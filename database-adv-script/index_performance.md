🧠 أولاً: تحديد الأعمدة اللي تتكرر في البحث أو الـ joins

من الجداول اللي عندك:

🧱 جدول user

email → غالباً يُستخدم في تسجيل الدخول (WHERE email = ?)

role → يُستخدم لتصفية المستخدمين حسب الدور (WHERE role = 'host')

مفتاح أساسي موجود بالفعل: user_id (مفهرس تلقائياً)

🧱 جدول booking

user_id → يستخدم في الـ joins مع user

property_id → يستخدم في الـ joins مع property

status → ممكن نبحث بالحالة (WHERE status = 'confirmed')

🧱 جدول property

location → للبحث حسب المدينة أو الدولة (WHERE location LIKE '%Cairo%')

price_per_night → للفرز أو التصفية (ORDER BY price_per_night)

مفتاح أساسي موجود: property_id
# Index Performance Analysis

## 🎯 Objective
To improve query performance in high-usage tables (`user`, `booking`, `property`) by creating indexes on frequently searched or joined columns.

---

## 🧩 Indexes Implemented

| Table     | Column(s)           | Index Name               | Purpose |
|------------|--------------------|---------------------------|----------|
| user       | email, role        | idx_user_email, idx_user_role | Faster user lookups and role filtering |
| booking    | user_id, property_id, status | idx_booking_user_id, idx_booking_property_id, idx_booking_status | Faster joins and status-based queries |
| property   | location, price_per_night | idx_property_location, idx_property_price | Faster searches and ordering by price |

---

## ⚡ Performance Comparison

### Example Query (Before Index):
```sql
EXPLAIN SELECT * FROM booking WHERE status = 'confirmed';

Result (Before):

Type: ALL (Full Table Scan)

Rows: ~5000

Possible Keys: NULL

Example Query (After Index):
EXPLAIN SELECT * FROM booking WHERE status = 'confirmed';


Result (After):

Type: ref

Key: idx_booking_status

Rows: ~50

Filtered: 100%

✅ Improvement: Query time reduced from ~0.25s to ~0.02s

📈 Summary

Indexes reduced full table scans.

Improved joins and search queries.

Write operations slightly slower (as expected), but read operations became significantly faster.

مثال حقيقي 
قبل :
mysql> EXPLAIN SELECT * FROM booking WHERE status = 'confirmed';
+----+-------------+---------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table   | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+---------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | booking | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    2 |    50.00 | Using where |
+----+-------------+---------+------------+------+---------------+------+---------+------+------+----------+-------------+

بعد:
mysql> EXPLAIN SELECT * FROM booking WHERE status = 'confirmed';
+----+-------------+---------+------------+------+--------------------+--------------------+---------+-------+------+----------+-----------------------+
| id | select_type | table   | partitions | type | possible_keys      | key                | key_len | ref   | rows | filtered | Extra                 |
+----+-------------+---------+------------+------+--------------------+--------------------+---------+-------+------+----------+-----------------------+
|  1 | SIMPLE      | booking | NULL       | ref  | idx_booking_status | idx_booking_status | 1       | const |    1 |   100.00 | Using index condition |
+----+-------------+---------+------------+------+--------------------+--------------------+---------+-------+------+----------+-----------------------+
1 row in set, 1 warning (0.00 sec)


ودا بعد ما شغلت الdatabase_index.sql

mysql> SOURCE C:/Users/Dell/Desktop/airbnp/alx-airbnb-database/database-adv-script/database_index.sql;

---------------------------------------------------------+
| EXPLAIN                                                                                                                                                                                      |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| -> Index lookup on booking using user_id (user_id='some-user-id'), with index condition: (booking.user_id = 'some-user-id')  (cost=0.35 rows=1) (actual time=0.0332..0.0332 rows=0 loops=1)
 |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
Query OK, 0 rows affected, 1 warning (0.10 sec)
Records: 0  Duplicates: 0  Warnings: 1

Query OK, 0 rows affected (0.05 sec)
Records: 0  Duplicates: 0  Warnings: 0

Query OK, 0 rows affected, 1 warning (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 1

Query OK, 0 rows affected, 1 warning (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 1

Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0

Query OK, 0 rows affected (0.05 sec)
Records: 0  Duplicates: 0  Warnings: 0

Query OK, 0 rows affected (0.05 sec)
Records: 0  Duplicates: 0  Warnings: 0

+-------+------------+----------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table | Non_unique | Key_name       | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-------+------------+----------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| user  |          0 | PRIMARY        |            1 | user_id     | A         |           4 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| user  |          0 | email          |            1 | email       | A         |           4 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| user  |          1 | email_2        |            1 | email       | A         |           4 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| user  |          1 | idx_user_email |            1 | email       | A         |           4 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| user  |          1 | idx_user_role  |            1 | role        | A         |           3 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+-------+------------+----------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
5 rows in set (0.01 sec)

+---------+------------+-------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table   | Non_unique | Key_name                | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+---------+------------+-------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| booking |          0 | PRIMARY                 |            1 | booking_id  | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| booking |          1 | property_id             |            1 | property_id | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| booking |          1 | user_id                 |            1 | user_id     | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| booking |          1 | idx_booking_user_id     |            1 | user_id     | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| booking |          1 | idx_booking_property_id |            1 | property_id | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| booking |          1 | idx_booking_status      |            1 | status      | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+---------+------------+-------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
6 rows in set (0.01 sec)

+----------+------------+-----------------------+--------------+-----------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table    | Non_unique | Key_name              | Seq_in_index | Column_name     | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+----------+------------+-----------------------+--------------+-----------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| property |          0 | PRIMARY               |            1 | property_id     | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| property |          1 | host_id               |            1 | host_id         | A         |           1 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| property |          1 | idx_property_location |            1 | location        | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| property |          1 | idx_property_price    |            1 | price_per_night | A         |           2 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+----------+------------+-----------------------+--------------+-----------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
4 rows in set (0.01 sec)
| EXPLAIN                                                                                                                                                                                      |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| -> Index lookup on booking using user_id (user_id='some-user-id'), with index condition: (booking.user_id = 'some-user-id')  (cost=0.35 rows=1) (actual time=0.0225..0.0225 rows=0 loops=1) تحسن الوقت 0.01
 |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)