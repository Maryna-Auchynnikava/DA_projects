-- Определим аномальные значения (выбросы) по значению перцентилей:
WITH limits AS (
    SELECT  
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY total_area) AS total_area_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY rooms) AS rooms_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY balcony) AS balcony_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_h,
        PERCENTILE_DISC(0.01) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_l
    FROM real_estate.flats     
),
-- Найдём id объявлений, которые не содержат выбросы:
filtered_id AS(
    SELECT id
    FROM real_estate.flats  
    WHERE 
        total_area < (SELECT total_area_limit FROM limits)
        AND (rooms < (SELECT rooms_limit FROM limits) OR rooms IS NULL)
        AND (balcony < (SELECT balcony_limit FROM limits) OR balcony IS NULL)
        AND ((ceiling_height < (SELECT ceiling_height_limit_h FROM limits)
            AND ceiling_height > (SELECT ceiling_height_limit_l FROM limits)) OR ceiling_height IS NULL)
    ),
-- Задача 1. Время активности объявлений:
sq as (
	SELECT 
		case when city='Санкт-Петербург' then 'Санкт-Петербург'
		else 'ЛенОбл'
		end as city,
		case when days_exposition<=30 then 'до месяца'
		when days_exposition>30 and days_exposition<=90 then 'до трех месяцев'
		when days_exposition>90 and days_exposition<=180 then 'до полугода'
		when days_exposition>180 then 'более полугода'
		else 'еще в продаже'
		end as activity_days,
		last_price/total_area::numeric as meter_price,
		total_area,
		rooms,
		balcony,
		floor
	FROM real_estate.flats left join real_estate.city c using (city_id) left join real_estate.advertisement a using(id) left join real_estate."type" t using(type_id)
	WHERE id IN (SELECT * FROM filtered_id) AND type='город' AND days_exposition IS NOT NULL 
	GROUP BY city, days_exposition, last_price, total_area, rooms, balcony, floor)
SELECT 
	city,
	activity_days,
	round (avg(meter_price)::numeric,2) AS avg_meter_price,
	round(avg(total_area)::numeric,2) AS avg_area,
	percentile_disc(0.5) WITHIN GROUP (ORDER BY rooms) AS mediana_rooms,
	percentile_disc(0.5) WITHIN GROUP (ORDER BY balcony) AS mediana_balcony,
	percentile_disc(0.5) WITHIN GROUP (ORDER BY floor) AS mediana_floor
FROM sq
GROUP BY city, activity_days
ORDER BY city DESC;
--Задача 2. Сезонность объявлений
-- К сожалению, я не придумала, как решить эту задачу одним запросом
-- ЧАСТЬ 1. Информация про месяцы с наибольшей активностью публикации объявлений
--Определим аномальные значения (выбросы) по значению перцентилей:
WITH limits AS (
    SELECT  
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY total_area) AS total_area_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY rooms) AS rooms_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY balcony) AS balcony_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_h,
        PERCENTILE_DISC(0.01) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_l
    FROM real_estate.flats     
),
-- Найдём id объявлений, которые не содержат выбросы:
filtered_id AS(
    SELECT id
    FROM real_estate.flats  
    WHERE 
        total_area < (SELECT total_area_limit FROM limits)
        AND (rooms < (SELECT rooms_limit FROM limits) OR rooms IS NULL)
        AND (balcony < (SELECT balcony_limit FROM limits) OR balcony IS NULL)
        AND ((ceiling_height < (SELECT ceiling_height_limit_h FROM limits)
            AND ceiling_height > (SELECT ceiling_height_limit_l FROM limits)) OR ceiling_height IS NULL)
    ),
    -- Оставим объявления за период 2015-2018 (полные годы). Выделим месяц из даты и посчитаем стоимость кв.метра
sq AS (
   SELECT *,
   		EXTRACT (MONTH FROM  first_day_exposition) AS start_month,
   		count(id) OVER () AS total_adv,
    	last_price/total_area::numeric as meter_price
    FROM real_estate.flats left join real_estate.advertisement a using(id) left join real_estate.type t using(type_id)
    WHERE id IN (SELECT * FROM filtered_id) AND type='город' AND first_day_exposition>='2015-01-01' AND first_day_exposition<='2018-12-31'),
    -- Посчитаем кол-во объявлений по месяцам и данные по квартирам 
sq2 AS (
    SELECT 
    	DISTINCT start_month,
    	COUNT(id) OVER (PARTITION BY start_month) AS new_adv_number,
    	total_adv,
    	round (avg(meter_price) OVER (PARTITION BY start_month)::NUMERIC,2) AS avg_meter_price,
    	round (avg(total_area) OVER (PARTITION BY start_month)::NUMERIC,2) AS avg_total_area,
    	avg(total_area) OVER () AS total_avg_area,
    	avg(meter_price) OVER () AS total_avg_mprice
    FROM sq
    )
    -- Добавим ранг
   SELECT
   		DISTINCT start_month,
   		RANK () OVER (ORDER BY new_adv_number DESC) AS rank_new,
   		new_adv_number,
   		ROUND(new_adv_number/total_adv::NUMERIC,2) AS part_adv,
    	avg_meter_price,
    	RANK () OVER (ORDER BY avg_meter_price DESC) AS rank_mp,
    	round(total_avg_mprice::NUMERIC,2) AS total_avg_mprice,-- в задаче не требовалось, считала для описания данных
    	avg_total_area,
    	RANK () OVER (ORDER BY avg_total_area DESC) AS rank_ta,
    	round(total_avg_area::NUMERIC,2) AS total_avg_area-- в задаче не требовалось, считала для описания данных
    FROM sq2
    ORDER BY new_adv_number DESC;
   -- ЧАСТЬ 2. Информация про месяцы с наибольшей активностью снятия объявлений
   --Определим аномальные значения (выбросы) по значению перцентилей:
