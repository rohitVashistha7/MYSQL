-- Q1 
CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY NOT NULL,
    emp_name TEXT NOT NULL,
    age INTEGER CHECK (age >= 18),
    email  varchar(100) UNIQUE,
    salary DECIMAL DEFAULT 30000
);

-- Q2
-- Purpose of Constraints in a Database:
-- Constraints are rules applied to columns in a database table to enforce data accuracy, consistency, and reliability. 
-- They ensure that the data entered into the database follows predefined standards, which helps maintain data integrity.

-- EXAMPLE:
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(255) UNIQUE,
    salary DECIMAL(10,2) DEFAULT 30000.00
);

-- Q3 
-- The NOT NULL constraint ensures that a column must always have a value — it prevents null (missing) values in that column.
-- Purpose:
-- To enforce required fields like names, emails, or IDs that are essential for record identification or processing.
-- To maintain data completeness and integrity — for example, an order without a customer ID is invalid in most systems.

-- EXAMPLE:
-- emp_name VARCHAR(100) NOT NULL

-- Q4
-- In SQL, you can use the ALTER TABLE statement to add or remove constraints from an existing table.  

-- 1. Add a Constraint
-- SYNTAX:
-- ALTER TABLE table_name ADD CONSTRAINT constraint_name constraint_type;

-- Example: Add a UNIQUE constraint to the email column
-- ALTER TABLE employees ADD CONSTRAINT uq_email UNIQUE (email);

-- 	2. Remove a Constraint
-- ALTER TABLE table_name DROP CONSTRAINT constraint_name;

-- Example: Remove the UNIQUE constraint from email
-- ALTER TABLE employees DROP INDEX uq_email;


-- Q5
-- Consequences of Violating Constraints in SQL
-- When you insert, update, or delete data in a way that violates constraints, 
-- the RDBMS will reject the operation and return an error. This protects the integrity and consistency of your data.

-- Q6
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2));
 -- 	1. Make product_id a PRIMARY KEY
			ALTER TABLE products ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);
 
 -- 	2. Set a DEFAULT value of 50.00 for price
			ALTER TABLE products ALTER COLUMN price SET DEFAULT 50.00;


 -- Q7.  Fetch the student_name and class_name for each student using an INNER JOIN. 
 SELECT s.student_name, c.class_name
FROM students s
INNER JOIN classes c ON s.class_id = c.class_id;

-- Q8. LEFT JOIN to Show All Products
SELECT o.order_id, c.customer_name, p.product_name
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
LEFT JOIN customers c ON o.customer_id = c.customer_id;


-- Q9. Total Sales Per Product
SELECT p.product_name, SUM(o.quantity * o.price_per_unit) AS total_sales
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name;

-- Q10. INNER JOIN for Orders with Customer Names
SELECT o.order_id, c.customer_name, od.quantity
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_details od ON o.order_id = od.order_id;



-- ********************* SQL COMMANDS *********************

-- Q1. Identify the primary and foreign keys in Maven Movies DB

-- actor(actor_id) → Primary Key
-- film(film_id) → Primary Key
-- inventory(inventory_id) → Primary Key
-- rental(rental_id) → Primary Key
-- customer(customer_id) → Primary Key

-- Foreign Keys:
-- film_actor(film_id, actor_id) → FK to film, FK to actor
-- inventory(film_id) → FK to film
-- inventory(store_id) → FK to store
-- rental(customer_id) → FK to customer
-- payment(customer_id) → FK to customer
-- payment(rental_id) → FK to rental


-- Q2. List all details of actors
SELECT * FROM actor;

-- Q3. List all customer information
SELECT * FROM customer;


-- Q4. List different countries
SELECT DISTINCT country FROM country;

-- Q7. Films with rental duration greater than 5
SELECT * FROM film WHERE rental_duration > 5;

-- Q8. Number of films with replacement cost between $15 and $20
SELECT COUNT(*)  FROM film WHERE replacement_cost > 15 AND replacement_cost < 20;

-- Q9. Count of unique first names of actors
SELECT COUNT(DISTINCT first_name) FROM actor;

-- Q10. First 10 records from customer table
SELECT * FROM customer LIMIT 10;

-- Q11. First 3 customers whose first name starts with 'b'
SELECT * FROM customer 
WHERE first_name ILIKE 'b%' 
LIMIT 3;

-- Q12. First 5 movies rated as ‘G’
SELECT title FROM film 
WHERE rating = 'G' 
LIMIT 5;


-- Q13. Customers whose first name starts with 'a'
SELECT * FROM customer 
WHERE first_name ILIKE 'a%';

-- Q14. Customers whose first name ends with 'a'
SELECT * FROM customer 
WHERE first_name ILIKE '%a';

-- Q15. First 4 cities starting and ending with ‘a’
SELECT city 
FROM city 
WHERE city ILIKE 'a%a' 
LIMIT 4;

-- Q16. Customers whose first name contains 'NI'
SELECT * FROM customer 
WHERE first_name ILIKE '%ni%';

-- Q17. Customers with 'r' as second letter in first name
SELECT * FROM customer 
WHERE first_name ILIKE '_r%';

