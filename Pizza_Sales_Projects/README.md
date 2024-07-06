## Pizza Sales SQL Queries Presentation with Tableau Dashboard

### Background:
Our pizza chain needs a detailed analysis of our sales performance. To do this, we require SQL queries that will extract and present key metrics from our sales database. This will help us understand our business performance, identify trends, and make informed decisions to improve our operations and profitability.

### Objective:
The objective of this project is to develop and present a set of SQL queries that will extract critical KPIs and trends related to our pizza sales. The results will provide valuable insights into our sales performance, helping us make data-driven decisions.

### Problem Statement 1: KPI Requirements

The queries should provide real-time insights into the following key performance indicators (KPIs):

**Total Revenue**: Calculate the total revenue generated from pizza sales.

**Average Order Value**: Determine the average value of each order.

**Total Pizzas Sold**: Count the total number of pizzas sold.

**Total Orders**: Count the total number of orders placed.

**Average Pizzas Per Order**: Calculate the average number of pizzas sold per order.

### Problem Statement 2: Trend and Distribution Requirements

1. **Hourly Trend of Total Pizzas Sold**: Extract data to display a Bar chart showing the total number of pizzas sold each hour.
2. **Weekly Trend of Total Pizzas Sold**: Extract data to display a line chart illustrating the weekly trend of total pizzas sold.

3. **Percentage of Total Orders by Pizza Category**: Extract data to present the distribution of total orders across different pizza categories using a donut chart.

4. **Percentage of Sales by Pizza Size**: Extract data to present the contribution of different pizza sizes to the total sales through a bar chart.

5. **Top and Bottom Seller Analysis**:

    - **Top 5 Best Seller Pizzas by Revenue**: Identify the top 5 pizzas generating the highest revenue.

    - **Bottom 5 Best Seller Pizzas by Revenue**: Identify the bottom 5 pizzas generating the lowest revenue.

    - **Top 5 Best Seller Pizzas by Total Quantity**: Identify the top 5 pizzas sold in the highest quantities.

    - **Bottom 5 Best Seller Pizzas by Total Quantity**: Identify the bottom 5 pizzas sold in the lowest quantities.

### Deliverables:
- SQL queries for each KPI and trend requirement.
- Presentation of the query results in charts and tables as specified.
- Analysis and insights derived from the data to support decision-making.

By completing this project, we aim to gain a comprehensive understanding of our pizza sales performance and uncover actionable insights to drive growth and efficiency.


# The Analysis

The questions are illustrated below want to excute specific business problem in term of car sales issues. 

### Problem Statement 1: KPI Requirements

The queries should provide real-time insights into the following key performance indicators (KPIs):

•	Total Revenue: Calculate the total revenue generated from pizza sales.

```sql
SELECT CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_Revenue
FROM pizza_sales

```

•	Average Order Value: Determine the average value of each order.

```sql
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Average_Order_Value
FROM pizza_sales

```

•	Total Pizzas Sold: Count the total number of pizzas sold.
```sql
SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales

```


•	Total Orders: Count the total number of orders placed.
```sql
SELECT count(distinct order_id) AS Total_Orders
FROM pizza_sales

```
•	Average Pizzas Per Order: Calculate the average number of pizzas sold per order.
```sql
SELECT CAST(  --this is for 2 decimal
			CAST( --this is for total output will be decimal
				SUM(quantity) AS DECIMAL (10,2)) / 
			CAST( --this is for total output will be decimal
				COUNT (DISTINCT order_id) AS DECIMAL (10,2)) 
					AS DECIMAL(10,2)) AS Average_Pizza_Per_Orders   --this is for 2 decimal
FROM pizza_sales

```
### Problem Statement 2: Trend and Distribution Requirements

1. Hourly Trend of Total Pizzas Sold: Extract data to display a Bar chart showing the total number of pizzas sold each hour.
```sql
--Datepart will extract hour data from order_time
SELECT DATEPART(HOUR, order_time) AS Order_Hour, SUM(quantity) AS TotalPizzaSold
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

```

2. Weekly Trend of Total Pizzas Sold: Extract data to display a line chart illustrating the weekly trend of total pizzas sold.

```sql
--Datepart will extract IS_Week data from order_time
SELECT DATEPART(ISO_WEEK, order_date) AS Week_Number, --it will shows total weeks of a year
		YEAR(order_date) as Order_Year, --years of 2015 showed
		count(distinct order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATEPART(ISO_WEEK, order_date), YEAR(order_date) --aggregated function are used as a group by statement (requirement)
ORDER BY DATEPART(ISO_WEEK, order_date), YEAR(order_date) --aggregated function are used as a order by statement (requirement)

```

3. Percentage of Total Orders by Pizza Category: Extract data to present the distribution of total orders across different pizza categories using a donut chart.
```sql
SELECT pizza_category AS P_Categrory, ROUND(sum(total_price),2) as Total_Sales , ROUND( SUM(total_price) * 100 / 
-- A subquery used here for correct result			
					(SELECT SUM(total_price) from pizza_sales WHERE MONTH(order_date) = 1 ),2) AS Percentage_OfTotalSales
FROM pizza_sales
--when we used filter in main query we should use this filter also subqueyr
WHERE MONTH(order_date) = 1 
--WHERE MONTH(order_date) = 1  indicateds that will shows the month of january = 4 shows the month of April
GROUP BY pizza_category
ORDER BY Percentage_OfTotalSales DESC, Total_Sales DESC

```


4. Percentage of Sales by Pizza Size: Extract data to present the contribution of different pizza sizes to the total sales through a bar chart.

```sql
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_Sales, CAST(
					SUM(total_price) * 100 / 
-- A subquery used here for correct result	
-- Both subquery and main query should use filter (SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER, order_date) = 1) AS decimal (10,2) ) AS Percent_SalesBYPizza_Size --rounded query end this line
FROM pizza_sales
--Where quarter is 1 
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_size
ORDER BY pizza_size, Total_Sales DESC

```

5. Top and Bottom Seller Analysis:

•	Top 5 Best Seller Pizzas by Revenue: Identify the top 5 pizzas generating the highest revenue.
```sql
SELECT TOP 5 pizza_name, CAST(sum(total_price) AS DECIMAL (10,2)) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC 

```


•	Bottom 5 Best Seller Pizzas by Revenue: Identify the bottom 5 pizzas generating the lowest revenue.
```sql
SELECT TOP 5 pizza_name, CAST(sum(total_price) AS DECIMAL (10,2)) AS Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC --to figur out bottom 5 pizza

```
•	Top 5 Best Seller Pizzas by Total Quantity: Identify the top 5 pizzas sold in the highest quantities.
```sql
SELECT TOP 5 pizza_name, CAST(sum(quantity) AS DECIMAL (10,2)) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC 

```
•	 Bottom 5 Best Seller Pizzas by Total Quantity: Identify the bottom 5 pizzas sold in the lowest quantities.
```sql    
SELECT TOP 5 pizza_name, CAST(sum(quantity) AS DECIMAL (10,2)) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC --to figur out bottom 5 pizza
```
# Car Sales Dashboard Insights 


## Recommendations Based on Insights

**Thanks**