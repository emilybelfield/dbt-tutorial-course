SELECT
* except(distribution_center_geom, longitude),
CASE WHEN name = 'Los Angeles CA' THEN -2.02 else longitude end as longitude
FROM {{ ref('stg_ecommerce__distribution_centers') }}
