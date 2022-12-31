SELECT DISTINCT LastName, FirstName
FROM Instructors AS I
WHERE 
	I.InstructorID IN 
	(SELECT InstructorID
	 FROM Courses AS C)
ORDER BY LastName, FirstName;

SELECT LastName, FirstName 
FROM Instructors AS I 
WHERE 
	I.AnnualSalary >
	(SELECT AVG(AnnualSalary) 
	 FROM Instructors) 
ORDER BY AnnualSalary DESC;

SELECT DISTINCT LastName, FirstName
FROM Instructors AS I 
WHERE NOT EXISTS 
	(SELECT InstructorID
	 FROM Courses AS C 
	 WHERE C.InstructorID = I.InstructorID) 
ORDER BY LastName, FirstName;

SELECT LastName, FirstName, COUNT(*) AS 'Number Of Courses'
FROM Students AS S JOIN StudentCourses AS SC ON S.StudentID = SC.StudentID
WHERE SC.StudentID IN
	(SELECT StudentID
	 FROM StudentCourses AS SC 
	 JOIN Courses AS C ON SC.CourseID = C.CourseID
	 GROUP BY StudentID
	 HAVING COUNT(*) > 1)
GROUP BY LastName, FirstName
ORDER BY LastName, FirstName;

SELECT LastName, FirstName, AnnualSalary
FROM Instructors
WHERE AnnualSalary NOT IN
	(SELECT AnnualSalary
	 FROM Instructors
	 GROUP BY AnnualSalary
	 HAVING COUNT(AnnualSalary) > 1)
ORDER BY LastName, FirstName;

INSERT INTO Departments (DepartmentName) 
VALUES ('History');

DELETE FROM Departments 
WHERE DepartmentName = 'History';

SELECT *
FROM Departments;

INSERT INTO Instructors(LastName, FirstName, Status, DepartmentChairman, HireDate, AnnualSalary, DepartmentID)
VALUES ('Benedict', 'Susan', 'P', 0, GETDATE(), 34000.00, 9),('Adams', null, 'F', 1, GETDATE(), 66000.00, 9);

UPDATE Instructors
SET AnnualSalary = 35000.00
WHERE InstructorID =
	(SELECT InstructorID
	 FROM Instructors
	 WHERE LastName = 'Benedict'
	 AND FirstName = 'Susan');

DELETE FROM Instructors
WHERE InstructorID =
	(SELECT InstructorID
	 FROM Instructors
	 WHERE LastName = 'Adams'
	 AND FirstName IS NULL);

DELETE FROM Instructors
WHERE DepartmentID = 9;
DELETE FROM Departments
WHERE DepartmentID = 9;

UPDATE Instructors
SET AnnualSalary = (1.05*AnnualSalary)
FROM Instructors AS I 
	JOIN Departments AS D
ON I.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Education';

SELECT *
FROM Instructors;

SELECT *
FROM Students;

DELETE FROM Instructors
WHERE InstructorID NOT IN 
	(SELECT InstructorID 
	 FROM Courses );

DROP TABLE GradStudents

CREATE TABLE GradStudents (
StudentID INT NOT NULL PRIMARY KEY,
LastName CHAR,
FirstName CHAR,
EnrollmentDate VARCHAR(20),
GraduationDate VARCHAR(20));

SELECT * INTO GradStudents FROM Students
WHERE GraduationDate IS NOT NULL;

SELECT * 
FROM Gradstudents;

SELECT  AnnualSalary/12 AS 'MonthlySalary', 
		CAST(AnnualSalary/12 AS DECIMAL(10,1)) AS 'Cast_MonthlySalary',
		CONVERT(INT, AnnualSalary/12) AS 'Convert_MonthlySalary_Int', 
		CAST(AnnualSalary/12 AS INT) AS 'Cast_MonthlySalary_Int'
FROM Instructors;

SELECT  EnrollmentDate, 
		CAST(EnrollmentDate AS DATE) AS 'Cast_EnrollmentDate', 
		CAST(EnrollmentDate AS DATETIME) AS 'Cast_EnrollmentDate1',
		CAST(EnrollmentDate AS CHAR(7)) AS 'Cast_EnrollmentDate2'
FROM Students;

SELECT  EnrollmentDate, 
		CONVERT(VARCHAR, EnrollmentDate, 101) AS 'Convert_EnrollmentDate',
		CONVERT(VARCHAR, EnrollmentDate, 100) AS 'Convert_EnrollmentDate1',
		CONVERT(VARCHAR, EnrollmentDate, 113) AS 'Convert_EnrollmentDate2', 
		CONVERT(VARCHAR(5), EnrollmentDate, 101) AS 'Convert_EnrollmentDate3'
FROM Students;