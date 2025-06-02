{% macro create_base_model(source_name, table_name) %}
    {%- set columns = adapter.get_columns_in_relation(source(source_name, table_name)) %}

    {% set model_sql %}
WITH source AS (
    SELECT * FROM {% raw %}{{ source({% endraw %}'{{ source_name }}', '{{ table_name }}'{% raw %}) }}{% endraw %}
)

SELECT
    {%- for col in columns %}
    {{ col.name }}{{ "," if not loop.last -}}
    {% endfor %}
FROM source
    {% endset %}

{% if execute %}

{{ log(model_sql, info=True) }}
{% do return(model_sql) %}

{% endif %}

{% endmacro %}