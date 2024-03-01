create database Walmart_sales;

create table sales(
invoice_id varchar(30) not null primary key,
branch VARCHAR(5) NOT NULL,
city VARCHAR(30) NOT NULL,
customer_type VARCHAR(30) NOT NULL,
gender VARCHAR(30) NOT NULL,
product_line VARCHAR(100) NOT NULL,
unit_price DECIMAL(10,2) NOT NULL,
quantity INT NOT NULL,
tax_pct FLOAT(6,4) NOT NULL,
total DECIMAL(12, 4) NOT NULL,
date DATETIME NOT NULL,
time TIME NOT NULL,
payment VARCHAR(15) NOT NULL,
cogs DECIMAL(10,2) NOT NULL,
gross_margin_pct FLOAT(11,9),
gross_income DECIMAL(12, 4),
rating FLOAT(2, 1) );

-- ----- Adding new useful columns -- -----
-- Time of the day --
select 
time,(
case 
    when time between "00:00:00" and "12:00:00" then "Morning"
	when time between "12:01:00" and "16:00:00" then "Afternoon"
    else "Evening" 
    end ) as time_of_day 
from sales;

alter table sales add column time_of_day varchar(20);

update sales
set time_of_day = (
case 
    when time between "00:00:00" and "12:00:00" then "Morning"
	when time between "12:01:00" and "16:00:00" then "Afternoon"
    else "Evening" 
    end );
    
-- Day name --
select date, dayname(date) 
from sales;

alter table sales add column day_name varchar(20);

update sales
set day_name = dayname(date) ;

-- Month name --
select date, ( monthname(date))
from sales;

alter table sales add column month_name varchar(20);

update sales
set month_name = ( monthname(date));

              -- Insights --
-- How many unique cities does the data have? --
select distinct city from sales;

-- In which city is each branch? --
select distinct city, branch from sales;

-- How many unique product lines does the data have? --
select distinct product_line from sales;

-- What is the percentage of orders made by males and females ? --
select gender, (count(invoice_id)/995) *100 as Orders from sales
group by gender;

-- What is the percentage of orders made by each payment method ? --
select payment, (count(invoice_id)/995) *100 as Orders from sales
group by payment; 

-- What is the total revenue generated based on the time of day ? --
select sum(total) as Total_revenue, time_of_day from sales
group by time_of_day
order by Total_revenue desc;

-- Which branch has the highest revenue ? --
select sum(total) as Total_revenue, branch from sales
group by branch
order by Total_revenue desc;

