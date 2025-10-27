-- 1️⃣ Initial Query (Before Optimization)
-- Retrieves all bookings with user, property, and payment details
SELECT 
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.status AS payment_status
FROM booking b
JOIN user u ON b.user_id = u.user_id
JOIN property p ON b.property_id = p.property_id
LEFT JOIN payment pay ON b.booking_id = pay.booking_id
WHERE pay.status = 'completed'
  AND p.location LIKE '%Egypt%';
  

-- 2️⃣ Analyze performance before optimization
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.status AS payment_status
FROM booking b
JOIN user u ON b.user_id = u.user_id
JOIN property p ON b.property_id = p.property_id
LEFT JOIN payment pay ON b.booking_id = pay.booking_id
WHERE pay.status = 'completed'
  AND p.location LIKE '%Egypt%';


-- 3️⃣ Optimized Query (After adding indexes & removing unnecessary columns)
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    u.first_name,
    u.last_name,
    p.name AS property_name,
    pay.amount
FROM booking b
JOIN user u ON b.user_id = u.user_id
JOIN property p ON b.property_id = p.property_id
LEFT JOIN payment pay ON b.booking_id = pay.booking_id
WHERE pay.status = 'completed'
  AND p.location LIKE '%Egypt%';
