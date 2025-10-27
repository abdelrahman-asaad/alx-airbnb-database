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