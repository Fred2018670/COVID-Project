--Total Cases Vs Total Deaths Percentage for continents & world
-- shows likelihood of dying if you contract covid in these countries

select country, nullif(sum(new_deaths),0) as TotalDeaths, nullif(sum(new_cases),0) as TotalCases, Round((nullif(sum(new_deaths),0)/nullif(sum(new_cases),0))*100,2) as DeathPercentage
from CovidDeaths$
where country like '%Canada%'
	or country like '%Australia%'
	or country like '%Kenya%'
group by country
order by 1,2

--from above adjust countries to continents

select country, population, nullif(sum(new_deaths),0) as TotalDeaths, nullif(sum(new_cases),0) as TotalCases, Round((nullif(sum(new_deaths),0)/nullif(sum(new_cases),0))*100,2) as DeathPercentage,Round((nullif(sum(new_cases),0)/population)*100,2) as InfectedPercentage
from CovidDeaths$
where country not like '%North America%'
	or country not like '%Europe%'
	or country not like '%Asia%'
	or country not like '%South America%'
	or country not like '%Africa%'
	or country not like '%Australia%'
	or country not like '%world%'
group by country,population
order by 1,2

select country, population, nullif(sum(new_deaths),0) as TotalDeaths, nullif(sum(new_cases),0) as TotalCases, Round((nullif(sum(new_deaths),0)/nullif(sum(new_cases),0))*100,2) as DeathPercentage,Round((nullif(sum(new_cases),0)/population)*100,2) as InfectedPercentage
from CovidDeaths$
where country like '%North America%'
	or country like '%Europe%'
	or country like '%Asia%'
	or country like '%South America%'
	or country like '%Africa%'
	or country like '%Australia%'
	or country like '%world%'
group by country,population
order by 1,2

create view TotalcasesTotaldeathsDeathpercentageInfectedpercentagebycountry as
select country, population, nullif(sum(new_deaths),0) as TotalDeaths, nullif(sum(new_cases),0) as TotalCases, Round((nullif(sum(new_deaths),0)/nullif(sum(new_cases),0))*100,2) as DeathPercentage,Round((nullif(sum(new_cases),0)/population)*100,2) as InfectedPercentage
from CovidDeaths$
where country not like '%North America%'
	or country not like '%Europe%'
	or country not like '%Asia%'
	or country not like '%South America%'
	or country not like '%Africa%'
	or country not like '%Australia%'
	or country not like '%world%'
group by country,population
--order by 1,2

select *
from TotalcasesTotaldeathsDeathpercentageInfectedpercentagebycountry

create view TotalcasesTotaldeathsDeathpercentageInfectedpercentagebyContinent as
select country, population, nullif(sum(new_deaths),0) as TotalDeaths, nullif(sum(new_cases),0) as TotalCases, Round((nullif(sum(new_deaths),0)/nullif(sum(new_cases),0))*100,2) as DeathPercentage,Round((nullif(sum(new_cases),0)/population)*100,2) as InfectedPercentage
from CovidDeaths$
where country like '%North America%'
	or country like '%Europe%'
	or country like '%Asia%'
	or country like '%South America%'
	or country like '%Africa%'
	or country like '%Australia%'
	or country like '%world%'
group by country,population
--order by 1,2

select*
from TotalcasesTotaldeathsDeathpercentageInfectedpercentagebyContinent
