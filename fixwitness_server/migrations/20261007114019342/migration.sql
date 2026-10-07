BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "condition_report" (
    "id" bigserial PRIMARY KEY,
    "jobId" bigint NOT NULL,
    "clientOpId" uuid NOT NULL,
    "items" json NOT NULL,
    "recordedByUserId" uuid NOT NULL,
    "recordedByName" text NOT NULL,
    "capturedAt" timestamp without time zone NOT NULL,
    "receivedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "condition_report_op_idx" ON "condition_report" USING btree ("clientOpId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "customer_link" (
    "id" bigserial PRIMARY KEY,
    "jobId" bigint NOT NULL,
    "tokenHash" text,
    "createdByUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "revokedAt" timestamp without time zone,
    "lastOpenedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "customer_link_token_idx" ON "customer_link" USING btree ("tokenHash");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "estimate" (
    "id" bigserial PRIMARY KEY,
    "jobId" bigint NOT NULL,
    "versionNumber" bigint NOT NULL,
    "status" text NOT NULL,
    "lines" json NOT NULL,
    "totalMinor" bigint NOT NULL,
    "currency" text NOT NULL,
    "note" text,
    "reasonForRevision" text,
    "contentHash" text NOT NULL,
    "issuedAt" timestamp without time zone NOT NULL,
    "issuedByUserId" uuid NOT NULL,
    "issuedByName" text NOT NULL,
    "decidedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "estimate_version_idx" ON "estimate" USING btree ("jobId", "versionNumber");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "estimate_decision" (
    "id" bigserial PRIMARY KEY,
    "jobId" bigint NOT NULL,
    "estimateId" bigint NOT NULL,
    "versionNumber" bigint NOT NULL,
    "contentHash" text NOT NULL,
    "decision" text NOT NULL,
    "typedName" text NOT NULL,
    "declineReason" text,
    "customerLinkId" bigint NOT NULL,
    "ipAddress" text,
    "userAgent" text,
    "decidedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "estimate_decision_estimate_idx" ON "estimate_decision" USING btree ("estimateId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "evidence_photo" (
    "id" bigserial PRIMARY KEY,
    "jobId" bigint NOT NULL,
    "clientOpId" uuid NOT NULL,
    "stage" text NOT NULL,
    "caption" text,
    "storagePath" text,
    "contentType" text NOT NULL,
    "sizeBytes" bigint NOT NULL,
    "sha256" text NOT NULL,
    "capturedAt" timestamp without time zone NOT NULL,
    "uploadedByUserId" uuid NOT NULL,
    "uploadedByName" text NOT NULL,
    "registeredAt" timestamp without time zone NOT NULL,
    "customerVisible" boolean NOT NULL DEFAULT true
);

-- Indexes
CREATE UNIQUE INDEX "evidence_photo_op_idx" ON "evidence_photo" USING btree ("clientOpId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "job_event" (
    "id" bigserial PRIMARY KEY,
    "jobId" bigint NOT NULL,
    "seq" bigint NOT NULL,
    "type" text NOT NULL,
    "actorKind" text NOT NULL,
    "actorLabel" text NOT NULL,
    "summary" text NOT NULL,
    "customerVisible" boolean NOT NULL,
    "estimateVersion" bigint,
    "occurredAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "job_event_seq_idx" ON "job_event" USING btree ("jobId", "seq");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "job_note" (
    "id" bigserial PRIMARY KEY,
    "jobId" bigint NOT NULL,
    "clientOpId" uuid NOT NULL,
    "text" text NOT NULL,
    "customerVisible" boolean NOT NULL DEFAULT false,
    "authorUserId" uuid NOT NULL,
    "authorName" text NOT NULL,
    "writtenAt" timestamp without time zone NOT NULL,
    "receivedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "job_note_op_idx" ON "job_note" USING btree ("clientOpId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "repair_job" (
    "id" bigserial PRIMARY KEY,
    "shopId" bigint NOT NULL,
    "jobNumber" bigint NOT NULL,
    "clientOpId" uuid NOT NULL,
    "customerName" text NOT NULL,
    "customerPhone" text NOT NULL,
    "deviceMake" text NOT NULL,
    "deviceModel" text NOT NULL,
    "deviceSerial" text,
    "reportedFault" text NOT NULL,
    "accessories" text,
    "status" text NOT NULL,
    "rowVersion" bigint NOT NULL DEFAULT 1,
    "eventSeq" bigint NOT NULL DEFAULT 0,
    "currentEstimateId" bigint,
    "authorizedEstimateId" bigint,
    "createdByUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" timestamp without time zone,
    "collectedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "repair_job_number_idx" ON "repair_job" USING btree ("shopId", "jobNumber");
CREATE UNIQUE INDEX "repair_job_op_idx" ON "repair_job" USING btree ("clientOpId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "shop" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "currency" text NOT NULL DEFAULT 'INR'::text,
    "nextJobNumber" bigint NOT NULL DEFAULT 1,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "shop_member" (
    "id" bigserial PRIMARY KEY,
    "shopId" bigint NOT NULL,
    "authUserId" uuid NOT NULL,
    "displayName" text NOT NULL,
    "role" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "shop_member_user_idx" ON "shop_member" USING btree ("authUserId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "condition_report"
    ADD CONSTRAINT "condition_report_fk_0"
    FOREIGN KEY("jobId")
    REFERENCES "repair_job"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "customer_link"
    ADD CONSTRAINT "customer_link_fk_0"
    FOREIGN KEY("jobId")
    REFERENCES "repair_job"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "estimate"
    ADD CONSTRAINT "estimate_fk_0"
    FOREIGN KEY("jobId")
    REFERENCES "repair_job"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "estimate_decision"
    ADD CONSTRAINT "estimate_decision_fk_0"
    FOREIGN KEY("jobId")
    REFERENCES "repair_job"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "estimate_decision"
    ADD CONSTRAINT "estimate_decision_fk_1"
    FOREIGN KEY("estimateId")
    REFERENCES "estimate"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "evidence_photo"
    ADD CONSTRAINT "evidence_photo_fk_0"
    FOREIGN KEY("jobId")
    REFERENCES "repair_job"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "job_event"
    ADD CONSTRAINT "job_event_fk_0"
    FOREIGN KEY("jobId")
    REFERENCES "repair_job"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "job_note"
    ADD CONSTRAINT "job_note_fk_0"
    FOREIGN KEY("jobId")
    REFERENCES "repair_job"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "repair_job"
    ADD CONSTRAINT "repair_job_fk_0"
    FOREIGN KEY("shopId")
    REFERENCES "shop"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "shop_member"
    ADD CONSTRAINT "shop_member_fk_0"
    FOREIGN KEY("shopId")
    REFERENCES "shop"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR fixwitness
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fixwitness', '20261007114019342', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261007114019342', "timestamp" = now();

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
