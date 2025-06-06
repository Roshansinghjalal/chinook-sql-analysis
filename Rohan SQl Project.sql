show databases;
create database sql_project;
use sql_project;

---  Who is the senior most employee based on the Job title?

SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.title
FROM employee e
INNER JOIN (
    SELECT 
        title,
        MIN(hire_date) AS earliest_hire_date
    FROM employee
    GROUP BY title
) AS earliest_hires ON e.title = earliest_hires.title AND e.hire_date = earliest_hires.earliest_hire_date;


--- Which countries have the most invoices?

select billing_country,
count(invoice_id) as Most_invoice
from invoice 
group by billing_country ;



--- What are top three values of invoices?

select billing_country,
count(invoice_id) as Most_invoice
from invoice
group by billing_country limit 3;




--- Which city has the best customers? We would like to throw a promotional MusicFestival in the 
--- city we made the most money.
--- Write a query that returns one city that has the highest sum of invoice totals.
--- Return both the city name and sum of all invoice totals.

select billing_city,
sum(total) as Invoice_Total
from invoice
group by billing_city 
order by invoice_Total desc
limit 1;



--- Who is the best customer?
--- The customer who has spent the most money will be declared the best customer.
--- Write a query that returns the person who has spent the most money.

select
 c.customer_id,
 c.first_name,
 c.last_name,
sum(i.total) as Invoice_Total
from invoice as i
inner join customer as c
on i.customer_id = c.customer_id
group by c.customer_id,c.first_name,c.last_name
order by Invoice_total desc
limit 1;



--- Write a query to return the email, first name, last name and Genre of all Rock music listeners.
--- Return your list ordered alphabetically by email starting with A.

SELECT
    c.email,
    c.first_name,
    c.last_name,
    g.name
FROM customer AS  c
inner join invoice as i on c.customer_id = i.customer_id 
inner join invoice_line as il on i.invoice_id = il.invoice_id 
inner join track as t on il.track_id = t.track_id 
inner join genre as g on t.genre_id = g.genre_id
where g.name = "Rock"
order by email asc;
select * from genre;




--- Return all the track names that have a song length longer than the average song length.
--- Return the Name and Milliseconds for each track
--- Order by the song with the longest songs listed first

SELECT name,milliseconds
FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track)
order by milliseconds desc;



--- We want to find out the most popular music genre for each country.
--- We determine the most popular genre as the genre with highest amount of purchases.
--- Write a query that returns each country along with the top genr

WITH GenreSales AS (
  SELECT 
    g.name AS genre_name,
    i.billing_country,
    SUM(il.unit_price * il.quantity) AS total_sales
  FROM genre g
  INNER JOIN track t ON g.genre_id = t.genre_id
  INNER JOIN invoice_line il ON il.track_id = t.track_id
  INNER JOIN invoice i ON i.invoice_id = il.invoice_id
  GROUP BY g.name, i.billing_country
)
SELECT 
  gs.billing_country,
  gs.genre_name AS most_popular_genre
FROM GenreSales gs
INNER JOIN (
  SELECT 
    billing_country,
    MAX(total_sales) AS max_sales
  FROM GenreSales
  GROUP BY billing_country
) AS top_sales ON gs.billing_country = top_sales.billing_country
AND gs.total_sales = top_sales.max_sales;



--- Write a query that determines the customer that has spent the most on music for each
--- country.
--- Write a query that returns the country along with the top customer and how much they spent.
--- For countries where the top amount spent is shared, provide all customers who spent this amount

WITH CustomerSpending AS (
  SELECT
    i.billing_country,
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(il.unit_price * il.quantity) AS total_spent
  FROM invoice i
  INNER JOIN customer c ON i.customer_id = c.customer_id
  INNER JOIN invoice_line il ON i.invoice_id = il.invoice_id
  GROUP BY i.billing_country, c.customer_id, c.first_name, c.last_name
)
SELECT
  cs.billing_country,
  cs.first_name,
  cs.last_name,
  cs.total_spent
FROM CustomerSpending cs
INNER JOIN (
  SELECT 
    billing_country,
    MAX(total_spent) AS max_spent
  FROM CustomerSpending
  GROUP BY billing_country
) AS top_spenders ON cs.billing_country = top_spenders.billing_country
AND cs.total_spent = top_spenders.max_spent;

