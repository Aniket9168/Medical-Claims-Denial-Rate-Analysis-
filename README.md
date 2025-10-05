# Medical-Claims-Denial-Rate-Analysis-
SQL Project | Medical Claims Denial Rate Analysis 
A simple SQL-based healthcare analytics project where I analyze medical claims data to calculate the denial rate.   
-Skills: SQL, CASE logic, Aggregate Functions, Healthcare Data Analysis  
-Tools: PostgreSQL, Excel, GitHub  
-Focus: Real-world healthcare metric — Denial Rate (% of denied claims)
#  Medical Claims Denial Rate Analysis (SQL Project)

##  Project Objective
To analyze healthcare claim data and calculate the **Claim Denial Rate** — a key performance indicator (KPI) in healthcare analytics that shows what percentage of submitted claims are denied by insurance companies.  
This project helps healthcare organizations identify billing inefficiencies and improve claim approval rates.

---

##  Dataset Overview
A small sample dataset of medical insurance claims.

| Column Name | Description |
|--------------|-------------|
| **ClaimID** | Unique claim number |
| **PatientID** | Unique patient identifier |
| **Provider** | Insurance provider name |
| **ClaimAmount** | Total amount billed for the claim |
| **ClaimStatus** | Status of the claim (Approved/Denied) |
| **ClaimDate** | Date when the claim was filed |

**Sample Data**

| ClaimID | PatientID | Provider | ClaimAmount | ClaimStatus | ClaimDate |
|----------|------------|-----------|--------------|--------------|------------|
| 1 | P001 | Aetna | 200 | Approved | 2024-01-10 |
| 2 | P002 | Optum | 150 | Denied | 2024-01-12 |
| 3 | P003 | Anthem | 300 | Denied | 2024-01-15 |
| 4 | P004 | Aetna | 100 | Approved | 2024-01-20 |
| 5 | P005 | Cigna | 400 | Approved | 2024-01-25 |

---

##  SQL Steps

### 1️ Create Table

CREATE TABLE Claims (
    ClaimID INT PRIMARY KEY,
    PatientID VARCHAR(10),
    Provider VARCHAR(50),
    ClaimAmount DECIMAL(10,2),
    ClaimStatus VARCHAR(20),
    ClaimDate DATE
);

2️ Insert Data

INSERT INTO Claims VALUES
(1, 'P001', 'Aetna', 200, 'Approved', '2024-01-10'),
(2, 'P002', 'Optum', 150, 'Denied', '2024-01-12'),
(3, 'P003', 'Anthem', 300, 'Denied', '2024-01-15'),
(4, 'P004', 'Aetna', 100, 'Approved', '2024-01-20'),
(5, 'P005', 'Cigna', 400, 'Approved', '2024-01-25');

3️ Calculate Claim Denial Rate

SELECT 
    ROUND(
        SUM(CASE WHEN ClaimStatus = 'Denied' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS denial_rate_percent
FROM Claims;

- Output → 40.00%

- Insights
Total Claims: 5

Denied Claims: 2

Denial Rate: 40%

Approved Claims: 60%

A 40% denial rate indicates a high rejection trend.
In real healthcare data, this metric helps identify:Coding or billing errors

Documentation issues

Insurance mismatch or missing information

- Key Learnings
-Used CASE WHEN statements for conditional logic
-Applied aggregate functions (SUM, COUNT) to calculate metrics
-Practiced data validation and performance analysis relevant to healthcare analytics

- Tools & Technologies
SQL (PostgreSQL) — data querying & analysis
Excel/CSV — dataset creation
GitHub — project version control and portfolio hosting

- How to Run the Project
1️] Open PostgreSQL (or pgAdmin).
2️] Run create_table.sql to create the table.
3️] Run insert_data.sql to load sample data.
4️] Run denial_rate_query.sql to get the denial rate percentage.

- Future Enhancements
Add provider-wise or month-wise denial rate trends
Include denial reason codes for deeper analysis
Create a Power BI dashboard to visualize claim performance

📚 About This Project
This mini SQL project combines medical coding knowledge with data analytics skills — showing how claim-related data can be analyzed to improve operational performance in healthcare.

👩‍💻 Author
Aniket Mane
💼 Transitioning from Medical Coder at Optum → Data Analyst
📍 Passionate about healthcare analytics and SQL-based insights.
