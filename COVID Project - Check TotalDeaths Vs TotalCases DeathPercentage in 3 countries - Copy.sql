--Total Cases Vs Total Deaths Percentage for multiple countries
-- shows likelihood of dying if you contract covid in these countries

select country, date, total_cases, total_deaths, Round ((nullif(total_deaths,0)/nullif(total_cases,0)*100),2) AS DeathPercentage
from [Project Portfolio]..CovidDeaths
where country like '%Canada%'
	or country like '%Australia%'
	or country like '%Kenya%'
order by 1,2

Create view TotalDeathsTotalCasesDeathPercetageinCanAusKen as
select country, date, total_cases, total_deaths, Round ((nullif(total_deaths,0)/nullif(total_cases,0)*100),2) AS DeathPercentage
from [Project Portfolio]..CovidDeaths
where country like '%Canada%'
	or country like '%Australia%'
	or country like '%Kenya%'
--order by 1,2

select *
from TotalDeathsTotalCasesDeathPercetageinCanAusKen
