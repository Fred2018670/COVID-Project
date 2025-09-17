-- looking at countries with highest infection rate compared to population
-- we need to remove the date and add Max in total then add group by and finally use the infected percentage as the ranker

select country, date,population,total_cases, Round ((nullif(total_cases,0)/nullif(population,0)*100),2) AS InfectedPercentage
from [Project Portfolio]..CovidDeaths
where country like '%Kenya%'
order by 1,2

-- after the adjustments, the query is as below

select country, population,Max(total_cases) as HighestInfectionCount, Max(Round ((nullif(total_cases,0)/nullif(population,0)*100),2)) AS InfectedPercentage
from [Project Portfolio]..CovidDeaths
--where country like '%Kenya%'
group by country, population
order by InfectedPercentage desc

--countries with highest death count
-- note column for total_deaths is fed as float, need to cast this as int

select country, Max(cast (total_deaths as int)) as TotalDeathCount
from [Project Portfolio]..CovidDeaths
--where country like '%Kenya%'
group by country
order by TotalDeathCount desc

Create view CountriesInfectedPercentage as
select country, population,Max(total_cases) as HighestInfectionCount, Max(Round ((nullif(total_cases,0)/nullif(population,0)*100),2)) AS InfectedPercentage
from [Project Portfolio]..CovidDeaths
--where country like '%Kenya%'
group by country, population
--order by InfectedPercentage desc

select *
from CountriesInfectedPercentage