# Project Week 1 answers

How many users do we have?
Answer: 130

```
select count(*)
from dev_db.dbt_oleg_agapov.stg_postgres__users
```

On average, how many orders do we receive per hour?
Answer: 7.520833

```
WITH orders_per_hour AS 
(
    select date_trunc(hour, created_at) as order_hour,
        count(*) as total_orders
    from dev_db.dbt_vagmobigmailcom.stg_postgres__orders
    group by 1
    order by 1
)

select avg(total_orders) AS avg_order_per_hour
from orders_per_hour
```

On average, how long does an order take from being placed to being delivered?
Answer: 3.891803278689

```
with delivery_time as 
(
    select 
        datediff(minute, created_at, delivered_at) as minutes_to_delivery,
        minutes_to_delivery / 60 as hours_to_delivery,
        hours_to_delivery / 24 as days_to_delivery,
    from dev_db.dbt_vagmobigmailcom.stg_postgres__orders
    where delivered_at is not null
)

select avg(days_to_delivery) as avg_days_to_delivery
from delivery_time
```

How many users have only made one purchase? Two purchases? Three+ purchases?
Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

Answer: 
PURCHASE_CATEGORY	TOTAL_USERS
        1	            25
        2	            28
        3+	            71

```
with user_purchases as 
(
    select 
        user_id,
        count(order_id) as purchases
    from dev_db.dbt_vagmobigmailcom.stg_postgres__orders
    group by user_id
)

select 
    iff(purchases < 3, purchases::varchar, '3+') as purchase_category,
    count(user_id) as total_users
from user_purchases
group by purchase_category
order by purchase_category
```

On average, how many unique sessions do we have per hour?
Answer: 16.327586

```
with session_hours as 
(
    select 
        date_trunc(hour, created_at) as session_hour,
        count(distinct session_id) as total_sessions
    from dev_db.dbt_vagmobigmailcom.stg_postgres__events
    group by session_hour
)

select 
    avg(total_sessions) as avg_sessions_per_hour
from session_hours
```