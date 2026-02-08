-- ============================================================================
-- Healthcare Patient Records - DML (Data Manipulation Language)
-- Database: healthcare_system
-- Generates realistic fake data for testing and demonstration
-- ============================================================================

USE healthcare_system;

-- ============================================================================
-- 1. INSERT DEPARTMENTS (Lookup Table)
-- ============================================================================

INSERT INTO departments (department_name, department_code, floor_number, phone_number, head_physician, budget_allocated) VALUES
('Cardiology', 'CARD', 2, '555-0101', 'Dr. James Mitchell', 500000.00),
('Neurology', 'NEURO', 3, '555-0102', 'Dr. Sarah Chen', 450000.00),
('Orthopedics', 'ORTHO', 1, '555-0103', 'Dr. Michael Kumar', 480000.00),
('Pediatrics', 'PEDS', 4, '555-0104', 'Dr. Emma Rodriguez', 420000.00),
('Oncology', 'ONCO', 5, '555-0105', 'Dr. David Thompson', 520000.00),
('Emergency Medicine', 'ER', 1, '555-0106', 'Dr. Lisa Anderson', 600000.00),
('Psychiatry', 'PSYCH', 6, '555-0107', 'Dr. Robert Wilson', 380000.00),
('General Surgery', 'SURGERY', 2, '555-0108', 'Dr. Jennifer Lee', 550000.00),
('Dermatology', 'DERM', 3, '555-0109', 'Dr. Christopher Brown', 380000.00),
('Gastroenterology', 'GI', 4, '555-0110', 'Dr. Patricia Martinez', 460000.00);

-- ============================================================================
-- 2. INSERT DOCTORS (Lookup Table)
-- ============================================================================

INSERT INTO doctors (first_name, last_name, license_number, specialization, fk_department_id, phone_number, email, hire_date, years_of_experience, is_available) VALUES
('James', 'Mitchell', 'MD001234', 'Cardiology', 1, '555-1001', 'james.mitchell@hospital.com', '2015-06-15', 15, TRUE),
('Sarah', 'Chen', 'MD001235', 'Neurology', 2, '555-1002', 'sarah.chen@hospital.com', '2018-08-20', 12, TRUE),
('Michael', 'Kumar', 'MD001236', 'Orthopedics', 3, '555-1003', 'michael.kumar@hospital.com', '2012-03-10', 18, TRUE),
('Emma', 'Rodriguez', 'MD001237', 'Pediatrics', 4, '555-1004', 'emma.rodriguez@hospital.com', '2019-09-05', 10, TRUE),
('David', 'Thompson', 'MD001238', 'Oncology', 5, '555-1005', 'david.thompson@hospital.com', '2014-01-22', 16, TRUE),
('Lisa', 'Anderson', 'MD001239', 'Emergency Medicine', 6, '555-1006', 'lisa.anderson@hospital.com', '2016-07-18', 14, TRUE),
('Robert', 'Wilson', 'MD001240', 'Psychiatry', 7, '555-1007', 'robert.wilson@hospital.com', '2017-11-12', 13, TRUE),
('Jennifer', 'Lee', 'MD001241', 'General Surgery', 8, '555-1008', 'jennifer.lee@hospital.com', '2013-05-08', 17, TRUE),
('Christopher', 'Brown', 'MD001242', 'Dermatology', 9, '555-1009', 'christopher.brown@hospital.com', '2020-02-14', 9, TRUE),
('Patricia', 'Martinez', 'MD001243', 'Gastroenterology', 10, '555-1010', 'patricia.martinez@hospital.com', '2015-09-30', 15, TRUE),
('William', 'Johnson', 'MD001244', 'Cardiology', 1, '555-1011', 'william.johnson@hospital.com', '2018-04-12', 12, TRUE),
('Angela', 'Davis', 'MD001245', 'Neurology', 2, '555-1012', 'angela.davis@hospital.com', '2019-08-25', 11, TRUE);

-- ============================================================================
-- 3. INSERT PATIENTS (Lookup Table)
-- ============================================================================

