 {{
  config(
    materialized='table'
  )
}}

WITH events AS (
    SELECT *
    FROM {{ref('stg_postgres__events')}}
)
, order_items AS (
    SELECT *
    FROM {{ref('stg_postgres__order_items')}}
)
, products AS (
    SELECT *
    FROM {{ref('stg_postgres__products')}}
)

{% set event_types = dbt_utils.get_column_values(table=ref('stg_postgres__events'), column='event_type') %}

SELECT
    e.session_id,
    e.user_id,
    e.created_at,
    e.event_id,
    e.event_type,
    e.order_id,
    case when e.event_type = 'page_view' then 1 else 0 end as page_view,
    case when e.event_type = 'add_to_cart' then 1 else 0 end as add_to_cart,
    case when e.event_type = 'checkout' then 1 else 0 end as checkout,
    case when e.event_type = 'package_shipped' then 1 else 0 end as package_shipped,
    p.product_name
FROM events e
LEFT JOIN order_items i
    ON e.order_id = i.order_id
LEFT JOIN products p
    ON COALESCE(e.product_id, i.product_id) = p.product_id