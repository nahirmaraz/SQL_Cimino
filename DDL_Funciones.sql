-- 86) Definir la función ultimo_digito que reciba una cadena que represente un número (como un DNI o un teléfono móvil) y devuelva el último dígito de la misma.
DELIMITER //
CREATE FUNCTION ultimo_digito(numero VARCHAR(255))
RETURNS CHAR(1) DETERMINISTIC
BEGIN
  DECLARE ult_digito CHAR(1);
  SET ult_digito = RIGHT(numero, 1);
  RETURN ult_digito;
END;
//
DELIMITER ;

-- 87) Definir la función edad que reciba la fecha de nacimiento de una persona y devuelva la edad de la misma.
DELIMITER //
CREATE FUNCTION edad(fecha_nacimiento DATE)
RETURNS INT DETERMINISTIC
BEGIN
  DECLARE edad INT;
  SET edad = YEAR(CURDATE()) - YEAR(fecha_nacimiento);
  IF DATE_FORMAT(CURDATE(), '%m%d') < DATE_FORMAT(fecha_nacimiento, '%m%d') THEN
    SET edad = edad - 1;
  END IF;
  RETURN edad;
END;
//
DELIMITER ;

-- 88) Definir la función tipo_perfil que reciba el mejor título de un profesor y devuelva su tipo de perfil ('Licenciado', 'Ingeniero', 'Auxiliar', etc)
DELIMITER //
CREATE FUNCTION tipo_perfil (mejor_titulo VARCHAR (50))
RETURNS VARCHAR (15) DETERMINISTIC
BEGIN
DECLARE perfil VARCHAR (15);
SET perfil= SUBSTRING_INDEX(mejor_titulo, ' ', 1);
RETURN perfil;
END;
//
DELIMITER ;

-- 89) Definir la función nivel_int que reciba el conocimiento previo de un alumno y devuelva el número asociado, según: 'Ninguno': 0, 'Básico': 1, 'Intermedio': 2, 'Avanzado': 3. Para cualquier otro valor debe devolver -1. 
DELIMITER //
CREATE FUNCTION nivel_int (conocimiento_previo VARCHAR(15))
RETURNS INT DETERMINISTIC
BEGIN
DECLARE num int;
	IF conocimiento_previo = 'Ninguno' THEN
	SET num= 0;
	IF conocimiento_previo = 'Básico' THEN
		SET num= 1;
	IF conocimiento_previo = 'Intermedio' THEN
		SET num= 2;
	IF conocimiento_previo = 'Avanzado' THEN
		SET num= 3;
	ELSE
		SET num= -1;
	END IF;
RETURN num; 
END;
//
DELIMITER ;

-- 90) Definir la función tipo_domicilio que reciba el domicilio de una persona y devuelve el tipo de domicilio de la misma ('CASA', 'DEPARTAMENTO', 'PH', 'PISO_COMPLETO').
DELIMITER //
CREATE FUNCTION tipo_domicilio (domicilio VARCHAR(255))
RETURNS VARCHAR (20) DETERMINISTIC
BEGIN
DECLARE tipo VARCHAR (20);
  IF domicilio REGEXP '\\bCasa\\b' THEN
    SET tipo = 'CASA';
  ELSEIF domicilio REGEXP '\\bDepto\\b' THEN
    SET tipo = 'DEPARTAMENTO';
  ELSEIF domicilio REGEXP '\\bPH\\b' THEN
    SET tipo = 'PH';
  ELSEIF domicilio REGEXP '\\bPiso\\b' THEN
    SET tipo = 'PISO_COMPLETO';
  ELSE
    SET tipo = 'DESCONOCIDO';
  END IF;
RETURN tipo;
END;
//
DELIMITER ;