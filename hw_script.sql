use sakila;

#1a.
select first_name, last_name from actor;

#1b.
select concat(first_name, " ", last_name) as "Actor Name" from actor;

#2a.
select actor_id, first_name, last_name
from actor
where first_name = "Joe";

#2b.
select * from actor
where last_name like "%gen%";

#2c.
select * from actor
where last_name like "%li%"
order by last_name, first_name;

#2d.
select country_id, country from country
where country in ("Afghanistan", "Bangladesh", "China");

#3a.
alter table actor add description blob;

#3b.
alter table actor drop column description;

#4a.
select last_name, count(last_name) from actor
group by last_name;

#4b.
select last_name, count(last_name) from actor
group by last_name
having count(last_name) >= 2;

#4c.
update actor set first_name = "Harpo"
where first_name = "Groucho";

#4d.
update actor set first_name = "Groucho"
where first_name = "Harpo";

#5a.
show create table address;

#6a.
select s.first_name, s.last_name, a.address
from staff s left outer join address a
on s.address_id = a.address_id;

#6b.
select s.first_name, s.last_name, sum(p.amount)
from (select * from payment where payment_date like "%-08-%") p
left outer join staff s
on s.staff_id = p.staff_id
group by s.first_name, s.last_name;

#6c.
select f.title, count(fa.actor_id) 
from film f
inner join film_actor fa
on f.film_id = fa.film_id
group by f.title;

#6d.
select count(i.film_id) as copies
from inventory i
where i.film_id = (select film_id from film
where title = "Hunchback Impossible");

#6e.
select c.last_name, sum(p.amount)
from payment p
left outer join customer c
on c.customer_id = p.customer_id
group by c.last_name
order by c.last_name;

#7a.
select f.title
from film f
left outer join language l
on f.language_id = l.language_id
having f.title like "K%" or f.title like "Q%";

#7b.
select a.first_name, a.last_name 
from (
	select actor_id 
	from film_actor 
	where film_id = (
		select film_id 
		from film 
		where title = "Alone Trip")) ab
left outer join actor a
on ab.actor_id = a.actor_id;

#7c.
select c.first_name, c.last_name, c.email
from customer c
left outer join address a
on c.address_id = a.address_id
left outer join city ci
on a.city_id = ci.city_id
left outer join country co
on ci.country_id = co.country_id
where co.country = "Canada";

#7d.
select f.title
from film f
left outer join film_category fc
on f.film_id = fc.film_id
left outer join category c
on fc.category_id = c.category_id
where c.name = "Family";

#7e.
select f.title, count(f.title)
from rental r
left outer join inventory i
on r.inventory_id = i.inventory_id
left outer join film f
on i.film_id = f.film_id
group by f.title
order by count(f.title) desc, title asc;

#7f.
select * from sales_by_store;

#7g.
select s.store_id, c.city, co.country
from store s
left outer join address a
on s.address_id = a.address_id
left outer join city c
on a.city_id = c.city_id
left outer join country co
on c.country_id = co.country_id;

#7h.
select c.name, sum(p.amount) as revenue
from payment p
left outer join rental r
on p.rental_id = r.rental_id
left outer join inventory i
on r.inventory_id = i.inventory_id
left outer join film_category fc
on i.film_id = fc.film_id
left outer join category c
on fc.category_id = c.category_id
group by c.name
order by revenue desc
limit 5;

#8a.
create view revenue_by_category as
(select c.name, sum(p.amount) as revenue
from payment p
left outer join rental r
on p.rental_id = r.rental_id
left outer join inventory i
on r.inventory_id = i.inventory_id
left outer join film_category fc
on i.film_id = fc.film_id
left outer join category c
on fc.category_id = c.category_id
group by c.name
order by revenue desc
limit 5);

#8b.
select * from revenue_by_category;

#8c.
drop view revenue_by_category;