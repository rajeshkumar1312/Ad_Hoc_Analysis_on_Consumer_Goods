
# Ad_Hoc_analysis_on_Consumer_Goods_Domain_By_Codebasics
Codebasics SQL project on Provide Insights to Management in Consumer Goods Domain

Challenge [Link](https://codebasics.io/challenge/codebasics-resume-project-challenge)

Presentation video [Link](https://www.linkedin.com/posts/mrajesh1312_codebasicsresumechallenge-activity-7038105797997805568-BCH8?utm_source=share&utm_medium=member_desktop)

## Table of Contents

- [Company Overview And Problem Statement](#company-overview-and-problem-statement)
- [Atliq’s Business their Markets and Products](#atliqs-business-their-markets-and-products)
- [Data Inputs](#data-inputs)
- [Ad-hoc Request Along With The Result, Visualization And Insights](#ad-hoc-request-along-with-the-result-visualization-and-insights)

## Company Overview And Problem Statement

Atliq Hardwares (imaginary company) is one of the leading computer hardware producers in India and well expanded in other countries too.

However, the management noticed that they do not get enough insights to make quick and smart data-informed decisions. 
They want to expand their data analytics team by adding several junior data analysts. 
Tony Sharma, their data analytics director wanted to hire someone who is good at both tech and soft skills. 
Hence, he decided to conduct a SQL challenge which will help him understand both the skills.
#### Task
- There are 10 ad hoc requests to run a SQL query to answer these requests. 
- The target audience of this Project is top-level management – and  create a presentation to show the insights.

## Atliq’s business their markets and products
 ### Atliq's Markets
 
 <p align="center">
  <img src="https://github.com/rajeshkumar1312/Ad_Hoc_analysis_on_Consumer_Goods_Domain_By_Codebasics/blob/main/Insight%20%26%20output/Atilq_markets.png" height="400">
</p>

 ### Atliq's Products
 
 <p align="center">
  <img src="https://github.com/rajeshkumar1312/Ad_Hoc_analysis_on_Consumer_Goods_Domain_By_Codebasics/blob/main/Insight%20%26%20output/Atilq_product.png" height="400">
</p>


 ## Data Inputs
 
 <p align="center">
  <img src="https://github.com/rajeshkumar1312/Ad_Hoc_analysis_on_Consumer_Goods_Domain_By_Codebasics/blob/main/Insight%20%26%20output/Atilq_data_inputs.png" height="400">
</p>

## Ad-hoc Request Along With the Result, Visualization and Insights

-	 **📌Q1:** Provide the list of markets in which customer `Atliq Exclusive` operates its business in the `APAC region`

```sql
SELECT DISTINCT (market)
 FROM dim_customer
WHERE customer="Atliq Exclusive" 
	AND region='APAC'
```
-	**OutPut:**
<p align="center">
  <img src="https://github.com/rajeshkumar1312/Ad_Hoc_analysis_on_Consumer_Goods_Domain_By_Codebasics/blob/main/Insight%20%26%20output/Q1_Sql_Screenshot%20.png" height="250">
</p>

-	**Insights:**
<p align="center">
  <img src="Insight & output/Insights_1.png" height="400">
</p>

- It appears that "Atliq Exclusive" operates in 8 markets in the APAC region


-	**📌Q2:** What is the percentage of unique product increase in 2021 vs. 2020? The
final output contains these fields.`unique_products_2020`, `unique_products_2021`, `percentage_chg`

```sql
SELECT 
  COUNT(DISTINCT CASE WHEN fiscal_year=2020 THEN product_code ELSE NULL END) AS unique_products_2020,
  COUNT(DISTINCT CASE WHEN fiscal_year=2021 then product_code ELSE NULL END) AS unique_products_2021
  ,ROUND((COUNT(DISTINCT CASE WHEN fiscal_year=2021 then product_code ELSE NULL END) - count(distinct case when fiscal_year=2020 then product_code else null end))
 /(COUNT(DISTINCT CASE WHEN fiscal_year=2020 then product_code ELSE NULL END))*100,2) AS percentage_chg
FROM  fact_gross_price;
```
-	**OutPut:**

<p align="center">
  <img src="https://github.com/rajeshkumar1312/Ad_Hoc_analysis_on_Consumer_Goods_Domain_By_Codebasics/blob/main/Insight%20%26%20output/Q2_SQL_Screenshot.png" height="80">
</p>


-	**Insights:**

<p align="center">
  <img src="Insight & output/Insights_2.png" height="400">
</p>

-	The company added a significant number of new  products in 2021 compared to 2020, with a 36.33% increase in the number of  products. This could indicate that the company is expanding its product offerings or introducing new products to the market.


-	**📌Q3:** Provide a report with all the unique product counts for each segment and
sort them in descending order of product counts. The final output contains 2 fields,
`Segment`, `Product_count`.

```sql
SELECT  
 segment,
 COUNT(DISTINCT product_code) AS product_count
FROM dim_product
GROUP BY 1       
ORDER BY 2 desc
```
-	**OutPut:**
<p align="center">
  <img src="Insight & output/Q3_SQL_screenshot.png" height="300">
</p>


-	**Insights:**
<p align="center">
  <img src="Insight & output/Insights_2.png" height="400">
</p>

-	Notebook and Accessories are the highest selling categories with 129 and 116 , followed by Peripherals with 84 . Desktop and Storage are the least sold categories with 32 and 27, and Networking has the lowest sales with only 9 units sold. This information can be used to make decisions related to inventory management and marketing strategies.
	

-	**📌Q4:** Follow-up: Which segment had the most increase in unique products in
2021 vs 2020? The final output contains these fields.`Segment`, `Product_count_2020`, `Product_count_2021`, `Difference`

```sql
SELECT 
 p.segment,
 COUNT(DISTINCT CASE WHEN g.fiscal_year=2020 THEN p.product_code ELSE null END) AS products_count_2020,
 COUNT(DISTINCT CASE WHEN g.fiscal_year=2021 THEN p.product_code ELSE null END) AS products_count_2021,
 ROUND(COUNT(DISTINCT CASE WHEN g.fiscal_year=2021 THEN p.product_code ELSE NULL END)  
 - COUNT(DISTINCT CASE WHEN g.fiscal_year=2020 THEN p.product_code ELSE NULL END),2) AS difference
 FROM dim_product p
  inner JOIN fact_gross_price g ON p.product_code=g.product_code
 GROUP BY 1
 ORDER BY 4 DESC
```
-	**OutPut:**

<p align="center">
  <img src="Insight & output/Q4_SQL_Sreenshot.png" height="200">
</p>

-	**Insights:**

<p align="center">
  <img src="Insight & output/Insights_4.png" height="400">
</p>

-	we can see that the Accessories segment  had the highest increase in products between 2020 and 2021, with an increase of 34 products. The Notebook had the second-highest increase, with the 16 products. The Peripherals, Desktop, Storage, and Networking  also experienced increases it’s products, with ranging from 3 to 16.


-	**📌Q5** Get the products that have the highest and lowest manufacturing costs.
The final output should contain these fields. `Product_code`, `Product`, `Manufacturing_cost`.

```sql
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
ORDER BY 1 DESC
```
-	**OutPut:**

<p align="center">
  <img src="Insight & output/Q5_SQL_Screenshot .png" height="90">
</p>

-	**Insights:**

<p align="center">
  <img src="Insight & output/Insights_5.png" height="400">
</p>

-	Knowing the manufacturing costs of products is important for businesses to determine the profitability of each product. By comparing the manufacturing cost to the selling price, businesses can determine the profit margin of each product and make informed decisions about pricing and production.


-	**📌Q6:** Generate a report which contains the top 5 customers who received an
average high pre_invoice_discount_pct for the fiscal year 2021 and in the
Indian market. The final output contains these fields,
`customer_code`, `customer`, `Average_Discount_Percentage`

```sql
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
LIMIT 5
```
-	**OutPut:**

<p align="center">
  <img src="https://github.com/rajeshkumar1312/Ad_Hoc_analysis_on_Consumer_Goods_Domain_By_Codebasics/blob/main/Insight%20%26%20output/Q6(1)_SQL_Screenshot%20.png" height="400">
 
</p>

-	**Insights:**

<p align="center">
  <img src="Insight & output/Insights_6.png" height="400">
</p>

-	This report can be useful for understanding which customers in the Indian market are receiving the highest pre-invoice discounts and for identifying potential areas for cost-saving measures.


-	**📌Q7:** Get the complete report of the Gross sales amount for the customer “Atliq
Exclusive” for each month. This analysis helps to get an idea of low and
high-performing months and take strategic decisions.
The final report contains these columns:
`Month`, `Year`, `Gross sales Amount`.

```sql
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
ORDER BY 1 
```
-	**OutPut:**

<p align="center">
  <img src="Insight & output/Q7_SQL_Screenshot .png" height="200">
</p>

-	**Insights:**

<p align="center">
  <img src="Insight & output/Insights_7.png" height="400">
</p>

-	Atliq Exclusive's best-performing months in terms of gross sales are October, November and December of 2020, with sales of $13.22M $20.46M and $12.94M respectively.
-	The lower-performing month  is in March, April, May 2020, due to the COVID-19 pandemic
-	There seems to be a seasonal trend in Atliq Exclusive's sales, with higher sales during the months of September to December, and lower sales during the months of January to April.
-	These insights can help Atliq Exclusive make strategic decisions, such as focusing on marketing and promotions during the months of September to December, and planning for inventory and staffing needs based on the seasonal trends.



-	**📌Q8:**. In which quarter of 2020, got the maximum total_sold_quantity? The final
output contains these fields sorted by the total_sold_quantity,
`Quarter`, `Total_Sold_Quantity`.
```sql
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
ORDER BY 2 DESC
```
-	**OutPut:**

<p align="center">
  <img src="Insight & output/Q8_SQL_Screenshot.png" height="200">
</p>

   
-	**Insights:**

<p align="center">
  <img src="Insight & output/Insights_8.png" height="400">
</p>

-	Q1 had the highest sales volume of 7.01M, and Q2 had second-highest sales volume of 6.65M, suggesting that the company's sales and marketing strategies were successful during the beginning of the fiscal year. The lowest sales volume in Q3 2020 is 2.8M, indicating that is the effect of COVID_19 on our sales. In Q4 there is recovery because of high demand on computer accessories.


**📌Q9:**  Which channel helped to bring more gross sales in the fiscal year 2021
and the percentage of contribution? The final output contains these fields,
`Channel`, `Gross_Sales_Mln`, `Percentage`

```sql
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
ORDER BY 2 DESC
```
-	**OutPut:**

<p align="center">
  <img src="Insight & output/Q9_SQL_Screenshot.png" height="150">
</p>

-	**Insights:**

<p align="center">
  <img src="Insight & output/Insights_9.png" height="400">
</p>

-	The Retailer channel was the top-performing sales channel for the company in fiscal year 2021. this channel performed so well compared to the Direct and Distributor channels.  

 
-	**📌Q10:**  Get the Top 3 products in each division that have a high
total_sold_quantity in the fiscal_year 2021? The final output contains these fields,
`Division`, `Product_code`, `Product`, `Total_Sold_Quantity`, `Rank_order`

```sql
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
	WHERE rank_order<=3
```
-	**OutPut:**

<p align="center">
  <img src="https://github.com/rajeshkumar1312/Ad_Hoc_analysis_on_Consumer_Goods_Domain_By_Codebasics/blob/main/Insight%20%26%20output/Q10_SQL_Screenshot.png" height="300">
</p>

-	**Insights:**

<p align="center">
  <img src="Insight & output/Insights_10.png" height="300">
</p>

-	The top-selling product in the N & S division is the AQ Pen Drive 2 IN 1, with a total quantity sold of 701,373 units. This is significantly higher than the second and third top-selling products in the same division.
-	In the P & A division, the difference in the quantity sold between the top-selling product (AQ Gamers MS) and the second and third top-selling products (AQ Maxima MS) is relatively small, with a difference of only a few hundred units sold.
-	The AQ Digit is the top-selling product in the PC division, with a total quantity sold of 17,434 units. However, the difference in quantity sold between the top-selling and second and third top-selling products in this division is relatively small.




