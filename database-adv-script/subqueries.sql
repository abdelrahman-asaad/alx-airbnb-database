-- 1️⃣ Non-Correlated Subquery: Properties with average rating > 4.0
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

-- 2️⃣ Correlated Subquery: Users with more than 3 bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM user u
WHERE (
    SELECT COUNT(*) 
    FROM booking b 
    WHERE b.user_id = u.user_id
) > 3;
