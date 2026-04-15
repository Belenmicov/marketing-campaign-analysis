-- ============================================================
-- MARKETING CAMPAIGN PERFORMANCE ANALYSIS
-- Dataset: Marketing Campaign Performance (2021)
-- Companies: Alpha Innovations, DataTech Solutions, Innovate Industries
--            NexGen Systems, TechCorp
-- Tool: MySQL
-- ============================================================


-- ============================================================
-- BLOCK 1: KNOW THE DATASET
-- ============================================================

-- Preview the full dataset
SELECT * 
FROM campaigns;

-- How many campaigns does each company have?
SELECT Company,
       COUNT(*) AS total_campaigns
FROM campaigns
GROUP BY Company
ORDER BY total_campaigns DESC;

-- What date range does the dataset cover?
SELECT MIN(Date) AS start_date,
       MAX(Date) AS end_date
FROM campaigns;

-- What unique values exist in the key dimensions?
SELECT DISTINCT Campaign_Type FROM campaigns;
SELECT DISTINCT Channel_Used FROM campaigns;
SELECT DISTINCT Customer_Segment FROM campaigns;


-- ============================================================
-- BLOCK 2: GLOBAL COMPANY RANKING
-- Which company performs better overall?
-- ============================================================

SELECT Company,
       COUNT(*) AS total_campaigns,
       ROUND(AVG(ROI), 2) AS avg_roi,
       ROUND(AVG(Conversion_Rate), 4) AS avg_conversion_rate,
       ROUND(AVG(Acquisition_Cost), 2) AS avg_acquisition_cost,
       ROUND(AVG(Engagement_Score), 2) AS avg_engagement
FROM campaigns
GROUP BY Company
ORDER BY avg_roi DESC;

-- Finding: All five companies perform at virtually the same level.
-- ROI ranges from 4.99 to 5.01, a difference of 0.02.
-- No company holds a clear competitive advantage.


-- ============================================================
-- BLOCK 3: WHY DOES ONE COMPANY PERFORM BETTER?
-- Decomposing performance by channel and campaign type
-- ============================================================

-- ROI by company and channel
SELECT Company,
       Channel_Used,
       ROUND(AVG(ROI), 2) AS avg_roi,
       COUNT(*) AS total_campaigns
FROM campaigns
GROUP BY Company, Channel_Used
ORDER BY Company, avg_roi DESC;

-- Finding: No channel consistently outperforms others across companies.
-- Each company has a different top channel but differences are under 0.06.
-- Campaign volume is evenly distributed (~6,600 per channel per company).

-- ROI by company and campaign type
SELECT Company,
       Campaign_Type,
       ROUND(AVG(ROI), 2) AS avg_roi,
       ROUND(AVG(Conversion_Rate), 4) AS avg_conversion_rate
FROM campaigns
GROUP BY Company, Campaign_Type
ORDER BY Company, avg_roi DESC;

-- Finding: Influencer and Search appear more frequently at the top
-- across companies. Social Media tends to underperform relatively.
-- Differences remain minimal, under 0.08 ROI across all types.


-- ============================================================
-- BLOCK 4: SEGMENTS AND AUDIENCES
-- Which segment is most profitable and which channel works best?
-- ============================================================

-- Most profitable segment per company
SELECT Company,
       Customer_Segment,
       ROUND(AVG(ROI), 2) AS avg_roi,
       ROUND(AVG(Acquisition_Cost), 2) AS avg_cost
FROM campaigns
GROUP BY Company, Customer_Segment
ORDER BY Company, avg_roi DESC;

-- Finding: No segment shows a universal ROI advantage.
-- Every segment appears as someone's best performer.
-- Acquisition Cost shows slightly more variation than ROI ($237 range).

-- CTR by company (creative efficiency metric)
SELECT Company,
       ROUND(AVG(Clicks / Impressions) * 100, 2) AS avg_ctr
FROM campaigns
GROUP BY Company
ORDER BY avg_ctr DESC;

-- Finding: CTR is uniform across companies at ~14%.
-- This is significantly above real world benchmarks (2-5% for Google Ads,
-- 0.5-1% for social), confirming the synthetic nature of the dataset.
-- TechCorp leads CTR and also shows consistent performance across metrics.


-- ============================================================
-- BLOCK 5: TREND OVER TIME
-- Does ROI improve or decline throughout 2021?
-- ============================================================

SELECT Company,
       DATE_FORMAT(Date, '%Y-%m') AS month,
       ROUND(AVG(ROI), 2) AS avg_roi
FROM campaigns
GROUP BY Company, month
ORDER BY Company, month ASC;

-- Finding: Most companies fluctuate randomly around 5.00 with no trend.
-- NexGen Systems is the exception: starts strong in Jan-Feb (5.05),
-- drops mid-year Mar-Jul (as low as 4.94), then recovers in Sep-Oct (5.04).
-- This is the most visible pattern in the entire dataset.


-- ============================================================
-- BLOCK 6: SECONDARY ANALYSIS
-- The following dimensions show minimal variation consistent
-- with the rest of the dataset. Included for completeness.
-- ============================================================

-- ROI by target audience
SELECT Target_Audience,
       ROUND(AVG(ROI), 2) AS avg_roi,
       ROUND(AVG(Conversion_Rate), 4) AS avg_conversion,
       ROUND(AVG(Acquisition_Cost), 2) AS avg_cost
FROM campaigns
GROUP BY Target_Audience
ORDER BY avg_roi DESC;

-- Finding: Men 25-34 leads marginally with ROI 5.02.
-- Men 18-24 has the lowest ROI but highest conversion rate,
-- suggesting they convert but at lower transaction value.

-- ROI by language
SELECT Language,
       ROUND(AVG(ROI), 2) AS avg_roi,
       ROUND(AVG(Conversion_Rate), 4) AS avg_conversion
FROM campaigns
GROUP BY Language
ORDER BY avg_roi DESC;

-- Finding: French and Mandarin marginally lead in a US-based dataset,
-- which is unexpected and further confirms synthetic data generation.

-- Does campaign duration affect ROI?
SELECT
       CASE
           WHEN CAST(REGEXP_REPLACE(Duration, '[^0-9]', '') AS UNSIGNED) <= 30 THEN 'Short (≤30 days)'
           WHEN CAST(REGEXP_REPLACE(Duration, '[^0-9]', '') AS UNSIGNED) <= 60 THEN 'Medium (31-60 days)'
           ELSE 'Long (60+ days)'
       END AS campaign_length,
       ROUND(AVG(ROI), 2) AS avg_roi,
       ROUND(AVG(Conversion_Rate), 4) AS avg_conversion,
       COUNT(*) AS total_campaigns
FROM campaigns
GROUP BY campaign_length
ORDER BY avg_roi DESC;

-- Finding: Only two duration categories exist in the dataset.
-- No campaigns exceed 60 days. Both categories return identical ROI of 5.00.
-- Duration has no impact on performance in this dataset.