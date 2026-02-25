-- USE INSURANCE_DB;
--1 High-Risk Claims (CTE)
-- WITH risk_calc AS (
--   SELECT *,
--          CASE 
--            WHEN fraud_probability > 0.7 OR claim_amount > 200000 
--            THEN 'HIGH RISK'
--            ELSE 'NORMAL'
--          END AS risk_level
--   FROM DWH.FACT_CLAIMS
-- )
-- SELECT *
-- FROM risk_calc
-- WHERE risk_level = 'HIGH RISK';


--2 Top 5 Most Expensive Claims
-- SELECT claim_id, customer_id, claim_amount
-- FROM DWH.FACT_CLAIMS
-- ORDER BY claim_amount DESC
-- LIMIT 5;


--3 Customer Risk Ranking (Window Function)
-- SELECT 
--   customer_id,
--   SUM(claim_amount) AS total_claim_amount,
--   RANK() OVER (ORDER BY SUM(claim_amount) DESC) AS risk_rank
-- FROM DWH.FACT_CLAIMS
-- GROUP BY customer_id;


--4 Policy Type-wise Average Fraud Probability
-- SELECT 
--     p.policy_type,
--     AVG(f.fraud_probability) AS avg_fraud_score
-- FROM DWH.FACT_CLAIMS f
-- JOIN DWH.DIM_POLICY p ON f.policy_id = p.policy_id
-- GROUP BY p.policy_type;


--5 City-wise Claim Distribution
-- SELECT 
--     c.city,
--     COUNT(*) AS total_claims
-- FROM DWH.FACT_CLAIMS f
-- JOIN DWH.DIM_CUSTOMER c ON f.customer_id = c.customer_id
-- GROUP BY c.city
-- ORDER BY total_claims DESC;


--6 State-wise High Fraud Probability (Threshold >0.6)
-- SELECT 
--     c.state,
--     COUNT(*) AS high_fraud_cases
-- FROM DWH.FACT_CLAIMS f
-- JOIN DWH.DIM_CUSTOMER c ON f.customer_id = c.customer_id
-- WHERE f.fraud_probability > 0.6
-- GROUP BY c.state
-- ORDER BY high_fraud_cases DESC;


--7 Monthly Claim Trends
-- SELECT 
--     d.year,
--     d.month,
--     COUNT(*) AS total_claims
-- FROM DWH.FACT_CLAIMS f
-- JOIN DWH.DIM_DATE d ON f.incident_date_key = d.date_key
-- GROUP BY d.year, d.month
-- ORDER BY d.year, d.month;


--8 Approval Rate (%)
-- SELECT 
--   (SUM(CASE WHEN claim_status = 'APPROVED' THEN 1 ELSE 0 END) * 100.0) 
--     / COUNT(*) AS approval_rate_percentage
-- FROM DWH.FACT_CLAIMS;


--9 Rejected Claims List
-- SELECT claim_id, customer_id, claim_amount
-- FROM DWH.FACT_CLAIMS
-- WHERE claim_status = 'REJECTED';


--10 Claims Above Policy Coverage (Potential Fraud)
-- SELECT 
--     f.claim_id,
--     f.claim_amount,
--     p.coverage,
--     (f.claim_amount - p.coverage) AS over_limit_amount
-- FROM DWH.FACT_CLAIMS f
-- JOIN DWH.DIM_POLICY p ON f.policy_id = p.policy_id
-- WHERE f.claim_amount > p.coverage;


--11 Customers With Multiple Claims (Fraud Signal)
-- SELECT 
--     customer_id,
--     COUNT(*) AS num_claims
-- FROM DWH.FACT_CLAIMS
-- GROUP BY customer_id
-- HAVING COUNT(*) > 1;


--12
SELECT 
  claim_id,
  fraud_probability,
  CASE 
    WHEN fraud_probability > 0.75 THEN 'High Fraud'
    WHEN fraud_probability > 0.40 THEN 'Moderate Fraud'
    ELSE 'Low Fraud'
  END AS fraud_category
FROM DWH.FACT_CLAIMS;