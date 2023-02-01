-- 1. Show the total population of the world.
-- world(name, continent, area, population, gdp)

SELECT SUM(population)
FROM world;

-- 2. List all the continents - just once each.

SELECT DISTINCT continent
FROM world;

SELECT continent
FROM world
GROUP BY continent;

-- 3. Give the total GDP of Africa

SELECT SUM(gdp) as total_GDP
FROM world
GROUP BY continent
HAVING continent = 'Africa'

-- 4. How many countries have an area of at least 1000000

SELECT COUNT(name)
FROM world
WHERE area >= 1000000;

-- 5. What is the total population of ('Estonia', 'Latvia', 'Lithuania')

SELECT SUM(population)
FROM world
WHERE name in ('Estonia', 'Latvia', 'Lithuania');

-- 6. For each continent show the continent and number of countries.

SELECT continent, COUNT(name)
FROM world
GROUP BY continent;

-- 7. For each continent show the continent and number of countries with populations of at least 10 million.

SELECT t1.continent, COUNT(t1.name)
FROM (SELECT continent, name 
      FROM world
      WHERE population >= 10000000
      ) t1
GROUP BY t1.continent;

-- 8. List the continents that have a total population of at least 100 million.

SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;