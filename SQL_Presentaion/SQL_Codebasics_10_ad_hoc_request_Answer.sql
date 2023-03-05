
-- Codebasics SQL Challenge Requests:

/*1. Provide the list of markets in which customer "Atliq Exclusive" operates its
business in the 'APAC' region.
*/

SELECT 
 DISTINCT (market)
FROM dim_customer
WHERE customer="Atliq Exclusive" 
	AND region='APAC';

/*
2. What is the percentage of unique product increase in 2021 vs. 2020? The
final output contains these fields,
-->unique_products_2020
-->unique_products_2021
-->percentage_chg
*/

SELECT 
  COUNT(DISTINCT CASE WHEN fiscal_year=2020 THEN product_code ELSE NULL END) AS unique_products_2020,
  COUNT(DISTINCT CASE WHEN fiscal_year=2021 then product_code ELSE NULL END) AS unique_products_2021,
  ROUND((COUNT(DISTINCT CASE WHEN fiscal_year=2021 then product_code ELSE NULL END) - count(distinct case when fiscal_year=2020 then product_code else null end))
  /(COUNT(DISTINCT CASE WHEN fiscal_year=2020 then product_code ELSE NULL END))*100,2) AS percentage_chg
FROM  fact_gross_price;

/*
3. Provide a report with all the unique product counts for each segment and
sort them in descending order of product counts. The final output contains 2 fields,
-->segment
-->product_count
*/
SELECT  
 segment,
 COUNT(DISTINCT product_code) AS product_count
FROM dim_product
GROUP BY 1       
ORDER BY 2 desc;

/*
4. Follow-up: Which segment had the most increase in unique products in
2021 vs 2020? The final output contains these fields,
-->segment
-->product_count_2020
-->product_count_2021
-->difference
*/
SELECT 
 p.segment,
 COUNT(DISTINCT CASE WHEN g.fiscal_year=2020 THEN p.product_code ELSE null END) AS products_count_2020,
 COUNT(DISTINCT CASE WHEN g.fiscal_year=2021 THEN p.product_code ELSE null END) AS products_count_2021,
 ROUND(COUNT(DISTINCT CASE WHEN g.fiscal_year=2021 THEN p.product_code ELSE NULL END)  
 - COUNT(DISTINCT CASE WHEN g.fiscal_year=2020 THEN p.product_code ELSE NULL END),2) AS difference
 FROM dim_product p
  inner JOIN fact_gross_price g ON p.product_code=g.product_code
 GROUP BY 1
 ORDER BY 4 DESC;



/*
5. Get the products that have the highest and lowest manufacturing costs.
The final output should contain these fields,
-->product_code
-->product
-->manufacturing_cost
*/
SELECT
 m.product_code,
 p.product,
 p.division,
 p.segment,
 CONCAT('$',ROUND(m.manufacturing_cost,2)) AS manufacturing_cost /*here b is alias for fact_manufacturing_cost table*/
FROM fact_manufacturing_cost m 
   inner JOIN dim_product p ON m.product_code=p.product_code
WHERE m.manufacturing_cost IN ((SELECT min(manufacturing_cost) FROM fact_manufacturing_cost),
								(SELECT max(manufacturing_cost) FROM fact_manufacturing_cost))
ORDER BY 1 DESC;
/*
6. Generate a report which contains the top 5 customers who received an
average high pre_invoice_discount_pct for the fiscal year 2021 and in the
Indian market. The final output contains these fields,
-->customer_code
-->customer
-->average_discount_percentage
*/
SELECT  
 c.customer_code,
 c.customer,
 ROUND(AVG(p.pre_invoice_discount_pct)*100,2) AS average_discount_percentage
FROM fact_pre_invoice_deductions P
  LEFT JOIN dim_customer C  ON p.customer_code=c.customer_code
WHERE p.fiscal_year=2021 
	AND c.market='India'
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 5;
/*
7. Get the complete report of the Gross sales amount for the customer “Atliq
Exclusive” for each month. This analysis helps to get an idea of low and
high-performing months and take strategic decisions.
The final report contains these columns:
-->Month
-->Year
-->Gross sales Amount
*/
SELECT  
 s.date, 
 YEAR(s.date) as year_,
 monthname(s.date) as month_,
 concat('$',ROUND(SUM(s.sold_quantity*g.gross_price)/1000000,2),'M') AS Gross_sales_amount
FROM fact_sales_monthly s
  JOIN fact_gross_price g ON g.product_code=s.product_code AND g.fiscal_year = s.fiscal_year
  JOIN dim_customer c ON c.customer_code=s.customer_code 
WHERE customer= 'Atliq Exclusive' 
GROUP BY 1,2
ORDER BY 1 ;

/*
8. In which quarter of 2020, got the maximum total_sold_quantity? The final
output contains these fields sorted by the total_sold_quantity,
-->Quarter
-->total_sold_quantity
*/

SELECT 
 CASE
   WHEN MONTH(date) IN  (9,10,11) THEN  "Q1"
   WHEN MONTH(date) IN (12,1,2) THEN  "Q2"
   WHEN MONTH(date) IN (3,4,5) THEN  "Q3"
   ELSE "Q4"
   END AS  Quaters,
ROUND(SUM(s.sold_quantity)/1000000,2) AS Total_sold_quantity
FROM fact_sales_monthly s 
WHERE s.fiscal_year= 2020 
GROUP BY 1
ORDER BY 2 DESC;
   


/*
9. Which channel helped to bring more gross sales in the fiscal year 2021
and the percentage of contribution? The final output contains these fields,
-->channel
-->gross_sales_mln
-->percentage
*/
WITH gross_sale AS(
SELECT 
 channel,
 ROUND(SUM(g.gross_price*s.sold_quantity)/1000000,2) AS Gross_sales_mln
 FROM fact_sales_monthly s
    LEFT JOIN fact_gross_price g ON s.product_code=g.product_code AND g.fiscal_year = s.fiscal_year
    LEFT JOIN  dim_customer c ON c.customer_code=s.customer_code
 WHERE s.fiscal_year=2021
 GROUP BY 1)
SELECT *,
  CONCAT(ROUND(Gross_sales_mln/ SUM(Gross_sales_mln) OVER()*100,2),'%') AS percentage
FROM gross_sale
GROUP BY 1,2
ORDER BY 2 DESC;
 


/*
10. Get the Top 3 products in each division that have a high
total_sold_quantity in the fiscal_year 2021? The final output contains these fields,
-->division
-->product_code
-->product
-->total_sold_quantity
-->rank_order
*/

WITH cte1 AS(
SELECT 
 p.division,
 p.product_code,
 p.product,
 SUM(s.sold_quantity) AS total_sold_quantity
FROM fact_sales_monthly s 
  JOIN dim_product p ON p.product_code=s.product_code
WHERE s.fiscal_year=2021 
GROUP BY 1,2,3
),
cte2 AS(
    SELECT *, 
	 RANK() OVER(PARTITION BY division ORDER BY total_sold_quantity DESC) AS rank_order 
	FROM cte1)
	SELECT * 
	 FROM cte2
	WHERE rank_order<=3;
    
   