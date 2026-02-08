"""
Healthcare Data Generator
Generates ~500 records of fake healthcare data for all tables
"""

from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker()
Faker.seed(42)
random.seed(42)

# ============================================================================
# CONFIGURATION
# ============================================================================
NUM_DEPARTMENTS = 10  # Keep existing
NUM_DOCTORS = 50
NUM_PATIENTS = 200
NUM_DIAGNOSES = 20
NUM_MEDICATIONS = 30
NUM_ENCOUNTERS = 500

# ============================================================================
# REFERENCE DATA
# ============================================================================

SPECIALIZATIONS = [
    'Cardiology', 'Neurology', 'Orthopedics', 'Pediatrics', 'Oncology',
    'Emergency Medicine', 'Psychiatry', 'General Surgery', 'Dermatology',
    'Gastroenterology', 'Endocrinology', 'Pulmonology', 'Nephrology',
    'Urology', 'Obstetrics', 'Ophthalmology', 'ENT', 'Radiology'
]

BLOOD_TYPES = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']

ENCOUNTER_TYPES = [
    'Routine Checkup', 'Consultation', 'Emergency Admission', 'Follow-up Visit',
    'Physical Examination', 'Surgical Procedure', 'Diagnostic Test',
    'Vaccination', 'Psychiatric Evaluation', 'Post-Operative Checkup'
]

BILLING_STATUSES = ['Paid', 'Pending', 'Insurance Processing', 'Outstanding']

INSURANCE_PROVIDERS = [
    'Blue Cross', 'Aetna', 'United Health', 'Cigna', 'Humana',
    'Medicare', 'Medicaid', 'Kaiser Permanente'
]

# ICD-10 Codes and Diagnoses
DIAGNOSES_DATA = [
    ('I10', 'Essential Hypertension', 'Cardiovascular', 'Moderate', True),
    ('E11', 'Type 2 Diabetes Mellitus', 'Endocrine', 'High', True),
    ('J44.9', 'COPD', 'Respiratory', 'High', True),
    ('F32.9', 'Major Depressive Disorder', 'Psychiatric', 'Moderate', True),
    ('M79.3', 'Myalgia and Myositis', 'Musculoskeletal', 'Low', False),
    ('N18.3', 'Chronic Kidney Disease Stage 3', 'Renal', 'Moderate', True),
    ('K21.9', 'GERD', 'Gastrointestinal', 'Moderate', True),
    ('C34.9', 'Malignant Neoplasm of Lung', 'Oncology', 'Critical', True),
    ('I21.9', 'Acute Myocardial Infarction', 'Cardiovascular', 'Critical', False),
    ('J06.9', 'Upper Respiratory Infection', 'Respiratory', 'Low', False),
    ('M17.9', 'Osteoarthritis of Knee', 'Musculoskeletal', 'Moderate', True),
    ('E78.5', 'Hyperlipidemia', 'Endocrine', 'Moderate', True),
    ('F41.9', 'Anxiety Disorder', 'Psychiatric', 'Moderate', True),
    ('K76.0', 'Fatty Liver', 'Hepatic', 'Moderate', True),
    ('N39.0', 'Urinary Tract Infection', 'Urological', 'Low', False),
    ('L30.9', 'Dermatitis', 'Dermatological', 'Low', False),
    ('H52.4', 'Presbyopia', 'Ophthalmological', 'Low', False),
    ('M54.5', 'Low Back Pain', 'Musculoskeletal', 'Moderate', False),
    ('R51', 'Headache', 'Neurological', 'Low', False),
    ('B34.9', 'Viral Infection', 'Infectious', 'Low', False),
]

