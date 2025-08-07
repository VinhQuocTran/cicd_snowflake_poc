-- liquibase formatted sql

--changeset Vinh:1 logicalFilePath:sql/001_create_schema_sac_monitoring.sql
CREATE SCHEMA IF NOT EXISTS OPERATION.SAC_MONITORING;

--rollback DROP SCHEMA IF EXISTS OPERATION.SAC_MONITORING;