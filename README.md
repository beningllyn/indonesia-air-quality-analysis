# Analysis of Indonesia's weekly air quality (Jun 2024 - Nov 2026) compared with 7 ASEAN countries.

### What we want to analyze and the result:
##### 1. How is Indonesia's air quality from June 2024 until November 2026?
###### Indonesia had 0 "Good" weeks out of 126, and about 87% of weeks were in the "Unhealthy for Sensitive Groups" category or worse. AQI reached Hazardous level (>300) in 4 weeks during September - October 2026.
##### 2. Compared to other ASEAN countries, which position is Indonesia in? 
###### Indonesia ranks first (worst) with an average AQI of 138.4, compared with 57-113 for the other seven countries.
##### 3. How did Indonesia's September - October 2026 rise compare with other ASEAN countries?
###### Indonesia's average AQI rose by 107 points (158 in Jun-Aug2026 to 265 in Sep-Nov2026), the largest rise among the eight countries. All other countries also rose, but non averaged above 143.
##### 4. Is there a seasonal pattern in Indonesia's air quality?
###### In Indonesia by 2024-2025 (based on only two full yearly cycles), there is no consistent seasonal pattern, but the AQI in September - October 2026 breaks far above both years.

### Dataset:
- **Name:** AQI - Air Quality Index
- **Author:** azminetoushikwasi (Kaggle)
- **Link:** https://www.kaggle.com/datasets/azminetoushikwasi/aqi-air-quality-index-scheduled-daily-update
- **License:** [Open Database License (ODbL) v1.0](https://opendatacommons.org/licenses/odbl/1-0/)
- **Columns:** `date`, `country`, `status`, `aqi_value`
- **Period used:** 2024-06-06 to 2026-11-05 (126 weekly observations per country)
- **Countries analyzed:** Indonesia, Malaysia, Singapore, Thailand, Vietnam, Philippines, Myanmar, Laos

### Methodology and cleaning decisions:
##### 1. Why did we use only June 2024 - November 2026?
###### The Kaggle dataset covers many countries from 2022 to 2026, but before 2024-06-06 its time structure is inconsistent: daily data in 2022, a single date in January 2023, a short weekly stretch in 2023, and gaps of 112, 77, and 301 days between them. From 2024-06-06 onward, the data is weekly (every Thursday) with one missing week. We used only this segment (126 weekly observations per country) so that trends and comparisons are consistent.
##### 2. Why did we compare 8 ASEAN countries instead of 10?
###### The dataset has 10 ASEAN countries. We kept countries with at least 90% of the 126 weekly observations. Cambodia (106 weeks, 84.1%) fell below this threshold. Brunei (118 weeks, 93.7%) passes it, but its data stops on 2026-09-10, so it misses the September - October 2026 period that this analysis focuses on. Philippines (125 weeks) and Myanmar (124 weeks) have small gaps and were kept.
##### 3. What did we do with duplicate rows?
###### On 2024-06-06, every country had two rows. The values were identical except for Laos (23 and 46, both in the "Good" category). We averaged the valuer per country per date.
##### 4. What about the missing week?
###### No data exists for 2026-07-30 for any country. We did not fill or estimate it, and we noted it as a limitation.

### Analysis result:
##### 1. Indonesia's air quality, June 2024 - November 2026
###### Indonesia had no "Good" weeks in the period. Most weeks (about 66%) were "Unhealthy for Sensitive Groups", and AQI reached "Hazardous" levels (>300) in 4 weeks during September - October 2026.
<img width="750" alt="Weekly AQI of Indonesia colored by category" src="https://github.com/user-attachments/assets/7794072b-fe5a-4450-8fa8-57370eeb7dce" />

##### 2. Indonesia's rank among 8 ASEAN countries
###### By average weekly AQI, Indonesia ranks first (worst) at 138.4, followed by Thailand (113.2) and Myanmar (76.7).
<img width="750" alt="Average AQI by country" src="https://github.com/user-attachments/assets/3f276994-15f3-4e00-be9c-ea3657af0cac" />

##### 3. Indonesia's rise compared with other countries
###### Indonesia's average AQI rose by 107 points (158 to 265) from June-August to September-early November 2026, the largest rise among the eight countries. The other seven also rose, but none averaged above 143.
<img width="750" alt="Weekly AQI of Indonesia vs other ASEAN countries" src="https://github.com/user-attachments/assets/19842c22-809d-476e-ae2a-e1dff13e1f8d" />

##### 4. Seasonal pattern
###### There is no consistent seasonal pattern in 2024-2025, and September - October 2026 is far above both years. This is based on only two full yearly cycles.
<img width="750" alt="Monthly average AQI by year" src="https://github.com/user-attachments/assets/6770470f-8737-4550-aba2-beefe349de80" />

### Limitations:
##### 1. No cause data.
###### We can only analyze "what" and "when", not "why", because the dataset has no pollutant, weather, city, or event columns.
##### 2. Weekly resolution.
###### Data is weekly (per Thursday), so spikes on other days may be missed.
##### 3. Unclear coverage per country.
###### Some countries had multiple values per date, suggesting country values may combine several locations.
##### 4. Only two full yearly cycles (2024-2025)
###### Seasonal conclusions are tentative.
##### 5. Incomplete data.
###### One week (2026-07-30) is missing, and two of the ten ASEAN countries (Cambodia, Brunei) were excluded.

### Tools
- **SQL** (PostgreSQL) for data cleaning and analysis
- **DBeaver** as the SQL client
- **Excel** for pivot tables and charts
- **GitHub** for documentation
