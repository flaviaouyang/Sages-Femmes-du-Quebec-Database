INSERT INTO Mother (RAMQNum, mname, email, phone, dob, address, profession, bloodtype)
VALUES ('CONC97582511', 'Cecilia Contreras', 'ceciliacontreras2419@gmail.com', '1-603-267-4782', '08/25/1997',
        '974-8333 Sapien. Ave', 'Doctor', 'AB')
     , ('MURF94572836', 'Fredericka Murphy', 'frederickamurphy8987@gmail.com', '1-483-619-1776', '07/28/1994',
        '233-279 Ultricies Road', 'Unemployed', 'B')
     , ('CORL95540655', 'Louise Cortez', 'louisecortez@gmail.com', '1-292-336-9164', '04/06/1995',
        'Ap #264-5025 Eget Road', 'Product Manager', 'A')
     , ('SEXA98621038', 'Ashley Sexton', 'ashleysexton7405@gmail.com', '1-718-691-0651', '12/10/1988',
        '301-9183 Eu Ave', 'Architect', NULL)
     , ('RIGA02621077', 'Ann Riggs', 'annriggs9558@gmail.com', '1-844-255-5677', '12/10/2002', 'Ap #311-9899 Cum St.',
        'Student', NULL)
     , ('GUTV95540766', 'Victoria Gutierrez', 'vicgutierrez@gmail.com', '1-763-639-7056', '04/07/1995',
        '764-4686 Libero Av.', 'Professor', 'O')
;

INSERT INTO Father (fatherID, fname, email, phone, dob, address, profession, bloodtype, RAMQNum)
VALUES (1, 'Alvin Craig', 'alvincraig7758@icloud.com', '1-241-436-8268', '03/07/2002', '550-8974 Amet Street',
        'Carpenter', 'B', 'CRAA02030764')
     , (2, 'Oliver Allen', 'oliverallen@gmail.com', '1-252-581-9213', '06/11/2002', '7471 Elit, Rd.', 'Doctor', NULL,
        NULL)
     , (3, 'Simon Torres', NULL, '1-303-244-2317', '01/30/1996', NULL, 'Skater', 'B', 'TORS96013073')
     , (4, 'Sid Mcclain', 'sidmcclain8604@icloud.com', '1-636-449-7851', '07/21/2004',
        'P.O. Box 390, 1816 Ullamcorper, Rd.', 'Curator', 'O', NULL)
     , (5, 'Clementine Mcdowell', 'clementinemcdowell@icloud.com', '1-355-262-3143', '07/25/1995', '3008 Consequat Rd.',
        'Teacher', 'AB', NULL)
;

INSERT INTO Couple (coupleID, RAMQNum, fatherID)
VALUES (1, 'CONC97582511', 1)
     , (2, 'MURF94572836', 2)
     , (3, 'RIGA02621077', NULL)
     , (4, 'GUTV95540766', 3)
     , (5, 'CORL95540655', 4)
     , (6, 'SEXA98621038', 5)
;

INSERT INTO Institution (institutionID, name, phone, email, address, website)
VALUES (1, 'Lac-Saint-Louis', '1-514-697-4110', 'lacsaintlouis@clinic.com', '180, avenue Cartier Pointe-Claire',
        'clscs-louis.com')
     , (2, 'Pierrefonds', '1-514-626-2572', 'pierrefonds@birthcenter.com', '13800, boulevard Gouin Ouest Pierrefonds',
        NULL)
     , (3, 'Dorval-Lachine', '1-514-639-0650', 'dorval@clinic.com', '1900, rue Notre-Dame Lachine', NULL)
     , (4, 'CDN', '1-514-736-0705', 'cdn@birthcenter.com', '6560 Côte-des-Neiges', NULL)
     , (5, 'Jeanne-Mance', '1-514-527-2361', 'jm@birthcenter.com', '1822-1828 Ontario Street East', NULL)
     , (6, 'Longueil Birth Center', '1-925-238-9742', 'mattis.cras@birthcenter.com', '2028 Porta Street',
        'longueilbirth.ca')
     , (7, 'Westmount Clinic', '1-639-484-2751', 'morbi.quis@clinic.com', '2731 Molestie St.', 'westhealth.com')
     , (8, 'Lachine Clinic', '1-398-662-2818', 'curabitur@clinic.com', '7893 Nibh. Road', NULL)
     , (9, 'Mercier Birth Center', '1-603-990-0286', 'nec.luctus.felis@birthcenter.com', '3204 Fusce Rd.', NULL)
     , (10, 'Roxham Community Clinic', '1-331-972-4939', 'donec.felis@clinic.com', '6938 Ac Road', 'roxhamhealth.com')
