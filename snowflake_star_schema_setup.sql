--CREATE DATABASE INSURANCE_DB;

-- Use this database
--USE INSURANCE_DB;

-- Create Schemas
--CREATE SCHEMA RAW;
--CREATE SCHEMA DWH;
-- CREATE OR REPLACE TABLE DWH.DIM_CUSTOMER (
--   customer_id INT PRIMARY KEY,
--   name STRING,
--   age INT,
--   gender STRING,
--   city STRING,
--   state STRING,
--   risk_profile STRING
-- );
-- CREATE OR REPLACE TABLE DWH.DIM_POLICY (
--   policy_id INT PRIMARY KEY,
--   policy_type STRING,
--   premium INT,
--   coverage INT,
--   start_date DATE,
--   end_date DATE
-- );
-- CREATE OR REPLACE TABLE DWH.DIM_DATE (
--   date_key INT PRIMARY KEY,
--   full_date DATE,
--   year INT,
--   month INT,
--   day INT
-- );
-- 
-- USE DATABASE INSURANCE_DB;
-- USE SCHEMA RAW;

-- CREATE OR REPLACE STAGE MY_STAGE;
-- COPY INTO DWH.DIM_CUSTOMER
-- FROM @RAW.my_stage/customers.csv
-- FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1);
-- COPY INTO DWH.DIM_POLICY
-- FROM @RAW.my_stage/policies.csv
-- FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1);
-- COPY INTO DWH.FACT_CLAIMS
-- FROM @RAW.my_stage/claims.csv
-- FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1);
-- COPY INTO DWH.FACT_CLAIMS
-- FROM @RAW.my_stage/claims.csv
-- FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1);
-- SELECT * FROM DWH.DIM_CUSTOMER;
-- USE DATABASE INSURANCE_DB;
-- USE SCHEMA DWH;
-- COPY INTO DWH.DIM_CUSTOMER
-- FROM @INSURANCE_DB.RAW.MY_STAGE/customers_cleaned.csv
-- FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1);
-- COPY INTO DWH.DIM_POLICY
-- FROM @INSURANCE_DB.RAW.MY_STAGE/policies_cleaned.csv
-- FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1);
-- COPY INTO DWH.DIM_POLICY
-- FROM @INSURANCE_DB.RAW.MY_STAGE/policies_cleaned.csv
-- FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1);
-- COPY INTO DWH.DIM_DATE
-- FROM @INSURANCE_DB.RAW.MY_STAGE/date_dimension_cleaned.csv
-- FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1);
-- SELECT * FROM DWH.DIM_CUSTOMER;
-- SELECT COUNT(*) FROM DWH.DIM_POLICY;
-- SELECT COUNT(*) FROM DWH.FACT_CLAIMS;
-- SELECT COUNT(*) FROM DWH.DIM_DATE;
-- SELECT * FROM DWH.FACT_CLAIMS;
SELECT 
    c.customer_id,
    c.name,
    c.city,
    c.state,
    p.policy_type,
    p.premium,
    f.claim_id,
    f.claim_amount,
    f.approved_amount,
    f.fraud_probability,
    f.claim_status,
    d.full_date
FROM DWH.FACT_CLAIMS f
JOIN DWH.DIM_CUSTOMER c ON f.customer_id = c.customer_id
JOIN DWH.DIM_POLICY p ON f.policy_id = p.policy_id
JOIN DWH.DIM_DATE d ON f.incident_date_key = d.date_key;