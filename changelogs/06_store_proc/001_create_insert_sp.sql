-- liquibase formatted sql

--changeset Vinh:1 logicalFilePath:sql/001_create_insert_sp.sql
CREATE OR REPLACE PROCEDURE OPERATION.SAC_MONITORING.SP_TEST_INSERT()
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.12'
PACKAGES = ('snowflake-snowpark-python==1.33.0',
        'cloudpickle==3.0.0',
        'pandas==2.3.1',
        'pyyaml==6.0.2'
        )
HANDLER = 'sp_test_insert.main'
IMPORTS = ('@OPERATION.SAC_MONITORING.SAC_GIT_REPO/branches/master/python_stage/constant_and_util.py',
        '@OPERATION.SAC_MONITORING.SAC_GIT_REPO/branches/master/store_proc/sp_test_insert.py')
EXECUTE AS CALLER
;


--rollback DROP TABLE IF EXISTS event_log