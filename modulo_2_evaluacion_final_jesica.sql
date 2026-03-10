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
    
-- QUERY FINAL -- Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

-- QUERY FINAL --
SELECT first_name,last_name
	FROM actor
    WHERE last_name LIKE "%Gibson%"; -- Se podría hacer con = pero que "engan "Gibson" en su apellido",el tegan he interpretado que es un que contengan y no que sea igual a "Gibson" 
    
 -- Query comprobación   -- Esta query es para comprobar que en SQL no se distinguen mayúsculas ni minúsculas,gibson con la g minúscula también lo entiende
SELECT first_name,last_name
	FROM actor
    WHERE last_name LIKE "%gibson%";
    
-- EJERCIO 7 -- Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

-- Query comprobación   -- 
SELECT first_name,actor_id
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20;
    
-- QUERY FINAL --
SELECT first_name
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20;
    
-- EJERCIO 8 -- Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
-- Query comprobación   -- 
SELECT title,rating
	FROM film
    WHERE rating NOT IN ("R", "PG-13");

-- QUERY FINAL --
SELECT title 
	FROM film
    WHERE rating NOT IN ("R", "PG-13"); -- se podría realizar también con el operador distinto de <> y AND
    
-- EJERCIO 9 --Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.

SELECT COUNT(film_id),rating -- cada película tiene un film_id único,es la PK(film_id de la tabla) y la PK nunca puede ser NULL.Usando PK nos aseguramos que estamos contando todas las películas
	FROM film
    GROUP BY rating;

-- EJERCIO 10 -- Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS TotalPeliAlquiladasXcliente -- Usamos la función de agregación COUNT, y contamos por la columna rental_id que es la PK de la tabla rental y es la que sin duda tiene todos las películas alquiladas
	FROM customer AS c
		INNER JOIN rental AS r -- usamos un INNER JOIN ya que queremos que solo queremos los clientes que han alquilado películas,no queremos a los que no han alquilado nada.
			ON c.customer_id = r.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name; -- Agrupamos películas alquiladas por cliente
    

-- EJERCIO 11 -- Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

-- RUTA Tablas: CATEGORY --> FILM_CATEGORY --> FILM --> INVENTORY--> RENTAL - Necesitamos 4 INNER JOIN para unir las 5 tablas, unimos unas con otras por la columna que tienen en común para ir de Categoría a Alquileres

SELECT name, COUNT(rental_id) AS TotalPeliAlquiladasXcategoría
	FROM category AS ca
		INNER JOIN film_category AS fc
			ON ca.category_id = fc.category_id
		INNER JOIN film AS f
			ON fc.film_id = f.film_id
		INNER JOIN inventory AS i
			ON f.film_id = i.film_id
		INNER JOIN rental AS r
			ON i.inventory_id = r.inventory_id
	GROUP BY name;

-- EJERCIO 12 --Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

SELECT rating,AVG(length) AS duraciónMediaPelícula -- AVG --> Función de agregación para calcular la media
	FROM film
    GROUP BY rating; -- Agrupamos películas por grupo,para que la media por clasificación

-- EJERCIO 13 -- Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
-- RUTA Tablas:ACTOR -->FILM_ACTOR-->FILM

-- Query comprobación   -- 
SELECT a.first_name, a.last_name,title
	FROM actor AS a
		INNER JOIN film_actor AS fa
			ON a.actor_id = fa.actor_id
		INNER JOIN film AS f
			ON fa.film_id = f.film_id
    WHERE title = "Indian Love";
    
    
-- QUERY FINAL --
SELECT a.first_name, a.last_name
	FROM actor AS a
		INNER JOIN film_actor AS fa
			ON a.actor_id = fa.actor_id
		INNER JOIN film AS f
			ON fa.film_id = f.film_id
    WHERE title = "Indian Love";
    
    
-- EJERCIO 14 -- Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

SELECT title, description
	FROM film
    WHERE description LIKE "%dog%" OR description LIKE "%cat%"; -- Es la condición
    
-- EJERCIO 15 -- Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.
-- RUTA Tablas ACTOR -->FILM_ACTOR

    -- Query comprobación   --     -- compruebo que no hay nulos
        
SELECT a.actor_id,f.title
	FROM actor AS a
		LEFT JOIN film_actor AS fa 
		ON a.actor_id = fa.actor_id
        LEFT JOIN film AS f
		ON fa.film_id = f.film_id; 
        
-- QUERY FINAL --
SELECT a.actor_id
	FROM actor AS a
		LEFT JOIN film_actor AS fa -- queremos que nos de los NULL también, no solo los actores que si tienen películas
		ON a.actor_id = fa.actor_id
    WHERE fa.film_id IS NULL; -- filtramos los actores que no tienen películas

    
    
    