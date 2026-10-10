# Marketing Campaign Performance Analysis


## Business Problem
The Group CMO is currently allocating the marketing budget across 5 companies without a clear analysis of which channels and companies perform best, which risks underfunding high-performing channels while overspending on weaker ones. She needs to decide how to split next year's marketing budget across channels and companies, based on 2021 ROI by channel and company, within a fixed total budget.

**Client:** Group CMO (oversees marketing across all 5 companies) **Stakeholders**: CFO (return on spend), individual company Marketing Directors (compete for budget)

This project simulates a consulting engagement: the dataset is synthetic (sourced from Kaggle), so there was no real client. The business problem was framed deliberately to structure the analysis around a decision, rather than producing an unfocused exploration of the data.

---

## Business Questions
1. Is any channel meaningfully better than the others, or do they all perform about the same, and is that consistent across companies?
2. Is any company performing meaningfully better than the others, or are they roughly the same?
3. Has performance in any channel or company shifted meaningfully over the year, or has it stayed flat?

## Overview
Analysis of 200,000 marketing campaigns across 5 fictional companies using MySQL and Power BI. 
The project explores ROI, CTR, conversion rate, and acquisition cost across channels, campaign types, customer segments, and time to identify performance patterns and optimization opportunities.

---

## Author
**Belén Micó Velarde**  
[LinkedIn](www.linkedin.com/in/belenmicovelarde)

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

**Note on metrics**: ROI, Conversion Rate, and Acquisition Cost arrive pre-calculated in the dataset, so the underlying formulas could not be audited or verified for consistency across companies. CTR, Cost per Click, and Efficiency Score were calculated independently as part of this analysis (see DAX Measures below).

---

## Project Structure

```
marketing-campaign-analysis/
    │
    ├── README.md
    ├── sql/
    │       └── marketing_campaign_analysis.sql
    └── powerbi/
            └── marketing_campaign_analysis..pbix
´´´

---

## SQL Analysis Structure

**Block 1 — Know the Dataset**  
Data profiling: exploratory queries to understand dataset volume, date range, and key dimension values before trusting any analysis built on top of it.

**Block 2 — Global Company Ranking**  
Overall performance comparison across all five companies using ROI, conversion rate, acquisition cost, and engagement score. Answers Business Question 2.

**Block 3 — Channel and Campaign Type Performance**  
Decomposing ROI by company and channel, and by company and campaign type to identify whether any combination consistently outperforms others. Answers Business Question 1.

**Block 4 — Segments and Audiences**  
Identifying the most profitable customer segments per company and calculating CTR as a measure of creative efficiency.

**Block 5 — Trend Over Time**
Monthly ROI analysis per company across 2021 to detect seasonal patterns or performance shifts. Answers Business Question 3.

**Block 6 — Secondary Analysis**  
Analysis of target audience, language, and campaign duration as secondary dimensions. Included for completeness.

---

## Power BI Dashboard Structure

**Overview** --> What is the overall scale and performance of campaigns?
**Company Ranking** --> Which company performs best across all metrics?
**Channel & Campaign Type** --> Which channel and campaign type drives the best ROI?
**Segments & Audiences** --> Which customer segment is most profitable?
**Trend Over Time** --> Does ROI improve or decline throughout 2021?
**Secondary Analysis** --> Do audience, language and duration affect performance?

---

**KPI** | **Role** | **What it tells the CMO**
|---|---|
ROI | Primary | Return per unit spent — links cost directly to return, which a budget-split decision needs
Acquisition Cost | Supporting | Cost per customer — protects against treating two equal-ROI channels as equally attractive when one costs far more per customer
Campaign Volume (COUNT) | Supporting | Confirms a result isn't based on too small a sample to be reliable
Conversion Rate	Diagnostic | Helps explain why ROI moves
CTR | Diagnostic | Creative/ad relevance, independent of conversion

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

## Recommendation

ROI is flat at ~5.0 across all companies, channels, and segments, but without an external benchmark, it's not possible to tell whether that level is strong, weak, or simply meaningless. The CTR of ~14% is also far above real-world norms, which raises further doubts about the data itself. Given this, there is no evidence to justify reallocating the budget, so maintaining the current allocation is the safest approach. Before making any changes, the recommended next step is to test these findings against real campaign data or industry benchmarks to confirm whether the numbers hold up.

---

## Limitations

- **Synthetic data**: the dataset is artificially generated, so the patterns found here may not reflect how real campaigns behave.
**Limited business actionability: the project is valuable for practicing the full analytical process, but it does not produce an actionable business recommendation, since there is no real signal in the data to act on.
- **Pre-calculated metrics**: ROI, conversion rate, and acquisition cost were already calculated in the source dataset, so the formulas behind them could not be verified or checked for consistency across companies.
- **No external benchmark**: there is no industry benchmark for this context, which limits how confidently the numbers (e.g. ROI of 5.0, CTR of 14%) can be interpreted.

---

## Notes
This project was built using a synthetic dataset from Kaggle for portfolio purposes, so there was no real client or stakeholder, the business problem was framed deliberately to simulate one. The analytical framework, SQL structure, DAX measures, and dashboard design reflect the approach that would be applied to a real marketing dataset to identify channel optimization, audience targeting, and budget allocation opportunities.
