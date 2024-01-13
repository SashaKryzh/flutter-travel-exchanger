import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";

const connectionString = Deno.env.get("SUPABASE_DB_URL")!;

// Disable prefetch as it is not supported for "Transaction" pool mode
const client = postgres(connectionString, { prepare: false });
export const db = drizzle(client);
