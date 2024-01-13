import type { Config } from "drizzle-kit";

export default {
  schema: "./supabase/functions/_shared/schema.ts",
  out: "./supabase/migrations",
} satisfies Config;
