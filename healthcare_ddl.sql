-- ============================================================================
-- Healthcare Patient Records - DDL (Data Definition Language)
-- Database: healthcare_system
-- Main Denormalized Table: denormalized_patient_encounters
-- Related Dimensions: patients, doctors, departments, diagnoses, medications
-- ============================================================================

-- Drop database if exists (for fresh start)
DROP DATABASE IF EXISTS healthcare_system;
CREATE DATABASE healthcare_system;
USE healthcare_system;

-- ============================================================================
-- DIMENSION TABLES (Lookup Tables)
-- ============================================================================

-- 1. DEPARTMENTS TABLE
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    department_code VARCHAR(20) NOT NULL,
    floor_number INT,
    phone_number VARCHAR(15),
    head_physician VARCHAR(100),
    budget_allocated DECIMAL(12, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. DOCTORS TABLE
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    license_number VARCHAR(50) NOT NULL UNIQUE,
    specialization VARCHAR(100),
    fk_department_id INT NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(100),
    hire_date DATE,
    years_of_experience INT,
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fk_department_id) REFERENCES departments(department_id),
    INDEX idx_specialization (specialization),
    INDEX idx_department (fk_department_id)
);

-- 3. PATIENTS TABLE
CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
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
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_patient_name (last_name, first_name),
    INDEX idx_dob (date_of_birth)
);

-- 4. DIAGNOSES LOOKUP TABLE
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

-- 5. MEDICATIONS LOOKUP TABLE
CREATE TABLE medications (
    medication_id INT PRIMARY KEY AUTO_INCREMENT,
    medication_name VARCHAR(255) NOT NULL UNIQUE,
    generic_name VARCHAR(255),
    ndc_code VARCHAR(20),
    dosage_strength VARCHAR(50),
    dosage_form VARCHAR(50),
    route_of_administration VARCHAR(50),
    common_side_effects TEXT,
    contraindications TEXT,
    manufacturer VARCHAR(100),
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_med_name (medication_name),
    INDEX idx_generic (generic_name)
);

-- ============================================================================
-- MAIN DENORMALIZED TABLE
-- ============================================================================


USE healthcare_system;
	--  DROP TABLE denormalized_patient_encounters
CREATE TABLE denormalized_patient_encounters (
    -- Primary Key
    encounter_id INT PRIMARY KEY AUTO_INCREMENT,
--     -- Foreign Keys to Dimension Tables
    fk_patient_id INT NOT NULL,
    fk_doctor_id INT NOT NULL,
    fk_department_id INT NOT NULL,
    fk_diagnosis_id INT,
    fk_medication_id INT,
    -- ========== PATIENT ATTRIBUTES (Denormalized) ==========
    patient_first_name VARCHAR(100),
    patient_last_name VARCHAR(100),
    patient_date_of_birth DATE,
    patient_age INT,
    patient_gender VARCHAR(10),
    patient_blood_type VARCHAR(5),
    patient_phone VARCHAR(15),
    patient_email VARCHAR(100),
    patient_street_address VARCHAR(255),
    patient_city VARCHAR(100),
    patient_state VARCHAR(100),
    patient_postal_code VARCHAR(20),
    patient_country VARCHAR(100),
    patient_insurance_provider VARCHAR(100),
    patient_insurance_policy_number VARCHAR(50),
    patient_emergency_contact_name VARCHAR(100),
    patient_emergency_contact_phone VARCHAR(15),
    patient_registration_date DATE,
    -- ========== DOCTOR ATTRIBUTES (Denormalized) ==========
    doctor_first_name VARCHAR(100),
    doctor_last_name VARCHAR(100),
    doctor_license_number VARCHAR(50),
    doctor_specialization VARCHAR(100),
    doctor_phone VARCHAR(15),
    doctor_email VARCHAR(100),
    doctor_hire_date DATE,
    doctor_years_experience INT,
    -- ========== DEPARTMENT ATTRIBUTES (Denormalized) ==========
    department_name VARCHAR(100),
    department_code VARCHAR(20),
    department_floor INT,
    department_phone VARCHAR(15),
    department_head VARCHAR(100),
    -- ========== DIAGNOSIS ATTRIBUTES (Denormalized) ==========
    diagnosis_icd_code VARCHAR(20),
    diagnosis_name VARCHAR(255),
    diagnosis_category VARCHAR(100),
    diagnosis_severity VARCHAR(20),
    diagnosis_description TEXT,
    is_chronic_diagnosis BOOLEAN,
    -- ========== MEDICATION ATTRIBUTES (Denormalized) ==========
    medication_name VARCHAR(255),
    medication_generic_name VARCHAR(255),
    medication_dosage_strength VARCHAR(50),
    medication_dosage_form VARCHAR(50),
    medication_route VARCHAR(50),
    medication_side_effects TEXT,
    medication_contraindications TEXT,
    medication_manufacturer VARCHAR(100),
    -- ========== ENCOUNTER SPECIFIC ATTRIBUTES ==========
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
    -- ========== AUDIT & SYSTEM FIELDS ==========
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    last_modified_by VARCHAR(100),
    -- Foreign Key Constraints
    FOREIGN KEY (fk_patient_id) REFERENCES patients(patient_id) ON DELETE RESTRICT,
    FOREIGN KEY (fk_doctor_id) REFERENCES doctors(doctor_id) ON DELETE RESTRICT,
    FOREIGN KEY (fk_department_id) REFERENCES departments(department_id) ON DELETE RESTRICT,
    FOREIGN KEY (fk_diagnosis_id) REFERENCES diagnoses(diagnosis_id) ON DELETE SET NULL,
    FOREIGN KEY (fk_medication_id) REFERENCES medications(medication_id) ON DELETE SET NULL,
    -- Indexes for Performance
    INDEX idx_patient (fk_patient_id),
    INDEX idx_doctor (fk_doctor_id),
    INDEX idx_department (fk_department_id),
    INDEX idx_encounter_date (encounter_date),
    INDEX idx_encounter_type (encounter_type),
    INDEX idx_billing_status (billing_status)
);

-- ============================================================================
-- SUMMARY: TABLE STRUCTURE
-- ============================================================================
/*
Primary Key: encounter_id (AUTO_INCREMENT)

Foreign Keys:
  - fk_patient_id → patients(patient_id)
  - fk_doctor_id → doctors(doctor_id)
  - fk_department_id → departments(department_id)
  - fk_diagnosis_id → diagnoses(diagnosis_id)
  - fk_medication_id → medications(medication_id)

Total Attributes: 68 denormalized columns covering:
  - Customer/Patient Info: 18 attributes
  - Doctor Info: 8 attributes
  - Department Info: 5 attributes
  - Diagnosis Info: 6 attributes
  - Medication Info: 8 attributes
  - Encounter/Transaction Info: 14 attributes
  - Audit/System Fields: 4 attributes

Denormalization Rationale:
  - Stores customer data redundantly (patient info repeated per encounter)
  - Pre-computes calculated fields (patient_age)
  - Includes lookup description fields (diagnosis_name, medication_dosage_form)
  - Enables single-table queries without complex joins
  - Trade-off: Storage overhead vs Query performance
*/

