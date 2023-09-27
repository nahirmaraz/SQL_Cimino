-- 6) Listar toda la información de los países, ordenados por población de manera ascendente.
SELECT * FROM country
ORDER BY Population asc;

-- 7) Listar nombre de los lenguajes en orden alfabético.
SELECT Language FROM countrylanguage
ORDER BY Language asc;

-- 8) Listar nombre y cantidad de habitantes de las veinte ciudades menos pobladas.
SELECT Name, Population FROM city
ORDER BY Population
LIMIT 20;

-- 9) Listar código, nombre y año de independencia de todos los países, ordenados por antigüedad descendente.
 SELECT Name, Code, IndepYear FROM country
 ORDER BY IndepYear desc;
 
 -- 10) Listar nombre y continente de los cien países con mayor expectativa de vida. Si hubiera países que tengan la misma expectativa de vida, mostrar primero a los de menor superficie.
 SELECT Name, Continent FROM country
 ORDER BY LifeExpectancy desc
 LIMIT 100;