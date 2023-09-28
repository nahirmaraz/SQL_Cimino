-- 66) Mostrar el nombre y el apellido de todos los alumnos con conocimientos previos básicos, ordenados alfabéticamente por apellido.
SELECT nombre, apellido FROM personas
WHERE dni IN (SELECT fk_dni_personas FROM alumnos
			  WHERE conocimiento_previo = 'Básico')
ORDER BY apellido;

-- 67) Mostrar el nombre, el apellido y la nacionalidad de todos los profesores argentinos, ordenados alfabéticamente por apellido.
SELECT nombre, apellido, nacionalidad FROM personas
WHERE dni IN (SELECT fk_dni_personas FROM profesores)
	      AND nacionalidad ='Argentina'
ORDER BY apellido;

-- 68) Mostrar los nombres de las sedes donde haya menos de 5 comisiones.
SELECT nombre FROM sedes
WHERE id IN ( SELECT fk_id_sedes FROM comisiones
			  GROUP BY fk_id_sedes
			  HAVING COUNT(*) < 5);
              
-- 69) Mostrar los 5 barrios con mayor cantidad de personas (alumnos y profesores).
SELECT DISTINCT barrio FROM personas 
GROUP BY barrio
HAVING COUNT(*)
ORDER BY COUNT(*) desc
LIMIT 5;

-- 70) Mostrar el nombre del turno con menor cantidad de comisiones abiertas.
SELECT nombre FROM turnos
WHERE id IN (SELECT fk_id_turnos FROM comisiones
			 GROUP BY fk_id_turnos
			 HAVING COUNT(*) = (SELECT COUNT(*) FROM comisiones
								GROUP BY fk_id_turnos
								ORDER BY COUNT(*) ASC
								LIMIT 1))
LIMIT 1;

-- 71) Mostrar el promedio de alumnos por comisión.
SELECT AVG(cantidad_alumnos) AS promedio_alumnos_por_comision
FROM (
    SELECT fk_id_comisiones, COUNT(*) AS cantidad_alumnos
    FROM alumnos
    GROUP BY fk_id_comisiones
) AS subquery;

-- 72) Mostrar la cantidad de comisiones con menos de 10 mujeres. (Se espera 5).
SELECT c.id AS id_comision, COUNT(DISTINCT p.dni) AS cantidad_mujeres
FROM comisiones c
INNER JOIN alumnos a ON c.id = a.fk_id_comisiones
INNER JOIN personas p ON a.fk_dni_personas = p.dni
WHERE p.genero = 'M'
GROUP BY c.id
HAVING COUNT(DISTINCT p.dni) < 10; 

-- 73) Insertar a la siguiente persona: * El domicilio y el barrio que declaró la persona son los de la sede llamada 'Filip'.
INSERT INTO personas (dni, nombre, apellido, genero, fecha_nacimiento, mail, movil, domicilio, barrio, nacionalidad)
VALUES ('37483238', 'Santiago', 'Vera', 'H', '1993-05-12', 'santi.vera
@gma1l.com', '1179382832', (SELECT domicilio FROM sedes WHERE nombre = 'Filip'), (SELECT barrio FROM sedes WHERE nombre = 'Filip'), 'Argentina');

-- 74) Actualizar el mail de la alumna con legajo 2596 por 'lore116@gma1l.com'.
UPDATE personas
SET mail = 'lore116@gma1l.com'
WHERE dni IN (SELECT fk_dni_personas FROM alumnos 
			  WHERE legajo = 2596);

-- 75) Eliminar todas las comisiones que pertenezcan a sedes situadas en el barrio de 'San Nicolás', dejando a sus alumnos sin comisión asignada.
UPDATE alumnos
SET fk_id_comisiones = NULL
WHERE fk_id_comisiones IN (SELECT id FROM comisiones 
						   WHERE fk_id_sedes IN (SELECT id FROM sedes
												 WHERE barrio ='San Nicolás'));

DELETE FROM comisiones 
WHERE fk_id_sedes IN (SELECT id FROM sedes
					  WHERE barrio ='San Nicolás');