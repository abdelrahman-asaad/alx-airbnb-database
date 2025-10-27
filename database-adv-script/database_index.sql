-- Create indexes to improve performance

-- 1️⃣ قبل إنشاء الفهارس: تحليل الأداء الحالي
EXPLAIN ANALYZE 
SELECT * 
FROM booking 
WHERE user_id = 'some-user-id';

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


-- 3️⃣ بعد إنشاء الفهارس: إعادة تحليل الأداء
EXPLAIN ANALYZE 
SELECT * 
FROM booking 
WHERE user_id = 'some-user-id';

-- ملاحظات:
-- ⬆️ EXPLAIN ANALYZE بيعرض خطة التنفيذ (Execution Plan)
-- وبيوضح وقت التنفيذ قبل وبعد الفهارس
-- بحيث تقدر تشوف فعلاً هل الأداء اتحسن ولا لأ