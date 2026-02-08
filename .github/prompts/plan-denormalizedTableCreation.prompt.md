# Plan: Creating a Denormalized Table with 30-40 Attributes & PK-FK Relationships

## 1. Objective
Create a denormalized fake data table with 30-40 related attributes in a single subject area that:
- Contains a Primary Key (PK)
- Maintains Foreign Key (FK) relationships to parent/lookup tables
- Demonstrates real-world denormalization patterns
- Uses MySQL as the database technology
- Includes sample fake data

---

## 2. Subject Area Selection (To Be Defined)
**Status:** Awaiting clarification on domain/subject area

### Recommended Domain Options:
1. **E-Commerce Order Management**
   - Main table: `denormalized_orders`
   - Related dimensions: customers, products, categories, suppliers, regions

2. **Healthcare Patient Records**
   - Main table: `denormalized_patient_encounters`
   - Related dimensions: patients, doctors, departments, diagnoses, medications

3. **Employee & HR Management**
   - Main table: `denormalized_employee_records`
   - Related dimensions: departments, designations, projects, skills, locations

4. **Sales & CRM**
   - Main table: `denormalized_sales_transactions`
   - Related dimensions: customers, products, sales_teams, regions, campaigns

5. **Banking/Financial Transactions**
   - Main table: `denormalized_transactions`
   - Related dimensions: accounts, customers, transaction_types, branches

---

## 3. Table Design Structure

### 3.1 Primary Key
- `primary_id` (INT, AUTO_INCREMENT, PRIMARY KEY)
- Uniquely identifies each record in the denormalized table

### 3.2 Foreign Keys (Example Structure)
Assuming E-Commerce Order example:
- `fk_customer_id` → REFERENCES `customers(customer_id)`
- `fk_product_id` → REFERENCES `products(product_id)`
- `fk_category_id` → REFERENCES `categories(category_id)`
- `fk_supplier_id` → REFERENCES `suppliers(supplier_id)`
- `fk_region_id` → REFERENCES `regions(region_id)`
- `fk_payment_method_id` → REFERENCES `payment_methods(payment_method_id)`

### 3.3 Denormalized Attributes (30-40 fields)
**Customer Related (8-10 attributes)**
- customer_first_name
- customer_last_name
- customer_email
- customer_phone
- customer_address
- customer_city
- customer_state
- customer_zip_code
- customer_country
- customer_registration_date

**Product Related (8-10 attributes)**
- product_name
- product_sku
- product_category_name
- product_unit_price
- product_stock_quantity
- product_description
- product_weight
- product_dimensions
- product_color
- product_supplier_name

**Order Related (8-10 attributes)**
- order_date
- order_total_amount
- order_tax_amount
- order_shipping_cost
- order_discount_amount
- order_status
- order_payment_method
- order_shipping_address
- order_notes
- order_priority_level

**Additional Business Logic (6-8 attributes)**
- delivery_date
- estimated_delivery_date
- actual_delivery_date
- return_status
- return_reason
- loyalty_points_earned
- is_bulk_order
- campaign_source

**Audit/System Fields (2-4 attributes)**
- created_at
- updated_at
- created_by
- last_modified_by

---

## 4. Implementation Steps

### Step 1: Create Lookup/Parent Tables
```sql
CREATE TABLE customers (...)
CREATE TABLE products (...)
CREATE TABLE categories (...)
CREATE TABLE suppliers (...)
CREATE TABLE regions (...)
CREATE TABLE payment_methods (...)
```

