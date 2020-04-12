USE Bookworm
GO
-- Consulta

-- 1 - Listar todos los campos de todos los libros
SELECT * FROM LIBROS

-- 2 - Listar todos los campos de todos los autores
SELECT * FROM Autores

-- 3 - Listar el título y el año de publicación de todos los libros
SELECT TITULO, AÑO FROM LIBROS

-- 4 - Listar todos los campos de todos los autores y una columna con el año de nacimiento.
SELECT *,YEAR(FECHANAC) AS AÑONAC  FROM AUTORES

-- 5 - Listar el apellido, nombre, el sexo y el año de nacimiento de los autores
SELECT APELLIDOS, NOMBRES, SEXO, YEAR(FECHANAC) AS AÑONAC FROM AUTORES

-- 6 - Listar todos los campos de todos los libros cuyas editoriales sean 1, 2 o 3
SELECT * FROM LIBROS WHERE IDEditorial IN (1,2,3)

-- 7 - Listar todos los campos de todos los libros cuyos idiomas sean 3 o 4
SELECT * FROM LIBROS WHERE IDIdioma IN(3,4)

-- 8 - Listar todos los campos de todos los libros cuyas editoriales no sean 4, 5 o 6
SELECT * FROM LIBROS WHERE IDEditorial NOT IN (4,5,6)

-- 9 - Listar todos los campos de todos los libros cuyos idiomas no sean 1, 2 o 3
SELECT * FROM LIBROS WHERE IDIdioma NOT IN (1,2,3) 

-- 10 - Listar todos los campos de todos los libros cuyo precio sea mayor a $1000
SELECT * FROM LIBROS WHERE PRECIO > 1000

-- 11 - Listar todos los campos de todos los libros cuyo precio se encuentre entre $1000 y $5000
SELECT * FROM LIBROS WHERE PRECIO BETWEEN 1000 AND 5000

-- 12 - Listar todos los campos de todos los libros cuya cantidad de páginas sea menor a 500
SELECT * FROM LIBROS WHERE PAGINAS < 500

-- 13 - Listar todos los campos de todos los libros cuyo título contenga 'Historia'
SELECT * FROM LIBROS WHERE TITULO LIKE '%HISTORIA%'

-- 14 - Listar todos los campos de todos los libros cuyo título contenga 'Rey'
SELECT * FROM LIBROS WHERE TITULO LIKE '%REY%'

-- 15 - Listar las páginas de todos los libros cuyo título contenga 'Rey'
SELECT PAGINAS FROM LIBROS WHERE TITULO LIKE '%REY%'

-- 16 - Listar las páginas, sin duplicados, de todos los libros cuyo título contenga 'Rey'
SELECT DISTINCT PAGINAS FROM LIBROS WHERE TITULO LIKE '%REY%'

-- 17 - Listar todos los campos de todos los libros cuyo título contenga 'Economía'. Ver qué ocurre si se realiza la búsqueda con el término 'Economia'.
SELECT * FROM LIBROS WHERE TITULO COLLATE TRADITIONAL_SPANISH_CI_AI LIKE '%ECONOMIA%'

-- 18 - Listar todos los campos de todos los libros que no posean Editorial.
SELECT * FROM LIBROS WHERE IDEDITORIAL IS NULL

-- 19 - Listar todos los campos de todos los libros que posean Editorial
SELECT * FROM LIBROS WHERE IDEDITORIAL IS NOT NULL

-- 20 - Listar todos los campos de todos los libros que no posean Editorial y que su precio sea mayor a $1000.
SELECT * FROM LIBROS WHERE IDEDITORIAL IS NULL AND PRECIO > 1000

-- 21 - Listar el título, el año de publicación y el precio de los libros que cuesten más de $1000
SELECT TITULO, AÑO, PRECIO FROM LIBROS WHERE PRECIO > 1000

-- 22 - Listar título y precio de los 5 libros más caros
SELECT TOP 5 TITULO, PRECIO FROM LIBROS ORDER BY PRECIO DESC

-- 23 - Listar título, precio y cantidad de páginas de los 5 libros más cortos
SELECT TOP 5 TITULO, PRECIO, PAGINAS FROM LIBROS ORDER BY PAGINAS

-- 24 - Listar título, páginas e IDIdioma de los libros que no tengan idioma o tengan entre 280 y 300 páginas ordenados alfabéticamente
SELECT TITULO, PAGINAS, IDIDIOMA FROM LIBROS WHERE (IDIDIOMA IS NULL) OR (PAGINAS BETWEEN 280 AND 300) ORDER BY TITULO

-- 25 - Listar el nombre de aquellos géneros que comiencen con la palabra ‘Ciencia’ o ‘Fantasía’, o que contenga la palabra ‘para’
SELECT NOMBRE FROM GENEROS WHERE NOMBRE LIKE 'CIENCIA%' OR NOMBRE COLLATE TRADITIONAL_SPANISH_CI_AI LIKE 'FANTASIA%' OR NOMBRE LIKE '%PARA%'

-- 26 - Listar ordenadamente los distintos nombres que comienzan con J de los autores
SELECT DISTINCT NOMBRES FROM AUTORES WHERE NOMBRES LIKE 'J%' ORDER BY NOMBRES

-- 27 - Listar ordenadamente los diferentes años en los que nacieron los autores (sin repetir)
SELECT DISTINCT YEAR(FECHANAC) AS AÑONAC FROM AUTORES ORDER BY AÑONAC

