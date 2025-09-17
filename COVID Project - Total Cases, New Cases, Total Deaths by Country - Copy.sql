select country, date,total_cases,new_cases,total_deaths,population
from [Project Portfolio]..CovidDeaths
order by 1,2

--When using ORDER BY 1, 2, 3, we're instructing the database to sort the results based on the first, second, and third columns in the SELECT list.

Create view TotalcasesNewCasesTotaldeathsbycountry as
select country, date,total_cases,new_cases,total_deaths,population
from [Project Portfolio]..CovidDeaths
--order by 1,2

select *
from TotalcasesNewCasesTotaldeathsbycountry
