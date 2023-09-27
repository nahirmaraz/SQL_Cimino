-- 26) Listar los nombres de los países sudamericanos junto a los nombres de sus capitales (con alias 'Capital').
SELECT co.Name as Pais, ci.Name as Capital FROM country co 
INNER JOIN city ci
ON (ci.ID= co.Capital)
WHERE co.Continent LIKE 'South America';

 -- 27) Listar el código de país, junto a los nombres de las ciudades y su cantidad de habitantes, de aquellos cuya expectativa de vida sea mayor a 80.
SELECT co.Code as Cod_Pais, ci.Name as Ciudad, ci.Population as Poblacion FROM country co
INNER JOIN city ci
ON (co.Code=ci.CountryCode)
WHERE LifeExpectancy>80;

 -- 28) Listar las capitales de los países cuya forma de gobierno sea una República Federal.
SELECT ci.Name as Capital, co.Name as Pais FROM city ci 
INNER JOIN country co
ON (ci.ID= co.Capital)
WHERE GovernmentForm='Federal Republic'; 

 -- 29) Listar los lenguajes oficiales, junto al nombre de sus respectivos países, donde la cantidad de habitantes de dicho país esté entre un millón y tres millones.
SELECT cl.Language as Lenguaje_Oficial, co.Name as Pais FROM countrylanguage cl 
INNER JOIN country co 
ON (co.Code=cl.CountryCode)
WHERE Population BETWEEN 1000000 and 3000000 and IsOfficial='T';

 -- 30) Listar los códigos, los nombres locales y la región a la que pertenecen aquellos países donde se hable español.
SELECT co.Code as Cod_Pais, co.LocalName as Nombre_Local, co.Region as Region FROM country co 
INNER JOIN countrylanguage cl 
ON (co.Code=cl.CountryCode)
WHERE Language LIKE 'Spanish';

 -- 31) Listar los nombres y las capitales de los países en cuya capital se concentre más de la mitad de su población total.
SELECT ci.Name as Capital, co.Name as Pais FROM country co 
INNER JOIN city ci
ON (ci.ID= co.Capital)
WHERE ci.Population>= 0.5*co.Population;

 -- 32) Listar los nombres y la superficie de los países africanos cuya capital coincida con el nombre del distrito a la que pertenece.
SELECT co.Name as Pais, co.SurfaceArea as Superficie FROM country co 
INNER JOIN city ci 
ON (ci.ID= co.Capital)
WHERE Continent='Africa' AND ci.Name=ci.District;

 -- 33) Listar los nombres, las capitales y el año de independencia (sin nulos) de los 20 países más antiguos.
SELECT co.Name as Pais, ci.Name as Capital, co.IndepYear as Anio_Independencia FROM country co 
INNER JOIN city ci 
ON (ci.ID= co.Capital)
WHERE IndepYear IS NOT NULL
ORDER BY IndepYear
LIMIT 20;

 -- 34) Listar las ciudades europeas junto a sus idiomas, sin incluir al español, inglés, portugués, italiano, francés y alemán.
SELECT ci.Name as Ciudad, cl.Language as Lenguaje FROM city ci 
INNER JOIN countrylanguage cl
ON (ci.CountryCode=cl.CountryCode)
INNER JOIN country co 
ON (co.Code=cl.CountryCode)
WHERE Language NOT IN ('Spanish', 'English','Dutch',' French', 'Portuguese', 'Italian') AND co.Continent LIKE 'Europe';

 -- 35) Listar nombre, población y país de las diez ciudades europeas de habla inglesa más pobladas.
SELECT co.Name as Pais, ci.Name as Ciudad, ci.Population as Poblacion FROM city ci 
INNER JOIN country co 
ON (co.Code=ci.CountryCode)
INNER JOIN countrylanguage cl
ON (co.Code=cl.CountryCode)
WHERE Continent LIKE 'Europe' AND Language LIKE 'English'
ORDER BY Population asc
LIMIT 10;