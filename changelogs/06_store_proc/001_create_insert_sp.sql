-- liquibase formatted sql

--changeset Vinh:1 logicalFilePath:sql/001_create_insert_sp.sql
CREATE OR REPLACE PROCEDURE TEST_DB.PUBLIC.TMP_SP_TEST_5()
RETURNS TABLE ("PACKAGE_NAME" VARCHAR, "VERSION" VARCHAR, "LANGUAGE" VARCHAR, "RUNTIME_VERSION" VARCHAR)
LANGUAGE PYTHON
RUNTIME_VERSION = '3.12'
PACKAGES = ('snowflake-snowpark-python==1.33.0','cloudpickle==3.0.0')
HANDLER = 'sp_test_1.main'
IMPORTS = ('@MY_GIT_REPO/branches/main/sp_test_1.py')
EXECUTE AS CALLER
;


--rollback DROP TABLE IF EXISTS event_log