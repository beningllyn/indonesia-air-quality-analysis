/* Create table to ingest csv data*/
create table demo.air_quality_index_per_country (
	date date,
	country varchar,
	status varchar,
	aqi_value int4
);

----------------------------------------------------------------------
/* Check range date */
select min(date) as min_date, max(date) as max_date 
from demo.air_quality_index_per_country;
/* min_date = 2022-07-21
   max_date = 2026-11-05 */  

----------------------------------------------------------------------
/* Check each date gap */
with date_list as (
	select distinct date 
	from demo.air_quality_index_per_country
)
select date, date_gap from (
	select 
		date,
		date-lag(date) over(order by date) as date_gap 
	from date_list 
	order by date
	)
where date_gap not in (1,7);
/* From 2022-07-21 to 2023-08-10 the gap each date is inconsistent.
   So we use the data from 2024-06-06 until 2026-11-05 (with 7 days gap per data)
   with note: there are no data with date of 2026-07-30 */

----------------------------------------------------------------------
/* Check count of country each date */
select date, count(*) as count from (
    select distinct date, country
    from demo.air_quality_index_per_country 
    where date >= '2024-06-06'
)
group by 1 
order by 2;
/* Each date has various number of country (ranged in 102 ~ 133),
   so we will check the scope of each country */

----------------------------------------------------------------------
/* Check the scope of each country */
with total as (
	select count(distinct date) as total_date
	from demo.air_quality_index_per_country
	where date >= '2024-06-06'
)
select
	a.country,
	count(distinct a.date) as n_date,
	round(100.0 * count(distinct a.date)/t.total_date,1) as pct_scope,
	min(a.date) as first,
	max(a.date) as last
from demo.air_quality_index_per_country a,
total t
where a.date >= '2024-06-06'
and a.country ilike any (array[
	'%indonesia%','%malaysia%','%singapore%','%thailand%','%viet%',
	'%philip%','%myanmar%','%cambodia%','%lao%','%brunei%','%timor%'
])
group by a.country, t.total_date 
order by 3 desc;
/* Philippines 125/126, 99.2% (missing 1 row, 2025-06-26) : included
 * Myanmar 124/126, 98.4% (missing 2 rows, 2025-09-11, 2025-09-18) : included
 * Brunei 118/126, 93.7% (missing 8 rows) (stopped after 2026-09-10) : excluded (it misses the September - October 2026 period that this analysis focuses on)
 * Cambodia 106/126, 84.1% (missing 20 rows) : excluded (scope below 90%)*/
 
----------------------------------------------------------------------
/* Check if there are 1 date & 1 country that have more than 1 aqi_value*/
select date, country, count(*) as count_per_date_country
from demo.air_quality_index_per_country
where date >= '2024-06-06'
and country ilike any (array[
	'%indonesia%','%malaysia%','%singapore%','%thailand%','%viet%',
	'%philip%','%myanmar%','%lao%'
])
group by 1,2 
having count(*) > 1
order by 1,2;
/* 2024-06-06, has duplicate rows */

----------------------------------------------------------------------
/* Check the values in 2024-06-06 */
select distinct * from demo.air_quality_index_per_country 
where date = '2024-06-06'
and country ilike any (array[
	'%indonesia%','%malaysia%','%singapore%','%thailand%','%viet%',
	'%philip%','%myanmar%','%lao%'
])
order by country;
/* Laos has 2 different aqi_value (23 and 46, both in "Good" category), so we will use the average.
 * The other countries has duplicate same aqi_value, so it's okay to average too. */

----------------------------------------------------------------------
/* Create view for analysis */
create view demo.v_aqi_asean as 
select date, country, status, avg(aqi_value)::integer as aqi_value
from demo.air_quality_index_per_country
where date = '2024-06-06'
and country ilike any (array[
	'%indonesia%','%malaysia%','%singapore%','%thailand%','%viet%',
	'%philip%','%myanmar%','%lao%'
])
group by date, country, status
union all
select date, country, status, aqi_value 
from demo.air_quality_index_per_country
where date > '2024-06-06'
and country ilike any (array[
	'%indonesia%','%malaysia%','%singapore%','%thailand%','%viet%',
	'%philip%','%myanmar%','%lao%'
])
order by date, country;