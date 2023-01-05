-- List all the customers who have made more rentals than the average cutster

SELECT *
FROM rental;


-- Get the number of each customer rentals
SELECT customer_id, COUNT(*) AS num_rentals
FROM rental 
GROUP BY customer_id;

-- Find the average rental per customer based on rental counts
SELECT AVG(num_rentals)
FROM (
	SELECT customer_id, COUNT(*) AS num_rentals
	FROM rental 
	GROUP BY customer_id
) AS customer_rental_totals;

-- Find the customers by ID who have more rentals than average
SELECT customer_id
FROM rental 
GROUP BY customer_id
HAVING COUNT(*) > (
	SELECT AVG(count)
	FROM (
		SELECT customer_id, COUNT(*)
		FROM rental 
		GROUP BY customer_id
	) AS customer_rental_average
);

-- List all customers whose id is in the list of IDs greater than the average
SELECT *
FROM customer 
WHERE customer_id IN (
	SELECT customer_id
	FROM rental 
	GROUP BY customer_id
	HAVING COUNT(*) > (
		SELECT AVG(count)
		FROM (
			SELECT customer_id, COUNT(*)
			FROM rental 
			GROUP BY customer_id
		) AS customer_rental_average
	)
);

SELECT *
FROM film_actor;


-- Join film to film_actor
SELECT *
FROM film_actor fa 
JOIN film f 
ON fa.film_id = f.film_id;


SELECT *
FROM film_actor fa 
JOIN actor a 
ON fa.actor_id = a.actor_id;



SELECT f.film_id, f.title, f.release_year, a.first_name, a.last_name
FROM film f 
JOIN film_actor fa 
ON f.film_id = fa.film_id 
JOIN actor a 
ON fa.actor_id = a.actor_id;


SELECT f.film_id, f.title, f.release_year, a.first_name, a.last_name
FROM film f 
JOIN film_actor fa 
ON f.film_id = fa.film_id 
JOIN actor a 
ON fa.actor_id = a.actor_id
ORDER BY f.film_id;



-- SUBQUERIES!!!

-- Subqueries are queries that happen within another query


-- Ex. Which films have exactly 12 actors in them?

-- Step 1. Get the ids of the movies that have 12 actors
SELECT film_id
FROM film_actor
GROUP BY film_id
HAVING COUNT(*) = 12;

SELECT film_id, COUNT(*)
FROM film_actor
GROUP BY film_id 
HAVING COUNT(*) = 12;

--529
--802
--34
--892
--414
--517

-- Step 2. Get the rows from the film table that have film ids in the above list of films

SELECT *
FROM film f 
WHERE film_id IN (
	529,
	802,
	34,
	892,
	414,
	517
);


-- Create a Subquery: Combine the two steps into one query. The query that you want executed FIRST is the
-- subquery. ** Subquery must return only ONE column**    *unless used in a FROM

SELECT *
FROM film 
WHERE film_id IN (
	SELECT film_id
	FROM film_actor
	GROUP BY film_id 
	HAVING COUNT(*) = 12
);


-- Which staff member had the highest cumulative sales
SELECT *
FROM staff 
WHERE staff_id = (
	SELECT staff_id
	FROM payment
	GROUP BY staff_id
	ORDER BY SUM(amount) DESC
	LIMIT 1
);


-- Use subqueries for calculations
-- List out all of the payments that are more thatn the average payment amount

SELECT AVG(amount)
FROM payment;


SELECT *
FROM payment 
WHERE amount > (
	SELECT AVG(amount)
	FROM payment
)
ORDER BY amount;



-- Subqueries with a FROM clause
-- *Subquery in FROM must have an alias*

-- List all the customers who have made more rentals than the average cutster

SELECT *
FROM rental;


-- Get the number of each customer rentals
SELECT customer_id, COUNT(*) AS num_rentals
FROM rental 
GROUP BY customer_id;

-- Find the average rental per customer based on rental counts
SELECT AVG(num_rentals)
FROM (
	SELECT customer_id, COUNT(*) AS num_rentals
	FROM rental 
	GROUP BY customer_id
) AS customer_rental_totals;

-- Find the customers by ID who have more rentals than average
SELECT customer_id
FROM rental 
GROUP BY customer_id
HAVING COUNT(*) > (
	SELECT AVG(count)
	FROM (
		SELECT customer_id, COUNT(*)
		FROM rental 
		GROUP BY customer_id
	) AS customer_rental_average
);

-- List all customers whose id is in the list of IDs greater than the average
SELECT *
FROM customer 
WHERE customer_id IN (
	SELECT customer_id
	FROM rental 
	GROUP BY customer_id
	HAVING COUNT(*) > (
		SELECT AVG(count)
		FROM (
			SELECT customer_id, COUNT(*)
			FROM rental 
			GROUP BY customer_id
		) AS customer_rental_average
	)
);


SELECT first_name AS actor_first_name
FROM actor;



-- (DDL) Add a column on the customer table for loyalty member and set everyone to FALSE 
ALTER TABLE customer 
ADD COLUMN loyalty_member BOOLEAN DEFAULT FALSE;

SELECT *
FROM customer;


-- Use subqueries in DML statements
-- Update all customer who have made more 25 or more rentals 


-- Step 1. Find all of the customer ids of the customers who made more than 25 rentals
SELECT customer_id
FROM rental
GROUP BY customer_id
HAVING COUNT(*) > 25
ORDER BY COUNT(*);

-- Update the customer table to set loyalty_member = True if customer is in the list of IDs
UPDATE customer 
SET loyalty_member = TRUE 
WHERE customer_id IN (
	SELECT customer_id
	FROM rental
	GROUP BY customer_id
	HAVING COUNT(*) > 25
);

SELECT *
FROM customer 
WHERE loyalty_member = FALSE;








--SELECT *
--FROM film 
--WHERE film_id IN (
--	SELECT customer_id
--	FROM rental
--	GROUP BY customer_id
--	HAVING COUNT(*) > 25
--);


-- Joins and Subqueries

SELECT c.customer_id, first_name, last_name, rental_id, rental_date
FROM customer c 
JOIN rental r 
ON c.customer_id = r.customer_id
WHERE c.customer_id IN (
	SELECT customer_id
	FROM rental
	GROUP BY customer_id
	HAVING COUNT(*) < 25
	ORDER BY COUNT(*)
)
ORDER BY c.customer_id;
