-- 1️⃣ Drop old table if exists
DROP TABLE IF EXISTS booking_partitioned;

-- 2️⃣ Create partitioned version of booking table based on start_date
CREATE TABLE booking_partitioned (
    booking_id CHAR(36) PRIMARY KEY,
    user_id CHAR(36),
    property_id CHAR(36),
    start_date DATE,
    end_date DATE,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION pmax  VALUES LESS THAN MAXVALUE
);

-- 3️⃣ Insert existing data into new partitioned table
INSERT INTO booking_partitioned
SELECT * FROM booking;

-- 4️⃣ Example query before optimization (unpartitioned)
EXPLAIN ANALYZE
SELECT * FROM booking
WHERE start_date BETWEEN '2025-01-01' AND '2025-06-30';

-- 5️⃣ Example query after optimization (partitioned)
EXPLAIN ANALYZE
SELECT * FROM booking_partitioned
WHERE start_date BETWEEN '2025-01-01' AND '2025-06-30';
