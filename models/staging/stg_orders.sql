with source as (
    select * from {{ source('ecommerce', 'orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        order_date,
        lower(status)  as status
    from source
)

select * from renamed