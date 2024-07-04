# CAR SALES DASHBOARD
## SQL Full Project with Tableau Dashboard
# Background
Our company is a car dealership that sells various car models. To effectively track and analyse our sales performance, we need a comprehensive Car Sales Dashboard in Power BI. 
 ## Objective: 
 The objective of this project is to design and develop a dynamic and interactive Car Sales Dashboard using Power BI. The dashboard will visualize critical KPIs related to our car sales, helping us understand our sales performance over time and make data-driven decisions.
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
```
SELECT 
    CONCAT(ROUND(SUM("Price") / 1000000.0, 3), 'M') AS YTD_SALES
FROM 
    car_sales_data
WHERE 
    EXTRACT(YEAR FROM "Date") = 2021
```


•	Year-over-Year (YOY) Growth in Total Sales



2.	Average Price Analysis:


•	YTD Average Price



•	YOY Growth in Average Price



## 3.	Cars Sold Metrics:
•	YTD Cars Sold


•	YOY Growth in Cars Sold





# Problem Statement 2: Charts Requirement

1.	YTD Sales Weekly Trend: Display a line chart illustrating the weekly trend of YTD sales. The X-axis should represent weeks, and the Y-axis should show the total sales amount.



2.	YTD Total Sales by Body Style: Visualize the distribution of YTD total sales across different car body styles using a Pie chart.


3.	YTD Total Sales by Color: Present the contribution of various car colors to the YTD total sales through a donut chart.




4.	YTD Cars Sold by Dealer Region: Showcase the YTD sales data based on different dealer regions using a bar chart to visualize the sales distribution geographically.



5.	Company-Wise Sales Trend in Grid Form: Provide a tabular grid that displays the sales trend for each company. The grid should showcase the company name along with their YTD sales figures.

