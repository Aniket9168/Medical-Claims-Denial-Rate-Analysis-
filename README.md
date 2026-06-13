# Healthcare Claims Denial Rate Analysis
End-to-end analysis of 10,000 medical insurance claims (FY 2024) to identify the root causes of claim denials, quantify revenue at risk, and recommend operational fixes — built using SQL, Excel, and Power BI.


##  Project Overview
Healthcare providers lose millions of dollars every year to denied claims — many of which are preventable. This project analyzes a 10,000-record claims dataset to answer four questions that matter to a revenue cycle / payer operations team:


What is our overall claim denial rate, and how does it compare to the industry benchmark?
Which denial reasons are costing us the most money?
Which payers, provider types, and diagnosis groups have the highest denial rates?
What specific, actionable steps would reduce denials and recover revenue?


The project moves through three layers of analysis: SQL for querying and aggregating raw claims data, Excel for data cleaning and pivot-based exploration, and Power BI for the final interactive dashboard.

##Business problem


A 29.6% denial rate (vs. an 11% national average reported by Crowe RCA benchmarking) means nearly $11.45M of $24.93M billed is at risk. The goal of this project is to pinpoint why claims are being denied and where to intervene first for the biggest impact.
---

##  Dataset Overview
A synthetic but realistic dataset of 10,000 medical claims spanning Jan 2023 – Dec 2024.

ColumnDescriptionClaim_IDUnique claim identifierPatient_IDUnique patient identifierDate_of_ServiceDate the service was providedSubmission_DateDate the claim was submitted to the payerDecision_DateDate the payer made a decisionPayerInsurance payer (Aetna, BCBS, Cigna, Medicaid, Medicare, etc.)Provider_TypeClinic, Hospital, Lab, Specialist, Primary Care, Imaging CenterDiagnosis_GroupClinical category (Cardiovascular, Respiratory, Oncology, etc.)Procedure_CodeCPT/procedure code billedClaim_AmountTotal amount billedPaid_AmountAmount reimbursed by payerClaim_StatusApproved / Denied / PendingDenial_ReasonReason code for denial (if applicable)Denial_flag1 = denied, 0 = not deniedProcessing DaysDays between submission and decisionDenied AmountDollar amount denied

📁 Raw data: data/healthcare_claims_raw.xlsx


Tools & skills used

ToolPurposeSQL (PostgreSQL)Denial rate calculations, CASE logic, GROUP BY aggregations, window functionsExcelData cleaning, pivot tables, VLOOKUP/INDEX-MATCH cross-checksPower BIInteractive dashboard — KPIs, donut/bar charts, drill-through, slicersHealthcare domain knowledgeICD-10 / CPT / HCPCS context, denial reason categorization, RCM workflows


Dashboard

The dashboard surfaces four core KPIs and six supporting visuals so a revenue cycle manager can go from "what's wrong" to "what to fix" in one view.

Key KPIs


Denial Rate: 29.6% (vs. 11% industry benchmark)
Revenue at Risk: $11.45M (of $24.93M total billed)
Approved Claims: 6,211 (62.1% approval rate)
Avg Processing Days: 32.2


Visuals


Claim status breakdown (donut chart)
Top 10 denial reasons (horizontal bar)
Denial rate by diagnosis group
Denial rate by provider type
Payer performance table with risk tiers
Monthly denial trend


📁 Screenshot: dashboard/screenshots/dashboard_overview.png


Key insights


Wrong Procedure Code (819) + Incorrect Modifier (63) = 882 denials (~30% of all denials) — these are coding-level errors that a pre-submission claim scrubber could catch before the claim ever leaves the building.
Missing Prior Authorization accounts for 774 denials (26%) — the single largest category after coding errors, concentrated in Respiratory, Dermatology, and Mental Health services.
Cigna (32.2%) and Humana (31.2%) have the highest payer-level denial rates — both roughly 3 points above the portfolio average.
Respiratory (32.0%) and Dermatology (31.9%) diagnosis groups consistently see the highest denial rates, suggesting documentation or coding gaps specific to these specialties.
Clinics (30.9%) and Primary Care (30.3%) have the highest denial rates by provider type — likely candidates for targeted billing-team training.



SQL analysis

All queries are in sql/:


01_create_table.sql — schema definition for the claims table
02_denial_rate_analysis.sql — denial rate, denial reason breakdown, payer/provider/diagnosis-level analysis, monthly trends, and revenue-at-risk calculations


Example — overall denial rate:

sqlSELECT
    ROUND(SUM(denial_flag) * 100.0 / COUNT(*), 2) AS denial_rate_percent,
    SUM(denial_flag) AS denied_claims,
    COUNT(*) AS total_claims
FROM healthcare_claims;


Recommendations

PriorityRecommendationExpected impact1Implement pre-submission code validation / claim scrubbingReduces ~882 coding-error denials2Automate prior-authorization triggers at scheduling for Respiratory, Dermatology, Mental HealthReduces ~774 PA-related denials3Run quarterly denial reviews with Cigna and Humana provider relations teamsTargets the 2 highest-denial payers4Targeted billing training for Clinics and Primary Care staffAddresses highest denial rates by provider type


Repository structure

Medical-Claims-Denial-Rate-Analysis/
├── README.md
├── data/
│   └── healthcare_claims_raw.xlsx
├── sql/
│   ├── 01_create_table.sql
│   └── 02_denial_rate_analysis.sql
├── dashboard/
│   ├── Claims_Denial_Dashboard.pbix
│   └── screenshots/
│       └── dashboard_overview.png
└── docs/
    └── insights_summary.md


About me

Aniket Mane
Medical Coder (3+ years, Optum) → Healthcare Data Analyst | CCS Certified (AHIMA) | MBA in Business Analytics

Combining hands-on US healthcare RCM experience (ICD-10, CPT, HCPCS, claims adjudication) with SQL, Excel, and Power BI to turn claims data into operational decisions.

📫 Connect with me on LinkedIn




