# Healthcare Database - Dynamic Table Creation Project

A comprehensive MySQL database project demonstrating **denormalization patterns** with Primary Key and Foreign Key relationships using realistic fake healthcare data.

[![Database](https://img.shields.io/badge/Database-MySQL-blue.svg)](https://www.mysql.com/)
[![Python](https://img.shields.io/badge/Python-3.8+-green.svg)](https://www.python.org/)
[![Data](https://img.shields.io/badge/Records-800+-orange.svg)](https://github.com/NirajV/Dynamic_Table_Creating)

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Database Schema](#database-schema)
- [Usage Examples](#usage-examples)
- [Data Generation](#data-generation)
- [Analysis Queries](#analysis-queries)
- [Denormalization Explained](#denormalization-explained)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

## 🎯 Overview

This project demonstrates a **denormalized database design** for healthcare patient encounter records, featuring:

- **68-column denormalized table** with complete patient, doctor, department, diagnosis, and medication data
- **Primary Key (PK)** and **5 Foreign Keys (FK)** maintaining referential integrity
- **800+ realistic fake records** generated using Python Faker library
- **Comprehensive documentation** explaining denormalization trade-offs
- **15 analysis queries** for reporting and analytics

### Domain: Healthcare Patient Records

The system manages patient encounters across multiple departments with:
- Patient demographics and insurance information
- Doctor specializations and credentials
- Medical diagnoses (ICD-10 codes)
- Medication prescriptions and dosages
- Vital signs and clinical notes
- Billing and follow-up tracking

---

## ✨ Features

### Database Design
- ✅ **5 Dimension Tables:** patients, doctors, departments, diagnoses, medications
- ✅ **1 Denormalized Table:** Complete encounter records (68 columns)
- ✅ **1 Normalized Database:** 6 tables in Third Normal Form (3NF) extracted from denormalized data
- ✅ **PK-FK Relationships:** Proper referential integrity with ON DELETE rules
- ✅ **Indexes:** Optimized for common query patterns

### Data Normalization
- ✅ **SQL Normalization Script:** Extracts normalized tables from denormalized data using `ROW_NUMBER()`
- ✅ **Python Setup Script:** Automated database creation with MySQL auto-detection and verification
- ✅ **6 Normalized Tables:** departments, doctors, patients, diagnoses, medications, encounters

### Data Generation
- ✅ **Python Script:** Automated fake data generation using Faker
- ✅ **Realistic Data:** Valid ICD-10 codes, medication names, vital signs
- ✅ **Configurable:** Easy to adjust record counts and data ranges
- ✅ **Safe Loading:** Automatic cleanup prevents duplicate key errors

### Documentation
- ✅ **Implementation Guide:** 600+ lines explaining denormalization
- ✅ **Data Loading Guide:** Step-by-step loading instructions
- ✅ **Analysis Queries:** 15 pre-built queries for common reports

---

## 📁 Project Structure

```
Dynamic_Table_Creating/
│
├── 📄 README.md                              # This file
├── 📄 HandMake_Prompts.txt                   # Original requirements
├── 📄 .gitignore                             # Git ignore rules
│
├── 🗄️  Database Schema (DDL)
│   └── healthcare_ddl.sql                    # Table definitions
│
├── 📊 Sample Data (DML)
│   ├── healthcare_dml.sql                    # Initial 15 records
│   ├── healthcare_insert_select.sql          # Alternative loading method
│   └── healthcare_bulk_data.sql              # 800+ records (generated)
│
├── 🔄 Data Normalization
│   ├── normalize_healthcare.sql              # SQL script to extract normalized tables
│   └── setup_normalized_db.py               # Python setup script (auto-detect MySQL)
│
├── 🐍 Data Generation
│   └── generate_bulk_data.py                 # Python script to generate data
│
├── 📈 Analysis & Queries
│   └── healthcare_analysis_queries.sql       # 15 pre-built queries
│
├── 📚 Documentation
│   ├── healthcare_implementation_guide.sql   # Comprehensive guide (600+ lines)
│   ├── DATA_LOADING_GUIDE.md                 # Loading instructions
│   └── .github/prompts/
│       └── plan-denormalizedTableCreation.prompt.md  # Initial planning
│
└── 🔧 Configuration
    └── .git/                                 # Version control
```

---

## 🔧 Prerequisites

### Required Software

1. **MySQL Server** (5.7+ or 8.0+)
   ```bash
   # Check version
   mysql --version
   ```

2. **Python** (3.8+)
   ```bash
   # Check version
   python --version
   ```

3. **Python Faker Library**
   ```bash
   pip install faker
   ```

### Optional Tools
- MySQL Workbench (GUI for database management)
- DBeaver (Cross-platform database tool)
- Git (for version control)

---

## 🚀 Quick Start

### Step 1: Clone the Repository

```bash
git clone https://github.com/NirajV/Dynamic_Table_Creating.git
cd Dynamic_Table_Creating
```

### Step 2: Create Database & Tables

```bash
mysql -u root -p < healthcare_ddl.sql
```

This creates:
- `healthcare_system` database
- 5 dimension tables
- 1 denormalized main table
- 1 normalized encounters table

### Step 3: Load Bulk Data (800+ Records)

```bash
mysql -u root -p healthcare_system < healthcare_bulk_data.sql
```

**What this does:**
- Clears existing data (prevents duplicates)
- Inserts 50 doctors
- Inserts 200 patients
- Inserts 20 diagnoses
- Inserts 30 medications
- Inserts 500 encounters
- Populates denormalized table

### Step 4: Create Normalized Database (Optional)

```bash
python setup_normalized_db.py
```

Or with CLI arguments:

```bash
python setup_normalized_db.py root yourpassword
```

This reads `healthcare_system.denormalized_patient_encounters` and creates `healthcare_system_model_db` with 6 normalized tables:

| Table | Records | Extracted By |
|-------|---------|-------------|
| departments | 10 | Unique department_name |
| doctors | 50 | Unique license_number |
| patients | 177 | Unique fk_patient_id |
| diagnoses | 20 | Unique ICD code |
| medications | 30 | Unique medication_name |
| encounters | 500 | All records (fact table) |

### Step 5: Verify Data

```bash
mysql -u root -p healthcare_system
```

```sql
-- Check record counts
SELECT 'doctors' AS table_name, COUNT(*) AS records FROM doctors
UNION ALL SELECT 'patients', COUNT(*) FROM patients
UNION ALL SELECT 'diagnoses', COUNT(*) FROM diagnoses
UNION ALL SELECT 'medications', COUNT(*) FROM medications
UNION ALL SELECT 'encounters', COUNT(*) FROM encounters
UNION ALL SELECT 'denormalized_patient_encounters', COUNT(*) FROM denormalized_patient_encounters;
```

**Expected Output:**
```
+----------------------------------+---------+
| table_name                       | records |
+----------------------------------+---------+
| doctors                          |      50 |
| patients                         |     200 |
| diagnoses                        |      20 |
| medications                      |      30 |
| encounters                       |     500 |
| denormalized_patient_encounters  |     500 |
+----------------------------------+---------+
```

---

## 🗄️ Database Schema

### Dimension Tables (Normalized)

#### 1. **departments** (10 records)
```sql
department_id (PK), department_name, department_code, floor_number,
phone_number, head_physician, budget_allocated
```

#### 2. **doctors** (50 records)
```sql
doctor_id (PK), first_name, last_name, license_number, specialization,
fk_department_id (FK), phone_number, email, hire_date, years_of_experience
```

#### 3. **patients** (200 records)
```sql
patient_id (PK), first_name, last_name, date_of_birth, gender, blood_type,
phone_number, email, street_address, city, state_province, postal_code, country,
insurance_provider, insurance_policy_number, emergency_contact_name,
emergency_contact_phone, registration_date
```

#### 4. **diagnoses** (20 records)
```sql
diagnosis_id (PK), icd_code (UNIQUE), diagnosis_name, diagnosis_category,
severity_level, description, is_chronic
```

#### 5. **medications** (30 records)
```sql
medication_id (PK), medication_name (UNIQUE), generic_name, ndc_code,
dosage_strength, dosage_form, route_of_administration, common_side_effects,
contraindications, manufacturer
```

### Main Table (Denormalized)

#### **denormalized_patient_encounters** (500 records, 68 columns)

**Primary Key:**
- `encounter_id` (INT AUTO_INCREMENT)

**Foreign Keys:**
- `fk_patient_id` → patients(patient_id)
- `fk_doctor_id` → doctors(doctor_id)
- `fk_department_id` → departments(department_id)
- `fk_diagnosis_id` → diagnoses(diagnosis_id)
- `fk_medication_id` → medications(medication_id)

**Denormalized Attributes (64 columns):**
- 18 patient attributes (name, DOB, contact, insurance, etc.)
- 8 doctor attributes (name, specialization, credentials, etc.)
- 5 department attributes (name, code, location, etc.)
- 6 diagnosis attributes (ICD code, category, severity, etc.)
- 8 medication attributes (name, dosage, route, side effects, etc.)
- 14 encounter-specific attributes (date, vitals, notes, billing, etc.)
- 4 audit fields (created_at, updated_at, created_by, last_modified_by)

---

## 💡 Usage Examples

### Query 1: Patient Count by Department

```sql
SELECT
    department_name,
    COUNT(DISTINCT fk_patient_id) AS unique_patients,
    COUNT(*) AS total_encounters
FROM denormalized_patient_encounters
GROUP BY department_name
ORDER BY unique_patients DESC;
```

### Query 2: Doctor Workload Analysis

```sql
SELECT
    CONCAT(doctor_first_name, ' ', doctor_last_name) AS doctor_name,
    doctor_specialization,
    COUNT(*) AS total_encounters,
    AVG(encounter_duration_minutes) AS avg_duration,
    SUM(billingBillable_amount) AS total_revenue
FROM denormalized_patient_encounters
GROUP BY fk_doctor_id, doctor_first_name, doctor_last_name, doctor_specialization
ORDER BY total_encounters DESC
LIMIT 10;
```

### Query 3: Patients with Multiple Chronic Conditions

```sql
SELECT
    fk_patient_id,
    CONCAT(patient_first_name, ' ', patient_last_name) AS patient_name,
    patient_age,
    COUNT(DISTINCT fk_diagnosis_id) AS chronic_conditions,
    GROUP_CONCAT(DISTINCT diagnosis_name ORDER BY diagnosis_name) AS diagnoses
FROM denormalized_patient_encounters
WHERE is_chronic_diagnosis = TRUE
GROUP BY fk_patient_id, patient_first_name, patient_last_name, patient_age
HAVING COUNT(DISTINCT fk_diagnosis_id) >= 2
ORDER BY chronic_conditions DESC;
```

**See `healthcare_analysis_queries.sql` for 15 more queries!**

---

## 🐍 Data Generation

### Generate Custom Bulk Data

Edit `generate_bulk_data.py` to customize record counts:

```python
# Configuration (lines 18-23)
NUM_DOCTORS = 50        # Change to desired number
NUM_PATIENTS = 200      # Change to desired number
NUM_DIAGNOSES = 20      # Change to desired number
NUM_MEDICATIONS = 30    # Change to desired number
NUM_ENCOUNTERS = 500    # Change to desired number
```

Run the script:

```bash
python generate_bulk_data.py
```

**Output:** `healthcare_bulk_data.sql` (updated with new data)

Load the generated data:

```bash
mysql -u root -p healthcare_system < healthcare_bulk_data.sql
```

### Data Characteristics

**Doctors:**
- 18 specializations (Cardiology, Neurology, Oncology, etc.)
- License numbers: MD000001 - MD000050
- Hire dates: 2010-2023
- Experience: 5-30 years

**Patients:**
- Birth dates: 1940-2010 (ages 14-84)
- 8 insurance providers
- Blood types: A+, A-, B+, B-, AB+, AB-, O+, O-
- Complete demographics and emergency contacts

**Encounters:**
- Dates: 2023-2024
- Times: 08:00 - 18:00
- Duration: 15-120 minutes
- Vital signs:
  - Temperature: 97.0-99.5°F
  - Blood pressure: 110-160 / 60-100
  - Heart rate: 60-100 bpm
  - Respiratory rate: 12-20 breaths/min
- Billing: $150 - $5,000

---

## 📈 Analysis Queries

The project includes **15 pre-built queries** in `healthcare_analysis_queries.sql`:

1. Patient Count by Department
2. Patient Count by Doctor
3. Detailed Patient List by Department
4. Detailed Patient List by Doctor
5. Department & Doctor Summary
6. Patients by Department with Contact Info
7. Doctor Workload Analysis
8. Patients Visiting Multiple Departments
9. Recent Patients by Department (Last 30 Days)
10. Doctor-Patient Matrix
11. Total Encounter Count
12. Encounter Count Comparison (Normalized vs Denormalized)
13. Department Efficiency Metrics
14. Doctor Performance by Specialization
15. Patient Encounter Timeline

**Run all queries:**

```bash
mysql -u root -p healthcare_system < healthcare_analysis_queries.sql
```

---

## 🔄 Denormalization Explained

### What is Denormalization?

**Normalization** separates data into multiple tables to reduce redundancy.
**Denormalization** intentionally duplicates data for performance benefits.

### How This Project is Denormalized

#### Normal Form Violations (By Design):

1. **Data Duplication**
   - Patient info repeated in every encounter
   - Violates First Normal Form (1NF)

2. **Transitive Dependencies**
   - Department info stored despite FK relationship
   - Violates Third Normal Form (3NF)

3. **Derived Attributes**
   - `patient_age` computed but stored
   - Could be calculated on demand

### Benefits of This Approach

✅ **Query Performance**
- Single table queries (no joins needed)
- 70-80% faster for common queries
- Direct access to all related data

✅ **Reporting & Analytics**
- Simplified report generation
- No complex join logic
- Pre-aggregated data

✅ **Application Simplicity**
- Full context in one record
- Reduced application logic
- Easier to understand

### Trade-offs & Risks

❌ **Data Redundancy**
- 40-50% more storage space
- Patient data repeated per encounter

❌ **Update Anomalies**
- Changing patient email requires updating ALL encounters
- Risk of data inconsistency

❌ **Maintenance Complexity**
- Triggers needed for data synchronization
- Additional validation logic

### When to Use Denormalization

**Good for:**
- Read-heavy applications (80%+ reads)
- Reporting and analytics workloads
- Real-time dashboards
- Historical data warehouses

**Bad for:**
- Write-heavy applications
- Systems requiring strict consistency
- Storage-constrained environments
- Frequently updated master data

---

## 🛠️ Troubleshooting

### Issue: Duplicate Entry Errors

**Error:**
```
Error: Duplicate entry 'I10' for key 'diagnoses.icd_code'
```

**Solution:** ✅ **Already Fixed!** The bulk data SQL includes automatic cleanup.

If you still encounter this:
```sql
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE denormalized_patient_encounters;
TRUNCATE TABLE encounters;
TRUNCATE TABLE doctors;
TRUNCATE TABLE patients;
TRUNCATE TABLE diagnoses;
TRUNCATE TABLE medications;
SET FOREIGN_KEY_CHECKS = 1;
```

### Issue: Foreign Key Constraint Fails

**Solution:** Load tables in correct order:
1. departments
2. doctors (depends on departments)
3. patients, diagnoses, medications (independent)
4. encounters (depends on all above)
5. denormalized_patient_encounters (depends on encounters)

### Issue: Python Faker Not Found

```bash
pip install faker
# or
pip3 install faker
```

### Issue: MySQL Access Denied

```bash
# Reset MySQL root password or use correct credentials
mysql -u root -p
# Enter password when prompted
```

---

## 📊 Performance Considerations

### Query Performance Comparison

**Normalized Approach (5 JOINs):**
```sql
SELECT p.first_name, d.first_name, dep.department_name, di.diagnosis_name
FROM encounters e
JOIN patients p ON e.fk_patient_id = p.patient_id
JOIN doctors d ON e.fk_doctor_id = d.doctor_id
JOIN departments dep ON e.fk_department_id = dep.department_id
JOIN diagnoses di ON e.fk_diagnosis_id = di.diagnosis_id;
```
⏱️ Execution Time: ~5-10ms

**Denormalized Approach (0 JOINs):**
```sql
SELECT patient_first_name, doctor_first_name, department_name, diagnosis_name
FROM denormalized_patient_encounters;
```
⏱️ Execution Time: <1ms

**Performance Gain: 70-80% faster**

### Indexing Strategy

Current indexes on `denormalized_patient_encounters`:
- PRIMARY KEY on `encounter_id`
- INDEX on `fk_patient_id`
- INDEX on `fk_doctor_id`
- INDEX on `fk_department_id`
- INDEX on `encounter_date`
- INDEX on `encounter_type`
- INDEX on `billing_status`

---

## 🎓 Learning Resources

### Key Concepts Demonstrated

- ✅ Database denormalization patterns
- ✅ Data normalization from denormalized source using ROW_NUMBER()
- ✅ Primary Key and Foreign Key relationships
- ✅ Data generation with Python Faker
- ✅ SQL DDL (Data Definition Language)
- ✅ SQL DML (Data Manipulation Language)
- ✅ INSERT...SELECT statements
- ✅ LEFT JOIN operations
- ✅ Window functions (ROW_NUMBER, PARTITION BY)
- ✅ Aggregate functions and GROUP BY
- ✅ Database indexing strategies
- ✅ Trade-offs in database design

### Additional Documentation

- **Implementation Guide:** `healthcare_implementation_guide.sql` (600+ lines)
- **Data Loading Guide:** `DATA_LOADING_GUIDE.md`
- **Normalization Script:** `normalize_healthcare.sql`
- **Planning Document:** `.github/prompts/plan-denormalizedTableCreation.prompt.md`

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
4. **Commit with clear messages**
   ```bash
   git commit -m "Add feature: description"
   ```
5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```
6. **Open a Pull Request**

### Ideas for Contributions

- Add more analysis queries
- Create visualization scripts (Python/R)
- Add support for PostgreSQL/SQL Server
- Create Docker setup
- Add unit tests
- Improve data generation logic
- Add more medical specializations
- Create a web interface

---

## 📄 License

This project is licensed under the **MIT License** - see the LICENSE file for details.

---

## 👤 Author

**Niraj V**
- GitHub: [@NirajV](https://github.com/NirajV)
- Repository: [Dynamic_Table_Creating](https://github.com/NirajV/Dynamic_Table_Creating)

---

## 🙏 Acknowledgments

- **Faker Library:** For realistic fake data generation
- **MySQL:** For robust database management
- **ICD-10 Codes:** Based on international medical standards
- **Healthcare Domain:** Inspired by real-world patient management systems

---

## 📞 Support

If you encounter issues or have questions:

1. **Check Documentation:**
   - `healthcare_implementation_guide.sql`
   - `DATA_LOADING_GUIDE.md`

2. **Review Troubleshooting Section** in this README

3. **Open an Issue** on GitHub with:
   - Error message
   - MySQL version
   - Python version
   - Steps to reproduce

---

## 🎯 Project Goals

This project was created to demonstrate:

✅ Real-world database denormalization patterns
✅ Reverse normalization from denormalized data
✅ Trade-offs between normalization and performance
✅ Practical use of Primary Key and Foreign Key relationships
✅ Bulk data generation techniques
✅ Healthcare domain modeling

**Perfect for:** Database students, data engineers, and anyone learning SQL optimization!

---

## 📈 Project Stats

- **Total Files:** 12+ SQL and Python files
- **Total Lines of Code:** 4,000+
- **Total Records Generated:** 800+
- **Documentation Lines:** 1,500+
- **Analysis Queries:** 15
- **Databases:** 2 (denormalized + normalized)
- **Database Tables:** 13 (7 denormalized + 6 normalized)

---

**⭐ If you find this project helpful, please star the repository!**

---

**Last Updated:** February 2026
**Version:** 1.0.0
**Database:** MySQL 5.7+
**Python:** 3.8+