;

INSERT INTO CommunityClinic (institutionID)
VALUES (1),
       (3),
       (7),
       (8),
       (10);

INSERT INTO BirthCenter (institutionID)
VALUES (2),
       (4),
       (5),
       (6),
       (9);

INSERT INTO Midwife (practitionerID, name, phone, email, institutionID)
VALUES (2735, 'Yen Evans', '1-514-865-4705', 'yenevans@health.ca', 1)
     , (7751, 'Adrienne Dickerson', '1-514-365-5543', 'adriennedickerson@health.ca', 2)
     , (5295, 'Whilemina Newton', '1-514-732-2405', 'whileminanewton@health.ca', 4)
     , (3508, 'Susan Howard', '1-514-866-4171', 'susanhoward@health.ca', 5)
     , (9234, 'Clio Barnes', '1-514-820-6110', 'cliobarnes@health.ca', 6)
     , (8834, 'Marion Girard', '1-514-800-7710', 'mariongirard@health.ca', 10)
     , (8470, 'Idola Nichols', '1-514-638-5510', 'idolanichols6622@health.ca', 3)
     , (8712, 'Hadley Garrett', '1-514-686-0768', 'hadleygarrett2472@health.ca', 8)
     , (2487, 'Nolan Page', '1-514-439-5742', 'nolanpage4737@health.ca', 7)
     , (2178, 'Lucian Calhoun', '1-514-634-0107', 'luciancalhoun8778@health.ca', 9)
     , (3009, 'Moira Page', '1-514-345-0099', 'moirapage4737@health.ca', 1)
     , (5532, 'Pagie Rose', '1-514-321-1122', 'pagierose@health.ca', 1)
;

INSERT INTO InformationSession (sessionID, date, time, language, practitionerID)
VALUES (1, '12/03/2021', '9:05 AM', 'English', 2735)
     , (2, '11/28/2021', '1:30 PM', 'English', 3508)
     , (3, '06/15/2021', '12:05 PM', 'French', 8834)
     , (4, '02/10/2022', '1:00 PM', 'French', 2487)
     , (5, '09/09/2021', '3:30 PM', 'French', 2178)
     , (6, '06/03/2021', '9:05 AM', 'French', 8712)
;

INSERT INTO InformationSessionRegistration (registrationRecord, sessionID, coupleID, attended)
VALUES (1, 1, 1, TRUE)
     , (2, 2, 2, TRUE)
     , (3, 3, 5, FALSE)
     , (4, 3, 6, TRUE)
     , (5, 4, 3, TRUE)
     , (6, 5, 4, FALSE)
     , (7, 5, 5, TRUE)
     , (8, 6, 4, TRUE)
;

INSERT INTO Pregnancy (coupleID, pregnancyNum, interested, dueYM, estimatedDD, ultrasoundDD, finalDD, homebirth,
                       primaryPractitionerID, backupPractitionerID, institutionID)
VALUES (4, 2, TRUE, '02/05/2022', '02/10/2022', '02/10/2022', '02/10/2022', FALSE, 7751, 5295, 5)
     , (1, 1, TRUE, '07/15/2022', '07/20/2022', '07/20/2022', '07/20/2022', FALSE, 3508, 8712, 2)
     , (2, 1, TRUE, '07/01/2022', NULL, NULL, NULL, TRUE, 8834, 8470, NULL)
     , (3, 1, TRUE, '07/30/2022', '07/25/2022', '07/30/2022', '07/30/2022', FALSE, 2178, 2735, 9)
     , (5, 2, TRUE, '08/12/2022', '08/25/2022', '08/25/2022', '08/25/2022', FALSE, 2735, 2487, 6)
     , (6, 3, TRUE, '09/12/2022', '09/25/2022', '09/25/2022', '09/25/2022', TRUE, 2735, 8834, NULL)
     , (6, 2, TRUE, '06/20/2021', '06/20/2021', '06/20/2021', '06/20/2021', TRUE, 2487, 8712, NULL)
     , (5, 1, TRUE, '05/30/2021', '05/30/2021', '05/30/2021', '05/30/2021', FALSE, 8712, 7751, 6)
