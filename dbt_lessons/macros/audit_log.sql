{% macro audit_log() %}

INSERT INTO training-dsq.emily_dbt.audit_log (
              model_name,
              run_time,
              run_started_at,
              invocation_id,
              executed_by,
              target_env,
              status,
              run_duration_seconds,
              full_refresh
          )
          VALUES (
              '{{ this.identifier }}',  -- Just the model name, like 'orders_summary'
              CURRENT_TIMESTAMP(),      -- Time this hook is run
              '{{ run_started_at }}',   -- dbt-provided: time the run started
              '{{ invocation_id }}',    -- dbt-provided: unique ID for this run
              '{{ env_var("DBT_EXECUTED_BY", "unknown") }}', -- Use env var if available
              '{{ target.name }}',      -- dbt target (dev, prod, etc.)
              'success',                -- Hardcoded for now (hooks dont auto-detect success/failure)
              TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), '{{ run_started_at }}', SECOND), -- estimate
              {{ full_refresh | default(false) }}
          );

{% endmacro %}