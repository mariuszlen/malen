-- Przygotowanie bazy, ujednolicenie nazewnictwa


alter table public."2019"
rename column "Country or region" to country;


alter table public."2020"
rename column "Country name" to country;


alter table public."2021"
rename column "Country name"  to country;

alter table public."2021"
rename column "Country name"  to country;


SELECT "RANK", country, "Happiness score", "Whisker-high", "Whisker-low", "Dystopia (1.83) + residual", "Explained by: GDP per capita", "Explained by: Social support", "Explained by: Healthy life expectancy", "Explained by: Freedom to make life choices", "Explained by: Generosity", "Explained by: Perceptions of corruption"
FROM public."2022"
where country like '%*'



--weryfikacja nazw w celu ujednolicenia 

select a.country , b.country, c.country, d.country
from public."2022" as a 
inner  join 
public."2021" as b
on 
a.country=b.country
inner join 
public."2020" as c 
on
a.country=c.country 
inner join 
public."2019" as d 
on 
a.country=d.country 

select a.country , b.country, c.country, d.country
from public."2022" as a 
left join 
public."2021" as b
on 
a.country=b.country
left  join
public."2020" as c 
on
a.country=c.country 
left  join
public."2019" as d 
on 
a.country=d.country 


-- Ujednolicenie nazw Państwa 2019-2022

update public."2022"
set country = 'Luxembourg' 
where country = 'Luxembourg*'

update public."2022"
set country = 'Guatemala' 
where country = 'Guatemala*' 

update public."2022"
set country = 'Kuwait' 
where country = 'Kuwait*'

update public."2022"
set country = 'Belarus' 
where country = 'Belarus*'

update public."2022"
set country = 'Turkmenistan' 
where country = 'Turkmenistan*'

update public."2022"
set country = 'North Cyprus' 
where country = 'North Cyprus*'

update public."2022"
set country = 'Libya' 
where country = 'Libya*'

update public."2022"
set country = 'Azerbaijan' 
where country = 'Azerbaijan*'

update public."2022"
set country = 'Gambia' 
where country = 'Gambia*'

update public."2022"
set country = 'Liberia' 
where country = 'Liberia*'

update public."2022"
set country = 'Niger' 
where country = 'Niger*'

update public."2022"
set country = 'Comoros' 
where country = 'Comoros*'

update public."2022"
set country = 'Palestinian Territories' 
where country = 'Palestinian Territories*'

update public."2022"
set country = 'Eswatini, Kingdom of' 
where country = 'Eswatini, Kingdom of*'

update public."2022"
set country = 'Madagascar' 
where country = 'Madagascar*'

update public."2022"
set country = 'Chad' 
where country = 'Chad*'

update public."2022"
set country = 'Yemen' 
where country = 'Yemen*'

update public."2022"
set country = 'Mauritania' 
where country = 'Mauritania*'

update public."2022"
set country = 'Botswana' 
where country = 'Botswana*'

update public."2022"
set country = 'Rwanda' 
where country = 'Rwanda*'

update public."2022"
set country = 'Lesotho' 
where country = 'Lesotho*'

update public."2019"
set country = 'Hong Kong S.A.R. of China' 
where country = 'Hong Kong'

update public."2019"
set country = 'Czechia' 
where country = 'Czech Republic'

update public."2020"
set country = 'Czechia' 
where country = 'Czech Republic'

update public."2021"
set country = 'Czechia' 
where country = 'Czech Republic'

update public."2019"
set country = 'North Cyprus' 
where country = 'Northern Cyprus'

update public."2019"
set country = 'Taiwan Province of China' 
where country = 'Taiwan'

update public."2020"
set country = 'North Macedonia' 
where country = 'Macedonia'



DELETE FROM public."2022"
WHERE country='xx'

DELETE FROM public."2022"
WHERE country='xx'

DELETE FROM public."2022"
WHERE country='Eswatini, Kingdom of'

DELETE FROM public."2022"
WHERE country='Congo'


