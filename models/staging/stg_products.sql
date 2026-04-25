with source as (
    select * from {{ source('ecommerce', 'products') }}
),

renamed as (
    select
        product_id,
        product_name,
        lower(category)  as category,
        price            as unit_price
    from source
)

select * from renamed