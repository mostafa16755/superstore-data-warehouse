-- Grant CONNECT privilege to superstore_dw
GRANT CONNECT ON DATABASE superstore_dw TO etl_role, analyst_role, engineer_role, readonly_role;

-- grant schema permissions
GRANT USAGE ON SCHEMA staging TO etl_role, engineer_role;
GRANT CREATE ON SCHEMA staging TO etl_role, engineer_role;

GRANT USAGE ON SCHEMA clean TO etl_role, analyst_role, engineer_role, readonly_role;
GRANT CREATE ON SCHEMA clean TO etl_role, engineer_role;

GRANT USAGE ON SCHEMA dw TO analyst_role, engineer_role, readonly_role;
GRANT CREATE ON SCHEMA dw TO engineer_role;

GRANT USAGE ON SCHEMA analytics TO analyst_role, engineer_role, readonly_role, etl_role;
GRANT CREATE ON SCHEMA analytics TO engineer_role;