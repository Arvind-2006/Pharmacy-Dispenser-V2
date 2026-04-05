-- =============================================================================
-- SAFE ADD MORE DATA (WITHOUT SPECIFYING IDs - Let DB auto-generate)
-- This avoids all foreign key and constraint errors
-- =============================================================================

BEGIN;

-- =============================================================================
-- ADD MORE USERS (LET DB AUTO-GENERATE IDs)
-- =============================================================================
INSERT INTO users (username, password, role) VALUES
    ('drkumar', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_DOCTOR'),
    ('drnikhil', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_DOCTOR'),
    ('drsharma', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_DOCTOR'),
    ('kevin', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT'),
    ('laura', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT'),
    ('mark', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT'),
    ('nancy', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT'),
    ('oscar', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT'),
    ('paul', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT'),
    ('quinn', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT');

-- =============================================================================
-- ADD MORE PATIENTS (LET DB AUTO-GENERATE IDs, use existing user_ids)
-- =============================================================================
INSERT INTO patients (name, age, gender, email, phone, address, user_id) VALUES
    ('Kevin Stone', 40, 'Male', 'kevin.stone@mail.com', '555-0111', '555 Logic Lane', (SELECT id FROM users WHERE username='kevin')),
    ('Laura White', 37, 'Female', 'laura.white@mail.com', '555-0112', '666 Memory Mews', (SELECT id FROM users WHERE username='laura')),
    ('Mark Young', 44, 'Male', 'mark.young@mail.com', '555-0113', '777 Router Road', (SELECT id FROM users WHERE username='mark')),
    ('Nancy Gray', 32, 'Female', 'nancy.gray@mail.com', '555-0114', '888 Protocol Path', (SELECT id FROM users WHERE username='nancy')),
    ('Oscar Black', 49, 'Male', 'oscar.black@mail.com', '555-0115', '999 Hardware Hill', (SELECT id FROM users WHERE username='oscar')),
    ('Paul Brown', 38, 'Male', 'paul.brown@mail.com', '555-0116', '1010 Software Street', (SELECT id FROM users WHERE username='paul')),
    ('Quinn Light', 27, 'Other', 'quinn.light@mail.com', '555-0117', '1111 Cyber Circle', (SELECT id FROM users WHERE username='quinn'));

-- =============================================================================
-- ADD MORE DOCTORS (LET DB AUTO-GENERATE IDs, use existing user_ids)
-- =============================================================================
INSERT INTO doctors (name, specialization, email, phone, user_id) VALUES
    ('Dr. Arvind Kumar', 'Neurology', 'kumar@hospital.org', '555-0205', (SELECT id FROM users WHERE username='drkumar')),
    ('Dr. Nikhil Sharma', 'Oncology', 'nikhil@hospital.org', '555-0206', (SELECT id FROM users WHERE username='drnikhil')),
    ('Dr. Deepak Sharma', 'Surgery', 'sharma@hospital.org', '555-0207', (SELECT id FROM users WHERE username='drsharma'));

-- =============================================================================
-- ADD MORE MEDICINES (ONLY IF THEY DON'T EXIST BY NAME)
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

-- =============================================================================
-- ADD MORE INVENTORY (Link to medicines - LET DB AUTO-GENERATE inventory_id)
-- =============================================================================
INSERT INTO medicine_inventory (medicine_id, batch_no, quantity_available, expiry_date, reorder_level, machine_slot, last_updated) 
SELECT medicine_id, 
       CONCAT('BATCH-', medicine_name, '-', floor(random() * 1000)), 
       FLOOR(random() * 300 + 100),
       CURRENT_DATE + INTERVAL '365 days',
       20,
       CONCAT('SLOT-', LPAD(CAST(floor(random() * 20) AS text), 2, '0')),
       NOW()
FROM medicine 
WHERE medicine_name IN ('Doxycycline 100mg', 'Insulin Glargine', 'Warfarin 5mg', 'Clopidogrel 75mg', 'Atorvastatin 20mg');

-- =============================================================================
-- ADD 15 MORE PRESCRIPTIONS (Reference existing doctors and patients)
-- =============================================================================
INSERT INTO prescription (patient_name, diagnosis, prescribed_at, doctor_id, status, expiry_date, patient_id) 
SELECT 
    p.name,
    CASE floor(random() * 3)
        WHEN 0 THEN 'Migraine headaches'
        WHEN 1 THEN 'Chronic pain management'
        ELSE 'Follow-up examination'
    END,
    CURRENT_TIMESTAMP - INTERVAL '1 day' * floor(random() * 7),
    d.user_id,  -- Reference existing doctor user_id
    'ACTIVE',
    CURRENT_DATE + INTERVAL '30 days',
    p.id
FROM patients p
CROSS JOIN (SELECT user_id FROM doctors ORDER BY user_id DESC LIMIT 1) d
WHERE p.name IN ('Kevin Stone', 'Laura White', 'Mark Young', 'Nancy Gray', 'Oscar Black', 'Paul Brown', 'Quinn Light')
AND NOT EXISTS (
    SELECT 1 FROM prescription WHERE patient_id = p.id AND diagnosis LIKE '%Migraine%'
);

-- Alternative if CROSS JOIN issue: Add prescriptions for each patient
INSERT INTO prescription (patient_name, diagnosis, prescribed_at, doctor_id, status, expiry_date, patient_id)
SELECT 
    'Kevin Stone',
    'Neurology consultation',
    CURRENT_TIMESTAMP - INTERVAL '2 days',
    (SELECT user_id FROM doctors WHERE name='Dr. Arvind Kumar' LIMIT 1),
    'ACTIVE',
    CURRENT_DATE + INTERVAL '30 days',
    (SELECT id FROM patients WHERE name='Kevin Stone' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM prescription WHERE patient_name='Kevin Stone' AND diagnosis='Neurology consultation');

INSERT INTO prescription (patient_name, diagnosis, prescribed_at, doctor_id, status, expiry_date, patient_id)
SELECT 
    'Laura White',
    'Oncology follow-up',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    (SELECT user_id FROM doctors WHERE name='Dr. Nikhil Sharma' LIMIT 1),
    'ACTIVE',
    CURRENT_DATE + INTERVAL '30 days',
    (SELECT id FROM patients WHERE name='Laura White' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM prescription WHERE patient_name='Laura White' AND diagnosis='Oncology follow-up');

INSERT INTO prescription (patient_name, diagnosis, prescribed_at, doctor_id, status, expiry_date, patient_id)
SELECT 
    'Mark Young',
    'Post-surgical pain management',
    CURRENT_TIMESTAMP,
    (SELECT user_id FROM doctors WHERE name='Dr. Deepak Sharma' LIMIT 1),
    'ACTIVE',
    CURRENT_DATE + INTERVAL '30 days',
    (SELECT id FROM patients WHERE name='Mark Young' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM prescription WHERE patient_name='Mark Young' AND diagnosis='Post-surgical pain management');

INSERT INTO prescription (patient_name, diagnosis, prescribed_at, doctor_id, status, expiry_date, patient_id)
SELECT 
    'Nancy Gray',
    'Surgical recovery',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    (SELECT user_id FROM doctors WHERE name='Dr. Deepak Sharma' LIMIT 1),
    'ACTIVE',
    CURRENT_DATE + INTERVAL '25 days',
    (SELECT id FROM patients WHERE name='Nancy Gray' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM prescription WHERE patient_name='Nancy Gray');

INSERT INTO prescription (patient_name, diagnosis, prescribed_at, doctor_id, status, expiry_date, patient_id)
SELECT 
    'Oscar Black',
    'Neurology assessment',
    CURRENT_TIMESTAMP - INTERVAL '4 hours',
    (SELECT user_id FROM doctors WHERE name='Dr. Arvind Kumar' LIMIT 1),
    'ACTIVE',
    CURRENT_DATE + INTERVAL '28 days',
    (SELECT id FROM patients WHERE name='Oscar Black' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM prescription WHERE patient_name='Oscar Black');

-- =============================================================================
-- ADD PRESCRIPTION ITEMS (Link prescriptions to medicines - auto-generate IDs)
-- Reference LAST 5 prescriptions with LAST 5 medicines
-- =============================================================================
INSERT INTO prescription_item (prescription_id, medicine_id, quantity)
SELECT 
    pr.id,
    m.medicine_id,
    FLOOR(random() * 30 + 5)  -- Random quantity between 5-35
FROM (SELECT id FROM prescription ORDER BY id DESC LIMIT 5) pr
CROSS JOIN (SELECT medicine_id FROM medicine ORDER BY medicine_id DESC LIMIT 5) m
WHERE NOT EXISTS (
    SELECT 1 FROM prescription_item 
    WHERE prescription_id = pr.id AND medicine_id = m.medicine_id
)
LIMIT 25;

-- =============================================================================
-- FINAL DATA SUMMARY
-- =============================================================================
SELECT 'USERS TOTAL' as Report, COUNT(*) as Count FROM users UNION ALL
SELECT 'PATIENTS TOTAL', COUNT(*) FROM patients UNION ALL
SELECT 'DOCTORS TOTAL', COUNT(*) FROM doctors UNION ALL
SELECT 'MEDICINES TOTAL', COUNT(*) FROM medicine UNION ALL
SELECT 'INVENTORY TOTAL', COUNT(*) FROM medicine_inventory UNION ALL
SELECT 'PRESCRIPTIONS TOTAL', COUNT(*) FROM prescription UNION ALL
SELECT 'PRESCRIPTION ITEMS TOTAL', COUNT(*) FROM prescription_item UNION ALL
SELECT 'DISPENSE LOGS TOTAL', COUNT(*) FROM dispense_log;

COMMIT;
