-- ============================================================================
-- Healthcare Patient Records - ANALYSIS QUERIES
-- Database: healthcare_system
-- Table: denormalized_patient_encounters
-- Purpose: Patient analysis by Department and Doctor
-- ============================================================================

USE healthcare_system;

-- ============================================================================
-- 1. PATIENT COUNT BY DEPARTMENT
-- ============================================================================
-- Total unique patients per department

SELECT
    department_name,
    department_code,
    COUNT(DISTINCT fk_patient_id) AS unique_patients,
    COUNT(*) AS total_encounters
FROM denormalized_patient_encounters
GROUP BY fk_department_id, department_name, department_code
ORDER BY unique_patients DESC;

-- ============================================================================
-- 2. PATIENT COUNT BY DOCTOR
-- ============================================================================
-- Total unique patients per doctor with encounter statistics

SELECT
    CONCAT(doctor_first_name, ' ', doctor_last_name) AS doctor_name,
    doctor_specialization,
    COUNT(DISTINCT fk_patient_id) AS unique_patients,
    COUNT(*) AS total_encounters,
    AVG(encounter_duration_minutes) AS avg_encounter_duration
FROM denormalized_patient_encounters
GROUP BY fk_doctor_id, doctor_first_name, doctor_last_name, doctor_specialization
ORDER BY unique_patients DESC;

-- ============================================================================
-- 3. DETAILED PATIENT LIST BY DEPARTMENT
-- ============================================================================
-- List all patients with their encounters by department

SELECT
    department_name,
    CONCAT(patient_first_name, ' ', patient_last_name) AS patient_name,
    patient_age,
    patient_gender,
    encounter_date,
    encounter_type,
    diagnosis_name,
    billing_status
FROM denormalized_patient_encounters
ORDER BY department_name, encounter_date DESC;

-- ============================================================================
-- 4. DETAILED PATIENT LIST BY DOCTOR
-- ============================================================================
-- List all patients treated by each doctor

SELECT
    CONCAT(doctor_first_name, ' ', doctor_last_name) AS doctor_name,
    doctor_specialization,
    CONCAT(patient_first_name, ' ', patient_last_name) AS patient_name,
    patient_age,
    patient_blood_type,
    encounter_date,
    chief_complaint,
    diagnosis_name,
    medication_name
FROM denormalized_patient_encounters
ORDER BY doctor_last_name, doctor_first_name, encounter_date DESC;

-- ============================================================================
-- 5. DEPARTMENT & DOCTOR SUMMARY
-- ============================================================================
-- Combined department and doctor statistics

SELECT
    department_name,
    CONCAT(doctor_first_name, ' ', doctor_last_name) AS doctor_name,
    doctor_specialization,
    COUNT(DISTINCT fk_patient_id) AS unique_patients,
    COUNT(*) AS total_encounters,
    SUM(billingBillable_amount) AS total_revenue,
    AVG(encounter_duration_minutes) AS avg_duration
FROM denormalized_patient_encounters
GROUP BY
    fk_department_id, department_name,
    fk_doctor_id, doctor_first_name, doctor_last_name, doctor_specialization
ORDER BY department_name, unique_patients DESC;

-- ============================================================================
-- 6. PATIENTS BY DEPARTMENT WITH CONTACT INFO
-- ============================================================================
-- Unique patients per department with contact details

SELECT DISTINCT
    department_name,
    fk_patient_id,
    CONCAT(patient_first_name, ' ', patient_last_name) AS patient_name,
    patient_email,
    patient_phone,
    patient_insurance_provider,
    MIN(encounter_date) AS first_visit,
    MAX(encounter_date) AS last_visit,
    COUNT(*) OVER (PARTITION BY fk_patient_id, fk_department_id) AS visit_count
FROM denormalized_patient_encounters
ORDER BY department_name, patient_last_name, patient_first_name;

-- ============================================================================
-- 7. DOCTOR WORKLOAD ANALYSIS
-- ============================================================================
-- Doctor workload with patient distribution

SELECT
    CONCAT(doctor_first_name, ' ', doctor_last_name) AS doctor_name,
    doctor_specialization,
    department_name,
    COUNT(DISTINCT fk_patient_id) AS unique_patients,
    COUNT(*) AS total_encounters,
    COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END) AS follow_ups_needed,
    SUM(billingBillable_amount) AS total_billed,
    AVG(billingBillable_amount) AS avg_bill_per_encounter
FROM denormalized_patient_encounters
GROUP BY
    fk_doctor_id, doctor_first_name, doctor_last_name,
    doctor_specialization, department_name
