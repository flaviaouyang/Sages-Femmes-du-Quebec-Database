WITH CoupleApt AS (
    SELECT appointmentID, date, time, RAMQNum, practitionerID
    FROM Appointment
             LEFT JOIN Couple ON Appointment.coupleID = Couple.coupleID
),
     AllInfo AS (
         SELECT appointmentID, date, time, Mother.RAMQNum, practitionerID, mname, phone
         FROM CoupleApt
                  LEFT JOIN Mother ON CoupleApt.RAMQNum = Mother.RAMQNum
     )
SELECT date    AS Appointment_Date,
       time    AS Appointment_Time,
       RAMQNum AS Mother_RAMQ,
       mname   AS Mother_Name,
       phone   AS Mother_Phone_Number
FROM AllInfo
WHERE EXTRACT(YEAR from date) = 2022
  AND EXTRACT(Month from date) = 03
  AND EXTRACT(Day from date) >= 21
  AND EXTRACT(Day from date) <= 25
  AND practitionerID = (
    SELECT practitionerID
    FROM Midwife
    WHERE name = 'Marion Girard'
)
ORDER BY date;



SELECT labworkDate AS Lab_Date,
       result      AS Blood_Iron_Result
FROM MedicalTest
WHERE coupleID = (
    SELECT coupleID
    FROM Couple
             LEFT JOIN Mother ON Couple.RAMQNum = Mother.RAMQNum
    WHERE mname = 'Victoria Gutierrez'
)
  AND type = 'blood iron'
  AND pregnancyNum = 2
ORDER BY labworkDate;



WITH RelevantPreg AS (
    SELECT primaryPractitionerID, dueYM, finalDD
    FROM Pregnancy
    WHERE finalDD IS NULL
      AND EXTRACT(YEAR FROM dueYM) = 2022
      AND EXTRACT(MONTH FROM dueYM) = 07
    UNION ALL
    SELECT primaryPractitionerID, dueYM, finalDD
    FROM Pregnancy
    WHERE finalDD IS NOT NULL
      AND EXTRACT(YEAR FROM finalDD) = 2022
      AND EXTRACT(MONTH FROM finalDD) = 07
)
SELECT Institution.name             AS Health_Institution_Name
     , COUNT(primaryPractitionerID) AS Num_July_Pregnancy
FROM Institution
         LEFT JOIN Midwife ON Institution.institutionID = Midwife.institutionID
         FULL OUTER JOIN RelevantPreg ON RelevantPreg.primaryPractitionerID = Midwife.practitionerID
GROUP BY Institution.name
ORDER BY Num_July_Pregnancy DESC;



SELECT DISTINCT Mother.RAMQNum AS Mother_RAMQ,
                mname          AS Mother_Name,
                Mother.phone   AS Mother_Phone_Number
FROM Pregnancy
         LEFT JOIN Baby ON Pregnancy.coupleID = Baby.coupleID AND Pregnancy.pregnancyNum = Baby.pregnancyNum
         LEFT JOIN Couple ON Pregnancy.coupleID = Couple.coupleID
         LEFT JOIN Mother ON Couple.RAMQNum = Mother.RAMQNum
WHERE (
            primaryPractitionerID IN
            (
                SELECT practitionerID
                FROM Midwife
                WHERE institutionID = (
                    SELECT institutionID
                    FROM Institution
                    WHERE name = 'Lac-Saint-Louis'
                )
            )
        OR backupPractitionerID IN
           (
               SELECT practitionerID
               FROM Midwife
               WHERE institutionID = (
                   SELECT institutionID
                   FROM Institution
                   WHERE name = 'Lac-Saint-Louis'
               )
           )
    )
  AND interested IS TRUE
  AND Baby.birthday IS NULL
  AND Baby.birthTime IS NULL
  AND babyID IS NOT NULL;



WITH BabyCount AS (
    SELECT Pregnancy.coupleID, Pregnancy.pregnancyNum, COUNT(babyID) AS babyNum
    FROM Pregnancy
             FULL OUTER JOIN Baby ON Pregnancy.pregnancyNum = Baby.pregnancyNum AND Pregnancy.coupleID = Baby.coupleID
    GROUP BY Pregnancy.coupleID, Pregnancy.pregnancyNum
)
SELECT DISTINCT Mother.RAMQNum AS Mother_RAMQ,
                mname          AS Mother_Name
FROM BabyCount
         LEFT JOIN Couple ON BabyCount.coupleID = Couple.coupleID
         LEFT JOIN Mother ON COUPLE.RAMQNum = Mother.RAMQNum
WHERE babyNum > 1;