INSERT INTO patients (first_name, last_name, date_of_birth, gender, blood_type, phone_number, email, street_address, city, state_province, postal_code, country, insurance_provider, insurance_policy_number, emergency_contact_name, emergency_contact_phone, registration_date, is_active) VALUES
('John', 'Anderson', '1965-03-15', 'M', 'O+', '555-2001', 'john.anderson@email.com', '123 Oak Street', 'Springfield', 'Illinois', '62701', 'USA', 'Blue Cross', 'BC123456789', 'Mary Anderson', '555-2100', '2022-01-10', TRUE),
('Mary', 'Johnson', '1972-07-22', 'F', 'A+', '555-2002', 'mary.johnson@email.com', '456 Maple Avenue', 'Portland', 'Oregon', '97201', 'USA', 'Aetna', 'AET987654321', 'Robert Johnson', '555-2101', '2021-06-05', TRUE),
('Robert', 'Williams', '1958-11-08', 'M', 'B+', '555-2003', 'robert.williams@email.com', '789 Pine Road', 'Denver', 'Colorado', '80202', 'USA', 'United Health', 'UHC456789012', 'Susan Williams', '555-2102', '2020-03-20', TRUE),
('Patricia', 'Brown', '1980-05-12', 'F', 'AB-', '555-2004', 'patricia.brown@email.com', '321 Elm Court', 'Austin', 'Texas', '78701', 'USA', 'Cigna', 'CIG234567890', 'James Brown', '555-2103', '2023-02-14', TRUE),
('Michael', 'Garcia', '1975-09-25', 'M', 'O-', '555-2005', 'michael.garcia@email.com', '654 Birch Lane', 'Houston', 'Texas', '77002', 'USA', 'Medicare', 'MED567890123', 'Carmen Garcia', '555-2104', '2019-08-18', TRUE),
('Jennifer', 'Martinez', '1988-02-03', 'F', 'A-', '555-2006', 'jennifer.martinez@email.com', '987 Cedar Street', 'Phoenix', 'Arizona', '85001', 'USA', 'Humana', 'HUM123123123', 'Carlos Martinez', '555-2105', '2022-10-25', TRUE),
('David', 'Rodriguez', '1970-04-17', 'M', 'B-', '555-2007', 'david.rodriguez@email.com', '147 Spruce Drive', 'Philadelphia', 'Pennsylvania', '19101', 'USA', 'Blue Cross', 'BC789789789', 'Isabella Rodriguez', '555-2106', '2021-05-12', TRUE),
('Susan', 'Lee', '1965-10-30', 'F', 'O+', '555-2008', 'susan.lee@email.com', '258 Oak Circle', 'San Antonio', 'Texas', '78201', 'USA', 'Aetna', 'AET456456456', 'Daniel Lee', '555-2107', '2020-11-08', TRUE),
('James', 'Taylor', '1955-12-20', 'M', 'AB+', '555-2009', 'james.taylor@email.com', '369 Maple Place', 'San Diego', 'California', '92101', 'USA', 'United Health', 'UHC321321321', 'Elizabeth Taylor', '555-2108', '2019-09-03', TRUE),
('Jessica', 'Thomas', '1992-06-14', 'F', 'A+', '555-2010', 'jessica.thomas@email.com', '741 Pine Terrace', 'Dallas', 'Texas', '75201', 'USA', 'Cigna', 'CIG654654654', 'George Thomas', '555-2109', '2023-04-22', TRUE),
('Christopher', 'White', '1968-08-05', 'M', 'O-', '555-2011', 'christopher.white@email.com', '852 Elm Path', 'San Jose', 'California', '95101', 'USA', 'Medicare', 'MED111222333', 'Anne White', '555-2110', '2018-07-14', TRUE),
('Lauren', 'Harris', '1985-01-28', 'F', 'B+', '555-2012', 'lauren.harris@email.com', '963 Birch Walk', 'Austin', 'Texas', '78702', 'USA', 'Humana', 'HUM999888777', 'Thomas Harris', '555-2111', '2022-12-01', TRUE),
('Daniel', 'Clark', '1972-11-19', 'M', 'AB-', '555-2013', 'daniel.clark@email.com', '159 Cedar Boulevard', 'Jacksonville', 'Florida', '32099', 'USA', 'Blue Cross', 'BC111111111', 'Victoria Clark', '555-2112', '2021-03-15', TRUE),
('Lisa', 'Lewis', '1978-03-09', 'F', 'O+', '555-2014', 'lisa.lewis@email.com', '258 Spruce Way', 'Fort Worth', 'Texas', '76102', 'USA', 'Aetna', 'AET222222222', 'Paul Lewis', '555-2113', '2020-08-27', TRUE),
('Mark', 'Walker', '1960-07-12', 'M', 'A-', '555-2015', 'mark.walker@email.com', '357 Oak Street', 'Columbus', 'Ohio', '43085', 'USA', 'United Health', 'UHC777777777', 'Nancy Walker', '555-2114', '2019-02-10', TRUE);

-- ============================================================================
-- 4. INSERT DIAGNOSES (Lookup Table)
-- ============================================================================

