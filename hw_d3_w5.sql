1. List all customers who live in Texas (use JOINs)


select c.first_name, c.last_name, a.district 
from customer c 
join address a 
on c.customer_id = a.address_id
where a.district = 'Texas';
--good

2. List all payments of more than $7.00 with the customer’s first and last name

select c.first_name, c.last_name, p.amount 
from customer c 
join payment p
on c.customer_id = p.customer_id 
where p.amount > '7.00';
---good

3. Show all customer names who have made over $175 in payments (use
subqueries)

select *
from customer c 
where customer_id in (
459,
144,
137,
178,
526,
148);

select *
from customer c 
where customer_id in (
	select p.customer_id
	from payment p
	group by p.customer_id
	having sum(p.amount) >175
	order by sum(p.amount));    --- WINNNNER


4. List all customers that live in Argentina (use the city table)

select c3.first_name, c3.last_name, a.district, c2.city, c.country 
from customer c3
join address a 
on c3.address_id = a.address_id 
join city c2
on a.city_id = c2.city_id
join country c  
on c2.country_id = c.country_id 
where c.country = 'Argentina';




5. Show all the film categories with their count in descending order


select fc.category_id, c."name", count (*) as num_movies_in_cat
from film_category fc
join category c 
on fc.category_id = c.category_id 
group by fc.category_id, c."name" 
order by num_movies_in_cat desc; 

6. What film had the most actors in it (show film info)?

select 

select fa.actor_id, count (*) as num_actors
from film_actor fa
group by fa.actor_id;

-- get the number of each film's actors
select fa.film_id, count (*) as num_actors
from film_actor fa
group by fa.film_id; -- best bet

--find the max actors
select max(num_actors)
from(

select fa.film_id, c."name", count (*) as num_actors
from film_actor fa
join category c 
group by fa.film_id
order by num_actors desc
limit 1;

) as most_actors_in_film; -----best bet

select fa.film_id, count (*) as num_actors
from film_actor fa
group by fa.film_id
order by num_actors desc
limit 1;


--find the film id for the max actors

select film_id, num_actors
from film_actor fa 
group by film_id 


order by film_id; 


order by .... desc
limit 1 



7. Which actor has been in the least movies?

select a2.actor_id, fa.film_id 
from actor a2 
join film_actor fa 
on a2.actor_id  = fa.film_id; 


8. Which country has the most cities?

select c.country_id, c2.city 
from country c 
join city c2 
on c2.city_id = c.country_id;




9. List the actors who have been in between 20 and 25 films.