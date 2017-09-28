-- Write queries to return the following:
-- Make the following changes in the "world" database.

-- 1. Add Superman's hometown, Smallville, Kansas to the city table. The 
-- countrycode is 'USA', and population of 45001. (Yes, I looked it up on 
-- Wikipedia.)

BEGIN TRANSACTION;

INSERT INTO city(id ,name, countrycode, population, district) 
VALUES (6000,'Smallville', 'USA', 45001, 'Kansas')

COMMIT;

ROLLBACK;

SELECT * FROM city WHERE name = 'Smallville'

-- 2. Add Kryptonese to the countrylanguage table. Kryptonese is spoken by 0.0001
-- percentage of the 'USA' population.

BEGIN TRANSACTION;

INSERT INTO countrylanguage(language, countrycode, isofficial, percentage)
VALUES('Kryptonese','USA',false, 0.0001)

COMMIT;

ROLLBACK;

SELECT * FROM countrylanguage WHERE language = 'Kryptonese'
-- 3. After heated debate, "Kryptonese" was renamed to "Krypto-babble", change 
-- the appropriate record accordingly.

BEGIN TRANSACTION;

UPDATE countrylanguage SET language = 'Krypto-babble'
WHERE language = 'Kryptonese'

COMMIT;

ROLLBACK;

SELECT * FROM countrylanguage WHERE language = 'Krypto-babble'
-- 4. Set the US captial to Smallville, Kansas in the country table.
SELECT capital FROM country WHERE code = 'USA'
BEGIN TRANSACTION;

UPDATE country SET capital = 6000
WHERE capital = 3813 

COMMIT;

ROLLBACK;

SELECT * FROM country WHERE code = 'USA'
-- 5. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)

BEGIN TRANSACTION;

DELETE FROM city  WHERE name = 'Smallville'

COMMIT;

ROLLBACK;

SELECT * FROM city WHERE name = 'Smallville'
-- 6. Return the US captial to Washington.

BEGIN TRANSACTION;

UPDATE country SET capital = 3813
WHERE capital = 6000

COMMIT;

ROLLBACK;

SELECT * FROM country WHERE code = 'USA'
-- 7. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)

BEGIN TRANSACTION;

DELETE FROM city  WHERE name = 'Smallville'

COMMIT;

ROLLBACK;

SELECT * FROM city WHERE name = 'Smallville'

-- 8. Reverse the "is the official language" setting for all languages where the
-- country's year of independence is within the range of 1800 and 1972 
-- (exclusive). 
-- (590 rows affected)
SELECT language, cl.isofficial
FROM countrylanguage cl
JOIN country c ON cl.countrycode = c.code
WHERE c.indepyear BETWEEN 1800 AND 1972
ORDER BY countrycode

BEGIN TRANSACTION;

UPDATE countrylanguage 
SET isofficial = NOT isofficial
FROM country 
WHERE indepyear BETWEEN 1800 AND 1972

COMMIT;

ROLLBACK;

SELECT language, cl.isofficial
FROM countrylanguage cl
JOIN country c ON cl.countrycode = c.code
WHERE c.indepyear BETWEEN 1800 AND 1972
ORDER BY countrycode
-- 9. Convert population so it is expressed in 1,000s for all cities. (Round to
-- the nearest integer value greater than 0.)
-- (4079 rows affected)

SELECT name,population 
FROM city
ORDER BY population ASC

BEGIN TRANSACTION;

UPDATE city 
SET population = CEILING(population/1000.0)

COMMIT;

ROLLBACK;

SELECT name,population 
FROM city
ORDER BY population DESC

-- 10. Assuming a country's surfacearea is expressed in miles, convert it to 
-- meters for all countries where French is spoken by more than 20% of the 
-- population.
-- (7 rows affected)
SELECT name, surfacearea, cl.language, cl.percentage
FROM countrylanguage cl
JOIN country ON country.code = cl.countrycode
WHERE percentage > 20.000 AND language = 'French'

BEGIN TRANSACTION;

UPDATE country
SET surfacearea = surfacearea*1609.344
FROM countrylanguage 
WHERE percentage > 20.000 AND language = 'French'

COMMIT;

ROLLBACK;
