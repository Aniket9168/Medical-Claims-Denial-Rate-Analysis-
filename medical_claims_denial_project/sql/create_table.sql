CREATE TABLE Claims (
    ClaimID INT PRIMARY KEY,
    PatientID VARCHAR(10),
    Provider VARCHAR(50),
    ClaimAmount DECIMAL(10,2),
    ClaimStatus VARCHAR(20),
    ClaimDate DATE
);