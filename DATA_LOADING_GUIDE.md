# Healthcare System - Data Loading Guide

## Overview
This guide explains how to populate the healthcare database with bulk fake data for testing and demonstration purposes.

---

## Generated Files

### 1. **generate_bulk_data.py**
Python script that generates realistic fake healthcare data using the Faker library.

**Configuration:**
- Doctors: 50 records
- Patients: 200 records
- Diagnoses: 20 records
- Medications: 30 records
- Encounters: 500 records
- **Total: 800 records across all tables**

### 2. **healthcare_bulk_data.sql** (Generated Output)
SQL file containing all INSERT statements and the final INSERT...SELECT to populate the denormalized table.

**File Size:** 912 lines
**Encoding:** UTF-8

---

## Prerequisites

### Database Setup
Ensure the healthcare database and all tables are created first:

```bash
mysql -u root -p < healthcare_ddl.sql
```

This creates:
- `healthcare_system` database
- 5 dimension tables (departments, doctors, patients, diagnoses, medications)
- 1 main denormalized table (`denormalized_patient_encounters`)
- 1 normalized encounters table (for INSERT...SELECT approach)

### Python Requirements
```bash
pip install faker
```

---

## Data Generation Process

### Step 1: Generate the SQL File

Run the Python script to generate bulk data:

```bash
python generate_bulk_data.py
```

**Output:** `healthcare_bulk_data.sql`

### Step 2: Load Data into MySQL

**IMPORTANT:** The bulk data file automatically clears existing data to prevent duplicate key errors.

Execute the generated SQL file:

```bash
mysql -u root -p healthcare_system < healthcare_bulk_data.sql
```

Or from within MySQL:

```sql
USE healthcare_system;
SOURCE healthcare_bulk_data.sql;
```

**What happens during load:**
1. ✅ Temporarily disables foreign key checks
2. ✅ Truncates all tables (except departments)
3. ✅ Inserts fresh bulk data (50 doctors, 200 patients, etc.)
4. ✅ Populates denormalized table via INSERT...SELECT
5. ✅ Re-enables foreign key checks

**Data preserved:**
- Departments table (keeps existing 10 records)

**Data replaced:**
- Doctors, Patients, Diagnoses, Medications
- Encounters and Denormalized encounters

### Step 3: Verify Data Loaded

The SQL file includes verification queries at the end. You should see:

```
+----------------------------------+-----------+
| table_name                       | row_count |
+----------------------------------+-----------+
| doctors                          |        50 |
| patients                         |       200 |
| diagnoses                        |        20 |
| medications                      |        30 |
| encounters                       |       500 |
| denormalized_patient_encounters  |       500 |
+----------------------------------+-----------+
```

---

## Data Generation Details

### Doctors (50 records)
- Realistic names using Faker
- Unique license numbers (MD000001 - MD000050)
- 18 different specializations
- Random department assignments
- Hire dates between 2010-2023
- 5-30 years of experience

### Patients (200 records)
- Realistic demographic data
- Birth dates between 1940-2010 (ages 14-84)
- Complete address information
- 8 different insurance providers
- Emergency contact information
- Blood types: A+, A-, B+, B-, AB+, AB-, O+, O-

### Diagnoses (20 records)
- ICD-10 codes (I10, E11, J44.9, etc.)
- Categories: Cardiovascular, Respiratory, Psychiatric, etc.
- Severity levels: Low, Moderate, High, Critical
- Chronic vs. Acute conditions

### Medications (30 records)
- Common medications (Lisinopril, Metformin, Atorvastatin, etc.)
- Generic and brand names
- Various dosage forms (Tablet, Capsule, Injectable, Inhaler)
- NDC codes
- Side effects and contraindications

### Encounters (500 records)
- Encounter dates: 2023-2024
- Encounter times: 08:00 - 18:00
- 10 encounter types (Routine Checkup, Emergency, Surgery, etc.)
- Duration: 15-120 minutes
- Realistic vital signs:
  - Temperature: 97.0-99.5°F
  - Blood pressure: 110-160 / 60-100
  - Heart rate: 60-100 bpm
  - Respiratory rate: 12-20 breaths/min
- Chief complaints, clinical notes, treatment plans
- Billing amounts: $150 - $5,000
- 4 billing statuses: Paid, Pending, Insurance Processing, Outstanding

---

## Data Flow Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                 generate_bulk_data.py                        │
│                 (Python + Faker)                             │
└──────────────────────┬──────────────────────────────────────┘
                       │ Generates
                       ▼
