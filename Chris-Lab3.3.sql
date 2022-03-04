use sakila;

#How many copies of the film Hunchback Impossible exist in the inventory system?

select count(inventory_id), film_id
from inventory
where film_id in (select film_id
from film
where title = "Hunchback Impossible");


#List all films whose length is longer than the average of all the films.

select avg(length)
from film;

select film_id, title
from film
where length > (select avg(length)
from film)
group by title;

#Use subqueries to display all actors who appear in the film Alone Trip.

select actor_id, first_name, last_name
from actor
where actor_id in (select actor_id
from film_actor
where film_id in (select film_id
from film
where title = "Alone Trip"));


#Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
#Identify all movies categorized as family films.

select * from category;

select film_id, title
from film 
where film_id in (select film_id
from film_category
where category_id = 8);

#Get name and email from customers from Canada using subqueries. 
#Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys 
#and foreign keys, that will help you get the relevant information.
select * from country;

select customer_id, first_name, last_name, email
from customer
where address_id in (select address_id
from address
where city_id in (select city_id
from city
where country_id in (select country_id
from country
where country = "Canada")));


#Which are films starred by the most prolific actor? 
#Most prolific actor is defined as the actor that has acted in the most number of films. 
#First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
select actor_id, sum(film_id)
from film_actor
group by actor_id
order by sum(film_id) desc;

select film_id, title 
from film
where film_id in (select film_id
from film_actor
where actor_id = "198");

#Films rented by most profitable customer. 
#You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
select customer_id, sum(amount)
from payment
group by customer_id
order by sum(amount) desc;

select film_id, title 
from film
where film_id in (select film_id
from inventory
where store_id in (select store_id
from customer
where customer_id = "526"));

#Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
with avg(total_amount) as
(select customer_id, sum(amount) as total_amount
from payment
group by customer_id)
select customer_id, sum(p1.amount)
from payment p1
join payment p2
using (customer_id)
where sum(p1.amount) >= avg(total_amount)
group by customer_id;
