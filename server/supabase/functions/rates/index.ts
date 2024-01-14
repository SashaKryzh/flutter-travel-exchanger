import * as z from "https://deno.land/x/zod@v3.21.4/mod.ts";
import { db } from "../_shared/db.ts";
import { rates } from "../_shared/schema.ts";
import { eq, InferInsertModel, sql } from "drizzle-orm";

const apiKey = Deno.env.get("EXCHANGE_RATE_API_KEY");
const oneHour = 60 * 60 * 1000;

type Data = {
  success: true;
  base: string;
  rates: Rate[];
};

interface Rate {
  base: string;
  target: string;
  rate: number;
  updatedAt: string;
}

type Error = {
  success: false;
  error: string;
};

type ApiResponse = Data | Error;

type RateDB = Omit<InferInsertModel<typeof rates>, "updatedAt">;

const base = "EUR";

async function getBase() {
  const baseRate = await db.select().from(rates).where(
    eq(rates.base, base),
  );
  return baseRate.length > 0 ? baseRate[0] : null;
}

async function getAllRates() {
  const data = await db.select().from(rates).where(eq(rates.base, base));
  return data;
}

async function putRates(ratesList: RateDB[]) {
  const date = new Date().toISOString();
  const ratesInsert = ratesList.map((rate) => ({ ...rate, updatedAt: date }));

  await db.insert(rates).values(ratesInsert).onConflictDoUpdate({
    target: [rates.base, rates.target],
    set: { rate: sql`excluded.rate`, updatedAt: date },
  });
}

async function getRatesFromApi() {
  const response = await fetch(
    `http://api.exchangeratesapi.io/v1/latest?access_key=${apiKey}&base=${base}`,
  );

  const json = await response.json();
  const parsedBody = exchangeRateSchema.parse(json);

  if (!parsedBody.success) {
    throw new Error(JSON.stringify(parsedBody));
  }

  return parsedBody;
}

Deno.serve(async (req) => {
  const { method } = req;

  if (method !== "GET") {
    return new Response(
      JSON.stringify(
        { success: false, error: "Method not allowed" } satisfies ApiResponse,
      ),
      { headers: { "Content-Type": "application/json" }, status: 405 },
    );
  }

  try {
    const baseRate = await getBase();
    if (
      baseRate && new Date(baseRate.updatedAt).getTime() >= Date.now() - oneHour
    ) {
      const data = await getAllRates();
      return new Response(
        JSON.stringify(
          {
            success: true,
            base: base,
            rates: data,
          } satisfies ApiResponse,
        ),
        { headers: { "Content-Type": "application/json" } },
      );
    }

    let data: Rate[] = [];
    try {
      const response = await getRatesFromApi();
      const rates = Object.entries(response.rates).map(([target, rate]) => ({
        base: response.base,
        target,
        rate,
      }));
      await putRates(rates);
    } catch (error) {
      console.error(error);
    }

    data = await getAllRates();

    return new Response(
      JSON.stringify(
        {
          success: true,
          base: base,
          rates: data,
        } satisfies ApiResponse,
      ),
      { headers: { "Content-Type": "application/json" } },
    );
  } catch (error) {
    console.error(error);
    return new Response(
      JSON.stringify(
        {
          success: false,
          error: error.message,
        } satisfies ApiResponse,
      ),
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
