-- ============================================================================
-- Healthcare Patient Records - INSERT INTO SELECT STATEMENT
-- Populates denormalized_patient_encounters from normalized dimension tables
-- encounter_id: INT PRIMARY KEY AUTO_INCREMENT (auto-generated)
-- ============================================================================

USE healthcare_system;

-- ============================================================================
-- APPROACH 1: CREATE NORMALIZED ENCOUNTERS TABLE (Base Table)
-- ============================================================================

-- This is the source table that tracks encounters (before denormalization)
CREATE TABLE IF NOT EXISTS encounters (
    encounter_id INT PRIMARY KEY AUTO_INCREMENT,
    fk_patient_id INT NOT NULL,
    fk_doctor_id INT NOT NULL,
    fk_department_id INT NOT NULL,
    fk_diagnosis_id INT,
    fk_medication_id INT,
    encounter_date DATE NOT NULL,
    encounter_time TIME,
    encounter_type VARCHAR(50),
    encounter_duration_minutes INT,
    chief_complaint TEXT,
    vital_signs_temperature DECIMAL(5, 2),
    vital_signs_blood_pressure VARCHAR(20),
    vital_signs_heart_rate INT,
    vital_signs_respiratory_rate INT,
    clinical_notes TEXT,
    treatment_plan TEXT,
    prescribed_quantity INT,
    prescribed_frequency VARCHAR(100),
    prescription_duration_days INT,
    follow_up_date DATE,
    follow_up_required BOOLEAN,
    billingBillable_amount DECIMAL(10, 2),
    billing_status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    last_modified_by VARCHAR(100),
    FOREIGN KEY (fk_patient_id) REFERENCES patients(patient_id) ON DELETE RESTRICT,
    FOREIGN KEY (fk_doctor_id) REFERENCES doctors(doctor_id) ON DELETE RESTRICT,
    FOREIGN KEY (fk_department_id) REFERENCES departments(department_id) ON DELETE RESTRICT,
    FOREIGN KEY (fk_diagnosis_id) REFERENCES diagnoses(diagnosis_id) ON DELETE SET NULL,
    FOREIGN KEY (fk_medication_id) REFERENCES medications(medication_id) ON DELETE SET NULL,
    INDEX idx_patient (fk_patient_id),
    INDEX idx_doctor (fk_doctor_id),
    INDEX idx_department (fk_department_id),
    INDEX idx_encounter_date (encounter_date)
);

-- ============================================================================
-- INSERT SAMPLE DATA INTO NORMALIZED ENCOUNTERS TABLE
-- ============================================================================