# Medication data
MEDICATIONS_DATA = [
    ('Lisinopril', 'Lisinopril', '10mg', 'Tablet', 'Oral'),
    ('Metformin', 'Metformin HCl', '500mg', 'Tablet', 'Oral'),
    ('Atorvastatin', 'Atorvastatin', '20mg', 'Tablet', 'Oral'),
    ('Omeprazole', 'Omeprazole', '20mg', 'Capsule', 'Oral'),
    ('Sertraline', 'Sertraline HCl', '50mg', 'Tablet', 'Oral'),
    ('Metoprolol', 'Metoprolol Tartrate', '50mg', 'Tablet', 'Oral'),
    ('Amoxicillin', 'Amoxicillin', '500mg', 'Capsule', 'Oral'),
    ('Ibuprofen', 'Ibuprofen', '200mg', 'Tablet', 'Oral'),
    ('Ciprofloxacin', 'Ciprofloxacin', '500mg', 'Tablet', 'Oral'),
    ('Insulin Glargine', 'Insulin Glargine', '100 units/mL', 'Injectable', 'Subcutaneous'),
    ('Losartan', 'Losartan Potassium', '50mg', 'Tablet', 'Oral'),
    ('Amlodipine', 'Amlodipine Besylate', '5mg', 'Tablet', 'Oral'),
    ('Levothyroxine', 'Levothyroxine Sodium', '100mcg', 'Tablet', 'Oral'),
    ('Albuterol', 'Albuterol Sulfate', '90mcg', 'Inhaler', 'Inhalation'),
    ('Gabapentin', 'Gabapentin', '300mg', 'Capsule', 'Oral'),
    ('Hydrochlorothiazide', 'Hydrochlorothiazide', '25mg', 'Tablet', 'Oral'),
    ('Prednisone', 'Prednisone', '20mg', 'Tablet', 'Oral'),
    ('Warfarin', 'Warfarin Sodium', '5mg', 'Tablet', 'Oral'),
    ('Clopidogrel', 'Clopidogrel', '75mg', 'Tablet', 'Oral'),
    ('Furosemide', 'Furosemide', '40mg', 'Tablet', 'Oral'),
    ('Aspirin', 'Acetylsalicylic Acid', '81mg', 'Tablet', 'Oral'),
    ('Pantoprazole', 'Pantoprazole', '40mg', 'Tablet', 'Oral'),
    ('Simvastatin', 'Simvastatin', '40mg', 'Tablet', 'Oral'),
    ('Alprazolam', 'Alprazolam', '0.5mg', 'Tablet', 'Oral'),
    ('Tramadol', 'Tramadol HCl', '50mg', 'Tablet', 'Oral'),
    ('Cephalexin', 'Cephalexin', '500mg', 'Capsule', 'Oral'),
    ('Fluoxetine', 'Fluoxetine HCl', '20mg', 'Capsule', 'Oral'),
    ('Montelukast', 'Montelukast Sodium', '10mg', 'Tablet', 'Oral'),
    ('Tamsulosin', 'Tamsulosin HCl', '0.4mg', 'Capsule', 'Oral'),
    ('Ranitidine', 'Ranitidine HCl', '150mg', 'Tablet', 'Oral'),
]

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

def sql_escape(text):
    """Escape single quotes for SQL"""
    if text is None:
        return 'NULL'
    return str(text).replace("'", "''")

def random_date(start_year=2020, end_year=2024):
    """Generate random date"""
    start = datetime(start_year, 1, 1)
    end = datetime(end_year, 12, 31)
    delta = end - start
    random_days = random.randint(0, delta.days)
    return (start + timedelta(days=random_days)).strftime('%Y-%m-%d')

def random_time():
    """Generate random time"""
    hour = random.randint(8, 18)
    minute = random.choice([0, 15, 30, 45])
    return f"{hour:02d}:{minute:02d}:00"

# ============================================================================
# GENERATE SQL INSERTS
# ============================================================================

def generate_doctors_sql():
    """Generate INSERT statements for doctors"""
    sql = "-- ============================================================================\n"
    sql += "-- INSERT DOCTORS (50 records)\n"
    sql += "-- ============================================================================\n\n"
    sql += "INSERT INTO doctors (first_name, last_name, license_number, specialization, "
    sql += "fk_department_id, phone_number, email, hire_date, years_of_experience, is_available) VALUES\n"

    values = []
    for i in range(1, NUM_DOCTORS + 1):
        first_name = fake.first_name()
        last_name = fake.last_name()
        license = f"MD{i:06d}"
        specialization = random.choice(SPECIALIZATIONS)
        dept_id = random.randint(1, NUM_DEPARTMENTS)
        phone = fake.phone_number()[:15]
        email = f"{first_name.lower()}.{last_name.lower()}@hospital.com"
        hire_date = random_date(2010, 2023)
        years_exp = random.randint(5, 30)

        values.append(
            f"('{sql_escape(first_name)}', '{sql_escape(last_name)}', '{license}', "
            f"'{specialization}', {dept_id}, '{phone}', '{email}', '{hire_date}', {years_exp}, TRUE)"
        )

    sql += ",\n".join(values) + ";\n\n"
    return sql

