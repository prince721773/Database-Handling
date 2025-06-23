-- 1. Add/Update/Delete Pharmacy
CREATE OR REPLACE PROCEDURE ManagePharmacy(
    p_action VARCHAR2,
    p_name VARCHAR2,
    p_address VARCHAR2 DEFAULT NULL,
    p_phone VARCHAR2 DEFAULT NULL
) IS
    v_count NUMBER;
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO Pharmacy VALUES (p_name, p_address, p_phone);
            DBMS_OUTPUT.PUT_LINE('Pharmacy added: ' || p_name);
        WHEN 'UPDATE' THEN
            UPDATE Pharmacy SET Address = p_address, PhoneNumber = p_phone WHERE Name = p_name;
            DBMS_OUTPUT.PUT_LINE('Pharmacy updated: ' || p_name);
        WHEN 'DELETE' THEN
            DELETE FROM Pharmacy WHERE Name = p_name;
            DBMS_OUTPUT.PUT_LINE('Pharmacy deleted: ' || p_name);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unknown action: ' || p_action);
    END CASE;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in ManagePharmacy: ' || SQLERRM);
END;
/

-- 1. Add/Update/Delete Doctor
CREATE OR REPLACE PROCEDURE ManageDoctor(
    p_action VARCHAR2,
    p_id CHAR,
    p_name VARCHAR2 DEFAULT NULL,
    p_specialty VARCHAR2 DEFAULT NULL,
    p_experience INT DEFAULT NULL
) IS
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO Doctor VALUES (p_id, p_name, p_specialty, p_experience);
            DBMS_OUTPUT.PUT_LINE('Doctor added: ' || p_name);
        WHEN 'UPDATE' THEN
            UPDATE Doctor SET Name = p_name, Specialty = p_specialty, YearsOfExperience = p_experience WHERE AadharID = p_id;
            DBMS_OUTPUT.PUT_LINE('Doctor updated: ' || p_id);
        WHEN 'DELETE' THEN
            DELETE FROM Doctor WHERE AadharID = p_id;
            DBMS_OUTPUT.PUT_LINE('Doctor deleted: ' || p_id);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unknown action: ' || p_action);
    END CASE;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in ManageDoctor: ' || SQLERRM);
END;
/

-- 1. Add/Update/Delete Patient
CREATE OR REPLACE PROCEDURE ManagePatient(
    p_action VARCHAR2,
    p_id CHAR,
    p_name VARCHAR2 DEFAULT NULL,
    p_address VARCHAR2 DEFAULT NULL,
    p_age INT DEFAULT NULL,
    p_physician CHAR DEFAULT NULL
) IS
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO Patient VALUES (p_id, p_name, p_address, p_age, p_physician);
            DBMS_OUTPUT.PUT_LINE('Patient added: ' || p_name);
        WHEN 'UPDATE' THEN
            UPDATE Patient SET Name = p_name, Address = p_address, Age = p_age, PrimaryPhysicianID = p_physician WHERE AadharID = p_id;
            DBMS_OUTPUT.PUT_LINE('Patient updated: ' || p_id);
        WHEN 'DELETE' THEN
            DELETE FROM Patient WHERE AadharID = p_id;
            DBMS_OUTPUT.PUT_LINE('Patient deleted: ' || p_id);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unknown action: ' || p_action);
    END CASE;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in ManagePatient: ' || SQLERRM);
END;
/

-- 1. Add/Update/Delete PharmaceuticalCompany
CREATE OR REPLACE PROCEDURE ManageCompany(
    p_action VARCHAR2,
    p_name VARCHAR2,
    p_phone VARCHAR2 DEFAULT NULL
) IS
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO PharmaceuticalCompany VALUES (p_name, p_phone);
            DBMS_OUTPUT.PUT_LINE('Company added: ' || p_name);
        WHEN 'UPDATE' THEN
            UPDATE PharmaceuticalCompany SET Phone_Number = p_phone WHERE Company_Name = p_name;
            DBMS_OUTPUT.PUT_LINE('Company updated: ' || p_name);
        WHEN 'DELETE' THEN
            DELETE FROM PharmaceuticalCompany WHERE Company_Name = p_name;
            DBMS_OUTPUT.PUT_LINE('Company deleted: ' || p_name);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unknown action: ' || p_action);
    END CASE;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in ManageCompany: ' || SQLERRM);