INSERT INTO encounters (
    fk_patient_id, fk_doctor_id, fk_department_id, fk_diagnosis_id, fk_medication_id,
    encounter_date, encounter_time, encounter_type, encounter_duration_minutes, chief_complaint,
    vital_signs_temperature, vital_signs_blood_pressure, vital_signs_heart_rate, vital_signs_respiratory_rate,
    clinical_notes, treatment_plan, prescribed_quantity, prescribed_frequency, prescription_duration_days,
    follow_up_date, follow_up_required, billingBillable_amount, billing_status,
    created_by, last_modified_by
) VALUES
(1, 1, 1, 1, 1, '2024-01-15', '09:30:00', 'Routine Checkup', 30, 'Blood pressure monitoring and medication review', 98.6, '155/95', 78, 16, 'Patient presents with hypertension well controlled on current medication. BP reading slightly elevated today.', 'Continue Lisinopril 10mg daily. Reduce sodium intake. Follow up in 3 months.', 90, 'Once daily', 90, '2024-04-15', TRUE, 250.00, 'Paid', 'Dr. James Mitchell', 'Dr. James Mitchell'),
(2, 2, 2, 4, 5, '2024-01-20', '10:15:00', 'Psychiatric Evaluation', 45, 'Follow-up for depression management', 98.8, '120/80', 72, 15, 'Patient reports improved mood on current medication. No suicidal ideation. Sleep still slightly disrupted.', 'Continue Sertraline 50mg daily. Consider cognitive behavioral therapy. Follow-up in 2 months.', 60, 'Once daily', 60, '2024-03-20', TRUE, 300.00, 'Pending', 'Dr. Sarah Chen', 'Dr. Sarah Chen'),
(3, 3, 3, 5, 8, '2024-01-25', '14:00:00', 'Physical Examination', 25, 'Right shoulder pain and muscle strain', 98.7, '130/82', 75, 17, 'Patient presents with myalgia in right shoulder. Limited range of motion. No signs of fracture on palpation.', 'Prescribe Ibuprofen 200mg for pain management. Physical therapy recommended. Rest and ice for 48 hours.', 30, 'Three times daily with food', 14, '2024-02-08', TRUE, 180.50, 'Paid', 'Dr. Michael Kumar', 'Dr. Michael Kumar'),
(4, 4, 4, 5, 7, '2024-02-01', '11:00:00', 'Consultation', 35, 'Suspected upper respiratory infection', 99.1, '118/76', 80, 18, 'Patient with fever and mild cough for 2 days. Throat slightly inflamed. No signs of pneumonia.', 'Prescribe Amoxicillin for bacterial infection. Supportive care. Recheck if symptoms persist after 5 days.', 20, 'Three times daily', 10, '2024-02-15', FALSE, 210.00, 'Paid', 'Dr. Emma Rodriguez', 'Dr. Emma Rodriguez'),
(5, 5, 5, 8, 10, '2024-02-05', '15:30:00', 'Chemotherapy Session', 120, 'Third cycle of lung cancer chemotherapy', 98.5, '128/84', 82, 19, 'Patient tolerating chemotherapy well. No significant side effects. Tumor markers showing improvement.', 'Continue chemotherapy protocol. Monitor blood counts. Supportive care for nausea and fatigue.', 1, 'As prescribed by oncology', 28, '2024-02-26', TRUE, 1500.00, 'Paid', 'Dr. David Thompson', 'Dr. David Thompson'),
(6, 6, 6, 10, 3, '2024-02-10', '19:45:00', 'Emergency Admission', 180, 'Chest pain with EKG changes consistent with MI', 99.2, '142/92', 105, 22, 'Patient presented to ER with acute chest pain radiating to left arm. EKG shows ST elevation. Troponin elevated.', 'Admit to ICU for cardiac monitoring. Initiate dual antiplatelet therapy and statin. Consider angiography.', 30, 'Once daily (long-term)', 365, '2024-04-10', TRUE, 5000.00, 'Pending', 'Dr. Lisa Anderson', 'Dr. Lisa Anderson'),
(7, 7, 7, 4, 5, '2024-02-12', '13:20:00', 'Psychiatric Session', 50, 'Ongoing depression management and therapy', 98.9, '122/81', 76, 16, 'Patient reports good response to medication. Mood improved. Still experiencing some anhedonia.', 'Continue Sertraline. Increase psychotherapy frequency to twice monthly. Discuss lifestyle modifications.', 60, 'Once daily', 90, '2024-05-12', TRUE, 400.00, 'Paid', 'Dr. Robert Wilson', 'Dr. Robert Wilson'),
(8, 8, 8, 5, 9, '2024-02-18', '10:00:00', 'Post-Operative Checkup', 40, 'Follow-up after appendectomy', 98.4, '125/79', 71, 14, 'Surgical wound healing well. No signs of infection. Patient reports minimal pain at this visit.', 'Continue antibiotic course to completion. Wound care instructions provided. Light activity only for 2 weeks.', 30, 'Twice daily', 10, '2024-03-04', FALSE, 350.00, 'Paid', 'Dr. Jennifer Lee', 'Dr. Jennifer Lee'),
(9, 9, 9, 5, 2, '2024-02-22', '09:30:00', 'Dermatology Consultation', 30, 'Skin lesion evaluation and biopsy', 98.6, '128/83', 74, 15, 'Patient with new skin lesion on back. Biopsy performed for pathology report. Lesion appears benign clinically.', 'Await biopsy results. Avoid sun exposure to affected area. Return in 1 week for results review.', 60, 'Twice daily with meals', 30, '2024-03-01', TRUE, 275.00, 'Paid', 'Dr. Christopher Brown', 'Dr. Christopher Brown'),
(10, 10, 10, 7, 4, '2024-02-28', '14:30:00', 'Upper Endoscopy', 60, 'Evaluation of chronic reflux symptoms', 98.7, '123/80', 73, 16, 'Endoscopy shows moderate gastritis but no Barrett esophagus or ulceration. No malignancy noted.', 'Increase Omeprazole to 40mg daily. Lifestyle modifications: avoid spicy foods, elevate bed head.', 60, 'Once daily', 90, '2024-05-28', TRUE, 450.00, 'Paid', 'Dr. Patricia Martinez', 'Dr. Patricia Martinez'),
(11, 1, 1, 1, 1, '2024-03-05', '08:45:00', 'Routine Checkup', 30, 'Blood pressure management follow-up', 98.5, '148/92', 77, 16, 'BP reading elevated despite medication. Patient admits to occasional medication non-compliance.', 'Adjust Lisinopril to 20mg. Counsel on medication adherence. Dietary sodium restriction reinforced.', 90, 'Once daily', 90, '2024-06-05', TRUE, 250.00, 'Paid', 'Dr. James Mitchell', 'Dr. James Mitchell'),
(12, 2, 2, 4, 5, '2024-03-10', '11:00:00', 'Neuropsychiatry Consultation', 50, 'Evaluation for treatment-resistant depression', 98.8, '119/79', 71, 15, 'Patient currently on Sertraline 50mg with partial response. Considering medication augmentation strategy.', 'Trial of bupropion augmentation. Continue psychotherapy. Recheck in 6 weeks.', 30, 'Once daily', 60, '2024-04-24', TRUE, 350.00, 'Paid', 'Dr. Sarah Chen', 'Dr. Sarah Chen'),
(13, 11, 1, 2, 2, '2024-03-15', '09:00:00', 'Endocrinology Consultation', 40, 'Diabetes management and HbA1c review', 98.6, '132/85', 79, 17, 'Latest HbA1c 7.2%. Patient reports good compliance with diet and exercise. Fasting glucose 156 mg/dL.', 'Continue Metformin 500mg twice daily. Consider adding second agent if next HbA1c remains above 7%.', 90, 'Twice daily with meals', 90, '2024-06-15', TRUE, 300.00, 'Paid', 'Dr. William Johnson', 'Dr. William Johnson'),
(14, 12, 2, 3, 9, '2024-03-20', '15:00:00', 'Pulmonary Function Test', 60, 'COPD assessment and respiratory therapy', 98.7, '125/81', 74, 18, 'FEV1/FVC ratio indicates moderate airflow obstruction. Patient completing pulmonary rehabilitation program.', 'Continue current bronchodilator therapy. Influenza and pneumococcal vaccines administered. Smoking cessation counseling.', 30, 'Twice daily', 30, '2024-04-20', TRUE, 400.00, 'Paid', 'Dr. Angela Davis', 'Dr. Angela Davis'),
(15, 3, 3, 6, 11, '2024-03-25', '10:30:00', 'Nephrology Follow-up', 35, 'Chronic kidney disease monitoring', 98.4, '130/82', 72, 15, 'eGFR 45 mL/min/1.73m2. Creatinine stable. Proteinuria minimal. Patient counseled on renal-protective diet.', 'Continue Losartan. Renal function panel every 3 months. Nephrology referral confirmed for March 2025.', 90, 'Once daily', 90, '2024-06-25', TRUE, 280.00, 'Paid', 'Dr. Michael Kumar', 'Dr. Michael Kumar');

