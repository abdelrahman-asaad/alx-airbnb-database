-- 1️⃣ Aggregation Query: Total number of bookings made by each user
SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    COUNT(b.booking_id) AS total_bookings
FROM user u
LEFT JOIN booking b 
    ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;

-- 2️⃣ Window Function: Rank properties based on total number of bookings
SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM property p
LEFT JOIN booking b 
    ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY booking_rank;

-- شرح مختصر

-- الاستعلام الأول:
-- يستخدم COUNT و GROUP BY علشان يحسب إجمالي عدد الحجوزات لكل مستخدم.
-- لو المستخدم معندوش حجوزات، بيظهر برضو بسبب LEFT JOIN.

-- الاستعلام الثاني:
-- بيحسب عدد الحجوزات لكل عقار، وبعدها يستخدم RANK() (دالة نافذة window function) لترتيب العقارات حسب عدد الحجوزات من الأعلى إلى الأقل.
