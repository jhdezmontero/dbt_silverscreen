-- models/staging/stg_invoices.sql

with source as (
    select * from {{ source('silverscreen', 'invoices') }}
),

cleaned as (
    select 
        movie_id,
        invoice_id,
        
        -- Convert month from 'DD.MM.YYYY' to date and truncate to first day of the month (YYYY-MM-DD)
        date_trunc('month', try_to_date(month, 'DD.MM.YYYY')) as month,
        
        location_id,
        
        -- Standarize studio names using standarize_studio macro
        {{ standarize_studio('studio') }} as studio,
        
        weekly_price as weekly_rental_cost,
        total_invoice_sum as total_rental_cost

    from source
)

select * from cleaned