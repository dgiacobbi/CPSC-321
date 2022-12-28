
/**********************************************************************
 * NAME: David Giacobbi
 * CLASS: CPSC 321-01
 * DATE: 11/12/22
 * HOMEWORK: HW-6 SQL Analytics
 * DESCRIPTION: This project uses the cpsc321 database to perform analytical
                queries that practice using aggregate functions, GROUP BY
                methods, and other analytics.
 **********************************************************************/

-- Question 1: Aggregate funciton practice (use AS to rename titles)
SELECT COUNT(*) AS num_films, MIN(length) AS min_length, MAX(length) AS max_length, 
       AVG(length) AS avg_length, COUNT(DISTINCT special_features) AS special_features
FROM film;


-- Question 2: GROUP BY practice with aggregate functions
SELECT rating, COUNT(*) AS num_films, ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
ORDER BY avg_length DESC;


-- Question 3: GROUP BY practice with joined tables
SELECT rating, COUNT(actor_id) AS num_actors
FROM film_actor JOIN film USING (film_id)
                JOIN actor USING (actor_id)
GROUP BY rating
ORDER BY num_actors DESC;


-- Question 4: Aggregate function practice with a GROUP BY on multiple joins
SELECT name, COUNT(film_id) AS num_films, MIN(rental_rate) AS min_rate, MAX(rental_rate) AS max_rate,
             ROUND(AVG(rental_rate), 2) AS avg_rate, MIN(replacement_cost) AS min_cost, 
             MAX(replacement_cost) AS max_cost, ROUND(AVG(replacement_cost), 2) AS avg_cost
FROM film_category JOIN film USING (film_id)
                   JOIN category USING (category_id)
GROUP BY name
ORDER BY name;


-- Question 5: GROUP BY practice with focus on joining the right tables
SELECT rating, COUNT(film_id) AS num_rentals
FROM film_category JOIN film USING (film_id)
                   JOIN category USING (category_id)
                   JOIN inventory USING (film_id)
                   JOIN rental USING (inventory_id)
WHERE name = "Horror" AND store_id = 1
GROUP BY rating
ORDER BY num_rentals DESC;


-- Question 6: Practice using LIMIT clause with GROUP BY and aggregates
SELECT title, rating, COUNT(film_id) AS num_rentals
FROM film_category JOIN film USING (film_id)
                   JOIN category USING (category_id)
                   JOIN inventory USING (film_id)
                   JOIN rental USING (inventory_id)
WHERE name = "Horror"
GROUP BY title
ORDER BY num_rentals DESC
LIMIT 15;
             

-- Question 7: Practice using HAVING clause with a GROUP BY
SELECT title, COUNT(film_id) AS num_rentals
FROM film_category JOIN film USING (film_id)
                   JOIN category USING (category_id)
                   JOIN inventory USING (film_id)
                   JOIN rental USING (inventory_id)
WHERE name = "Action" AND rating = "G"
GROUP BY title
HAVING num_rentals >= 15
ORDER BY num_rentals DESC;


-- Question 8: Practice GROUP BY with two attributes and multiple ORDER BY requirements
SELECT first_name, last_name, COUNT(film_id) AS num_horror_films
FROM film JOIN film_category USING (film_id)
          JOIN category USING (category_id)
          JOIN film_actor USING (film_id)
          JOIN actor USING (actor_id)
WHERE name = "Horror"
GROUP BY first_name, last_name
HAVING num_horror_films >= 4
ORDER BY num_horror_films DESC, last_name, first_name;


-- Question 9: More practice with HAVING clause
SELECT first_name, last_name, COUNT(rental_id) AS num_rentals
FROM rental JOIN customer USING (customer_id)
            JOIN inventory USING (inventory_id)
            JOIN film USING (film_id)
WHERE rating = "PG"
GROUP BY first_name, last_name
HAVING num_rentals > 10
ORDER BY num_rentals DESC, last_name, first_name;


-- Question 10: Find the names and emails of customers who have rented more than 2 family
--              movies with a PG rating. The query results should be ordered from most number
--              of rentals to least followed by customer last name and then first name.
SELECT first_name, last_name, email, COUNT(rental_id) AS num_rentals
FROM rental JOIN customer USING (customer_id)
            JOIN inventory USING (inventory_id)
            JOIN film USING (film_id)
            JOIN film_category USING (film_id)
            JOIN category USING (category_id)
WHERE rating = "PG" AND name = "Family"
GROUP BY first_name, last_name, email
HAVING num_rentals > 2
ORDER BY num_rentals DESC, last_name, first_name;