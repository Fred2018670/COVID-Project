select country, date,total_cases,new_cases,total_deaths,population
from [Project Portfolio]..CovidDeaths
order by 1,2

--looking at Total Cases Vs Total Deaths
 --first remove the division error

 WITH DeathRatio AS (
 SELECT 
	CASE
		WHEN total_cases = 0 then null
	ELSE (total_deaths/total_cases)*100
	END AS DeathPercentage
FROM [Project Portfolio]..CovidDeaths
)
 WITH DeathPercentage AS (
	SELECT *
	FROM [Project Portfolio]..CovidDeaths
	WHERE isnull (total_deaths/nullif(total_cases,0)*100,0 ) = DeathPercentage
	)

USE [Project Portfolio]..CovidDeaths;
GO
 WITH DeathRatio AS (
 SELECT 
	CASE
		WHEN total_cases = 0 then null
	ELSE (total_deaths/total_cases)*100
	END AS DeathPercentage
FROM [Project Portfolio]..CovidDeaths
)
SELECT total_cases, total_deaths, DeathPercentage
FROM	DeathRatio

SELECT country, date, total_cases, total_deaths, DeathPercentage
FROM [Project Portfolio]..CovidDeaths
ORDER BY 1,2

-- 31st may trial
select country, date,total_cases,total_deaths,(total_deaths/nullif(total_cases,0)
from [Project Portfolio]..CovidDeaths
order by 1,2
---- STILL IN PROGRESS