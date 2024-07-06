use portfolio_project;
show tables;
drop table sales_backup;
select * from walmart_sales_modified;
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
select min(temperature) from walmart_sales_modified;
select max(temperature) from walmart_sales_modified;
-- kpi 1 : which store has the maximum sales
select store
from walmart_sales_modified 
group by store
order by sum(weekly_sales) desc limit 1;
-- ans: store 20

-- kpi 2: what was the maximum sales that the store had?
select max(weekly_sales) from walmart_sales_modified;
-- ans : 3818686.45

-- kpi 3: Which store has the highest air temperature?
select temperature, store from walmart_sales_modified order by temperature desc limit 1;
-- ans : store 33 and temperature 100.14

-- kpi 4: Top 5 and Bottom 5 stores

-- top 5
select store
from walmart_sales_modified 
group by store
order by sum(weekly_sales) desc limit 5;
-- ans : 20, 4, 14, 13, 2

-- bottom 5
select store
from walmart_sales_modified 
group by store
order by sum(weekly_sales) asc limit 5;
-- ans : 33, 44, 5, 36, 38


-- kpi 5: Understanding the relationship between temperature and sales

-- top 5 stores vs temperature
select store, temperature
from walmart_sales_modified 
group by store
order by sum(weekly_sales)desc limit 5;
-- ans: 20 - 25.92, 4 - 43.76, 14 - 27.31, 13 - 31.53, 2 - 40.19

-- bottom 5 stores vs temperature
select store, temperature
from walmart_sales_modified 
group by store
order by sum(weekly_sales)asc limit 5;
-- ans : 33 - 58.4, 44 - 31.53, 5 - 39.7, 36 - 45.97, 38 - 49.47

-- correlation 1: correlation between sales and temperature
SELECT
    (
        (COUNT(*) * SUM(temperature * weekly_sales)) - (SUM(temperature) * SUM(weekly_sales))
    ) / (
        SQRT((COUNT(*) * SUM(temperature * temperature)) - (SUM(temperature) * SUM(temperature)))
        * SQRT((COUNT(*) * SUM(weekly_sales * weekly_sales)) - (SUM(weekly_sales) * SUM(weekly_sales)))
    ) AS correlation_coefficient
   FROM walmart_sales_modified;
    
-- ans: A correlation value of -0.06381001317946293 indicates that there is a weak negative correlation between temperature and sales.

-- kpi 6 : Understanding the relationship between fuel price and sales
SELECT
    (
        (COUNT(*) * SUM(fuel_price* weekly_sales)) - (SUM(fuel_price) * SUM(weekly_sales))
    ) / (
        SQRT((COUNT(*) * SUM(fuel_price * fuel_price)) - (SUM(fuel_price) * SUM(fuel_price)))
        * SQRT((COUNT(*) * SUM(weekly_sales * weekly_sales)) - (SUM(weekly_sales) * SUM(weekly_sales)))
    ) AS correlation_coefficient
   FROM walmart_sales_modified;

-- ans : A correlation value of 0.009463786314503278 indicates that there is a weak positive correlation between fuel price and sales.


-- kpi 7 : Understanding the relationship between CPI and sales
SELECT
    (
        (COUNT(*) * SUM(CPI* weekly_sales)) - (SUM(CPI) * SUM(weekly_sales))
    ) / (
        SQRT((COUNT(*) * SUM(CPI * CPI)) - (SUM(CPI) * SUM(CPI)))
        * SQRT((COUNT(*) * SUM(weekly_sales * weekly_sales)) - (SUM(weekly_sales) * SUM(weekly_sales)))
    ) AS correlation_coefficient
   FROM walmart_sales_modified;

-- ans : A correlation value of -0.07263416204017244 indicates that there is a weak negative correlation between CPI and sales.

-- kpi 8 : Understanding the relationship between holiday_flag and sales
SELECT
    (
        (COUNT(*) * SUM(Holiday_Flag* weekly_sales)) - (SUM(Holiday_Flag) * SUM(weekly_sales))
    ) / (
        SQRT((COUNT(*) * SUM(holiday_flag * holiday_flag)) - (SUM(holiday_flag) * SUM(holiday_flag)))
        * SQRT((COUNT(*) * SUM(weekly_sales * weekly_sales)) - (SUM(weekly_sales) * SUM(weekly_sales)))
    ) AS correlation_coefficient
   FROM walmart_sales_modified;
   
-- ans : A correlation value of 0.036890968010413944 indicates that there is a weak positive correlation between holiday_flag and sales.

-- kpi 9:  Understanding the relationship between unemployment rate and sales
SELECT
    (
        (COUNT(*) * SUM(unemployment * weekly_sales)) - (SUM(unemployment ) * SUM(weekly_sales))
    ) / (
        SQRT((COUNT(*) * SUM(unemployment  * unemployment )) - (SUM(unemployment ) * SUM(unemployment )))
        * SQRT((COUNT(*) * SUM(weekly_sales * weekly_sales)) - (SUM(weekly_sales) * SUM(weekly_sales)))
    ) AS correlation_coefficient
   FROM walmart_sales_modified;
   
-- ans : A correlation value of -0.10617608965796825 indicates that there is a weak negative correlation between unemployment rate and sales


