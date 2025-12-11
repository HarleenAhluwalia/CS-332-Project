-- 1. Professors
INSERT INTO Professor VALUES
('123456789', 'Dr. John Smith', 130000.00, '123 Nutwood St', 'Fullerton', 'CA', '92831', '949', '1234567', 'Professor', 'M'),
('112233445', 'Dr. Mary Smith', 145000.00, '321 College Blvd', 'Fullerton', 'CA', '92831', '949', '7654321', 'Professor', 'F'),
('112233455', 'Dr. Lisa Smith', 155000.00, '321 Nutwood Blvd', 'Fullerton', 'CA', '92831', '949', '7653321', 'Professor', 'F');

-- 2. Departments
INSERT INTO Department VALUES
(1, 'Computer Science', '0000001234', 'CS-101', '123456789'),
(2, 'Engineering',      '0000001122', 'E-101',  '112233445');

-- 3. Students
INSERT INTO Student VALUES
('800000001', 'John', 'Smith', '6570001111', '123 Orange St', 1),
('800000002', 'Mary', 'Lee',   '6570002222', '55 Lemon St',   2),
('800000003', 'Mary', 'Lee',   '6570003333', '55 Lemon St',   1),
('800000004', 'Mary', 'Lee',   '6570002224', '55 Lemon St',   1),
('800000005', 'Mary', 'Lee',   '6570002225', '55 Lemon St',   1),
('800000006', 'Mary', 'Lee',   '6570002226', '55 Lemon St',   1),
('800000007', 'Mary', 'Lee',   '6570002227', '55 Lemon St',   1),
('800000008', 'Mary', 'Lee',   '6570002228', '55 Lemon St',   1);

-- 4. Minors
INSERT INTO Minor VALUES
('800000001', 2),
('800000002', 1),
('800000003', 2),
('800000004', 2),
('800000005', 2),
('800000006', 2),
('800000007', 2),
('800000008', 2);

-- 5. Courses
INSERT INTO Course VALUES
(332, 'Database', 'Fundamentals of Database Systems', 3, 1),
(120, 'Intro to CS', 'CS Basics', 3, 1),
(240, 'Computer Assembly', 'Fundamentals of Assembly', 3, 1),
(150, 'CS Ethics', 'Fundamentals of CS Ethics', 4, 2);

-- 6. Prerequisites
INSERT INTO Prerequisites VALUES
(120, 332),
(240, 120);

-- 7. Sections - FIXED: Added comma after line 4
INSERT INTO Section VALUES
(1, 332, 'CS-101', 35, '08:30:00', '09:45:00', '123456789'),
(1, 120, 'CS-102', 30, '10:00:00', '11:15:00', '123456789'),
(1, 240, 'CS-201', 40, '11:30:00', '12:45:00', '123456789'),
(1, 150, 'E-101',  45, '13:30:00', '14:45:00', '112233445'),
(2, 332, 'CS-101', 35, '08:30:00', '09:45:00', '123456789'),
(3, 332, 'CS-101', 35, '08:30:00', '09:45:00', '123456789');

-- 8. Meeting Days
INSERT INTO MeetingDays VALUES
(1, 332, 'M'),
(1, 332, 'W'),
(1, 332, 'F'),
(1, 120, 'Tu'),
(1, 120, 'Th'),
(1, 240, 'M'),
(1, 240, 'W'),
(1, 240, 'F'),
(1, 150, 'Tu'),
(1, 150, 'Th');

-- 9. Enrollment
INSERT INTO Enrollment VALUES
('800000001', 1, 332, 'A'),
('800000001', 1, 120, 'B'),
('800000002', 1, 332, 'A'),
('800000002', 1, 240, 'C'),
('800000003', 1, 120, 'B'),
('800000003', 1, 332, 'A'),
('800000004', 1, 120, 'B'),
('800000004', 1, 332, 'A'),
('800000005', 1, 120, 'B'),
('800000005', 1, 332, 'A'),
('800000006', 1, 120, 'B'),
('800000006', 1, 332, 'A'),
('800000007', 1, 120, 'B'),
('800000007', 1, 332, 'A'),
('800000008', 1, 120, 'B'),
('800000006', 1, 240, 'B'),
('800000006', 1, 150, 'A'),
('800000007', 1, 240, 'B'),
('800000007', 1, 150, 'A'),
('800000008', 1, 240, 'B'),
('800000008', 1, 150, 'A');
