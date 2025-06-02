{% snapshot snapshot__distribution_center_v2 %}

{{
	config(
		target_schema='dbt_snapshots',
		unique_key='id',
		strategy='check',
		check_cols=['name', 'latitude', 'longitude']
	)
}}

SELECT
	id,
	name,
	latitude,
	longitude

FROM {{ ref('int_ecommerce__distribution_centers') }}

{% endsnapshot %}