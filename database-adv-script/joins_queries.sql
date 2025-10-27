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
