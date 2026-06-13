-- ============================================================
-- Healthcare Claims Denial Rate Analysis
-- 01_create_table.sql
-- Schema definition for the claims dataset (10,000 records)
-- ============================================================

CREATE TABLE healthcare_claims (
    claim_id          VARCHAR(15) PRIMARY KEY,
    patient_id        VARCHAR(15),
    date_of_service   DATE,
    submission_date   DATE,
    decision_date     DATE,
    payer             VARCHAR(50),
    provider_type     VARCHAR(50),
    diagnosis_group   VARCHAR(50),
    procedure_code    INT,
    claim_amount      DECIMAL(10,2),
    paid_amount       DECIMAL(10,2),
    claim_status      VARCHAR(20),
    denial_reason     VARCHAR(50),
    denial_flag       INT,
    processing_days   INT,
    denied_amount     DECIMAL(10,2)
);

-- ============================================================
-- Loading data
-- If using PostgreSQL with the provided CSV export of
-- healthcare_claims_raw.xlsx, load it with:
--
-- COPY healthcare_claims
-- FROM '/path/to/healthcare_claims_raw.csv'
-- DELIMITER ','
-- CSV HEADER;
-- ============================================================
