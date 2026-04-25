with source as (
    select * from {{ source('ecommerce', 'payments') }}
),

renamed as (
    select
        payment_id,
        order_id,
        lower(payment_method)  as payment_method,
        amount,
        payment_date
    from source
)

select * from renamed