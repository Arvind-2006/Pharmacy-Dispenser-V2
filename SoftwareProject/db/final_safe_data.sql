-- =============================================================================
-- FIX SEQUENCE AND ADD NEW DATA SAFELY
-- =============================================================================

BEGIN;

-- First, reset the medicine sequence to start AFTER existing max ID
SELECT setval('medicine_medicine_id_seq', (SELECT COALESCE(MAX(medicine_id), 0) + 1 FROM medicine));

-- Reset other sequences too
SELECT setval('users_id_seq', (SELECT COALESCE(MAX(id), 0) + 1 FROM users));
SELECT setval('patients_id_seq', (SELECT COALESCE(MAX(id), 0) + 1 FROM patients));
SELECT setval('doctors_id_seq', (SELECT COALESCE(MAX(id), 0) + 1 FROM doctors));
SELECT setval('prescription_id_seq', (SELECT COALESCE(MAX(id), 0) + 1 FROM prescription));
SELECT setval('prescription_item_id_seq', (SELECT COALESCE(MAX(id), 0) + 1 FROM prescription_item));
SELECT setval('medicine_inventory_inventory_id_seq', (SELECT COALESCE(MAX(inventory_id), 0) + 1 FROM medicine_inventory));

-- =============================================================================
-- NOW ADD NEW USERS (These will auto-generate unique IDs starting from next available)
-- =============================================================================
INSERT INTO users (username, password, role) 
SELECT 'drkumar', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_DOCTOR'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username='drkumar');

INSERT INTO users (username, password, role) 
SELECT 'drnikhil', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_DOCTOR'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username='drnikhil');

INSERT INTO users (username, password, role) 
SELECT 'drsharma', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_DOCTOR'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username='drsharma');

INSERT INTO users (username, password, role) 
SELECT 'kevin', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username='kevin');

INSERT INTO users (username, password, role) 
SELECT 'laura', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username='laura');

INSERT INTO users (username, password, role) 
SELECT 'mark', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username='mark');

INSERT INTO users (username, password, role) 
SELECT 'nancy', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username='nancy');

-- =============================================================================
-- ADD NEW PATIENTS
-- =============================================================================
INSERT INTO patients (name, age, gender, email, phone, address, user_id) 
SELECT 'Kevin Stone', 40, 'Male', 'kevin.stone@mail.com', '555-0111', '555 Logic Lane', u.id
FROM users u WHERE u.username='kevin' AND NOT EXISTS (SELECT 1 FROM patients WHERE email='kevin.stone@mail.com');

INSERT INTO patients (name, age, gender, email, phone, address, user_id) 
SELECT 'Laura White', 37, 'Female', 'laura.white@mail.com', '555-0112', '666 Memory Mews', u.id
FROM users u WHERE u.username='laura' AND NOT EXISTS (SELECT 1 FROM patients WHERE email='laura.white@mail.com');

INSERT INTO patients (name, age, gender, email, phone, address, user_id) 
SELECT 'Mark Young', 44, 'Male', 'mark.young@mail.com', '555-0113', '777 Router Road', u.id
FROM users u WHERE u.username='mark' AND NOT EXISTS (SELECT 1 FROM patients WHERE email='mark.young@mail.com');

INSERT INTO patients (name, age, gender, email, phone, address, user_id) 
SELECT 'Nancy Gray', 32, 'Female', 'nancy.gray@mail.com', '555-0114', '888 Protocol Path', u.id
FROM users u WHERE u.username='nancy' AND NOT EXISTS (SELECT 1 FROM patients WHERE email='nancy.gray@mail.com');

-- =============================================================================
-- ADD NEW DOCTORS
-- =============================================================================
INSERT INTO doctors (name, specialization, email, phone, user_id) 
SELECT 'Dr. Arvind Kumar', 'Neurology', 'kumar@hospital.org', '555-0205', u.id
FROM users u WHERE u.username='drkumar' AND NOT EXISTS (SELECT 1 FROM doctors WHERE email='kumar@hospital.org');

