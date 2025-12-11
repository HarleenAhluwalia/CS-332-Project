DROP TABLE IF EXISTS MeetingDays;
DROP TABLE IF EXISTS Prerequisites;
DROP TABLE IF EXISTS CollegeDegrees;
DROP TABLE IF EXISTS Minor;
DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Section;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Professor;

CREATE TABLE Professor (
    SSN           CHAR(9)     PRIMARY KEY,
    Name          VARCHAR(60) NOT NULL,
    Salary        DECIMAL(10,2),
    StreetAddress VARCHAR(100),
    City          VARCHAR(40),
    State         CHAR(2),
    Zipcode       CHAR(5),
    AreaCode      CHAR(3),
    Phone7        CHAR(7),
    Title         VARCHAR(30),
    Sex           CHAR(1)
) ENGINE=InnoDB;

CREATE TABLE Department (
    Dnum           INT         PRIMARY KEY,
    Name           VARCHAR(60) NOT NULL,
    Telephone      VARCHAR(15),
    OfficeLocation VARCHAR(60),
    ChairSSN       CHAR(9),
    FOREIGN KEY (ChairSSN) REFERENCES Professor(SSN)
) ENGINE=InnoDB;

CREATE TABLE Student (
    CWID      CHAR(9)      PRIMARY KEY,
    Fname     VARCHAR(30)  NOT NULL,
    Lname     VARCHAR(30)  NOT NULL,
    Telephone VARCHAR(15),
    Address   VARCHAR(100),
    Dnum      INT          NOT NULL,
    FOREIGN KEY (Dnum) REFERENCES Department(Dnum)
) ENGINE=InnoDB;

CREATE TABLE Course (
    Cnum     INT         PRIMARY KEY,
    Title    VARCHAR(80) NOT NULL,
    Textbook VARCHAR(80),
    Units    INT,
    Dnum     INT NOT NULL,
    FOREIGN KEY (Dnum) REFERENCES Department(Dnum)
) ENGINE=InnoDB;

CREATE TABLE Section (
    Snum      INT,
    Cnum      INT,
    Classroom VARCHAR(20),
    NumSeats  INT,
    BeginTime TIME,
    EndTime   TIME,
    TeachSSN  CHAR(9),
    PRIMARY KEY (Snum, Cnum),
    FOREIGN KEY (Cnum)     REFERENCES Course(Cnum),
    FOREIGN KEY (TeachSSN) REFERENCES Professor(SSN)
) ENGINE=InnoDB;

CREATE TABLE Enrollment (
    CWID  CHAR(9),
    Snum  INT,
    Cnum  INT,
    Grade VARCHAR(2),
    PRIMARY KEY (CWID, Snum, Cnum),
    FOREIGN KEY (CWID)       REFERENCES Student(CWID),
    FOREIGN KEY (Snum, Cnum) REFERENCES Section(Snum, Cnum)
) ENGINE=InnoDB;

CREATE TABLE Minor (
    CWID CHAR(9),
    Dnum INT,
    PRIMARY KEY (CWID, Dnum),
    FOREIGN KEY (CWID) REFERENCES Student(CWID),
    FOREIGN KEY (Dnum) REFERENCES Department(Dnum)
) ENGINE=InnoDB;

CREATE TABLE CollegeDegrees (
    SSN    CHAR(9),
    Degree VARCHAR(60),
    PRIMARY KEY (SSN, Degree),
    FOREIGN KEY (SSN) REFERENCES Professor(SSN)
) ENGINE=InnoDB;

CREATE TABLE Prerequisites (
    Cnum       INT,
    PrereqCnum INT,
    PRIMARY KEY (Cnum, PrereqCnum),
    FOREIGN KEY (Cnum)       REFERENCES Course(Cnum),
    FOREIGN KEY (PrereqCnum) REFERENCES Course(Cnum)
) ENGINE=InnoDB;

CREATE TABLE MeetingDays (
    Snum INT,
    Cnum INT,
    Day  VARCHAR(3),  -- e.g. 'M', 'Tu', 'MWF'
    PRIMARY KEY (Snum, Cnum, Day),
    FOREIGN KEY (Snum, Cnum) REFERENCES Section(Snum, Cnum)
) ENGINE=InnoDB;