INSERT INTO diagnoses (icd_code, diagnosis_name, diagnosis_category, severity_level, description, is_chronic) VALUES
('I10', 'Essential Hypertension', 'Cardiovascular', 'Moderate', 'High blood pressure condition requiring management', TRUE),
('E11', 'Type 2 Diabetes Mellitus', 'Endocrine', 'High', 'Chronic metabolic disorder affecting blood glucose levels', TRUE),
('J44.9', 'COPD (Chronic Obstructive Pulmonary Disease)', 'Respiratory', 'High', 'Progressive airway obstruction disease', TRUE),
('F32.9', 'Major Depressive Disorder', 'Psychiatric', 'Moderate', 'Persistent low mood affecting daily functioning', TRUE),
('M79.3', 'Myalgia and Myositis', 'Musculoskeletal', 'Low', 'Muscle pain and inflammation', FALSE),
('N18.3', 'Chronic Kidney Disease Stage 3', 'Renal', 'Moderate', 'Reduced kidney function requiring monitoring', TRUE),
('K21.9', 'GERD (Gastroesophageal Reflux Disease)', 'Gastrointestinal', 'Moderate', 'Acid reflux causing esophageal irritation', TRUE),
('C34.9', 'Malignant Neoplasm of Lung', 'Oncology', 'Critical', 'Primary lung cancer requiring aggressive treatment', TRUE),
('G89.29', 'Chronic pain syndrome', 'Pain', 'Moderate', 'Persistent pain beyond tissue healing', TRUE),
('I21.9', 'Acute Myocardial Infarction', 'Cardiovascular', 'Critical', 'Heart attack requiring emergency intervention', FALSE),
('F10.229', 'Alcohol Use Disorder with Intoxication', 'Psychiatric', 'High', 'Chronic alcohol dependence with acute intoxication', TRUE),
('K70.30', 'Cirrhosis of Liver', 'Hepatic', 'High', 'Advanced liver disease', TRUE);

-- ============================================================================
-- 5. INSERT MEDICATIONS (Lookup Table)
-- ============================================================================

INSERT INTO medications (medication_name, generic_name, ndc_code, dosage_strength, dosage_form, route_of_administration, common_side_effects, contraindications, manufacturer, is_available) VALUES
('Lisinopril', 'Lisinopril', '0172-2085-60', '10mg', 'Tablet', 'Oral', 'Dizziness, Fatigue, Dry cough', 'Pregnancy, ACE inhibitor allergy', 'Cipla', TRUE),
('Metformin', 'Metformin HCl', '0228-2757-56', '500mg', 'Tablet', 'Oral', 'Nausea, Diarrhea, Headache', 'Kidney disease, Liver disease', 'Teva', TRUE),
('Atorvastatin', 'Atorvastatin', '0071-1040-31', '20mg', 'Tablet', 'Oral', 'Muscle pain, Liver enzyme elevation', 'Liver disease, Simvastatin interaction', 'Pfizer', TRUE),
('Omeprazole', 'Omeprazole', '0054-8648-25', '20mg', 'Capsule', 'Oral', 'Headache, Abdominal pain, Nausea', 'Clopidogrel interaction', 'AstraZeneca', TRUE),
('Sertraline', 'Sertraline HCl', '0045-0508-60', '50mg', 'Tablet', 'Oral', 'Nausea, Insomnia, Sexual dysfunction', 'MAOI use, Pimozide use', 'Pfizer', TRUE),
('Metoprolol', 'Metoprolol Tartrate', '0093-0847-60', '50mg', 'Tablet', 'Oral', 'Fatigue, Bradycardia, Dizziness', 'Cardiogenic shock, Heart block', 'Novartis', TRUE),
('Amoxicillin', 'Amoxicillin', '0093-2264-56', '500mg', 'Capsule', 'Oral', 'Diarrhea, Rash, Nausea', 'Penicillin allergy', 'GlaxoSmithKline', TRUE),
('Ibuprofen', 'Ibuprofen', '0143-9841-16', '200mg', 'Tablet', 'Oral', 'Stomach upset, Heartburn, GI bleeding', 'NSAID allergy, Active ulcer', 'Johnson & Johnson', TRUE),
('Ciprofloxacin', 'Ciprofloxacin', '0006-3599-54', '500mg', 'Tablet', 'Oral', 'Nausea, Diarrhea, Tendinitis risk', 'Quinolone allergy, Myasthenia gravis', 'Bayer', TRUE),
('Insulin Glargine', 'Insulin Glargine', '0088-1188-14', '100 units/mL', 'Injectable Solution', 'Subcutaneous', 'Hypoglycemia, Injection site reaction', 'Hypoglycemia episode', 'Sanofi', TRUE),
('Losartan', 'Losartan Potassium', '0054-2900-30', '50mg', 'Tablet', 'Oral', 'Dizziness, Kidney dysfunction', 'Pregnancy, Potassium supplements', 'Merck', TRUE),
('Amlodipine', 'Amlodipine Besylate', '0069-2730-41', '5mg', 'Tablet', 'Oral', 'Edema, Headache, Fatigue', 'Cardiogenic shock', 'Pfizer', TRUE);

-- ============================================================================
-- 6. INSERT DENORMALIZED PATIENT ENCOUNTERS (Main Table with Fake Data)
-- ============================================================================

