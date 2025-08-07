-- liquibase formatted sql

--changeset Vinh:1 logicalFilePath:sql/001_create_git_integration.sql
USE SCHEMA OPERATION.SAC_MONITORING;
CREATE OR REPLACE SECRET secret_git_integration
  TYPE = password
  USERNAME = 'VinhQuocTran'
  PASSWORD = '${git_token}';


CREATE OR REPLACE API INTEGRATION sac_monitor_git_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/VinhQuocTran')
  ALLOWED_AUTHENTICATION_SECRETS = (secret_git_integration)
  ENABLED = TRUE;


CREATE OR REPLACE GIT REPOSITORY sac_git_repo
  API_INTEGRATION = sac_monitor_git_integration
  GIT_CREDENTIALS = secret_git_integration
  ORIGIN = 'https://github.com/VinhQuocTran/cicd_snowflake_poc';

--rollback DROP procedure IF EXISTS test_sp;