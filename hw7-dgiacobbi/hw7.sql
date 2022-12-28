
/**********************************************************************
 * NAME: David Giacobbi
 * CLasS: CPSC 321-01
 * DATE: 11/26/22
 * HOMEWORK: #7
 * DESCRIPTION: The purpose of this program is to practice writing subqueries,
                utilizing the cpsc321 database on MariaDB.
 **********************************************************************/


-- Quesiton 1: 
SELECT film_id, title, length
FROM film
WHERE length >= ALL(SELECT length FROM film);

-- Question 2:
SELECT film_id, title, length
FROM film
WHERE rating = 'G' AND length >= ALL(SELECT length FROM film);

-- Question 3:
SELECT DISTINCT first_name, last_name
FROM actor JOIN film_actor USING (actor_id)
           JOIN film USING (film_id)
WHERE actor_id NOT IN (SELECT actor_id
                       FROM actor JOIN film_actor USING (actor_id)
                                  JOIN film USING (film_id)
                       WHERE rating = 'R');

-- Question 4:
SELECT name, COUNT(*) as num_g_rated_films
FROM category JOIN film_category USING (category_id)
              JOIN film USING (film_id)
WHERE rating = 'G'
GROUP BY name
HAVING num_g_rated_films >= ALL (SELECT COUNT(*)
                                 FROM category JOIN film_category USING (category_id)
                                               JOIN film USING (film_id)
                                 WHERE rating = 'G'
                                 GROUP BY name);

-- Question 5:
SELECT title, COUNT(*) AS num_rentals
FROM rental JOIN inventory USING (inventory_id)
            JOIN film USING (film_id)
WHERE rating = 'PG'
GROUP BY title
HAVING num_rentals > (SELECT AVG(a.num_rentals)
                      FROM (SELECT COUNT(*) AS num_rentals
                            FROM rental r JOIN inventory i USING (inventory_id)
                                          JOIN film f USING (film_id)
                            WHERE f.rating = 'PG'
                            GROUP BY f.title) AS a)
ORDER BY num_rentals DESC;

-- Question 6:
SELECT b.actor_id, b.first_name, b.last_name, (COUNT(*) / (SELECT COUNT(*)
                                                           FROM actor a JOIN film_actor fa USING (actor_id)
                                                                        JOIN film f USING (film_id)
                                                           WHERE a.actor_id = b.actor_id
                                                           GROUP BY a.actor_id)) as pct
FROM actor b JOIN film_actor USING (actor_id)
             JOIN film USING (film_id)
WHERE rating = 'PG'
GROUP BY actor_id
HAVING pct > 0
ORDER BY pct DESC;

-- Question 7:
SELECT DISTINCT f1.title
FROM inventory i1 JOIN film f1 USING (film_id)
WHERE f1.film_id IN (SELECT f2.film_id
                     FROM film f2 JOIN inventory i2 USING (film_id)
                     WHERE i1.store_id != i2.store_id);



-- Question 8:
SELECT first_name, last_name, COUNT(*) AS rentals_sold
FROM staff JOIN rental USING (staff_id)
GROUP BY staff_id
HAVING rentals_sold >= ALL (SELECT COUNT(*)
                            FROM staff JOIN rental USING (staff_id)
                            GROUP BY staff_id)
ORDER BY rentals_sold DESC;