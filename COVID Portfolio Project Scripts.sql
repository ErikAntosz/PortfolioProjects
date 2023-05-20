Select*
From PortfolioProject..CovidDeaths
Where continent is not null
order by 3,4

--Select*
--From PortfolioProject..CovidVaccinations
--order by 3,4

--Select data I am going to be using

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Where continent is not null
order by 1,2


--Looking at the total case vs total deaths
--Shows the likelihood of dying if you contact COVID in the United States 

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where location like '%states%'
Where continent is not null
order by 1,2

--Looking at the total case vs the population
--Shows what percentage of the population contracted Covid

Select Location, date, population, total_cases, (total_cases/population)*100 as PercentagePositive
From PortfolioProject..CovidDeaths
Where location like '%states%'
Where continent is not null
order by 1,2

--Looking at countries with the highest infection rate compared to population

Select Location, Population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as PercentagePopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not null
Group by Location, Population
order by PercentagePopulationInfected desc

--Showing Countries with the highest death count per population

Select Location, max(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not null
Group by Location
order by TotalDeathCount desc

--Breaking things down by continent
--Showing the continents with the highest death counts

Select location, max(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is null
Group by location
order by TotalDeathCount desc


--Global Numbers

--Global Death Percentage by date

Select date, Sum(new_cases) as total_cases, Sum(cast(New_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as GlobalDeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not null
Group by date
order by 1,2


--Total Global Death Percentage

Select Sum(new_cases) as total_cases, Sum(cast(New_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as GlobalDeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not null
--Group by date
order by 1,2


--Looking at total population vs vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(cast(vac.new_vaccinations as int)) Over(partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated, 
--(RollingPeopleVaccinated/dea.population)*100
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
On dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null
order by 2,3


--Use CTE

With PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(cast(vac.new_vaccinations as int)) Over(partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated 
--,(RollingPeopleVaccinated/dea.population)*100
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
On dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
FROM PopvsVac


--Use a Temp Table

Drop table if exists #PercentPopulationVaccinated 
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(cast(vac.new_vaccinations as int)) Over(partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated 
--,(RollingPeopleVaccinated/dea.population)*100
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
On dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated


-- Creating view to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(cast(vac.new_vaccinations as int)) Over(partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated 
--,(RollingPeopleVaccinated/dea.population)*100
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
On dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null
--order by 2,3