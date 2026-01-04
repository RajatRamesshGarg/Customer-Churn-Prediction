select * from churn_data.ecommerce_customer_churn_dataset;
select count(*) as total_rows from churn_data.ecommerce_customer_churn_dataset;

# Country Wise Customer Count
select country as country_name,count(country) as country_count from churn_data.ecommerce_customer_churn_dataset
group by country order by country_count DESC;

# Country Wise Churned Customer Count
select country as country_name,count(country) as country_count,sum(churned) as churned_customer from churn_data.ecommerce_customer_churn_dataset
group by country order by country_count DESC;

# Age Wise Churned Customer Count
select age as age, count(age) as age_count,sum(churned) as churned_customer from churn_data.ecommerce_customer_churn_dataset
group by age order by age DESC;

# Gender Wise Churned Customer Count
select gender as gender, count(gender) as gender_count,sum(churned) as churned_customer from churn_data.ecommerce_customer_churn_dataset
group by gender order by gender DESC;

# Agewise + Average Order Value Customer Count
select age as age,count(age) as age_count, sum(Average_Order_Value) as sum from churn_data.ecommerce_customer_churn_dataset
group by age order by age DESC;

SELECT
  churned,
  COUNT(*) AS customer_count,
  ROUND(AVG(average_order_value), 2) AS avg_order_value
FROM churn_data.ecommerce_customer_churn_dataset
GROUP BY churned;    # Churned Customers have a Higher Average Order Value

# Countrywise Membership year 
select country as country_name, Membership_years as Membership_years, count(Membership_years) as Membership_years_sum from churn_data.ecommerce_customer_churn_dataset
group by country,Membership_years order by Membership_Years desc;

# Quick profile of Membership_Years (range + typical value)
SELECT
  MIN(Membership_Years) AS min_years,
  MAX(Membership_Years) AS max_years,
  ROUND(AVG(Membership_Years), 2) AS avg_years
FROM churn_data.ecommerce_customer_churn_dataset;

# How many customers are in each tenure year (simple distribution)
SELECT
  FLOOR(Membership_Years) AS membership_year_bucket,
  COUNT(*) AS customers
FROM churn_data.ecommerce_customer_churn_dataset
GROUP BY membership_year_bucket
ORDER BY membership_year_bucket;

# Churn rate by tenure year bucket
SELECT
  FLOOR(Membership_Years) AS membership_year_bucket,
  COUNT(*) AS customers,
  SUM(Churned) AS churned_customers,
  ROUND(AVG(Churned) * 100, 2) AS churn_rate_pct
FROM churn_data.ecommerce_customer_churn_dataset
GROUP BY membership_year_bucket
ORDER BY membership_year_bucket;


# Country + tenure band (where churn is actually coming from)
SELECT
  Country AS country_name,
  ROUND(AVG(Membership_Years), 2) AS avg_tenure_years,
  COUNT(*) AS total_customers,
  SUM(Churned) AS churned_customers,
  ROUND(AVG(Churned) * 100, 2) AS churn_rate_pct
FROM churn_data.ecommerce_customer_churn_dataset
GROUP BY Country
ORDER BY churn_rate_pct DESC;

# Order value + Tenure + Churn
SELECT
  FLOOR(Membership_Years) AS tenure_year,
  COUNT(*) AS customers,
  SUM(Churned) AS churned_customers,
  ROUND(AVG(Average_Order_Value), 2) AS avg_order_value,
  ROUND(AVG(Churned)*100, 2) AS churn_rate_pct
FROM  churn_data.ecommerce_customer_churn_dataset
GROUP BY tenure_year
ORDER BY tenure_year;

# Tenure + Gender + Churn (Churn Behaviour)
SELECT
  FLOOR(Membership_Years) AS tenure_year,
  Gender,
  COUNT(*) AS customers,
  SUM(Churned) AS churned_customers,
  ROUND(AVG(Churned)*100, 2) AS churn_rate_pct
FROM churn_Data.ecommerce_customer_churn_dataset
GROUP BY tenure_year, Gender
ORDER BY churn_rate_pct DESC;

 # (Overall Summary)
SELECT
  Gender AS Gender,
  ROUND(AVG(Membership_Years), 2) AS avg_tenure_years,
  COUNT(*) AS total_customers,
  SUM(Churned) AS churned_customers,
  ROUND(AVG(Churned) * 100, 2) AS churn_rate_pct
FROM churn_data.ecommerce_customer_churn_dataset
GROUP BY Gender
ORDER BY churn_rate_pct DESC; 

#Login frequency vs churn (engagement risk)
SELECT
  CASE 
    WHEN Login_Frequency < 5 THEN 'Low Login'
    WHEN Login_Frequency < 15 THEN 'Medium Login'
    ELSE 'High Login'
  END AS login_band,
  COUNT(*) AS customers,
  ROUND(AVG(Churned)*100, 2) AS churn_pct
FROM churn_data.ecommerce_customer_churn_dataset
GROUP BY login_band
ORDER BY churn_pct DESC;

#High order value customers churn count
SELECT
  COUNT(*) AS high_value_churners
FROM churn_data.ecommerce_customer_churn_dataset
WHERE Churned = 1
  AND Average_Order_Value > (SELECT AVG(Average_Order_Value) FROM churn_data.ecommerce_customer_churn_dataset);








