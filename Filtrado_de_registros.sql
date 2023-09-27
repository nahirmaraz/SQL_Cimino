-- 11) Listar todos los datos de los países que no cuenten con habitantes.
 SELECT * FROM country
 WHERE Population = 0;
 
 -- 12) Listar todos los datos de los países cuya expectativa de vida supere los setenta y cinco años, ordenados bajo este concepto de forma ascendente.
 SELECT * FROM country
 WHERE LifeExpectancy>75
 ORDER BY LifeExpectancy;
 
 -- 13) Listar todos los datos de los países cuya independencia haya ocurrido a partir de la segunda mitad del siglo XIX y su forma de gobierno sea una monarquía constitucional.
 SELECT * FROM country
 WHERE IndepYear >= 1850 AND GovernmentForm='Constitutional Monarchy';
 
 -- 14) Listar todos los datos de los diez países europeos de mayor PBN.
 SELECT * FROM country
 WHERE Continent ='Europe'
 ORDER BY GNP desc
 LIMIT 10;
 
 -- 15) Listar todos los datos de los países cuyo nombre registrado coincida con su nombre local.
 SELECT * FROM country
 WHERE Name=LocalName;
 -- 16) Listar todos los datos de los países cuya independencia se haya dado a partir de la segunda mitad del siglo XX.
 SELECT * FROM country
 WHERE IndepYear>=1951;
 
 -- 17) Listar todos los datos de los países situados en Europa, Asia o Sudamérica.
 SELECT * FROM country
 WHERE Continent IN ('Europe', 'Asia', 'South America');
 
 -- 18) Listar todos los datos de todos los países, excepto los africanos.
 SELECT * FROM country
 WHERE Continent NOT LIKE 'Africa';
 
 -- 19) Listar todos los datos de las ciudades argentinas fuera de la provincia de Buenos Aires.
 SELECT * FROM city
 WHERE CountryCode='ARG' AND District NOT LIKE 'Buenos Aires';
 
 -- 20) Listar todos los datos de las ciudades de entre 125 mil y 130 mil habitantes.
 SELECT * FROM city
 WHERE Population BETWEEN 125000 AND 130000;