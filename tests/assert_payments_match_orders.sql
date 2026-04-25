-- This test fails if any completed order has a payment
-- amount that doesn't match the order total

select
    o.order_id,
    o.order_total,
    p.amount
from {{ ref('fct_orders') }} o
left join {{ ref('stg_payments') }} p
    on o.order_id = p.order_id
where
    o.status = 'completed'
    and p.amount is not null
    and abs(o.order_total - p.amount) > 1.00