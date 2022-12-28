
/**********************************************************************
 * NAME: David Giacobbi
 * CLASS: CPSC 321-01
 * DATE: 12/2/22
 * HOMEWORK: #8
 * DESCRIPTION: This homework includes exercises that practice SQL set
                operations, views, case statements, common table expressions,
                and window functions.
 **********************************************************************/

-- Drop created views if they exist
DROP VIEW IF EXISTS customer_rental;

-- Question 1: 
CREATE VIEW customer_rental AS
    SELECT customer_id, first_name, last_name, rental_date, film_id, title
    FROM cpsc321.rental JOIN cpsc321.customer USING (customer_id)
                        JOIN cpsc321.inventory USING (inventory_id)
                        JOIN cpsc321.film USING (film_id)
    ORDER BY last_name, first_name, rental_date;

SELECT * FROM customer_rental;

-- Question 2:
WITH film_update (film_id, type, last_update) AS (
    (SELECT film_id, "actor" AS type, last_update
    FROM cpsc321.film_actor)
    UNION
    (SELECT film_id, "category" AS type, last_update
    FROM cpsc321.film_category)
    UNION
    (SELECT film_id, "inventory" AS type, last_update
    FROM cpsc321.inventory)
)
SELECT film_id, title, type, u.last_update
FROM film_update u JOIN cpsc321.film f USING (film_id)
                   JOIN cpsc321.film_category fc USING (film_id)
                   JOIN cpsc321.category c USING (category_id)
WHERE name = "Action"
ORDER BY title, last_update;


-- Question 3:
SELECT film_id, title, rating, length, 
       CASE
           WHEN length <= 50 THEN "short"
           WHEN length > 50 AND length < 80 THEN "featurette"
           ELSE "feature"
       END AS type
FROM cpsc321.film;


-- Question 4:
SELECT film_id, title, rating, length, 
       DENSE_RANK() OVER (PARTITION BY rating ORDER BY length) as rank
FROM cpsc321.film;

-- Question 5:
WITH movie_ranks (film_id, title, rating, length, rank) AS (
    SELECT film_id, title, rating, length, 
       DENSE_RANK() OVER (PARTITION BY rating ORDER BY length) as rank
    FROM cpsc321.film
)
SELECT film_id, title, rating, length
FROM movie_ranks
WHERE rank > 0 AND rank <= 5;