-- ============================================================================
-- MAIN INSERT INTO SELECT STATEMENT
-- Denormalization: Joins all dimension tables and populates denormalized table
-- encounter_id: AUTO_INCREMENT (not specified in SELECT, will be auto-generated)
-- ============================================================================

INSERT INTO denormalized_patient_encounters (
    fk_patient_id,
    fk_doctor_id,
    fk_department_id,
    fk_diagnosis_id,
    fk_medication_id,
    patient_first_name,
    patient_last_name,
    patient_date_of_birth,
    patient_age,
    patient_gender,
    patient_blood_type,
    patient_phone,
    patient_email,
    patient_street_address,
    patient_city,
    patient_state,
    patient_postal_code,
    patient_country,
    patient_insurance_provider,
    patient_insurance_policy_number,
    patient_emergency_contact_name,
    patient_emergency_contact_phone,
    patient_registration_date,
    doctor_first_name,
    doctor_last_name,
    doctor_license_number,
    doctor_specialization,
    doctor_phone,
    doctor_email,
    doctor_hire_date,
    doctor_years_experience,
    department_name,
    department_code,
    department_floor,
    department_phone,
    department_head,
    diagnosis_icd_code,
    diagnosis_name,
    diagnosis_category,
    diagnosis_severity,
    diagnosis_description,
    is_chronic_diagnosis,
    medication_name,
    medication_generic_name,
    medication_dosage_strength,
    medication_dosage_form,
    medication_route,
    medication_side_effects,
    medication_contraindications,
    medication_manufacturer,
    encounter_date,
    encounter_time,
    encounter_type,
    encounter_duration_minutes,
    chief_complaint,
    vital_signs_temperature,
    vital_signs_blood_pressure,
    vital_signs_heart_rate,
    vital_signs_respiratory_rate,
    clinical_notes,
    treatment_plan,
    prescribed_quantity,
    prescribed_frequency,
    prescription_duration_days,
    follow_up_date,
    follow_up_required,
    billingBillable_amount,
    billing_status,
    created_by,
    last_modified_by
)
SELECT
    -- Foreign Keys (passed through from encounters table)
    e.fk_patient_id,
    e.fk_doctor_id,
    e.fk_department_id,
    e.fk_diagnosis_id,
    e.fk_medication_id,
    
    -- ========== PATIENT ATTRIBUTES (FROM PATIENTS TABLE) ==========
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    p.date_of_birth AS patient_date_of_birth,
    YEAR(CURDATE()) - YEAR(p.date_of_birth) - (DATE_FORMAT(CURDATE(), '%m%d') < DATE_FORMAT(p.date_of_birth, '%m%d')) AS patient_age,
    p.gender AS patient_gender,
    p.blood_type AS patient_blood_type,
    p.phone_number AS patient_phone,
    p.email AS patient_email,
    p.street_address AS patient_street_address,
    p.city AS patient_city,
    p.state_province AS patient_state,
    p.postal_code AS patient_postal_code,
    p.country AS patient_country,
    p.insurance_provider AS patient_insurance_provider,
    p.insurance_policy_number AS patient_insurance_policy_number,
    p.emergency_contact_name AS patient_emergency_contact_name,
    p.emergency_contact_phone AS patient_emergency_contact_phone,
    p.registration_date AS patient_registration_date,
    
    -- ========== DOCTOR ATTRIBUTES (FROM DOCTORS TABLE) ==========
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    d.license_number AS doctor_license_number,
    d.specialization AS doctor_specialization,
    d.phone_number AS doctor_phone,
    d.email AS doctor_email,
    d.hire_date AS doctor_hire_date,
    d.years_of_experience AS doctor_years_experience,
    
    -- ========== DEPARTMENT ATTRIBUTES (FROM DEPARTMENTS TABLE) ==========
    dp.department_name,
    dp.department_code,
    dp.floor_number AS department_floor,
    dp.phone_number AS department_phone,
    dp.head_physician AS department_head,
    
    -- ========== DIAGNOSIS ATTRIBUTES (FROM DIAGNOSES TABLE) ==========
    di.icd_code AS diagnosis_icd_code,
    di.diagnosis_name,
    di.diagnosis_category,
    di.severity_level AS diagnosis_severity,
    di.description AS diagnosis_description,
    di.is_chronic AS is_chronic_diagnosis,
    
    -- ========== MEDICATION ATTRIBUTES (FROM MEDICATIONS TABLE) ==========
    m.medication_name,
    m.generic_name AS medication_generic_name,
    m.dosage_strength AS medication_dosage_strength,
    m.dosage_form AS medication_dosage_form,
    m.route_of_administration AS medication_route,
    m.common_side_effects AS medication_side_effects,
    m.contraindications AS medication_contraindications,
    m.manufacturer AS medication_manufacturer,
    
    -- ========== ENCOUNTER ATTRIBUTES (FROM ENCOUNTERS TABLE) ==========
    e.encounter_date,
    e.encounter_time,
    e.encounter_type,
    e.encounter_duration_minutes,
    e.chief_complaint,
    e.vital_signs_temperature,
    e.vital_signs_blood_pressure,
    e.vital_signs_heart_rate,
    e.vital_signs_respiratory_rate,
    e.clinical_notes,
    e.treatment_plan,
    e.prescribed_quantity,
    e.prescribed_frequency,
    e.prescription_duration_days,
    e.follow_up_date,
    e.follow_up_required,
    e.billingBillable_amount,
    e.billing_status,
    
    -- ========== AUDIT FIELDS ==========
    e.created_by,
    e.last_modified_by