INSERT INTO denormalized_patient_encounters (
    fk_patient_id, fk_doctor_id, fk_department_id, fk_diagnosis_id, fk_medication_id,
    patient_first_name, patient_last_name, patient_date_of_birth, patient_age, patient_gender, patient_blood_type,
    patient_phone, patient_email, patient_street_address, patient_city, patient_state, patient_postal_code, patient_country,
    patient_insurance_provider, patient_insurance_policy_number, patient_emergency_contact_name, patient_emergency_contact_phone,
    patient_registration_date,
    doctor_first_name, doctor_last_name, doctor_license_number, doctor_specialization, doctor_phone, doctor_email,
    doctor_hire_date, doctor_years_experience,
    department_name, department_code, department_floor, department_phone, department_head,
    diagnosis_icd_code, diagnosis_name, diagnosis_category, diagnosis_severity, diagnosis_description, is_chronic_diagnosis,
    medication_name, medication_generic_name, medication_dosage_strength, medication_dosage_form, medication_route,
    medication_side_effects, medication_contraindications, medication_manufacturer,
    encounter_date, encounter_time, encounter_type, encounter_duration_minutes, chief_complaint,
    vital_signs_temperature, vital_signs_blood_pressure, vital_signs_heart_rate, vital_signs_respiratory_rate,
    clinical_notes, treatment_plan, prescribed_quantity, prescribed_frequency, prescription_duration_days,
    follow_up_date, follow_up_required, billingBillable_amount, billing_status,
    created_by, last_modified_by
) VALUES
(1, 1, 1, 1, 1,
    'John', 'Anderson', '1965-03-15', 59, 'M', 'O+',
    '555-2001', 'john.anderson@email.com', '123 Oak Street', 'Springfield', 'Illinois', '62701', 'USA',
    'Blue Cross', 'BC123456789', 'Mary Anderson', '555-2100', '2022-01-10',
    'James', 'Mitchell', 'MD001234', 'Cardiology', '555-1001', 'james.mitchell@hospital.com',
    '2015-06-15', 15,
    'Cardiology', 'CARD', 2, '555-0101', 'Dr. James Mitchell',
    'I10', 'Essential Hypertension', 'Cardiovascular', 'Moderate', 'High blood pressure condition requiring management', TRUE,
    'Lisinopril', 'Lisinopril', '10mg', 'Tablet', 'Oral',
    'Dizziness, Fatigue, Dry cough', 'Pregnancy, ACE inhibitor allergy', 'Cipla',
    '2024-01-15', '09:30:00', 'Routine Checkup', 30, 'Blood pressure monitoring and medication review',
    '98.6', '155/95', 78, 16,
    'Patient presents with hypertension well controlled on current medication. BP reading slightly elevated today.',
    'Continue Lisinopril 10mg daily. Reduce sodium intake. Follow up in 3 months.',
    90, 'Once daily', 90,
    '2024-04-15', TRUE, 250.00, 'Paid',
    'Dr. James Mitchell', 'Dr. James Mitchell'),

(2, 2, 2, 4, 5,
    'Mary', 'Johnson', '1972-07-22', 52, 'F', 'A+',
    '555-2002', 'mary.johnson@email.com', '456 Maple Avenue', 'Portland', 'Oregon', '97201', 'USA',
    'Aetna', 'AET987654321', 'Robert Johnson', '555-2101', '2021-06-05',
    'Sarah', 'Chen', 'MD001235', 'Neurology', '555-1002', 'sarah.chen@hospital.com',
    '2018-08-20', 12,
    'Neurology', 'NEURO', 3, '555-0102', 'Dr. Sarah Chen',
    'F32.9', 'Major Depressive Disorder', 'Psychiatric', 'Moderate', 'Persistent low mood affecting daily functioning', TRUE,
    'Sertraline', 'Sertraline HCl', '50mg', 'Tablet', 'Oral',
    'Nausea, Insomnia, Sexual dysfunction', 'MAOI use, Pimozide use', 'Pfizer',
    '2024-01-20', '10:15:00', 'Psychiatric Evaluation', 45, 'Follow-up for depression management',
    '98.8', '120/80', 72, 15,
    'Patient reports improved mood on current medication. No suicidal ideation. Sleep still slightly disrupted.',
    'Continue Sertraline 50mg daily. Consider cognitive behavioral therapy. Follow-up in 2 months.',
    60, 'Once daily', 60,
    '2024-03-20', TRUE, 300.00, 'Pending',
    'Dr. Sarah Chen', 'Dr. Sarah Chen'),

(3, 3, 3, 5, 8,
    'Robert', 'Williams', '1958-11-08', 65, 'M', 'B+',
    '555-2003', 'robert.williams@email.com', '789 Pine Road', 'Denver', 'Colorado', '80202', 'USA',
    'United Health', 'UHC456789012', 'Susan Williams', '555-2102', '2020-03-20',
    'Michael', 'Kumar', 'MD001236', 'Orthopedics', '555-1003', 'michael.kumar@hospital.com',
    '2012-03-10', 18,
    'Orthopedics', 'ORTHO', 1, '555-0103', 'Dr. Michael Kumar',
    'M79.3', 'Myalgia and Myositis', 'Musculoskeletal', 'Low', 'Muscle pain and inflammation', FALSE,
    'Ibuprofen', 'Ibuprofen', '200mg', 'Tablet', 'Oral',
    'Stomach upset, Heartburn, GI bleeding', 'NSAID allergy, Active ulcer', 'Johnson & Johnson',
    '2024-01-25', '14:00:00', 'Physical Examination', 25, 'Right shoulder pain and muscle strain',
    '98.7', '130/82', 75, 17,
    'Patient presents with myalgia in right shoulder. Limited range of motion. No signs of fracture on palpation.',
    'Prescribe Ibuprofen 200mg for pain management. Physical therapy recommended. Rest and ice for 48 hours.',
    30, 'Three times daily with food', 14,
    '2024-02-08', TRUE, 180.50, 'Paid',
    'Dr. Michael Kumar', 'Dr. Michael Kumar'),

