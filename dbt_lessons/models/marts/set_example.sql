WITH department_example as (
SELECT
order_id,
{%- for department in dbt_utils.get_column_values(table=ref('int_ecommerce__order_items_products'), column='product_department') %}
SUM(IF(product_department = '{{ department }}', sale_price, 0)) AS total_sold_by_{{department.lower()}}{{',' if not loop.last}} 
{%- endfor %}
FROM {{ ref('int_ecommerce__order_items_products') }}
GROUP BY order_id
)

SELECT
order_id,
{%- for department in departments %}
total_sold_by_{{department.lower()}}{{',' if not loop.last}} 
{%- endfor %}
FROM department_example