-- ========== JOINS TO BRING ALL DIMENSION DATA TOGETHER ==========
FROM encounters e
    LEFT JOIN patients p ON e.fk_patient_id = p.patient_id
    LEFT JOIN doctors d ON e.fk_doctor_id = d.doctor_id
    LEFT JOIN departments dp ON e.fk_department_id = dp.department_id
    LEFT JOIN diagnoses di ON e.fk_diagnosis_id = di.diagnosis_id
    LEFT JOIN medications m ON e.fk_medication_id = m.medication_id
WHERE e.fk_patient_id IS NOT NULL
  AND e.fk_doctor_id IS NOT NULL
  AND e.fk_department_id IS NOT NULL;

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

-- Check row counts
SELECT 'encounters' AS table_name, COUNT(*) AS row_count FROM encounters
UNION ALL
SELECT 'denormalized_patient_encounters' AS table_name, COUNT(*) AS row_count FROM denormalized_patient_encounters;

-- Verify denormalized data was loaded correctly
SELECT 
    encounter_id,
    patient_first_name,
    patient_last_name,
    doctor_first_name,
    doctor_last_name,
    department_name,
    diagnosis_name,
    medication_name,
    encounter_date,
    billing_status
FROM denormalized_patient_encounters
LIMIT 5;

-- Check for NULL values in critical columns
SELECT 
    encounter_id,
    CASE WHEN patient_first_name IS NULL THEN 'MISSING' ELSE 'OK' END AS patient_check,
    CASE WHEN doctor_first_name IS NULL THEN 'MISSING' ELSE 'OK' END AS doctor_check,
    CASE WHEN department_name IS NULL THEN 'MISSING' ELSE 'OK' END AS department_check,
    CASE WHEN encounter_date IS NULL THEN 'MISSING' ELSE 'OK' END AS encounter_date_check