-- wyliczenie sredniej od 2019-2022
with B as 
(
SELECT 
--"Overall rank", 
"country"  as "Country_name",
score, 
"GDP per capita", 
"Social support", 
"Healthy life expectancy", 
"Freedom to make life choices", 
generosity as Generosity ,
"Perceptions of corruption"
FROM public."2019"

union


select 
"country" as "Country_name",
--"Regional indicator"
"Ladder score" as "score",
"Explained by: Log GDP per capita" as "GDP per capita",
"Explained by: Social support" as "Social support",
"Explained by: Healthy life expectancy" as "Healthy life expectancy",
"Explained by: Freedom to make life choices" as "Freedom to make life choices",
"Explained by: Generosity" as "Generosity" ,
"Explained by: Perceptions of corruption" as "Perceptions of corruption"
from "2020"

union
select 
"country" as "Country_name",
--"Regional indicator"
"Ladder score" as "score",
"Explained by: Log GDP per capita" as "GDP per capita",
"Explained by: Social support" as "Social support",
"Explained by: Healthy life expectancy" as "Healthy life expectancy",
"Explained by: Freedom to make life choices" as "Freedom to make life choices",
"Explained by: Generosity" as "Generosity" ,
"Explained by: Perceptions of corruption" as "Perceptions of corruption"
from "2021"

union

select 
country as "Country_name",
--"Regional indicator"
"Happiness score" as "score",
"Explained by: GDP per capita" as "GDP per capita",
"Explained by: Social support" as "Social support",
"Explained by: Healthy life expectancy" as "Healthy life expectancy",
"Explained by: Freedom to make life choices" as "Freedom to make life choices",
"Explained by: Generosity" as "Generosity" ,
"Explained by: Perceptions of corruption" as "Perceptions of corruption"
from "2022"
)

select
 "Country_name", 
avg(b.score) as "score",
avg (b."GDP per capita") as " sredni GDP per capita",
avg ("Social support") as " sredni Social support",
avg ("Healthy life expectancy") as " sredni Healthy life expectancy",
avg ("Freedom to make life choices") as "sredni Freedom to make life choices",
avg (Generosity) as "sredni Generosity",
avg ("Perceptions of corruption") as "sredni Perceptions of corruption"
from b 
group by 1
order by 2 desc


ranking wedlug sredniej



with c as 
(select
 "Country_name", 
avg(b.score) as "score",
avg (b."GDP per capita") as "sredni GDP per capita",
avg ("Social support") as "sredni Social support",
avg ("Healthy life expectancy") as "sredni Healthy life expectancy",
avg ("Freedom to make life choices") as "sredni Freedom to make life choices",
avg (Generosity) as "sredni Generosity",
avg ("Perceptions of corruption") as "sredni Perceptions of corruption"
from 
(
SELECT 
--"Overall rank", 
"country"  as "Country_name",
score, 
"GDP per capita", 
"Social support", 
"Healthy life expectancy", 
"Freedom to make life choices", 
generosity as Generosity ,
"Perceptions of corruption"
FROM public."2019"

union


select 
"country" as "Country_name",
--"Regional indicator"
"Ladder score" as "score",
"Explained by: Log GDP per capita" as "GDP per capita",
"Explained by: Social support" as "Social support",
"Explained by: Healthy life expectancy" as "Healthy life expectancy",
"Explained by: Freedom to make life choices" as "Freedom to make life choices",
"Explained by: Generosity" as "Generosity" ,
"Explained by: Perceptions of corruption" as "Perceptions of corruption"
from "2020"

union
select 
"country" as "Country_name",
--"Regional indicator"
"Ladder score" as "score",
"Explained by: Log GDP per capita" as "GDP per capita",
"Explained by: Social support" as "Social support",
"Explained by: Healthy life expectancy" as "Healthy life expectancy",
"Explained by: Freedom to make life choices" as "Freedom to make life choices",
"Explained by: Generosity" as "Generosity" ,
"Explained by: Perceptions of corruption" as "Perceptions of corruption"
from "2021"

union

select 
country as "Country_name",
--"Regional indicator"
"Happiness score" as "score",
"Explained by: GDP per capita" as "GDP per capita",
"Explained by: Social support" as "Social support",
"Explained by: Healthy life expectancy" as "Healthy life expectancy",
"Explained by: Freedom to make life choices" as "Freedom to make life choices",
"Explained by: Generosity" as "Generosity" ,
"Explained by: Perceptions of corruption" as "Perceptions of corruption"
from "2022"
) as b
where "Country_name"  in (select country from public."2022")

group by 1
order by 2 desc

)


