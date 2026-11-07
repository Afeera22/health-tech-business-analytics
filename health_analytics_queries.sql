-- Health-Tech Business & Operations Analytics
-- SQL dialect: SQLite
-- Dataset: synthetic portfolio data
--
-- Business rules:
-- 1. Recognised revenue includes only Paid orders.
-- 2. Net revenue = gross_amount_inr - discount_inr.
-- 3. Funnel and customer conversion metrics use DISTINCT customers.
-- 4. Trial-to-programme conversion requires a paid programme order
--    after the customer's paid 7-Day Trial order.

-- 1. Customer count by city
SELECT
    city,
    COUNT(DISTINCT customer_id) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;


-- 2. Paid orders and net revenue by plan
SELECT
    plan_type,
    COUNT(order_id) AS paid_orders,
    COUNT(DISTINCT customer_id) AS unique_paying_customers,
    SUM(gross_amount_inr - discount_inr) AS net_revenue_inr
FROM orders
WHERE order_status = 'Paid'
GROUP BY plan_type
ORDER BY net_revenue_inr DESC;


-- 3. Overall recognised revenue
SELECT
    COUNT(order_id) AS paid_orders,
    COUNT(DISTINCT customer_id) AS unique_paying_customers,
    SUM(gross_amount_inr - discount_inr) AS total_net_revenue_inr
FROM orders
WHERE order_status = 'Paid';


-- 4. Monthly recognised revenue
SELECT
    strftime('%Y-%m', order_date) AS revenue_month,
    SUM(gross_amount_inr - discount_inr) AS net_revenue_inr,
    COUNT(order_id) AS paid_orders
FROM orders
WHERE order_status = 'Paid'
GROUP BY strftime('%Y-%m', order_date)
ORDER BY revenue_month;


-- 5. Customer acquisition channel
SELECT
    acquisition_channel,
    COUNT(DISTINCT customer_id) AS total_customers
FROM customers
GROUP BY acquisition_channel
ORDER BY total_customers DESC;


-- 6. Lead funnel stage breakdown
SELECT
    funnel_stage,
    COUNT(*) AS lead_records,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM leads
GROUP BY funnel_stage
ORDER BY lead_records DESC;


-- 7. Lead conversion rate using distinct lead customers
WITH lead_customers AS (
    SELECT DISTINCT customer_id
    FROM leads
),
converted_customers AS (
    SELECT DISTINCT customer_id
    FROM leads
    WHERE funnel_stage = 'Converted'
)
SELECT
    (SELECT COUNT(*) FROM lead_customers) AS unique_lead_customers,
    (SELECT COUNT(*) FROM converted_customers) AS converted_customers,
    ROUND(
        100.0 * (SELECT COUNT(*) FROM converted_customers)
        / NULLIF((SELECT COUNT(*) FROM lead_customers), 0),
        1
    ) AS lead_conversion_rate_pct;


-- 8. Trial customers and programme customers
SELECT
    COUNT(DISTINCT CASE
        WHEN plan_type = '7-Day Trial' THEN customer_id
    END) AS trial_customers,
    COUNT(DISTINCT CASE
        WHEN plan_type <> '7-Day Trial' THEN customer_id
    END) AS programme_customers
FROM orders
WHERE order_status = 'Paid';


-- 9. True trial-to-programme conversion
-- A customer converts only if they have a paid programme order
-- dated after their earliest paid 7-Day Trial order.
WITH trial_customers AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_trial_date
    FROM orders
    WHERE order_status = 'Paid'
      AND plan_type = '7-Day Trial'
    GROUP BY customer_id
),
programme_after_trial AS (
    SELECT DISTINCT t.customer_id
    FROM trial_customers t
    JOIN orders p
      ON p.customer_id = t.customer_id
     AND p.order_status = 'Paid'
     AND p.plan_type <> '7-Day Trial'
     AND p.order_date > t.first_trial_date
)
SELECT
    (SELECT COUNT(*) FROM trial_customers) AS trial_customers,
    (SELECT COUNT(*) FROM programme_after_trial) AS converted_to_programme,
    ROUND(
        100.0 * (SELECT COUNT(*) FROM programme_after_trial)
        / NULLIF((SELECT COUNT(*) FROM trial_customers), 0),
        1
    ) AS trial_to_programme_conversion_pct;


-- 10. Consultation status breakdown
SELECT
    consultation_status,
    COUNT(consultation_id) AS total_consultations
FROM consultations
GROUP BY consultation_status
ORDER BY total_consultations DESC;


-- 11. Consultation completion rate
SELECT
    COUNT(*) AS total_consultations,
    SUM(CASE WHEN consultation_status = 'Completed' THEN 1 ELSE 0 END)
        AS completed_consultations,
    ROUND(
        100.0 * SUM(CASE WHEN consultation_status = 'Completed' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        1
    ) AS completion_rate_pct
FROM consultations;


-- 12. Average consultation turnaround time by assigned team
SELECT
    assigned_team,
    ROUND(
        AVG(
            julianday(completion_date) - julianday(booking_date)
        ),
        1
    ) AS avg_turnaround_days
FROM consultations
WHERE consultation_status = 'Completed'
  AND booking_date IS NOT NULL
  AND completion_date IS NOT NULL
GROUP BY assigned_team
ORDER BY avg_turnaround_days;


-- 13. Overall average consultation turnaround time
SELECT
    ROUND(
        AVG(julianday(completion_date) - julianday(booking_date)),
        1
    ) AS avg_turnaround_days
FROM consultations
WHERE consultation_status = 'Completed'
  AND booking_date IS NOT NULL
  AND completion_date IS NOT NULL;
