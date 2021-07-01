CREATE DATABASE University;

USE University;

CREATE TABLE Classroom (
    building    VARCHAR(15),
    room_number VARCHAR(7),
    capacity    NUMERIC(4, 0),
    PRIMARY KEY (building, room_number)
);

INSERT INTO Classroom VALUES('Packard', '101',  500);
INSERT INTO Classroom VALUES('Painter', '514',  10);
INSERT INTO Classroom VALUES('Taylor',  '3128', 70);
INSERT INTO Classroom VALUES('Watson',  '100',  30);
INSERT INTO Classroom VALUES('Watson',  '120',  50);

CREATE TABLE Department (
    dept_name   VARCHAR(20),
    building    VARCHAR(15),
    budget      NUMERIC(12, 2) CHECK (budget > 0),
    PRIMARY KEY (dept_name)
);

INSERT INTO Department VALUES('Biology',    'Watson',   90000);
INSERT INTO Department VALUES('Comp. Sci.', 'Taylor',   100000);
INSERT INTO Department VALUES('Elec. Eng.', 'Taylor',   85000);
INSERT INTO Department VALUES('Finance',    'Painter',  120000);
INSERT INTO Department VALUES('History',    'Painter',  50000);
INSERT INTO Department VALUES('Music',      'Packard',  80000);
INSERT INTO Department VALUES('Physics',    'Watson',   70000);

CREATE TABLE Course (
    course_id   VARCHAR(8),
    title       VARCHAR(50),
    dept_name   VARCHAR(20),
    credits     NUMERIC(2, 0) CHECK (credits > 0),
    PRIMARY KEY (course_id),
    FOREIGN KEY (dept_name) REFERENCES Department (dept_name) ON DELETE SET NULL
);

INSERT INTO Course VALUES('BIO-101',    'Intro. to Biology',            'Biology',      4);
INSERT INTO Course VALUES('BIO-301',    'Genetics',                     'Biology',      4);
INSERT INTO Course VALUES('BIO-399',    'Computational Biology',        'Biology',      3);
INSERT INTO Course VALUES('CS-101',     'Intro. to Computer Science',   'Comp. Sci.',   4);
INSERT INTO Course VALUES('CS-190',     'Game Design',                  'Comp. Sci.',   4);
INSERT INTO Course VALUES('CS-315',     'Robotics',                     'Comp. Sci.',   3);
INSERT INTO Course VALUES('CS-319',     'Image Processing',             'Comp. Sci.',   3);
INSERT INTO Course VALUES('CS-347',     'Database System Concepts',     'Comp. Sci.',   3);
INSERT INTO Course VALUES('EE-181',     'Intro. to Digital Systems',    'Elec. Eng.',   3);
INSERT INTO Course VALUES('FIN-201',    'Investment Banking',           'Finance',      3);
INSERT INTO Course VALUES('HIS-351',    'World History',                'History',      3);
INSERT INTO Course VALUES('MU-199',     'Music Video Production',       'Music',        3);
INSERT INTO Course VALUES('PHY-101',    'Physical Principles',          'Physics',      4);

CREATE TABLE Instructor (
    ID          VARCHAR(5),
    name        VARCHAR(20) NOT NULL,
    dept_name   VARCHAR(20),
    salary      NUMERIC(8, 2) CHECK (salary > 29000),
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name) REFERENCES Department (dept_name) ON DELETE SET NULL
);

INSERT INTO Instructor VALUES('10101',     'Srinivasan',   'Comp. Sci.',   65000);
INSERT INTO Instructor VALUES('12121',     'Wu',           'Finance',      90000);
INSERT INTO Instructor VALUES('15151',     'Mozart',       'Music',        40000);
INSERT INTO Instructor VALUES('22222',     'Einstein',     'Physics',      95000);
INSERT INTO Instructor VALUES('32343',     'El Said',      'History',      60000);
INSERT INTO Instructor VALUES('33456',     'Gold',         'Physics',      87000);
INSERT INTO Instructor VALUES('45565',     'Katz',         'Comp. Sci.',   75000);
INSERT INTO Instructor VALUES('58583',     'Califieri',    'History',      62000);
INSERT INTO Instructor VALUES('76543',     'Singh',        'Finance',      80000);
INSERT INTO Instructor VALUES('76766',     'Crick',        'Biology',      72000);
INSERT INTO Instructor VALUES('83821',     'Brandt',       'Comp. Sci.',   92000);
INSERT INTO Instructor VALUES('98345',     'Kim',          'Elec. Eng.',   80000);

