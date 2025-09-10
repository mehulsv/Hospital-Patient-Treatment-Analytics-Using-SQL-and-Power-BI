-- 1. View all data for initial inspection
SELECT * FROM hospital.hosp_data;

-- 2. Check for missing or NULL values in columns
SELECT 
  COUNT(*) AS Total_Rows,
  COUNT(CASE WHEN Patient_ID IS NULL THEN 1 END) AS Missing_Patient_ID,
  COUNT(CASE WHEN Age IS NULL THEN 1 END) AS Missing_Age,
  COUNT(CASE WHEN Gender IS NULL THEN 1 END) AS Missing_Gender,
  COUNT(CASE WHEN `Condition` IS NULL THEN 1 END) AS Missing_Condition,
  COUNT(CASE WHEN `Procedure` IS NULL THEN 1 END) AS Missing_Procedure,
  COUNT(CASE WHEN Cost IS NULL THEN 1 END) AS Missing_Cost,
  COUNT(CASE WHEN Length_of_Stay IS NULL THEN 1 END) AS Missing_Length_of_Stay,
  COUNT(CASE WHEN Readmission IS NULL THEN 1 END) AS Missing_Readmission,
  COUNT(CASE WHEN Outcome IS NULL THEN 1 END) AS Missing_Outcome,
  COUNT(CASE WHEN Satisfaction IS NULL THEN 1 END) AS Missing_Satisfaction
FROM hospital.hosp_data;

-- 3. Remove duplicate patient records (if any) based on Patient_ID
DELETE FROM hospital.hosp_data
WHERE Patient_ID NOT IN (
  SELECT min_id FROM (
    SELECT MIN(Patient_ID) AS min_id
    FROM hospital.hosp_data
    GROUP BY Patient_ID
  ) AS subquery
);

-- 4. Convert Gender values to consistent format (uppercase)
UPDATE hospital.hosp_data
SET Gender = UPPER(Gender)
WHERE Gender IS NOT NULL;


-- 5. Count patients by Gender
SELECT Gender, COUNT(*) AS Patient_Count
FROM hospital.hosp_data
GROUP BY Gender;

-- 6. Calculate average patient age
SELECT AVG(Age) AS Average_Age
FROM hospital.hosp_data;

-- 7. Find distinct medical Conditions treated
SELECT DISTINCT `Condition`
FROM hospital.hosp_data;

-- 8. Count patients admitted per Condition
SELECT `Condition`, COUNT(*) AS Number_of_Patients
FROM hospital.hosp_data
GROUP BY `Condition`
ORDER BY Number_of_Patients DESC;

-- 9. Analyze total and average treatment Cost by Condition
SELECT `Condition`, 
  SUM(Cost) AS Total_Cost,
  AVG(Cost) AS Average_Cost
FROM hospital.hosp_data
GROUP BY `Condition`
ORDER BY Total_Cost DESC;

-- 10. Compute average Length_of_Stay for each Condition
SELECT `Condition`, AVG(Length_of_Stay) AS Average_Stay
FROM hospital.hosp_data
GROUP BY `Condition`
ORDER BY Average_Stay DESC;

-- 11. Count readmission cases
SELECT Readmission, COUNT(*) AS Count_Readmissions
FROM hospital.hosp_data
GROUP BY Readmission;

-- 12. Analyze patient outcomes count and distribution
SELECT Outcome, COUNT(*) AS Outcome_Count
FROM hospital.hosp_data
GROUP BY Outcome;

-- 13. Average satisfaction score by Condition
SELECT `Condition`, AVG(Satisfaction) AS Avg_Satisfaction
FROM hospital.hosp_data
GROUP BY `Condition`
ORDER BY Avg_Satisfaction DESC;

-- 14. Correlation between Length_of_Stay and Satisfaction (simple join for visual inspection)
SELECT Length_of_Stay, Satisfaction
FROM hospital.hosp_data;

-- 15. Top 5 most expensive treatments
SELECT `Procedure`, SUM(Cost) AS Total_Cost
FROM hospital.hosp_data
GROUP BY `Procedure`
ORDER BY Total_Cost DESC
LIMIT 5;

-- 16: Find the top 3 most frequent Conditions by readmission rate (patients readmitted)
SELECT `Condition`,
       COUNT(*) AS Total_Patients,
       SUM(CASE WHEN Readmission = 'Yes' THEN 1 ELSE 0 END) AS Readmitted,
       ROUND(SUM(CASE WHEN Readmission = 'Yes' THEN 1 ELSE 0 END)/COUNT(*) * 100, 2) AS Readmission_Rate_Percentage
FROM hospital.hosp_data
GROUP BY `Condition`
ORDER BY Readmission_Rate_Percentage DESC
LIMIT 3;

-- 17: Patients with longest hospital stays and their details
SELECT Patient_ID, Age, Gender, `Condition`, `Procedure`, Length_of_Stay
FROM hospital.hosp_data
ORDER BY Length_of_Stay DESC
LIMIT 10;

-- 18: Rank doctors by average patient Satisfaction (assuming Procedure implies doctor specialization)
SELECT `Procedure`, AVG(Satisfaction) AS Avg_Satisfaction, COUNT(*) AS Patients_Treated
FROM hospital.hosp_data
GROUP BY `Procedure`
ORDER BY Avg_Satisfaction DESC
LIMIT 5;

-- 19: Cases where Length_of_Stay exceeds average by Condition (indicating complications or severe cases)
SELECT Patient_ID, `Condition`, Length_of_Stay,
       AVG(Length_of_Stay) OVER (PARTITION BY `Condition`) AS Avg_Length_of_Stay
FROM hospital.hosp_data
WHERE Length_of_Stay > (
  SELECT AVG(Length_of_Stay) FROM hospital.hosp_data h2 WHERE h2.`Condition` = hospital.hosp_data.`Condition`
)
ORDER BY Length_of_Stay DESC
LIMIT 10;

-- 20: Average cost per procedure grouped by Outcome and Gender
SELECT `Procedure`, Outcome, Gender, AVG(Cost) AS Avg_Cost
FROM hospital.hosp_data
GROUP BY `Procedure`, Outcome, Gender
ORDER BY Avg_Cost DESC;