END;
/

-- 1. Add/Update/Delete Drug
CREATE OR REPLACE PROCEDURE ManageDrug(
    p_action VARCHAR2,
    p_trade_name VARCHAR2,
    p_formula VARCHAR2 DEFAULT NULL,
    p_company VARCHAR2 DEFAULT NULL
) IS
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO Drug VALUES (p_trade_name, p_formula, p_company);
            DBMS_OUTPUT.PUT_LINE('Drug added: ' || p_trade_name);
        WHEN 'UPDATE' THEN
            UPDATE Drug SET Formula = p_formula WHERE Trade_Name = p_trade_name AND Company_Name = p_company;
            DBMS_OUTPUT.PUT_LINE('Drug updated: ' || p_trade_name);
        WHEN 'DELETE' THEN
            DELETE FROM Drug WHERE Trade_Name = p_trade_name AND Company_Name = p_company;
            DBMS_OUTPUT.PUT_LINE('Drug deleted: ' || p_trade_name);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unknown action: ' || p_action);
    END CASE;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in ManageDrug: ' || SQLERRM);
END;
/

-- 1. Add/Update/Delete Contract
CREATE OR REPLACE PROCEDURE ManageContract(
    p_action VARCHAR2,
    p_pharmacy VARCHAR2,
    p_company VARCHAR2,
    p_start_date DATE DEFAULT NULL,
    p_end_date DATE DEFAULT NULL,
    p_content VARCHAR2 DEFAULT NULL,
    p_supervisor CHAR DEFAULT NULL
) IS
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            INSERT INTO Contract VALUES (p_pharmacy, p_company, p_start_date, p_end_date, p_content, p_supervisor);
            DBMS_OUTPUT.PUT_LINE('Contract added: ' || p_pharmacy || ' - ' || p_company);
        WHEN 'UPDATE' THEN
            UPDATE Contract SET Start_Date = p_start_date, End_Date = p_end_date, Content = p_content, SupervisorID = p_supervisor
            WHERE Pharmacy_Name = p_pharmacy AND Company_Name = p_company;
            DBMS_OUTPUT.PUT_LINE('Contract updated: ' || p_pharmacy || ' - ' || p_company);
        WHEN 'DELETE' THEN
            DELETE FROM Contract WHERE Pharmacy_Name = p_pharmacy AND Company_Name = p_company;
            DBMS_OUTPUT.PUT_LINE('Contract deleted: ' || p_pharmacy || ' - ' || p_company);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unknown action: ' || p_action);
    END CASE;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in ManageContract: ' || SQLERRM);
END;
/

--Add/Delete/Update Prescriptions

CREATE OR REPLACE PROCEDURE ManagePrescription(
    p_action VARCHAR2,
    p_patient_id CHAR,
    p_doctor_id CHAR,
    p_trade_name VARCHAR2,
    p_company VARCHAR2,
    p_prescription_date DATE DEFAULT NULL,
    p_quantity INT DEFAULT NULL
) IS
    v_count NUMBER;
