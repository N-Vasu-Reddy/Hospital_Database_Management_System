CREATE DATABASE IF NOT EXISTS Hospital_DB ;
USE Hospital_DB;
CREATE TABLE Patient (
    Patient_ID INT NOT NULL,
    Patient_FName VARCHAR(20) NOT NULL,
    Patient_LName VARCHAR(20) NOT NULL,
    Phone VARCHAR(12) NOT NULL,
    Blood_Type  VARCHAR(5) NOT NULL,
    Email VARCHAR(50),
    Gender  VARCHAR(10),
    Condition_ VARCHAR(30),
    Admission_Date DATE,
    Discharge_Date DATE,
    PRIMARY KEY (Patient_ID) 
    );

CREATE TABLE Department (
    Dept_ID INT NOT NULL,
    Dept_Head VARCHAR(20) NOT NULL,
    Dept_Name VARCHAR(15) NOT NULL,
    Emp_Count INT,
    PRIMARY  KEY (Dept_ID) 
  );

CREATE TABLE Staff (
    Emp_ID INT  NOT NULL,
    Emp_FName  VARCHAR(20) NOT NULL,
    Emp_LName  VARCHAR(20) NOT NULL,
    Date_Joining  DATE,
    Date_Seperation DATE,
    Emp_Type VARCHAR(15) NOT NULL,
    Email  VARCHAR(50),
    Address  VARCHAR(50) NOT NULL,
    Dept_ID  INT NOT NULL,
    SSN  INT NOT NULL,
    PRIMARY KEY (Emp_ID),
    FOREIGN KEY (Dept_ID) REFERENCES Department  (Dept_ID)
);

CREATE TABLE Doctor (
    Doctor_ID INT NOT NULL,
    Qualifications VARCHAR(15) NOT NULL,
    Emp_ID INT NOT NULL,
    Specialization VARCHAR(20) NOT NULL,
    Dept_ID INT NOT NULL,
    PRIMARY KEY (Doctor_ID),
    FOREIGN KEY (Emp_ID) REFERENCES Staff (Emp_ID),
    FOREIGN KEY (Dept_ID) REFERENCES Department (Dept_ID)
);

CREATE TABLE Nurse (
    Nurse_ID INT  NOT NULL,
    Patient_ID  INT  NOT NULL,
    Emp_ID  INT NOT NULL,
    Dept_ID INT NOT NULL,
    PRIMARY KEY(Nurse_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID),
    FOREIGN KEY (Emp_ID) REFERENCES Staff  (Emp_ID),
    FOREIGN KEY (Dept_ID) REFERENCES Department (Dept_ID)
);

CREATE TABLE Emergency_Contact(
    Contact_ID INT  NOT NULL,
    Contact_Name VARCHAR(20) NOT NULL,
    Phone VARCHAR(12) NOT NULL,
    Relation VARCHAR(20) NOT NULL,
    Patient_ID  INT NOT NULL,
    PRIMARY KEY (Contact_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID)
);

  CREATE TABLE Payroll (
    Account_No VARCHAR(25) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    Bonus DECIMAL(10,2),
    Emp_ID INT NOT NULL,
    IBAN VARCHAR(25),
    PRIMARY KEY (Account_No),
    FOREIGN KEY (Emp_ID) REFERENCES Staff (Emp_ID)
   );

 CREATE TABLE  Lab_Screening (
    Lab_ID INT NOT NULL,
    Patient_ID  INT  NOT NULL,
    Technician_ID  INT  NOT NULL,
    Doctor_ID  INT NOT NULL,
    Test_Cost  DECIMAL(10,2),
    Date  DATE  NOT NULL,
    PRIMARY KEY (Lab_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor (Doctor_ID)
);

CREATE TABLE Insurance (
    Policy_Number VARCHAR(20) NOT NULL,
    Patient_ID INT NOT NULL,
    Ins_Code VARCHAR(20) NOT NULL,
    End_Date VARCHAR(10),
    Provider VARCHAR(20),
    Plan VARCHAR(20),
    Co_Pay  DECIMAL(10,2),
    Coverage VARCHAR(20),
    Maternity  BOOLEAN,
    Dental  BOOLEAN,
    Optical BOOLEAN,
    PRIMARY  KEY (Policy_Number),
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID)
);


