# /*  Project Purpose 🏆
*/
--To check any error present, Datatype, missing values
SELECT * FROM car_sales_data
select *
from car_sales_data
where 

/*
CASE 
	WHEN EXTRACT(month from date) = 6 then 'June'
 	WHEN EXTRACT(month from date) = 7 then 'July'
	WHEN EXTRACT(month from date) = 8 then 'August'  
END as month 

*/


select * from  car_sales_data csd 

select CONCAT(ROUND(SUM("Price") / 1000000.0, 3), 'M') AS YTD_SALES 
--CONCAT(ROUND(SUM("Price")
from car_sales_data csd  
--where "Gender" = 'Female' 

/* TABLEAU PROJECT
CAR SALES DASHBOARD
Background: Our company is a car dealership that sells various car models. To effectively track and analyse our sales performance, we need a comprehensive Car Sales Dashboard in Power BI. 
Objective: The objective of this project is to design and develop a dynamic and interactive Car Sales Dashboard using Power BI. The dashboard will visualize critical KPIs related to our car sales, helping us understand our sales performance over time and make data-driven decisions.
Problem Statement 1: KPI’s Requirement
The dashboard should provide real-time insights into key performance indicators (KPIs) related to our sales data. This will enable us to make informed decisions, monitor our progress, and identify trends and opportunities for growth.
*/
-- Q.1.	Sales Overview:

--•	Year-to-Date (YTD) Total Sales
--✨ Skills: SQL Basic CONCAT, ROUND, Aggregate, Compare operator
SELECT 
    CONCAT(ROUND(SUM("Price") / 1000000.0, 3), 'M') AS YTD_SALES
FROM 
    car_sales_data
WHERE 
    EXTRACT(YEAR FROM "Date") = 2021



--•	Year-over-Year (YOY)
--✨ Skills: SQL Basic CONCAT, ROUND, Aggregate, Compare operator 
SELECT 
    CONCAT(ROUND(SUM("Price") / 1000000.0, 3), 'M') AS YOY_SALES
FROM 
    car_sales_data
WHERE 
    EXTRACT(YEAR FROM "Date") = 2020;


--Growth in Total Sales
-- To calculated Growth in total sales we have to use CTE here
--✨ Skills: SQL Advance function which is CTE called Common Table expretion
--- The CTE is a temporary table which has not located anywhere in the original table.
WITH  YTD_TOTAL AS (

SELECT 
    ROUND(SUM("Price") / 1000000.0, 3) AS YTD_SALES
FROM 
    car_sales_data
WHERE 
    EXTRACT(YEAR FROM "Date") = 2021
), 

YOY_TOTAL AS (

SELECT 
    ROUND(SUM("Price") / 1000000.0, 3) AS YOY_SALES
FROM 
    car_sales_data
WHERE 
    EXTRACT(YEAR FROM "Date") = 2020
)

SELECT YTD_SALES, YOY_SALES, 
ROUND((YTD_SALES -YOY_SALES) /YOY_SALES * 100, 2 ) as YOY_GROWTH
FROM YTD_TOTAL, YOY_TOTAL;



--Q.2.	Average Price Analysis:
--✨ Skills: SQL Advance function which is CTE called Common Table expretion
--•	YTD Average Price which is YTD_total_sales / YTD_car_sold
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

--•	YOY Growth in Average Price


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


--Q.3.	Cars Sold Metrics:
--•	YTD Cars Sold
select count("Car_id") as YTD_Car_Sold
from car_sales_data 
where EXTRACT(YEAR FROM "Date") = 2021 
        






--•	YOY Growth in Cars Sold

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



Here is our master updated

--Problem Statement 2: Charts Requirement

1.	YTD Sales Weekly Trend: Display a line chart illustrating the weekly trend of YTD sales. The X-axis should represent weeks, and the Y-axis should show the total sales amount.
2.	YTD Total Sales by Body Style: Visualize the distribution of YTD total sales across different car body styles using a Pie chart.
3.	YTD Total Sales by Color: Present the contribution of various car colors to the YTD total sales through a donut chart.
4.	YTD Cars Sold by Dealer Region: Showcase the YTD sales data based on different dealer regions using a bar chart to visualize the sales distribution geographically.
5.	Company-Wise Sales Trend in Grid Form: Provide a tabular grid that displays the sales trend for each company. The grid should showcase the company name along with their YTD sales figures.








(371185120.0Million) into 271.185M

SELECT CONCAT(ROUND(amount_in_millions, 1), ' million') AS amount_formatted
FROM your_table_name;






