(4, 4, 4, 5, 7,
    'Patricia', 'Brown', '1980-05-12', 44, 'F', 'AB-',
    '555-2004', 'patricia.brown@email.com', '321 Elm Court', 'Austin', 'Texas', '78701', 'USA',
    'Cigna', 'CIG234567890', 'James Brown', '555-2103', '2023-02-14',
    'Emma', 'Rodriguez', 'MD001237', 'Pediatrics', '555-1004', 'emma.rodriguez@hospital.com',
    '2019-09-05', 10,
    'Pediatrics', 'PEDS', 4, '555-0104', 'Dr. Emma Rodriguez',
    'M79.3', 'Myalgia and Myositis', 'Musculoskeletal', 'Low', 'Muscle pain and inflammation', FALSE,
    'Amoxicillin', 'Amoxicillin', '500mg', 'Capsule', 'Oral',
    'Diarrhea, Rash, Nausea', 'Penicillin allergy', 'GlaxoSmithKline',
    '2024-02-01', '11:00:00', 'Consultation', 35, 'Suspected upper respiratory infection',
    '99.1', '118/76', 80, 18,
    'Patient with fever and mild cough for 2 days. Throat slightly inflamed. No signs of pneumonia.',
    'Prescribe Amoxicillin for bacterial infection. Supportive care. Recheck if symptoms persist after 5 days.',
    20, 'Three times daily', 10,
    '2024-02-15', FALSE, 210.00, 'Paid',
    'Dr. Emma Rodriguez', 'Dr. Emma Rodriguez'),

(5, 5, 5, 8, 10,
    'Michael', 'Garcia', '1975-09-25', 48, 'M', 'O-',
    '555-2005', 'michael.garcia@email.com', '654 Birch Lane', 'Houston', 'Texas', '77002', 'USA',
    'Medicare', 'MED567890123', 'Carmen Garcia', '555-2104', '2019-08-18',
    'David', 'Thompson', 'MD001238', 'Oncology', '555-1005', 'david.thompson@hospital.com',
    '2014-01-22', 16,
    'Oncology', 'ONCO', 5, '555-0105', 'Dr. David Thompson',
    'C34.9', 'Malignant Neoplasm of Lung', 'Oncology', 'Critical', 'Primary lung cancer requiring aggressive treatment', TRUE,
    'Insulin Glargine', 'Insulin Glargine', '100 units/mL', 'Injectable Solution', 'Subcutaneous',
    'Hypoglycemia, Injection site reaction', 'Hypoglycemia episode', 'Sanofi',
    '2024-02-05', '15:30:00', 'Chemotherapy Session', 120, 'Third cycle of lung cancer chemotherapy',
    '98.5', '128/84', 82, 19,
    'Patient tolerating chemotherapy well. No significant side effects. Tumor markers showing improvement.',
    'Continue chemotherapy protocol. Monitor blood counts. Supportive care for nausea and fatigue.',
    1, 'As prescribed by oncology', 28,
    '2024-02-26', TRUE, 1500.00, 'Paid',
    'Dr. David Thompson', 'Dr. David Thompson'),

(6, 6, 6, 10, 3,
    'Jennifer', 'Martinez', '1988-02-03', 36, 'F', 'A-',
    '555-2006', 'jennifer.martinez@email.com', '987 Cedar Street', 'Phoenix', 'Arizona', '85001', 'USA',
    'Humana', 'HUM123123123', 'Carlos Martinez', '555-2105', '2022-10-25',
    'Lisa', 'Anderson', 'MD001239', 'Emergency Medicine', '555-1006', 'lisa.anderson@hospital.com',
    '2016-07-18', 14,
    'Emergency Medicine', 'ER', 1, '555-0106', 'Dr. Lisa Anderson',
    'I21.9', 'Acute Myocardial Infarction', 'Cardiovascular', 'Critical', 'Heart attack requiring emergency intervention', FALSE,
    'Atorvastatin', 'Atorvastatin', '20mg', 'Tablet', 'Oral',
    'Muscle pain, Liver enzyme elevation', 'Liver disease, Simvastatin interaction', 'Pfizer',
    '2024-02-10', '19:45:00', 'Emergency Admission', 180, 'Chest pain with EKG changes consistent with MI',
    '99.2', '142/92', 105, 22,
    'Patient presented to ER with acute chest pain radiating to left arm. EKG shows ST elevation. Troponin elevated.',
    'Admit to ICU for cardiac monitoring. Initiate dual antiplatelet therapy and statin. Consider angiography.',
    30, 'Once daily (long-term)', 365,
    '2024-04-10', TRUE, 5000.00, 'Pending',
    'Dr. Lisa Anderson', 'Dr. Lisa Anderson'),