### Step 2: Create Denormalized Main Table
```sql
CREATE TABLE denormalized_orders (
    primary_id INT PRIMARY KEY AUTO_INCREMENT,
    -- Foreign Keys
    fk_customer_id INT NOT NULL,
    fk_product_id INT NOT NULL,
    fk_category_id INT NOT NULL,
    fk_supplier_id INT NOT NULL,
    fk_region_id INT NOT NULL,
    fk_payment_method_id INT NOT NULL,
    
    -- Denormalized Customer Attributes
    customer_first_name VARCHAR(100),
    customer_last_name VARCHAR(100),
    customer_email VARCHAR(100),
    customer_phone VARCHAR(20),
    customer_address VARCHAR(255),
    customer_city VARCHAR(100),
    customer_state VARCHAR(50),
    customer_zip_code VARCHAR(10),
    customer_country VARCHAR(100),
    customer_registration_date DATE,
    
    -- Denormalized Product Attributes
    product_name VARCHAR(255),
    product_sku VARCHAR(50),
    product_category_name VARCHAR(100),
    product_unit_price DECIMAL(10, 2),
    product_stock_quantity INT,
    product_description TEXT,
    product_weight DECIMAL(8, 2),
    product_dimensions VARCHAR(100),
    product_color VARCHAR(50),
    product_supplier_name VARCHAR(100),
    
    -- Order Attributes
    order_date DATE,
    order_total_amount DECIMAL(12, 2),
    order_tax_amount DECIMAL(10, 2),
    order_shipping_cost DECIMAL(10, 2),
    order_discount_amount DECIMAL(10, 2),
    order_status VARCHAR(50),
    order_payment_method VARCHAR(50),
    order_shipping_address VARCHAR(255),
    order_notes TEXT,
    order_priority_level VARCHAR(20),
    
    -- Business Logic Attributes
    delivery_date DATE,
    estimated_delivery_date DATE,
    actual_delivery_date DATE,
    return_status VARCHAR(50),
    return_reason TEXT,
    loyalty_points_earned INT,
    is_bulk_order BOOLEAN,
    campaign_source VARCHAR(100),
    
    -- Audit Fields
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    last_modified_by VARCHAR(100),
    
    -- Foreign Key Constraints
    FOREIGN KEY (fk_customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (fk_product_id) REFERENCES products(product_id),
    FOREIGN KEY (fk_category_id) REFERENCES categories(category_id),
    FOREIGN KEY (fk_supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (fk_region_id) REFERENCES regions(region_id),
    FOREIGN KEY (fk_payment_method_id) REFERENCES payment_methods(payment_method_id)
);
```

### Step 3: Generate Fake Data
- Use Python (Faker library) to generate 1000+ rows of realistic fake data
- Ensure FKs reference valid parent table records
- Maintain data consistency and realistic relationships

### Step 4: Verify Integrity
- Check all FKs are valid
- Verify no orphaned records
- Validate data types and formats
- Test queries and relationships

---

## 5. Why This Is Denormalized

**Normal Form Issues Being Addressed:**
- Combining customer, product, order data into single table
- Storing derived/computed values (order_total_amount pre-calculated)
- Repeating supplier name instead of just FK
- Including category name alongside FK reference
- Storing address data that could be in separate tables

**Benefits:**
- Single table queries (no joins needed for common queries)
- Fast read performance
- Simplified reporting
- Pre-computed aggregations available

**Trade-offs:**
- Data redundancy (customer data repeated per order)
- Update anomalies (changing customer_email in one record only)
- Storage overhead
- Maintenance complexity

---

## 6. Technology & Tools

- **Database:** MySQL
- **Data Generation:** Python (Faker library)
- **Tools Needed:**
  - MySQL Server
  - Python 3.8+
  - Libraries: faker, mysql-connector-python (or SQLAlchemy)

---

## 7. Next Steps

1. **Confirm subject area** (E-commerce, Healthcare, HR, etc.)
2. **Define specific attributes** based on domain
3. **Create SQL DDL** for all tables
4. **Build Python script** to:
   - Create lookup tables
   - Populate with fake data
   - Create denormalized table
   - Generate denormalized fake data with valid FKs
5. **Validate** data integrity and relationships
6. **Export** schema and sample data

---

## 8. Estimated Output Deliverables

- ✅ SQL script for creating all tables (lookup + denormalized)
- ✅ Python script for generating 1000+ rows of fake data
- ✅ SQL script to insert generated data
- ✅ Query examples demonstrating FK relationships
- ✅ Documentation of schema and denormalization rationale

---

**Status:** Awaiting subject area confirmation to proceed with detailed implementation
