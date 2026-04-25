with orders as (
    select * from {{ ref('int_orders_with_items') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

final as (
    select
        o.order_id,
        o.customer_id,
        c.full_name        as customer_name,
        c.city             as customer_city,
        o.order_date,
        o.status,
        o.total_items,
        o.order_total,
        p.payment_method,
        p.amount           as amount_paid,
        p.payment_date,
        case
            when p.payment_id is null then 'unpaid'
            else 'paid'
        end                as payment_status
    from orders o
    left join payments p  on o.order_id  = p.order_id
    left join customers c on o.customer_id = c.customer_id
)

select * from final