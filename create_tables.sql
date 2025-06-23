DROP TABLE Prescribes CASCADE CONSTRAINTS;
DROP TABLE Sells CASCADE CONSTRAINTS;
DROP TABLE Contract CASCADE CONSTRAINTS;
DROP TABLE Drug CASCADE CONSTRAINTS;
DROP TABLE Pharmacy CASCADE CONSTRAINTS;
DROP TABLE PharmaceuticalCompany CASCADE CONSTRAINTS;
DROP TABLE Patient CASCADE CONSTRAINTS;
DROP TABLE Doctor CASCADE CONSTRAINTS;
CREATE TABLE Doctor (
    AadharID CHAR(12) PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Specialty VARCHAR2(100),
    YearsOfExperience INT
);

CREATE TABLE Patient (
    AadharID CHAR(12) PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Address VARCHAR2(1000), 
    Age INT,
    PrimaryPhysicianID CHAR(12),
    FOREIGN KEY (PrimaryPhysicianID) REFERENCES Doctor(AadharID)
);

CREATE TABLE PharmaceuticalCompany (
    Company_Name VARCHAR2(100) PRIMARY KEY,
    Phone_Number VARCHAR2(15)
);

CREATE TABLE Drug (
    Trade_Name VARCHAR2(100),
    Formula VARCHAR2(1000), 
    Company_Name VARCHAR2(100),
    PRIMARY KEY (Trade_Name, Company_Name),
    FOREIGN KEY (Company_Name) REFERENCES PharmaceuticalCompany(Company_Name)
        ON DELETE CASCADE
);

CREATE TABLE Pharmacy (
    Name VARCHAR2(100) PRIMARY KEY,
    Address VARCHAR2(1000), 
    PhoneNumber VARCHAR2(15)
);

CREATE TABLE Sells (
    Pharmacy_Name VARCHAR2(100),
    Trade_Name VARCHAR2(100),
    Company_Name VARCHAR2(100),
    Price DECIMAL(10, 2),
    PRIMARY KEY (Pharmacy_Name, Trade_Name, Company_Name),
    FOREIGN KEY (Pharmacy_Name) REFERENCES Pharmacy(Name),
    FOREIGN KEY (Trade_Name, Company_Name) REFERENCES Drug(Trade_Name, Company_Name)
);

CREATE TABLE Prescribes (
    PatientID CHAR(12),
    DoctorID CHAR(12),
    Trade_Name VARCHAR2(100),
    Company_Name VARCHAR2(100),
    Prescription_Date DATE,
    Quantity INT,
    PRIMARY KEY (PatientID, DoctorID, Trade_Name, Company_Name),
    FOREIGN KEY (PatientID) REFERENCES Patient (AadharID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor (AadharID),
    FOREIGN KEY (Trade_Name, Company_Name) REFERENCES Drug(Trade_Name, Company_Name)
        ON DELETE CASCADE
);

CREATE TABLE Contract (
    Pharmacy_Name VARCHAR2(100),
    Company_Name VARCHAR2(100),
    Start_Date DATE,
    End_Date DATE,
    Content VARCHAR2(2000), 
    SupervisorID CHAR(12),
    PRIMARY KEY (Pharmacy_Name, Company_Name),
    FOREIGN KEY (Pharmacy_Name) REFERENCES Pharmacy(Name),
    FOREIGN KEY (Company_Name) REFERENCES PharmaceuticalCompany(Company_Name)
);
@"D:/Bits Hyderabad_Campus Diaries/DBMS Project/insert_data.sql"