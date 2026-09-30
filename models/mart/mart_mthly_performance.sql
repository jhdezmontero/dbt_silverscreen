-- models/mart/mart_mnthl_performance.sql

{{ 
	config(
		materialized='table'
	)
}}

select 
    {{ dbt_utils.generate_surrogate_key(['ms.movie_id', 'ms.location_id', 'ms.month']) }} as unique_row_id,
    ms.movie_id,
    mi.movie_title,
    mi.genre,
    mi.studio,
    ms.month,
    ms.location_id,
    mi.mthly_rental_invoices,
    coalesce(mi.total_rental_cost, 0) as total_rental_cost,
    ms.tickets_sold as total_tickets_sold,
    ms.revenue as total_revenue,
from {{ ref("int_monthly_sales_location") }} as ms
left join {{ ref("int_movie_invoices") }} as mi
    on ms.movie_id = mi.movie_id
    and ms.month = mi.month
    and ms.location_id = mi.location_id
order by ms.month, ms.location_id