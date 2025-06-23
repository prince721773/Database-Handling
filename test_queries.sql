-- Formatting Setup
SET LINESIZE 150
SET PAGESIZE 50
SET COLSEP " | "
COLUMN TRADE_NAME FORMAT A20
COLUMN FORMULA FORMAT A30
COLUMN COMPANY_NAME FORMAT A20
COLUMN PRESCRIPTION_DATE FORMAT A12
COLUMN NAME FORMAT A25
COLUMN ADDRESS FORMAT A40
SET SERVEROUTPUT ON
SET VERIFY OFF

-- 1. Add/Update/Delete Pharmacy (Test)
EXEC ManagePharmacy('ADD', 'Test Pharmacy', '123 Test Lane', '+91-9999999999');
SELECT * FROM Pharmacy WHERE Name = 'Test Pharmacy';

--Test for Prescribe
-- Test 1: Add new prescription
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'Metformin', 'Biocon', DATE '2025-04-22', 2);
SELECT * FROM Prescribes WHERE PatientID = '112233445566' AND DoctorID = '798512347812' AND Trade_Name = 'Metformin' AND Company_Name = 'Biocon';

-- Test 1.1: Duplicate:
-- Should fail: Prescription for this doctor, patient, and date already exists
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'Metformin', 'Biocon', DATE '2025-04-22', 2);
-- Expected output: Error about duplicate prescription

--Attempt to Add Prescription When a Newer One Exists
-- Insert a prescription with a future date
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'Metformin', 'Biocon', DATE '2025-06-01', 5);
-- Now try to add an older prescription for the same doctor and patient
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'Metformin', 'Biocon', DATE '2025-05-01', 3);
-- Expected output: Error about newer prescription already existing

-- Insert an old prescription
EXEC ManagePrescription('ADD', '223344556677', '234567894567', 'Saridon', 'Cipla', DATE '2025-04-01', 2);

-- Insert a newer prescription (should delete the old one)
EXEC ManagePrescription('ADD', '223344556677', '234567894567', 'Saridon', 'Cipla', DATE '2025-04-15', 2);

-- Check only the latest prescription exists
SELECT * FROM Prescribes WHERE PatientID = '223344556677' AND DoctorID = '234567894567' AND Trade_Name = 'Saridon' AND Company_Name = 'Cipla';

-- Should succeed: Different drug, same doctor/patient/date
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'Dolo 650', 'Sun Pharma', DATE '2025-04-22', 1);
SELECT * FROM Prescribes WHERE PatientID = '112233445566' AND DoctorID = '798512347812' AND Trade_Name = 'Dolo 650' AND Company_Name = 'Sun Pharma';

-- Should fail: Patient does not exist
EXEC ManagePrescription('ADD', '000000000000', '798512347812', 'Metformin', 'Biocon', DATE '2025-04-22', 1);

-- Should fail: Doctor does not exist
EXEC ManagePrescription('ADD', '112233445566', '000000000000', 'Metformin', 'Biocon', DATE '2025-04-22', 1);

-- Should fail: Drug/Company does not exist
EXEC ManagePrescription('ADD', '112233445566', '798512347812', 'NonexistentDrug', 'FakeCompany', DATE '2025-04-22', 1);

-- Should succeed: Update quantity and date
EXEC ManagePrescription('UPDATE', '112233445566', '798512347812', 'Metformin', 'Biocon', DATE '2025-04-23', 4);
SELECT * FROM Prescribes WHERE PatientID = '112233445566' AND DoctorID = '798512347812' AND Trade_Name = 'Metformin' AND Company_Name = 'Biocon';

-- Should succeed: Delete existing prescription
EXEC ManagePrescription('DELETE', '112233445566', '798512347812', 'Metformin', 'Biocon');
SELECT * FROM Prescribes WHERE PatientID = '112233445566' AND DoctorID = '798512347812' AND Trade_Name = 'Metformin' AND Company_Name = 'Biocon';

-- Should output an error or a message indicating no such prescription
EXEC ManagePrescription('UPDATE', '000000000000', '000000000000', 'FakeDrug', 'FakeCompany', DATE '2025-04-22', 1);
EXEC ManagePrescription('DELETE', '000000000000', '000000000000', 'FakeDrug', 'FakeCompany');


-- 2. Prescription Report for Patient 876543210987 (April 2025)
EXEC patient_prescriptions_report('876543210987', DATE '2025-04-01', DATE '2025-04-30');




-- 3. Prescription Details for Patient 876543210987 on 2025-04-11
-- Test 1: Valid prescription (from insert_data.sql)
EXEC PrintPrescriptionDetails('876543210987', DATE '2025-04-22');

-- Expected Output:
-- Prescription Details for Anika Trivedi
-- Date: 22-APR-2025
-- -------------------------------------------
-- Doctor: Dr. Swati Mishra
-- Specialty: Pediatrics
-- Medication: Cetirizine
-- Company: Natco
-- Formula: C21H25ClN2O5
-- Quantity: 3
-------------------------------------------


-- Test 2: No prescriptions
EXEC PrintPrescriptionDetails('876543210987', DATE '2025-01-01');

-- Expected Output:
-- No prescriptions found for this date

-- Test 3: Invalid patient
EXEC PrintPrescriptionDetails('000000000000', SYSDATE);

-- Expected Output:
-- Error: Patient 000000000000 not found




-- 4. Drugs by Sun Pharma
VARIABLE drugs REFCURSOR
EXEC :drugs := GetCompanyDrugs('Sun Pharma');
PRINT drugs

-- 5. Stock Position of Apollo Pharmacy
VARIABLE stock REFCURSOR
EXEC GetStockPosition('Apollo Pharmacy', :stock);
PRINT stock

-- 6. Contact Details for Apollo Pharmacy & Sun Pharma
VARIABLE ph_phone VARCHAR2(15)
VARIABLE co_phone VARCHAR2(15)
EXEC GetContactDetails('Apollo Pharmacy', 'Sun Pharma', :ph_phone, :co_phone);
PRINT ph_phone
PRINT co_phone

-- 7. Patients for Doctor 123456789012 (Dr. Alok Pandey)
VARIABLE patients REFCURSOR
EXEC :patients := GetDoctorPatients('123456789012');
PRINT patients

