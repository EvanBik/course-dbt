# Week 3 Questions

### 1) What is our overall conversion rate?

Answer = 0.624567

SQL:
```
select 
count(distinct case when conversion_to_order = 1 then session_id end) / count(distinct session_id) as conversion_rate
from dev_db.dbt_vagmobigmailcom.fct_conversion
```

### 2) What is our conversion rate by product?

Answer = The top 5 products by conversion rate are as followed:
NAME	            CONVERSION_RATE
* String of pearls	0.609375
* Arrow Head	    0.555556
* Cactus	        0.545455
* ZZ Plant	        0.539683
* Bamboo	        0.537313


SQL:
```
select 
    product_name,
    count(distinct case when conversion_to_order = 1 then session_id end) / count(distinct session_id) as conversion_rate
from dev_db.dbt_vagmobigmailcom.fct_conversion
group by product_name
order by 2 desc limit 5
```

### 3) Which products had their inventory change from week 2 to week 3?

Answer = In total, the following 6 products had their inventory changed:

* Pothos
* Bamboo
* Philodendron
* Monstera
* String of pearls
* ZZ Plant

```
select *
from dev_db.dbt_vagmobigmailcom.products_snapshot
where dbt_valid_to is not null
```
