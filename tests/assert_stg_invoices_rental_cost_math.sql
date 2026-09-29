-- This test returns rows where total_rental_cost does not equal 4 times weekly_rental_cost
select 
    movie_id,
    location_id,
    month,
    weekly_rental_cost,
    total_rental_cost,
    (weekly_rental_cost * 4) as expected_total_rental_cost
from {{ ref('stg_invoices') }}
where total_rental_cost != (weekly_rental_cost * 4)