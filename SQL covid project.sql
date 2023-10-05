select * from africa;
select * from asia;
select * from europe;
select * from north_america;
select * from oceania;
select * from other;
select * from south_america;

 
 -- 1..  Origin continent of covid

Select * from (select continent, month(date), max(total_cases)
from africa where year(date)=2020 
group by continent, month(date) order by 3 limit 1) as Africa_2020
union
select * from (select continent,  month(date), max(total_cases)
from asia where year(date)=2020 
group by continent, month(date) order by 2 limit 1) as Asia_2020
union
select * from (select continent, month(date), max(total_cases) 
from europe where year(date)=2020 
group by continent, month(date) order by 3 limit 1) as Europe_2020
union
select * from (select continent,  month(date), max(total_cases) 
from north_america where year(date)=2020 
group by continent, month(date) order by 3 limit 1) as north_america_2020
union
select * from (select continent, month(date), max(total_cases) 
from oceania where year(date)=2020 
group by continent, month(date) order by 3 limit 1) as oceania_2020
union
select * from (select continent, month(date), max(total_cases) 
from south_america where year(date)=2020 
group by continent,  month(date) order by 3 limit 1) as south_america_2020;

-- 2. spread started from china
 select location, max(Total_cases) from asia where location != 'Asia' AND year(date)=2020 AND month(date)=1
 group by location order by 2 desc limit 5; 
 
 -- 3. Continent with maximum cases

SELECT continent, total_cases FROM Africa WHERE total_cases = (SELECT MAX(total_cases) FROM Africa)
UNION
SELECT continent, total_cases FROM Asia WHERE  total_cases = (SELECT MAX(total_cases) FROM Asia)
UNION
SELECT continent, total_cases FROM Europe WHERE  total_cases  = (SELECT MAX(total_cases) FROM Europe)
UNION
SELECT continent, total_cases FROM North_america  WHERE  total_cases  = (SELECT MAX(Total_cases) FROM North_america)
UNION
SELECT continent, total_cases FROM Oceania WHERE  total_cases = (SELECT MAX(total_cases) FROM Oceania)
UNION
SELECT continent, total_cases FROM south_america WHERE  total_cases  = (SELECT MAX(total_cases) FROM south_america) 
order by total_cases desc;
 
 -- 4. Maximum cases location from Europe
 select location, max(Total_cases) from Europe where location != 'Europe'
 group by location order by 2 desc limit 5; 
 
 -- 5. Total deaths worldwide by continents
 SELECT continent, total_deaths FROM Africa WHERE total_deaths = (SELECT MAX(total_deaths) FROM Africa)
UNION
 SELECT continent, total_deaths FROM Asia WHERE total_deaths = (SELECT MAX(total_deaths) FROM Asia)
UNION
 SELECT continent, total_deaths FROM Europe WHERE total_deaths = (SELECT MAX(total_deaths) FROM Europe)
UNION
 SELECT continent, total_deaths FROM North_america WHERE total_deaths = (SELECT MAX(total_deaths) FROM North_america) 
 UNION
 SELECT continent, total_deaths FROM Oceania WHERE total_deaths = (SELECT MAX(total_deaths) FROM Oceania)
UNION
 SELECT continent, total_deaths FROM south_america WHERE total_deaths = (SELECT MAX(total_deaths) FROM south_america) 
order by total_deaths desc;
 
 -- 6. total_deaths over timeline of 3 years
select location, year(date), total_deaths, month(date) from other where location='world' 
 group by location, total_deaths, month(date), year(date);
 
 -- 7. number of toatl_cases and smokers comparison
 select * from (select continent, max(total_cases), max(female_smokers)+ max(male_smokers) as smokers
 from africa group by continent) as asiatd
  union
 select * from (select continent, max(total_cases), max(female_smokers)+ max(male_smokers) as smokers
 from asia group by continent) as asiatd
  union
  select * from (select continent, max(total_cases), max(female_smokers)+ max(male_smokers) as smokers
 from europe group by continent) as asiatd
 union
 select * from (select continent, max(total_cases), max(female_smokers)+ max(male_smokers) as smokers
 from north_america group by continent) as asiatd
 union
  select * from (select continent, max(total_cases),max(female_smokers)+ max(male_smokers) as smokers
 from oceania group by continent) as asiatd
 union
  select * from (select continent, max(total_cases), max(female_smokers)+ max(male_smokers) as smokers
 from south_america group by continent) as asiatd;
 