(7, 7, 7, 4, 5,
    'David', 'Rodriguez', '1970-04-17', 54, 'M', 'B-',
    '555-2007', 'david.rodriguez@email.com', '147 Spruce Drive', 'Philadelphia', 'Pennsylvania', '19101', 'USA',
    'Blue Cross', 'BC789789789', 'Isabella Rodriguez', '555-2106', '2021-05-12',
    'Robert', 'Wilson', 'MD001240', 'Psychiatry', '555-1007', 'robert.wilson@hospital.com',
    '2017-11-12', 13,
    'Psychiatry', 'PSYCH', 6, '555-0107', 'Dr. Robert Wilson',
    'F32.9', 'Major Depressive Disorder', 'Psychiatric', 'Moderate', 'Persistent low mood affecting daily functioning', TRUE,
    'Sertraline', 'Sertraline HCl', '50mg', 'Tablet', 'Oral',
    'Nausea, Insomnia, Sexual dysfunction', 'MAOI use, Pimozide use', 'Pfizer',
    '2024-02-12', '13:20:00', 'Psychiatric Session', 50, 'Ongoing depression management and therapy',
    '98.9', '122/81', 76, 16,
    'Patient reports good response to medication. Mood improved. Still experiencing some anhedonia.',
    'Continue Sertraline. Increase psychotherapy frequency to twice monthly. Discuss lifestyle modifications.',
    60, 'Once daily', 90,
    '2024-05-12', TRUE, 400.00, 'Paid',
    'Dr. Robert Wilson', 'Dr. Robert Wilson'),

(8, 8, 8, 5, 9,
    'Susan', 'Lee', '1965-10-30', 59, 'F', 'O+',
    '555-2008', 'susan.lee@email.com', '258 Oak Circle', 'San Antonio', 'Texas', '78201', 'USA',
    'Aetna', 'AET456456456', 'Daniel Lee', '555-2107', '2020-11-08',
    'Jennifer', 'Lee', 'MD001241', 'General Surgery', '555-1008', 'jennifer.lee@hospital.com',
    '2013-05-08', 17,
    'General Surgery', 'SURGERY', 2, '555-0108', 'Dr. Jennifer Lee',
    'M79.3', 'Myalgia and Myositis', 'Musculoskeletal', 'Low', 'Muscle pain and inflammation', FALSE,
    'Ciprofloxacin', 'Ciprofloxacin', '500mg', 'Tablet', 'Oral',
    'Nausea, Diarrhea, Tendinitis risk', 'Quinolone allergy, Myasthenia gravis', 'Bayer',
    '2024-02-18', '10:00:00', 'Post-Operative Checkup', 40, 'Follow-up after appendectomy',
    '98.4', '125/79', 71, 14,
    'Surgical wound healing well. No signs of infection. Patient reports minimal pain at this visit.',
    'Continue antibiotic course to completion. Wound care instructions provided. Light activity only for 2 weeks.',
    30, 'Twice daily', 10,
    '2024-03-04', FALSE, 350.00, 'Paid',
    'Dr. Jennifer Lee', 'Dr. Jennifer Lee'),

(9, 9, 9, 5, 2,
    'James', 'Taylor', '1955-12-20', 68, 'M', 'AB+',
    '555-2009', 'james.taylor@email.com', '369 Maple Place', 'San Diego', 'California', '92101', 'USA',
    'United Health', 'UHC321321321', 'Elizabeth Taylor', '555-2108', '2019-09-03',
    'Christopher', 'Brown', 'MD001242', 'Dermatology', '555-1009', 'christopher.brown@hospital.com',
    '2020-02-14', 9,
    'Dermatology', 'DERM', 3, '555-0109', 'Dr. Christopher Brown',
    'M79.3', 'Myalgia and Myositis', 'Musculoskeletal', 'Low', 'Muscle pain and inflammation', FALSE,
    'Metformin', 'Metformin HCl', '500mg', 'Tablet', 'Oral',
    'Nausea, Diarrhea, Headache', 'Kidney disease, Liver disease', 'Teva',
    '2024-02-22', '09:30:00', 'Dermatology Consultation', 30, 'Skin lesion evaluation and biopsy',
    '98.6', '128/83', 74, 15,
    'Patient with new skin lesion on back. Biopsy performed for pathology report. Lesion appears benign clinically.',
    'Await biopsy results. Avoid sun exposure to affected area. Return in 1 week for results review.',
    60, 'Twice daily with meals', 30,
    '2024-03-01', TRUE, 275.00, 'Paid',
    'Dr. Christopher Brown', 'Dr. Christopher Brown'),

