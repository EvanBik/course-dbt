*Week 3 Questions

***1) What is our overall conversion rate?

Answer: 62.4567

SQL:
```
select 
count(distinct case when checkout = 1 then session_id end) / count( distinct session_id) * 100 as conversion_rate
from dev_db.dbt_vagmobigmailcom.fct_page_views
```

***2) What is our conversion rate by product?

Answer: 
NAME	            CONVERSION_RATE
String of pearls	60.937500
Arrow Head	        55.555600
Cactus	            54.545500
ZZ Plant	        53.968300
Bamboo	            53.731300
Rubber Plant	    51.851900
Monstera	        51.020400
Calathea Makoyana	50.943400
Fiddle Leaf Fig	    50.000000
Majesty Palm	    49.253700
Aloe Vera	        49.230800
Devil's Ivy	        48.888900
Philodendron	    48.387100
Jade Plant	        47.826100
Pilea Peperomioides	47.457600
Spider Plant	    47.457600
Dragon Tree	        46.774200
Money Tree	        46.428600
Orchid	            45.333300
Bird of Paradise	45.000000
Ficus	            42.647100
Birds Nest Fern	    42.307700
Pink Anthurium	    41.891900
Boston Fern	        41.269800
Alocasia Polly	    41.176500
Peace Lily	        40.909100
Ponytail Palm	    40.000000
Snake Plant	        39.726000
Angel Wings Begonia	39.344300
Pothos	            34.426200

SQL:
```
select b.name, 
count(distinct case when checkout = 1 then session_id end) / count( distinct session_id) * 100 as conversion_rate
from dev_db.dbt_vagmobigmailcom.fct_page_views a
left join dev_db.dbt_vagmobigmailcom.products_snapshot b on a.product_id = b.product_id
group by b.name
order by 2 desc
```

***3) Which products had their inventory change from week 2 to week 3?

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