select "Country_name",
avg(c.score) as srednia_score,
dense_rank() over (order by  avg(c.score) desc) as ranking_score,
avg (c."sredni GDP per capita")  as srednia_GDP,
dense_rank() over (order by avg (c."sredni GDP per capita")desc) as ranking_GDP,
avg (c."sredni Social support") as "srednia Social support",
dense_rank() over ( order by avg (c."sredni Social support")desc) as Social_support,
avg (c."sredni Healthy life expectancy") as "sredna Healthy life expectancy",
dense_rank()  over ( order by avg (c."sredni Healthy life expectancy")desc)  as ranking_Healthy_life_expectancy,
avg (c."sredni Freedom to make life choices") as "srednia Freedom to make life choices",
dense_rank() over ( order by avg (c."sredni Freedom to make life choices")desc)  as ranking_Freedom_to_make_life_choices,
avg ("sredni Generosity") as "srednia Generosity",
dense_rank() over ( order by avg ("sredni Generosity")desc)  as ranking_Generosity,
avg (c."sredni Perceptions of corruption") as "srednia Perceptions of corruption",
dense_rank() over ( order by avg (c."sredni Perceptions of corruption")desc) as ranking_Perceptions_of_corruption
from c
group by  "Country_name"
order by avg(c.score) desc




 -- stworzenie Bazowej tabeli ze średnią oraz rankingiem w poszczególnych kategoriach 
2020-2021

with c as 
(select
 "Country_name", 
 "Regional indicator",
avg(b.score) as "score",
avg (b."GDP per capita") as "sredni GDP per capita",
avg (b."Social support") as "sredni Social support",
avg (b."Healthy life expectancy") as "sredni Healthy life expectancy",
avg (b."Freedom to make life choices") as "sredni Freedom to make life choices",
avg (b."Generosity") as "sredni Generosity",
avg (b."Perceptions of corruption") as "sredni Perceptions of corruption",
avg (b."Dystopia + residual")as "sredni Dystopia + residual"
from 
(
/*SELECT 
--"Overall rank", 
"country"  as "Country_name",
score, 
"GDP per capita", 
"Social support", 
"Healthy life expectancy", 
"Freedom to make life choices", 
generosity as Generosity ,
"Perceptions of corruption"
FROM public."2019"

union

*/
select 
"country" as "Country_name",
"Regional indicator",
"Ladder score" as "score",
"Explained by: Log GDP per capita" as "GDP per capita",
"Explained by: Social support" as "Social support",
"Explained by: Healthy life expectancy" as "Healthy life expectancy",
"Explained by: Freedom to make life choices" as "Freedom to make life choices",
"Explained by: Generosity" as "Generosity" ,
"Explained by: Perceptions of corruption" as "Perceptions of corruption",
"Dystopia + residual" as "Dystopia + residual"
from "2020"

union
select 
"country" as "Country_name",
"Regional indicator",
"Ladder score" as "score",
"Explained by: Log GDP per capita" as "GDP per capita",
"Explained by: Social support" as "Social support",
"Explained by: Healthy life expectancy" as "Healthy life expectancy",
"Explained by: Freedom to make life choices" as "Freedom to make life choices",
"Explained by: Generosity" as "Generosity" ,
"Explained by: Perceptions of corruption" as "Perceptions of corruption",
 "Dystopia + residual" as "Dystopia + residual"
from "2021"
/*
union

select 
country as "Country_name",
--"Regional indicator"
"Happiness score" as "score",
"Explained by: GDP per capita" as "GDP per capita",
"Explained by: Social support" as "Social support",
"Explained by: Healthy life expectancy" as "Healthy life expectancy",
"Explained by: Freedom to make life choices" as "Freedom to make life choices",
"Explained by: Generosity" as "Generosity" ,
"Explained by: Perceptions of corruption" as "Perceptions of corruption"
from "2022"*/
) as b
where "Country_name"  in (select country from public."2022")

group by 1,2
order by 3 desc

)


