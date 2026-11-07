# Health-Tech Business & Operations Analytics

Synthetic portfolio dataset for a health-tech business analytics project.

## Files
- customers.csv — 600 customer records
- leads.csv — 617 lead records
- orders.csv — 729 order records
- consultations.csv — 559 consultation records
- data_dictionary.csv — column descriptions

## Business rules
- Recognised revenue includes only orders with `order_status = 'Paid'`.
- Net revenue = `gross_amount_inr - discount_inr`.
- Failed, cancelled and refunded orders are excluded from recognised revenue.
- Funnel metrics use distinct customers where appropriate.
- Trial-to-programme conversion requires a paid programme order after a paid 7-Day Trial.

## Important
All records are synthetic and created for portfolio demonstration. They do not represent real customers or any employer's data.
