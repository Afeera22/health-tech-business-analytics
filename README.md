# Health-Tech Business & Operations Analytics

## Project Overview

An end-to-end business analytics project using synthetic health-tech data to analyse revenue performance, customer acquisition, lead conversion and consultation operations.

The project demonstrates how SQL and Power BI can transform raw business data into actionable insights for business and operations teams.

## Business Objectives

- Analyse customer acquisition and lead funnel performance.
- Measure revenue generated across different subscription plans.
- Understand trial-to-programme conversion.
- Evaluate consultation completion, cancellations and no-shows.
- Monitor consultation turnaround time across assigned teams.

## Dataset

The project uses four synthetic datasets:

| Dataset | Records |
|---|---:|
| Customers | 600 |
| Leads | 617 |
| Orders | 729 |
| Consultations | 559 |

## Tools & Technologies

- SQL (SQLite)
- Microsoft Power BI
- DAX
- Microsoft Excel

## SQL Analysis

SQL techniques used:

- SELECT, WHERE and GROUP BY
- Aggregate functions
- Joins
- Common Table Expressions (CTEs)
- COUNT DISTINCT
- Date-based analysis
- Customer-level conversion analysis

## Power BI Dashboards

### 1. Business Performance
- Total revenue
- Total customers
- Paid orders
- Monthly revenue trends
- Revenue by plan type
- Customers by acquisition channel

### 2. Customer Funnel
- Total leads
- Unique lead customers
- Lead conversion rate
- Trial customers
- Programme customers
- Trial-to-programme conversion

### 3. Consultation Operations
- Total consultations
- Completed and cancelled consultations
- No-show consultations
- Consultation completion rate
- Average consultation turnaround time
- Team-wise turnaround comparison

## Key Business Findings

### Revenue Performance
- Total recognised revenue: ₹35,74,682.
- The 12-Week Programme contributed the largest revenue share.
- The 24-Week Programme generated higher average revenue per paid order than the other plans.

### Customer Funnel
- 617 total lead records.
- 524 unique lead customers.
- Lead conversion rate: 32.8%.
- 318 customers purchased a 7-Day Trial.
- 42 trial customers subsequently purchased a programme.
- Actual trial-to-programme conversion rate: 13.2%.

### Consultation Operations
- 559 total consultations.
- 341 completed consultations.
- 82 cancelled consultations.
- 52 no-show consultations.
- 84 scheduled consultations.
- Completion rate: 61%.
- Average turnaround time: 3.2 days.

## Business Recommendations

1. Improve follow-up strategies for trial customers to increase programme conversion.
2. Investigate cancellation and no-show patterns to improve consultation attendance.
3. Review team-wise turnaround times to identify operational bottlenecks.
4. Monitor monthly revenue and customer conversion trends to support business decisions.

## Project Outcome

Built a three-page interactive Power BI dashboard supported by SQL analysis to evaluate business performance, customer conversion and consultation operations.

**Note:** All datasets used in this project are synthetic and created for learning and portfolio demonstration purposes. They do not represent actual company or customer records.
