
/**********************************************************************
 * NAME: David Giacobbi
 * CLASS: CPSC 321-01
 * DATE: 10/10/22
 * HOMEWORK: #2
 * DESCRIPTION: This file completes all the SQL queries for Step 2, using
                joins and other modifiers as necessary.
 **********************************************************************/

-- Quesiton 1: 
-- Write an SQL query to find the countries with low inflation (you choose) and a high gdp (you
-- choose). Your query should return all of the country attributes and your answers should be
-- sorted from lowest to highest inflation.
SELECT *
FROM Country c
WHERE (c.gdp > 20000 AND c.inflation < 8.5)
ORDER BY c.inflation;


-- Question 2:
-- Write an SQL query using a “comma join” (i.e., without join syntax) to find all provinces that
-- have a small total area that are in a country with high inflation. Your query should return the
-- country code, country name, inflation, province name, and area and results should be sorted
-- from highest to lowest inflation, then alphabetically by country code (for countries with the
-- same inflation), and then by smallest to largest area.
SELECT c.country_code, c.country_name, c.inflation, p.province_name, p.area
FROM Country c, Province p
WHERE (c.country_code = p.country_code AND c.inflation > 8.0 AND p.area < 300000)
ORDER BY c.inflation DESC, c.country_code, p.area;


-- Question 3:
-- Rewrite your query in (2) to use JOIN syntax instead of a comma join.
SELECT c.country_code, c.country_name, c.inflation, p.province_name, p.area
FROM Country c JOIN Province p ON (c.country_code = p.country_code)
WHERE (c.inflation > 8.0 AND p.area < 300000)
ORDER BY c.inflation DESC, c.country_code, p.area;


-- Question 4:
-- Write an SQL query that finds the unique set of all provinces that have at least one city
-- with a population greater than a specific value (note that a province is identified by both the
-- province name and the country it is in). Return the country code, country name, province
-- name, and province area. Your query must use comma joins and should only return one row
-- per matching province.
SELECT DISTINCT c.country_code, c.country_name, p.province_name, p.area
FROM Country c, Province p, City d
WHERE (c.country_code = p.country_code AND 
       d.province_name = p.province_name AND 
       d.country_code = p.country_code AND
       d.population > 200000);


-- Question 5:
-- Rewrite your query from (4) using JOIN syntax for all of the joins.
SELECT DISTINCT c.country_code, c.country_name, p.province_name, p.area
FROM Province p JOIN Country c ON (p.country_code = c.country_code) 
                JOIN City d ON (p.province_name = d.province_name AND p.country_code = d.country_code)
WHERE d.population > 200000;


-- Question 6:
-- Write an SQL query that finds the unique set of all provinces with at least two cities having
-- a population greater than a specific value. Return the country code, country name, province
-- name, and province area. Your query must use comma joins, and must return only one row
-- per matching province.
SELECT DISTINCT c.country_code, c.country_name, p.province_name, p.area
FROM Country c, Province p, City d1, City d2
WHERE (c.country_code = p.country_code AND 
       d1.province_name = p.province_name AND 
       d1.country_code = p.country_code AND
       d2.province_name = p.province_name AND 
       d2.country_code = p.country_code AND
       d1.population > 800000 AND d2.population > 800000); 


-- Question 7:
-- Rewrite your query from (6) using JOIN syntax for all of the joins.
SELECT DISTINCT c.country_code, c.country_name, p.province_name, p.area
FROM Province p NATURAL JOIN Country c
                NATURAL JOIN City d1
                NATURAL JOIN City d2
WHERE d1.population > 800000 AND d2.population > 800000;


-- Question 8:
-- Write an SQL query that finds pairs of different cities with the same population. A city
-- is considered to be different if it has a different name, is in a different province, and/or is
-- in a different country. As examples, Portland and Salem are different cities, and Portland
-- Oregon and Portland Maine are also different cities. Return the city name, province name,
-- and country code for each city along with the population of both cities (so seven attributes in
-- total). Your query must use JOIN syntax.
SELECT DISTINCT d1.city_name, d1.province_name, d1.country_code, d2.city_name, d2.province_name, d2.country_code, d2.population 
FROM City d1 JOIN City d2 ON (d1.population = d2.population)
WHERE ((d1.city_name != d2.city_name) OR 
       (d1.province_name != d2.province_name) OR 
       (d1.country_code != d2.country_code)) 
       AND (d1.population = d2.population)
GROUP BY d1.city_name;

-- Question 9:
-- Write an SQL query that finds all countries with a high GDP and low inflation that border a
-- country with a low GDP and high inflation. Your query should return the country code and
-- country name. Your query must use comma joins and should only return unique countries
-- (i.e., one row per matching country).
SELECT x.country_code, x.country_name
FROM Country x, Country y, Border b
WHERE x.country_code = b.country_code_1 AND
      y.country_code = b.country_code_2 AND
      (y.gdp < 10000 AND y.inflation > 8.0) AND
      (x.gdp > 40000 AND x.inflation < 8.5);


-- Question 10:
-- Rewrite your query from (9) using JOIN syntax for all of the joins.
SELECT x.country_code, x.country_name
FROM Border b JOIN Country x ON (x.country_code = b.country_code_1)
              JOIN Country y ON (y.country_code = b.country_code_2)
WHERE (y.gdp < 10000 AND y.inflation > 8.0) AND
      (x.gdp > 40000 AND x.inflation < 8.5);