select "Country_name",
"Regional indicator",
avg(c.score) as srednia_score,
dense_rank() over (order by  avg(c.score) desc) as ranking_score,
avg (c."sredni GDP per capita")  as srednia_GDP,
dense_rank() over (order by avg (c."sredni GDP per capita")desc) as ranking_GDP,
avg (c."sredni Social support") as "srednia Social support",
dense_rank() over ( order by avg (c."sredni Social support")desc) as Social_support,
avg (c."sredni Healthy life expectancy") as "sredna Healthy life expectancy",
dense_rank()  over ( order by avg (c."sredni Healthy life expectancy")desc)  as ranking_Healthy_life_expectancy,
avg (c."sredni Freedom to make life choices") as "srednia Freedom to make life choices",
dense_rank() over ( order by avg (c."sredni Freedom to make life choices")desc)  as ranking_Freedom_to_make_life_choices,
avg (c."sredni Generosity") as "srednia Generosity",
dense_rank() over ( order by avg ("sredni Generosity")desc)  as ranking_Generosity,
avg (c."sredni Perceptions of corruption") as "srednia Perceptions of corruption",
dense_rank() over ( order by avg (c."sredni Perceptions of corruption")desc) as ranking_Perceptions_of_corruption,
avg (c."sredni Dystopia + residual") as "srednia Dystopia + residual",
dense_rank() over ( order by avg (c."sredni Dystopia + residual")desc) as ranking_sredni_Dystopia_residual
from c
group by  "Country_name", "Regional indicator"
order by avg(c.score) desc


--2022 z błędem

/*select 
country,"Regional indicator" ,
avg("Happiness score") as srednia_score,
dense_rank() over (order by  avg("Happiness score") desc) as "2022_ranking_score",
avg ("Explained by: GDP per capita")  as "2022_srednia_GDP",
dense_rank() over (order by avg ("Explained by: GDP per capita")desc) as "2022_ranking_GDP",
avg ("Explained by: Social support") as "2022_srednia Social support",
dense_rank() over ( order by avg ("Explained by: Social support")desc) as "2022_Social_support",
avg ("Explained by: Healthy life expectancy") as "2022_sredna Healthy life expectancy",
dense_rank()  over ( order by avg ("Explained by: Healthy life expectancy")desc)  as "2022_ranking_Healthy_life_expectancy",
avg ("Explained by: Freedom to make life choices") as "2022_srednia Freedom to make life choices",
dense_rank() over ( order by avg ("Explained by: Freedom to make life choices")desc)  as "2022_ranking_Freedom_to_make_life_choices",
avg ("Explained by: Generosity") as "2022_srednia Generosity",
dense_rank() over ( order by avg ("Explained by: Generosity")desc)  as "2022_ranking_Generosity",
avg ("Explained by: Perceptions of corruption") as "2022_srednia Perceptions of corruption",
dense_rank() over ( order by avg ("Explained by: Perceptions of corruption")desc) as "2022_ranking_Perceptions_of_corruption",
avg ("Dystopia (1.83) + residual") as "2022_Dystopia + residual",
dense_rank() over ( order by avg ("Dystopia (1.83) + residual")desc) as "2022_ranking_Dystopia_residual"
from public."2022" 
group by  1,2
order by avg("Happiness score") desc*/


