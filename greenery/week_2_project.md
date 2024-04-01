# Project Week 2 answers

1) Part 1. Models: What is our user repeat rate?
Repeat Rate = Users who purchased 2 or more times / users who purchased
Answer = 0.798387

```
select count_if(is_frequent_buyer) / count(*)
from dev_db.dbt_vagmobigmailcom.fct_user_orders
where is_buyer = TRUE
```

2) Part 3. dbt Snapshots: Which products had their inventory change from week 1 to week 2? 
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