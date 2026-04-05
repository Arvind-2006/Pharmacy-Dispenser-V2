-- =============================================================================
-- ADD MORE TEST DATA (WITHOUT TRUNCATING EXISTING RECORDS)
-- Append-only script to bulk up prescriptions and dispense logs
-- =============================================================================

BEGIN;

-- =============================================================================
-- ADD MORE USERS (Additional Doctors and Patients)
-- =============================================================================
INSERT INTO users (id, username, password, role) VALUES
    -- Additional Doctors
    (18, 'drkumar', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_DOCTOR'),
    (19, 'drnikhil', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_DOCTOR'),
    (20, 'drsharma', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_DOCTOR'),
    
    -- Additional Patients
    (21, 'kevin', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT'),
    (22, 'laura', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT'),
    (23, 'mark', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT'),
    (24, 'nancy', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT'),
    (25, 'oscar', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT'),
    (26, 'paul', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT'),
    (27, 'quinn', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT');

-- =============================================================================
-- ADD MORE PATIENTS
-- =============================================================================
INSERT INTO patients (id, name, age, gender, email, phone, address, user_id) VALUES
    (11, 'Kevin Stone', 40, 'Male', 'kevin@mail.com', '555-0111', '555 Logic Lane', 21),
    (12, 'Laura White', 37, 'Female', 'laura@mail.com', '555-0112', '666 Memory Mews', 22),
    (13, 'Mark Young', 44, 'Male', 'mark@mail.com', '555-0113', '777 Router Road', 23),
    (14, 'Nancy Gray', 32, 'Female', 'nancy@mail.com', '555-0114', '888 Protocol Path', 24),
    (15, 'Oscar Black', 49, 'Male', 'oscar@mail.com', '555-0115', '999 Hardware Hill', 25),
    (16, 'Paul Brown', 38, 'Male', 'paul@mail.com', '555-0116', '1010 Software Street', 26),
    (17, 'Quinn Light', 27, 'Other', 'quinn@mail.com', '555-0117', '1111 Cyber Circle', 27);

-- =============================================================================
-- ADD MORE DOCTORS
-- =============================================================================
INSERT INTO doctors (id, name, specialization, email, phone, user_id) VALUES
    (6, 'Dr. Arvind Kumar', 'Neurology', 'kumar@hospital.org', '555-0205', 18),
    (7, 'Dr. Nikhil Sharma', 'Oncology', 'nikhil@hospital.org', '555-0206', 19),
    (8, 'Dr. Deepak Sharma', 'Surgery', 'sharma@hospital.org', '555-0207', 20);

-- =============================================================================
-- ADD MORE MEDICINES (If needed) - increasing variety
-- =============================================================================
INSERT INTO medicine (medicine_id, medicine_name, description, price, manufacturer) VALUES
    (13, 'Doxycycline 100mg', 'Antibiotic - tetracycline class', 55.00, 'MediCorp'),
    (14, 'Insulin Glargine', 'Long-acting insulin', 420.00, 'DiabeteCare'),
    (15, 'Warfarin 5mg', 'Anticoagulant / blood thinner', 38.00, 'CardiacCare'),
    (16, 'Clopidogrel 75mg', 'Blood clot prevention', 120.00, 'AntiThrombo'),
    (17, 'Atorvastatin 20mg', 'Cholesterol control', 42.00, 'LipidLabs');

-- =============================================================================
-- ADD MORE INVENTORY
-- =============================================================================
INSERT INTO medicine_inventory (inventory_id, medicine_id, batch_no, quantity_available, expiry_date, reorder_level, machine_slot, last_updated) VALUES
    (13, 13, 'BATCH-DOX-001', 180, DATE '2027-09-15', 20, 'G1', NOW()),
    (14, 14, 'BATCH-INSULIN-002', 100, DATE '2026-12-20', 15, 'G2', NOW()),
    (15, 15, 'BATCH-WAR-003', 120, DATE '2027-02-28', 10, 'H1', NOW()),
    (16, 16, 'BATCH-CLOP-004', 150, DATE '2027-11-05', 15, 'H2', NOW()),
    (17, 17, 'BATCH-ATOR-005', 250, DATE '2027-07-22', 25, 'I1', NOW());

-- =============================================================================
-- ADD 30 MORE PRESCRIPTIONS (Bulk additions for testing)
-- =============================================================================
INSERT INTO prescription (id, patient_name, diagnosis, prescribed_at, doctor_id, status, expiry_date, patient_id) VALUES
    -- Dr. Kumar (Neurology) - Prescriptions 21-30
    (21, 'Kevin Stone', 'Migraine headaches', TIMESTAMP '2026-04-20 10:00:00', 18, 'ACTIVE', DATE '2026-05-20', 11),
    (22, 'Laura White', 'Tension headache treatment', TIMESTAMP '2026-04-21 11:15:00', 18, 'ACTIVE', DATE '2026-05-21', 12),
    (23, 'Mark Young', 'Chronic pain management', TIMESTAMP '2026-04-22 09:30:00', 18, 'ACTIVE', DATE '2026-05-22', 13),
    (24, 'Nancy Gray', 'Vertigo / Dizziness', TIMESTAMP '2026-04-23 13:45:00', 18, 'ACTIVE', DATE '2026-05-23', 14),
    (25, 'Oscar Black', 'Neuropathy treatment', TIMESTAMP '2026-04-24 10:20:00', 18, 'ACTIVE', DATE '2026-05-24', 15),
    (26, 'Paul Brown', 'Sleep disorder management', TIMESTAMP '2026-04-25 14:00:00', 18, 'ACTIVE', DATE '2026-05-25', 16),
    (27, 'Quinn Light', 'Anxiety management', TIMESTAMP '2026-04-26 09:15:00', 18, 'ACTIVE', DATE '2026-05-26', 17),
    (28, 'Kevin Stone', 'Follow-up migraine check', TIMESTAMP '2026-04-27 11:30:00', 18, 'ACTIVE', DATE '2026-05-27', 11),
    (29, 'Alice Smith', 'Nerve pain relief', TIMESTAMP '2026-04-28 10:45:00', 18, 'ACTIVE', DATE '2026-05-28', 1),
    (30, 'Bob Jones', 'Balance disorder', TIMESTAMP '2026-04-29 13:00:00', 18, 'ACTIVE', DATE '2026-05-29', 2),
    
    -- Dr. Sharma (Oncology) - Prescriptions 31-40
    (31, 'Charlie Brown', 'Cancer chemotherapy support', TIMESTAMP '2026-04-20 08:00:00', 19, 'ACTIVE', DATE '2026-05-20', 3),
    (32, 'Diana Prince', 'Immunotherapy adjunct', TIMESTAMP '2026-04-21 09:30:00', 19, 'ACTIVE', DATE '2026-05-21', 4),
    (33, 'Evan Davis', 'Radiation therapy support', TIMESTAMP '2026-04-22 10:15:00', 19, 'ACTIVE', DATE '2026-05-22', 5),
    (34, 'Fiona Green', 'Targeted therapy management', TIMESTAMP '2026-04-23 11:00:00', 19, 'ACTIVE', DATE '2026-05-23', 6),
    (35, 'Grace Hall', 'Post-cancer recovery', TIMESTAMP '2026-04-24 13:20:00', 19, 'ACTIVE', DATE '2026-05-24', 7),
    (36, 'Henry King', 'Palliative care', TIMESTAMP '2026-04-25 09:45:00', 19, 'ACTIVE', DATE '2026-05-25', 8),
    (37, 'Iris Lee', 'Genetic risk counseling', TIMESTAMP '2026-04-26 10:30:00', 19, 'ACTIVE', DATE '2026-05-26', 9),
    (38, 'Jack Miller', 'Surveillance monitoring', TIMESTAMP '2026-04-27 11:15:00', 19, 'ACTIVE', DATE '2026-05-27', 10),
    (39, 'Kevin Stone', 'Preventive cancer therapy', TIMESTAMP '2026-04-28 08:30:00', 19, 'ACTIVE', DATE '2026-05-28', 11),
    (40, 'Laura White', 'Oncology follow-up', TIMESTAMP '2026-04-29 12:00:00', 19, 'ACTIVE', DATE '2026-05-29', 12),
    
    -- Dr. Deepak (Surgery) - Prescriptions 41-50
    (41, 'Mark Young', 'Post-surgical pain management', TIMESTAMP '2026-04-20 14:30:00', 20, 'ACTIVE', DATE '2026-05-20', 13),
    (42, 'Nancy Gray', 'Surgical wound care', TIMESTAMP '2026-04-21 15:00:00', 20, 'ACTIVE', DATE '2026-05-21', 14),
    (43, 'Oscar Black', 'Infection prevention post-op', TIMESTAMP '2026-04-22 13:45:00', 20, 'ACTIVE', DATE '2026-05-22', 15),
    (44, 'Paul Brown', 'Physical therapy support', TIMESTAMP '2026-04-23 14:20:00', 20, 'ACTIVE', DATE '2026-05-23', 16),
    (45, 'Quinn Light', 'Post-operative anxiety', TIMESTAMP '2026-04-24 15:10:00', 20, 'ACTIVE', DATE '2026-05-24', 17),
    (46, 'Kevin Stone', 'Emergency room follow-up', TIMESTAMP '2026-04-25 10:00:00', 20, 'ACTIVE', DATE '2026-05-25', 11),
    (47, 'Laura White', 'Trauma recovery', TIMESTAMP '2026-04-26 11:30:00', 20, 'ACTIVE', DATE '2026-05-26', 12),
    (48, 'Mark Young', 'Orthopedic post-surgery', TIMESTAMP '2026-04-27 09:00:00', 20, 'ACTIVE', DATE '2026-05-27', 13),
    (49, 'Nancy Gray', 'Suture removal visit', TIMESTAMP '2026-04-28 10:15:00', 20, 'ACTIVE', DATE '2026-05-28', 14),
    (50, 'Oscar Black', 'Surgical scar management', TIMESTAMP '2026-04-29 11:45:00', 20, 'ACTIVE', DATE '2026-05-29', 15);

-- =============================================================================
-- ADD PRESCRIPTION ITEMS FOR NEW PRESCRIPTIONS (21-50)
-- =============================================================================
INSERT INTO prescription_item (id, prescription_id, medicine_id, quantity) VALUES
    -- Prescriptions 21-30 (Neurology meds)
    (24, 21, 1, 20),   -- Paracetamol for migraine
    (25, 22, 4, 15),   -- Ibuprofen for tension
    (26, 23, 1, 10),   -- Pain relief
    (27, 24, 3, 30),   -- Vitamin D
    (28, 25, 9, 10),   -- Azithromycin
    (29, 26, 10, 30),  -- Cetirizine
    (30, 27, 4, 20),   -- Ibuprofen
    (31, 28, 1, 15),   -- Paracetamol
    (32, 29, 5, 8),    -- Ciprofloxacin
    (33, 30, 2, 15),   -- Amoxicillin
    
    -- Prescriptions 31-40 (Oncology meds)
    (34, 31, 14, 1),   -- Insulin Glargine
    (35, 32, 13, 20),  -- Doxycycline
    (36, 33, 8, 30),   -- Omeprazole
    (37, 34, 15, 5),   -- Warfarin
    (38, 35, 12, 60),  -- Calcium Carbonate
    (39, 36, 6, 60),   -- Metformin
    (40, 37, 10, 30),  -- Cetirizine
    (41, 38, 3, 30),   -- Vitamin D3
    (42, 39, 16, 10),  -- Clopidogrel
    (43, 40, 17, 30),  -- Atorvastatin
    
    -- Prescriptions 41-50 (Surgery meds)
    (44, 41, 1, 20),   -- Paracetamol
    (45, 42, 2, 15),   -- Amoxicillin
    (46, 43, 13, 20),  -- Doxycycline for infection
    (47, 44, 4, 30),   -- Ibuprofen
    (48, 45, 10, 20),  -- Cetirizine for anxiety
    (49, 46, 9, 12),   -- Azithromycin
    (50, 47, 5, 10),   -- Ciprofloxacin
    (51, 48, 7, 30),   -- Lisinopril
    (52, 49, 3, 20),   -- Vitamin D3
    (53, 50, 8, 30);   -- Omeprazole

-- =============================================================================
-- VIEW SUMMARY OF NEW ADDITIONS
-- =============================================================================
SELECT 'Users' as Entity, COUNT(*) as Total FROM users UNION ALL
SELECT 'Patients', COUNT(*) FROM patients UNION ALL
SELECT 'Doctors', COUNT(*) FROM doctors UNION ALL
SELECT 'Medicines', COUNT(*) FROM medicine UNION ALL
SELECT 'Inventory', COUNT(*) FROM medicine_inventory UNION ALL
SELECT 'Prescriptions', COUNT(*) FROM prescription UNION ALL
SELECT 'Prescription Items', COUNT(*) FROM prescription_item UNION ALL
SELECT 'Dispense Logs', COUNT(*) FROM dispense_log;

COMMIT;
