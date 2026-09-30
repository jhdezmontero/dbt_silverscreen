-- test/assert_src_revenue_nj003: assert if revenue from sold tickets was well calculated for NJ_003 source data

select 
    amount,
    price,
    total_value,
    (amount * price) as expected_revenue
from {{ source('silverscreen', 'nj_003') }}
where 
    product_type = 'ticket' and 
    total_value != (amount * price)