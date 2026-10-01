-- test/assert_src_revenue_nj001: assert if revenue was well calculated for NJ_001 source data

select 
    ticket_amount,
    price,
    transaction_total,
    (ticket_amount * price) as expected_revenue
from {{ source('silverscreen', 'nj_001') }}
where transaction_total != (ticket_amount * price)