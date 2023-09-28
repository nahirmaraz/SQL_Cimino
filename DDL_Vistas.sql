-- 91) Crear una vista llamada barrio_menor_alumnado, que permita mostrar al barrio con menor cantidad de alumnos.
CREATE VIEW barrio_menor_alumnado AS
SELECT barrio
FROM (SELECT barrio, COUNT(*) AS cantidad_alumnos
      FROM personas p
      WHERE EXISTS (SELECT 1
					FROM alumnos a
					WHERE a.fk_dni_personas = p.dni)
      GROUP BY barrio
      ORDER BY cantidad_alumnos ASC
      LIMIT 1) AS subquery;

-- 92) Crear una vista llamada profesores_trabajo_mismo_barrio, que permita mostrar el nombre, el apellido y el barrio de residencia de los profesores que trabajan en comisiones cuyas sedes coincidan con su barrio de residencia. Mostrar también el nombre y barrio de esas sedes.
CREATE VIEW profesores_trabajo_mismo_barrio AS
SELECT p.nombre, p.apellido, p.barrio FROM personas p
INNER JOIN profesores ps
ON(p.dni=ps.fk_dni_personas)
INNER JOIN comisiones c 
ON (ps.id=c.fk_id_profesores)
INNER JOIN sedes s 
ON(s.id=c.fk_id_sedes)
WHERE s.barrio=p.barrio;

-- 93) Crear una vista llamada personas_sin_rol, que permita mostrar todos los datos de las personas que no cumplan rol de alumno, ni de profesor.
CREATE VIEW personas_sin_rol AS
SELECT * FROM personas
WHERE dni NOT IN (SELECT fk_dni_personas FROM profesores) AND 
	  dni NOT IN (SELECT fk_dni_personas FROM alumnos);

-- 94) Crear una vista llamada cumpleanieros, que permita mostrar el nombre, el apellido, la fecha de nacimiento y la edad de las personas que cumplan años hoy.
CREATE VIEW cumpleanieros AS
SELECT nombre, apellido, fecha_nacimiento, edad(fecha_nacimiento)
FROM personas
WHERE DAY(fecha_nacimiento) = DAY(CURDATE()) AND
      MONTH(fecha_nacimiento) = MONTH(CURDATE());
-- 95) Crear una vista llamada profesores_violan_ddjj, que permita mostrar el nombre y el apellido de los profesores que tengan comisiones superpuestas (dos o más comisiones para el mismo día y turno).
CREATE VIEW profesores_violan_ddjj AS
SELECT DISTINCT p.nombre, p.apellido
FROM personas p
INNER JOIN profesores ps 
ON p.dni = ps.fk_dni_personas
INNER JOIN comisiones c 
ON ps.id = c.fk_id_profesores
INNER JOIN turnos t 
ON t.id = c.fk_id_turnos
WHERE ps.id IN (SELECT fk_id_profesores
				FROM comisiones
				GROUP BY fk_id_profesores, fk_id_dias, fk_id_turnos
				HAVING COUNT(*) > 1);