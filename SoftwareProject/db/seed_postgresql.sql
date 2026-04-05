-- =============================================================================
-- AMDS sample data for PostgreSQL (matches SoftwareProject JPA entities)
-- =============================================================================
-- Login passwords (BCrypt): all demo accounts use plain text password:  password
--   admin / drpatel / pharma1 / alice / bob  ->  password
--
-- Tables covered by THIS app (see model package):
--   users, patients, doctors, medicine, medicine_inventory,
--   prescription, prescription_item, dispense_log
--
-- If pgAdmin shows extra tables (appointments, medicines, prescriptions, …)
-- they are NOT mapped by the current Java project. Either drop them or seed
-- separately once you know their columns.
-- =============================================================================

BEGIN;

-- Clear existing rows (respect FK order). Uncomment if you want a clean reload.
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

-- -----------------------------------------------------------------------------
-- users  (role enum strings: ROLE_ADMIN, ROLE_DOCTOR, ROLE_PHARMACIST, ROLE_PATIENT)
-- -----------------------------------------------------------------------------
INSERT INTO users (id, username, password, role) VALUES
    (1, 'admin',
     '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm',
     'ROLE_ADMIN'),
    (2, 'drpatel',
     '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm',
     'ROLE_DOCTOR'),
    (3, 'pharma1',
     '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm',
     'ROLE_PHARMACIST'),
    (4, 'alice',
     '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm',
     'ROLE_PATIENT'),
    (5, 'bob',
     '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31jm',
     'ROLE_PATIENT');

-- -----------------------------------------------------------------------------
-- patients  (user_id -> users.id, email unique)
-- -----------------------------------------------------------------------------
INSERT INTO patients (id, name, age, gender, email, phone, address, user_id) VALUES
    (1, 'Alice Smith', 28, 'Female', 'alice.smith@example.com', '555-0101',
     '123 Neon St, Cyber City', 4),
    (2, 'Bob Jones', 35, 'Male', 'bob.jones@example.com', '555-0102',
     '456 Grid Ave, Tech Park', 5);

-- -----------------------------------------------------------------------------
-- doctors  (user_id -> users.id, email unique)
-- -----------------------------------------------------------------------------
INSERT INTO doctors (id, name, specialization, email, phone, user_id) VALUES
    (1, 'Dr. Priya Patel', 'General Medicine', 'dr.patel@hospital.org', '555-0200', 2);

-- -----------------------------------------------------------------------------
-- medicine  (PK column: medicine_id)
-- -----------------------------------------------------------------------------
INSERT INTO medicine (medicine_id, medicine_name, description, price, manufacturer) VALUES
    (1, 'Paracetamol 500mg', 'Analgesic / antipyretic', 2.50, 'MediCorp'),
    (2, 'Amoxicillin 250mg', 'Antibiotic capsule', 45.00, 'PharmaLife'),
    (3, 'Vitamin D3 1000IU', 'Cholecalciferol supplement', 12.00, 'SunLabs');

-- -----------------------------------------------------------------------------
-- medicine_inventory
-- -----------------------------------------------------------------------------
INSERT INTO medicine_inventory (
    inventory_id, medicine_id, batch_no, quantity_available, expiry_date,
    reorder_level, machine_slot, last_updated
) VALUES
    (1, 1, 'BATCH-PARA-001', 500, DATE '2027-12-31', 50, 'A1', NOW()),
    (2, 2, 'BATCH-AMX-042', 120, DATE '2026-08-15', 20, 'A2', NOW()),
    (3, 3, 'BATCH-D3-900', 200, DATE '2027-01-10', 30, 'B1', NOW());

-- -----------------------------------------------------------------------------
-- prescription  (doctor_id -> users.id, patient_id -> patients.id)
-- -----------------------------------------------------------------------------
INSERT INTO prescription (
    id, patient_name, diagnosis, prescribed_at, doctor_id, status, expiry_date, patient_id
) VALUES
    (1, 'Alice Smith', 'Seasonal flu with fever',
     TIMESTAMP '2026-03-15 10:30:00', 2, 'DISPENSED', DATE '2026-04-15', 1),
    (2, 'Alice Smith', 'Vitamin D deficiency',
     TIMESTAMP '2026-04-01 09:00:00', 2, 'ACTIVE', DATE '2026-05-01', 1),
    (3, 'Bob Jones', 'Bacterial respiratory infection',
     TIMESTAMP '2026-04-02 14:00:00', 2, 'ACTIVE', DATE '2026-05-02', 2);

-- -----------------------------------------------------------------------------
-- prescription_item  (prescription_id, medicine_id -> medicine.medicine_id)
-- -----------------------------------------------------------------------------
INSERT INTO prescription_item (id, prescription_id, medicine_id, quantity) VALUES
    (1, 1, 1, 20),
    (2, 1, 3, 30),
    (3, 2, 3, 60),
    (4, 3, 2, 14);

-- -----------------------------------------------------------------------------
-- dispense_log  (user_id = pharmacist who dispensed)
-- -----------------------------------------------------------------------------
INSERT INTO dispense_log (
    log_id, prescription_id, medicine_id, patient_id, user_id,
    quantity_dispensed, dispense_time, status
) VALUES
    (1, 1, 1, 1, 3, 20, TIMESTAMP '2026-03-16 11:05:00', 'SUCCESS'),
    (2, 1, 3, 1, 3, 30, TIMESTAMP '2026-03-16 11:06:00', 'SUCCESS');

-- Keep SERIAL/IDENTITY in sync after manual IDs
SELECT setval(pg_get_serial_sequence('users', 'id'), (SELECT COALESCE(MAX(id), 1) FROM users));
SELECT setval(pg_get_serial_sequence('patients', 'id'), (SELECT COALESCE(MAX(id), 1) FROM patients));
SELECT setval(pg_get_serial_sequence('doctors', 'id'), (SELECT COALESCE(MAX(id), 1) FROM doctors));
SELECT setval(pg_get_serial_sequence('medicine', 'medicine_id'), (SELECT COALESCE(MAX(medicine_id), 1) FROM medicine));
SELECT setval(pg_get_serial_sequence('medicine_inventory', 'inventory_id'), (SELECT COALESCE(MAX(inventory_id), 1) FROM medicine_inventory));
SELECT setval(pg_get_serial_sequence('prescription', 'id'), (SELECT COALESCE(MAX(id), 1) FROM prescription));
SELECT setval(pg_get_serial_sequence('prescription_item', 'id'), (SELECT COALESCE(MAX(id), 1) FROM prescription_item));
SELECT setval(pg_get_serial_sequence('dispense_log', 'log_id'), (SELECT COALESCE(MAX(log_id), 1) FROM dispense_log));

COMMIT;

-- =============================================================================
-- Quick checks
-- =============================================================================
-- SELECT * FROM users;
-- SELECT * FROM patients;
-- SELECT * FROM prescription;
-- SELECT * FROM dispense_log;