ORDER BY total_encounters DESC;

-- ============================================================================
-- 8. PATIENTS VISITING MULTIPLE DEPARTMENTS
-- ============================================================================
-- Patients who have visited multiple departments

SELECT
    fk_patient_id,
    CONCAT(patient_first_name, ' ', patient_last_name) AS patient_name,
    patient_age,
    COUNT(DISTINCT fk_department_id) AS departments_visited,
    COUNT(DISTINCT fk_doctor_id) AS doctors_seen,
    COUNT(*) AS total_encounters,
    GROUP_CONCAT(DISTINCT department_name ORDER BY department_name) AS departments
FROM denormalized_patient_encounters
GROUP BY fk_patient_id, patient_first_name, patient_last_name, patient_age
HAVING COUNT(DISTINCT fk_department_id) > 1
ORDER BY departments_visited DESC;

-- ============================================================================
-- 9. RECENT PATIENTS BY DEPARTMENT (LAST 30 DAYS)
-- ============================================================================
-- Recent patient activity by department

SELECT
    department_name,
    COUNT(DISTINCT fk_patient_id) AS new_patients,
    COUNT(*) AS total_encounters,
    AVG(billingBillable_amount) AS avg_billing
FROM denormalized_patient_encounters
WHERE encounter_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY fk_department_id, department_name
ORDER BY new_patients DESC;

-- ============================================================================
-- 10. DOCTOR-PATIENT MATRIX
-- ============================================================================
-- Show which doctors are treating which patients

SELECT
    CONCAT(doctor_first_name, ' ', doctor_last_name) AS doctor_name,
    doctor_specialization,
    GROUP_CONCAT(
        DISTINCT CONCAT(patient_first_name, ' ', patient_last_name)
        ORDER BY patient_last_name
        SEPARATOR '; '
    ) AS patients_treated
FROM denormalized_patient_encounters
GROUP BY fk_doctor_id, doctor_first_name, doctor_last_name, doctor_specialization
ORDER BY doctor_last_name;

-- ============================================================================
-- BONUS QUERIES
-- ============================================================================

-- 11. Total Encounter Count (Simple)
SELECT COUNT(*) AS total_encounters
FROM denormalized_patient_encounters;

-- 12. Encounter Count Comparison (Normalized vs Denormalized)
SELECT 'denormalized_patient_encounters' AS table_name, COUNT(*) AS total_encounters
FROM denormalized_patient_encounters
UNION ALL
SELECT 'encounters' AS table_name, COUNT(*) AS total_encounters
FROM encounters;

-- 13. Department Efficiency Metrics
SELECT
    department_name,
    department_head,
    COUNT(*) AS total_encounters,
    COUNT(DISTINCT fk_patient_id) AS unique_patients,
    COUNT(CASE WHEN billing_status = 'Paid' THEN 1 END) AS paid_encounters,
    COUNT(CASE WHEN billing_status = 'Pending' THEN 1 END) AS pending_encounters,
    SUM(billingBillable_amount) AS total_revenue,
    AVG(encounter_duration_minutes) AS avg_duration
FROM denormalized_patient_encounters
GROUP BY fk_department_id, department_name, department_head
ORDER BY total_revenue DESC;

-- 14. Doctor Performance by Specialization
SELECT
    doctor_specialization,
    COUNT(DISTINCT CONCAT(doctor_first_name, ' ', doctor_last_name)) AS num_doctors,
    COUNT(DISTINCT fk_patient_id) AS total_patients,
    COUNT(*) AS total_encounters,
    SUM(billingBillable_amount) AS total_revenue,
    AVG(billingBillable_amount) AS avg_revenue_per_encounter
FROM denormalized_patient_encounters
GROUP BY doctor_specialization
ORDER BY total_revenue DESC;

-- 15. Patient Encounter Timeline
SELECT
    fk_patient_id,
    CONCAT(patient_first_name, ' ', patient_last_name) AS patient_name,
    COUNT(*) AS total_visits,
    MIN(encounter_date) AS first_visit,
    MAX(encounter_date) AS last_visit,
    DATEDIFF(MAX(encounter_date), MIN(encounter_date)) AS days_between_first_last,
    SUM(billingBillable_amount) AS total_spent
FROM denormalized_patient_encounters
GROUP BY fk_patient_id, patient_first_name, patient_last_name
HAVING COUNT(*) > 1
ORDER BY total_visits DESC;

-- ============================================================================
-- END OF ANALYSIS QUERIES
-- ============================================================================