WITH limits AS (
    SELECT  
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY total_area) AS total_area_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY rooms) AS rooms_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY balcony) AS balcony_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_h,
        PERCENTILE_DISC(0.01) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_l
    FROM real_estate.flats     
),
-- Найдём id объявлений, которые не содержат выбросы:
filtered_id AS(
    SELECT id
    FROM real_estate.flats  
    WHERE 
        total_area < (SELECT total_area_limit FROM limits)
        AND (rooms < (SELECT rooms_limit FROM limits) OR rooms IS NULL)
        AND (balcony < (SELECT balcony_limit FROM limits) OR balcony IS NULL)
        AND ((ceiling_height < (SELECT ceiling_height_limit_h FROM limits)
            AND ceiling_height > (SELECT ceiling_height_limit_l FROM limits)) OR ceiling_height IS NULL)
    ),
    -- Оставим объявления за период 2015-2018 (полные годы) и неактивные (т.е. проданные) объявления. Выделим месяц из даты и посчитаем стоимость кв.метра
sq AS (
   SELECT *,
   		first_day_exposition + days_exposition::int AS last_day_exposition,
   		EXTRACT (MONTH FROM first_day_exposition + days_exposition::int) AS last_month,
    	last_price/total_area::numeric as meter_price,
    	count(id) OVER () AS total_adv
    FROM real_estate.flats left join real_estate.advertisement a using(id) left join real_estate.type t using(type_id)
    WHERE id IN (SELECT * FROM filtered_id) AND type='город' AND first_day_exposition>='2015-01-01' AND first_day_exposition<='2018-12-31' AND days_exposition IS NOT NULL),
	-- Посчитаем кол-во объявлений по месяцам и данные по квартирам 
sq2 AS (
    SELECT 
    	DISTINCT last_month,
    	COUNT(id) OVER (PARTITION BY last_month) AS close_adv_number,
        total_adv,
    	round (avg(meter_price) OVER (PARTITION BY last_month)::NUMERIC,2) AS avg_meter_price,
    	round (avg(total_area) OVER (PARTITION BY last_month)::NUMERIC,2) AS avg_total_area
    FROM sq
    )
     -- Добавим ранг
   SELECT 
   		DISTINCT last_month,
   		RANK () OVER (ORDER BY close_adv_number DESC) AS rank_close,
   		close_adv_number,
   		ROUND(close_adv_number/total_adv::NUMERIC,2) AS part_adv2,
    	avg_meter_price,
    	RANK () OVER (ORDER BY avg_meter_price DESC) AS rank_mp,
    	avg_total_area,
    	RANK () OVER (ORDER BY avg_total_area DESC) AS rank_ta
    FROM sq2
    ORDER BY close_adv_number DESC;
    
    -- Задача 3. Анализ рынка недвижимости Ленобласти
   -- Определим аномальные значения (выбросы) по значению перцентилей:
WITH limits AS (
    SELECT  
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY total_area) AS total_area_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY rooms) AS rooms_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY balcony) AS balcony_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_h,
        PERCENTILE_DISC(0.01) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_l
    FROM real_estate.flats     
),
-- Найдём id объявлений, которые не содержат выбросы:
filtered_id AS(
    SELECT id
    FROM real_estate.flats  
    WHERE 
        total_area < (SELECT total_area_limit FROM limits)
        AND (rooms < (SELECT rooms_limit FROM limits) OR rooms IS NULL)
        AND (balcony < (SELECT balcony_limit FROM limits) OR balcony IS NULL)
        AND ((ceiling_height < (SELECT ceiling_height_limit_h FROM limits)
            AND ceiling_height > (SELECT ceiling_height_limit_l FROM limits)) OR ceiling_height IS NULL)
    ),
sq AS (SELECT *,
	avg(total_area) over() AS total_avg_area,
	avg(last_price/total_area) OVER () AS total_avg_mprice,
	avg(days_exposition) OVER () AS total_avg_days
FROM real_estate.flats left join real_estate.city c using (city_id) left join real_estate.advertisement a using(id) left join real_estate."type" t using(type_id)
WHERE id IN (SELECT * FROM filtered_id) AND city<>'Санкт-Петербург')
SELECT 
	ntile(20) OVER (ORDER BY count(id) DESC) AS rank_city,-- ранжировать, чтобы выделить топ-15? не совсем поняла, для чего именно ранжировать
	city,
	count(id) AS adv_number,   
	count(days_exposition) AS close_adv_number,    
	round(count(days_exposition)/count(id)::NUMERIC,2) AS share_of_sales,
	round(avg(last_price/total_area)::NUMERIC,2) AS avg_meter_price, 
	round(total_avg_mprice::NUMERIC,2) AS total_avg_mprice,-- в задаче не требовалось, считала для описания данных
	round(avg(total_area)::NUMERIC,2) AS avg_total_area,  
	round(total_avg_area::NUMERIC,2) AS total_avg_area,  -- в задаче не требовалось, считала для описания данных
	round(avg(days_exposition/30)::NUMERIC,2) AS avg_months_exposition,
	round(avg(total_avg_days/30)::NUMERIC,2) AS total_avg_month -- в задаче не требовалось, считала для описания данных
FROM sq
GROUP BY city,total_avg_area,total_avg_mprice
ORDER BY adv_number DESC 
LIMIT 15;



