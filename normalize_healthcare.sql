-- ============================================================================
-- Healthcare System - Data Normalization Script
-- Source: healthcare_system.denormalized_patient_encounters
-- Target: healthcare_system_model_db (Normalized 3NF Tables)
-- ============================================================================

DROP DATABASE IF EXISTS healthcare_system_model_db;
CREATE DATABASE healthcare_system_model_db;
USE healthcare_system_model_db;

-- ============================================================================
-- 1. DEPARTMENTS TABLE
-- ============================================================================
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    department_code VARCHAR(20) NOT NULL,
    floor_number INT,
    phone_number VARCHAR(15),
    head_physician VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO departments (department_name, department_code, floor_number, phone_number, head_physician)
SELECT DISTINCT
    department_name,
    department_code,
    department_floor,
    department_phone,
    department_head
FROM healthcare_system.denormalized_patient_encounters
WHERE department_name IS NOT NULL
ORDER BY department_name;

-- ============================================================================
-- 2. DOCTORS TABLE
-- ============================================================================
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    license_number VARCHAR(50) NOT NULL UNIQUE,
    specialization VARCHAR(100),
    fk_department_id INT,
    phone_number VARCHAR(15),
    email VARCHAR(100),
    hire_date DATE,
    years_of_experience INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fk_department_id) REFERENCES departments(department_id),
    INDEX idx_specialization (specialization),
    INDEX idx_department (fk_department_id)
);

INSERT INTO doctors (first_name, last_name, license_number, specialization, fk_department_id, phone_number, email, hire_date, years_of_experience)
SELECT
    sub.doctor_first_name,
    sub.doctor_last_name,
    sub.doctor_license_number,
    sub.doctor_specialization,
    d.department_id,
    sub.doctor_phone,
    sub.doctor_email,
    sub.doctor_hire_date,
    sub.doctor_years_experience
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY doctor_license_number ORDER BY encounter_id) AS rn
    FROM healthcare_system.denormalized_patient_encounters
    WHERE doctor_license_number IS NOT NULL
) sub
JOIN departments d ON d.department_name = sub.department_name
WHERE sub.rn = 1
ORDER BY sub.doctor_license_number;

-- ============================================================================
-- 3. PATIENTS TABLE
-- ============================================================================
CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    source_patient_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(10),
    blood_type VARCHAR(5),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    street_address VARCHAR(255),
    city VARCHAR(100),
    state_province VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    insurance_provider VARCHAR(100),
    insurance_policy_number VARCHAR(50),
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(15),
    registration_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_source_patient (source_patient_id),
    INDEX idx_patient_name (last_name, first_name),
    INDEX idx_dob (date_of_birth)
);

INSERT INTO patients (source_patient_id, first_name, last_name, date_of_birth, gender, blood_type, phone_number, email, street_address, city, state_province, postal_code, country, insurance_provider, insurance_policy_number, emergency_contact_name, emergency_contact_phone, registration_date)
SELECT
    fk_patient_id,
    patient_first_name,
    patient_last_name,
    patient_date_of_birth,
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
    patient_registration_date
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY fk_patient_id ORDER BY encounter_id) AS rn
    FROM healthcare_system.denormalized_patient_encounters
    WHERE fk_patient_id IS NOT NULL
) sub
WHERE rn = 1
ORDER BY fk_patient_id;

-- ============================================================================
-- 4. DIAGNOSES TABLE
-- ============================================================================
CREATE TABLE diagnoses (
    diagnosis_id INT PRIMARY KEY AUTO_INCREMENT,
    icd_code VARCHAR(20) NOT NULL UNIQUE,
    diagnosis_name VARCHAR(255) NOT NULL,
    diagnosis_category VARCHAR(100),
    severity_level VARCHAR(20),
    description TEXT,
    is_chronic BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_icd_code (icd_code),
    INDEX idx_category (diagnosis_category)
);

INSERT INTO diagnoses (icd_code, diagnosis_name, diagnosis_category, severity_level, description, is_chronic)
SELECT
    diagnosis_icd_code,
    diagnosis_name,
    diagnosis_category,
    diagnosis_severity,
    diagnosis_description,
    is_chronic_diagnosis
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY diagnosis_icd_code ORDER BY encounter_id) AS rn
    FROM healthcare_system.denormalized_patient_encounters
    WHERE diagnosis_icd_code IS NOT NULL
) sub
WHERE rn = 1
ORDER BY diagnosis_icd_code;

