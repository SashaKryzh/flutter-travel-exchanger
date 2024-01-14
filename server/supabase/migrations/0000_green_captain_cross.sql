CREATE TABLE IF NOT EXISTS "rates" (
	"base" varchar NOT NULL,
	"target" varchar NOT NULL,
	"rate" double precision NOT NULL,
	"updated_at" timestamp with time zone NOT NULL,
	CONSTRAINT "rates_base_target_pk" PRIMARY KEY("base","target")
);