def generate_patients_sql():
    """Generate INSERT statements for patients"""
    sql = "-- ============================================================================\n"
    sql += "-- INSERT PATIENTS (200 records)\n"
    sql += "-- ============================================================================\n\n"
    sql += "INSERT INTO patients (first_name, last_name, date_of_birth, gender, blood_type, "
    sql += "phone_number, email, street_address, city, state_province, postal_code, country, "
    sql += "insurance_provider, insurance_policy_number, emergency_contact_name, "
    sql += "emergency_contact_phone, registration_date, is_active) VALUES\n"

    values = []
    for i in range(1, NUM_PATIENTS + 1):
        first_name = fake.first_name()
        last_name = fake.last_name()
        dob = random_date(1940, 2010)
        gender = random.choice(['M', 'F'])
        blood_type = random.choice(BLOOD_TYPES)
        phone = fake.phone_number()[:15]
        email = f"{first_name.lower()}.{last_name.lower()}@email.com"
        address = fake.street_address()[:255]
        city = fake.city()
        state = fake.state()
        postal = fake.postcode()
        country = 'USA'
        insurance = random.choice(INSURANCE_PROVIDERS)
        policy = f"{insurance[:3].upper()}{random.randint(100000000, 999999999)}"
        emergency_name = fake.name()
        emergency_phone = fake.phone_number()[:15]
        reg_date = random_date(2018, 2024)

        values.append(
            f"('{sql_escape(first_name)}', '{sql_escape(last_name)}', '{dob}', '{gender}', "
            f"'{blood_type}', '{phone}', '{email}', '{sql_escape(address)}', '{sql_escape(city)}', "
            f"'{sql_escape(state)}', '{postal}', '{country}', '{insurance}', '{policy}', "
            f"'{sql_escape(emergency_name)}', '{emergency_phone}', '{reg_date}', TRUE)"
        )

    sql += ",\n".join(values) + ";\n\n"
    return sql

def generate_diagnoses_sql():
    """Generate INSERT statements for diagnoses"""
    sql = "-- ============================================================================\n"
    sql += "-- INSERT DIAGNOSES (20 records)\n"
    sql += "-- ============================================================================\n\n"
    sql += "INSERT INTO diagnoses (icd_code, diagnosis_name, diagnosis_category, "
    sql += "severity_level, description, is_chronic) VALUES\n"

    values = []
    for icd, name, category, severity, is_chronic in DIAGNOSES_DATA:
        desc = f"{name} - {category} condition with {severity.lower()} severity"
        values.append(
            f"('{icd}', '{sql_escape(name)}', '{category}', '{severity}', "
            f"'{sql_escape(desc)}', {str(is_chronic).upper()})"
        )

    sql += ",\n".join(values) + ";\n\n"
    return sql

def generate_medications_sql():
    """Generate INSERT statements for medications"""
    sql = "-- ============================================================================\n"
    sql += "-- INSERT MEDICATIONS (30 records)\n"
    sql += "-- ============================================================================\n\n"
    sql += "INSERT INTO medications (medication_name, generic_name, ndc_code, dosage_strength, "
    sql += "dosage_form, route_of_administration, common_side_effects, contraindications, "
    sql += "manufacturer, is_available) VALUES\n"

    values = []
    manufacturers = ['Pfizer', 'Novartis', 'Merck', 'GSK', 'Sanofi', 'AstraZeneca', 'Teva', 'Cipla']

    for i, (med_name, generic, strength, form, route) in enumerate(MEDICATIONS_DATA, 1):
        ndc = f"{random.randint(1000, 9999)}-{random.randint(1000, 9999)}-{random.randint(10, 99)}"
        side_effects = fake.sentence(nb_words=6)
        contraindications = fake.sentence(nb_words=5)
        manufacturer = random.choice(manufacturers)

        values.append(
            f"('{sql_escape(med_name)}', '{sql_escape(generic)}', '{ndc}', '{strength}', "
            f"'{form}', '{route}', '{sql_escape(side_effects)}', '{sql_escape(contraindications)}', "
            f"'{manufacturer}', TRUE)"
        )

    sql += ",\n".join(values) + ";\n\n"
    return sql

