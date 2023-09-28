-- 96) Crear un procedimiento almacenado llamado comisiones_menos_de, que reciba como parámetro de entrada una cantidad de alumnos y devuelva un listado de comisiones que tengan menos de esa cantidad de alumnos. De cada comisión se espera ver el nombre, domicilio y barrio de la sede, los dos días de la semana que se cursa y en qué turno.
DELIMITER //
CREATE PROCEDURE comisiones_menos_de(IN cantidad_alumnos INT)
BEGIN
    SELECT c.id AS id_comision, s.domicilio, s.barrio, d.dia_1 AS dia1, d.dia_2 AS dia2, t.nombre AS turno
    FROM comisiones c
    INNER JOIN sedes s 
    ON c.fk_id_sedes = s.id
    INNER JOIN dias d 
    ON c.fk_id_dias = d.id
    INNER JOIN turnos t 
    ON c.fk_id_turnos = t.id
    WHERE (SELECT COUNT(*) FROM alumnos a 
		   WHERE a.fk_id_comisiones = c.id) < cantidad_alumnos;
END;
//
DELIMITER ;

-- 97) Crear un procedimiento almacenado llamado cambiar_comision, que reciba como parámetros de entrada el DNI de un alumno y el ID de la comisión a la que desea cambiarse. El procedimiento debe efectuar dicho cambio en la base de datos.
DELIMITER //
CREATE PROCEDURE cambiar_comision(IN dni_alumno CHAR(10), IN id_nueva_comision SMALLINT)
BEGIN
	UPDATE alumnos SET fk_id_comisiones = id_nueva_comision WHERE fk_dni_personas = dni_alumno;
END;
//
DELIMITER ;

-- 98) Crear un procedimiento almacenado llamado porcentaje_segun_nivel, que reciba como parámetro de entrada un nivel de conocimientos y retorne a través de un parámetro de salida el porcentaje de alumnos totales con ese nivel.
DELIMITER //
CREATE PROCEDURE porcentaje_segun_nivel (IN nivel_conocimiento VARCHAR(15), OUT porcentaje DECIMAL(5,2))
BEGIN
    DECLARE total_alumnos INT;
    DECLARE alumnos_con_nivel INT;
    
	SELECT COUNT(*) INTO total_alumnos FROM alumnos;
    
    SELECT COUNT(*) INTO alumnos_con_nivel FROM alumnos WHERE conocimiento_previo = nivel_conocimiento;
    
    IF total_alumnos > 0 THEN
        SET porcentaje = (alumnos_con_nivel / total_alumnos) * 100;
    ELSE
        SET porcentaje = 0;
    END IF;
END;
//
DELIMITER ;

-- 99) Crear un procedimiento almacenado llamado porcentaje_segun_nivel_en_comision, que reciba como parámetro de entrada un nivel de conocimientos y el ID de una comisión y retorne a través de un parámetro de salida el porcentaje de alumnos con ese nivel en tal comisión.
DELIMITER //
CREATE PROCEDURE porcentaje_segun_nivel_en_comision (IN nivel_conocimiento VARCHAR(15), IN id_comision INT, OUT porcentaje DECIMAL(5,2))
BEGIN
    DECLARE total_alumnos INT;
    DECLARE alumnos_con_nivel INT;
    
    SELECT COUNT(*) INTO total_alumnos FROM alumnos
    WHERE fk_id_comisiones = id_comision;

    SELECT COUNT(*) INTO alumnos_con_nivel FROM alumnos porcentaje_segun_nivel_en_comision
    WHERE conocimiento_previo = nivel_conocimiento AND
		  fk_id_comisiones = id_comision;
    
    IF total_alumnos > 0 THEN
        SET porcentaje = (alumnos_con_nivel / total_alumnos) * 100;
    ELSE
        SET porcentaje = 0;
    END IF;
END;
//
DELIMITER ;

-- 100) Crear un procedimiento almacenado llamado nivel_grafico, que reciba como parámetro de entrada el legajo de un alumno y muestre el nivel de dicho alumno con una cantidad de asteriscos, basándose en las pautas del ejercicio 89). Resolver sin el uso de instrucciones IF ni CASE.
DELIMITER //
CREATE PROCEDURE nivel_grafico(IN legajo_alumno INT)
BEGIN
    DECLARE nivel_conocimientos VARCHAR(15);
    DECLARE asteriscos VARCHAR(255);
    
    SELECT conocimiento_previo INTO nivel_conocimientos
    FROM alumnos
    WHERE legajo = legajo_alumno;
    
    SET asteriscos = '';
    
    SET asteriscos = REPEAT('*', 
        CASE nivel_conocimientos
            WHEN 'Ninguno' THEN 0
            WHEN 'Básico' THEN 1
            WHEN 'Intermedio' THEN 2
            WHEN 'Avanzado' THEN 3
            ELSE 0 -- Nivel desconocido o no válido
        END);
   
    SELECT asteriscos AS nivel_grafico;
END;
//
DELIMITER ;
