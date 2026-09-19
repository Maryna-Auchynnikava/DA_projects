# 🚀 Startup Investments & Venture Financing Market Research
> **Двуязычное описание / Bilingual Documentation** (Русский | English)

---

## 🇷🇺 Русскоязычная версия

### 📌 Описание проекта
Проект посвящен исследованию исторических данных венчурного рынка и финансирования стартапов для финансовой компании, планирующей войти на инвестиционный рынок с моделью покупки, развития и последующей перепродажи перспективных компаний. Исследование направлено на оценку динамики объемов финансирования, выбор растущих массовых сегментов рынка и анализ показателей возврата средств (Payback/ROI) по типам финансирования.

### 🎯 Бизнес-задачи проекта
1. **Анализ динамики раундов финансирования:** Расчет среднего размера раунда (`funding_total_usd` / `funding_rounds`) и анализ активности рынка (количества раундов) по годам.
2. **Анализ растущих массовых сегментов:** Оценка суммарного финансирования по отраслям, выделение растущих в 2014 году сегментов и отсечение нишевых/средних рынков для поиска наиболее перспективных ниш.
3. **Оценка нормированного возврата средств:** Анализ доли возвращенных средств по типам инвестиций (`venture`, `debt_financing`, `private_equity`, `seed`, `angel`) с обработкой аномальных выбросов и деления на ноль.
4. **Инвестиционные рекомендации (контекст 2015 года):** Формирование стратегии выбора отрасли и оптимального типа финансирования для входа фонда на рынок.

### 🛠 Технический стек и методология
* **Язык и среда:** Python 3.x, Jupyter Notebook.
* **Обработка данных (Data Wrangling & Imputation):** `Pandas`, `NumPy` — фильтрация, агрегация, построение сводных таблиц (`pivot_table`), обработка деления на ноль ($+1e-60$), замена аномалий на `NaN`.
* **Временные ряды и динамика:** Анализ годовых трендов, временных рядов (Time Series Analysis) и относительных темпов роста.
* **Визуализация данных:** `Matplotlib`, `Seaborn` — линейные графики динамики (Line Plots), столбчатые диаграммы и тепловые карты.

### 📊 Структура проекта
1. **Предобработка и очистка данных:** Проверка качества датасета, обработка пропусков и дубликатов.
2. **Анализ динамики финансирования (Шаг 4.1):** Оценка размера раунда и количества инвестиционных сделок по годам.
3. **Анализ массовых сегментов рынка (Шаг 4.2):** Сравнительный анализ объема инвестиций в растущие сегменты (2013–2014 гг.).
4. **Годовая динамика возврата средств (Шаг 4.3):** Расчет нормированного показателя возврата капитала по видам инвестиций.
5. **Итоговые выводы и рекомендации (Шаг 5):** Стратегическое резюме для инвесторов.

---

## 🇬🇧 English Version

### 📌 Project Overview
This project provides an exploratory analysis of historical startup financing data for a financial company entering the venture investment market to acquire, scale, and resell promising startups. The research evaluates funding dynamics over time, identifies expanding mass-market segments, and measures normalized capital return ratios across funding types.

### 🎯 Business Requirements & Scope
1. **Funding Dynamics Analysis:** Calculating average round size (`funding_total_usd` / `funding_rounds`) and tracking overall deal volume over time.
2. **Growth Market Segment Identification:** Pivot analysis of aggregate funding by industry, isolating growing mass-market segments while filtering out niche sectors.
3. **Capital Return Ratio Metrics:** Calculating normalized capital return proportions across investment types (`venture`, `debt_financing`, `private_equity`, `seed`, `angel`) while handling division-by-zero ($+1e-60$) and outlier imputation.
4. **Investment Recommendations (2015 Context):** Formulating market entry strategies, target industry selection, and optimal deal structuring.

### 🛠 Technical Architecture & Tools
* **Language & Environment:** Python 3.x, Jupyter Notebook.
* **Data Wrangling & Time Series:** `Pandas`, `NumPy` — aggregation, pivot tables, zero-division handling, outlier filtering, and trend analytics.
* **Data Visualization:** `Matplotlib`, `Seaborn` — line plots, bar charts, and trend visualizations.

### 📊 Project Deliverables & Structure
1. **Part 1 — Data Quality & Preprocessing:** Data validation, missing value imputation, and dataset cleaning.
2. **Part 2 — Funding Dynamics (Step 4.1):** Annual deal volume and average round size analysis.
3. **Part 3 — Mass-Market Segment Analysis (Step 4.2):** Industry growth trend evaluations (2013–2014 baseline).
4. **Part 4 — Capital Return Ratio Metrics (Step 4.3):** Annual normalized capital return performance across investment vehicle types.
5. **Part 5 — Executive Summary & Strategy (Step 5):** Strategic investment thesis and final recommendations.

---

## 📂 Проекты и скрипты / Project Files
* [`startup_investments_analysis.ipynb`](./startup_investments_analysis.ipynb) — Полный Jupyter Notebook с расчетами, графиками и аналитическими комментариями / Complete Jupyter Notebook with code, charts, and business conclusions.

---

## 📬 Контакты / Contact
* **Автор / Author:** Maryna Auchynnikava
* **LinkedIn:** [linkedin.com/in/maryna-auchynnikava](https://www.linkedin.com/in/maryna-auchynnikava/)
* **Email:** maryna.auchynnikava@gmail.com
