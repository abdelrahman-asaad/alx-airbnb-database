# 🏠 Airbnb Database Schema

## 📄 Overview
This directory contains the **SQL schema** for the Airbnb database, designed according to the provided specifications and normalized to
 **Third Normal Form (3NF)**.

---

## 🧱 Files
| File | Description |
|------|--------------|
| `schema.sql` | SQL script that creates all tables, keys, and constraints. |
| `README.md` | Explanation of the design and relationships between entities. |

---

## ⚙️ Entities
The database includes the following main entities:

- **User**: Stores all platform users (guests, hosts, admins)
- **Property**: Represents listed accommodations
- **Booking**: Connects users to properties via reservations
- **Payment**: Stores payment information for bookings
- **Review**: Guest feedback on properties
- **Message**: Communication between users

---

## 🔐 Constraints & Integrity
- **Primary Keys:** All tables use UUIDs as primary keys.
- **Foreign Keys:** Maintain referential integrity across entities.
- **Unique Constraints:** On `email` field in `User` table.
- **Check Constraints:** Ensure valid rating range (1–5).

---

## 🚀 How to Use
1. Open MySQL shell:
   ```bash
   mysql -u root -p