FROM denormalized_patient_encounters;

-- Display summary statistics
SELECT 
    'denormalized_patient_encounters' AS table_name,
    COUNT(*) AS total_rows,
    COUNT(DISTINCT fk_patient_id) AS unique_patients,
    COUNT(DISTINCT fk_doctor_id) AS unique_doctors,
    COUNT(DISTINCT fk_department_id) AS unique_departments,
    COUNT(DISTINCT fk_diagnosis_id) AS unique_diagnoses,
    COUNT(DISTINCT fk_medication_id) AS unique_medications,
    MIN(encounter_date) AS earliest_date,
    MAX(encounter_date) AS latest_date
FROM denormalized_patient_encounters;

-- ============================================================================
-- USAGE NOTES
-- ============================================================================
/*

1. ENCOUNTER_ID HANDLING:
   - encounter_id is defined as INT PRIMARY KEY AUTO_INCREMENT
   - The INSERT...SELECT statement uses LEFT JOINs 
   - encounter_id is NOT included in the column list
   - MySQL automatically generates sequential IDs (1, 2, 3, ...)
   - Each row gets a unique encounter_id automatically

2. WHEN TO RUN THIS SCRIPT:
   - Initial data load from normalized to denormalized structure
   - Periodic synchronization if normalized data changes
   - Data warehouse refresh
   - Testing and validation environments

3. IMPORTANT CONSIDERATIONS:
   - Truncate denormalized table before re-running if doing a full reload
   - Use WHERE clause to insert only new/updated records for incremental loads
   - LEFT JOINs used to handle nullable FK relationships (diagnosis, medication)
   - Records with NULL diagnosis_id or medication_id still get loaded
   - INNER JOINS could be used if strict data quality required

4. PERFORMANCE:
   - First run: ~2-5 seconds for 15 records
   - Scales with encounter volume
   - Consider indexing on join keys if production volume (100K+ records)
   - Batch process large migrations in chunks of 10K records

5. DATA INTEGRITY:
   - All FKs still maintained and enforced
   - Denormalized columns are duplicates of source data
   - Any updates to source tables require re-sync of denormalized table
   - Consider triggers or scheduled jobs for keeping tables in sync

6. MODIFICATION EXAMPLE - Incremental Load:
   To insert only new encounters since last load:
   
   INSERT INTO denormalized_patient_encounters (...)
   SELECT ... FROM encounters e
   WHERE e.encounter_id > (SELECT MAX(encounter_id) FROM denormalized_patient_encounters)
   [rest of joins]

7. MODIFICATION EXAMPLE - Full Refresh:
   TRUNCATE denormalized_patient_encounters;
   [Run full INSERT...SELECT above]

*/
