# Proyecto SQL: Gestión de Videoclub (Database Sakila)

##  Descripción del Proyecto
Este proyecto forma parte del **Bootcamp de Análisis de Datos**, donde se pone en práctica el dominio del lenguaje SQL mediante la consulta y análisis estratégico de la base de datos **Sakila**. 

La base de datos Sakila representa el sistema de gestión de un **videoclub** . El objetivo es resolver 24 desafíos técnicos que van desde consultas simples de inventario hasta extracciones complejas mediante el uso de JOINs complejos entre múltiples tablas, permitiendo obtener métricas clave sobre el rendimiento del negocio, la fidelización de clientes y la disponibilidad de existencias



---

## Estructura de la Base de Datos
Sakila cuenta con una arquitectura normalizada que cubre todos los aspectos de una tienda de alquiler de películas. Las tablas principales utilizadas en este análisis son:

* **`film`**: Datos maestros (título, descripción, año de lanzamiento, duración).
* **`actor`**: Información sobre los actores y actrices.
* **`category`**: Géneros cinematográficos (Comedy, Horror, Family, etc.).
* **`customer`**: Detalles de los clientes (nombres, emails y direcciones).
* **`inventory`**: Registro de copias físicas disponibles en las tiendas.
* **`rental`**: Histórico de alquileres y fechas de devolución.
* **Tablas Intermedias (`film_actor`, `film_category`)**: Relaciones N:M que conectan películas con sus repartos y géneros.

---


## 🛠️ Herramientas y Conceptos de SQL Aplicados

Durante el desarrollo de este proyecto, se han aplicado los pilares fundamentales de las consultas relacionales para garantizar la precisión y eficiencia de los datos:

* **`SELECT DISTINCT`**: Utilizado para eliminar duplicados y obtener listados únicos de títulos, categorías y actores.
* **`INNER JOIN`**: La base del proyecto, permitiendo la conexión de hasta 5 tablas simultáneas para cruzar información de inventario, clientes y películas.
* **`GROUP BY` & Funciones de Agregación**: Aplicados con `COUNT`,  `AVG` para extraer métricas de negocio, como el total de alquileres por categoría.
* **`HAVING`**: Filtros avanzados sobre datos agrupados, esenciales para segmentar actores o clientes que cumplen con ciertos criterios de volumen.
* **`ORDER BY`**: Implementado para jerarquizar los resultados (ej. las películas más alquiladas).
* **Subconsultas & Operadores Lógicos**: Uso de subconsultas con `IN` y `NOT IN`, junto con operadores de comparación y funciones de fecha (`DATEDIFF`), para resolver problemas lógicos complejos.

---

## 🛠️ Consultas Destacadas (Ejemplos)

A continuación, se muestran algunas de las consultas clave desarrolladas para el análisis:

### - Consulta Destacada: Análisis de Popularidad por Categoría (Query 11)

Esta consulta es un ejemplo de **trazabilidad completa** dentro de una base de datos relacional. Para obtener el recuento de alquileres por género cinematográfico, ha sido necesario interconectar 5 tablas distintas, navegando desde la definición de la categoría hasta el registro individual de cada préstamo.

**Lógica de la consulta:**
1.  Relacionamos la categoría con sus películas (`film_category`).
2.  Conectamos las películas con el inventario físico (`inventory`).
3.  Vinculamos cada copia del inventario con su historial de alquileres (`rental`).
4.  Agrupamos por nombre de categoría y realizamos un conteo (`COUNT`) de los registros únicos.

```sql

SELECT 
    ca.name AS Categoria, 
    COUNT(r.rental_id) AS Total_Alquileres
FROM category AS ca
    INNER JOIN film_category AS fc ON ca.category_id = fc.category_id
    INNER JOIN film AS f ON fc.film_id = f.film_id
    INNER JOIN inventory AS i ON f.film_id = i.film_id
    INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY ca.name
ORDER BY Total_Alquileres DESC;
``` 

### Consulta Destacada: Análisis de Plazos de Alquiler (Query 22)

En esta query se resuelve la identificación de títulos alquilados por más de 5 días. Para ello, se ha aplicado una **subconsulta** que actúa como filtro dinámico, permitiendo aislar primero los registros de alquiler específicos antes de obtener los nombres de las películas.

**Lógica de la consulta:**
1.  **Subconsulta de filtrado:** Se utiliza `DATEDIFF` dentro de una subconsulta para generar un listado de los `rental_id` que cumplen la condición de haber sido alquilados por más de 5 días.
2.  **Relación de tablas:** Se conecta `film`, `inventory` y `rental` mediante `INNER JOIN` para cruzar los títulos con sus copias físicas y registros de préstamo.
3.  **Filtro IN:** Se utiliza el operador `IN` para que la consulta principal solo muestre las películas cuyos alquileres coincidan con los IDs filtrados previamente.
4.  **Eliminación de duplicados:** Se aplica `DISTINCT` para asegurar que cada título aparezca una sola vez, independientemente de cuántas veces haya superado el plazo.

```sql

SELECT DISTINCT f.title 
	FROM film AS f
		INNER JOIN inventory AS i
			ON f.film_id = i.film_id
		INNER JOIN rental AS r
			ON i.inventory_id = r.inventory_id
		WHERE r.rental_id IN ( 
			SELECT rental_id
			FROM rental
			WHERE DATEDIFF(return_date , rental_date) > 5
        );
```


### 🚀 Cómo Ejecutar el Proyecto

<details>
<summary>Instrucciones para replicar el análisis</summary>

Para replicar este análisis en tu entorno local:

1. **Requisitos:** Tener instalado **MySQL Server** y **MySQL Workbench**.  
2. **Carga de Datos:** Descarga los scripts oficiales de [Sakila Database](https://dev.mysql.com/doc/index-other.html) e instálalos.  
3. **Ejecución:**  
   * Abre el archivo `.sql` adjunto en este repositorio.  
   * Ejecuta el comando inicial: `USE sakila;`.  
   * Ejecuta cada bloque de ejercicio de forma independiente para ver los resultados en la consola.  

</details>

---

**Autor:** Jesica González González  
**Fecha:** 2026