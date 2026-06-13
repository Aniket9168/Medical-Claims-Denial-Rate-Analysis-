-- ============================================================
-- Healthcare Claims Denial Rate Analysis
-- 02_denial_rate_analysis.sql
-- Core analysis queries used to build the dashboard
-- ============================================================

-- 1. OVERALL DENIAL RATE
-- ------------------------------------------------------------
SELECT
    COUNT(*)                                            AS total_claims,
    SUM(denial_flag)                                    AS denied_claims,
    ROUND(SUM(denial_flag) * 100.0 / COUNT(*), 2)       AS denial_rate_percent,
    ROUND(SUM(CASE WHEN claim_status = 'Approved' THEN 1 ELSE 0 END)
          * 100.0 / COUNT(*), 2)                        AS approval_rate_percent
FROM healthcare_claims;


-- 2. REVENUE AT RISK
-- ------------------------------------------------------------
SELECT
    ROUND(SUM(claim_amount), 2)   AS total_billed,
    ROUND(SUM(denied_amount), 2)  AS total_denied_amount,
    ROUND(SUM(paid_amount), 2)    AS total_paid,
    ROUND(SUM(denied_amount) * 100.0 / SUM(claim_amount), 2) AS pct_revenue_at_risk
FROM healthcare_claims;


-- 3. TOP DENIAL REASONS
-- ------------------------------------------------------------
SELECT
    denial_reason,
    COUNT(*) AS denial_count,
    ROUND(COUNT(*) * 100.0 / (SELECT SUM(denial_flag) FROM healthcare_claims), 2) AS pct_of_denials
FROM healthcare_claims
WHERE denial_flag = 1
GROUP BY denial_reason
ORDER BY denial_count DESC;


-- 4. DENIAL RATE BY PAYER
-- ------------------------------------------------------------
SELECT
    payer,
    COUNT(*)                                       AS total_claims,
    SUM(denial_flag)                               AS denied_claims,
    ROUND(SUM(denial_flag) * 100.0 / COUNT(*), 2)  AS denial_rate_percent,
    ROUND(SUM(denied_amount), 2)                   AS denied_amount
FROM healthcare_claims
GROUP BY payer
ORDER BY denial_rate_percent DESC;


-- 5. DENIAL RATE BY PROVIDER TYPE
-- ------------------------------------------------------------
SELECT
    provider_type,
    COUNT(*)                                       AS total_claims,
    SUM(denial_flag)                               AS denied_claims,
    ROUND(SUM(denial_flag) * 100.0 / COUNT(*), 2)  AS denial_rate_percent
FROM healthcare_claims
GROUP BY provider_type
ORDER BY denial_rate_percent DESC;


-- 6. DENIAL RATE BY DIAGNOSIS GROUP
-- ------------------------------------------------------------
SELECT
    diagnosis_group,
    COUNT(*)                                       AS total_claims,
    SUM(denial_flag)                               AS denied_claims,
    ROUND(SUM(denial_flag) * 100.0 / COUNT(*), 2)  AS denial_rate_percent
FROM healthcare_claims
GROUP BY diagnosis_group
ORDER BY denial_rate_percent DESC;


-- 7. MONTHLY DENIAL TREND
-- ------------------------------------------------------------
SELECT
    EXTRACT(MONTH FROM date_of_service) AS month_number,
    COUNT(*)                                       AS total_claims,
    SUM(denial_flag)                               AS denied_claims,
    ROUND(SUM(denial_flag) * 100.0 / COUNT(*), 2)  AS denial_rate_percent
FROM healthcare_claims
GROUP BY EXTRACT(MONTH FROM date_of_service)
ORDER BY month_number;


-- 8. AVG PROCESSING DAYS BY CLAIM STATUS
-- ------------------------------------------------------------
SELECT
    claim_status,
    ROUND(AVG(processing_days), 1) AS avg_processing_days
FROM healthcare_claims
GROUP BY claim_status;


-- 9. TOP PREVENTABLE DENIAL CATEGORIES (CODING-RELATED)
-- ------------------------------------------------------------
SELECT
    SUM(CASE WHEN denial_reason IN ('Wrong Procedure Code', 'Incorrect Modifier')
             THEN 1 ELSE 0 END) AS coding_error_denials,
    SUM(CASE WHEN denial_reason = 'Missing Prior Authorization'
             THEN 1 ELSE 0 END) AS prior_auth_denials,
    SUM(denial_flag)            AS total_denials
FROM healthcare_claims;
