-- for raw ingested data
CREATE SCHEMA staging;

-- for standardized & validated data
CREATE SCHEMA clean;

-- for star schema
CREATE SCHEMA dw;

-- business-ready views
CREATE SCHEMA analytics;