-- models/staging/stg_location_sales.sql

with nj_001_sales as (
    select
        date_trunc('month', timestamp::timestamp) as month,
        movie_id,
        ticket_amount as tickets_sold,
        price as ticket_price,                     
        ticket_amount * price as revenue,
        'NJ_001' as location_id
    from {{ source('silverscreen', 'nj_001') }}
),

nj_002_sales as (
    select
        date_trunc('month', date::timestamp) as month,
        movie_id,
        ticket_amount as tickets_sold,
        ticket_price as ticket_price,
        ticket_amount * ticket_price as revenue,
        'NJ_002' as location_id
    from {{ source('silverscreen', 'nj_002') }}
),

nj_003_sales as (
    select
        date_trunc('month', timestamp::timestamp) as month,
        details as movie_id, 
        amount as tickets_sold,
        price as ticket_price,      
        amount * price as revenue,
        'NJ_003' as location_id
    from {{ source('silverscreen', 'nj_003') }}
    where product_type = 'ticket'
),

combined as (
    select * from nj_001_sales
    union all
    select * from nj_002_sales
    union all
    select * from nj_003_sales
)

select 
    to_date(month) as month,
    movie_id,
    tickets_sold,
    ticket_price,
    revenue,
    location_id
from combined