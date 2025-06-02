-- Test: Detect numeric feature drift between time periods
-- Purpose: Fail if feature mean or stddev changes significantly

WITH feature_stats AS (
  SELECT
    -- Historical period: before 30 days ago
    AVG(CASE WHEN date < DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) THEN feature_1 END) AS historical_mean,
    STDDEV(CASE WHEN date < DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) THEN feature_1 END) AS historical_stddev,

    -- Recent period: last 30 days
    AVG(CASE WHEN date >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) THEN feature_1 END) AS recent_mean,
    STDDEV(CASE WHEN date >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) THEN feature_1 END) AS recent_stddev
  FROM {{ ref('model_with_features') }}
)

SELECT *
FROM feature_stats
WHERE 
    ABS(historical_mean - recent_mean) > 10  -- Mean shift threshold
    OR ABS(historical_stddev - recent_stddev) > 5  -- Stddev change threshold
    