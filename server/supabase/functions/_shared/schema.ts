import {
  doublePrecision,
  pgTable,
  primaryKey,
  timestamp,
  varchar,
} from "drizzle-orm/pg-core";

export const rates = pgTable("rates", {
  base: varchar("base").notNull(),
  target: varchar("target").notNull(),
  rate: doublePrecision("rate").notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
}, (table) => {
  return {
    pk: primaryKey({ columns: [table.base, table.target] }),
    pkWithCustomName: primaryKey({
      name: "id",
      columns: [table.base, table.target],
    }),
  };
});
