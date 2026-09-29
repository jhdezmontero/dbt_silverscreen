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
        
        -- Clean trailing dots and spaces using regex, then standardize Disney studios
        case 
            when trim(regexp_replace(studio, '\\.+$', '')) in ('Disney', 'Walt Disney') then 'Walt Disney Pictures'
            else trim(regexp_replace(studio, '\\.+$', ''))
        end as studio,
        
        weekly_price as weekly_rental_cost,
        total_invoice_sum as total_rental_cost

    from source
)

select * from cleaned