;

INSERT INTO Baby (babyID, name, birthday, birthTime, bloodtype, legalSex, pregnancyNum, coupleID)
VALUES (1, 'Callum', '02/05/2022', '11:06 AM', 'AB', 'M', 2, 4)
     , (2, 'Hazel', NULL, NULL, NULL, 'F', 1, 1)
     , (3, 'Angelica', NULL, NULL, NULL, 'F', 1, 2)
     , (4, 'August', NULL, NULL, NULL, 'M', 2, 5)
     , (5, NULL, NULL, NULL, NULL, NULL, 3, 6)
     , (6, 'Chloe', '06/20/2021', '12:54 PM', 'O', 'F', 2, 6)
     , (7, 'Kimberly', '06/20/2021', '12:57 PM', 'O', 'F', 2, 6)
     , (8, 'Landon', '05/30/2021', '9:42 PM', 'AB', 'M', 1, 5)
     , (9, 'Jules', '05/30/2021', '9:50 PM', 'AB', 'F', 1, 5)
     , (10, NULL, NULL, NULL, NULL, NULL, 1, 3)
     ,(11, 'Lindsey', NULL, NULL, NULL, 'F', 2, 4)
;

INSERT INTO Technician (techID, name, phone)
VALUES (1, 'Jared Baker', '1-514-712-2569')
     , (2, 'Benjamin Olsen', '1-514-774-8652')
     , (3, 'Lael Spence', '1-514-558-6383')
     , (4, 'Keely Gates', '1-514-183-9251')
     , (5, 'Quinlan Baldwin', '1-514-400-4914')
;

INSERT INTO MedicalTest (testID, type, labworkDate, prescribedDate, takenDate, result, practitionerID, pregnancyNum,
                         coupleID, babyID, techID)
VALUES (1, 'blood iron', '12/10/2021', '12/05/2021', '12/08/2021', 'normal', 2735, 2, 4, NULL, 2)
     , (2, 'blood iron', '11/20/2021', '11/05/2021', '11/08/2021', 'low', 2735, 2, 4, NULL, 3)
     , (3, 'blood iron', '10/30/2021', '10/25/2021', '10/28/2021', 'low', 2735, 2, 4, NULL, 2)
     , (4, 'blood type', '02/10/2022', '02/10/2022', '02/10/2022', 'AB', 7751, NULL, NULL, 1, 1)
     , (5, 'blood type', '06/20/2021', '06/20/2021', '06/20/2021', 'O', 2735, NULL, NULL, 6, 1)
     , (6, 'blood type', '06/20/2021', '06/20/2021', '06/20/2021', 'O', 2735, NULL, NULL, 7, 1)
     , (7, 'blood type', '05/31/2021', '05/31/2021', '05/31/2021', 'AB', 2735, NULL, NULL, 8, 4)
     , (8, 'blood type', '05/31/2021', '05/31/2021', '05/31/2021', 'AB', 2735, NULL, NULL, 9, 4)
;

INSERT INTO Appointment (appointmentID, date, time, pregnancyNum, coupleID, practitionerID)
VALUES (1, '03/21/2022', '4:12 PM', 1, 2, 8834)
     , (2, '03/23/2022', '4:00 PM', 1, 1, 8834)
     , (3, '03/24/2022', '2:34 PM', 1, 5, 8834)
     , (4, '12/05/2021', '10:33 AM', 2, 4, 2735)
     , (5, '11/05/2021', '2:25 PM', 2, 4, 2735)
     , (6, '10/25/2021', '4:25 PM', 2, 4, 2735)
;

INSERT INTO Observation (observationID, time, date, content, appointmentID)
VALUES (1, '4:20 PM', '03/21/2022', 'Mother looks healthy.', 1)
     , (2, '4:00 PM', '03/23/2022', 'Good progress. On track.', 2)
     , (3, '2:34 PM', '03/24/2022', 'On track.', 3)
     , (4, '10:33 AM', '12/05/2021', 'Sign of low iron. Order blood iron test.', 4)
     , (5, '2:25 PM', '11/05/2021', 'Check if iron level still low.', 5)
     , (6, '4:25 PM', '10/25/2021', 'Check iron level.', 6)
;




