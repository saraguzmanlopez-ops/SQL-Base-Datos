Use Sakila;

# -------------------------------------------------------------------------------
# . Selecciona todos los nombres de las películas sin que aparezcan duplicados.
# -------------------------------------------------------------------------------

# el nombre de la pelicula es  tabla film y  columna title ,como no quiero duplicados con distinct,  soluciono

SELECT  DISTINCT title
FROM film
ORDER BY title asc;

# -------------------------------------------------------------------------------
# . Muestra los nombres de todas las películas que tengan una clasificación de "PG-13"
# -------------------------------------------------------------------------------

# esto es el rating

SELECT title 
FROM film
WHERE rating = 'PG-13'
ORDER BY title ASC;

# --------------------------------------------------------------------------------------------------------------------
# Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
# --------------------------------------------------------------------------------------------------------------------

SELECT title, description
FROM film
WHERE description REGEXP 'Amazing'
ORDER BY title ASC;

# -----------------------------------------------------------------------------------------
# . Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos. 
# ------------------------------------------------------------------------------------------
# length , son los minutos 

SELECT title , length
FROM film
WHERE length >120
ORDER BY title ASC;

# -----------------------------------------------
#. Recupera los nombres de todos los actores.
# -----------------------------------------------

SELECT DISTINCT first_name,last_name
FROM actor;

# -----------------------------------------------
#. . Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
# -----------------------------------------------

SELECT DISTINCT first_name,last_name
FROM actor
WHERE last_name = 'Gibson';

# -----------------------------------------------
#. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
# -----------------------------------------------

SELECT DISTINCT actor_id,first_name,last_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20;


# -----------------------------------------------
#.Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
# -----------------------------------------------

SELECT title,rating
FROM film
WHERE rating  NOT IN ('R','PG-13')
ORDER BY Title ASC;


# -----------------------------------------------
# Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento
# -----------------------------------------------

SELECT rating, COUNT(film_id) AS total_peliculas
FROM film
GROUP BY rating;


# -----------------------------------------------------------------------------------------
/*.Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, 
su nombre y apellido junto con la cantidad de películas alquiladas.
 ------------------------------------------------------------------------------------------*/
 
 SELECT
		 c.customer_id AS ID_cliente,
		 c.first_name AS nombre_cliente,
		 c.last_name AS apellido_cliente,
		 COUNT(r.rental_id) AS numero_peliculas
 FROM  customer as  c
 INNER JOIN rental as r
 ON c.customer_id = r.customer_id
 GROUP BY c.customer_id,
		 c.first_name ,
		 c.last_name ;
         
         
         
         # -----------------------------------------------------------------------------------------
/*.. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría
junto con el recuento de alquileres.
 ------------------------------------------------------------------------------------------*/
 
 SELECT 
		# c.category_id as id_categoria -- para ver de donde he sacado la categoria
        
		c.name as nombre_categoria,
        
         COUNT(r.rental_id) AS numero_peliculas
         
 FROM category as c
 
		 INNER  JOIN film_category as fc
				ON c.category_id =   fc.category_id  # uno de category a film_category
		INNER JOIN inventory as i
				ON fc.film_id= i.film_id # uno de film category a inventory gracias a film id
		INNER JOIN rental as r
				ON i.inventory_id = r.inventory_id
                
GROUP BY c.category_id ,
		c.name ;

# -----------------------------------------------------------------------------------------
/*.. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y
muestra la clasificación junto con 
el promedio de duración.
 ------------------------------------------------------------------------------------------*/


SELECT 
	#c.category_id ,
    c.name as nombre_categoria,
    
    AVG(f.length) as media_duracion_minutos
    
FROM category as c
	INNER JOIN film_category as fc
		ON c.category_id = fc.category_id # subo de category a film category
	INNER JOIN film as f
		ON fc.film_id = f.film_id
GROUP BY 
c.name;

# -------------------------------------------------------------------------------------------------------
/*... Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
 --------------------------------------------------------------------------------------------------------*/
 
 
 SELECT 
		 a.first_name AS nombre,
		 a.last_name AS apellido,
         f.title AS titulo_pelicula

FROM actor AS a
	INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
	INNER JOIN film as f
		ON fa.film_id = f.film_id

WHERE f.title in ('Indian Love');
    
    
# -------------------------------------------------------------------------------------------------------
/*... Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción
 --------------------------------------------------------------------------------------------------------*/

SELECT
	title as Titulo

FROM film as f
WHERE description REGEXP 'dog' or ' cat';

/*-------------------------------------------------------------------------------------------------------
Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor
--------------------------------------------------------------------------------------------------------*/

SELECT 
	a.actor_id,
    a.first_name,
    a.last_name,
    
    COUNT(f.film_id ) as numero_peliculas 
FROM actor as a
	LEFT JOIN film_actor as fc
		On a.actor_id = fc.actor_id # uno las tablas actor y actor id
	LEFT JOIN film as f
		On fc.film_id = f.film_id # unido a film desde film actor 
 GROUP BY
 a.actor_id,
    a.first_name,
    a.last_name
ORDER BY numero_peliculas ASC;
## la que menos ha hecho ha sido emily dee con pelis
 
 SELECT 
	a.actor_id,
    a.first_name,
    a.last_name,
    
    COUNT(f.film_id ) as numero_peliculas 
FROM actor as a
	LEFT JOIN film_actor as fc
		On a.actor_id = fc.actor_id # uno las tablas actor y actor id
	LEFT JOIN film as f
		On fc.film_id = f.film_id # unido a film desde film actor 
 GROUP BY
 a.actor_id,
    a.first_name,
    a.last_name
HAVING COUNT(f.film_id ) = 0
ORDER BY numero_peliculas ASC;

/* -------------------------------------------------------------------------------------------------------
16  Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
--------------------------------------------------------------------------------------------------------*/

SELECT 
		title as titulo,
		release_year as año_lanzamiento

FROM film
 WHERE release_year BETWEEN 2005 and 2010;