CREATE TABLE Section (
    course_id       VARCHAR(8),
    sec_id          VARCHAR(8),
    semester        VARCHAR(6) CHECK (semester IN ('Fall', 'Winter', 'Spring', 'Summer')),
    year            NUMERIC(4, 0) CHECK (year > 1701 AND year < 2100),
    building        VARCHAR(15),
    room_number     VARCHAR(7),
    time_slot_id    VARCHAR(4),
    PRIMARY KEY (course_id, sec_id, semester, year),
    FOREIGN KEY (course_id) REFERENCES Course (course_id) ON DELETE CASCADE,
    FOREIGN KEY (building, room_number) REFERENCES Classroom (building, room_number) ON DELETE SET NULL
);

INSERT INTO Section VALUES('BIO-101',   '1', 'Summer',  2009, 'Painter',    '514',     'B');
INSERT INTO Section VALUES('BIO-301',   '1', 'Summer',  2010, 'Painter',    '514',     'A');
INSERT INTO Section VALUES('CS-101',    '1', 'Fall',    2009, 'Packard',    '101',     'H');
INSERT INTO Section VALUES('CS-101',    '1', 'Spring',  2010, 'Packard',    '101',     'F');
INSERT INTO Section VALUES('CS-190',    '1', 'Spring',  2009, 'Taylor',     '3128',    'E');
INSERT INTO Section VALUES('CS-190',    '2', 'Spring',  2009, 'Taylor',     '3128',    'A');
INSERT INTO Section VALUES('CS-315',    '1', 'Spring',  2010, 'Watson',     '120',     'D');
INSERT INTO Section VALUES('CS-319',    '1', 'Spring',  2010, 'Watson',     '100',     'B');
INSERT INTO Section VALUES('CS-319',    '2', 'Spring',  2010, 'Taylor',     '3128',    'C');
INSERT INTO Section VALUES('CS-347',    '1', 'Fall',    2009, 'Taylor',     '3128',    'A');
INSERT INTO Section VALUES('EE-181',    '1', 'Spring',  2009, 'Taylor',     '3128',    'C');
INSERT INTO Section VALUES('FIN-201',   '1', 'Spring',  2010, 'Packard',    '101',     'B');
INSERT INTO Section VALUES('HIS-351',   '1', 'Spring',  2010, 'Painter',    '514',     'C');
INSERT INTO Section VALUES('MU-199',    '1', 'Spring',  2010, 'Packard',    '101',     'D');
INSERT INTO Section VALUES('PHY-101',   '1', 'Fall',    2009, 'Watson',     '100',     'A');

CREATE TABLE Teaches (
    ID          VARCHAR(5),
    course_id   VARCHAR(8),
    sec_id      VARCHAR(8),
    semester    VARCHAR(6),
    year        NUMERIC(4, 0),
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES Section (course_id, sec_id, semester, year) ON DELETE CASCADE,
    FOREIGN KEY (ID) REFERENCES Instructor (ID) ON DELETE CASCADE
);

INSERT INTO Teaches VALUES('10101',    'CS-101', '1',  'Fall',      2009);
INSERT INTO Teaches VALUES('10101',    'CS-315', '1',  'Spring',    2010);
INSERT INTO Teaches VALUES('10101',    'CS-347', '1',  'Fall',      2009);
INSERT INTO Teaches VALUES('12121',    'FIN-201','1',  'Spring',    2010);
INSERT INTO Teaches VALUES('15151',    'MU-199', '1',  'Spring',    2010);
INSERT INTO Teaches VALUES('22222',    'PHY-101','1',  'Fall',      2009);
INSERT INTO Teaches VALUES('32343',    'HIS-351','1',  'Spring',    2010);
INSERT INTO Teaches VALUES('45565',    'CS-101', '1',  'Spring',    2010);
INSERT INTO Teaches VALUES('45565',    'CS-319', '1',  'Spring',    2010);
INSERT INTO Teaches VALUES('76766',    'BIO-101','1',  'Summer',    2009);
INSERT INTO Teaches VALUES('76766',    'BIO-301','1',  'Summer',    2010);
INSERT INTO Teaches VALUES('83821',    'CS-190', '1',  'Spring',    2009);
INSERT INTO Teaches VALUES('83821',    'CS-190', '2',  'Spring',    2009);
INSERT INTO Teaches VALUES('83821',    'CS-319', '2',  'Spring',    2010);
INSERT INTO Teaches VALUES('98345',    'EE-181', '1',  'Spring',    2009);

