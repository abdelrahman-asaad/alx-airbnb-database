-- Create indexes to improve performance

-- 🧍 User table indexes
CREATE INDEX idx_user_email ON user(email);
CREATE INDEX idx_user_role ON user(role);

-- 📅 Booking table indexes
CREATE INDEX idx_booking_user_id ON booking(user_id);
CREATE INDEX idx_booking_property_id ON booking(property_id);
CREATE INDEX idx_booking_status ON booking(status);

-- 🏠 Property table indexes
CREATE INDEX idx_property_location ON property(location);
CREATE INDEX idx_property_price ON property(price_per_night);

-- Check created indexes
SHOW INDEX FROM user;
SHOW INDEX FROM booking;
SHOW INDEX FROM property;
