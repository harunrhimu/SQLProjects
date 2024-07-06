--select all data from pizza_sales
SELECT *
FROM [Project2024].[dbo].[pizza_sales]


--Total Revenue
SELECT CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_Revenue
FROM pizza_sales

-- Average Order Value
SELECT CAST(SUM(total_price) / COUNT(DISTINCT order_id) AS DECIMAL (10,2)) AS Average_Order_Value
FROM pizza_sales

-- Total Pizza Sold
SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales

--Total Orders
SELECT count(distinct order_id) AS Total_Orders
FROM pizza_sales

--Average Pizza Per Orders
--Note: This result shows exact number but not in fraction
--That's why we have to cast this item 
--10,2 decimal meaning after comma it will shows 10 digit
--So we need to cast again to 2 decimal point
SELECT CAST(  --this is for 2 decimal
			CAST( --this is for total output will be decimal
				SUM(quantity) AS DECIMAL (10,2)) / 
			CAST( --this is for total output will be decimal
				COUNT (DISTINCT order_id) AS DECIMAL (10,2)) 
					AS DECIMAL(10,2)) AS Average_Pizza_Per_Orders   --this is for 2 decimal
FROM pizza_sales


--Hourly Trend Total Pizza Sold
--Datepart will extract hour data from order_time
SELECT DATEPART(HOUR, order_time) AS Order_Hour, SUM(quantity) AS TotalPizzaSold
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)



"""
--Daily Trend Total Pizza Sold
--Datepart will extract hour data from order_time
SELECT DATENAME(DW, order_time) AS Order_Hour, COUNT(DISTINCT order_id) AS TOTAL_ORDERS
FROM pizza_sales
GROUP BY DATENAME(DW, order_time)

"""
SELECT *
FROM pizza_sales


--Weekly Trend Total Pizza Sold
--Datepart will extract IS_Week data from order_time
SELECT DATEPART(ISO_WEEK, order_date) AS Week_Number, --it will shows total weeks of a year
		YEAR(order_date) as Order_Year, --years of 2015 showed
		count(distinct order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATEPART(ISO_WEEK, order_date), YEAR(order_date) --aggregated function are used as a group by statement (requirement)
ORDER BY DATEPART(ISO_WEEK, order_date), YEAR(order_date) --aggregated function are used as a order by statement (requirement)


--Percentage of Total Order by Pizza Category
SELECT pizza_category, SUM(total_price) * 100 / SUM(total_price)
FROM pizza_sales
GROUP BY pizza_category
--Note: The above result shows only 100 with pizza category
--So we should be subquery to find out real values
--just divided by subquery sum_of_total_Price
SELECT pizza_category AS P_Categrory, ROUND(sum(total_price),2) as Total_Sales , ROUND( SUM(total_price) * 100 / 
-- A subquery used here for correct result			
					(SELECT SUM(total_price) from pizza_sales WHERE MONTH(order_date) = 1 ),2) AS Percentage_OfTotalSales
FROM pizza_sales
--when we used filter in main query we should use this filter also subqueyr
WHERE MONTH(order_date) = 1 
--WHERE MONTH(order_date) = 1  indicateds that will shows the month of january = 4 shows the month of April
GROUP BY pizza_category
ORDER BY Percentage_OfTotalSales DESC, Total_Sales DESC

--Percentage of Sales by Pizza Size

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_Sales, CAST(
					SUM(total_price) * 100 / 
-- A subquery used here for correct result	
-- Both subquery and main query should use filter
					(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER, order_date) = 1) AS decimal (10,2) ) AS Percent_SalesBYPizza_Size --rounded query end this line
FROM pizza_sales
--Where quarter is 1 
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_size
ORDER BY pizza_size, Total_Sales DESC

--Top 5 Best Seller Pizza By Revenue, 

SELECT TOP 5 pizza_name, CAST(sum(total_price) AS DECIMAL (10,2)) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC 

--Bottom 5 Best Seller Pizza By Revenue, 

SELECT TOP 5 pizza_name, CAST(sum(total_price) AS DECIMAL (10,2)) AS Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC --to figur out bottom 5 pizza

--Top 5 Best Seller Pizza By Total Quantity

SELECT TOP 5 pizza_name, CAST(sum(quantity) AS DECIMAL (10,2)) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC 



--Bottom 5 Best Seller Pizza By Total Quantity 

SELECT TOP 5 pizza_name, CAST(sum(quantity) AS DECIMAL (10,2)) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC --to figur out bottom 5 pizza


--Top 5 Best Seller Pizza By Total Quantity

SELECT TOP 5 pizza_name, CAST(count(distinct order_id) AS DECIMAL (10,2)) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC 

--Bottom 5 Best Seller Pizza By Total Quantity 

SELECT TOP 5 pizza_name, CAST(count(distinct order_id) AS DECIMAL (10,2)) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC --to figur out bottom 5 pizza


SELECT *
FROM [Project2024].[dbo].[pizza_sales]
