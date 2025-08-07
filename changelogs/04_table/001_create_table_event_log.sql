-- liquibase formatted sql

--changeset Vinh:1 logicalFilePath:sql/001_create_table_event_log.sql
CREATE TABLE OPERATION.SAC_MONITORING.event_log (
    id INT IDENTITY(1,1), -- IDENTITY(seed, increment) for auto-incrementing primary key
    event_description VARCHAR(500) -- A VARCHAR column to store event details
);

--rollback DROP TABLE IF EXISTS event_log