def generate_encounters_sql():
    """Generate INSERT statements for normalized encounters table"""
    sql = "-- ============================================================================\n"
    sql += "-- INSERT ENCOUNTERS (500 records)\n"
    sql += "-- ============================================================================\n\n"
    sql += "INSERT INTO encounters (fk_patient_id, fk_doctor_id, fk_department_id, "
    sql += "fk_diagnosis_id, fk_medication_id, encounter_date, encounter_time, encounter_type, "
    sql += "encounter_duration_minutes, chief_complaint, vital_signs_temperature, "
    sql += "vital_signs_blood_pressure, vital_signs_heart_rate, vital_signs_respiratory_rate, "
    sql += "clinical_notes, treatment_plan, prescribed_quantity, prescribed_frequency, "
    sql += "prescription_duration_days, follow_up_date, follow_up_required, "
    sql += "billingBillable_amount, billing_status, created_by, last_modified_by) VALUES\n"

    values = []
    for i in range(NUM_ENCOUNTERS):
        patient_id = random.randint(1, NUM_PATIENTS)
        doctor_id = random.randint(1, NUM_DOCTORS)
        dept_id = random.randint(1, NUM_DEPARTMENTS)
        diagnosis_id = random.randint(1, len(DIAGNOSES_DATA))
        medication_id = random.randint(1, len(MEDICATIONS_DATA)) if random.random() > 0.1 else 'NULL'

        encounter_date = random_date(2023, 2024)
        encounter_time = random_time()
        encounter_type = random.choice(ENCOUNTER_TYPES)
        duration = random.choice([15, 20, 30, 45, 60, 90, 120])
        complaint = fake.sentence(nb_words=8)

        temp = round(random.uniform(97.0, 99.5), 1)
        bp_systolic = random.randint(110, 160)
        bp_diastolic = random.randint(60, 100)
        bp = f"{bp_systolic}/{bp_diastolic}"
        heart_rate = random.randint(60, 100)
        resp_rate = random.randint(12, 20)

        clinical_notes = fake.paragraph(nb_sentences=2)
        treatment_plan = fake.paragraph(nb_sentences=2)

        prescribed_qty = random.choice([14, 30, 60, 90]) if medication_id != 'NULL' else 'NULL'
        prescribed_freq = random.choice([
            'Once daily', 'Twice daily', 'Three times daily', 'As needed'
        ]) if medication_id != 'NULL' else 'NULL'
        prescription_days = random.choice([7, 14, 30, 90]) if medication_id != 'NULL' else 'NULL'

        follow_up_required = random.choice([True, False])
        follow_up_date = f"'{random_date(2024, 2025)}'" if follow_up_required else 'NULL'

        billing_amount = round(random.uniform(150.0, 5000.0), 2)
        billing_status = random.choice(BILLING_STATUSES)

        doctor_name = f"Dr. Smith"  # Placeholder

        med_id_val = medication_id if medication_id != 'NULL' else 'NULL'
        qty_val = prescribed_qty if prescribed_qty != 'NULL' else 'NULL'
        freq_val = f"'{prescribed_freq}'" if prescribed_freq != 'NULL' else 'NULL'
        days_val = prescription_days if prescription_days != 'NULL' else 'NULL'

        values.append(
            f"({patient_id}, {doctor_id}, {dept_id}, {diagnosis_id}, {med_id_val}, "
            f"'{encounter_date}', '{encounter_time}', '{encounter_type}', {duration}, "
            f"'{sql_escape(complaint)}', {temp}, '{bp}', {heart_rate}, {resp_rate}, "
            f"'{sql_escape(clinical_notes)}', '{sql_escape(treatment_plan)}', "
            f"{qty_val}, {freq_val}, {days_val}, {follow_up_date}, "
            f"{str(follow_up_required).upper()}, {billing_amount}, '{billing_status}', "
            f"'{doctor_name}', '{doctor_name}')"
        )

    sql += ",\n".join(values) + ";\n\n"
    return sql

# ============================================================================
# MAIN SCRIPT
# ============================================================================

