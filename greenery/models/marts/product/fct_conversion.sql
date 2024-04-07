with product_events as (
    SELECT *
    FROM {{ref('int_product_events')}}
)

select 
    session_id,
    user_id,
    event_id,
    created_at,
    event_type,
    product_name,
    order_id,
    page_view,
    add_to_cart,
    checkout,
    package_shipped,
    case when order_id is not null then 1 else 0 end as conversion_to_order
from product_events