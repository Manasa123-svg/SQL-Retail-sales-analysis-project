
--retail sales analysis project

  create database retail_sales;
  
  create table retail_sales(
  transactions_id int primary key,
  sale_date date,
  sale_time time,
  customer_id int,
  gender varchar(10),
  age int,
  category varchar(20),
  quantiy int,
  price_per_unit int,
  cogs float,
  total_sale int
  )

  select * from retail_sales;

--find the total records

  select count(*) from retail_sales

--find the null values

  select *
  from retail_sales
  where
  transactions_id is null
  or
  sale_date is null
  or
  sale_time is null
  or
  customer_id is null
  or
  gender is null
  or
  age is null
  or
  category is null
  or
  quantiy is null
  or
  price_per_unit is null
  or
  cogs is null
  or
  total_sale is null

--remove the null values

  delete 
  from retail_sales
  where
  transactions_id is null
  or
  sale_date is null
  or
  sale_time is null
  or
  customer_id is null
   or
  gender is null
  or
  age is null
  or
  category is null
  or
  quantiy is null
  or
  price_per_unit is null
  or
  cogs is null
  or
  total_sale is null

-- after delete check the toatl rows

   select count(*) from retail_sales

   select * from retail_sales

-- Data Exploration

-- How many sales we have?

   select count(*) as total_sales from retail_sales;

-- How many uniuque customers we have ?

   select count (distinct customer_id) as total_customers from retail_sales

---find unique category we have

   select distinct category from  retail_sales

-- Data Analysis & Business Key Problems 

-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

	select * from retail_sales
	where sale_date='2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022

	select * from retail_sales
	where
	category='Clothing'
	and
	quantiy >2
	and
	to_char(sale_date,'YYYY-MM')='2022-11'
	
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

	select 
	category,
	count(*) as total_sale
	from retail_sales
	group by category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

	select 
	cast(avg(age) as int) as average_age
	from retail_sales
	where
	category='Beauty'
	
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

	select * from retail_sales
	where total_sale >1000;
	
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

	select
	category,
	gender,
	count(*) as total_transactions
	from retail_sales
	group by 1,2
	

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

	select
	  year,
	  month,
	  average_sale
	from
	(
	select
	    extract(year from sale_date) as year,
	    extract(month from sale_date) as month,
	    cast(avg(total_sale) as int) as average_sale,
		rank() over(partition by extract(year from sale_date) order by  cast(avg(total_sale) as int) desc ) as rk
	    from retail_Sales
	    group by 1,2) as x
		where rk =1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

	select 
	customer_id,
	sum(total_Sale)
	from retail_sales
	group by 1
	order by 2 desc
	limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

	select 
	category,
	count(distinct customer_id) as unique_customers
	from retail_sales
	group by 1

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
 
  with hourliy_sales as
  (
  SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
    FROM retail_sales)
    select
    shift,
    count(*) as total_orders
    from hourliy_sales
    group by 1

---end
