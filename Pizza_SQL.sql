CREATE DATABASE Pizza_DB;

--TOTAL REVENUE
USE Pizza_DB;
SELECT 
	 CAST (SUM (total_price) AS DECIMAL (10,2)) AS 'Total_Revenue'
FROM
	pizza_sales;


--AVERAGE ORDER VALUE
USE Pizza_DB;
SELECT 
	CAST (SUM (total_price) / COUNT (DISTINCT order_id) 
	AS DECIMAL (10,2)) AS 'Avg_Order_Value'
FROM
	pizza_sales;


--TOTAL ORDERS
USE Pizza_DB;
SELECT 
      COUNT (DISTINCT Order_id) AS 'Total_Order'
FROM 
	pizza_sales;


--TOTAL PIZZAS SOLD
USE Pizza_DB;
SELECT 
	SUM (quantity) AS 'Total_Pizza_Sold'
FROM 
	pizza_sales;


--AVERAGE PIZZAS PER ORDER
USE Pizza_DB;
SELECT
	CAST (CAST (SUM(quantity) AS DECIMAL (10,2)) /
	CAST( COUNT(DISTINCT order_id) AS DECIMAL (10,2))
	AS DECIMAL (10,2)) AS 'Avg_Pizza_Per_Order'
FROM 
	pizza_sales;


--DAILY ORDER TRENDS
USE Pizza_DB;
SELECT 
	DATENAME(DW,Order_date) AS 'Order_Day',
	COUNT( DISTINCT order_id) AS 'Total_Order' 
FROM 
	pizza_sales
GROUP BY 
	DATENAME(DW,Order_date);


--SALES BY PIZZA CATEGORY 
USE Pizza_DB;
SELECT 
	pizza_category, SUM (total_Price) AS Total_Sales,
	SUM(total_price) * 100/ 
	(SELECT SUM(total_price) FROM pizza_sales
	WHERE MONTH(order_date) = 1) AS 'Pct_Of_Total_Sales'
FROM 
	pizza_sales
WHERE
	MONTH(order_date) = 1
GROUP BY 
	pizza_category;


--SALES BY PIZZA SIZE
USE Pizza_DB;
SELECT 
	pizza_size, CAST (SUM (total_Price) AS DECIMAL(10,2)) AS 'Total_Sales',
	CAST (SUM(total_price) * 100/ 
	(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER,order_date)=1) 
	AS DECIMAL (10,2)) AS 'Pct_Of_Total_Sales'
FROM 
	pizza_sales
WHERE DATEPART(QUARTER,order_date)=1
GROUP BY 
	pizza_size
ORDER BY
	Pct_Of_Total_Sales DESC; 


--TOP 5 PIZZAS BY REVENUE
USE Pizza_DB;
SELECT 
	TOP 5 pizza_name, SUM(total_price) AS 'Total_Revenue'
FROM 
	pizza_sales
GROUP BY 
	pizza_name
ORDER BY 
	Total_Revenue DESC;


--TOP 5 PIZZAS BY QUANTITY SOLD
USE Pizza_DB;
SELECT 
	TOP 5 pizza_name, SUM(quantity) AS 'Total_Quantity'
FROM 
	pizza_sales
GROUP BY 
	pizza_name
ORDER BY 
	Total_Quantity DESC;


-- TOP 5 PIZZAS BY TOTAL ORDERS
USE Pizza_DB;
SELECT 
	TOP 5 pizza_name, COUNT(DISTINCT order_id) AS 'Total_Order'
FROM 
	pizza_sales
GROUP BY 
	pizza_name
ORDER BY 
	Total_Order DESC;