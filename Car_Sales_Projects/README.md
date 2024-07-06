# CAR SALES DASHBOARD
![Full Projects](https://github.com/harunrhimu/SQLProjects/blob/main/Car_Sales_Projects/Cars%20Sales%20Dahboard.jpg?raw=true)

## SQL Full Project with Tableau Dashboard
# Background
Our company is a car dealership that sells various car models. To effectively track and analyse our sales performance, we need a comprehensive Car Sales Dashboard in Tableau. 
 ## Objective: 
 The objective of this project is to design and develop a dynamic and interactive Car Sales Dashboard using Tableau. The dashboard will visualize critical KPIs related to our car sales, helping us understand our sales performance over time and make data-driven decisions.
 ### The question I wanted to answer through my `SQL` queries were:
KPI’s Requirement
1.	Sales Overview:
•	Year-to-Date (YTD) Total Sales
•	Year-over-Year (YOY) Growth in Total Sales
2.	Average Price Analysis:
•	YTD Average Price
•	YOY Growth in Average Price
3.	Cars Sold Metrics:
•	YTD Cars Sold
•	YOY Growth in Cars Sold
Problem Statement 2
1.	YTD Sales Weekly Trend
2.	YTD Total Sales by Body Style
3.	YTD Total Sales by Color
4.	YTD Cars Sold by Dealer Region
5.	Company-Wise Sales Trend in Grid Form

# The Tools I Used:
I used several key tools to deep dive in the data analyst. 
- **SQL:** The backbone of my data analyst which is enable me to figure out what i wanted to solve the business problem.
- **PostgreSQL:** The database management system
- **Visual Studio Code:** PostgreSQL connected with VS Code to excuting SQL queries.
- **Git & GitHub:** This is a essential tools for verson control and sharing my project and analysis. 


# The Analysis

The questions are illustrated below want to excute specific business problem in term of car sales issues. 

## Problem Statement 1: KPI’s Requirement

Due to The dashboard should provide real-time insights into key performance indicators (KPIs) related to our sales data. This will enable us to make informed decisions, monitor our progress, and identify trends and opportunities for growth.
## 1.	Sales Overview:

•	Year-to-Date (YTD) Total Sales
```sql
SELECT 
    CONCAT(ROUND(SUM("Price") / 1000000.0, 3), 'M') AS YTD_SALES
FROM 
    car_sales_data
WHERE 
    EXTRACT(YEAR FROM "Date") = 2021
```
[{{(Here is Image and query description)}}]


•	Year-over-Year (YOY) Growth in Total Sales
```sql
SELECT 
    CONCAT(ROUND(SUM("Price") / 1000000.0, 3), 'M') AS YOY_SALES
FROM 
    car_sales_data
WHERE 
    EXTRACT(YEAR FROM "Date") = 2020;
```

<p align="center">
  <img src="https://github.com/harunrhimu/SQLProjects/blob/main/Car_Sales_Projects/assets/YTDTotalSales&Growth%20.jpg?raw=true" alt="Year-over-Year (YOY) Total Sales & Growth in Total Sales">
</p>


# 2.	Average Price Analysis:
•	YTD Average Price
```sql

----•	YTD Average Price which is YTD_total_sales / YTD_car_sold
--Car sold is nothing but count(Car_id)
WITH YTD_SALESS as ( 
SELECT 
    SUM("Price")  AS YTD_SALES
FROM 
    car_sales_data
WHERE 
    EXTRACT(YEAR FROM "Date") = 2021
),
YTD_car_sold as (
SELECT 
    count("Car_id") as Total_car_sold
FROM 
    car_sales_data
WHERE 
    EXTRACT(YEAR FROM "Date") = 2021
)
SELECT YTD_SALES / Total_car_sold
FROM YTD_SALESS, YTD_car_sold
```

•	YOY Growth in Average Price
```sql 

WITH  YTD_avg AS (

SELECT 
    ROUND(avg("Price"),2) AS YTD_avg_price
FROM 
    car_sales_data
WHERE 
    EXTRACT(YEAR FROM "Date") = 2021
), 

PYTD_avg AS (

SELECT 
    round(avg("Price"),2) AS PYTD_avg_SALES
FROM 
    car_sales_data
WHERE 
    EXTRACT(YEAR FROM "Date") = 2020
)

SELECT YTD_avg_price, PYTD_avg_SALES, 
(YTD_avg_price -PYTD_avg_SALES) /PYTD_avg_SALES as YOY_AVG_GROWTH
FROM YTD_avg, PYTD_avg;
```
<p align="center">
  <img src="https://github.com/harunrhimu/SQLProjects/blob/main/Car_Sales_Projects/assets/YTDAvgPrice&Growth%20.jpg?raw=true" alt="YTD average price and growth">
</p>



## 3.	Cars Sold Metrics:
•	YTD Cars Sold
```sql 
select count("Car_id") as YTD_Car_Sold
from car_sales_data 
where EXTRACT(YEAR FROM "Date") = 2021 

```

•	YOY Growth in Cars Sold
```sql
WITH YTD_Cars AS (
    SELECT 
        COUNT("Car_id") AS YTD_car_sold
    FROM 
        car_sales_data
    WHERE 
        EXTRACT(YEAR FROM "Date") = 2021
), 
PYTD_cars AS (
    SELECT 
        COUNT("Car_id") AS PYTD_Car_Sold
    FROM 
        car_sales_data
    WHERE 
        EXTRACT(YEAR FROM "Date") = 2020
)
SELECT 
    YTD_car_sold, 
    PYTD_Car_Sold, 
    CASE 
        WHEN PYTD_Car_Sold = 0 THEN NULL -- Avoid division by zero
        ELSE (YTD_car_sold - PYTD_Car_Sold) / CAST(PYTD_Car_Sold AS FLOAT)
    END AS YOY_car_sold_GROWTH
FROM 
    YTD_Cars, 
    PYTD_cars;
```

<p align="center">
  <img src="https://github.com/harunrhimu/SQLProjects/blob/main/Car_Sales_Projects/assets/YTDCarsSold&Growth.jpg?raw=true" alt="YTD Cars Sold & Growth rate">
</p>



# Problem Statement 2: Charts Requirement

1.	YTD Sales Weekly Trend: Display a line chart illustrating the weekly trend of YTD sales. The X-axis should represent weeks, and the Y-axis should show the total sales amount.
```sql

select EXTRACT(weeks from "Date") as week, sum("Price") as total_sales
from car_sales_data 
where EXTRACT(YEAR FROM "Date") = 2021 
GROUP BY week
order by week desc
```
<p align="center">
  <img src="https://github.com/harunrhimu/SQLProjects/blob/main/Car_Sales_Projects/assets/YTDWeeklySalesTrends.jpg?raw=true" alt="YTD Sales Weekly Trends with line chart">
</p>



2.	YTD Total Sales by Body Style: Visualize the distribution of YTD total sales across different car body styles using a Pie chart.
```sql
SELECT  "Body Style", sum("Price") as total_sales
from car_sales_data 
where EXTRACT(YEAR FROM "Date") = 2021 
GROUP BY "Body Style"
order by total_sales desc

```
<p align="center">
  <img src="https://github.com/harunrhimu/SQLProjects/blob/main/Car_Sales_Projects/assets/YTDTotalSalesbyBodyStyle.jpg?raw=true" alt="YTD Total Sales by body style">
</p>

3.	YTD Total Sales by Color: Present the contribution of various car colors to the YTD total sales through a donut chart.
```sql
select  "Color" , sum("Price") as total_sales
from car_sales_data 
where EXTRACT(YEAR FROM "Date") = 2021 
GROUP BY "Color"
order by total_sales desc
```
<p align="center">
  <img src="https://github.com/harunrhimu/SQLProjects/blob/main/Car_Sales_Projects/assets/YTDTotalSalesbyColor.jpg?raw=true" alt="YTD Total Sales by color">
</p>

4.	YTD Cars Sold by Dealer Region: Showcase the YTD sales data based on different dealer regions using a bar chart to visualize the sales distribution geographically.
```sql
select  "Dealer_Region" , sum("Price") as total_sales
from car_sales_data 
where EXTRACT(YEAR FROM "Date") = 2021 
GROUP BY "Dealer_Region"
order by total_sales desc
```
<p align="center">
  <img src="https://github.com/harunrhimu/SQLProjects/blob/main/Car_Sales_Projects/assets/YTDCarSoldbyDealerRegion.jpg?raw=true" alt="YTD Total Sales by dealer region">
</p>



5.	Company-Wise Sales Trend in Grid Form: Provide a tabular grid that displays the sales trend for each company. The grid should showcase the company name along with their YTD sales figures.
```sql
select  "Company" , sum("Price") as total_sales
from car_sales_data 
where EXTRACT(YEAR FROM "Date") = 2021 
GROUP BY "Company"
order by total_sales desc
Limit 5
```
<p align="center">
  <img src="https://github.com/harunrhimu/SQLProjects/blob/main/Car_Sales_Projects/assets/CompanyWiseSalesTrends.jpg?raw=true" alt="YTD Total Sales by color">
</p>

# Car Sales Dashboard Insights 

**Total Sales & Growth:**
- **YTD Total Sales:** `$371.19M`, achieving a robust 23.59% annual growth rate and a weekly trend of `$15.53M`.

**Units Sold & Growth:**
- **YTD Total Cars Sold:** `13.26K` units, reflecting a significant `24.57%` growth rate.

**Pricing Trends:**
- **YTD Average Price:** `$27.99K`, with a slight decrease of `-0.79%`.

**Top Performing Regions:**
- **Top Dealer Region:** Austin, with `1,207` Auto and `1,089` Manual Transmission cars sold.
- **Bottom Dealer Region:** Middletown, with `909` Auto and `813` Manual Transmission cars sold.

**Top Companies:**
- **Cadillac:** Leading with a top YTD average of `$42.24M`.
- **Chevrolet:** Leading with `1.04K` cars sold and total sales of `$27.11M`.

**Sales by Color and Body Style:**
- **Top Car Color:** Pale White, with YTD sales of `$175.53M`.
- **Top Body Style:** SUV, with YTD sales of `$73.69M`.

## Recommendations Based on Insights

**Focus on High-Growth Areas:**
- **Optimize Resources in Austin:** Allocate more resources to Austin, the top dealer region, to capitalize on its strong performance. Implement promotions, enhance marketing efforts, and ensure adequate inventory to boost sales further.
- **Improve Performance in Middletown:** Investigate the factors leading to Middletown being the bottom dealer region. Consider revising marketing strategies and implementing training programs to enhance local performance.

**Enhance Marketing Strategies:**
- **Promote Leading Models and Colors:** Given the strong performance of Cadillac and Chevrolet, as well as the popularity of Pale White cars, tailor marketing campaigns to highlight these models and colors.
- **Focus on SUV Models:** Since SUVs have the highest total sales by body style, concentrate marketing efforts on promoting SUV models.

**Address Price Sensitivity:**
- **Evaluate Pricing Strategies:** With the average price slightly decreasing (-0.79%), reassess pricing strategies to remain competitive while maintaining profitability. Consider offering incentives or financing options to attract price-sensitive customers.

These recommendations aim to optimize sales performance, enhance customer satisfaction, and drive overall business growth.

**Thanks**