┌─────────────────────────────────────────────────────────────┐
│              healthcare_bulk_data.sql                        │
│              (912 lines of SQL)                              │
└──────────────────────┬──────────────────────────────────────┘
                       │ Loads into
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                   MySQL Database                             │
│         ┌────────────┬────────────┬───────────┐             │
│         │ Dimension  │ Normalized │Denormalized│             │
│         │  Tables    │ Encounters │ Encounters │             │
│         │  (5 tbl)   │  (500 rec) │  (500 rec) │             │
│         └────────────┴────────────┴────────────┘             │
└─────────────────────────────────────────────────────────────┘
```

---

## Denormalization Process

The script creates data in two phases:

### Phase 1: Populate Dimension Tables
1. Insert 50 doctors
2. Insert 200 patients
3. Insert 20 diagnoses
4. Insert 30 medications

### Phase 2: Create Encounters & Denormalize
1. Insert 500 records into normalized `encounters` table with FKs
2. Use INSERT...SELECT with LEFT JOINs to populate `denormalized_patient_encounters`
3. All dimension attributes are denormalized (copied) into the main table

**Result:** Each encounter record contains:
- 5 Foreign Keys (patient, doctor, department, diagnosis, medication)
- 68 total columns with all dimension data denormalized
- Complete patient, doctor, department, diagnosis, and medication details

---

## Customization

### Modify Record Counts

Edit `generate_bulk_data.py`:

```python
NUM_DOCTORS = 50       # Change to desired number
NUM_PATIENTS = 200     # Change to desired number
NUM_ENCOUNTERS = 500   # Change to desired number
```

### Add New Specializations

Edit the `SPECIALIZATIONS` list:

```python
SPECIALIZATIONS = [
    'Cardiology', 'Neurology', 'Orthopedics',
    'Your New Specialty',  # Add here
]
```

### Change Date Ranges

Modify the `random_date()` function calls:

```python
encounter_date = random_date(2023, 2024)  # Change year range
```

---

## Performance Considerations

### Loading Time
- **Small dataset (800 records):** ~5-10 seconds
- **Medium dataset (5,000 records):** ~30-60 seconds
- **Large dataset (50,000+ records):** Consider batch loading

### Optimization Tips
1. **Disable Foreign Key Checks** (for faster loading):
   ```sql
   SET FOREIGN_KEY_CHECKS = 0;
   SOURCE healthcare_bulk_data.sql;
   SET FOREIGN_KEY_CHECKS = 1;
   ```

2. **Increase Buffer Pool** (for large datasets):
   ```sql
   SET GLOBAL innodb_buffer_pool_size = 2147483648; -- 2GB
   ```

3. **Use Batch Inserts**: The script already uses batch INSERT statements

---

## Troubleshooting

### Issue: Duplicate Entry Error (icd_code, medication_name, etc.)
**Error Messages:**
```
Error: Duplicate entry 'I10' for key 'diagnoses.icd_code'
Error: Duplicate entry 'Lisinopril' for key 'medications.medication_name'
```

**Root Cause:** Tables already contain data from previous runs with UNIQUE constraints

**Solution:** ✅ **FIXED** - The script now automatically truncates tables before loading
- Lines 14-43 in `healthcare_bulk_data.sql` handle cleanup
- If you still get this error, ensure you're using the latest version

**Manual Fix (if needed):**
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
**Solution:** Ensure dimension tables are populated before encounters
```sql
-- Check if dimension tables have data
SELECT COUNT(*) FROM doctors;
SELECT COUNT(*) FROM patients;
```

### Issue: Duplicate Key Error (Still Occurring)
**Solution:** The script now handles this automatically with TRUNCATE statements
If issue persists, regenerate the SQL file:
```bash
python generate_bulk_data.py
```

### Issue: Unicode Encoding Error (Python)
**Solution:** Already fixed in script. If issue persists:
```python
with open(output_file, 'w', encoding='utf-8') as f:
```

### Issue: Data Looks Unrealistic
**Solution:** Adjust Faker seed for different data:
```python
Faker.seed(12345)  # Change seed number
random.seed(12345)
```

---

## Next Steps

After loading bulk data:

1. **Run Analysis Queries:**
   ```bash
   mysql -u root -p healthcare_system < healthcare_analysis_queries.sql
   ```

2. **Verify Data Integrity:**
   ```sql
   -- Check for orphaned records
   SELECT COUNT(*) FROM denormalized_patient_encounters
   WHERE fk_patient_id NOT IN (SELECT patient_id FROM patients);
   ```

3. **Test Denormalization Performance:**
   ```sql
   -- Compare query performance
   EXPLAIN SELECT * FROM denormalized_patient_encounters WHERE patient_age > 50;
   ```

4. **Export Sample Data:**
   ```bash
   mysqldump healthcare_system denormalized_patient_encounters > sample_data.sql
   ```

---

## File References

| File | Purpose | Records |
|------|---------|---------|
| `healthcare_ddl.sql` | Create database structure | N/A |
| `healthcare_dml.sql` | Initial 15 sample records | 15 |
| `generate_bulk_data.py` | Bulk data generator | 800 |
| `healthcare_bulk_data.sql` | Generated bulk inserts | 800 |
| `healthcare_insert_select.sql` | Alternative loading approach | 15 |
| `healthcare_analysis_queries.sql` | Analysis queries | N/A |

---

## Contact & Support

For issues or questions:
- Check `healthcare_implementation_guide.sql` for detailed explanations
- Review error logs: `mysql.err`
- Verify MySQL version compatibility (5.7+ recommended)

---

**Generated:** 2024
**Database:** MySQL 5.7+
**Python Version:** 3.8+
**Total Fake Records:** 800+
