-- 36) Mostrar según la tabla de países, la cantidad total de población, la población máxima, la población mínima, el promedio de población y con cuántos registros de población se cuenta.
 SELECT sum(Population), max(Population), min(Population), avg(Population), count(Population) FROM country;
 
 -- 37) Mostrar según la tabla de países, la cantidad total de población, la población máxima, la población mínima y el promedio de población, por cada continente.
SELECT sum(Population), max(Population), min(Population), avg(Population), count(Population) FROM country
GROUP BY Continent ; 

-- 38) Agrupar a todos los países según el continente al que pertenecen. Mostrar los continentes junto a la cantidad de naciones que pertenecen a cada uno.
SELECT Continent, count(Name) FROM country
GROUP BY Continent;

-- 39) Agrupar a todas las ciudades según el país al que pertenecen. Mostrar los códigos de países junto a la sumatoria total de habitantes de cada uno.
SELECT CountryCode, sum(Population) FROM city
GROUP BY CountryCode;

-- 40) Agrupar a todos los lenguajes según su nombre. Mostrar los nombres de los lenguajes junto al porcentaje de habla mínimo registrado para cada uno.
SELECT min(Percentage), Language FROM countrylanguage
GROUP BY Language;

-- 41) Mostrar las distintas formas de gobierno posibles de los países europeos junto a su correspondiente promedio de población que vive bajo estas circunstancias.
SELECT GovernmentForm, avg(Population) FROM country
WHERE Continent LIKE 'Europe'
GROUP BY GovernmentForm;

-- 42) Mostrar las diez regiones de mayor expectativa de vida promedio.
SELECT Region, avg(LifeExpectancy) FROM country
GROUP BY Region
ORDER BY avg(LifeExpectancy) desc
LIMIT 10;

-- 43) Mostrar los nombres de los diez distritos de mayor cantidad de ciudades con cantidad de habitantes mayor al medio millón, junto a la cantidad de ciudades.
SELECT District, sum(Population), count(Name) FROM city
GROUP BY District
HAVING sum(Population)>500000
ORDER BY count(Name) desc
LIMIT 10;

-- 44) Mostrar los nombres de los países que tengan ciudades en el Caribe, junto al número de las mismas por país.
SELECT co.Name as Pais, count(ci.Name) as Cant_Ciudad FROM country co 
INNER JOIN city ci 
ON (co.Code=ci.CountryCode)
WHERE Region LIKE 'Caribbean'
GROUP BY co.Name;

-- 45) Mostrar los lenguajes existentes junto a la cantidad de países que lo hablan de manera oficial.
SELECT cl.Language as Lenguaje, count(co.Name) as Cant_Pais FROM countrylanguage cl 
INNER JOIN country co 
ON (co.Code=cl.CountryCode)
WHERE cl.IsOfficial LIKE 'T'
GROUP BY cl.Language;