-- connect to the database
CONNECT to SF;

CREATE TABLE Mother
(
    RAMQNum    CHAR(12)     NOT NULL,
    mname      VARCHAR(20)  NOT NULL,
    email      VARCHAR(50)  NOT NULL UNIQUE,
    phone      VARCHAR(20)  NOT NULL,
    dob        DATE         NOT NULL,
    address    VARCHAR(200) NOT NULL,
    profession VARCHAR(20)  NOT NULL,
    bloodtype  VARCHAR(2),
    PRIMARY KEY (RAMQNum)
);

CREATE TABLE Father
(
    fatherID   INTEGER     NOT NULL,
    fname      VARCHAR(20) NOT NULL,
    email      VARCHAR(50),
    phone      VARCHAR(20) NOT NULL,
    dob        DATE        NOT NULL,
    address    VARCHAR(200),
    profession VARCHAR(20) NOT NULL,
    bloodtype  VARCHAR(2),
    RAMQNum    CHAR(12),
    PRIMARY KEY (fatherID)
);

CREATE TABLE Couple
(
    coupleID INTEGER  NOT NULL,
    RAMQNum  CHAR(12) NOT NULL,
    fatherID INTEGER,
    PRIMARY KEY (coupleID),
    FOREIGN KEY (RAMQNum)
        REFERENCES Mother (RAMQNum),
    FOREIGN KEY (fatherID)
        REFERENCES Father (fatherID)
);

CREATE TABLE Institution
(
    institutionID INTEGER      NOT NULL,
    name          VARCHAR(200) NOT NULL,
    phone         VARCHAR(20)  NOT NULL,
    email         VARCHAR(50)  NOT NULL,
    address       VARCHAR(200) NOT NULL,
    website       VARCHAR(100),
    PRIMARY KEY (institutionID)
);

CREATE TABLE CommunityClinic
(
    institutionID INTEGER NOT NULL,
    PRIMARY KEY (institutionID),
    FOREIGN KEY (institutionID)
        REFERENCES Institution (institutionID)
);

CREATE TABLE BirthCenter
(
    institutionID INTEGER NOT NULL,
    PRIMARY KEY (institutionID),
    FOREIGN KEY (institutionID)
        REFERENCES Institution (institutionID)
);

CREATE TABLE Midwife
(
    practitionerID CHAR(4)     NOT NULL,
    name           VARCHAR(20) NOT NULL,
    phone          VARCHAR(20) NOT NULL,
    email          VARCHAR(50) NOT NULL UNIQUE,
    institutionID  INTEGER     NOT NULL,
    PRIMARY KEY (practitionerID),
    FOREIGN KEY (institutionID)
        REFERENCES Institution (institutionID)
);

CREATE TABLE InformationSession
(
    sessionID      INTEGER     NOT NULL,
    date           DATE        NOT NULL,
    time           TIME        NOT NULL,
    language       VARCHAR(20) NOT NULL,
    practitionerID CHAR(4)     NOT NULL,
    UNIQUE (date, time, practitionerID),
    PRIMARY KEY (sessionID),
    FOREIGN KEY (practitionerID)
        REFERENCES Midwife (practitionerID)
);

CREATE TABLE InformationSessionRegistration
(
    registrationRecord INTEGER NOT NULL,
    sessionID          INTEGER NOT NULL,
    coupleID           INTEGER NOT NULL,
    attended           BOOLEAN NOT NULL,
    UNIQUE (sessionID, coupleID, attended),
    PRIMARY KEY (registrationRecord),
    FOREIGN KEY (sessionID)
        REFERENCES InformationSession (sessionID),
    FOREIGN KEY (coupleID)
        REFERENCES Couple (coupleID)
);

CREATE TABLE Pregnancy
(
    coupleID              INTEGER NOT NULL,
    pregnancyNum          INTEGER NOT NULL,
    interested            BOOLEAN,
    dueYM                 DATE    NOT NULL,
    estimatedDD           DATE,
    ultrasoundDD          DATE,
    finalDD               DATE,
    homebirth             BOOLEAN,
    primaryPractitionerID CHAR(4),
    backupPractitionerID  CHAR(4),
    institutionID         INTEGER,
    PRIMARY KEY (coupleID, pregnancyNum),
    FOREIGN KEY (coupleID)
        REFERENCES Couple (coupleID),
    FOREIGN KEY (primaryPractitionerID)
        REFERENCES Midwife (practitionerID),
    FOREIGN KEY (backupPractitionerID)
        REFERENCES Midwife (practitionerID),
    FOREIGN KEY (institutionID)
        REFERENCES BirthCenter (institutionID)
);

CREATE TABLE Baby
(
    babyID       INTEGER NOT NULL,
    name         VARCHAR(20),
    birthday     DATE,
    birthTime    TIME,
    bloodtype    VARCHAR(2),
    legalSex     CHAR(1),
    pregnancyNum INTEGER NOT NULL,
    coupleID     INTEGER NOT NULL,
    PRIMARY KEY (babyID),
    FOREIGN KEY (coupleID, pregnancyNum)
        REFERENCES Pregnancy (coupleID, pregnancyNum)
);

CREATE TABLE Technician
(
    techID INTEGER     NOT NULL,
    name   VARCHAR(20) NOT NULL,
    phone  VARCHAR(20) NOT NULL,
    PRIMARY KEY (techID)
);

CREATE TABLE MedicalTest
(
    testID         INTEGER     NOT NULL,
    type           VARCHAR(50) NOT NULL,
    labworkDate    DATE,
    prescribedDate DATE        NOT NULL,
    takenDate      DATE,
    result         VARCHAR(200),
    practitionerID CHAR(4)     NOT NULL,
    pregnancyNum   INTEGER,
    coupleID       INTEGER,
    babyID         INTEGER,
    techID         INTEGER,
    PRIMARY KEY (testID),
    FOREIGN KEY (practitionerID)
        REFERENCES Midwife (practitionerID),
    FOREIGN KEY (coupleID, pregnancyNum)
        REFERENCES Pregnancy (coupleID, pregnancyNum),
    FOREIGN KEY (babyID)
        REFERENCES Baby (babyID),
    FOREIGN KEY (techID)
        REFERENCES Technician (techID)
);

CREATE TABLE Appointment
(
    appointmentID  INTEGER NOT NULL,
    date           DATE    NOT NULL,
    time           TIME    NOT NULL,
    pregnancyNum   INTEGER NOT NULL,
    coupleID       INTEGER NOT NULL,
    practitionerID CHAR(4) NOT NULL,
    UNIQUE (date, time, pregnancyNum, coupleID),
    UNIQUE (date, time, practitionerID),
    PRIMARY KEY (appointmentID),
    FOREIGN KEY (coupleID, pregnancyNum)
        REFERENCES Pregnancy (coupleID, pregnancyNum),
    FOREIGN KEY (practitionerID)
        REFERENCES Midwife (practitionerID)
);

CREATE TABLE Observation
(
    observationID INTEGER      NOT NULL,
    time          TIME         NOT NULL,
    date          DATE         NOT NULL,
    content       VARCHAR(255) NOT NULL,
    appointmentID INTEGER      NOT NULL,
    UNIQUE (time, date, content, appointmentID),
    PRIMARY KEY (observationID),
    FOREIGN KEY (appointmentID)
        REFERENCES Appointment (appointmentID)
);


