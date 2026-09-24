-- Telecom Churn Analysis
-- SQL Business Analysis

-- 1. Overall Customer Count
SELECT
    COUNT(*) AS total_customers
FROM telecom_churn;


-- 2. Total Churned Customers
SELECT
    COUNT(*) AS churned_customers
FROM telecom_churn
WHERE churn = 'Yes';


-- 3. Churn Rate
SELECT
    CAST(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS churn_rate_percentage
FROM telecom_churn;


-- 4. Churn by Contract
SELECT
    contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    CAST(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS churn_rate_percentage
FROM telecom_churn
GROUP BY contract
ORDER BY churn_rate_percentage DESC;


-- 5. Churn by Payment Method
SELECT
    payment_method,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM telecom_churn
GROUP BY payment_method
ORDER BY churned_customers DESC;


-- 6. Churn by Gender
SELECT
    gender,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM telecom_churn
GROUP BY gender;


-- 7. Average Monthly Charges by Churn Status
SELECT
    churn,
    CAST(AVG(monthly_charges) AS DECIMAL(10,2)) AS avg_monthly_charges
FROM telecom_churn
GROUP BY churn;


-- 8. Churn by Tenure Group
SELECT
    CASE
        WHEN tenure_months <= 6 THEN '0-6 Months'
        WHEN tenure_months <= 12 THEN '7-12 Months'
        WHEN tenure_months <= 24 THEN '13-24 Months'
        ELSE '24+ Months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM telecom_churn
GROUP BY
    CASE
        WHEN tenure_months <= 6 THEN '0-6 Months'
        WHEN tenure_months <= 12 THEN '7-12 Months'
        WHEN tenure_months <= 24 THEN '13-24 Months'
        ELSE '24+ Months'
    END
ORDER BY churned_customers DESC;