-- poprawne zapytanie ranking w poszczegolnych kategoriach 2022

select 
country,  "Regional indicator" ,
"Happiness score" as score,
dense_rank() over (order by "Happiness score" desc) as "2022_ranking_score",
"Explained by: GDP per capita"  as "2022_GDP",
dense_rank() over (order by "Explained by: GDP per capita" desc) as "2022_ranking_GDP",
"Explained by: Social support" as "2022_Social support",
dense_rank() over (order by "Explained by: Social support" desc) as "2022_Social_support",
"Explained by: Healthy life expectancy" as "2022_Healthy life expectancy",
dense_rank()  over (order by "Explained by: Healthy life expectancy" desc)  as "2022_ranking_Healthy_life_expectancy",
"Explained by: Freedom to make life choices" as "2022_Freedom_to_make_life_choices",
dense_rank() over ( order by "Explained by: Freedom to make life choices" desc)  as "2022_ranking_Freedom_to_make_life_choices",
"Explained by: Generosity" as "2022_Generosity",
dense_rank() over (order by "Explained by: Generosity" desc)  as "2022_ranking_Generosity",
"Explained by: Perceptions of corruption" as "2022_Perceptions of corruption",
dense_rank() over (order by "Explained by: Perceptions of corruption" desc) as "2022_ranking_Perceptions_of_corruption",
"Dystopia (1.83) + residual" as "2022_Dystopia + residual",
dense_rank() over (order by "Dystopia (1.83) + residual" desc) as "2022_ranking_Dystopia_residual"
from public."2022" 
--group by  1,2
order by "Happiness score" desc


--Tworzenie nowej tabeli z regionem w celu porownania danych (w tabeli zrodlowej brak przypisania regionu w 2022 roku)

CREATE TABLE "2022-2" AS
SELECT a."RANK",b."Regional indicator", a.country, a."Happiness score", a."Whisker-high", a."Whisker-low", a."Dystopia (1.83) + residual", a."Explained by: GDP per capita", a."Explained by: Social support", a."Explained by: Healthy life expectancy", a."Explained by: Freedom to make life choices", a."Explained by: Generosity", a."Explained by: Perceptions of corruption"
FROM public."2022" as a 
left join public."2021"
 as b 
 on a.country = b.country


-- srednia wartosc pozycji na region w 2022
select 
"Regional indicator" ,
avg("Happiness score") as Region_srednia_score,
dense_rank() over (order by  avg("Happiness score") desc) as "Region_2022_ranking_score",
avg ("Explained by: GDP per capita")  as "Region_2022_srednia_GDP",
dense_rank() over (order by avg ("Explained by: GDP per capita")desc) as "Region_2022_ranking_GDP",
avg ("Explained by: Social support") as "Region_2022_srednia Social support",
dense_rank() over ( order by avg ("Explained by: Social support")desc) as "Region_2022_Social_support",
avg ("Explained by: Healthy life expectancy") as "Region_2022_sredna Healthy life expectancy",
dense_rank()  over ( order by avg ("Explained by: Healthy life expectancy")desc)  as "Region_2022_ranking_Healthy_life_expectancy",
avg ("Explained by: Freedom to make life choices") as "Region_2022_srednia Freedom to make life choices",
dense_rank() over ( order by avg ("Explained by: Freedom to make life choices")desc)  as "Region_2022_ranking_Freedom_to_make_life_choices",
avg ("Explained by: Generosity") as "Region_2022_srednia Generosity",
dense_rank() over ( order by avg ("Explained by: Generosity")desc)  as "Region_2022_ranking_Generosity",
avg ("Explained by: Perceptions of corruption") as "Region_2022_srednia Perceptions of corruption",
dense_rank() over ( order by avg ("Explained by: Perceptions of corruption")desc) as "Region_2022_ranking_Perceptions_of_corruption",
avg ("Dystopia (1.83) + residual") as "Region_2022_Dystopia + residual",
dense_rank() over ( order by avg ("Dystopia (1.83) + residual")desc) as "Region_2022_ranking_Dystopia_residual"
from public."2022" 
group by  1
order by avg("Happiness score") desc



