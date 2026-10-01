-- models/intermediate/int_movie_invoices

{{ 
	config(
		materialized='table'
	)
}}

with grouped_invoices as (
    select
        month,
        movie_id,
        location_id,
        studio,
        sum(weekly_rental_cost) as weekly_rental_cost,
        sum(total_rental_cost) as total_rental_cost,
        count(distinct invoice_id) as mthly_rental_invoices,
    from {{ ref("stg_invoices") }}
    group by month, movie_id, location_id, studio
    order by month, location_id
),
movies AS(
    select * from {{ ref("stg_movie_catalogue") }}
)
select
    gi.month,
    gi.movie_id,
    gi.location_id,
    m.movie_title,
    m.genre,
    m.studio,
    gi.weekly_rental_cost,
    gi.total_rental_cost,
    gi.mthly_rental_invoices
from grouped_invoices as gi
left join movies as m 
    on gi.movie_id = m.movie_id