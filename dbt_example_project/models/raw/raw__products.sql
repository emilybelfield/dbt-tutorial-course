WITH source AS (
    SELECT * FROM {{ source('thelook_ecommerce', 'products') }}
)

SELECT
    id,
    cost,
    category,
    name,
    brand,
    retail_price,
    department,
    sku,
    distribution_center_id
FROM source