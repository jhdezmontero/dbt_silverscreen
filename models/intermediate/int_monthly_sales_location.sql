-- models/intermediate/int_monthly_sales_location.sql

select 
    month,
    movie_id,
    location_id,
    sum(tickets_sold) as tickets_sold,
    sum(revenue) as revenue
from {{ ref("stg_location_sales") }}
group by month, movie_id, location_id