def main():
    print("Generating SQL file with bulk fake data...")

    output_file = "healthcare_bulk_data.sql"

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("-- ============================================================================\n")
        f.write("-- Healthcare System - BULK FAKE DATA GENERATION\n")
        f.write("-- ============================================================================\n")
        f.write("-- Total Records: ~500+\n")
        f.write(f"-- Doctors: {NUM_DOCTORS}\n")
        f.write(f"-- Patients: {NUM_PATIENTS}\n")
        f.write(f"-- Diagnoses: {len(DIAGNOSES_DATA)}\n")
        f.write(f"-- Medications: {len(MEDICATIONS_DATA)}\n")
        f.write(f"-- Encounters: {NUM_ENCOUNTERS}\n")
        f.write("-- ============================================================================\n\n")
        f.write("USE healthcare_system;\n\n")

        # Add cleanup section
        f.write("-- ============================================================================\n")
        f.write("-- DATA CLEANUP - Remove existing data to prevent duplicates\n")
        f.write("-- ============================================================================\n")
        f.write("-- This prevents \"Duplicate entry\" errors for UNIQUE constraints\n")
        f.write("-- We clear dependent tables first (in reverse FK order), then parent tables\n\n")

        f.write("SET FOREIGN_KEY_CHECKS = 0;\n\n")

        f.write("-- Clear denormalized table first (depends on all others)\n")
        f.write("TRUNCATE TABLE denormalized_patient_encounters;\n\n")

        f.write("-- Clear encounters table (depends on dimension tables)\n")
        f.write("TRUNCATE TABLE encounters;\n\n")

        f.write("-- Clear dimension tables (doctors depends on departments, so clear doctors first)\n")
        f.write("TRUNCATE TABLE doctors;\n")
        f.write("TRUNCATE TABLE patients;\n")
        f.write("TRUNCATE TABLE diagnoses;\n")
        f.write("TRUNCATE TABLE medications;\n\n")

        f.write("-- Keep departments table as-is (already has 10 records)\n")
        f.write("-- If you want fresh departments too, uncomment the next line:\n")
        f.write("-- TRUNCATE TABLE departments;\n\n")

        f.write("SET FOREIGN_KEY_CHECKS = 1;\n\n")

        f.write("-- ============================================================================\n")
        f.write("-- Note: All tables are now empty (except departments with 10 records)\n")
        f.write("-- Ready for bulk data insertion\n")
        f.write("-- ============================================================================\n\n")

        print("Generating doctors data...")
        f.write(generate_doctors_sql())

        print("Generating patients data...")
        f.write(generate_patients_sql())

        print("Generating diagnoses data...")
        f.write(generate_diagnoses_sql())

        print("Generating medications data...")
        f.write(generate_medications_sql())

        print("Generating encounters data...")
        f.write(generate_encounters_sql())

        f.write("-- ============================================================================\n")
        f.write("-- POPULATE DENORMALIZED TABLE\n")
        f.write("-- ============================================================================\n\n")
        f.write("INSERT INTO denormalized_patient_encounters (\n")
        f.write("    fk_patient_id, fk_doctor_id, fk_department_id, fk_diagnosis_id, fk_medication_id,\n")
        f.write("    patient_first_name, patient_last_name, patient_date_of_birth, patient_age,\n")
        f.write("    patient_gender, patient_blood_type, patient_phone, patient_email,\n")
        f.write("    patient_street_address, patient_city, patient_state, patient_postal_code,\n")
        f.write("    patient_country, patient_insurance_provider, patient_insurance_policy_number,\n")
        f.write("    patient_emergency_contact_name, patient_emergency_contact_phone, patient_registration_date,\n")
        f.write("    doctor_first_name, doctor_last_name, doctor_license_number, doctor_specialization,\n")
        f.write("    doctor_phone, doctor_email, doctor_hire_date, doctor_years_experience,\n")
        f.write("    department_name, department_code, department_floor, department_phone, department_head,\n")
        f.write("    diagnosis_icd_code, diagnosis_name, diagnosis_category, diagnosis_severity,\n")
        f.write("    diagnosis_description, is_chronic_diagnosis,\n")
        f.write("    medication_name, medication_generic_name, medication_dosage_strength,\n")
        f.write("    medication_dosage_form, medication_route, medication_side_effects,\n")
        f.write("    medication_contraindications, medication_manufacturer,\n")
        f.write("    encounter_date, encounter_time, encounter_type, encounter_duration_minutes,\n")
        f.write("    chief_complaint, vital_signs_temperature, vital_signs_blood_pressure,\n")
        f.write("    vital_signs_heart_rate, vital_signs_respiratory_rate, clinical_notes,\n")
        f.write("    treatment_plan, prescribed_quantity, prescribed_frequency, prescription_duration_days,\n")
        f.write("    follow_up_date, follow_up_required, billingBillable_amount, billing_status,\n")
        f.write("    created_by, last_modified_by\n")
        f.write(")\n")
        f.write("SELECT\n")
        f.write("    e.fk_patient_id, e.fk_doctor_id, e.fk_department_id, e.fk_diagnosis_id, e.fk_medication_id,\n")
        f.write("    p.first_name, p.last_name, p.date_of_birth,\n")
        f.write("    YEAR(CURDATE()) - YEAR(p.date_of_birth) - (DATE_FORMAT(CURDATE(), '%m%d') < DATE_FORMAT(p.date_of_birth, '%m%d')) AS patient_age,\n")
        f.write("    p.gender, p.blood_type, p.phone_number, p.email,\n")
        f.write("    p.street_address, p.city, p.state_province, p.postal_code, p.country,\n")
        f.write("    p.insurance_provider, p.insurance_policy_number,\n")
        f.write("    p.emergency_contact_name, p.emergency_contact_phone, p.registration_date,\n")
        f.write("    d.first_name, d.last_name, d.license_number, d.specialization,\n")
        f.write("    d.phone_number, d.email, d.hire_date, d.years_of_experience,\n")
        f.write("    dp.department_name, dp.department_code, dp.floor_number, dp.phone_number, dp.head_physician,\n")
        f.write("    di.icd_code, di.diagnosis_name, di.diagnosis_category, di.severity_level,\n")
        f.write("    di.description, di.is_chronic,\n")
        f.write("    m.medication_name, m.generic_name, m.dosage_strength, m.dosage_form,\n")
        f.write("    m.route_of_administration, m.common_side_effects, m.contraindications, m.manufacturer,\n")
        f.write("    e.encounter_date, e.encounter_time, e.encounter_type, e.encounter_duration_minutes,\n")
        f.write("    e.chief_complaint, e.vital_signs_temperature, e.vital_signs_blood_pressure,\n")
        f.write("    e.vital_signs_heart_rate, e.vital_signs_respiratory_rate, e.clinical_notes,\n")
        f.write("    e.treatment_plan, e.prescribed_quantity, e.prescribed_frequency, e.prescription_duration_days,\n")
        f.write("    e.follow_up_date, e.follow_up_required, e.billingBillable_amount, e.billing_status,\n")
        f.write("    e.created_by, e.last_modified_by\n")
        f.write("FROM encounters e\n")
        f.write("    LEFT JOIN patients p ON e.fk_patient_id = p.patient_id\n")
        f.write("    LEFT JOIN doctors d ON e.fk_doctor_id = d.doctor_id\n")
        f.write("    LEFT JOIN departments dp ON e.fk_department_id = dp.department_id\n")
        f.write("    LEFT JOIN diagnoses di ON e.fk_diagnosis_id = di.diagnosis_id\n")
        f.write("    LEFT JOIN medications m ON e.fk_medication_id = m.medication_id\n")
        f.write("WHERE e.fk_patient_id IS NOT NULL\n")
        f.write("  AND e.fk_doctor_id IS NOT NULL\n")
        f.write("  AND e.fk_department_id IS NOT NULL;\n\n")

        f.write("-- ============================================================================\n")
        f.write("-- VERIFICATION QUERIES\n")
        f.write("-- ============================================================================\n\n")
        f.write("SELECT 'doctors' AS table_name, COUNT(*) AS row_count FROM doctors\n")
        f.write("UNION ALL SELECT 'patients', COUNT(*) FROM patients\n")
        f.write("UNION ALL SELECT 'diagnoses', COUNT(*) FROM diagnoses\n")
        f.write("UNION ALL SELECT 'medications', COUNT(*) FROM medications\n")
        f.write("UNION ALL SELECT 'encounters', COUNT(*) FROM encounters\n")
        f.write("UNION ALL SELECT 'denormalized_patient_encounters', COUNT(*) FROM denormalized_patient_encounters;\n")

    print(f"\n[SUCCESS] SQL file generated: {output_file}")
    print(f"Total records: {NUM_DOCTORS + NUM_PATIENTS + len(DIAGNOSES_DATA) + len(MEDICATIONS_DATA) + NUM_ENCOUNTERS}")

if __name__ == "__main__":
    main()
