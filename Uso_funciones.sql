-- 76) Mostrar el nombre de cada turno junto a su duración.
SELECT nombre, TIMEDIFF(horario_salida, horario_entrada) AS duracion
FROM turnos;

-- 77) Mostrar la cantidad de personas que tengan apellido único.
SELECT count(*) as cantidad_personas FROM personas
WHERE apellido IN (SELECT DISTINCT apellido FROM personas);

-- 78) Agrupar a las personas según el último número de su teléfono móvil y mostrar cada dígito(ordenado de menor a mayor) junto a la cantidad de personas cuyo teléfono móvil termine con él.
SELECT RIGHT(movil, 1) AS ultimo_digito_movil, COUNT(*) AS cantidad_personas
FROM personas
GROUP BY ultimo_digito_movil
ORDER BY ultimo_digito_movil;

-- 79) Agrupar a las personas según su servidor de mail y mostrar cada servidor junto a la cantidad de personas que tengan su mail registrado en él.
SELECT SUBSTRING_INDEX(mail, '@', -1) AS servidor_mail, COUNT(*) AS cantidad_personas
FROM personas
GROUP BY servidor_mail
ORDER BY servidor_mail;

-- 80) Agrupar a las personas según el trimestre en el que hayan nacido y mostrar cada trimestre junto a la cantidad de personas que nacieron en él.
SELECT CONCAT('Trimestre ', QUARTER(fecha_nacimiento)) AS trimestre, COUNT(*) AS cantidad_personas
FROM personas
GROUP BY trimestre;

-- 81) Agrupar a las personas según el mes en el que hayan nacido y mostrar el nombre de cada mes (ordenado por su aparición en el calendario y no alfabéticamente) junto a la fecha más reciente registrada en cada uno.
SELECT monthname(fecha_nacimiento) as mes,  MAX(fecha_nacimiento) AS fecha_mas_reciente
FROM personas
GROUP BY mes
ORDER BY MONTH(fecha_mas_reciente);

-- 82) Cambiar el '11' inicial de los teléfonos móviles por '15' (No reemplazar el número '11' en otro lugar que no sea el inicio).
UPDATE personas
SET movil = CONCAT('15', SUBSTRING(movil, 3))
WHERE movil LIKE '11%';

-- 83) Poner en mayúsculas los apellidos de las personas cuya nacionalidad no sea 'Argentina'.
UPDATE personas
SET apellido = CONCAT(UPPER(SUBSTRING(apellido, 1, 1)), LOWER(SUBSTRING(apellido, 2)))
WHERE nacionalidad NOT IN ('Argentina');

-- 84) Reemplazar 'Tecnología de la Información' por 'TIC' en el campo mejor_titulo de la tabla profesores.
UPDATE profesores
SET mejor_titulo = replace(mejor_titulo,'Tecnología de la Información','TIC')
WHERE mejor_titulo ='Licenciado en Tecnología de la Información';

-- 85) Reemplazar 'Villa' por 'V.' en los campos barrio tanto de la tabla personas como sedes.      
UPDATE personas
SET barrio = REPLACE(barrio, 'Villa', 'V.')
WHERE barrio LIKE '%Villa%';

UPDATE sedes
SET barrio = REPLACE(barrio, 'Villa', 'V.')
WHERE barrio LIKE '%Villa%';