/* Проект «Секреты Тёмнолесья»
 * Цель проекта: изучить влияние характеристик игроков и их игровых персонажей 
 * на покупку внутриигровой валюты «райские лепестки», а также оценить 
 * активность игроков при совершении внутриигровых покупок
 * 
 * Автор: Овчинникова Марина
 * Дата: 16/01/2025 27/01/2025*/

-- Часть 1. Исследовательский анализ данных
-- Задача 1. Исследование доли платящих игроков
-- 1.1. Доля платящих пользователей по всем данным:
-- Напишите ваш запрос здесь
SELECT 
count(DISTINCT id) AS total_players,--общее количество игроков, зарегистрированных в игре
SUM (payer) AS total_paying_players,--количество платящих игроков
ROUND(SUM (payer)/count(DISTINCT id)::NUMERIC,2) AS paying_players_share--доля платящих игроков от общего количества пользователей, зарегистрированных в игре
FROM fantasy.users;
-- 1.2. Доля платящих пользователей в разрезе расы персонажа:
-- Напишите ваш запрос здесь
SELECT 
race,--раса персонажа
SUM (payer) AS paying_players,--количество платящих игроков, в разрезе каждой расы персонажа
count(DISTINCT id) AS players,--общее количество зарегистрированных игроков, в разрезе каждой расы персонажа
ROUND(SUM (payer)/count(DISTINCT id)::NUMERIC,2) AS paying_share_by_race--доля платящих игроков от общего количества пользователей, зарегистрированных в игре в разрезе каждой расы персонажа
FROM fantasy.users u LEFT JOIN fantasy.race r USING (race_id)
GROUP BY race;
-- Задача 2. Исследование внутриигровых покупок
-- 2.1. Статистические показатели по полю amount:
-- Напишите ваш запрос здесь
SELECT 
count(transaction_id) AS total_purchases,--общее количество покупок
sum(amount) AS total_amount,--суммарную стоимость всех покупок
min(amount) AS min_amount,--минимальная стоимость покупки
max(amount) AS max_amount,--максимальная стоимость покупки 
round(avg(amount)::NUMERIC ,2) AS average_amount,--среднее значение стоимости покупки
percentile_disc(0.50) WITHIN GROUP (ORDER BY amount) AS mediana_amount,--медиана стоимости покупки
round(stddev(amount)::NUMERIC, 2) AS std_amount --стандартное отклонение стоимости покупки
FROM fantasy.events e2; 
-- 2.2: Аномальные нулевые покупки:
-- Напишите ваш запрос здесь
SELECT
(SELECT 
 count(*)
 FROM fantasy.events
 WHERE amount=0) AS null_payment,--абсолютное количество покупок с нулевой стоимостью
 (SELECT 
 count(*)
 FROM fantasy.events
 WHERE amount=0)/count(amount)::NUMERIC AS null_payment_share--доля покупок с нулевой стоимостью от общего количества покупок
 FROM fantasy.events;
-- 2.3: Сравнительный анализ активности платящих и неплатящих игроков:
-- Напишите ваш запрос здесь
--WITH sq as(
--SELECT 
--payer,
--count(transaction_id) AS notnullpurchases--количество покупок без учета нулевых покупок 
--FROM fantasy.users u LEFT JOIN fantasy.events USING (id)
--WHERE amount>0
--GROUP BY payer)
--SELECT
--CASE WHEN payer=1
--THEN 'payer'
--ELSE 'not_payer'
--END AS type_player,
--count(DISTINCT id) AS number_of_player,--общее количество игроков
--ROUND(notnullpurchases/count(DISTINCT id)::NUMERIC,2) AS avg_purchases,-- среднее количество покупок (без учета нулевых покупок) на одного игрока
--ROUND(SUM(amount)::NUMERIC/count(DISTINCT id),2) AS avg_amount--средняя суммарная стоимость покупок на одного игрока
--FROM fantasy.users u LEFT JOIN fantasy.events USING (id) LEFT JOIN sq USING (payer)
--GROUP BY payer, notnullpurchases;
SELECT--попробовала пересчитать в одном запросе и с учетом только активных, как было рекомендовано.
CASE WHEN payer=1
THEN 'payer'
ELSE 'not_payer'
END AS type_player,
count(DISTINCT id)AS number_of_player,--общее количество игроков,
count(transaction_id)/count(DISTINCT id)AS avg_purchases,-- среднее количество покупок (без учета нулевых покупок) на одного игрока
ROUND(sum(amount)::NUMERIC /count(DISTINCT id),2) AS avg_amount--средняя суммарная стоимость покупок на одного игрока
FROM fantasy.events e LEFT JOIN fantasy.users u USING (id)
WHERE amount>0
GROUP BY payer;
-- 2.4: Популярные эпические предметы:
-- Напишите ваш запрос здесь
-- Пересчитано с учетом рекомендации, но не знаю, как округлить доли, чтобы было красивенько
SELECT 
	game_items,
	count(amount) AS total_trans_for_item, -- абсолютное количество продаж в разрезе эпических предметов
	count(amount)::FLOAT/(SELECT count(amount) 
	FROM fantasy.events) AS item_share,-- относительное (доля) количество продаж в разрезе эпических предметов
	count(DISTINCT id)::FLOAT/(SELECT 
	count(DISTINCT id) 
	FROM fantasy.events) AS player_share--доля игроков, которые хотя бы раз покупали этот предмет. 
