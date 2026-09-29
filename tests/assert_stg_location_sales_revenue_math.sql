-- This test fails and returns rows if any record has a revenue mismatch
select 
    movie_id,
    location_id,
    month,
    tickets_sold,
    ticket_price,
    revenue,
    (tickets_sold * ticket_price) as expected_revenue
from {{ ref('stg_location_sales') }}
where revenue != (tickets_sold * ticket_price)