-- =============================================
-- INNER JOIN: Retrieve all bookings and the respective users who made those bookings
-- =============================================
SELECT 
    booking.booking_id,
    booking.property_id,
    user.user_id,
    CONCAT(user.first_name, ' ', user.last_name) AS full_name,
    user.email,
    booking.start_date,
    booking.end_date,
    booking.total_price,
    booking.status
FROM booking
INNER JOIN user 
    ON booking.user_id = user.user_id;

-- =============================================
-- LEFT JOIN: Retrieve all properties and their reviews (including properties that have no reviews)
-- =============================================
SELECT 
    property.property_id,
    property.name AS property_name,
    property.location,
    review.review_id,
    review.rating,
    review.comment,
    review.created_at AS review_date
FROM property
LEFT JOIN review 
    ON property.property_id = review.property_id;
ORDER BY property.name;    


-- =============================================
-- FULL OUTER JOIN: Retrieve all users and all bookings 
-- (even if the user has no booking or a booking is not linked to a user)
-- =============================================
-- ⚠️ MySQL does NOT support FULL OUTER JOIN directly
-- so we simulate it by combining LEFT JOIN and RIGHT JOIN using UNION

SELECT 
    user.user_id,
    CONCAT(user.first_name, ' ', user.last_name) AS full_name,
    booking.booking_id,
    booking.start_date,
    booking.end_date,
    booking.status
FROM user
LEFT JOIN booking 
    ON user.user_id = booking.user_id

UNION

SELECT 
    user.user_id,
    CONCAT(user.first_name, ' ', user.last_name) AS full_name,
    booking.booking_id,
    booking.start_date,
    booking.end_date,
    booking.status
FROM user
RIGHT JOIN booking 
    ON user.user_id = booking.user_id;