FROM fantasy.events RIGHT JOIN fantasy.items USING (item_code)
WHERE amount>0
GROUP BY game_items
ORDER BY total_trans_for_item DESC; 
-- Часть 2. Решение ad hoc-задач
-- Задача 1. Зависимость активности игроков от расы персонажа:
-- Напишите ваш запрос здесь
-- Переписала запрос с учетом рекомендации:
WITH sq AS (
SELECT 
race,
COUNT(DISTINCT id) AS payer_players 
FROM fantasy.events e LEFT JOIN fantasy.users u USING(id) LEFT JOIN fantasy.race r USING (race_id)--пересчитала по событиям как рекомедовано
WHERE payer=1
GROUP BY race),
sq5 AS (
SELECT
race,
count(DISTINCT id) AS total_players 
FROM fantasy.users u LEFT JOIN fantasy.race r USING (race_id)
GROUP BY race),
sq2 AS (
SELECT 
race, 
count(amount) AS notnullpurchases,
count(DISTINCT e.id) AS players_with_purchases,
avg(amount) AS avg_amount_per_player,
sum(amount) AS sum_amount
FROM fantasy.users u RIGHT JOIN fantasy.race r USING (race_id) LEFT JOIN fantasy.events e USING (id) LEFT JOIN sq USING (race)
WHERE amount>0
GROUP BY race)
SELECT 
race, 
total_players, 
players_with_purchases, 
ROUND(players_with_purchases/total_players::NUMERIC,2) AS players_with_purchases_share_from_total, 
ROUND(sq.payer_players/players_with_purchases::NUMERIC,2) AS payers_with_purchases_share, 
ROUND(notnullpurchases/players_with_purchases::NUMERIC,2) AS avg_purchases_per_player,
ROUND(avg_amount_per_player::NUMERIC,2) AS avg_amount_per_player,
ROUND((sum_amount/players_with_purchases)::NUMERIC,2) AS avg_sum_amount
FROM sq LEFT JOIN sq2 USING (race) LEFT JOIN sq5 USING (race)
GROUP BY race, total_players, players_with_purchases,payer_players, notnullpurchases, avg_amount_per_player,sum_amount
ORDER BY total_players desc;
-- Задача 2: Частота покупок
-- Переписала запрос с учетом рекомендации:
WITH sq1 AS (
SELECT 
	id,
	payer,
	transaction_id,
	date::timestamp AS date_purchase,
	LAG (date::timestamp,1,NULL) OVER (PARTITION BY id ORDER BY date asc) AS date_purchase_before,
	date_trunc('DAY',age(date::timestamp,LAG (date::timestamp) OVER (PARTITION BY id ORDER BY date asc))) AS day_number
FROM fantasy.users u RIGHT JOIN fantasy.events USING (id)
WHERE amount>0
GROUP BY id, transaction_id, payer),-- для расчета дат между покупками у каждого игрока 
sq2 AS (
SELECT
	id,
	count(transaction_id) AS sum_tran,
	avg(day_number) AS avg_days
FROM sq1
GROUP BY id
HAVING count(transaction_id)>=25
),--для расчета общего количества покупок
sq3 AS (
SELECT 
	DISTINCT id AS un_id,
	payer,
	sum_tran,
	avg_days,
	NTILE (3) OVER (ORDER BY avg_days ASC) AS r_p
FROM sq1 RIGHT JOIN sq2 USING (id)
GROUP BY id, payer,sum_tran,avg_days),--для расчета среднего количества дней между покупками для каждого игрока и для ранжирования
sq4 AS (
SELECT
	r_p,
	COUNT(un_id) OVER (PARTITION BY r_p) AS number_players_with_purchases,
	SUM(payer) OVER (PARTITION BY r_p) AS number_payers,
	ROUND (AVG (sum_tran)OVER (PARTITION BY r_p)::NUMERIC,2) AS avg_purchases_per_players,
	AVG (avg_days)OVER (PARTITION BY r_p) AS avg_day_numbers
FROM sq3)
SELECT
	CASE 
	WHEN r_p=1 THEN 'высокая частота'
	WHEN r_p=2 THEN 'умеренная частота'
	WHEN r_p=3 THEN 'низкая частота'
	ELSE NULL
	END AS rank_players,
	number_players_with_purchases,
	number_payers,
	ROUND(number_payers/number_players_with_purchases::NUMERIC,2) AS payers_share,
	avg_purchases_per_players,
	avg_day_numbers
	FROM sq4
	GROUP BY rank_players, number_players_with_purchases,
	number_payers,
	avg_purchases_per_players,
	avg_day_numbers;

