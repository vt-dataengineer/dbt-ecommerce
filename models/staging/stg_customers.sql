with source as (
    select * from {{ source('ecommerce', 'customers') }}
),

renamed as (
    select
        customer_id,
        first_name,
        last_name,
        concat(first_name, ' ', last_name)  as full_name,
        lower(email)                         as email,
        city,
        created_at                           as customer_created_at
    from source
)

select * from renamed