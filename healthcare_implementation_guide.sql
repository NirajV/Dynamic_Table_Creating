-- ============================================================================
-- Healthcare Patient Records - IMPLEMENTATION GUIDE
-- Database: healthcare_system
-- ============================================================================

/*
===============================================================================
OVERVIEW
===============================================================================

This guide covers the implementation of a denormalized table structure for
healthcare patient encounters with 68+ attributes demonstrating PK-FK 
relationships and real-world denormalization patterns.

DOMAIN: Healthcare Patient Records
MAIN TABLE: denormalized_patient_encounters
LOOKUP TABLES: patients, doctors, departments, diagnoses, medications

===============================================================================
STEP 1: CREATE THE DATABASE STRUCTURE
===============================================================================

Execute the DDL script (healthcare_ddl.sql) in this order:

1. Create database: healthcare_system
2. Create Dimension Tables:
   - departments (10 records)
   - doctors (12 records)
   - patients (15 records)
   - diagnoses (12 records)
   - medications (12 records)

3. Create Denormalized Main Table:
   - denormalized_patient_encounters (68 columns with 5 FKs)

This takes approximately 5-10 seconds in most MySQL environments.

===============================================================================
STEP 2: POPULATE WITH FAKE DATA
===============================================================================

Execute the DML script (healthcare_dml.sql) in this order:

1. Insert 10 department records
2. Insert 12 doctor records (with FK to departments)
3. Insert 15 patient records
4. Insert 12 diagnosis lookup records
5. Insert 12 medication lookup records
6. Insert 15 denormalized encounter records (with all FKs populated)

This takes approximately 2-5 seconds and creates ~200 rows across all tables.

===============================================================================
STEP 3: VERIFY DATA INTEGRITY
===============================================================================

Run these validation queries to ensure referential integrity:

-- Check for orphaned FK references in denormalized table
SELECT COUNT(*) FROM denormalized_patient_encounters 
WHERE fk_patient_id NOT IN (SELECT patient_id FROM patients);

SELECT COUNT(*) FROM denormalized_patient_encounters 
WHERE fk_doctor_id NOT IN (SELECT doctor_id FROM doctors);

SELECT COUNT(*) FROM denormalized_patient_encounters 
WHERE fk_department_id NOT IN (SELECT department_id FROM departments);

-- Should return 0 for all checks if data is clean

===============================================================================
TABLE DESIGN: PRIMARY KEY & FOREIGN KEY RELATIONSHIPS
===============================================================================

PRIMARY KEY:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Table: denormalized_patient_encounters
Column: encounter_id (INT AUTO_INCREMENT)
Description: Unique identifier for each encounter record
Example Values: 1, 2, 3, ..., 15

FOREIGN KEY RELATIONSHIPS:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. fk_patient_id → patients(patient_id)
   - References the patient involved in the encounter
   - 15 patients in lookup table
   - Required (NOT NULL)

2. fk_doctor_id → doctors(doctor_id)
   - References the treating physician
   - 12 doctors in lookup table
   - Required (NOT NULL)

3. fk_department_id → departments(department_id)
   - References the department where encounter occurred
   - 10 departments in lookup table
   - Required (NOT NULL)

4. fk_diagnosis_id → diagnoses(diagnosis_id)
   - References the primary diagnosis
   - 12 diagnoses in lookup table
   - Optional (NULL allowed)

5. fk_medication_id → medications(medication_id)
   - References prescribed medication
   - 12 medications in lookup table
   - Optional (NULL allowed)

DENORMALIZATION ATTRIBUTES BREAKDOWN:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total Columns: 68
Total Denormalized Columns: 64 (excluding audit fields)

A. PATIENT ATTRIBUTES (18 columns)
   - patient_first_name
   - patient_last_name
   - patient_date_of_birth (FK denormalized)
   - patient_age (computed denormalized)
   - patient_gender
   - patient_blood_type
   - patient_phone
   - patient_email
   - patient_street_address
   - patient_city
   - patient_state
   - patient_postal_code
   - patient_country
   - patient_insurance_provider
   - patient_insurance_policy_number
   - patient_emergency_contact_name
   - patient_emergency_contact_phone
   - patient_registration_date

B. DOCTOR ATTRIBUTES (8 columns)
   - doctor_first_name (FK denormalized)
   - doctor_last_name (FK denormalized)
   - doctor_license_number (FK denormalized)
   - doctor_specialization (FK denormalized)
   - doctor_phone (FK denormalized)
   - doctor_email (FK denormalized)
   - doctor_hire_date (FK denormalized)
   - doctor_years_experience (FK denormalized)

C. DEPARTMENT ATTRIBUTES (5 columns)
   - department_name (FK denormalized)
   - department_code (FK denormalized)
   - department_floor (FK denormalized)
   - department_phone (FK denormalized)
   - department_head (FK denormalized)

D. DIAGNOSIS ATTRIBUTES (6 columns)
   - diagnosis_icd_code (FK denormalized)
   - diagnosis_name (FK denormalized)
   - diagnosis_category (FK denormalized)
   - diagnosis_severity (FK denormalized)
   - diagnosis_description (FK denormalized)
   - is_chronic_diagnosis (FK denormalized)

E. MEDICATION ATTRIBUTES (8 columns)
   - medication_name (FK denormalized)
   - medication_generic_name (FK denormalized)
   - medication_dosage_strength (FK denormalized)
   - medication_dosage_form (FK denormalized)
   - medication_route (FK denormalized)
   - medication_side_effects (FK denormalized)
   - medication_contraindications (FK denormalized)
   - medication_manufacturer (FK denormalized)

F. ENCOUNTER-SPECIFIC ATTRIBUTES (14 columns)
   - encounter_date
   - encounter_time
   - encounter_type
   - encounter_duration_minutes
   - chief_complaint
   - vital_signs_temperature
   - vital_signs_blood_pressure
   - vital_signs_heart_rate
   - vital_signs_respiratory_rate
   - clinical_notes
   - treatment_plan
   - prescribed_quantity
   - prescribed_frequency
   - prescription_duration_days
   - follow_up_date
   - follow_up_required
   - billingBillable_amount
   - billing_status

G. AUDIT/SYSTEM FIELDS (4 columns)
   - created_at (TIMESTAMP DEFAULT CURRENT_TIMESTAMP)
   - updated_at (TIMESTAMP DEFAULT CURRENT_TIMESTAMP)
   - created_by (VARCHAR - User who created record)
   - last_modified_by (VARCHAR - User who last modified record)

===============================================================================
WHY THIS IS DENORMALIZED
===============================================================================

NORMALIZATION VIOLATIONS (By Design):

1. CUSTOMER DATA DUPLICATION
   - Patient information (name, address, contact) is repeated in every encounter
   - Violates 1NF (First Normal Form)
   - Example: Patient "John Anderson" appears once in patients table,
     but his details appear in all his encounters in denormalized table

2. TRANSITIVE DEPENDENCIES
   - Department info stored in encounter table while also having FK to department
   - Example: department_name, department_code, department_head all denormalized
   - Violates 3NF (Third Normal Form)

3. REDUNDANT DERIVED ATTRIBUTES
   - patient_age is computed from patient_date_of_birth
   - Could be calculated on query time
   - Stored for read performance

4. ATTRIBUTE REPETITION
   - Same attributes appear denormalized even though FKs exist
   - doctor_specialization appears as both FK and denormalized value
   - medication_dosage_strength appears as both FK and denormalized value

BENEFITS OF DENORMALIZATION:

✓ QUERY PERFORMANCE
  - Single table queries avoid expensive joins
  - No need to join 5 tables for encounter details
  - Example: SELECT * FROM denormalized_patient_encounters 
    instead of SELECT * FROM encounters e 
    JOIN patients p ON e.fk_patient_id = p.patient_id
    JOIN doctors d ON e.fk_doctor_id = d.doctor_id ...

✓ REPORTING & ANALYTICS
  - Pre-grouped and pre-aggregated data
  - Faster report generation
  - No complex join logic in reports

✓ SIMPLICITY FOR APPLICATIONS
  - Full encounter context in single row
  - Reduces application-level logic
  - Easier to understand data relationships

TRADE-OFFS & RISKS:

✗ DATA REDUNDANCY
  - Storage overhead: ~40-50% more space vs normalized
  - Each patient's info repeated per encounter
  - With 10,000 encounters per patient, massive duplication

✗ UPDATE ANOMALIES
  - If patient changes email, must update ALL encounter records
  - Risk of inconsistency (some records updated, others not)
  - Example: Change patient_email from "john@old.com" to "john@new.com"
    requires UPDATE to potentially 1000s of denormalized records

✗ INSERT ANOMALIES
  - Cannot insert an encounter without all patient details
  - Cannot insert a new patient without an encounter

✗ DELETE ANOMALIES
  - Deleting encounters removes associated patient information
  - May lose data about patients with only deleted encounters

✗ MAINTENANCE COMPLEXITY
  - Triggers needed to keep denormalized columns in sync
  - Additional validation logic required
  - Testing complexity increases

===============================================================================
SAMPLE QUERIES - LEVERAGING DENORMALIZED STRUCTURE
===============================================================================

-- 1. Get all encounters for a specific doctor with patient details
SELECT 
    encounter_id,
    doctor_first_name,
    doctor_last_name,
    patient_first_name,
    patient_last_name,
    encounter_date,
    chief_complaint,
    diagnosis_name
FROM denormalized_patient_encounters
WHERE doctor_first_name = 'James' 
  AND doctor_last_name = 'Mitchell'
ORDER BY encounter_date DESC;

-- 2. Find patients with hypertension requiring billing follow-up
SELECT 
    DISTINCT patient_first_name,
    patient_last_name,
    patient_email,
    COUNT(*) as encounter_count,
    SUM(billingBillable_amount) as total_billed
FROM denormalized_patient_encounters
WHERE diagnosis_name = 'Essential Hypertension'
  AND billing_status = 'Pending'
GROUP BY patient_id, patient_first_name, patient_last_name, patient_email;

-- 3. List encounters with critical diagnoses in ICU monitoring
SELECT 
    encounter_id,
    patient_first_name,
    patient_last_name,
    doctor_specialization,
    encounter_date,
    diagnosis_severity,
    treatment_plan
FROM denormalized_patient_encounters
WHERE diagnosis_severity = 'Critical'
  AND follow_up_required = TRUE;

-- 4. Medication prescription analysis
SELECT 
    medication_name,
    medication_dosage_form,
    COUNT(*) as prescriptions_issued,
    SUM(prescribed_quantity) as total_quantity
FROM denormalized_patient_encounters
WHERE medication_name IS NOT NULL
GROUP BY medication_id, medication_name, medication_dosage_form
ORDER BY prescriptions_issued DESC;

-- 5. Doctor workload analysis
SELECT 
    doctor_first_name,
    doctor_last_name,
    doctor_specialization,
    COUNT(*) as total_encounters,
    AVG(encounter_duration_minutes) as avg_duration,
    SUM(billingBillable_amount) as total_revenue
FROM denormalized_patient_encounters
WHERE created_at >= DATE_SUB(NOW(), INTERVAL 1 MONTH)
GROUP BY doctor_id, doctor_first_name, doctor_last_name, doctor_specialization
ORDER BY total_encounters DESC;

-- 6. Patient comorbidity pattern (patients with multiple chronic conditions)
SELECT 
    DISTINCT e1.patient_id,
    e1.patient_first_name,
    e1.patient_last_name,
    GROUP_CONCAT(DISTINCT e1.diagnosis_name ORDER BY e1.diagnosis_name) as diagnoses,
    COUNT(DISTINCT e1.fk_diagnosis_id) as condition_count
FROM denormalized_patient_encounters e1
WHERE e1.is_chronic_diagnosis = TRUE
GROUP BY e1.patient_id, e1.patient_first_name, e1.patient_last_name
HAVING condition_count >= 2;

-- 7. Encounter timeline for specific patient
SELECT 
    encounter_id,
    encounter_date,
    encounter_type,
    department_name,
    doctor_specialization,
    chief_complaint,
    diagnosis_name,
    treatment_plan
FROM denormalized_patient_encounters
WHERE patient_first_name = 'Michael'
  AND patient_last_name = 'Garcia'
ORDER BY encounter_date ASC;

-- 8. Medication side effect risk assessment
SELECT 
    medication_name,
    medication_generic_name,
    patient_age,
    medication_side_effects,
    medication_contraindications,
    patient_gender,
    encounter_date
FROM denormalized_patient_encounters
WHERE medication_name IN ('Ciprofloxacin', 'Ibuprofen')
  AND patient_age > 60;

-- 9. Department efficiency metrics
SELECT 
    department_name,
    department_head,
    COUNT(*) as total_encounters,
    COUNT(DISTINCT fk_patient_id) as unique_patients,
    COUNT(CASE WHEN billing_status = 'Paid' THEN 1 END) as paid_encounters,
    SUM(billingBillable_amount) as total_revenue
FROM denormalized_patient_encounters
WHERE encounter_date >= DATE_SUB(NOW(), INTERVAL 3 MONTH)
GROUP BY department_id, department_name, department_head
ORDER BY total_revenue DESC;

-- 10. Follow-up required tracking
SELECT 
    encounter_id,
    patient_first_name,
    patient_last_name,
    doctor_first_name,
    doctor_last_name,
    follow_up_date,
    DATEDIFF(CURDATE(), follow_up_date) as days_overdue,
    patient_email,
    patient_phone
FROM denormalized_patient_encounters
WHERE follow_up_required = TRUE
  AND follow_up_date < CURDATE()
ORDER BY days_overdue DESC;

===============================================================================
DATA CONSISTENCY & INTEGRITY MAINTENANCE
===============================================================================

CHALLENGES WITH DENORMALIZED STRUCTURE:

1. Keeping denormalized columns in sync with source data

SOLUTION APPROACHES:

A. TRIGGER-BASED APPROACH (Real-time Consistency)
   - Create UPDATE/DELETE triggers on source tables
   - Automatically update denormalized columns
   - Pros: Immediate consistency
   - Cons: Performance impact, trigger complexity

   Example Trigger:
   CREATE TRIGGER update_patient_email_on_denormalized
   AFTER UPDATE ON patients
   FOR EACH ROW
   UPDATE denormalized_patient_encounters
   SET patient_email = NEW.email
   WHERE fk_patient_id = NEW.patient_id;

B. BATCH REFRESH APPROACH (Scheduled Updates)
   - Run periodic SQL scripts to update denormalized data
   - Can be scheduled via cron job or scheduled task
   - Pros: Simpler logic, less impact on day-to-day queries
   - Cons: Temporary inconsistencies, requires scheduling

   Example Update Script:
   UPDATE denormalized_patient_encounters de
   JOIN patients p ON de.fk_patient_id = p.patient_id
   SET de.patient_email = p.email,
       de.patient_phone = p.phone_number
   WHERE de.fk_patient_id = p.patient_id;

C. APPLICATION-LEVEL CONSISTENCY
   - Application code handles updates to both tables
   - Requires transactional integrity
   - Pros: Business logic control
   - Cons: Error-prone, duplicate code

===============================================================================
PERFORMANCE CHARACTERISTICS
===============================================================================

Current Data Scale:
- 15 encounters in denormalized table
- 15 patients, 12 doctors, 10 departments, 12 diagnoses, 12 medications

Query Performance Comparison:

NORMALIZED APPROACH (5 JOINs):
SELECT p.first_name, p.last_name, d.first_name, d.last_name, 
       dep.department_name, dia.diagnosis_name, m.medication_name
FROM encounters e
JOIN patients p ON e.fk_patient_id = p.patient_id
JOIN doctors d ON e.fk_doctor_id = d.doctor_id
JOIN departments dep ON e.fk_department_id = dep.department_id
JOIN diagnoses dia ON e.fk_diagnosis_id = dia.diagnosis_id
JOIN medications m ON e.fk_medication_id = m.medication_id
WHERE e.encounter_date >= '2024-02-01'
  AND d.specialization = 'Cardiology';

Expected Execution Time: 2-5ms (with proper indexes)

DENORMALIZED APPROACH (0 JOINs):
SELECT patient_first_name, patient_last_name,
       doctor_first_name, doctor_last_name,
       department_name, diagnosis_name, medication_name
FROM denormalized_patient_encounters
WHERE encounter_date >= '2024-02-01'
  AND doctor_specialization = 'Cardiology';

Expected Execution Time: <1ms (direct table scan)

PERFORMANCE GAIN: 70-80% faster for this query pattern

WHEN DENORMALIZATION HELPS:
✓ Heavy reporting/analytics workloads
✓ Read-heavy applications (80%+ reads)
✓ Complex queries with many joins
✓ Real-time dashboard requirements

WHEN DENORMALIZATION HURTS:
✗ Write-heavy applications
✗ Complex update scenarios
✗ Multiple denormalized copies needed
✗ Storage constraints critical

===============================================================================
INDEXES FOR OPTIMAL PERFORMANCE
===============================================================================

Current Indexes on denormalized_patient_encounters:
- PK: encounter_id (PRIMARY KEY)
- FK Indexes: fk_patient_id, fk_doctor_id, fk_department_id
- Query Indexes: encounter_date, encounter_type, billing_status

Additional Recommended Indexes:

-- For common filter combinations
CREATE INDEX idx_patient_encounter_date 
  ON denormalized_patient_encounters(fk_patient_id, encounter_date);

CREATE INDEX idx_doctor_specialization_date 
  ON denormalized_patient_encounters(doctor_specialization, encounter_date);

CREATE INDEX idx_diagnosis_severity 
  ON denormalized_patient_encounters(diagnosis_severity);

CREATE INDEX idx_follow_up_required 
  ON denormalized_patient_encounters(follow_up_required, follow_up_date);

===============================================================================
REAL-WORLD USE CASES
===============================================================================

1. PATIENT PORTAL
   - Patient logs in, sees all their encounter details
   - Uses denormalized table for single quick lookup
   - No need for application-level join logic

2. BILLING DEPARTMENT
   - Generates invoices and billing reports
   - Needs patient, doctor, service, and medication in one place
   - Denormalized structure perfect fit

3. CLINICAL ANALYTICS
   - Reports on patterns across specializations
   - Tracks medication prescriptions by doctor
   - Denormalized allows fast aggregations

4. HOSPITAL DASHBOARD
   - Real-time metrics on department performance
   - Workload visualization for doctors
   - Cash flow analysis (billing amounts)

===============================================================================
MIGRATION STRATEGY (NORMALIZED → DENORMALIZED)
===============================================================================

If you have existing normalized data:

1. BACKUP
   CREATE TABLE denormalized_patient_encounters_backup
   AS SELECT * FROM denormalized_patient_encounters;

2. POPULATE FROM NORMALIZED TABLES
   INSERT INTO denormalized_patient_encounters (...)
   SELECT 
       e.encounter_id,
       e.fk_patient_id, e.fk_doctor_id, e.fk_department_id,
       p.first_name, p.last_name, p.date_of_birth,
       YEAR(CURDATE()) - YEAR(p.date_of_birth) as age,
       ... [all other fields from JOINs]
   FROM encounters e
   JOIN patients p ON e.fk_patient_id = p.patient_id
   JOIN doctors d ON e.fk_doctor_id = d.doctor_id
   ... [continue joins];

3. VALIDATE
   SELECT COUNT(*) FROM normalized_encounters;
   SELECT COUNT(*) FROM denormalized_patient_encounters;
   -- Should match

4. CUTOVER
   - Update application to read from denormalized table
   - Set up triggers/batch updates for consistency
   - Monitor and optimize

===============================================================================
CONCLUSION
===============================================================================

This denormalized patient encounter table demonstrates:

✓ PK (encounter_id) and 5 FK relationships (patient, doctor, dept, diagnosis, med)
✓ 68 total columns covering healthcare domain
✓ Real-world denormalization patterns
✓ Performance benefits for read-heavy workloads
✓ Data consistency trade-offs and solutions

Best for: Healthcare reporting, analytics, patient portals
Not ideal for: Real-time transactional systems with frequent updates

For production use, consider:
- Trigger-based consistency
- Regular monitoring of data accuracy
- Backup and recovery procedures
- Performance tuning of indexes

===============================================================================
*/

-- Quick validation after loading:
SELECT 
    'denormalized_patient_encounters' as table_name,
    COUNT(*) as row_count,
    COUNT(DISTINCT fk_patient_id) as unique_patients,
    COUNT(DISTINCT fk_doctor_id) as unique_doctors,
    COUNT(DISTINCT fk_department_id) as unique_departments,
    MIN(encounter_date) as earliest_encounter,
    MAX(encounter_date) as latest_encounter
FROM denormalized_patient_encounters;
