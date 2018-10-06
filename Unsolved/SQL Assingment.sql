USE sakila;

-- 1a
SELECT first_name, last_name
FROM actor;

-- 1b
SELECT CONCAT(first_name, last_name) AS "Actor Name"
FROM actor;

-- 2a
DESCRIBE actor;
SELECT first_name, last_name, actor_id
FROM actor
WHERE first_name = "Joe";

-- 2b
SELECT * FROM actor
WHERE last_name LIKE "%GEN%";

-- 2c
SELECT last_name, first_name
FROM actor
WHERE last_name LIKE "%LI%";

-- 2d
DESCRIBE country;

SELECT country_id, country FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

-- 3a
ALTER TABLE actor
ADD COLUMN description BLOB(1000);

-- 3b
ALTER TABLE actor
DROP COLUMN description;


-- 4a
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name;

-- 4b
SELECT last_name, COUNT(last_name) AS "Count"
FROM actor
GROUP BY last_name
HAVING Count >1;

-- 4c
UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";

-- 4d
UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO";

-- 5a
SHOW CREATE TABLE address;

-- 6a
SELECT first_name, last_name, address
FROM staff s
LEFT OUTER JOIN address a
ON s.address_id = a.address_id;

-- 6b
SELECT s.first_name, s.last_name, sum(p.amount) AS "Total Rung Up"
FROM staff s
LEFT OUTER JOIN payment p
ON s.staff_id = p.staff_id
GROUP BY first_name;

-- 6c
SELECT f.title, COUNT(a.actor_id) AS "Number of Actor"
FROM film f
INNER JOIN film_actor a
ON f.film_id = a.film_id
GROUP BY title;

-- 6d
SELECT f.title, COUNT(i.film_id) AS "Number of Copies"
FROM film f
INNER JOIN inventory i
ON f.film_id = i.film_id
GROUP BY title
HAVING title = "Hunchback Impossible";

-- 6e
SELECT c.first_name, c.last_name, SUM(p.amount) AS "Total Payment"
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY last_name ASC;

-- 7a
SELECT title 
FROM film
WHERE (title LIKE "K%") OR (title LIKE "Q%")
AND language_id IN
	(
		SELECT language_id
		FROM language
        WHERE name = "English"
	);
    
-- 7b
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
	(
		SELECT actor_id
        FROM film_actor
        WHERE film_id IN
			(
				SELECT film_id
                FROM film
                WHERE title = "Alone Trip"
			)
	);
    
-- 7c
SELECT c.first_name, c.last_name, c.email, ct.country
FROM customer c
JOIN address a
ON c.address_id = a.address_id
JOIN city cy
ON a.city_id = cy.city_id
JOIN country ct
ON cy.country_id = ct.country_id
WHERE country = "Canada";

-- 7d
SELECT f.title
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
WHERE name = "Family";


-- 7e
SELECT f.title, COUNT(r.inventory_id) AS "Rental Count"
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY f.title;

-- 7f
