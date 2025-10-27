# Query Optimization Report

## 🔹 Initial Query
The initial query joined four tables (booking, user, property, payment) and retrieved all columns.
While functional, it had a high cost due to multiple joins and lack of filtering.

## 🔹 Performance Analysis (Before Optimization)
Using `EXPLAIN ANALYZE`, the execution time was relatively high due to:
- Full table scans.
- Lack of indexes on foreign keys (`user_id`, `property_id`, `booking_id`).

## 🔹 Optimized Query
Optimizations applied:
- Added indexes on frequently joined columns.
- Reduced selected columns to only the necessary ones.

## 🔹 Performance Analysis (After Optimization)
Execution time reduced significantly.
Joins now use indexed lookups instead of full scans.
