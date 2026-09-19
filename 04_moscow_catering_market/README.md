# 🍽️ Moscow Catering Market Research: Location & Concept Strategy
> **Двуязычное описание / Bilingual Documentation** (Русский | English)

---

## 🇷🇺 Русскоязычная версия

### 📌 Описание проекта
Проект посвящен исследовательскому анализу рынка общественного питания Москвы на основе геоданных сервисов Яндекс Карты и Яндекс Бизнес. Исследование проведено для инвестиционного фонда «Shut Up and Take My Money», планирующего запуск нового заведения. Анализ направлен на определение оптимального формата заведения (кафе, ресторан, кофейня, бар), ценовой категории, вместимости и локации для минимизации рисков и максимизации окупаемости.

### 🎯 Бизнес-задачи проекта
1. **Анализ структуры и сегментации рынка:** Оценка распределения видов заведений (кафе, рестораны, кофейни, фастфуд) в целом по Москве и в разрезе административных округов (включая глубокий срез по ЦАО).
2. **Исследование сетевого потенциала:** Анализ соотношения сетевых и несетевых заведений по категориям, выявление крупнейших сетей Москвы (Топ-15) и их характеристик.
3. **Оценка вместимости и ценовой политики:** Анализ типичного количества посадочных мест по категориям, очистка данных от выбросов и исследование зависимости среднего чека от удаленности заведения от центра города.
4. **Анализ факторов пользовательского рейтинга:** Построение матрицы корреляции факторов (категория, локация, сетевой статус, ценовой сегмент, круглосуточный режим) для определения ключевых драйверов высоких оценок.

### 🛠 Технический стек и методология
* **Язык и среда:** Python 3.x, Jupyter Notebook.
* **Обработка данных (Data Wrangling):** `Pandas`, `NumPy` — очистка от нерелевантных дубликатов, обработка пропусков, замена типов данных, агрегация и группировка.
* **Статистический и корреляционный анализ:** Расчет показателей центральной тенденции (среднее, медиана) и построение матриц корреляции (`Phik`, `SciPy`) для категориальных и непрерывных признаков.
* **Визуализация данных:** `Matplotlib`, `Seaborn` — построение гистограмм распределения, диаграмм размаха (boxplot), столбчатых диаграмм и тепловых карт (heatmaps).

### 📊 Структура проекта
1. **Часть 1 — Предобработка данных:**
   * Проверка типов данных, обработка пропущенных значений и очистка от нерелевантных дубликатов.
2. **Часть 2 — Анализ категорий и географического распределения:**
   * Исследование структуры общепита по видам заведений.
   * Анализ распределения заведений по административным округам Москвы и структура ЦАО.
3. **Часть 3 — Сетевой сегмент и анализ вместимости:**
   * Оценка доли сетевых заведений в разрезе категорий.
   * Выявление Топ-15 популярных сетей и расчет их средних рейтингов.
   * Анализ распределения посадочных мест и определение типичной вместимости по форматам.
4. **Часть 4 — Анализ рейтингов и ценовой динамики:**
   * Оценка средних рейтингов по категориям и анализ матрицы корреляции.
   * Исследование изменения среднего чека (`middle_avg_bill`) в зависимости от удаленности от ЦАО.

---

## 🇬🇧 English Version

### 📌 Project Overview
This project focuses on exploratory data analysis of the Moscow catering market based on location data from Yandex Maps and Yandex Business. Conducted for the "Shut Up and Take My Money" investment fund, the study aims to assist investors in selecting the optimal venue concept (cafe, restaurant, bar, coffee shop), price point, seating capacity, and district location to mitigate entry risks and maximize return on investment.

### 🎯 Business Requirements & Scope
1. **Market Structure & Segmentation:** Evaluating the distribution of catering formats across Moscow administrative districts, including a deep-dive analysis of the Central Administrative District (CAD).
2. **Chain vs. Independent Research:** Analyzing the proportion of chain and non-chain venues across categories, identifying Moscow's Top-15 catering chains and evaluating their metrics.
3. **Seating Capacity & Price Dynamics:** Determining median seating capacities by category, filtering out outliers, and analyzing middle average bill variation relative to proximity to the city center.
4. **User Rating Factors Analysis:** Constructing a correlation matrix across variables (category, district, chain status, price segment, 24/7 operations) to identify primary drivers of high customer ratings.

### 🛠 Technical Architecture & Tools
* **Language & Environment:** Python 3.x, Jupyter Notebook.
* **Data Wrangling & Manipulation:** `Pandas`, `NumPy` — deduplication, handling missing values, data type casting, multi-level aggregation, and grouping.
* **Statistical & Correlation Analysis:** Computing measures of central tendency (mean, median) and constructing correlation matrices (`Phik`, `SciPy`) for categorical and continuous features.
* **Data Visualization:** `Matplotlib`, `Seaborn` — distribution histograms, box plots, bar charts, and heatmaps.

### 📊 Project Deliverables & Structure
1. **Part 1 — Data Preprocessing:**
   * Data type validation, missing value imputation, and removal of duplicate records.
2. **Part 2 — Category & Geographic Distribution Analysis:**
   * Structural overview of catering formats across Moscow districts with dedicated CAD benchmarking.
3. **Part 3 — Chain Segment & Seating Capacity Analysis:**
   * Chain penetration share per category, Top-15 chain popularity ranking, and seating capacity distribution.
4. **Part 4 — User Rating Drivers & Price Variations:**
   * Rating comparison across formats, correlation matrix evaluation, and middle average bill analysis relative to central district proximity.

---

## 📂 Проекты и скрипты / Project Files
* [`moscow_catering_analysis.ipynb`](./moscow_catering_analysis.ipynb) — Полный Jupyter Notebook с кодом, графиками и выводами / Complete Jupyter Notebook with code, visualizations, and analytical insights.

---

## 📬 Контакты / Contact
* **Автор / Author:** Maryna Auchynnikava
* **LinkedIn:** [linkedin.com/in/maryna-auchynnikava](https://www.linkedin.com/in/maryna-auchynnikava/)
* **Email:** maryna.auchynnikava@gmail.com
