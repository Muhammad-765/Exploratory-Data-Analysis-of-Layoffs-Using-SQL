# Exploratory Data Analysis of Layoffs Using SQL

## 📌 Project Overview

This project performs exploratory data analysis on a global layoffs dataset using MySQL.

The analysis explores layoffs across companies, time periods, countries, industries, company stages, and company-location combinations. The goal is to identify major patterns, trends, rankings, and changes in layoffs over time using SQL.

This project builds on my previous **SQL Data Cleaning & Transformation Project**, where the raw layoffs dataset was cleaned and standardized before being used for exploratory analysis.

### Analytics Workflow

```text
Raw Layoffs Data
       ↓
SQL Data Cleaning
       ↓
Cleaned Dataset
       ↓
Exploratory Data Analysis
       ↓
Trends • Rankings • Patterns • Insights
```

---

## 🎯 Objectives

- Understand the overall scale of layoffs in the dataset.
- Identify companies with the highest total layoffs.
- Analyze layoffs across different time periods.
- Examine monthly and yearly layoff trends.
- Calculate cumulative layoffs over time.
- Compare layoffs across countries.
- Analyze layoffs by company funding stage.
- Identify the companies with the highest layoffs in each year.
- Analyze top company-location combinations by year.
- Identify the companies with the highest layoffs within each country and year.
- Identify the top industries by layoffs for each year.

---

## 📊 Dataset

The analysis uses the cleaned layoffs dataset produced from the previous data-cleaning project.

The dataset contains information including:

- `company`
- `location`
- `industry`
- `total_laid_off`
- `percentage_laid_off`
- `date`
- `stage`
- `country`
- `funds_raised_millions`

The dataset covers layoffs across multiple companies, industries, countries, and time periods.

---

## 🔍 Exploratory Analysis

### 1. Overall Layoff Statistics

The analysis begins by examining the maximum values of:

- Total employees laid off in a single event
- Percentage of workforce laid off in a single event

Records reporting `100%` layoffs were also isolated and sorted by the number of employees affected.

This helps identify the most severe individual layoff events in the dataset.

---

### 2. Company-Level Analysis

Companies were grouped and ranked according to their total reported layoffs.

```sql
SELECT company, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company
ORDER BY 2 DESC;
```

This identifies companies with the largest cumulative number of reported layoffs across the dataset.

---

### 3. Time Range Analysis

The minimum and maximum dates were identified to establish the time span covered by the dataset.

Monthly layoffs were then calculated by extracting the year and month from the `date` column.

```sql
SUBSTRING(`date`, 1, 7)
```

This allows layoffs to be examined chronologically and makes it possible to identify periods with unusually high or low layoff activity.

---

### 4. Monthly Layoff Trends

Monthly total layoffs were calculated and ordered chronologically.

This provides a time-series view of how layoff activity changed over the period covered by the dataset.

---

### 5. Rolling Total Analysis

A Common Table Expression was used to calculate monthly layoffs before applying a window function to calculate the cumulative number of reported layoffs over time.

```sql
SUM(total_off) OVER(ORDER BY `Month`)
```

This demonstrates the use of window functions for cumulative time-series analysis.

---

### 6. Company Layoffs by Year

Layoffs were aggregated by both company and year to identify how individual companies contributed to layoffs over time.

```sql
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;
```

---

### 7. Top 5 Companies by Year

A CTE combined with `DENSE_RANK()` was used to rank companies within each year.

```sql
DENSE_RANK() OVER(
    PARTITION BY years
    ORDER BY total_laid_off DESC
)
```

Only companies with a ranking of 5 or better were returned.

This provides a year-by-year view of the companies reporting the highest numbers of layoffs.

---

### 8. Company-Location Analysis

Layoffs were aggregated by company, location, and year.

`DENSE_RANK()` was then used to identify the highest-ranking company-location combinations within each year.

This provides an additional geographic dimension to company-level analysis.

---

### 9. Country-Level Analysis

