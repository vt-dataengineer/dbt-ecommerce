with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('int_orders_with_items') }}
),

joined as (
    select
        c.customer_id,
        c.full_name,
        c.email,
        c.city,
        c.customer_created_at,
        count(o.order_id)                                    as total_orders,
        sum(o.order_total)                                   as lifetime_value,
        min(o.order_date)                                    as first_order_date,
        max(o.order_date)                                    as latest_order_date
    from customers c
    left join orders o on c.customer_id = o.customer_id
    group by
        c.customer_id,
        c.full_name,
        c.email,
        c.city,
        c.customer_created_at
)

select * from joined