BEGIN
    CASE UPPER(p_action)
        WHEN 'ADD' THEN
            -- Check for existing prescription on same date
            SELECT COUNT(*) INTO v_count FROM Prescribes
            WHERE PatientID = p_patient_id
            AND DoctorID = p_doctor_id
            AND Prescription_Date = p_prescription_date;

            IF v_count > 0 THEN
                DBMS_OUTPUT.PUT_LINE('Error: Prescription already exists for this patient, doctor, and date.');
                RETURN;
            END IF;

            -- Check for newer prescriptions
            SELECT COUNT(*) INTO v_count FROM Prescribes
            WHERE PatientID = p_patient_id
            AND DoctorID = p_doctor_id
            AND Prescription_Date > p_prescription_date;

            IF v_count > 0 THEN
                DBMS_OUTPUT.PUT_LINE('Error: Newer prescription exists for this patient and doctor.');
                RETURN;
            END IF;

            -- Delete older prescriptions
            DELETE FROM Prescribes
            WHERE PatientID = p_patient_id
            AND DoctorID = p_doctor_id
            AND Prescription_Date < p_prescription_date;

            -- Insert new prescription
            INSERT INTO Prescribes VALUES (
                p_patient_id,
                p_doctor_id,
                p_trade_name,
                p_company,
                p_prescription_date,
                p_quantity
            );
            DBMS_OUTPUT.PUT_LINE('Prescription added for patient ' || p_patient_id);

        WHEN 'UPDATE' THEN
            UPDATE Prescribes SET
                Prescription_Date = p_prescription_date,
                Quantity = p_quantity
            WHERE PatientID = p_patient_id
            AND DoctorID = p_doctor_id
            AND Trade_Name = p_trade_name
            AND Company_Name = p_company;
            DBMS_OUTPUT.PUT_LINE('Prescription updated for patient ' || p_patient_id);

        WHEN 'DELETE' THEN
            DELETE FROM Prescribes
            WHERE PatientID = p_patient_id
            AND DoctorID = p_doctor_id
            AND Trade_Name = p_trade_name
            AND Company_Name = p_company;
            DBMS_OUTPUT.PUT_LINE('Prescription deleted for patient ' || p_patient_id);

        ELSE
            DBMS_OUTPUT.PUT_LINE('Unknown action: ' || p_action);
    END CASE;
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Prescription already exists with identical details.');
    WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            DBMS_OUTPUT.PUT_LINE('Error: Invalid patient or doctor ID.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END IF;
END;
/

--2 Generate Prescription Reports
CREATE OR REPLACE PROCEDURE patient_prescriptions_report(
    p_patient_id CHAR,
    p_start_date DATE,
    p_end_date DATE
) AS
    CURSOR c_prescriptions IS
        SELECT p.DoctorID, p.Prescription_Date, 
               d.Name AS DoctorName, d.Specialty,
               p.Trade_Name, p.Company_Name, p.Quantity
        FROM Prescribes p
        JOIN Doctor d ON p.DoctorID = d.AadharID
        WHERE p.PatientID = p_patient_id
        AND p.Prescription_Date BETWEEN p_start_date AND p_end_date
        ORDER BY p.Prescription_Date DESC;
    
    v_patient_name Patient.Name%TYPE;
    v_found BOOLEAN := FALSE;
BEGIN
    -- Get patient name
    SELECT Name INTO v_patient_name FROM Patient 
    WHERE AadharID = p_patient_id;
    
    DBMS_OUTPUT.PUT_LINE('==================================================');
    DBMS_OUTPUT.PUT_LINE('Prescription Report for Patient: ' || v_patient_name);
    DBMS_OUTPUT.PUT_LINE('Period: ' || TO_CHAR(p_start_date, 'DD-MON-YYYY') || 
                       ' to ' || TO_CHAR(p_end_date, 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('==================================================');
    
    FOR r_pres IN c_prescriptions LOOP
        v_found := TRUE;
        DBMS_OUTPUT.PUT_LINE('Date: ' || TO_CHAR(r_pres.Prescription_Date, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('Doctor: ' || r_pres.DoctorName || ' (' || r_pres.Specialty || ')');
        DBMS_OUTPUT.PUT_LINE('Medication: ' || r_pres.Trade_Name || 
                           ' (' || r_pres.Company_Name || ')');
        DBMS_OUTPUT.PUT_LINE('Quantity: ' || r_pres.Quantity);
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    END LOOP;
    
    IF NOT v_found THEN
        DBMS_OUTPUT.PUT_LINE('No prescriptions found for this period');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Patient ' || p_patient_id || ' not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/



-- 3. Print details of a prescription for a given patient for a given date
BEGIN
   EXECUTE IMMEDIATE 'DROP PROCEDURE print_prescription_details_by_date';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -4043 THEN
         RAISE;
      END IF;
END;
/
CREATE OR REPLACE PROCEDURE PrintPrescriptionDetails(
    p_patient_id IN CHAR,
    p_presc_date IN DATE
) AS
    v_patient_name Patient.Name%TYPE;
    v_doctor_name Doctor.Name%TYPE;
    v_specialty Doctor.Specialty%TYPE;
    v_trade_name Prescribes.Trade_Name%TYPE;
    v_company_name Prescribes.Company_Name%TYPE;
    v_formula Drug.Formula%TYPE;
    v_quantity Prescribes.Quantity%TYPE;
    v_found BOOLEAN := FALSE;
BEGIN
    -- Get patient name
    SELECT Name INTO v_patient_name FROM Patient WHERE AadharID = p_patient_id;

    -- Fetch prescription details
    FOR rec IN (
        SELECT d.Name AS doctor_name, d.Specialty, p.Trade_Name, p.Company_Name, dr.Formula, p.Quantity
        FROM Prescribes p
        JOIN Doctor d ON p.DoctorID = d.AadharID
        JOIN Drug dr ON p.Trade_Name = dr.Trade_Name AND p.Company_Name = dr.Company_Name
        WHERE p.PatientID = p_patient_id AND p.Prescription_Date = p_presc_date
    ) LOOP
        v_found := TRUE;
        DBMS_OUTPUT.PUT_LINE('Prescription Details for ' || v_patient_name);
        DBMS_OUTPUT.PUT_LINE('Doctor: ' || rec.doctor_name);
        DBMS_OUTPUT.PUT_LINE('Specialty: ' || rec.Specialty);
        DBMS_OUTPUT.PUT_LINE('Medication: ' || rec.Trade_Name);
        DBMS_OUTPUT.PUT_LINE('Company: ' || rec.Company_Name);
        DBMS_OUTPUT.PUT_LINE('Formula: ' || rec.Formula);
        DBMS_OUTPUT.PUT_LINE('Quantity: ' || rec.Quantity);
    END LOOP;

    IF NOT v_found THEN
        DBMS_OUTPUT.PUT_LINE('No prescriptions found for this date');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Patient ' || p_patient_id || ' not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/



-- 4. Get the details of drugs produced by a pharmaceutical company
CREATE OR REPLACE FUNCTION GetCompanyDrugs(
    p_company VARCHAR2
) RETURN SYS_REFCURSOR
IS
    v_drugs SYS_REFCURSOR;
BEGIN
    OPEN v_drugs FOR
        SELECT Trade_Name, Formula
        FROM Drug
        WHERE Company_Name = p_company;
    RETURN v_drugs;
END;
/

-- 5. Print the stock position of a pharmacy
CREATE OR REPLACE PROCEDURE GetStockPosition(
    p_pharmacy VARCHAR2,
    p_stock OUT SYS_REFCURSOR
) IS
BEGIN
    OPEN p_stock FOR
        SELECT s.Trade_Name, s.Company_Name, s.Price
        FROM Sells s
        WHERE s.Pharmacy_Name = p_pharmacy;
END;
/

-- 6. Print the contact details of a pharmacy-pharmaceutical company
CREATE OR REPLACE PROCEDURE GetContactDetails(
    p_pharmacy VARCHAR2,
    p_company VARCHAR2,
    p_pharmacy_phone OUT VARCHAR2,
    p_company_phone OUT VARCHAR2
) IS
BEGIN
    SELECT ph.PhoneNumber, pc.Phone_Number
    INTO p_pharmacy_phone, p_company_phone
    FROM Pharmacy ph, PharmaceuticalCompany pc
    WHERE ph.Name = p_pharmacy
    AND pc.Company_Name = p_company;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No contact details found');
END;
/

-- 7. Print the list of patients for a given doctor
CREATE OR REPLACE FUNCTION GetDoctorPatients(
    p_doctor_id CHAR
) RETURN SYS_REFCURSOR
IS
    v_patients SYS_REFCURSOR;
BEGIN
    OPEN v_patients FOR
        SELECT p.Name, p.Age, p.Address
        FROM Patient p
        WHERE p.PrimaryPhysicianID = p_doctor_id;
    RETURN v_patients;
END;
/