CREATE TABLE Medicine (
    Medicine_ID INT  NOT NULL,
    M_Name VARCHAR(20) NOT NULL,
    M_Quantity INT NOT NULL,
    M_Cost  Decimal(10,2),
   PRIMARY KEY (Medicine_ID)
    );

CREATE TABLE Prescription (
    Prescription_ID INT  NOT NULL,
    Patient_ID  INT  NOT NULL,
    Medicine_ID  INT  NOT NULL,
    Date  DATE,
    Dosage  INT,
    Doctor_ID INT NOT NULL,
    PRIMARY KEY (Prescription_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor (Doctor_ID),
    FOREIGN KEY (Medicine_ID) REFERENCES Medicine (Medicine_ID)
);

CREATE TABLE Medical_History (
    Record_ID  INT NOT NULL,
    Patient_ID  INT NOT NULL,
    Allergies VARCHAR(50),
    Pre_Conditions VARCHAR(50),
    PRIMARY KEY (Record_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID)
);

CREATE TABLE Appointment (
    Appt_ID INT  NOT NULL,
    Scheduled_On  DATETIME NOT NULL,
    Date  DATE,
    Time TIME,
    Doctor_ID INT NOT NULL,
    Patient_ID  INT NOT NULL,
    PRIMARY KEY (Appt_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor (Doctor_ID), 
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID)
);

 CREATE TABLE  Room (
    Room_ID INT NOT NULL,
    Room_Type VARCHAR(50) NOT NULL,
    Patient_ID  INT  NOT NULL,
    Room_Cost  DECIMAL(10,2),
    PRIMARY KEY (Room_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID)
    );

CREATE TABLE Bill (
    Bill_ID INT NOT NULL,
    Date  DATE,
    Room_Cost Decimal(10,2),
    Test_Cost  DECIMAL(10,2),
    Other_Charges  DECIMAL(10,2),
    M_Cost DECIMAL(10,2),
    Total  DECIMAL(10,2),
    Patient_ID INT NOT NULL,
    Remaining_Balance DECIMAL(10,2),
    Policy_Number VARCHAR(20) NOT NULL,
    PRIMARY KEY (Bill_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID),
    FOREIGN KEY (Policy_Number) REFERENCES Insurance (Policy_Number)
);


INSERT INTO Department (Dept_ID, Dept_Head, Dept_Name, Emp_Count) VALUES
(1, 'Dr. Green', 'Cardiology', 12),
(2, 'Dr. Adams', 'Neurology', 8),
(3, 'Dr. Patel', 'Orthopedics', 10),
(4, 'Dr. Singh', 'Oncology', 9),
(5, 'Dr. Rao', 'Pediatrics', 11),
(6, 'Dr. Chen', 'Radiology', 7),
(7, 'Dr. Bose', 'Emergency', 15),
(8, 'Dr. Ali', 'ENT', 6),
(9, 'Dr. Kumar', 'Dermatology', 5),
(10, 'Dr. Mehta', 'Urology', 4);


INSERT INTO Staff (Emp_ID, Emp_FName, Emp_LName, Date_Joining, Date_Seperation, Emp_Type, Email, Address, Dept_ID, SSN) VALUES
(101, 'John', 'Doe', '2020-01-15', NULL, 'Doctor', 'johndoe@hosp.com', '123 Main St', 1, 1111),
(102, 'Emma', 'Watson', '2019-03-10', NULL, 'Nurse', 'emma@hosp.com', '456 Elm St', 2, 2222),
(103, 'Liam', 'Smith', '2018-07-25', NULL, 'Technician', 'liam@hosp.com', '789 Oak St', 6, 3333),
(104, 'Olivia', 'Brown', '2021-05-05', NULL, 'Doctor', 'olivia@hosp.com', '321 Pine St', 3, 4444),
(105, 'Noah', 'Davis', '2022-09-15', NULL, 'Nurse', 'noah@hosp.com', '654 Maple St', 1, 5555),
(106, 'Ava', 'Wilson', '2017-12-12', NULL, 'Technician', 'ava@hosp.com', '888 Birch St', 6, 6666),
(107, 'William', 'Lee', '2020-06-20', NULL, 'Doctor', 'will@hosp.com', '555 Ash St', 2, 7777),
(108, 'Sophia', 'Moore', '2023-01-01', NULL, 'Nurse', 'sophia@hosp.com', '444 Cedar St', 3, 8888),
(109, 'James', 'Taylor', '2018-02-28', NULL, 'Technician', 'james@hosp.com', '333 Poplar St', 6, 9999),
(110, 'Isabella', 'Anderson', '2019-11-11', NULL, 'Doctor', 'isa@hosp.com', '777 Spruce St', 4, 1010);


INSERT INTO Doctor (Doctor_ID, Qualifications, Emp_ID, Specialization, Dept_ID) VALUES
(1, 'MBBS, MD', 101, 'Cardiology', 1),
(2, 'MBBS, DM', 104, 'Orthopedics', 3),
(3, 'MBBS, MD', 107, 'Neurology', 2),
(4, 'MBBS, MS', 110, 'Oncology', 4);


INSERT INTO Patient (Patient_ID, Patient_FName, Patient_LName, Phone, Blood_Type, Email, Gender, Condition_, Admission_Date, Discharge_Date) VALUES
(201, 'Alice', 'Green', '9876543210', 'O+', 'alice@gmail.com', 'Female', 'Hypertension', '2025-06-01', '2025-06-05'),
(202, 'Bob', 'White', '9123456780', 'A-', 'bob@gmail.com', 'Male', 'Fracture', '2025-06-02', NULL),
(203, 'Carol', 'Black', '9345678901', 'B+', 'carol@gmail.com', 'Female', 'Migraine', '2025-06-03', '2025-06-04'),
(204, 'David', 'Brown', '9988776655', 'AB+', 'david@gmail.com', 'Male', 'Cancer', '2025-06-04', NULL),
(205, 'Eva', 'Jones', '9090909090', 'O-', 'eva@gmail.com', 'Female', 'Asthma', '2025-06-05', '2025-06-10'),
(206, 'Frank', 'Mills', '9012345678', 'A+', 'frank@gmail.com', 'Male', 'COVID-19', '2025-06-06', NULL),
(207, 'Grace', 'Hall', '9234567890', 'B-', 'grace@gmail.com', 'Female', 'Fever', '2025-06-07', '2025-06-09'),
(208, 'Henry', 'King', '9345678123', 'O+', 'henry@gmail.com', 'Male', 'Allergy', '2025-06-08', NULL),
(209, 'Ivy', 'Adams', '9988123456', 'AB-', 'ivy@gmail.com', 'Female', 'Arthritis', '2025-06-09', '2025-06-11'),
(210, 'Jack', 'Wilson', '9876012345', 'A-', 'jack@gmail.com', 'Male', 'Back Pain', '2025-06-10', NULL);


INSERT INTO Nurse (Nurse_ID, Patient_ID, Emp_ID, Dept_ID) VALUES
(1, 201, 102, 1),
(2, 202, 105, 1),
(3, 203, 108, 3),
(4, 204, 102, 2),
(5, 205, 105, 1),
(6, 206, 108, 3),
(7, 207, 102, 2),
(8, 208, 105, 1),
(9, 209, 108, 3),
(10, 210, 102, 2);


INSERT INTO Emergency_Contact (Contact_ID, Contact_Name, Phone, Relation, Patient_ID) VALUES
(301, 'Mary Green', '9998887777', 'Mother', 201),
(302, 'Paul White', '8887776666', 'Father', 202),
(303, 'Nina Black', '7776665555', 'Sister', 203),
(304, 'Jake Brown', '6665554444', 'Brother', 204),
(305, 'Rita Jones', '5554443333', 'Spouse', 205),
(306, 'Lisa Mills', '4443332222', 'Mother', 206),
(307, 'Tom Hall', '3332221111', 'Father', 207),
(308, 'Anna King', '2221110000', 'Wife', 208),
(309, 'Eli Adams', '1110009999', 'Brother', 209),
(310, 'Mark Wilson', '0009998888', 'Father', 210);


INSERT INTO Payroll (Account_No, Salary, Bonus, Emp_ID, IBAN) VALUES
('ACC101', 120000.00, 5000.00, 101, 'IBAN001'),
('ACC102', 60000.00, 2000.00, 102, 'IBAN002'),
('ACC103', 55000.00, 1000.00, 103, 'IBAN003'),
('ACC104', 115000.00, 4500.00, 104, 'IBAN004'),
('ACC105', 65000.00, 1800.00, 105, 'IBAN005'),
('ACC106', 58000.00, 1500.00, 106, 'IBAN006'),
('ACC107', 110000.00, 4000.00, 107, 'IBAN007'),
('ACC108', 62000.00, 1600.00, 108, 'IBAN008'),
('ACC109', 57000.00, 1200.00, 109, 'IBAN009'),
('ACC110', 118000.00, 4200.00, 110, 'IBAN010');


INSERT INTO Lab_Screening (Lab_ID, Patient_ID, Technician_ID, Doctor_ID, Test_Cost, Date) VALUES
(401, 201, 103, 1, 1200.00, '2025-06-01'),
(402, 202, 106, 2, 1000.00, '2025-06-02'),
(403, 203, 103, 3, 800.00, '2025-06-03'),
(404, 204, 109, 4, 2500.00, '2025-06-04'),
(405, 205, 106, 1, 950.00, '2025-06-05'),
(406, 206, 109, 2, 1800.00, '2025-06-06'),
(407, 207, 103, 3, 1100.00, '2025-06-07'),
(408, 208, 106, 4, 900.00, '2025-06-08'),
(409, 209, 103, 1, 1300.00, '2025-06-09'),
(410, 210, 109, 2, 1400.00, '2025-06-10');


INSERT INTO Insurance (Policy_Number, Patient_ID, Ins_Code, End_Date, Provider, Plan, Co_Pay, Coverage, Maternity, Dental, Optical) VALUES
('POL001', 201, 'INS001', '2025-12-31', 'MediCare', 'Gold', 100.00, 'Full', TRUE, TRUE, TRUE),
('POL002', 202, 'INS002', '2025-11-30', 'HealthPlus', 'Silver', 150.00, 'Partial', FALSE, TRUE, FALSE),
('POL003', 203, 'INS003', '2026-01-31', 'MediCare', 'Gold', 120.00, 'Full', TRUE, FALSE, TRUE),
('POL004', 204, 'INS004', '2025-10-15', 'LifeAid', 'Bronze', 200.00, 'Partial', FALSE, FALSE, FALSE),
('POL005', 205, 'INS005', '2025-09-20', 'CareWell', 'Platinum', 90.00, 'Full', TRUE, TRUE, TRUE),
('POL006', 206, 'INS006', '2025-08-10', 'HealthSecure', 'Gold', 110.00, 'Full', TRUE, TRUE, FALSE),
('POL007', 207, 'INS007', '2025-12-01', 'MediCare', 'Silver', 130.00, 'Partial', FALSE, FALSE, TRUE),
('POL008', 208, 'INS008', '2026-02-28', 'LifeAid', 'Gold', 100.00, 'Full', TRUE, TRUE, TRUE),
('POL009', 209, 'INS009', '2025-11-15', 'HealthPlus', 'Silver', 140.00, 'Partial', FALSE, TRUE, TRUE),
('POL010', 210, 'INS010', '2025-07-31', 'CareWell', 'Bronze', 160.00, 'Limited', FALSE, FALSE, FALSE);


INSERT INTO Medicine (Medicine_ID, M_Name, M_Quantity, M_Cost) VALUES
(501, 'Paracetamol', 100, 2.50),
(502, 'Amoxicillin', 50, 5.00),
(503, 'Ibuprofen', 80, 3.00),
(504, 'Metformin', 60, 4.75),
(505, 'Aspirin', 90, 2.00),
(506, 'Atorvastatin', 70, 3.50),
(507, 'Ciprofloxacin', 40, 6.00),
(508, 'Dolo 650', 120, 1.50),
(509, 'Cetirizine', 100, 1.20),
(510, 'Azithromycin', 45, 7.00);


INSERT INTO Prescription (Prescription_ID, Patient_ID, Medicine_ID, Date, Dosage, Doctor_ID) VALUES
(601, 201, 501, '2025-06-01', 2, 1),
(602, 202, 502, '2025-06-02', 1, 2),
(603, 203, 503, '2025-06-03', 2, 3),
(604, 204, 504, '2025-06-04', 1, 4),
(605, 205, 505, '2025-06-05', 2, 1),
(606, 206, 506, '2025-06-06', 1, 2),
(607, 207, 507, '2025-06-07', 2, 3),
(608, 208, 508, '2025-06-08', 1, 4),
(609, 209, 509, '2025-06-09', 1, 1),
(610, 210, 510, '2025-06-10', 2, 2);


INSERT INTO Medical_History (Record_ID, Patient_ID, Allergies, Pre_Conditions) VALUES
(701, 201, 'Peanuts', 'Diabetes'),
(702, 202, 'None', 'High BP'),
(703, 203, 'Pollen', 'Migraine'),
(704, 204, 'Latex', 'Cancer'),
(705, 205, 'Penicillin', 'Asthma'),
(706, 206, 'Dust', 'COVID History'),
(707, 207, 'Cats', 'Flu'),
(708, 208, 'None', 'Allergy'),
(709, 209, 'Milk', 'Arthritis'),
(710, 210, 'None', 'Back Pain');


INSERT INTO Appointment (Appt_ID, Scheduled_On, Date, Time, Doctor_ID, Patient_ID) VALUES
(801, '2025-06-01 09:00:00', '2025-06-01', '09:00:00', 1, 201),
(802, '2025-06-02 10:30:00', '2025-06-02', '10:30:00', 2, 202),
(803, '2025-06-03 11:00:00', '2025-06-03', '11:00:00', 3, 203),
(804, '2025-06-04 14:00:00', '2025-06-04', '14:00:00', 4, 204),
(805, '2025-06-05 13:00:00', '2025-06-05', '13:00:00', 1, 205),
(806, '2025-06-06 15:00:00', '2025-06-06', '15:00:00', 2, 206),
(807, '2025-06-07 16:00:00', '2025-06-07', '16:00:00', 3, 207),
(808, '2025-06-08 10:00:00', '2025-06-08', '10:00:00', 4, 208),
(809, '2025-06-09 11:30:00', '2025-06-09', '11:30:00', 1, 209),
(810, '2025-06-10 12:00:00', '2025-06-10', '12:00:00', 2, 210);


INSERT INTO Room (Room_ID, Room_Type, Patient_ID, Room_Cost) VALUES
(901, 'General Ward', 201, 2000.00),
(902, 'Private', 202, 5000.00),
(903, 'ICU', 203, 8000.00),
(904, 'Semi-Private', 204, 3500.00),
(905, 'General Ward', 205, 2000.00),
(906, 'Private', 206, 5000.00),
(907, 'ICU', 207, 8000.00),
(908, 'Semi-Private', 208, 3500.00),
(909, 'General Ward', 209, 2000.00),
(910, 'Private', 210, 5000.00);


INSERT INTO Bill (Bill_ID, Date, Room_Cost, Test_Cost, Other_Charges, M_Cost, Total, Patient_ID, Remaining_Balance, Policy_Number) VALUES
(1001, '2025-06-05', 2000.00, 1200.00, 500.00, 5.00, 3705.00, 201, 0.00, 'POL001'),
(1002, '2025-06-06', 5000.00, 1000.00, 300.00, 5.00, 6305.00, 202, 200.00, 'POL002'),
(1003, '2025-06-07', 8000.00, 800.00, 400.00, 6.00, 9206.00, 203, 0.00, 'POL003'),
(1004, '2025-06-08', 3500.00, 2500.00, 600.00, 4.75, 6604.75, 204, 150.00, 'POL004'),
(1005, '2025-06-10', 2000.00, 950.00, 500.00, 2.00, 3452.00, 205, 0.00, 'POL005'),
(1006, '2025-06-11', 5000.00, 1800.00, 200.00, 3.00, 7003.00, 206, 100.00, 'POL006'),
(1007, '2025-06-12', 8000.00, 1100.00, 400.00, 6.00, 9506.00, 207, 0.00, 'POL007'),
(1008, '2025-06-13', 3500.00, 900.00, 300.00, 1.50, 4701.50, 208, 0.00, 'POL008'),
(1009, '2025-06-14', 2000.00, 1300.00, 350.00, 1.20, 3651.20, 209, 200.00, 'POL009'),
(1010, '2025-06-15', 5000.00, 1400.00, 450.00, 7.00, 6857.00, 210, 50.00, 'POL010');