-- Q18. First name starts with 'a' and length ≥ 5
SELECT * FROM customer 
WHERE first_name ILIKE 'a%' AND LENGTH(first_name) >= 5;

-- Q19. First name starts with 'a' and ends with 'o'
SELECT * FROM customer 
WHERE first_name ILIKE 'a%o';

-- Q20. Films rated PG or PG-13
SELECT * FROM film 
WHERE rating IN ('PG', 'PG-13');

-- Q21. Films with length between 50 and 100
SELECT * FROM film 
WHERE length BETWEEN 50 AND 100;

-- Q22. Top 50 actors
SELECT * FROM actor  LIMIT 50;


-- Q23. Distinct film IDs from inventory
SELECT DISTINCT film_id 
FROM inventory;


-- ******************************** FUNCTIONS *************************

-- Q1. Retrieve the total number of rentals made in the Sakila database
SELECT COUNT(*) AS total_rentals FROM rental;

-- Q2. Find the average rental duration (in days) of movies rented
SELECT AVG(rental_duration) AS average_duration FROM film;

-- Q3. Display the first name and last name of customers in uppercase
SELECT UPPER(first_name) AS first_name, UPPER(last_name) AS last_name FROM customer;

-- Q4. Extract the month from the rental date and display it alongside the rental ID
SELECT rental_id, MONTH(rental_date) AS rental_month FROM rental;


-- ******************************** GROUP BY *************************

-- Q5. Retrieve the count of rentals for each customer
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;

-- Q6. Find the total revenue generated by each store
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN staff s ON p.staff_id = s.staff_id
GROUP BY s.store_id;

-- Q7. Determine the total number of rentals for each category of movies
SELECT c.name AS category_name, COUNT(*) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- Q8. Find the average rental rate of movies in each language
SELECT l.name AS language, AVG(f.rental_rate) AS avg_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;


-- ******************************** JOINS *************************

-- Q9. Display the title of the movie, customer's first name, and last name who rented it
SELECT f.title, c.first_name, c.last_name
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id;

-- Q10. Retrieve the names of all actors who have appeared in the film "Gone with the Wind"
SELECT a.first_name, a.last_name
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE f.title = 'Gone with the Wind';

-- Q11. Retrieve the customer names along with the total amount they've spent on rentals
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

-- Q12. List the titles of movies rented by each customer in a particular city (e.g., 'London')
SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
GROUP BY c.first_name, c.last_name, f.title;


-- ******************************** ADVANCED JOINS & GROUP BY *************************

-- Q13. Display the top 5 rented movies along with the number of times they've been rented
SELECT f.title, COUNT(*) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 5;

-- Q14. Determine the customers who have rented movies from both stores (store ID 1 and store ID 2)
SELECT customer_id
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY customer_id
HAVING COUNT(DISTINCT i.store_id) = 2;


-- ************************************** WINDOW FUNCTIONS *************************

-- Q1. Rank the customers based on the total amount they've spent on rentals
SELECT customer_id, 
       SUM(amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(amount) DESC) AS spending_rank
FROM payment
GROUP BY customer_id;

-- Q2. Calculate the cumulative revenue generated by each film over time
SELECT f.title,
       p.payment_date,
       SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY p.payment_date) AS cumulative_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id;

-- Q3. Determine the average rental duration for each film, considering films with similar lengths
SELECT film_id,
       length,
       AVG(rental_duration) OVER (PARTITION BY length) AS avg_duration_for_length
FROM film;

-- Q4. Identify the top 3 films in each category based on their rental counts
WITH rental_counts AS (
    SELECT fc.category_id, f.title, COUNT(*) AS rental_count,
           RANK() OVER (PARTITION BY fc.category_id ORDER BY COUNT(*) DESC) AS rnk
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    GROUP BY fc.category_id, f.title
)
SELECT * FROM rental_counts WHERE rnk <= 3;

-- Q5. Calculate the difference in rental counts between each customer's total rentals and the average rentals
WITH rental_counts AS (
    SELECT customer_id, COUNT(*) AS total_rentals
    FROM rental
    GROUP BY customer_id
),
avg_rental AS (
    SELECT AVG(total_rentals) AS avg_rentals FROM rental_counts
)
SELECT rc.customer_id, rc.total_rentals,
       rc.total_rentals - ar.avg_rentals AS rental_diff
FROM rental_counts rc, avg_rental ar;

-- Q6. Find the monthly revenue trend for the entire rental store over time
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month, 
       SUM(amount) AS total_revenue
FROM payment
GROUP BY month
ORDER BY month;

-- Q7. Identify the customers whose total spending on rentals falls within the top 20% of all customers
WITH ranked_customers AS (
    SELECT customer_id, SUM(amount) AS total_spent,
           NTILE(5) OVER (ORDER BY SUM(amount) DESC) AS percentile
    FROM payment
    GROUP BY customer_id
)
SELECT * FROM ranked_customers WHERE percentile = 1;

-- Q8. Calculate the running total of rentals per category, ordered by rental count
WITH category_rentals AS (
    SELECT c.name AS category_name, COUNT(*) AS rental_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film_category fc ON i.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY c.name
)
SELECT category_name, rental_count,
       SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total
