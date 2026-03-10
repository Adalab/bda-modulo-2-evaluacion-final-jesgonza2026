USE sakila; /*Seleccionamos la BBDD sobre la que vamos a trabajar*/

-- EJERCIO 1 -- Selecciona todos los nombres de las películas sin que aparezcan duplicados.

SELECT DISTINCT title -- Usamos Distinc para eliminar los valores repetidos
	FROM film;

-- EJERCIO 2 -- Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

SELECT title,rating -- Query comprobación-añado la columna rating al SELECT para que me muestre y así poder comprobar que se cumple la condición indicada en el WHERE
	FROM film 
    WHERE rating = "PG-13";
    
-- QUERY FINAL --
SELECT title
	FROM film
    WHERE rating = "PG-13";

-- EJERCIO 3 -- Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción

SELECT title,description
	FROM film
	WHERE description LIKE "%amazing%"; -- la palabra va entre dos porcentajes porque necesitamos mostrar que contenga esa palabra.No nos piden que empiece ni que termine por algo,sino que contenga.
    
-- EJERCIO 4 -- Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

SELECT title,length -- Query comprobación
	FROM film
    WHERE length > 120;
    
-- QUERY FINAL --
SELECT title
	FROM film
    WHERE length > 120;
    
-- EJERCIO 5 -- Recupera los nombres de todos los actores.

SELECT first_name
	FROM actor;
    
-- EJERCIO 6 -- Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

-- QUERY FINAL --
SELECT first_name,last_name
	FROM actor
    WHERE last_name LIKE "%Gibson%"; -- Se podría hacer con = pero que "engan "Gibson" en su apellido",el tegan he interpretado que es un que contengan y no que sea igual a "Gibson" 
    
 -- Query comprobación   -- Esta query es para comprobar que en SQL no se distinguen mayúsculas ni minúsculas,gibson con la g minúscula también lo entiende
SELECT first_name,last_name
	FROM actor
    WHERE last_name LIKE "%gibson%";