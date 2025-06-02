WITH source AS (
    SELECT * FROM {{ source('thelook_ecommerce', 'distribution_centers') }}
)

SELECT
    id,
    name,
    latitude,
    longitude,
    distribution_center_geom
FROM source