-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). 
-- Select only columns title, length and rank in your output.
SELECT TITLE, LENGTH,
RANK() OVER (ORDER BY LENGTH DESC) AS LENGTH_RANKING
FROM SAKILA.FILM
WHERE LENGTH <> '0' OR LENGTH <> ' ';

-- 2. Rank films by length within the rating category 
-- (filter out the rows with nulls or zeros in length column). 
-- In your output, only select the columns title, length, rating and rank.
SELECT TITLE, LENGTH, RATING,
RANK() OVER (PARTITION BY RATING ORDER BY LENGTH DESC) AS LENGTH_RANKING
FROM SAKILA.FILM
WHERE LENGTH <> '0' OR LENGTH IS NOT NULL;

-- 3. How many films are there for each of the categories in the category table? 
-- Hint: Use appropriate join between the tables "category" and "film_category"
SELECT Category.NAME AS CATEGORY, COUNT(FILM_CAT.FILM_ID) AS FILM_COUNT
FROM SAKILA.CATEGORY Category
INNER JOIN SAKILA.FILM_CATEGORY FILM_CAT ON Category.CATEGORY_ID = FILM_CAT.CATEGORY_ID
GROUP BY Category.NAME;

-- 4. Which actor has appeared in the most films? 
-- Hint: You can create a join between the tables "actor" and "film actor" and 
-- count the number of times an actor appears.
SELECT Actor.ACTOR_ID AS ACTORS, Actor.FIRST_NAME, Actor.LAST_NAME, COUNT(Film_Actor.FILM_ID) AS FILM_COUNT
FROM SAKILA.ACTOR Actor
LEFT JOIN SAKILA.FILM_ACTOR Film_Actor
ON Actor.ACTOR_ID = Film_Actor.ACTOR_ID
GROUP BY Actor.ACTOR_ID
ORDER BY FILM_COUNT DESC
LIMIT 1;

-- 5. Which is the most active customer (the customer that has rented the most number of films)? 
-- Hint: Use appropriate join between the tables "customer" and "rental" and 
-- count the rental_id for each customer.
SELECT Customer.CUSTOMER_ID, COUNT(Rental.RENTAL_ID)
FROM SAKILA.CUSTOMER Customer
LEFT JOIN SAKILA.RENTAL Rental
ON Customer.CUSTOMER_ID = Rental.CUSTOMER_ID
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;