# Marketing Campaign Performance Analysis

## Overview
Analysis of 200,000 marketing campaigns across 5 fictional companies using MySQL and Power BI. 
The project explores ROI, CTR, conversion rate, and acquisition cost across channels, campaign types, customer segments, and time to identify performance patterns and optimization opportunities.

---

## Author
**Belén Micó Velarde**  
[LinkedIn](https://www.linkedin.com/in/belenmicov)

---

## Tools
- **MySQL** --> data exploration and analysis
- **Power BI** --> interactive dashboard and DAX measures

---

## Dataset
- **Source:** Marketing Campaign Performance Dataset (Kaggle)
- **Period:** January 2021 to December 2021
- **Volume:** ~200,000 campaigns
- **Companies:** Alpha Innovations, DataTech Solutions, Innovate Industries, NexGen Systems, TechCorp
- **Key columns:** Campaign Type, Channel Used, Customer Segment, ROI, Conversion Rate, Acquisition Cost, Clicks, Impressions, Engagement Score, Target Audience, Language, Duration

---

## Project Structure
marketing-campaign-analysis/
│
├── README.md
├── sql/
│   └── marketing_campaign_analysis.sql
└── powerbi/
    └── marketing_campaign_analysis..pbix

---

## SQL Analysis Structure

**Block 1 — Know the Dataset**  
Exploratory queries to understand dataset volume, date range, and key dimension values.

**Block 2 — Global Company Ranking**  
Overall performance comparison across all five companies using ROI, conversion rate, acquisition cost, and engagement score.

**Block 3 — Channel and Campaign Type Performance**  
Decomposing ROI by company and channel, and by company and campaign type to identify whether any combination consistently outperforms others.

**Block 4 — Segments and Audiences**  
Identifying the most profitable customer segments per company and calculating CTR as a measure of creative efficiency.

**Block 5 — Trend Over Time**
Monthly ROI analysis per company across 2021 to detect seasonal patterns or performance shifts.

**Block 6 — Secondary Analysis**  
Analysis of target audience, language, and campaign duration as secondary dimensions. 
Included for completeness.

---

## Power BI Dashboard Structure

Overview --> What is the overall scale and performance of campaigns?
Company Ranking --> Which company performs best across all metrics?
Channel & Campaign Type --> Which channel and campaign type drives the best ROI?
Segments & Audiences --> Which customer segment is most profitable?
Trend Over Time --> Does ROI improve or decline throughout 2021?
Secondary Analysis --> Do audience, language and duration affect performance?

---

## DAX Measures Created

CTR = DIVIDE(SUM(marketing_dataset[Clicks]), SUM(marketing_dataset[Impressions])) * 100
Efficiency Score = DIVIDE(AVERAGE(marketing_dataset[ROI]), AVERAGE(marketing_dataset[Acquisition_Cost]))
Cost per Click = DIVIDE(SUM(marketing_dataset[Acquisition_Cost]), SUM(marketing_dataset[Clicks]))

---

## Key Findings

- **No company holds a clear competitive advantage.** ROI ranges from 4.99 to 5.01 across all five companies, a difference of 0.02 that is not statistically meaningful.
- **No channel or campaign type consistently outperforms others.** Differences remain under 0.06 ROI across all channels and types.
- **CTR is uniform at ~14% across all companies**, significantly above real world benchmarks, confirming the synthetic nature of the dataset.
- **NexGen Systems shows the only notable temporal pattern**, with a mid-year ROI dip between March and July followed by a recovery in Q3.
- **Secondary dimensions show no meaningful variation.** Target audience, language, and campaign duration all return virtually identical ROI values.
- **The dataset is synthetic.** The uniformity across all dimensions confirms random generation centered around the same mean values. This limits actionable conclusions but the analytical framework applied reflects real world marketing analysis methodology.

---

## Notes
This project was built using a synthetic dataset from Kaggle for portfolio purposes. 
The analytical framework, SQL structure, DAX measures, and dashboard design reflect the approach that would be applied to a real marketing dataset to identify channel optimization, audience targeting, and budget allocation opportunities.
