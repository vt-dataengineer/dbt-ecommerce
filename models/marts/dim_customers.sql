with customer_orders as (
    select * from {{ ref('int_customer_orders') }}
),

final as (
    select
        customer_id,
        full_name,
        email,
        city,
        customer_created_at,
        total_orders,
        lifetime_value,
        first_order_date,
        latest_order_date,
        case
            when lifetime_value >= 5000  then 'high value'
            when lifetime_value >= 2000  then 'mid value'
            else 'low value'
        end as customer_segment
    from customer_orders
)

select * from final