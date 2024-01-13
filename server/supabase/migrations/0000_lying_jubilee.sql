CREATE TABLE IF NOT EXISTS "rates" (
	"base" varchar NOT NULL,
	"target" varchar NOT NULL,
	"rate" numeric NOT NULL,
	CONSTRAINT "rates_base_target_pk" PRIMARY KEY("base","target")
);