-- 28 - Listar el apellido, nombre y la descripción del sexo de los autores. Siendo 'Masculino' para 'M', 'Femenino' para 'F' y 'No especificado' para 'X'
SELECT APELLIDOS, NOMBRES,
CASE
	WHEN SEXO LIKE 'M' THEN 'MASCULINO'
	WHEN SEXO LIKE 'F' THEN 'FEMENINO'
	ELSE 'NO ESPECIFICADO' 
END AS SEXO
FROM AUTORES

-- 29 - Listar el título de todos los libros y una columna llamada Longitud con la siguiente condición:
--      "Corto" si la cantidad de páginas es < 200, "Normal" si la cantidad de páginas < 800,
--      "Largo" si la cantidad de páginas < 1200, de lo contrario "Extenso".
SELECT TITULO,
CASE
	WHEN PAGINAS < 200 THEN 'CORTO'
	WHEN PAGINAS < 800 THEN 'NORMAL'
	WHEN PAGINAS < 1200 THEN 'LARGO'
	ELSE 'EXTENSO'
END AS LONGITUD
FROM LIBROS

-- 30 - Listar todos los campos de todos los libros incluyendo el precio recalculado a partir de la siguiente condición.
--      Descontar un 10% el precio a aquellos libros cuyo año de publicación sea menor a 1990.
SELECT * ,
CASE
	WHEN AÑO < 1990 THEN PRECIO * 0.90
	ELSE PRECIO
END AS PRECIO_DESC
FROM LIBROS
ORDER BY AÑO

-- 31 - Listar todos los campos de todos los libros incluyendo el precio recalculado a partir de la siguiente condición. 
--      Aumentar un 30% el precio a aquellos libros cuya IDEditorial sea 5, 6 o 7.
SELECT * , 
CASE
	WHEN IDEDITORIAL IN (5,6,7) THEN PRECIO * 1.30
	ELSE PRECIO
END AS PRECIO_NUEVO
FROM LIBROS
ORDER BY IDEDITORIAL

-- 32 - Listar todos los campos de todos los autores y una columna adicional con la edad del mismo.
--SELECT * , (DATEDIFF(DAY,FECHANAC,GETDATE()))/365 AS EDAD FROM AUTORES


SELECT * ,
CASE
	WHEN MONTH(GETDATE()) > MONTH(FECHANAC) THEN DATEDIFF(YEAR,FECHANAC,GETDATE())
	WHEN MONTH(GETDATE()) < MONTH(FECHANAC) THEN DATEDIFF(YEAR,FECHANAC,GETDATE())-1
	WHEN DAY(GETDATE()) >= DAY (FECHANAC) THEN DATEDIFF(YEAR,FECHANAC,GETDATE())
	ELSE DATEDIFF(YEAR,FECHANAC,GETDATE()) - 1
END AS EDAD
FROM AUTORES

-- 33 - Listar los libros cuya publicación haya sido hace menos de 5 años.
SELECT TITULO, AÑO FROM LIBROS WHERE YEAR(GETDATE()) - AÑO < 5 ORDER BY AÑO

-- 34 - Listar los autores cuyo nacimiento haya ocurrido hace menos de 50 años.
SELECT APELLIDOS, NOMBRES FROM AUTORES WHERE DATEDIFF(YEAR,FECHANAC,GETDATE()) < 50

-- 35 - Listar todos los campos de todos los libros cuyo título comience con vocal
SELECT * FROM LIBROS WHERE TITULO LIKE '[AEIOU]%' ORDER BY TITULO

-- 36 - Listar todos los campos de todos los libros cuyo título no finalice con vocal
SELECT * FROM LIBROS WHERE TITULO NOT LIKE '%[AEIOU]' ORDER BY TITULO

-- 37 - Listar todos los campos de todos los libros cuyo título contenga todas las vocales
SELECT * FROM LIBROS WHERE TITULO COLLATE TRADITIONAL_SPANISH_CI_AI LIKE '%A%'AND TITULO COLLATE TRADITIONAL_SPANISH_CI_AI LIKE '%E%'
AND TITULO COLLATE TRADITIONAL_SPANISH_CI_AI LIKE '%I%' AND TITULO COLLATE TRADITIONAL_SPANISH_CI_AI LIKE '%O%' 
AND TITULO COLLATE TRADITIONAL_SPANISH_CI_AI LIKE '%U%'

-- 38 - Listar el apellido y nombres de todos los autores cuya edad sea entre 50 y 80 años
SELECT APELLIDOS, NOMBRES FROM AUTORES WHERE DATEDIFF(DAY,FECHANAC,GETDATE()) / 365 BETWEEN 50 AND 80 ORDER BY FECHANAC

-- 39 - Listar el apellido y nombres y la fecha de cumpleaños de cada autor. La misma debe ser mostrada en una sola columna de tipo varchar(5) con el siguiente formato "DIA/MES".
SELECT APELLIDOS, NOMBRES, FORMAT(FECHANAC,'dd/MMM','es-US') AS CUMPLEAÑOS FROM AUTORES 

-- 40 - Listar todos los libros que se escribieron después del 1980, en IDIdioma 1 o 2 que la cantidad de páginas sea entre 500 y 1200, 
--      su precio menor a $2000 y que posea Editorial. Ordenarlos del más costoso al más barato.
SELECT * FROM LIBROS WHERE AÑO > 1980 AND IDIDIOMA IN (1,2) AND PAGINAS BETWEEN 500 AND 1200 AND PRECIO < 2000 
AND IDEDITORIAL IS NOT NULL ORDER BY PRECIO DESC