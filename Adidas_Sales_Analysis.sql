select * from projects.adidas_sales limit 5;

-- 1. Year wise no of orders and total sales

select Year,count(Invoice_date) as Orders,sum(Total_sales) as Total_Sales
from projects.adidas_sales
group by Year;

-- 2. Display total orders and total sales from each region in the year 2021

select Region,count(Invoice_date) as Orders,sum(Total_sales) as Total_Sales
from projects.adidas_sales
where Year=2021
group by Region
order by Orders desc;

-- 3. Top 5 states with more orders in 2021

select State,count(Invoice_date) as Orders,sum(Total_sales) as Total_Sales
from projects.adidas_sales
where Year=2021
group by State
order by Orders desc
limit 5;

-- 4. Top 5 states with more sales in 2021

select State,sum(Total_sales) as Total_Sales,count(Invoice_date) as Orders
from projects.adidas_sales
where Year=2021
group by State
order by Total_Sales desc
limit 5;
-- 5. Top 3 best selling products in 2021 

select Product,count(Invoice_date) as Ordered
from projects.adidas_sales
where Year=2021
group by Product
order by Ordered desc
limit 3;

-- 6. Most used sales method in 2021

select Sales_method,count(Invoice_date) as Used
from projects.adidas_sales
where Year=2021
group by Sales_method
order by Used desc;

-- 7. Top 5 Months with more orders in 2021

select month,count(Invoice_date) as Orders,sum(Total_sales) as Total_Sales
from projects.adidas_sales
where Year=2021
group by month
order by Orders desc
limit 5;

-- 8. Top 5 months with more sales in 2021

select month,sum(Total_sales) as Total_Sales, count(Invoice_date) as Orders
from projects.adidas_sales
where Year=2021
group by month
order by Total_Sales desc
limit 5;

-- 9. what are top 5 retailers having more Orders and Sales in 2021

select Retailer,count(Invoice_date) as Orders,sum(Total_sales) as Sales
from projects.adidas_sales
where Year=2021
group by Retailer
order by Orders desc,Sales desc
limit 5;

-- 10. Growth Percentage of sales by each region in the year 2021

select Region,Sales_2021,concat(round(((Sales_2021/Sales_2020)-1)*100,1),' %') as Growth from(
select Region,sum(if(Year=2020,Total_sales,0)) as Sales_2020,sum(if(Year=2021,Total_sales,0)) as Sales_2021
from projects.adidas_sales
group by Region) as Regions;

-- 11. product wise Growth percentage of sales by product in 2021

select Product,Sales_2021,concat(round(((Sales_2021/Sales_2020)-1)*100,1),' %') as Growth from(
select Product,sum(if(Year=2020,Total_sales,0)) as Sales_2020,sum(if(Year=2021,Total_sales,0)) as Sales_2021
from projects.adidas_sales
group by Product) as Products;

-- 12. Region wise percentage increase of orders in the year 2021

select Region,orders_2021,concat(round(((orders_2021/orders_2020)-1)*100,1),' %') as Growth from (select Region,sum(if(Year=2020,1,0)) as orders_2020,sum(if(Year=2021,1,0)) as orders_2021
from projects.adidas_sales
group by Region) as orders;

-- 13. Month wise Growth percentage of orders in 2021

select month,orders_2021,concat(round(((orders_2021/orders_2020)-1)*100,1),' %') as Growth from (select month,sum(if(Year=2020,1,0)) as orders_2020,sum(if(Year=2021,1,0)) as orders_2021
from projects.adidas_sales
group by month) as orders;

-- 14. month wise Growth percentage of sales in 2021

select month,Sales_2021,concat(round(((Sales_2021/Sales_2020)-1)*100,1),' %') as Growth from(
select month,sum(if(Year=2020,Total_sales,0)) as Sales_2020,sum(if(Year=2021,Total_sales,0)) as Sales_2021
from practise.adidas_sales
group by month) as sales;

-- 15.  growth of orders by different sales methods in 2021

select Sales_method,orders_2021,concat(round(((orders_2021/orders_2020)-1)*100,1),' %') as Growth from (select Sales_method,sum(if(Year=2020,1,0)) as orders_2020,sum(if(Year=2021,1,0)) as orders_2021
from projects.adidas_sales
group by Sales_method) as orders;

-- 16. Month wise best selling products in 2021

select month,Product from (select *,rank() over(partition by month order by Sales desc) as rank1 from(
select month,Product,count(Total_sales) as Sales
from practise.adidas_sales
where Year=2021
group by month,Product) as t
order by month) t
where rank1=1;

-- 17. Region wise best selling Products in 2021

select Region,Product,Sales,rank1 as place from (select *,rank() over(partition by Region order by Sales desc) as rank1 from(
select Region,Product,sum(Total_sales) as Sales
from projects.adidas_sales
where Year=2021
group by Region,Product) as t
order by Region) t
where rank1=1 or rank1=2;

-- 18. Region wise Profit statistics in 2021

select Region,sum(Price_per_unit) as Price_per_Unit,sum(Operating_profit) as Operating_profit,sum(Operating_margin) as Opearating_Margin
from projects.adidas_sales
where Year=2021
group by Region
order by Operating_profit desc;

-- 19. Top 5 cities with maximum profit in 2021

select City,sum(Units_sold) as Units_Sold,sum(Operating_profit) as Operating_Profit
from projects.adidas_sales
where Year=2021
group by City
order by Operating_Profit desc
limit 5;

-- 20. Top 5 Products with maximum profit in 2021

select Product,sum(Units_sold) as Units_Sold,sum(Operating_profit) as Operating_Profit
from projects.adidas_sales
where Year=2021
group by Product
order by Operating_Profit desc
limit 5;