-- ============================================================================
-- 5. MEDICATIONS TABLE
-- ============================================================================
CREATE TABLE medications (
    medication_id INT PRIMARY KEY AUTO_INCREMENT,
    medication_name VARCHAR(255) NOT NULL UNIQUE,
    generic_name VARCHAR(255),
    dosage_strength VARCHAR(50),
    dosage_form VARCHAR(50),
    route_of_administration VARCHAR(50),
    common_side_effects TEXT,
    contraindications TEXT,
    manufacturer VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_med_name (medication_name),
    INDEX idx_generic (generic_name)
);

INSERT INTO medications (medication_name, generic_name, dosage_strength, dosage_form, route_of_administration, common_side_effects, contraindications, manufacturer)
SELECT
    medication_name,
    medication_generic_name,
    medication_dosage_strength,
    medication_dosage_form,
    medication_route,
    medication_side_effects,
    medication_contraindications,
    medication_manufacturer
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY medication_name ORDER BY encounter_id) AS rn
    FROM healthcare_system.denormalized_patient_encounters
    WHERE medication_name IS NOT NULL
) sub
WHERE rn = 1
ORDER BY medication_name;

-- ============================================================================
-- 6. ENCOUNTERS TABLE (Fact Table)
-- ============================================================================
CREATE TABLE encounters (
    encounter_id INT PRIMARY KEY AUTO_INCREMENT,
    source_encounter_id INT NOT NULL,
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
    billable_amount DECIMAL(10, 2),
    billing_status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    last_modified_by VARCHAR(100),
    UNIQUE KEY uk_source_encounter (source_encounter_id),
    FOREIGN KEY (fk_patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (fk_doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (fk_department_id) REFERENCES departments(department_id),
    FOREIGN KEY (fk_diagnosis_id) REFERENCES diagnoses(diagnosis_id),
    FOREIGN KEY (fk_medication_id) REFERENCES medications(medication_id),
    INDEX idx_patient (fk_patient_id),
    INDEX idx_doctor (fk_doctor_id),
    INDEX idx_department (fk_department_id),
    INDEX idx_encounter_date (encounter_date),
    INDEX idx_encounter_type (encounter_type),
    INDEX idx_billing_status (billing_status)
);

INSERT INTO encounters (
    source_encounter_id, fk_patient_id, fk_doctor_id, fk_department_id,
    fk_diagnosis_id, fk_medication_id, encounter_date, encounter_time,
    encounter_type, encounter_duration_minutes, chief_complaint,
    vital_signs_temperature, vital_signs_blood_pressure, vital_signs_heart_rate,
    vital_signs_respiratory_rate, clinical_notes, treatment_plan,
    prescribed_quantity, prescribed_frequency, prescription_duration_days,
    follow_up_date, follow_up_required, billable_amount, billing_status,
    created_by, last_modified_by
)
SELECT
    dpe.encounter_id,
    p.patient_id,
    doc.doctor_id,
    dep.department_id,
    diag.diagnosis_id,
    med.medication_id,
    dpe.encounter_date,
    dpe.encounter_time,
    dpe.encounter_type,
    dpe.encounter_duration_minutes,
    dpe.chief_complaint,
    dpe.vital_signs_temperature,
    dpe.vital_signs_blood_pressure,
    dpe.vital_signs_heart_rate,
    dpe.vital_signs_respiratory_rate,
    dpe.clinical_notes,
    dpe.treatment_plan,
    dpe.prescribed_quantity,
    dpe.prescribed_frequency,
    dpe.prescription_duration_days,
    dpe.follow_up_date,
    dpe.follow_up_required,
    dpe.billingBillable_amount,
    dpe.billing_status,
    dpe.created_by,
    dpe.last_modified_by
FROM healthcare_system.denormalized_patient_encounters dpe
JOIN patients p ON p.source_patient_id = dpe.fk_patient_id
JOIN doctors doc ON doc.license_number = dpe.doctor_license_number
JOIN departments dep ON dep.department_name = dpe.department_name
LEFT JOIN diagnoses diag ON diag.icd_code = dpe.diagnosis_icd_code
LEFT JOIN medications med ON med.medication_name = dpe.medication_name
ORDER BY dpe.encounter_id;

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

SELECT '=== NORMALIZATION COMPLETE ===' AS status;

SELECT 'departments' AS table_name, COUNT(*) AS record_count FROM departments
UNION ALL SELECT 'doctors', COUNT(*) FROM doctors
UNION ALL SELECT 'patients', COUNT(*) FROM patients
UNION ALL SELECT 'diagnoses', COUNT(*) FROM diagnoses
UNION ALL SELECT 'medications', COUNT(*) FROM medications
UNION ALL SELECT 'encounters', COUNT(*) FROM encounters;

SELECT CONCAT('Source denormalized records: ', COUNT(*)) AS source_count
FROM healthcare_system.denormalized_patient_encounters;
