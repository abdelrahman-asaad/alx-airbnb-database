# Airbnb Database – Join Queries

This directory contains SQL queries demonstrating different types of joins using the Airbnb database schema.

## Files
- **joins_queries.sql**: Contains INNER JOIN, LEFT JOIN, and FULL OUTER JOIN examples.

## Queries Overview

### 1️⃣ INNER JOIN
Retrieves all bookings along with user details for each booking.

### 2️⃣ LEFT JOIN
Retrieves all properties and their reviews, including properties that do not have any reviews.

### 3️⃣ FULL OUTER JOIN
Retrieves all users and all bookings, even if a user has no bookings or a booking is not linked to any user.  
(Simulated in MySQL using `UNION` of `LEFT JOIN` and `RIGHT JOIN`.)


the result 
-------------------------+------------+------------+-------------+-----------+
| booking_id                           | property_id                          | user_id                              | full_name    | email                    | start_date | end_date   | total_price | status    |
+--------------------------------------+--------------------------------------+--------------------------------------+--------------+--------------------------+------------+------------+-------------+-----------+
| 034daf33-aec0-11f0-9da6-d4bed95d063f | 034d013c-aec0-11f0-9da6-d4bed95d063f | 3832c0be-aebf-11f0-9da6-d4bed95d063f | Ahmed Khaled | ahmed.khaled@example.com | 2025-11-01 | 2025-11-05 |      480.00 | confirmed |
| 034dbe57-aec0-11f0-9da6-d4bed95d063f | 034d0cb7-aec0-11f0-9da6-d4bed95d063f | 38334214-aebf-11f0-9da6-d4bed95d063f | Laila Hassan | laila.hassan@example.com | 2025-12-10 | 2025-12-15 |     1500.00 | pending   |
+--------------------------------------+--------------------------------------+--------------------------------------+--------------+--------------------------+------------+------------+-------------+-----------+
2 rows in set (0.01 sec)

+--------------------------------------+-------------------+-------------------+--------------------------------------+--------+-----------------------------------------------+---------------------+
| property_id                          | property_name     | location          | review_id                            | rating | comment                                       | review_date         |
+--------------------------------------+-------------------+-------------------+--------------------------------------+--------+-----------------------------------------------+---------------------+
| 034d0cb7-aec0-11f0-9da6-d4bed95d063f | Desert Villa      | Siwa Oasis, Egypt | 034f3ec6-aec0-11f0-9da6-d4bed95d063f |      4 | Lovely place, but Wi-Fi could be better.      | 2025-10-21 23:53:36 |
| 034d013c-aec0-11f0-9da6-d4bed95d063f | Seaview Apartment | Alexandria, Egypt | 034f316f-aec0-11f0-9da6-d4bed95d063f |      5 | Amazing stay! Great view and clean apartment. | 2025-10-21 23:53:36 |
+--------------------------------------+-------------------+-------------------+--------------------------------------+--------+-----------------------------------------------+---------------------+
2 rows in set (0.00 sec)

+--------------------------------------+--------------+--------------------------------------+------------+------------+-----------+
| user_id                              | full_name    | booking_id                           | start_date | end_date   | status    |
+--------------------------------------+--------------+--------------------------------------+------------+------------+-----------+
| 3832c0be-aebf-11f0-9da6-d4bed95d063f | Ahmed Khaled | 034daf33-aec0-11f0-9da6-d4bed95d063f | 2025-11-01 | 2025-11-05 | confirmed |
| 38333737-aebf-11f0-9da6-d4bed95d063f | Sara Mahmoud | NULL                                 | NULL       | NULL       | NULL      |
| 38333e64-aebf-11f0-9da6-d4bed95d063f | Omar Youssef | NULL                                 | NULL       | NULL       | NULL      |
| 38334214-aebf-11f0-9da6-d4bed95d063f | Laila Hassan | 034dbe57-aec0-11f0-9da6-d4bed95d063f | 2025-12-10 | 2025-12-15 | pending   |
+--------------------------------------+--------------+--------------------------------------+------------+------------+-----------+
4 rows in set (0.00 sec)
_________________________

# Subqueries Practice

## 🎯 Objective
This task demonstrates how to use **correlated** and **non-correlated** subqueries in SQL for the Airbnb Database.

---

## 🧮 1️⃣ Non-Correlated Subquery
**Goal:** Retrieve all properties where the average rating is greater than 4.0.

### SQL Query:
```sql
SELECT 
    property_id,
    name,
    location,
    price_per_night
FROM property
WHERE property_id IN (
    SELECT property_id
    FROM review
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);

mysql> SOURCE C:/Users/Dell/Desktop/airbnp/alx-airbnb-database/database-adv-script/subqueries.sql;
+--------------------------------------+-------------------+-------------------+-----------------+
| property_id                          | name              | location          | price_per_night |
+--------------------------------------+-------------------+-------------------+-----------------+
| 034d013c-aec0-11f0-9da6-d4bed95d063f | Seaview Apartment | Alexandria, Egypt |          120.00 |
+--------------------------------------+-------------------+-------------------+-----------------+
1 row in set (0.01 sec)
Empty set (0.00 sec) لان مفيش مستخدمين باكتر من 3 حجوزات
_____________________
### 3. Apply Aggregations and Window Functions
**Objective:** Use SQL aggregation and window functions to analyze data.

**Queries:**
1. Calculate the total number of bookings made by each user using `COUNT` and `GROUP BY`.
2. Use a window function (`RANK`) to rank properties based on the total number of bookings.

**Run command:**
```sql
mysql> SOURCE C:/Users/Dell/Desktop/airbnp/alx-airbnb-database/database-adv-script/aggregations_and_window_functions.sql;
+--------------------------------------+--------------+----------------+
| user_id                              | user_name    | total_bookings |
+--------------------------------------+--------------+----------------+
| 3832c0be-aebf-11f0-9da6-d4bed95d063f | Ahmed Khaled |              1 |
| 38334214-aebf-11f0-9da6-d4bed95d063f | Laila Hassan |              1 |
| 38333737-aebf-11f0-9da6-d4bed95d063f | Sara Mahmoud |              0 |
| 38333e64-aebf-11f0-9da6-d4bed95d063f | Omar Youssef |              0 |
+--------------------------------------+--------------+----------------+
4 rows in set (0.00 sec)

+--------------------------------------+-------------------+----------------+--------------+
| property_id                          | property_name     | total_bookings | booking_rank |
+--------------------------------------+-------------------+----------------+--------------+
| 034d013c-aec0-11f0-9da6-d4bed95d063f | Seaview Apartment |              1 |            1 |
| 034d0cb7-aec0-11f0-9da6-d4bed95d063f | Desert Villa      |              1 |            1 |
+--------------------------------------+-------------------+----------------+--------------+
2 rows in set (0.00 sec)

+--------------------------------------+-------------------+----------------+--------------------+
| property_id                          | property_name     | total_bookings | booking_row_number |
+--------------------------------------+-------------------+----------------+--------------------+
| 034d013c-aec0-11f0-9da6-d4bed95d063f | Seaview Apartment |              1 |                  1 |
| 034d0cb7-aec0-11f0-9da6-d4bed95d063f | Desert Villa      |              1 |                  2 |
+--------------------------------------+-------------------+----------------+--------------------+
2 rows in set (0.00 sec)