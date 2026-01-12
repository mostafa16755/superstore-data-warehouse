## Superstore Data Warehouse Project

### Project Overview
This project demonstrates how to design and build a Data Warehouse from a raw transactional dataset using pure SQL.  
The goal is to transform the Global Superstore dataset into a clean, scalable **star schema** suitable for analytics and reporting.

The project follows industry-standard data engineering layers:

- Infrastructure  
- Staging  
- Profiling  
- Clean  
- Data Warehouse (Dimensions & Facts)  
- Analytics  

This project is **idempotent**, meaning all load scripts can be safely re-run without creating duplicate data.

---

## Architecture & Layers

### 1. Infrastructure Layer
**Purpose:**  
Establish the foundational database structure and security before any data is loaded.

**Key Features:**
- Create logical database schemas (staging, clean, dw, analytics)
- Create and manage users and roles
- Handle privileges and access control

---

### 2. Staging Layer
**Purpose:**  
Store raw data exactly as received from the source.

**Key Features:**
- Raw CSV ingestion using `COPY`
- No transformations, minimal constraints
- All columns stored as text or basic data types
- Load timestamp added for traceability

---

### 3. Clean Layer
**Purpose:**  
Apply data quality checks and business rules to prepare reliable data for the warehouse.

**Data Cleaning Rules Applied:**
- Remove duplicates using `(order_id, product_id)`
- Convert date fields to proper `DATE` type
- Handle multiple date formats
- Trim text fields
- Convert invalid values (e.g. `shipping_cost = 0 → NULL`)
- Ensure idempotent loads using **delete + insert** strategy

---

### 4. Data Warehouse Layer (Star Schema)

#### Dimensions
- **dim_customer** – customer details  
- **dim_product** – product attributes  
- **dim_location** – geographical attributes  
- **dim_date** – calendar attributes (order & ship dates)  

Each dimension:
- Uses a surrogate key
- Maintains a business key
- Prevents duplicate records

#### Fact Table
**fact_orders**
- Stores measurable metrics:
  - sales
  - quantity
  - discount
  - profit
  - shipping_cost
- Contains foreign keys to all dimensions
- Uses `order_id` as a degenerate dimension

---

### 5. Analytics Layer
**Purpose:**  
Provide analytics-ready views optimized for reporting, dashboards, and business analysis.

**Responsibilities:**
- Expose simplified views built on top of fact and dimension tables
- Support common analytical use cases (sales trends, profitability, customer analysis)
- Ensure consistent business logic for downstream consumers

This layer enables fast, reliable querying for BI tools and ad-hoc analysis.

---

## 🔁 Idempotent Loading Strategy
All load scripts are designed to be safe to run multiple times:
- Existing records are removed using business keys
- Fresh data is inserted
- Prevents duplication and ensures consistency

This reflects real-world batch data warehouse pipelines.

---

## 🛠 Technologies Used
- PostgreSQL  
- SQL (DDL, DML, Window Functions)  
- Star Schema Modeling  
- Data Quality & Validation Techniques  

---

## 📂 Project Structure
```text
project-root/
│
├── infrastructure/
│   ├── create_schemas.sql
│   ├── create_roles.sql
│   └── handle_privilage.sql
│
├── staging/
│   ├── create_staging_tables.sql
│   └── load_staging.sql
│
├── profiling/
│   └── data_profiling.sql
│
├── clean/
│   ├── create_clean_tables.sql
│   └── load_clean.sql
│
├── dw/
│   ├── create_dimensions.sql
│   ├── create_fact.sql
│   ├── load_dw.sql
│   └── validate_dw.sql
│
└── analytics/
    └── analytics_views.sql
