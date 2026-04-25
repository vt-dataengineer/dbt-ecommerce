with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    select * from {{ ref('stg_order_items') }}
),

joined as (
    select
        o.order_id,
        o.customer_id,
        o.order_date,
        o.status,
        sum(oi.line_total)   as order_total,
        sum(oi.quantity)     as total_items
    from orders o
    left join order_items oi on o.order_id = oi.order_id
    group by
        o.order_id,
        o.customer_id,
        o.order_date,
        o.status
)

select * from joined