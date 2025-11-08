--if you want to check the max cummulative number / population, then you have 2 options. one is to use a CTE or Temp table
-- if you want the MAX numbers by country you would have to remove the date to apply the MAX

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
   CovidDeaths$ dea
JOIN 
    CovidVaccinations$ vac
    ON dea.country = vac.country
    AND dea.date = vac.date
--ORDER BY dea.country, dea.date
	)
	select *, (cumulative_vaccinations/population)*100 as popvaccpercentage
	from popvsvac

	-- Option 2 Usinq a Temp Table

	
	Create table #PercentPopulationVaccinated
	(
	Country nvarchar (255),
	Date datetime,
	Population numeric,
	New_Vaccinations numeric,
	Cumulative_Vaccinations numeric,
	Vaccination_Rate numeric
	);
	Insert into #PercentPopulationVaccinated
SELECT 
    dea.country,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM (cast(nullif(vac.new_vaccinations,'0') as float)) OVER (PARTITION BY dea.country order by dea.country,dea.date) AS cumulative_vaccinations,
    SUM (cast(nullif(vac.new_vaccinations,'0') as float)) OVER (PARTITION BY dea.country order by dea.country,dea.date) * 1.0 / (dea.population) AS vaccination_rate
FROM 
    CovidDeaths$ dea
JOIN 
    CovidVaccinations$ vac
    ON dea.country = vac.country
    AND dea.date = vac.date
--ORDER BY dea.country, dea.date
	
	select *, (cumulative_vaccinations/population)*100 as popvaccpercentage
	from #PercentPopulationVaccinated


	--if you want to make an alteration in the table, remember since the temp table is existing you have to use DROP if table exists then make the alteration

	Drop Table if exists #PercentPopulationVaccinated
	Create table #PercentPopulationVaccinated
	(
	Country nvarchar (255),
	Date datetime,
	Population numeric,
	New_Vaccinations numeric,
	Cumulative_Vaccinations numeric,
	Vaccination_Rate numeric
	);
	Insert into #PercentPopulationVaccinated
SELECT 
    dea.country,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM (cast(nullif(vac.new_vaccinations,'0') as float)) OVER (PARTITION BY dea.country order by dea.country,dea.date) AS cumulative_vaccinations,
    SUM (cast(nullif(vac.new_vaccinations,'0') as float)) OVER (PARTITION BY dea.country order by dea.country,dea.date) * 1.0 / (dea.population) AS vaccination_rate
FROM 
    CovidDeaths$ dea
JOIN 
    CovidVaccinations$ vac
    ON dea.country = vac.country
    AND dea.date = vac.date
--ORDER BY dea.country, dea.date
	
	select *, (cumulative_vaccinations/population)*100 as popvaccpercentage
	from #PercentPopulationVaccinated


--Creating a view to store data for later visualizations

Create view PercentPopulationVaccinated as
		SELECT 
    dea.country,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM (cast(nullif(vac.new_vaccinations,'0') as float)) OVER (PARTITION BY dea.country order by dea.country,dea.date) AS cumulative_vaccinations,
    SUM (cast(nullif(vac.new_vaccinations,'0') as float)) OVER (PARTITION BY dea.country order by dea.country,dea.date) * 1.0 / (dea.population) AS vaccination_rate
FROM 
    CovidDeaths$ dea
JOIN 
    CovidVaccinations$ vac
    ON dea.country = vac.country
    AND dea.date = vac.date
--ORDER BY dea.country, dea.date

Select *
From PercentPopulationVaccinated

-- the view above from the create query is permanent and can be used for visualizations. Once not required it needs to be dropped off

-- hereafter we need to go to the queries generated then create views for each so that they can be used for visualizations





