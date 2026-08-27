-- Exploratory Data Analysis

SELECT *
FROM layoff_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoff_staging2;

SELECT *
FROM layoff_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT company, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoff_staging2;

SELECT country, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY stage
ORDER BY 2 DESC;


SELECT company, SUM(percentage_laid_off)
FROM layoff_staging2
GROUP BY company
ORDER BY 2 DESC;



SELECT SUBSTRING(`date`,1,7) AS `Month`, SUM(total_laid_off)
FROM layoff_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY`Month`
ORDER BY 1 ASC;

WITH Rolling_total AS
(
SELECT SUBSTRING(`date`,1,7) AS `Month`, SUM(total_laid_off) AS total_off
FROM layoff_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `Month`
ORDER BY 1 ASC
)
SELECT `Month`, total_off,
SUM(total_off) OVER(ORDER BY `Month`) AS rolling_total
FROM Rolling_total;


SELECT company, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS
(SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL)
SELECT * 
FROM Company_Year_Rank 
WHERE Ranking <= 5;


WITH Company_Location (company, location, years,  total_laid_off) AS
(
SELECT company, location, YEAR(`date`),  SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company, location, YEAR(`date`)
), Company_By_Location AS
(SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Location
WHERE years IS NOT NULL)
SELECT * 
FROM Company_By_Location
WHERE Ranking <= 5;


WITH Top_Country (country, company, years, total_laid_off) AS
(
SELECT country, company, YEAR(`date`), SUM(total_laid_off)
FROM layoff_staging2
GROUP BY country, company, YEAR(`date`)
), Top_Country_Rank AS
(SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Top_Country
WHERE years IS NOT NULL)
SELECT * 
FROM Top_Country_Rank 
WHERE Ranking <= 5;

WITH Top_Industry (industry, years, total_laid_off) AS
(
SELECT industry, YEAR(`date`), SUM(total_laid_off)
FROM layoff_staging2
GROUP BY industry, YEAR(`date`)
), Top_Industry_Rank AS
(SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Top_Industry
WHERE years IS NOT NULL)
SELECT * 
FROM Top_Industry_Rank 
WHERE Ranking <= 5;