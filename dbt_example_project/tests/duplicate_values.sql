SELECT 
order_id
FROM (
  SELECT order_id, 
  COUNT(DISTINCT status) as status_cnt
  FROM {{ ref('raw__orders') }}
  GROUP BY order_id
)
WHERE status_cnt > 1