Total layoffs were aggregated by country to compare the scale of layoffs across different geographic markets.

The analysis also examined the highest-layoff companies within each country and year using CTEs and window functions.

---

### 10. Industry Analysis

Layoffs were grouped by industry and year.

`DENSE_RANK()` was used to identify the top industries by reported layoffs for each year.

This makes it possible to examine how the industries most affected by layoffs changed over time.

---

### 11. Company Stage Analysis

Layoffs were aggregated by company funding stage to examine how reported layoffs differed across stages such as startups, growth-stage companies, and more established organizations.

---

## 🧮 SQL Techniques Used

### Core SQL

- `SELECT`
- `WHERE`
- `GROUP BY`
- `ORDER BY`
- Aggregate functions
- `SUM()`
- `MAX()`
- `MIN()`

### Advanced SQL

- Common Table Expressions (CTEs)
- Window Functions
- `DENSE_RANK()`
- `PARTITION BY`
- `OVER()`
- Rolling/Cumulative totals
- Date extraction with `YEAR()`
- String/date formatting with `SUBSTRING()`

### Analytical Techniques

- Time-series analysis
- Company-level aggregation
- Year-over-year ranking
- Geographic analysis
- Industry analysis
- Funding-stage analysis
- Cumulative analysis
- Multi-dimensional aggregation

---

## 📈 Key Analytical Outputs

The project produces several useful analytical outputs:

| Analysis | Purpose |
|---|---|
| Maximum layoffs | Identify the largest individual layoff events |
| 100% layoffs | Identify complete workforce reduction events |
| Company totals | Find companies with the highest cumulative layoffs |
| Monthly layoffs | Analyze layoffs over time |
| Rolling total | Track cumulative layoffs |
| Country totals | Compare layoffs geographically |
| Stage totals | Compare layoffs across company stages |
| Company-year totals | Analyze company layoffs over time |
| Top 5 companies/year | Identify yearly leaders in layoffs |
| Company-location rankings | Analyze geographic company patterns |
| Country-company-year rankings | Identify top companies within countries |
| Industry-year rankings | Identify leading affected industries |

---

## 🛠️ Tools & Technologies

**MySQL • SQL • MySQL Workbench**

---

## 💡 Skills Demonstrated

**SQL Querying • Exploratory Data Analysis • Data Aggregation • Time-Series Analysis • Window Functions • CTEs • Ranking Analysis • Data Interpretation • Business Analytics • Data Analysis**

---

## 📁 Project Structure

```text
sql-layoffs-exploratory-data-analysis/
│
├── data/
│   └── layoffs_cleaned.csv
│
├── sql/
│   └── exploratory_data_analysis.sql
│
├── screenshots/
│   ├── monthly_layoffs.png
│   ├── rolling_total.png
│   ├── top_companies.png
│   ├── country_analysis.png
│   └── yearly_rankings.png
│
├── README.md
└── .gitignore
```

---

## ▶️ How to Run

1. Install MySQL and MySQL Workbench.
2. Import the cleaned layoffs dataset.
3. Create/load the `layoff_staging2` table.
4. Open `exploratory_data_analysis.sql`.
5. Execute the queries sequentially.
6. Review the resulting tables and rankings.
7. Use the outputs for further visualization or business analysis.

---

## 🔗 Related Project

This project uses the cleaned dataset produced in my previous SQL project.

**SQL Data Cleaning & Transformation**

> Raw dataset → Data cleaning → Standardization → Analysis-ready dataset

The current project takes the cleaned data into the next stage:

> Cleaned dataset → Exploratory analysis → Trends → Rankings → Insights

---

## 🚀 Future Development

The SQL analysis can be extended into a data visualization project using Power BI or another BI platform to create an interactive layoffs dashboard.

Potential dashboard components include:

- Total layoffs KPI
- Layoffs over time
- Top companies
- Top industries
- Country comparison
- Yearly rankings
- Company-stage analysis
- Interactive filters