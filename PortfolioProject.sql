--For creating views
USE PortfolioProject
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Primary stats that will we be examining
select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by location, date

--Total cases vs Population
--Percentage of the population that got covid
select location, date, total_cases, population, (total_cases/population) * 100 as percentage_infected
from PortfolioProject..CovidDeaths
where continent is not null
order by location, date

--Total deaths vs Total cases
--Percentage of people that had covid and died
select location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as death_percentage
from PortfolioProject..CovidDeaths
where continent is not null
order by location, date

--List of countries with most cases
select location, MAX(total_cases) as max_cases
from PortfolioProject..CovidDeaths
where continent is not null
group by location
order by max_cases desc

--List of countries with most deaths
select location, MAX(cast(total_deaths as int)) as max_deaths
from PortfolioProject..CovidDeaths
where continent is not null
group by location
order by max_deaths desc

--Countries with highest infection rate
select location, MAX(total_cases) as max_cases, population, MAX(total_cases/population) * 100 as max_infection_rate
from PortfolioProject..CovidDeaths
where continent is not null
group by location, population
order by max_infection_rate desc

--Continents with the most cases
select location, MAX(total_cases) as max_cases
from PortfolioProject..CovidDeaths
where continent is null
group by location
order by max_cases desc

--Continents with the most deaths
select location, MAX(cast(total_deaths as int)) as max_deaths
from PortfolioProject..CovidDeaths
where continent is null
group by location
order by max_deaths desc

--Countries with most vaccinations
select location, MAX(cast(total_vaccinations as int)) as max_vaccinations
from PortfolioProject..CovidVaccinations
where continent is not null
group by location
order by max_vaccinations desc

--Countries with most fully people vaccinated
select location, MAX(cast(people_fully_vaccinated as int)) as max_fully_vaccinated
from PortfolioProject..CovidVaccinations
where continent is not null
group by location
order by max_fully_vaccinated desc

--Continents with most vaccinated
select location, MAX(cast(total_vaccinations as int)) as max_vaccinations
from PortfolioProject..CovidVaccinations
where continent is null
group by location
order by max_vaccinations desc

--Global cases and deaths
select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as global_death_percentage
from PortfolioProject..CovidDeaths
where continent is not null


--VIEWS
--
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