-- 8. Infections and the older age comparison
select year(date), continent, sum(total_cases), round(sum(((aged_70_older)/100)*population)) 
as 70_older_population from asia group by year(date), continent
union
select year(date), continent, sum(total_cases), round(sum(((aged_70_older)/100)*population)) 
as 70_older_population from africa group by year(date), continent
union
select year(date), continent, sum(total_cases), round(sum(((aged_70_older)/100)*population)) 
as 70_older_population from europe group by year(date), continent
union
select year(date), continent, sum(total_cases), round(sum(((aged_70_older)/100)*population)) 
as 70_older_population from north_america group by year(date), continent
union
select year(date), continent, sum(total_cases), round(sum(((aged_70_older)/100)*population)) 
as 70_older_population from Oceania group by year(date), continent
union
select year(date),  continent, sum(total_cases), round(sum(((aged_70_older)/100)*population)) 
as 70_older_population from south_america group by year(date), continent;

-- 9 Deaths and older age comparsion
select year(date), continent, sum(total_deaths), round(sum(((aged_65_older)/100)*population)) 
as 65_older_population from asia group by year(date),continent
union
select year(date), continent, sum(total_deaths), round(sum(((aged_65_older)/100)*population)) 
as 65_older_population from africa group by year(date), continent
union
select year(date),continent, sum(total_deaths), round(sum(((aged_65_older)/100)*population)) 
as 65_older_population from europe group by year(date), continent
union
select year(date),  continent, sum(total_deaths), round(sum(((aged_65_older)/100)*population)) 
as 65_older_population from north_america group by year(date),  continent
union
select year(date), continent, sum(total_deaths), round(sum(((aged_65_older)/100)*population)) 
as 65_older_population from Oceania group by year(date),  continent
union
select year(date),  continent, sum(total_deaths), round(sum(((aged_65_older)/100)*population)) 
as 65_older_population from south_america group by year(date),  continent;

-- 10 Total tests, Total cases, and Total deaths by continents and Years
select * from (select continent, year(date) as Year, max(total_tests) as Total_tests, max(total_cases) 
as Total_cases, max(total_deaths) as Total_deaths
from africa group by continent, year(date) order by 1) as africa
union
select * from(select continent, year(date) as Month, max(total_tests) as Total_tests, max(total_cases) 
as Total_cases, max(total_deaths) as Total_deaths
from asia group by continent, year(date) order by 1) as asia
union
select * from(select continent, year(date),  max(total_tests), max(total_cases), max(total_deaths) 
from  europe group by continent, year(date) order by 1) as europe
union
select * from (select continent, year(date),  max(total_tests), max(total_cases), max(total_deaths) 
from north_america group by continent, year(date) order by 1) as north_america
union
select * from (select  continent, year(date),  max(total_tests), max(total_cases), max(total_deaths) 
from Oceania group by continent, year(date) order by 1) as oceania
union
select * from(select continent, year(date),  max(total_tests), max(total_cases), max(total_deaths) 
from south_america group by continent, year(date) order by 1) as south_america;

-- 11 Total vaccinations by continents
 select year(date), continent, max(total_vaccinations) as Total_vaccinations from africa group by year(date), continent
 union
 select year(date), continent, max(total_vaccinations) from asia group by year(date), continent
 union
 select year(date), continent, max(total_vaccinations) from europe group by year(date), continent
 union
 select year(date), continent, max(total_vaccinations) from north_america group by year(date), continent
 union
 select year(date), continent, max(total_vaccinations) from oceania group by year(date), continent
 union
select year(date), continent, max(total_vaccinations) from south_america group by year(date), continent;

-- 12 Effect of GDP over the covid cases
 SELECT location, MAX(total_cases) / MAX(population) * 100 as spread, max(gdp_per_capita) as gdp_per_capita
FROM covid_data  WHERE continent <> '0'
GROUP by 1;

-- 13 Effect of GDP over the covid deaths

SELECT location, MAX(total_deaths) / MAX(population) * 100 as d_rate, max(gdp_per_capita) as gdp_per_capita
FROM covid_data  WHERE continent <> '0'
GROUP by 1;