CREATE TABLE Student (
    ID          VARCHAR(5),
    name        VARCHAR(20) NOT NULL,
    dept_name   VARCHAR(20),
    tot_cred    NUMERIC(3, 0) CHECK (tot_cred >= 0),
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name) REFERENCES Department (dept_name) ON DELETE SET NULL
);

INSERT INTO Student VALUES('00128',     'Zhang',    'Comp. Sci.',   102);
INSERT INTO Student VALUES('12345',     'Shankar',  'Comp. Sci.',   32);
INSERT INTO Student VALUES('19991',     'Brandt',   'History',      80);
INSERT INTO Student VALUES('23121',     'Chavez',   'Finance',      110);
INSERT INTO Student VALUES('44553',     'Peltier',  'Physics',      56);
INSERT INTO Student VALUES('45678',     'Levy',     'Physics',      46);
INSERT INTO Student VALUES('54321',     'Williams', 'Comp. Sci.',   54);
INSERT INTO Student VALUES('55739',     'Sanchez',  'Music',        38);
INSERT INTO Student VALUES('70557',     'Snow',     'Physics',      0);
INSERT INTO Student VALUES('76543',     'Brown',    'Comp. Sci.',   58);
INSERT INTO Student VALUES('76653',     'Aoi',      'Elec. Eng.',   60);
INSERT INTO Student VALUES('98765',     'Bourikas', 'Elec. Eng.',   98);
INSERT INTO Student VALUES('98988',     'Tanaka',   'Biology',      120);

CREATE TABLE Takes (
    ID          VARCHAR(5),
    course_id   VARCHAR(8),
    sec_id      VARCHAR(8),
    semester    VARCHAR(6),
    year        NUMERIC(4, 0),
    grade       VARCHAR(2),
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES Section (course_id, sec_id, semester, year) ON DELETE CASCADE,
    FOREIGN KEY (ID) REFERENCES Student (ID) ON DELETE CASCADE
);

INSERT INTO Takes VALUES('00128',     'CS-101',   '1',    'Fall',   2009,    'A');
INSERT INTO Takes VALUES('00128',     'CS-347',   '1',    'Fall',   2009,    'A-');
INSERT INTO Takes VALUES('12345',     'CS-101',   '1',    'Fall',   2009,    'C');
INSERT INTO Takes VALUES('12345',     'CS-190',   '2',    'Spring', 2009,    'A');
INSERT INTO Takes VALUES('12345',     'CS-315',   '1',    'Spring', 2010,    'A');
INSERT INTO Takes VALUES('12345',     'CS-347',   '1',    'Fall',   2009,    'A');
INSERT INTO Takes VALUES('19991',     'HIS-351',  '1',    'Spring', 2010,    'B');
INSERT INTO Takes VALUES('23121',     'FIN-201',  '1',    'Spring', 2010,    'C+');
INSERT INTO Takes VALUES('44553',     'PHY-101',  '1',    'Fall',   2009,    'B-');
INSERT INTO Takes VALUES('45678',     'CS-101',   '1',    'Fall',   2009,    'F');
INSERT INTO Takes VALUES('45678',     'CS-101',   '1',    'Spring', 2010,    'B+');
INSERT INTO Takes VALUES('45678',     'CS-319',   '1',    'Spring', 2010,    'B');
INSERT INTO Takes VALUES('54321',     'CS-101',   '1',    'Fall',   2009,    'A-');
INSERT INTO Takes VALUES('54321',     'CS-190',   '2',    'Spring', 2009,    'B+');
INSERT INTO Takes VALUES('55739',     'MU-199',   '1',    'Spring', 2010,    'A-');
INSERT INTO Takes VALUES('76543',     'CS-101',   '1',    'Fall',   2009,    'A');
INSERT INTO Takes VALUES('76543',     'CS-319',   '2',    'Spring', 2010,    'A');
INSERT INTO Takes VALUES('76653',     'EE-181',   '1',    'Spring', 2009,    'C');
INSERT INTO Takes VALUES('98765',     'CS-101',   '1',    'Fall',   2009,    'C-');
INSERT INTO Takes VALUES('98765',     'CS-315',   '1',    'Spring', 2010,    'B');
INSERT INTO Takes VALUES('98988',     'BIO-101',  '1',    'Summer', 2009,    'A');
INSERT INTO Takes VALUES('98988',     'BIO-301',  '1',    'Summer', 2010,    null);

