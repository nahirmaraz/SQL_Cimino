-- 1) Listar código, nombre, continente y población de todos los países.
SELECT Code, Name, Continent, Population FROM country;

-- 2) Listar solo el nombre de todos los lenguajes distintos que existan.
SELECT DISTINCT Language FROM countrylanguage;

-- 3) Listar nombre y población de cada ciudad, con los nombres de las columnas en castellano.
SELECT Name as Nombre, Population as Poblacion FROM city;

-- 4) Listar el nombre, el GNP como 'Producto Bruto Nacional', el GNPOld como 'Producto Bruto Nacional Anterior' y la diferencia entre estos como 'Diferencia', para todos los países.
SELECT Name, GNP as PBN, GNPOld as PBNA, (GNP-GNPOld) as Diferencia FROM country;

-- 5) Listar el nombre, la cantidad de habitantes, la superficie y una columna llamada 'Densidad' con el resultado de la densidad poblacional de todos los países.
SELECT Name, Population, SurfaceArea, (Population/SurfaceArea) as Densidad FROM country;