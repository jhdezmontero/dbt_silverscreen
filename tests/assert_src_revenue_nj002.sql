-- test/assert_src_revenue_nj002: assert if revenue was well calculated for NJ_002 source data
select 
    ticket_amount,
    ticket_price,
    total_earned,
    (ticket_amount * ticket_price) as expected_revenue
from {{ source('silverscreen', 'nj_002') }}
where total_earned != (ticket_amount * ticket_price)