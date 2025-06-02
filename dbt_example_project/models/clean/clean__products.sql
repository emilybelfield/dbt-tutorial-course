WITH products AS (
    SELECT
        product_id,
        department AS product_department,
        cost AS product_cost,
        retail_price AS product_retail_price
    FROM {{ ref('raw__products') }}
)
SELECT
	oi.order_item_id,
	oi.order_id,
	oi.user_id,
	oi.product_id,
	oi.sale_price,
	p.product_department,
	p.product_cost,
	p.product_retail_price,
	oi.sale_price - p.product_cost AS item_profit,
	p.product_retail_price - oi.sale_price AS item_discount
FROM {{ ref('raw__order_items') }} AS oi
LEFT JOIN products AS p 
	ON oi.product_id = p.product_id
	