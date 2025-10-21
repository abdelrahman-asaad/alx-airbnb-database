-- =====================================================
-- Airbnb Database - Sample Data (seed.sql)
-- =====================================================

USE airbnb_db;

-- ==============================
-- 1. Users
-- ==============================
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
(UUID(), 'Ahmed', 'Khaled', 'ahmed.khaled@example.com', 'hashed_pwd_1', '0100000001', 'guest'),
(UUID(), 'Sara', 'Mahmoud', 'sara.mahmoud@example.com', 'hashed_pwd_2', '0100000002', 'host'),
(UUID(), 'Omar', 'Youssef', 'omar.youssef@example.com', 'hashed_pwd_3', '0100000003', 'admin'),
(UUID(), 'Laila', 'Hassan', 'laila.hassan@example.com', 'hashed_pwd_4', '0100000004', 'guest');

-- ==============================
-- 2. Properties
-- ==============================
INSERT INTO Property (property_id, host_id, name, description, location, price_per_night)
VALUES
(UUID(), (SELECT user_id FROM User WHERE email='sara.mahmoud@example.com'),
'Seaview Apartment', 'Cozy apartment with sea view', 'Alexandria, Egypt', 120.00),
(UUID(), (SELECT user_id FROM User WHERE email='sara.mahmoud@example.com'),
'Desert Villa', 'Luxury villa in the desert with private pool', 'Siwa Oasis, Egypt', 300.00);

-- ==============================
-- 3. Bookings
-- ==============================
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
(UUID(),
(SELECT property_id FROM Property WHERE name='Seaview Apartment'),
(SELECT user_id FROM User WHERE email='ahmed.khaled@example.com'),
'2025-11-01', '2025-11-05', 480.00, 'confirmed'),

(UUID(),
(SELECT property_id FROM Property WHERE name='Desert Villa'),
(SELECT user_id FROM User WHERE email='laila.hassan@example.com'),
'2025-12-10', '2025-12-15', 1500.00, 'pending');

-- ==============================
-- 4. Payments
-- ==============================
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
(UUID(),
(SELECT booking_id FROM Booking WHERE status='confirmed'),
480.00, 'credit_card');

-- ==============================
-- 5. Reviews
-- ==============================
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
(UUID(),
(SELECT property_id FROM Property WHERE name='Seaview Apartment'),
(SELECT user_id FROM User WHERE email='ahmed.khaled@example.com'),
5, 'Amazing stay! Great view and clean apartment.'),

(UUID(),
(SELECT property_id FROM Property WHERE name='Desert Villa'),
(SELECT user_id FROM User WHERE email='laila.hassan@example.com'),
4, 'Lovely place, but Wi-Fi could be better.');

-- ==============================
-- 6. Messages
-- ==============================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
(UUID(),
(SELECT user_id FROM User WHERE email='ahmed.khaled@example.com'),
(SELECT user_id FROM User WHERE email='sara.mahmoud@example.com'),
'Hi Sara, is the apartment available for next weekend?'),

(UUID(),
(SELECT user_id FROM User WHERE email='sara.mahmoud@example.com'),
(SELECT user_id FROM User WHERE email='ahmed.khaled@example.com'),
'Hi Ahmed! Yes, it’s available. You can book it directly.');

