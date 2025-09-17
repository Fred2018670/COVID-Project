--Joining the two tables

select *
from [Project Portfolio]..CovidDeaths dea
join [Project Portfolio]..CovidVaccinations vac
	on dea.country = vac.country
	and dea.date = vac.date

-- looking at Total Population Vs Total Vaccinations

select dea.country,dea.date,dea.population,vac.new_vaccinations
from [Project Portfolio]..CovidDeaths dea
join [Project Portfolio]..CovidVaccinations vac
	on dea.country = vac.country
	and dea.date = vac.date
order by 1,2

-- we can use partition so that the querry does not repeat unnecessarily then sum up vaccinations by country and analyze vaccination rate
-- after partition we order by so that we can show how each new vacination is added to the cummulative number consequtively and ignores nulls

	SELECT 
    dea.country,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM (cast(nullif(vac.new_vaccinations,'0') as float)) OVER (PARTITION BY dea.country order by dea.country,dea.date) AS cumulative_vaccinations,
    SUM (cast(nullif(vac.new_vaccinations,'0') as float)) OVER (PARTITION BY dea.country order by dea.country,dea.date) * 1.0 / (dea.population) AS vaccination_rate
FROM 
    [Project Portfolio]..CovidDeaths dea
JOIN 
    [Project Portfolio]..CovidVaccinations vac
    ON dea.country = vac.country
    AND dea.date = vac.date
ORDER BY 
    dea.country, dea.date;

	--if you want to check the max cummulative number / population, then you have 2 options. one is to use a CTE

	-- Option 1 Use a CTE

	With popvsvac (country,date,population,new_vaccinations,cumulative_vaccinations,vaccination_rate)
	As
	(
		SELECT 
    dea.country,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM (cast(nullif(vac.new_vaccinations,'0') as float)) OVER (PARTITION BY dea.country order by dea.country,dea.date) AS cumulative_vaccinations,
    SUM (cast(nullif(vac.new_vaccinations,'0') as float)) OVER (PARTITION BY dea.country order by dea.country,dea.date) * 1.0 / (dea.population) AS vaccination_rate
FROM 
    [Project Portfolio]..CovidDeaths dea
JOIN 
    [Project Portfolio]..CovidVaccinations vac
    ON dea.country = vac.country
    AND dea.date = vac.date
--ORDER BY dea.country, dea.date
	)
	select *, (cumulative_vaccinations/population)*100 as popvaccpercentage
	from popvsvac

	create view CummulativeVaccinationsPercentageVsPopulation as
	With popvsvac (country,date,population,new_vaccinations,cumulative_vaccinations,vaccination_rate)
	As
	(
		SELECT 
    dea.country,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM (cast(nullif(vac.new_vaccinations,'0') as float)) OVER (PARTITION BY dea.country order by dea.country,dea.date) AS cumulative_vaccinations,
    SUM (cast(nullif(vac.new_vaccinations,'0') as float)) OVER (PARTITION BY dea.country order by dea.country,dea.date) * 1.0 / (dea.population) AS vaccination_rate
FROM 
    [Project Portfolio]..CovidDeaths dea
JOIN 
    [Project Portfolio]..CovidVaccinations vac
    ON dea.country = vac.country
    AND dea.date = vac.date
--ORDER BY dea.country, dea.date
	)
	select *, (cumulative_vaccinations/population)*100 as popvaccpercentage
	from popvsvac

	select *
	from CummulativeVaccinationsPercentageVsPopulation