(10, 10, 10, 7, 4,
    'Jessica', 'Thomas', '1992-06-14', 32, 'F', 'A+',
    '555-2010', 'jessica.thomas@email.com', '741 Pine Terrace', 'Dallas', 'Texas', '75201', 'USA',
    'Cigna', 'CIG654654654', 'George Thomas', '555-2109', '2023-04-22',
    'Patricia', 'Martinez', 'MD001243', 'Gastroenterology', '555-1010', 'patricia.martinez@hospital.com',
    '2015-09-30', 15,
    'Gastroenterology', 'GI', 4, '555-0110', 'Dr. Patricia Martinez',
    'K21.9', 'GERD (Gastroesophageal Reflux Disease)', 'Gastrointestinal', 'Moderate', 'Acid reflux causing esophageal irritation', TRUE,
    'Omeprazole', 'Omeprazole', '20mg', 'Capsule', 'Oral',
    'Headache, Abdominal pain, Nausea', 'Clopidogrel interaction', 'AstraZeneca',
    '2024-02-28', '14:30:00', 'Upper Endoscopy', 60, 'Evaluation of chronic reflux symptoms',
    '98.7', '123/80', 73, 16,
    'Endoscopy shows moderate gastritis but no Barrett esophagus or ulceration. No malignancy noted.',
    'Increase Omeprazole to 40mg daily. Lifestyle modifications: avoid spicy foods, elevate bed head.',
    60, 'Once daily', 90,
    '2024-05-28', TRUE, 450.00, 'Paid',
    'Dr. Patricia Martinez', 'Dr. Patricia Martinez'),

(11, 1, 1, 1, 1,
    'Christopher', 'White', '1968-08-05', 56, 'M', 'O-',
    '555-2011', 'christopher.white@email.com', '852 Elm Path', 'San Jose', 'California', '95101', 'USA',
    'Medicare', 'MED111222333', 'Anne White', '555-2110', '2018-07-14',
    'James', 'Mitchell', 'MD001234', 'Cardiology', '555-1001', 'james.mitchell@hospital.com',
    '2015-06-15', 15,
    'Cardiology', 'CARD', 2, '555-0101', 'Dr. James Mitchell',
    'I10', 'Essential Hypertension', 'Cardiovascular', 'Moderate', 'High blood pressure condition requiring management', TRUE,
    'Lisinopril', 'Lisinopril', '10mg', 'Tablet', 'Oral',
    'Dizziness, Fatigue, Dry cough', 'Pregnancy, ACE inhibitor allergy', 'Cipla',
    '2024-03-05', '08:45:00', 'Routine Checkup', 30, 'Blood pressure management follow-up',
    '98.5', '148/92', 77, 16,
    'BP reading elevated despite medication. Patient admits to occasional medication non-compliance.',
    'Adjust Lisinopril to 20mg. Counsel on medication adherence. Dietary sodium restriction reinforced.',
    90, 'Once daily', 90,
    '2024-06-05', TRUE, 250.00, 'Paid',
    'Dr. James Mitchell', 'Dr. James Mitchell'),

(12, 2, 2, 4, 5,
    'Lauren', 'Harris', '1985-01-28', 39, 'F', 'B+',
    '555-2012', 'lauren.harris@email.com', '963 Birch Walk', 'Austin', 'Texas', '78702', 'USA',
    'Humana', 'HUM999888777', 'Thomas Harris', '555-2111', '2022-12-01',
    'Sarah', 'Chen', 'MD001235', 'Neurology', '555-1002', 'sarah.chen@hospital.com',
    '2018-08-20', 12,
    'Neurology', 'NEURO', 3, '555-0102', 'Dr. Sarah Chen',
    'F32.9', 'Major Depressive Disorder', 'Psychiatric', 'Moderate', 'Persistent low mood affecting daily functioning', TRUE,
    'Sertraline', 'Sertraline HCl', '50mg', 'Tablet', 'Oral',
    'Nausea, Insomnia, Sexual dysfunction', 'MAOI use, Pimozide use', 'Pfizer',
    '2024-03-10', '11:00:00', 'Neuropsychiatry Consultation', 50, 'Evaluation for treatment-resistant depression',
    '98.8', '119/79', 71, 15,
    'Patient currently on Sertraline 50mg with partial response. Considering medication augmentation strategy.',
    'Trial of bupropion augmentation. Continue psychotherapy. Recheck in 6 weeks.',
    30, 'Once daily', 60,
    '2024-04-24', TRUE, 350.00, 'Paid',
    'Dr. Sarah Chen', 'Dr. Sarah Chen'),

