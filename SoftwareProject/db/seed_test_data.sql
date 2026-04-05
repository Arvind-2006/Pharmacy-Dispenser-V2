-- =============================================================================
-- COMPREHENSIVE TEST DATA FOR AMDS - PostgreSQL
-- =============================================================================
-- Extensive seed data with:
--   10+ Medicines, 5+ Doctors, 10+ Patients, 20+ Prescriptions
-- =============================================================================

BEGIN;

-- Clear existing rows (respect FK order)
TRUNCATE TABLE
    dispense_log,
    prescription_item,
    prescription,
    medicine_inventory,
    medicine,
    patients,
    doctors,
    users
RESTART IDENTITY CASCADE;

-- =============================================================================
-- USERS (Admin, Doctors, Pharmacist, Patients)
-- =============================================================================
INSERT INTO users (id, username, password, role, email) VALUES
    -- Admin
    (1, 'admin', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_ADMIN', 'admin@hospital.org'),
    
    -- Doctors (5)
    (2, 'drpatel', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_DOCTOR', 'patel@hospital.org'),
    (3, 'drsingh', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_DOCTOR', 'singh@hospital.org'),
    (4, 'drbhat', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_DOCTOR', 'bhat@hospital.org'),
    (5, 'drkapoor', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_DOCTOR', 'kapoor@hospital.org'),
    (6, 'drajay', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_DOCTOR', 'ajay@hospital.org'),
    
    -- Pharmacist
    (7, 'pharma1', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PHARMACIST', 'pharma@hospital.org'),
    
    -- Patients (10)
    (8, 'alice', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT', 'alice@mail.com'),
    (9, 'bob', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT', 'bob@mail.com'),
    (10, 'charlie', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT', 'charlie@mail.com'),
    (11, 'diana', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT', 'diana@mail.com'),
    (12, 'evan', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT', 'evan@mail.com'),
    (13, 'fiona', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT', 'fiona@mail.com'),
    (14, 'grace', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT', 'grace@mail.com'),
    (15, 'henry', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT', 'henry@mail.com'),
    (16, 'iris', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT', 'iris@mail.com'),
    (17, 'jack', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm', 'ROLE_PATIENT', 'jack@mail.com');

-- =============================================================================
-- PATIENTS (10)
-- =============================================================================
INSERT INTO patients (id, name, age, gender, email, phone, address, user_id) VALUES
    (1, 'Alice Smith', 28, 'Female', 'alice@mail.com', '555-0101', '123 Neon St, Cyber City', 8),
    (2, 'Bob Jones', 35, 'Male', 'bob@mail.com', '555-0102', '456 Grid Ave, Tech Park', 9),
    (3, 'Charlie Brown', 42, 'Male', 'charlie@mail.com', '555-0103', '789 Circuit Lane', 10),
    (4, 'Diana Prince', 31, 'Female', 'diana@mail.com', '555-0104', '321 Byte Blvd', 11),
    (5, 'Evan Davis', 55, 'Male', 'evan@mail.com', '555-0105', '654 Code Court', 12),
    (6, 'Fiona Green', 26, 'Female', 'fiona@mail.com', '555-0106', '987 Server St', 13),
    (7, 'Grace Hall', 48, 'Female', 'grace@mail.com', '555-0107', '111 Network Nook', 14),
    (8, 'Henry King', 33, 'Male', 'henry@mail.com', '555-0108', '222 Cloud Crest', 15),
    (9, 'Iris Lee', 29, 'Female', 'iris@mail.com', '555-0109', '333 Data Drive', 16),
    (10, 'Jack Miller', 51, 'Male', 'jack@mail.com', '555-0110', '444 Web Way', 17);

-- =============================================================================
-- DOCTORS (5)
-- =============================================================================
INSERT INTO doctors (id, name, specialization, email, phone, user_id) VALUES
    (1, 'Dr. Priya Patel', 'General Medicine', 'patel@hospital.org', '555-0200', 2),
    (2, 'Dr. Rajesh Singh', 'Cardiology', 'singh@hospital.org', '555-0201', 3),
    (3, 'Dr. Anjali Bhat', 'Pediatrics', 'bhat@hospital.org', '555-0202', 4),
    (4, 'Dr. Vikram Kapoor', 'Orthopedics', 'kapoor@hospital.org', '555-0203', 5),
    (5, 'Dr. Meera Ajay', 'Dermatology', 'ajay@hospital.org', '555-0204', 6);

-- =============================================================================
-- MEDICINES (12)
-- =============================================================================
INSERT INTO medicine (medicine_id, medicine_name, description, price, manufacturer) VALUES
    (1, 'Paracetamol 500mg', 'Pain reliever / fever reducer', 2.50, 'MediCorp'),
    (2, 'Amoxicillin 250mg', 'Antibiotic - bacterial infections', 45.00, 'PharmaLife'),
    (3, 'Vitamin D3 1000IU', 'Vitamin supplement', 12.00, 'SunLabs'),
    (4, 'Ibuprofen 400mg', 'Anti-inflammatory / pain relief', 8.50, 'HealthPlus'),
    (5, 'Ciprofloxacin 500mg', 'Antibiotic fluoroquinolone', 65.00, 'MediCorp'),
    (6, 'Metformin 500mg', 'Diabetes management', 18.00, 'EndoMed'),
    (7, 'Lisinopril 10mg', 'Blood pressure control', 22.00, 'CardiacCare'),
    (8, 'Omeprazole 20mg', 'Acid reflux treatment', 35.00, 'GastroMed'),
    (9, 'Azithromycin 250mg', 'Macrolide antibiotic', 52.00, 'PharmaLife'),
    (10, 'Cetirizine 10mg', 'Antihistamine allergy relief', 15.00, 'AllergenFree'),
    (11, 'Salbutamol Inhaler', 'Asthma rescue medication', 85.00, 'RespiCare'),
    (12, 'Calcium Carbonate 500mg', 'Calcium supplement', 10.00, 'BoneStrength');

-- =============================================================================
-- MEDICINE INVENTORY (High stock quantities for testing)
-- =============================================================================
INSERT INTO medicine_inventory (inventory_id, medicine_id, batch_no, quantity_available, expiry_date, reorder_level, machine_slot, last_updated) VALUES
    (1, 1, 'BATCH-PARA-001', 500, DATE '2027-12-31', 50, 'A1', NOW()),
    (2, 2, 'BATCH-AMX-042', 300, DATE '2026-08-15', 20, 'A2', NOW()),
    (3, 3, 'BATCH-D3-900', 200, DATE '2027-01-10', 30, 'B1', NOW()),
    (4, 4, 'BATCH-IBU-115', 400, DATE '2027-06-30', 40, 'B2', NOW()),
    (5, 5, 'BATCH-CIPRO-008', 150, DATE '2026-10-20', 15, 'C1', NOW()),
    (6, 6, 'BATCH-MET-223', 250, DATE '2027-05-15', 25, 'C2', NOW()),
    (7, 7, 'BATCH-LIS-334', 180, DATE '2027-03-22', 20, 'D1', NOW()),
    (8, 8, 'BATCH-OME-445', 220, DATE '2027-04-18', 25, 'D2', NOW()),
    (9, 9, 'BATCH-AZI-556', 140, DATE '2026-09-12', 15, 'E1', NOW()),
    (10, 10, 'BATCH-CET-667', 300, DATE '2027-07-25', 30, 'E2', NOW()),
    (11, 11, 'BATCH-SAL-778', 80, DATE '2027-02-14', 10, 'F1', NOW()),
    (12, 12, 'BATCH-CAL-889', 350, DATE '2027-08-30', 35, 'F2', NOW());

-- =============================================================================
-- PRESCRIPTIONS (20)
-- =============================================================================
INSERT INTO prescription (id, patient_name, diagnosis, prescribed_at, doctor_id, status, expiry_date, patient_id) VALUES
    -- Dr. Patel prescriptions
    (1, 'Alice Smith', 'Seasonal flu with fever', TIMESTAMP '2026-03-15 10:30:00', 2, 'DISPENSED', DATE '2026-04-15', 1),
    (2, 'Alice Smith', 'Vitamin D deficiency', TIMESTAMP '2026-04-01 09:00:00', 2, 'ACTIVE', DATE '2026-05-01', 1),
    (3, 'Bob Jones', 'Bacterial respiratory infection', TIMESTAMP '2026-04-02 14:00:00', 2, 'ACTIVE', DATE '2026-05-02', 2),
    (4, 'Charlie Brown', 'Headache and body pain', TIMESTAMP '2026-04-03 11:15:00', 2, 'ACTIVE', DATE '2026-05-03', 3),
    (5, 'Diana Prince', 'Urinary tract infection', TIMESTAMP '2026-04-04 08:45:00', 2, 'ACTIVE', DATE '2026-05-04', 4),
    
    -- Dr. Singh (Cardiology) prescriptions
    (6, 'Evan Davis', 'High blood pressure (Hypertension)', TIMESTAMP '2026-04-05 10:00:00', 3, 'ACTIVE', DATE '2026-05-05', 5),
    (7, 'Fiona Green', 'Chest pain assessment', TIMESTAMP '2026-04-06 13:30:00', 3, 'ACTIVE', DATE '2026-05-06', 6),
    (8, 'Grace Hall', 'Irregular heartbeat', TIMESTAMP '2026-04-07 09:20:00', 3, 'ACTIVE', DATE '2026-05-07', 7),
    
    -- Dr. Bhat (Pediatrics) prescriptions
    (9, 'Henry King', 'Common cold in children', TIMESTAMP '2026-04-08 14:45:00', 4, 'ACTIVE', DATE '2026-05-08', 8),
    (10, 'Iris Lee', 'Fever and allergy', TIMESTAMP '2026-04-09 10:30:00', 4, 'ACTIVE', DATE '2026-05-09', 9),
    
    -- Dr. Kapoor (Orthopedics) prescriptions
    (11, 'Jack Miller', 'Lower back pain', TIMESTAMP '2026-04-10 15:00:00', 5, 'ACTIVE', DATE '2026-05-10', 10),
    (12, 'Alice Smith', 'Knee joint inflammation', TIMESTAMP '2026-04-11 11:00:00', 5, 'ACTIVE', DATE '2026-05-11', 1),
    (13, 'Bob Jones', 'Shoulder strain', TIMESTAMP '2026-04-12 09:30:00', 5, 'ACTIVE', DATE '2026-05-12', 2),
    
    -- Dr. Ajay (Dermatology) prescriptions
    (14, 'Charlie Brown', 'Skin rash / allergic reaction', TIMESTAMP '2026-04-13 12:15:00', 6, 'ACTIVE', DATE '2026-05-13', 3),
    (15, 'Diana Prince', 'Acne treatment', TIMESTAMP '2026-04-14 10:45:00', 6, 'ACTIVE', DATE '2026-05-14', 4),
    
    -- More general prescriptions
    (16, 'Evan Davis', 'Acid reflux / GERD', TIMESTAMP '2026-04-15 08:00:00', 2, 'ACTIVE', DATE '2026-05-15', 5),
    (17, 'Fiona Green', 'Diabetes management', TIMESTAMP '2026-04-16 13:20:00', 2, 'ACTIVE', DATE '2026-05-16', 6),
    (18, 'Grace Hall', 'Asthma maintenance', TIMESTAMP '2026-04-17 09:50:00', 4, 'ACTIVE', DATE '2026-05-17', 7),
    (19, 'Henry King', 'Allergies - chronic', TIMESTAMP '2026-04-18 11:30:00', 4, 'ACTIVE', DATE '2026-05-18', 8),
    (20, 'Iris Lee', 'Bone health supplement', TIMESTAMP '2026-04-19 14:00:00', 3, 'ACTIVE', DATE '2026-05-19', 9);

-- =============================================================================
-- PRESCRIPTION ITEMS (Link prescriptions to medicines)
-- =============================================================================
INSERT INTO prescription_item (id, prescription_id, medicine_id, quantity) VALUES
    -- Prescription 1: Paracetamol
    (1, 1, 1, 10),
    
    -- Prescription 2: Vitamin D
    (2, 2, 3, 30),
    
    -- Prescription 3: Amoxicillin
    (3, 3, 2, 20),
    
    -- Prescription 4: Ibuprofen
    (4, 4, 4, 15),
    
    -- Prescription 5: Ciprofloxacin
    (5, 5, 5, 10),
    
    -- Prescription 6: Lisinopril (BP control)
    (6, 6, 7, 30),
    
    -- Prescription 7: Multiple items
    (7, 7, 4, 10),
    (8, 7, 3, 20),
    
    -- Prescription 8: Lisinopril
    (9, 8, 7, 30),
    
    -- Prescription 9: Paracetamol
    (10, 9, 1, 10),
    
    -- Prescription 10: Cetirizine + Paracetamol
    (11, 10, 10, 15),
    (12, 10, 1, 8),
    
    -- Prescription 11: Ibuprofen
    (13, 11, 4, 20),
    
    -- Prescription 12: Ibuprofen
    (14, 12, 4, 15),
    
    -- Prescription 13: Paracetamol
    (15, 13, 1, 10),
    
    -- Prescription 14: Cetirizine (skin rash)
    (16, 14, 10, 15),
    
    -- Prescription 15: Multiple items
    (17, 15, 10, 20),
    (18, 15, 4, 15),
    
    -- Prescription 16: Omeprazole
    (19, 16, 8, 30),
    
    -- Prescription 17: Metformin
    (20, 17, 6, 60),
    
    -- Prescription 18: Salbutamol
    (21, 18, 11, 1),
    
    -- Prescription 19: Cetirizine
    (22, 19, 10, 30),
    
    -- Prescription 20: Calcium Carbonate
    (23, 20, 12, 60);

COMMIT;

-- Verify data insertion
SELECT 'MEDICINES' as entity, COUNT(*) as count FROM medicine UNION ALL
SELECT 'INVENTORY', COUNT(*) FROM medicine_inventory UNION ALL
SELECT 'DOCTORS', COUNT(*) FROM doctors UNION ALL
SELECT 'PATIENTS', COUNT(*) FROM patients UNION ALL
SELECT 'PRESCRIPTIONS', COUNT(*) FROM prescription UNION ALL
SELECT 'PRESCRIPTION ITEMS', COUNT(*) FROM prescription_item;
