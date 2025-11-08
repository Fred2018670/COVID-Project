select *
from CovidDeaths$
order by 1,2

select *
from CovidVaccinations$
order by 1,2

--orders column by country then by date columns

select country, Max(total_deaths) as TotalDeathCount
from CovidDeaths$
group by country
Order by TotalDeathCount desc
