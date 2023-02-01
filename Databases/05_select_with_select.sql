-- 1. List each country name where the population is larger than that of 'Russia'.
-- world(name, continent, area, population, gdp)

SELECT name 
FROM world
WHERE population >
    (SELECT population FROM world
    WHERE name='Russia');

-- 2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
-- The per capita GDP is the gdp/population

SELECT name
FROM world
WHERE gdp/population > 
        (SELECT gdp/population
        FROM world
        WHERE name = 'United Kingdom') AND 
      (continent = 'Europe');

-- 3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

SELECT name, continent
FROM world
WHERE continent IN (
    SELECT continent
    FROM world
    WHERE name in ('Argentina','Australia'))
ORDER BY name;

-- 4. Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.

SELECT name, population
FROM world
WHERE population > (
        SELECT population FROM world 
        WHERE name = 'United Kingdom') AND
      population < (
        SELECT population FROM world 
        WHERE name = 'Germany');

-- 5. Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
-- Note: 
-- Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.
-- You can use the function ROUND to remove the decimal places.
-- You can use the function CONCAT to add the percentage symbol.

SELECT name, 
    CONCAT(ROUND(100*(population/(
        SELECT population
        FROM world
        WHERE name = 'Germany')
    ), 0),'%') as percentage
FROM world
WHERE continent = 'Europe'


-- 6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)

SELECT name
FROM world
WHERE gdp > ALL(SELECT gdp
                FROM world
                WHERE (Continent = 'Europe') AND 
                      (gdp>0)
                );

-- 7. Find the largest country (by area) in each continent, show the continent, the name and the area:
-- Note:
-- A correlated subquery works like a nested loop: the subquery only has access to rows related to a single record at a time in the outer query. The technique relies on table aliases to identify two different uses of the same table, one in the outer query and the other in the subquery.
-- One way to interpret the line in the WHERE clause that references the two table is “… where the correlated values are the same”.
-- In the example provided, you would say “select the country details from world where the population is greater than or equal to the population of all countries where the continent is the same”.

--correlated or synchronized sub-query.
--'select the country details from world where the area is greater than equal to the area of all countries where the continent is the same'
SELECT continent, name, area 
FROM world x
WHERE area >= ALL(
   SELECT area FROM world y
   WHERE y.continent=x.continent)

-- 8. List each continent and the name of the country that comes first alphabetically.

-- Nested SELECT is picking all the countries with the same continent
-- Outer SELECT is keeping the countries where the name is less than the country names in the Nested SELECT, so it will filter down to the lowest, or first alphabetical
SELECT continent, name
FROM world x
WHERE name <= ALL(
    SELECT name 
    FROM world y
    WHERE y.continent = x.continent
    )

-- 9. Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.

-- Starting from inner most SELECT...
-- Select all the country populations that are on the same continent
-- Keep only those distinct countries whose populations are <= 25000000
-- Get the country details of those countries that are in those continents
SELECT name, continent, population
FROM world z
WHERE z.continent IN (
SELECT DISTINCT continent
FROM world x
WHERE 25000000 > 
      ALL(SELECT population 
          FROM world y 
          WHERE x.continent = y.continent)
);

-- 10. Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.

-- Starting from inner most SELECT...
-- Select all other countries in the same continent and multiply those populations by 3
-- For each country, keep only those country details whose populations are greater than that entire list
SELECT name, continent
FROM world x
WHERE population > 
      ALL(SELECT 3*population 
          FROM world y 
          WHERE (x.continent = y.continent) AND
                (x.name != y.name)
          );