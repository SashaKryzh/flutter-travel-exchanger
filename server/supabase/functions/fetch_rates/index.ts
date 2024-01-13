import * as z from "https://deno.land/x/zod@v3.21.4/mod.ts";
import { db } from "../_shared/db.ts";
import { rates } from "../_shared/schema.ts";
import { eq, sql } from "drizzle-orm";

const apiKey = Deno.env.get("EXCHANGE_RATE_API_KEY");

Deno.serve(async () => {
  try {
    const base = await db.select().from(rates).where(
      eq(rates.base, rates.target),
    );
    if (base.length > 0) {
      // Less than 1 hour ago
      if (base[0].updatedAt.getTime() >= Date.now() - 60 * 60 * 1000) {
        const data = await db.select().from(rates);
        return new Response(
          JSON.stringify(data),
          { headers: { "Content-Type": "application/json" } },
        );
      }
    }

    const response = await fetch(
      `http://api.exchangeratesapi.io/v1/latest?access_key=${apiKey}&base=EUR`,
    );

    const json = await response.json();
    const parsedBody = exchangeRateSchema.parse(json);

    if (!parsedBody.success) {
      throw new Error(JSON.stringify(parsedBody));
    }

    const data = await db.insert(rates).values(
      Object.entries(parsedBody.rates).map(([target, rate]) => ({
        base: parsedBody.base,
        target,
        rate,
      })),
    ).onConflictDoUpdate({
      target: [rates.base, rates.target],
      set: { rate: sql`excluded.rate`, updatedAt: sql`now()` },
    })
      .returning();

    return new Response(
      JSON.stringify(data),
      { headers: { "Content-Type": "application/json" } },
    );
  } catch (error) {
    console.error(error);
    return new Response(
      JSON.stringify(error),
      { headers: { "Content-Type": "application/json" } },
    );
  }
});

const currencyRatesSchema = z.record(z.number());

const successSchema = z.object({
  success: z.literal(true),
  date: z.string(),
  timestamp: z.number(),
  base: z.string(),
  rates: currencyRatesSchema,
});

const errorSchema = z.object({
  success: z.literal(false),
  error: z.object({
    code: z.number().or(z.string()),
    info: z.string(),
  }),
});

const exchangeRateSchema = z.union([successSchema, errorSchema]);