(13, 11, 1, 2, 2,
    'Daniel', 'Clark', '1972-11-19', 51, 'M', 'AB-',
    '555-2013', 'daniel.clark@email.com', '159 Cedar Boulevard', 'Jacksonville', 'Florida', '32099', 'USA',
    'Blue Cross', 'BC111111111', 'Victoria Clark', '555-2112', '2021-03-15',
    'William', 'Johnson', 'MD001244', 'Cardiology', '555-1011', 'william.johnson@hospital.com',
    '2018-04-12', 12,
    'Cardiology', 'CARD', 2, '555-0101', 'Dr. James Mitchell',
    'E11', 'Type 2 Diabetes Mellitus', 'Endocrine', 'High', 'Chronic metabolic disorder affecting blood glucose levels', TRUE,
    'Metformin', 'Metformin HCl', '500mg', 'Tablet', 'Oral',
    'Nausea, Diarrhea, Headache', 'Kidney disease, Liver disease', 'Teva',
    '2024-03-15', '09:00:00', 'Endocrinology Consultation', 40, 'Diabetes management and HbA1c review',
    '98.6', '132/85', 79, 17,
    'Latest HbA1c 7.2%. Patient reports good compliance with diet and exercise. Fasting glucose 156 mg/dL.',
    'Continue Metformin 500mg twice daily. Consider adding second agent if next HbA1c remains above 7%.',
    90, 'Twice daily with meals', 90,
    '2024-06-15', TRUE, 300.00, 'Paid',
    'Dr. William Johnson', 'Dr. William Johnson'),

(14, 12, 2, 3, 9,
    'Lisa', 'Lewis', '1978-03-09', 46, 'F', 'O+',
    '555-2014', 'lisa.lewis@email.com', '258 Spruce Way', 'Fort Worth', 'Texas', '76102', 'USA',
    'Aetna', 'AET222222222', 'Paul Lewis', '555-2113', '2020-08-27',
    'Angela', 'Davis', 'MD001245', 'Neurology', '555-1012', 'angela.davis@hospital.com',
    '2019-08-25', 11,
    'Neurology', 'NEURO', 3, '555-0102', 'Dr. Sarah Chen',
    'J44.9', 'COPD (Chronic Obstructive Pulmonary Disease)', 'Respiratory', 'High', 'Progressive airway obstruction disease', TRUE,
    'Ciprofloxacin', 'Ciprofloxacin', '500mg', 'Tablet', 'Oral',
    'Nausea, Diarrhea, Tendinitis risk', 'Quinolone allergy, Myasthenia gravis', 'Bayer',
    '2024-03-20', '15:00:00', 'Pulmonary Function Test', 60, 'COPD assessment and respiratory therapy',
    '98.7', '125/81', 74, 18,
    'FEV1/FVC ratio indicates moderate airflow obstruction. Patient completing pulmonary rehabilitation program.',
    'Continue current bronchodilator therapy. Influenza and pneumococcal vaccines administered. Smoking cessation counseling.',
    30, 'Twice daily', 30,
    '2024-04-20', TRUE, 400.00, 'Paid',
    'Dr. Angela Davis', 'Dr. Angela Davis'),

(15, 3, 3, 6, 11,
    'Mark', 'Walker', '1960-07-12', 64, 'M', 'A-',
    '555-2015', 'mark.walker@email.com', '357 Oak Street', 'Columbus', 'Ohio', '43085', 'USA',
    'United Health', 'UHC777777777', 'Nancy Walker', '555-2114', '2019-02-10',
    'Michael', 'Kumar', 'MD001236', 'Orthopedics', '555-1003', 'michael.kumar@hospital.com',
    '2012-03-10', 18,
    'Orthopedics', 'ORTHO', 1, '555-0103', 'Dr. Michael Kumar',
    'N18.3', 'Chronic Kidney Disease Stage 3', 'Renal', 'Moderate', 'Reduced kidney function requiring monitoring', TRUE,
    'Losartan', 'Losartan Potassium', '50mg', 'Tablet', 'Oral',
    'Dizziness, Kidney dysfunction', 'Pregnancy, Potassium supplements', 'Merck',
    '2024-03-25', '10:30:00', 'Nephrology Follow-up', 35, 'Chronic kidney disease monitoring',
    '98.4', '130/82', 72, 15,
    'eGFR 45 mL/min/1.73m2. Creatinine stable. Proteinuria minimal. Patient counseled on renal-protective diet.',
    'Continue Losartan. Renal function panel every 3 months. Nephrology referral confirmed for March 2025.',
    90, 'Once daily', 90,
    '2024-06-25', TRUE, 280.00, 'Paid',
    'Dr. Michael Kumar', 'Dr. Michael Kumar');

-- ============================================================================
-- SUMMARY STATISTICS
-- ============================================================================
/*
Total Encounters Inserted: 15 denormalized patient records
Total Attributes per Record: 68 columns
Denormalization Breakdown:
  - Patient Attributes: 18
  - Doctor Attributes: 8
  - Department Attributes: 5
  - Diagnosis Attributes: 6
  - Medication Attributes: 8
  - Encounter/Transaction Attributes: 14
  - Audit/System Fields: 4
  - Foreign Keys: 5

Lookup Tables Populated:
  - Departments: 10 records
  - Doctors: 12 records
  - Patients: 15 records
  - Diagnoses: 12 records
  - Medications: 12 records

Database is ready for testing, analysis, and demonstration of
denormalization patterns and PK-FK relationships.
*/
