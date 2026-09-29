{{ 
	config(
		materialized='table'
	)
}}

select 
    {{ dbt_utils.generate_surrogate_key(['sales.movie_id', 'sales.location_id', 'sales.month']) }} as unique_row_id,
    sales.movie_id,
    movie.movie_title,
    movie.genre,
    movie.studio,
    sales.month,
    sales.location_id,
    coalesce(invoice.total_rental_cost, 0) as total_rental_cost,
    sales.tickets_sold as total_tickets_sold,
    sales.revenue as total_revenue,
from {{ ref('int_monthly_sales_location') }} as sales
left join {{ ref('stg_movie_catalogue') }} as movie
    on sales.movie_id = movie.movie_id
left join {{ ref('stg_invoices') }} as invoice
    on sales.movie_id = invoice.movie_id
    and sales.month = invoice.month
    and sales.location_id = invoice.location_id
order by sales.month, sales.location_id