select 
distinct "Regional indicator" ,
avg("Happiness score") over (partition by "Regional indicator")as Reg_srednia_score
/*dense_rank() over (order by  avg("Happiness score") desc) as "Region_2022_ranking_score",
avg ("Explained by: GDP per capita")  as "Region_2022_srednia_GDP",
dense_rank() over (order by avg ("Explained by: GDP per capita")desc) as "Region_2022_ranking_GDP",
avg ("Explained by: Social support") as "Region_2022_srednia Social support",
dense_rank() over ( order by avg ("Explained by: Social support")desc) as "Region_2022_Social_support",
avg ("Explained by: Healthy life expectancy") as "Region_2022_sredna Healthy life expectancy",
dense_rank()  over ( order by avg ("Explained by: Healthy life expectancy")desc)  as "Region_2022_ranking_Healthy_life_expectancy",
avg ("Explained by: Freedom to make life choices") as "Region_2022_srednia Freedom to make life choices",
dense_rank() over ( order by avg ("Explained by: Freedom to make life choices")desc)  as "Region_2022_ranking_Freedom_to_make_life_choices",
avg ("Explained by: Generosity") as "Region_2022_srednia Generosity",
dense_rank() over ( order by avg ("Explained by: Generosity")desc)  as "Region_2022_ranking_Generosity",
avg ("Explained by: Perceptions of corruption") as "Region_2022_srednia Perceptions of corruption",
dense_rank() over ( order by avg ("Explained by: Perceptions of corruption")desc) as "Region_2022_ranking_Perceptions_of_corruption",
avg ("Dystopia (1.83) + residual") as "Region_2022_Dystopia + residual",
dense_rank() over ( order by avg ("Dystopia (1.83) + residual")desc) as "Region_2022_ranking_Dystopia_residual"
*/from public."2022" 
--group by  1, "Happiness score"
order by 2 desc



-ogolna ilosc krajow z regionow w calym zestawieniu
with R as 
select a."Regional indicator", count (a.country) 
from public."2022" as a
group by 1
order by 2 desc

--ilosc wszystkich panstw
select count(country)
from public."2022" 


-- ilosc w pierwszej dziesiatce krajow z danego regionu 

select a."Regional indicator", count (a.country)
from (select * from  public."2022" order by  "Happiness score"    desc limit 10) as a
group by 1
order by 2 desc

--ilosc w ostatniej dziesiatce krajow z danego regionu 

select a."Regional indicator", count (a.country)
from (select * from  public."2022" order by  "Happiness score"    asc limit 10) as a
group by 1
order by 2 desc

-- najlepsze kraje z danego regionu i ich miejsce ogolne z 2022
 
 select "Regional indicator",country, "Happiness score", "rank_ogolny"
from 
(select "Regional indicator",a.country,"rank_ogolny",
rank() over (partition by "Regional indicator" order by "Happiness score" desc) as rank,
"Happiness score"
from public."2022" as a
left join 
(select g.country,
dense_rank() over (order by "Happiness score" desc) as "rank_ogolny"
from public."2022" as g )as b
on a.country = b.country ) as z
where rank =1
order by "Happiness score" desc

 -- najgorsze kraje z danego regionu i ich miejsce ogolne z 2022
  select "Regional indicator",country, "Happiness score", "rank_ogolny"
from 
(select "Regional indicator",a.country,"rank_ogolny",
rank() over (partition by "Regional indicator" order by "Happiness score" ) as rank,
"Happiness score"
from public."2022" as a
left join 
(select g.country,
dense_rank() over (order by "Happiness score" desc) as "rank_ogolny"
from public."2022" as g )as b
on a.country = b.country ) as z
where rank =1
order by "Happiness score" desc
