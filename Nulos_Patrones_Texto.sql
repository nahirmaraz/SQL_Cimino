 -- 21) Listar todos los datos de los países donde no se cuente con datos acerca de su independencia.
 SELECT * FROM country
 WHERE IndepYear IS NULL;
 
 -- 22) Listar todos los datos de los países donde no se tengan datos acerca del PBN anterior ni de la expectativa de vida.
 SELECT * FROM country
 WHERE GNPOld IS NULL AND LifeExpectancy IS NULL;
 
 -- 23) Listar todos los datos de los países cuyo nombre comience y termine con 'A'.
 SELECT * FROM country
 WHERE Name LIKE 'A%A';
 
 -- 24) Listar todos los datos de los países cuyo nombre sea compuesto (más de una palabra). (Se esperan 15 columnas y 66 registros).
 SELECT * FROM country
 WHERE Name LIKE '% %'; 
 
-- 25) Listar todos los datos de las ciudades cuyo nombre o distrito contengan un '-' (guión medio). (Se esperan 5 columnas y 372 registros).
 SELECT * FROM city
 WHERE Name LIKE '%-%' OR District LIKE '%-%'; #Tengo que poner el like para cada columna