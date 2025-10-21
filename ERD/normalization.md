# 🧩 Database Normalization to 3NF

## 🎯 Objective
Apply normalization principles to ensure the **AirBnB database** is structured efficiently, eliminating redundancy and ensuring data integrity up to **Third Normal Form (3NF)**.

---

## 🧠 What is Normalization?

**Normalization** is the process of organizing data in a database to minimize redundancy and improve data integrity.  
The goal is to divide large tables into smaller, related ones and define relationships between them.

---

## ⚙️ Normalization Steps

### **1️⃣ First Normal Form (1NF)**
**Rule:**  
- Each cell contains atomic (indivisible) values.  
- Each record is unique.

**Changes Applied:**
- Ensured all attributes hold single values (no lists or arrays).  
  ✅ Example: Split `full_name` into `first_name` and `last_name`.  
- Added primary keys (`user_id`, `property_id`, etc.) to all tables.

**Result:**  
All tables have unique identifiers and atomic fields.

---

### **2️⃣ Second Normal Form (2NF)**
**Rule:**  
- Must be in 1NF.  
- All non-key attributes must depend on the entire primary key (not part of it).

**Changes Applied:**
- Removed partial dependencies in composite tables.  
- Example: If `Booking` used `(property_id, user_id)` as a composite key, we replaced it with a single key `booking_id` and kept both as foreign keys.  
- Ensured attributes like `total_price` depend on the entire booking, not just one key.

**Result:**  
Each non-key attribute depends on the full primary key.

---

### **3️⃣ Third Normal Form (3NF)**
**Rule:**  
- Must be in 2NF.  
- No transitive dependencies (non-key attributes should not depend on other non-key attributes).

**Changes Applied:**
- Ensured user info (e.g., `email`, `phone_number`) is stored only in `User` table — not repeated elsewhere.
- Removed redundant attributes:
  - `host_name` removed from `Property` (use FK to `User` instead).
  - `guest_name` removed from `Booking` (use FK to `User` instead).
- Payment and Review tables reference their parent entities through IDs, avoiding repeated details like property name or user email.

**Result:**  
No transitive dependencies remain — data is fully normalized to **3NF**.

---

## 🧾 Final Table Summary (After Normalization)

| Table | Description |
|--------|--------------|
| **User** | Stores all user details (guest/host/admin). |
| **Property** | Linked to `User` via `host_id`. |
| **Booking** | Links `User` and `Property`. |
| **Payment** | Linked to a specific `Booking`. |
| **Review** | Linked to both `User` and `Property`. |
| **Message** | Represents communication between users. |

---

## ✅ Benefits Achieved
- **Reduced redundancy** (no repeated user or property info).
- **Improved integrity** via foreign keys.
- **Simplified updates** (changes happen in one place).
- **Optimized queries** with clear relationships.

---

## 🧭 Conclusion
After applying all normalization steps:
> ✅ The AirBnB database schema is now in **Third Normal Form (3NF)**.

This ensures:
- Minimal redundancy  
- Maximum consistency  
- Logical and scalable structure

---

**Author:** *Your Name*  
**Repository:** `alx-airbnb-database`  
**Directory:** `ERD/`  
**File:** `normalization.md`
