-- Create roles
CREATE ROLE etl_role;           -- Write to staging/clean
CREATE ROLE analyst_role;       -- Read from dw/analytics
CREATE ROLE engineer_role;      -- Full access to all schemas
CREATE ROLE readonly_role;   	-- Read-only for all schemas

-- Create users and assign roles
CREATE USER etl_user WITH PASSWORD 'etl_pass123' IN ROLE etl_role;
CREATE USER analyst_user WITH PASSWORD 'analyst_pass123' IN ROLE analyst_role;
CREATE USER engineer_user WITH PASSWORD 'engineer_pass123' IN ROLE engineer_role;
CREATE USER readonly_user WITH PASSWORD 'readonly_pass123' IN ROLE readonly_role;

-- Set role comments
COMMENT ON ROLE etl_role IS 'ETL Role - Write access to staging and clean schemas';
COMMENT ON ROLE analyst_role IS 'Analyst Role - Read access to dw and analytics schemas';
COMMENT ON ROLE engineer_role IS 'Engineer Role - Full access to all schemas';
COMMENT ON ROLE readonly_role IS 'Readonly Role - Read-only access to all schemas';