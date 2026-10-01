-- models/intermediate/int_monthly_sales_location.sql

{{ 
	config(
		materialized='table'
	)
}}

select 
    month,
    movie_id,
    location_id,
    sum(tickets_sold) as tickets_sold,
    sum(revenue) as revenue
from {{ ref("stg_location_sales") }}
group by month, movie_id, location_id
ORDER BY month, location_id
