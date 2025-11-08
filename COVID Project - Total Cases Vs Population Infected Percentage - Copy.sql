-- looking at total cases  versus population in a specific country. used Kenya as example

select country, date,population,total_cases, Round ((nullif(total_cases,0)/nullif(population,0)*100),2) AS InfectedPercentage
from CovidDeaths$
where country like '%Kenya%'
order by 1,2

select country, date,population,total_cases, Round ((nullif(total_cases,0)/nullif(population,0)*100),2) AS InfectedPercentage
from CovidDeaths$
where country like '%Australia%'
order by 1,2

select country, date,population,total_cases, Round ((nullif(total_cases,0)/nullif(population,0)*100),2) AS InfectedPercentage
from CovidDeaths$
where country like '%Canada%'
order by 1,2

select country, date,population,total_cases, Round ((nullif(total_cases,0)/nullif(population,0)*100),2) AS CanAusKenInfectedPercentage
from CovidDeaths$
where country like '%Canada%'
	or country like '%Australia%'
	or country like '%Kenya%'
order by 1,2


Create view CanAusKenInfectedPercentage as
select country, date,population,total_cases, Round ((nullif(total_cases,0)/nullif(population,0)*100),2) AS CanAusKenInfectedPercentage
from CovidDeaths$
where country like '%Canada%'
	or country like '%Australia%'
	or country like '%Kenya%'
--order by 1,2

Select *
From CanAusKenInfectedPercentage
