BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "shop_invite" (
    "id" bigserial PRIMARY KEY,
    "shopId" bigint NOT NULL,
    "codeHash" text NOT NULL,
    "createdByUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "usedAt" timestamp without time zone,
    "usedByUserId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "shop_invite_code_idx" ON "shop_invite" USING btree ("codeHash");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "upload_grant" (
    "id" bigserial PRIMARY KEY,
    "path" text NOT NULL,
    "shopId" bigint NOT NULL,
    "jobId" bigint NOT NULL,
    "opId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "upload_grant_path_idx" ON "upload_grant" USING btree ("path");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "shop_invite"
    ADD CONSTRAINT "shop_invite_fk_0"
    FOREIGN KEY("shopId")
    REFERENCES "shop"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR fixwitness
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fixwitness', '20261011112859406', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261011112859406', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