CREATE TABLE Advisor (
    s_ID    VARCHAR(5),
    i_ID    VARCHAR(5),
    PRIMARY KEY (s_ID),
    FOREIGN KEY (i_ID) REFERENCES Instructor (ID) ON DELETE SET NULL,
    FOREIGN KEY (s_ID) REFERENCES Student (ID) ON DELETE CASCADE
);

INSERT INTO Advisor VALUES('00128', '45565');
INSERT INTO Advisor VALUES('12345', '10101');
INSERT INTO Advisor VALUES('23121', '76543');
INSERT INTO Advisor VALUES('44553', '22222');
INSERT INTO Advisor VALUES('45678', '22222');
INSERT INTO Advisor VALUES('76543', '45565');
INSERT INTO Advisor VALUES('76653', '98345');
INSERT INTO Advisor VALUES('98765', '98345');
INSERT INTO Advisor VALUES('98988', '76766');

CREATE TABLE Prereq (
    course_id   VARCHAR(8),
    prereq_id   VARCHAR(8),
    PRIMARY KEY (course_id, prereq_id),
    FOREIGN KEY (course_id) REFERENCES Course (course_id) ON DELETE CASCADE,
    FOREIGN KEY (prereq_id) REFERENCES Course (course_id) 
);

INSERT INTO Prereq VALUES('BIO-301',    'BIO-101');
INSERT INTO Prereq VALUES('BIO-399',    'BIO-101');
INSERT INTO Prereq VALUES('CS-190',     'CS-101');
INSERT INTO Prereq VALUES('CS-315',     'CS-101');
INSERT INTO Prereq VALUES('CS-319',     'CS-101');
INSERT INTO Prereq VALUES('CS-347',     'CS-101');
INSERT INTO Prereq VALUES('EE-181',     'PHY-101');

CREATE TABLE Timeslot (
    time_slot_id    VARCHAR(4),
    day             VARCHAR(1) CHECK (day in ('M', 'T', 'W', 'R', 'F', 'S', 'U')),
    start_time      TIME,
    end_time        TIME,
    PRIMARY KEY (time_slot_id, day, start_time)
);

INSERT INTO Timeslot VALUES('A', 'M',   '8:00',   '8:50');
INSERT INTO Timeslot VALUES('A', 'W',   '8:00',   '8:50');
INSERT INTO Timeslot VALUES('A', 'F',   '8:00',   '8:50');
INSERT INTO Timeslot VALUES('B', 'M',   '9:00',   '9:50');
INSERT INTO Timeslot VALUES('B', 'W',   '9:00',   '9:50');
INSERT INTO Timeslot VALUES('B', 'F',   '9:00',   '9:50');
INSERT INTO Timeslot VALUES('C', 'M',   '11:00',  '11:50');
INSERT INTO Timeslot VALUES('C', 'W',   '11:00',  '11:50');
INSERT INTO Timeslot VALUES('C', 'F',   '11:00',  '11:50');
INSERT INTO Timeslot VALUES('D', 'M',   '13:00',  '13:50');
INSERT INTO Timeslot VALUES('D', 'W',   '13:00',  '13:50');
INSERT INTO Timeslot VALUES('D', 'F',   '13:00',  '13:50');
INSERT INTO Timeslot VALUES('E', 'T',   '10:30',  '11:45');
INSERT INTO Timeslot VALUES('E', 'R',   '10:30',  '11:45');
INSERT INTO Timeslot VALUES('F', 'T',   '14:30',  '15:45');
INSERT INTO Timeslot VALUES('F', 'R',   '14:30',  '15:45');
INSERT INTO Timeslot VALUES('G', 'M',   '16:00',  '16:50');
INSERT INTO Timeslot VALUES('G', 'W',   '16:00',  '16:50');
INSERT INTO Timeslot VALUES('G', 'F',   '16:00',  '16:50');
INSERT INTO Timeslot VALUES('H', 'W',   '10:00',  '12:30');
