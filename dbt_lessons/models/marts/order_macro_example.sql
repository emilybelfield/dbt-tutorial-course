SELECT
	order_id,
	created_at AS order_created_at,
	{{ is_weekend('created_at') }} AS order_created_on_weekend
	
FROM {{ ref('stg_ecommerce__orders') }}

