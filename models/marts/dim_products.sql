with products as (
    select * from {{ ref('stg_products') }}
),

order_items as (
    select * from {{ ref('stg_order_items') }}
),

product_stats as (
    select
        p.product_id,
        p.product_name,
        p.category,
        p.unit_price,
        count(oi.order_item_id)   as times_ordered,
        sum(oi.quantity)          as total_units_sold,
        sum(oi.line_total)        as total_revenue
    from products p
    left join order_items oi on p.product_id = oi.product_id
    group by
        p.product_id,
        p.product_name,
        p.category,
        p.unit_price
)

select * from product_stats