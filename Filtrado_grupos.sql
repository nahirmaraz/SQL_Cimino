-- 46) Mostrar listados los años de independencia (sin nulos) junto a la cantidad de países que la hayan conseguido en ese año. Se desea visualizar aquellos años donde más de un país se haya independizado.
SELECT IndepYear as Anio_Independencia, count(Name) as Cant_Pais FROM country
WHERE IndepYear IS NOT NULL
GROUP BY IndepYear
HAVING count(Name)>1;

-- 47) Listar los países junto a la cantidad de idiomas diferentes hablados, pero solo aquellos donde se hablen entre tres y cinco idiomas diferentes.
SELECT co.Name as Pais, count( cl.Language) as Cant_Idiomas FROM country co 
INNER JOIN countrylanguage cl 
ON (co.Code=cl.CountryCode)
GROUP BY co.Name
HAVING count(cl.Language) BETWEEN 3 AND 5;

-- 48) Mostrar los distritos, junto al nombre del país al que pertenecen, cuya población total (también listada) no supere los diez mil habitantes.
SELECT ci.District as Distrito, co.Name as Pais, sum(ci.Population) as Total_Poblacion FROM city ci 
INNER JOIN country co 
ON (co.Code=ci.CountryCode)
GROUP BY ci.District, co.Name
HAVING sum(ci.Population)<10000;

-- 49) Mostrar las regiones junto a su densidad poblacional promedio, donde ésta supere a la mitad de la densidad poblacional máxima.
SELECT Region, avg((Population/SurfaceArea)) as Prom_Densidad_Poblacion FROM country
GROUP BY Region
HAVING avg((Population/SurfaceArea))> 0.5 * max((Population/SurfaceArea));

-- 50) Mostrar los lenguajes oficiales junto a su porcentaje promedio de habla, cuyo promedio no supere un dígito entero.
SELECT Language, avg(Percentage) as Prom_Habla FROM countrylanguage
WHERE IsOfficial LIKE 'T'
GROUP BY Language
HAVING avg(Percentage)< 10;