FROM category_rentals;

-- Q9. Find the films that have been rented less than the average rental count for their respective categories
WITH category_avg AS (
    SELECT fc.category_id, AVG(rental_count) AS avg_rentals
    FROM (
        SELECT fc.category_id, f.film_id, COUNT(*) AS rental_count
        FROM rental r
        JOIN inventory i ON r.inventory_id = i.inventory_id
        JOIN film f ON i.film_id = f.film_id
        JOIN film_category fc ON f.film_id = fc.film_id
        GROUP BY fc.category_id, f.film_id
    ) AS sub
    GROUP BY fc.category_id
),
film_rentals AS (
    SELECT fc.category_id, f.title, COUNT(*) AS rental_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    GROUP BY fc.category_id, f.title
)
SELECT fr.title, fr.rental_count
FROM film_rentals fr
JOIN category_avg ca ON fr.category_id = ca.category_id
WHERE fr.rental_count < ca.avg_rentals;

-- Q10. Identify the top 5 months with the highest revenue and display the revenue generated in each month
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,
       SUM(amount) AS total_revenue
FROM payment
GROUP BY month
ORDER BY total_revenue DESC
LIMIT 5;


-- *************************** Normalisation & CTE ******************

-- Q1. First Normal Form (1NF)
-- A table violates 1NF if it has repeating groups or multiple values in a column.
-- Example: customer_orders(customer_id, customer_name, order_ids) violates 1NF.
-- Solution: Split into customer and orders table, one order per row.

-- Q2. Second Normal Form (2NF)
-- A table violates 2NF if non-key attributes depend only on part of a composite primary key.
-- Example: order_details(order_id, product_id, product_name) violates 2NF.
-- Solution: Move product_name to a separate product table.

-- Q3. Third Normal Form (3NF)
-- A table violates 3NF if there are transitive dependencies (non-key attributes depend on other non-key attributes).
-- Example: staff(staff_id, branch_id, branch_address) violates 3NF.
-- Solution: Move branch_address to a separate branch table.

-- Q4. Normalization Process
-- Start with unnormalized data (multi-valued fields).
-- Apply 1NF: Remove multi-valued fields.
-- Apply 2NF: Remove partial dependencies.
-- Apply 3NF: Remove transitive dependencies.


-- Q5. Retrieve the distinct list of actor names and the number of films they have acted in
WITH actor_films AS (
    SELECT actor_id, COUNT(*) AS film_count
    FROM film_actor
    GROUP BY actor_id
)
SELECT a.first_name, a.last_name, af.film_count
FROM actor a
JOIN actor_films af ON a.actor_id = af.actor_id;

-- Q6. Display the film title, language name, and rental rate
WITH film_lang AS (
    SELECT f.film_id, f.title, f.rental_rate, l.name AS language
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT * FROM film_lang;

-- Q7. Total revenue generated by each customer (sum of payments)
WITH customer_revenue AS (
    SELECT customer_id, SUM(amount) AS total_revenue
    FROM payment
    GROUP BY customer_id
)
SELECT c.first_name, c.last_name, cr.total_revenue
FROM customer c
JOIN customer_revenue cr ON c.customer_id = cr.customer_id;

-- Q8. Rank films based on their rental duration
WITH film_ranks AS (
    SELECT title, rental_duration,
           RANK() OVER (ORDER BY rental_duration DESC) AS duration_rank
    FROM film
)
SELECT * FROM film_ranks;

-- Q9. List customers who have made more than two rentals
WITH frequent_customers AS (
    SELECT customer_id, COUNT(*) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING rental_count > 2
)
SELECT c.* 
FROM customer c
JOIN frequent_customers fc ON c.customer_id = fc.customer_id;

-- Q10. Find the total number of rentals made each month
WITH monthly_rentals AS (
    SELECT DATE_FORMAT(rental_date, '%Y-%m') AS month, COUNT(*) AS rental_count
    FROM rental
    GROUP BY month
)
SELECT * FROM monthly_rentals;

-- Q11. Show pairs of actors who have appeared in the same film
WITH actor_pairs AS (
    SELECT fa1.actor_id AS actor1, fa2.actor_id AS actor2, fa1.film_id
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE fa1.actor_id < fa2.actor_id
)
SELECT a1.first_name AS actor1_first_name, a1.last_name AS actor1_last_name,
       a2.first_name AS actor2_first_name, a2.last_name AS actor2_last_name,
       ap.film_id
FROM actor_pairs ap
JOIN actor a1 ON ap.actor1 = a1.actor_id
JOIN actor a2 ON ap.actor2 = a2.actor_id;

-- Q12. Recursive CTE to find all employees who report to a specific manager (e.g., manager_id = 1)
WITH RECURSIVE subordinates AS (
    SELECT staff_id, first_name, last_name, reports_to
    FROM staff
    WHERE reports_to = 1

    UNION ALL

    SELECT s.staff_id, s.first_name, s.last_name, s.reports_to
    FROM staff s
    JOIN subordinates sub ON s.reports_to = sub.staff_id
)
SELECT * FROM subordinates;





