CREATE TABLE IF NOT EXISTS public."account" (
    "id" character varying COLLATE pg_catalog."default" NOT NULL,
    "password" character varying COLLATE pg_catalog."default" NOT NULL,
    "user" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT account_pkey PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS public."user" (
    "id" character varying COLLATE pg_catalog."default" NOT NULL,
    "name" character varying COLLATE pg_catalog."default" NOT NULL,
    "email" character varying COLLATE pg_catalog."default" NOT NULL,
    "role" character varying COLLATE pg_catalog."default" NOT NULL,
    "accountId" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT user_pkey PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS public."category" (
    "id" character varying COLLATE pg_catalog."default" NOT NULL,
    "name" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT category_pkey PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS public."product" (
    "id" character varying COLLATE pg_catalog."default" NOT NULL,
    "name" character varying COLLATE pg_catalog."default" NOT NULL,
    "description" character varying COLLATE pg_catalog."default" NOT NULL,
    "price" numeric NOT NULL,
    "categoryId" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT product_pkey PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS public."ticket" (
    "id" character varying COLLATE pg_catalog."default" NOT NULL,
    "userId" character varying COLLATE pg_catalog."default" NOT NULL,
    "datetime" bigint NOT NULL,
    "products" json NOT NULL,
    "total" numeric NOT NULL,
    CONSTRAINT ticket_pkey PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS public."table" (
    "id" character varying COLLATE pg_catalog."default" NOT NULL,
    "name" character varying COLLATE pg_catalog."default" NOT NULL,
    "index" integer NOT NULL,
    "ticketId" character varying COLLATE pg_catalog."default" NOT NULL,
    "accountName" character varying COLLATE pg_catalog."default" NOT NULL,
    "status" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT table_pkey PRIMARY KEY (id)
);