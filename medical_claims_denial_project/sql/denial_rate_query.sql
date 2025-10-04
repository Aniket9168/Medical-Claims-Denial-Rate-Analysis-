SELECT 
    ROUND(SUM(CASE WHEN ClaimStatus = 'Denied' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
    AS denial_rate_percent
FROM Claims;