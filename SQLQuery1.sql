select * from pizza;


------KPI-------
--Total_Revenue
select sum(total_price) as Total_Revenue from pizza;
;
--Average order value
select (sum(total_price)/count(Distinct order_Id)) as Average_Order_Value from pizza;

--Total Pizzas sold
select sum(quantity) as total_Pizzas_sold from pizza;

--Total Orders 
select count(distinct order_id ) as Total_order from pizza;

--Average pizza per order 
select cast(cast(sum(quantity) as Decimal(10,2)) / cast (count(Distinct order_id) as Decimal(10,2)) as Decimal(10,2)) as average_pizza_sold from pizza;


-----Analysis--------

--Daily Trend of the orders
select datename(dw,order_date) as order_day , count(Distinct order_id) as Total_orders
from pizza
group by datename(dw,order_date)
order by Total_orders desc;

--Monthly trend of the orders
select datename (month,order_date) as orders_per_month, count(Distinct order_id) as Total_orders 
from pizza
group by datename(month,order_date)
order by Total_orders desc;


--percentage of sales by pizza category 
select pizza_category,sum(Total_price) as Total_sales ,  sum(total_price)* 100 / (select sum(total_price) from pizza) as percentage_of_sale 
from pizza 
group by pizza_category
order by Total_sales desc;

--for different month (1 for january 4 for april)
select pizza_category,sum(Total_price) as Total_sales ,  sum(total_price)* 100 / (select sum(total_price) from pizza where month(order_date) =4) as percentage_of_sale 
from pizza 
where month(order_date) =4
group by pizza_category
order by Total_sales desc;

--percentage of sales by pizza size
select pizza_size, cast(sum(total_price) as Decimal(10,2)) as Total_sales,
cast(sum(total_price)*100/(select sum(total_price) from pizza) as Decimal(10,2)) as Percentage_of_sale
from pizza
group by pizza_size
order by Total_sales desc;

--percentage of sales by pizza size for first quarter----
select pizza_size, cast(sum(total_price) as Decimal(10,2)) as Total_sales,
cast(sum(total_price)*100/(select sum(total_price) from pizza where datepart(quarter,order_date)=1) as Decimal(10,2)) as Percentage_of_sale
from pizza
where datepart(quarter,order_date)=1
group by pizza_size
order by Total_sales desc;


--------Top 5 best sellers by revenue,total quantity, total orders--------
 

--By revenue

--Top 5
select Top 5 pizza_name, sum(total_price) as Total_sale 
from pizza
group by pizza_name
order by Total_sale desc ;
--Bottom 5
select Top 5 pizza_name, sum(total_price) as Total_sale 
from pizza
group by pizza_name
order by Total_sale  ;


--By quantity 

--Top 5
select Top 5 pizza_name, sum(quantity) as Total_quantity
from pizza
group by pizza_name
order by Total_quantity desc ;
--Bottom 5
select Top 5 pizza_name, sum(quantity) as Total_quantity
from pizza
group by pizza_name
order by Total_quantity  ;

--By orders

--Top 5
select Top 5 pizza_name, sum(distinct(order_id )) as Total_orders
from pizza
group by pizza_name
order by Total_orders desc ;
--Bottom 5
select Top 5 pizza_name, sum(distinct(order_id )) as Total_orders
from pizza
group by pizza_name
order by Total_orders  ;