INSERT INTO doctors (name, specialization, email, phone, user_id) 
SELECT 'Dr. Nikhil Sharma', 'Oncology', 'nikhil@hospital.org', '555-0206', u.id
FROM users u WHERE u.username='drnikhil' AND NOT EXISTS (SELECT 1 FROM doctors WHERE email='nikhil@hospital.org');

INSERT INTO doctors (name, specialization, email, phone, user_id) 
SELECT 'Dr. Deepak Sharma', 'Surgery', 'sharma@hospital.org', '555-0207', u.id
FROM users u WHERE u.username='drsharma' AND NOT EXISTS (SELECT 1 FROM doctors WHERE email='sharma@hospital.org');

-- =============================================================================
-- ADD NEW MEDICINES (Only names that don't exist yet)
-- =============================================================================
INSERT INTO medicine (medicine_name, description, price, manufacturer) 
SELECT 'Doxycycline 100mg', 'Antibiotic - tetracycline class', 55.00, 'MediCorp'
WHERE NOT EXISTS (SELECT 1 FROM medicine WHERE medicine_name = 'Doxycycline 100mg');

INSERT INTO medicine (medicine_name, description, price, manufacturer) 
SELECT 'Insulin Glargine', 'Long-acting insulin', 420.00, 'DiabeteCare'
WHERE NOT EXISTS (SELECT 1 FROM medicine WHERE medicine_name = 'Insulin Glargine');

INSERT INTO medicine (medicine_name, description, price, manufacturer) 
SELECT 'Warfarin 5mg', 'Anticoagulant / blood thinner', 38.00, 'CardiacCare'
WHERE NOT EXISTS (SELECT 1 FROM medicine WHERE medicine_name = 'Warfarin 5mg');

INSERT INTO medicine (medicine_name, description, price, manufacturer) 
SELECT 'Clopidogrel 75mg', 'Blood clot prevention', 120.00, 'AntiThrombo'
WHERE NOT EXISTS (SELECT 1 FROM medicine WHERE medicine_name = 'Clopidogrel 75mg');

INSERT INTO medicine (medicine_name, description, price, manufacturer) 
SELECT 'Atorvastatin 20mg', 'Cholesterol control', 42.00, 'LipidLabs'
WHERE NOT EXISTS (SELECT 1 FROM medicine WHERE medicine_name = 'Atorvastatin 20mg');

INSERT INTO medicine (medicine_name, description, price, manufacturer) 
SELECT 'Sertraline 50mg', 'Antidepressant - SSRI', 28.00, 'MindCare'
WHERE NOT EXISTS (SELECT 1 FROM medicine WHERE medicine_name = 'Sertraline 50mg');

INSERT INTO medicine (medicine_name, description, price, manufacturer) 
SELECT 'Metoprolol 25mg', 'Beta-blocker for heart conditions', 35.00, 'CardiacCare'
WHERE NOT EXISTS (SELECT 1 FROM medicine WHERE medicine_name = 'Metoprolol 25mg');

-- =============================================================================
-- ADD INVENTORY FOR NEW MEDICINES
-- =============================================================================
INSERT INTO medicine_inventory (medicine_id, batch_no, quantity_available, expiry_date, reorder_level, machine_slot, last_updated)
SELECT m.medicine_id, CONCAT('BATCH-', m.medicine_name, '-001'), 150, CURRENT_DATE + INTERVAL '1 year', 20, 'AUTO', NOW()
FROM medicine m 
WHERE m.medicine_name IN ('Doxycycline 100mg', 'Insulin Glargine', 'Warfarin 5mg', 'Clopidogrel 75mg', 'Atorvastatin 20mg', 'Sertraline 50mg', 'Metoprolol 25mg')
AND NOT EXISTS (
    SELECT 1 FROM medicine_inventory mi WHERE mi.medicine_id = m.medicine_id
);

-- =============================================================================
-- ADD NEW PRESCRIPTIONS
-- =============================================================================
INSERT INTO prescription (patient_name, diagnosis, prescribed_at, doctor_id, status, expiry_date, patient_id)
SELECT p.name, 'Neurological consultation', CURRENT_TIMESTAMP - INTERVAL '2 days', d.user_id, 'ACTIVE', CURRENT_DATE + INTERVAL '30 days', p.id
FROM patients p, doctors d
WHERE p.name = 'Kevin Stone' AND d.name = 'Dr. Arvind Kumar'
AND NOT EXISTS (SELECT 1 FROM prescription WHERE patient_id = p.id AND diagnosis = 'Neurological consultation');

INSERT INTO prescription (patient_name, diagnosis, prescribed_at, doctor_id, status, expiry_date, patient_id)
SELECT p.name, 'Oncology follow-up', CURRENT_TIMESTAMP - INTERVAL '1 day', d.user_id, 'ACTIVE', CURRENT_DATE + INTERVAL '30 days', p.id
FROM patients p, doctors d
WHERE p.name = 'Laura White' AND d.name = 'Dr. Nikhil Sharma'
AND NOT EXISTS (SELECT 1 FROM prescription WHERE patient_id = p.id AND diagnosis = 'Oncology follow-up');

INSERT INTO prescription (patient_name, diagnosis, prescribed_at, doctor_id, status, expiry_date, patient_id)
SELECT p.name, 'Post-surgical recovery', CURRENT_TIMESTAMP - INTERVAL '3 hours', d.user_id, 'ACTIVE', CURRENT_DATE + INTERVAL '25 days', p.id
FROM patients p, doctors d
WHERE p.name = 'Mark Young' AND d.name = 'Dr. Deepak Sharma'
AND NOT EXISTS (SELECT 1 FROM prescription WHERE patient_id = p.id AND diagnosis = 'Post-surgical recovery');

INSERT INTO prescription (patient_name, diagnosis, prescribed_at, doctor_id, status, expiry_date, patient_id)
SELECT p.name, 'Surgical wound care', CURRENT_TIMESTAMP, d.user_id, 'ACTIVE', CURRENT_DATE + INTERVAL '20 days', p.id
FROM patients p, doctors d
WHERE p.name = 'Nancy Gray' AND d.name = 'Dr. Deepak Sharma'
AND NOT EXISTS (SELECT 1 FROM prescription WHERE patient_id = p.id AND diagnosis = 'Surgical wound care');

-- =============================================================================
-- ADD PRESCRIPTION ITEMS (Link prescriptions to new medicines)
-- =============================================================================
INSERT INTO prescription_item (prescription_id, medicine_id, quantity)
SELECT pr.id, m.medicine_id, FLOOR(random() * 20 + 10)
FROM (SELECT id FROM prescription WHERE diagnosis IN ('Neurological consultation', 'Oncology follow-up', 'Post-surgical recovery', 'Surgical wound care') ORDER BY id DESC LIMIT 4) pr,
     (SELECT medicine_id FROM medicine WHERE medicine_name IN ('Doxycycline 100mg', 'Warfarin 5mg', 'Sertraline 50mg', 'Metoprolol 25mg') LIMIT 4) m
WHERE NOT EXISTS (
    SELECT 1 FROM prescription_item pi 
    WHERE pi.prescription_id = pr.id AND pi.medicine_id = m.medicine_id
);

-- =============================================================================
-- FINAL SUMMARY
-- =============================================================================
SELECT '✅ COMPLETION SUMMARY' as Status, '' as Info UNION ALL
SELECT 'TOTAL USERS', CAST(COUNT(*) as text) FROM users UNION ALL
SELECT 'TOTAL PATIENTS', CAST(COUNT(*) as text) FROM patients UNION ALL
SELECT 'TOTAL DOCTORS', CAST(COUNT(*) as text) FROM doctors UNION ALL
SELECT 'TOTAL MEDICINES', CAST(COUNT(*) as text) FROM medicine UNION ALL
SELECT 'TOTAL INVENTORY', CAST(COUNT(*) as text) FROM medicine_inventory UNION ALL
SELECT 'TOTAL PRESCRIPTIONS', CAST(COUNT(*) as text) FROM prescription UNION ALL
SELECT 'TOTAL PRESCRIPTION ITEMS', CAST(COUNT(*) as text) FROM prescription_item;

COMMIT;
