# Hospital-Patient-Treatment-Analytics-Using-SQL-and-Power-BI

## Project Overview

This project analyzes hospital patient and treatment data using **SQL** and **Power BI**, focusing on key healthcare metrics such as patient admissions, treatment effectiveness, costs, readmissions, and patient satisfaction. The insights generated aim to help hospitals improve patient care quality, streamline operations, and manage healthcare costs effectively.

## Importance of the Project

Healthcare data analytics plays a critical role in transforming medical services by enabling data-driven decision-making. This project demonstrates the use of real-world hospital data to:

- Monitor patient flow and treatment outcomes
- Identify high-risk conditions with readmissions
- Analyze treatment costs for financial management
- Assess patient satisfaction to improve service quality
- Support hospital administrators and doctors with actionable insights

This makes it a valuable portfolio project, showcasing expertise in both healthcare domain analytics and popular data tools.

## Dataset Description

The dataset includes these key fields:

- **Patient_ID:** Unique identifier
- **Age, Gender:** Demographics
- **Condition:** Diagnosed medical condition
- **Procedure:** Treatment performed
- **Cost:** Treatment expenses
- **Length_of_Stay:** Hospital stay duration (days)
- **Readmission:** Whether patient was readmitted (Yes/No)
- **Outcome:** Treatment result (Recovered, Stable, etc.)
- **Satisfaction:** Patient satisfaction rating (1-5)

## Sample SQL Query

The following SQL snippet calculates the total readmissions for each condition:

```sql
SELECT 
    `Condition`, 
    COUNT(*) AS Total_Readmissions
FROM 
    hospital.hosp_data
WHERE 
    Readmission = 'Yes'
GROUP BY 
    `Condition`
ORDER BY 
    Total_Readmissions DESC;
```

## Power BI Dashboard Highlights

- Key KPIs: Total patients, avg length of stay, readmission rate, avg satisfaction, total costs
- Patient demographics & condition-wise breakdowns
- Treatment cost distributions and trends
- Readmission and outcome analysis
- Interactive filters for gender, condition, and readmission status

<img width="959" height="538" alt="image" src="https://github.com/user-attachments/assets/5cbc50db-998e-440b-b107-452d42fbc028" />

## How to Use

1. Load the dataset into your SQL environment and run analysis queries.
2. Import cleaned data into Power BI Desktop.
3. Build or use the provided dashboard template to visualize key insights.
4. Use slicers to dynamically explore patient and treatment details.

## Author

Mehul .S.V

## License

Licensed under MIT License.

***

This README is focused, highlights project importance, includes a key SQL example, and omits less crucial technical details for clarity. Let me know if any other code snippets or sections should be added!
