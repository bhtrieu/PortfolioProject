--For creating views
USE PortfolioProject
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--
--
--Cases statistic 
--
--

--Percentage of population that got covid for a country over time
select location, date, total_cases, population, (total_cases/population) * 100 as percentage_of_population_infected
from PortfolioProject..CovidDeaths
where continent is not null
order by location, date

--List of countries and the percentage of their population that has covid in descending order
select location, MAX(total_cases) as max_cases, population, MAX(total_cases/population) * 100 as percentage_of_population_infected
from PortfolioProject..CovidDeaths
where continent is not null
group by location, population
order by percentage_of_population_infected desc

--List of countries with most cases in descending order
select location, MAX(total_cases) as max_cases
from PortfolioProject..CovidDeaths
where continent is not null
group by location
order by max_cases desc

--Continents with the most cases in descending order
select location, MAX(total_cases) as max_cases
from PortfolioProject..CovidDeaths
where continent is null
group by location
order by max_cases desc

--
--
--Death statistics
--
--

--Percentage of people that had covid and died for a country over time
select location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as death_percentage
from PortfolioProject..CovidDeaths
where continent is not null
order by location, date


--List of countries and percentage of covid deaths in descending order
with country_deaths(location, max_deaths, max_cases)
as
(
select location, MAX(cast(total_deaths as int)) as max_deaths, MAX(total_cases) as max_cases 
from PortfolioProject..CovidDeaths
where continent is not null
group by location
)
select *, (max_deaths/max_cases) * 100 as covid_death_percentage
from country_deaths
order by covid_death_percentage desc

--List of countries with most deaths in descending order
select location, MAX(cast(total_deaths as int)) as max_deaths
from PortfolioProject..CovidDeaths
where continent is not null
group by location
order by max_deaths desc

--Continents with the most deaths in descending order
select location, MAX(cast(total_deaths as int)) as max_deaths
from PortfolioProject..CovidDeaths
where continent is null
group by location
order by max_deaths desc

--
--
--Vaccination statistics
--
--

--Countries with most people vaccinated
select location, MAX(cast(total_vaccinations as int)) as people_vaccinated
from PortfolioProject..CovidVaccinations
where continent is not null
group by location
order by people_vaccinated desc

--Countries with most fully people vaccinated
select location, MAX(cast(people_fully_vaccinated as int)) as max_fully_vaccinated
from PortfolioProject..CovidVaccinations
where continent is not null
group by location
order by max_fully_vaccinated desc

--Continents with most vaccinated
select location, MAX(cast(total_vaccinations as float)) as max_vaccinations
from PortfolioProject..CovidVaccinations
where continent is null
group by location
order by max_vaccinations desc


--
--
--GLOBAL NUMBERS
--
--

--Global cases and deaths
select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as global_death_percentage
from PortfolioProject..CovidDeaths
where continent is not null


--
--
--VIEWS
--
--

GO

--Total cases vs Population view
CREATE VIEW country_total_cases AS
select location, date, total_cases, population, (total_cases/population) * 100 as percentage_infected
from PortfolioProject..CovidDeaths
where continent is not null

GO

--Total deaths vs Total cases view
create view country_total_deaths as 
select location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as death_percentage
from PortfolioProject..CovidDeaths
where continent is not null

GO

--List of countries with most cases view
create view country_max_cases as
select location, MAX(total_cases) as max_cases
from PortfolioProject..CovidDeaths
where continent is not null
group by location

GO

--List of countries with most deaths views
create view country_max_deaths as
select location, MAX(cast(total_deaths as int)) as max_deaths
from PortfolioProject..CovidDeaths
where continent is not null
group by location
