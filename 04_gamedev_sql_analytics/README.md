# 🎮 Game Economics & User Behavior Analytics: "Secrets of Darkwood"
> **Двуязычное описание / Bilingual Documentation** (Русский | English)

---

## 🇷🇺 Русскоязычная версия

### 📌 Описание проекта
Проект посвящен продуктовому и монетизационному анализу пользовательского поведения в игровой индустрии (Game Analytics) на примере игры «Секреты Темнолесья». Исследование направлено на изучение конверсии игроков в платящих, анализ игровой экономики (покупки эпических предметов) и проверку гипотезы продуктовой команды о балансе игрового процесса между различными расами персонажей.

### 🎯 Бизнес-задачи проекта
1. **Анализ конверсии в платящих (Payer Rate):** Оценка доли пользователей, покупающих внутриигровую валюту за реальные деньги, и проверка зависимости конверсии от выбранной расы персонажа.
2. **Исследование экономики внутриигровых покупок:** Расчет ключевых статистических показателей (среднее, медиана, стандартное отклонение), выявление покупок с нулевой стоимостью и рейтинг популярности эпических предметов.
3. **Продуктовая ad hoc задача (Игровой баланс):** Проверка гипотезы аналитического отдела о сложности прохождения игры за разные расы на основе активности внутриигровых покупок (среднее число покупок, средний чек, ARPPU на платящего игрока).

### 🛠 Технический стек и методология
* **СУБД:** PostgreSQL.
* **SQL:**
  * **Статистический анализ:** Расчет показателей центральной тенденции и разброса (`AVG`, `MEDIAN / PERCENTILE_CONT`, `STDDEV`).
  * **Продуктовые метрики:** Расчет Conversion Rate, Payer Share, средних чеков и количества транзакций на пользователя.
  * **Группировка и фильтрация:** Агрегация данных по расам персонажей (`GROUP BY`), очистка данных от невалидных и нулевых транзакций.
  * **Подзапросы и объединения:** Составление сложных SQL-запросов для расчета метрик от общего числа зарегистрированных и платящих игроков.

### 📊 Структура проекта
1. **Часть 1.1 — Доля платящих игроков (Conversion Analytics):**
   * Расчет общей конверсии игроков в платящих.
   * Сравнительный анализ конверсии в разрезе рас персонажей.
2. **Часть 1.2 — Статистика внутриигровых покупок (Item & Economy Analysis):**
   * Оценка объема, суммарной стоимости, минимальной/максимальной цены предметов.
   * Выявление и отфильтровывание аномальных транзакций с нулевой стоимостью.
   * Анализ проникновения и популярности эпических предметов среди покупателей.
3. **Часть 2 — Ad hoc исследование игрового баланса (Race Balance & Monetization):**
   * Оценка доли активных покупателей и доли платящих за реальные деньги игроков по каждой расе.
   * Расчет среднего количества покупок и средней суммарной стоимости покупок на одного активного покупателя (ARPPU/User Activity) для оценки сложности баланса рас.

---

## 🇬🇧 English Version

### 📌 Project Overview
This project focuses on product analytics and monetization research within the gaming industry (Game Analytics) for the game "Secrets of Darkwood." The study analyzes user conversion into paying players, explores in-game item economics, and tests a product hypothesis regarding game balance across different character races.

### 🎯 Business Requirements & Scope
1. **Conversion & Payer Rate Analytics:** Evaluating the proportion of players purchasing in-game currency with real money and analyzing conversion rate variance across character races.
2. **In-Game Economy Research:** Computing descriptive statistics (mean, median, standard deviation), identifying zero-cost transactions, and evaluating item popularity metrics.
3. **Product Ad Hoc Analysis (Game Balance):** Testing the analytics team's hypothesis on race difficulty progression by measuring transaction volume, average purchase value, and spending per paying user across character races.

### 🛠 Technical Architecture & Tools
* **Database Management System:** PostgreSQL.
* **SQL Toolkit:**
  * **Descriptive Statistics:** Calculating distribution metrics (`AVG`, `PERCENTILE_CONT`, `STDDEV`).
  * **Product & Monetization Metrics:** Computing Conversion Rate, Payer Share, ARPPU, and transaction frequency per user.
  * **Data Aggregation & Cleaning:** Multi-level grouping (`GROUP BY`), filtering out invalid/zero-value transactions.
  * **Complex Queries & Subqueries:** Measuring proportions relative to total registered vs. active paying user cohorts.

### 📊 Project Deliverables & Structure
1. **Part 1.1 — Payer Rate & Conversion Analysis:**
   * Global conversion rate baseline for registered players.
   * Conversion rate breakdown by character race.
2. **Part 1.2 — Economy & Item Performance Analysis:**
   * Descriptive statistics on item price distributions.
   * Detection and exclusion of zero-cost transaction anomalies.
   * Epic item popularity ranking and user penetration rate calculations.
3. **Part 2 — Ad Hoc Game Balance Analysis:**
   * Measuring buyer participation rate and real-money paying share per race.
   * Average purchase count and revenue per active buyer to evaluate difficulty balance across character races.

---

## 📂 Проекты и скрипты / Project Files
* [`gamedev_analytics_queries.sql`](./gamedev_analytics_queries.sql) — Полный набор SQL-скриптов с подробными комментариями / Complete collection of commented SQL scripts.

---

## 📬 Контакты / Contact
* **Автор / Author:** Maryna Auchynnikava
* **LinkedIn:** [linkedin.com/in/maryna-auchynnikava](https://www.linkedin.com/in/maryna-auchynnikava/)
* **Email:** maryna.auchynnikava@gmail.com
