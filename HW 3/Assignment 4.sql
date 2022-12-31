SELECT LastName, FirstName, CourseDescription
FROM Instructors AS I
	LEFT JOIN Courses AS C ON I.InstructorID = C.InstructorID
ORDER BY LastName, FirstName;

SELECT *
FROM Instructors;
SELECT *
FROM Courses;
SELECT *
FROM Students;


SELECT 'UNDERGRAD' AS Status, FirstName, LastName, EnrollmentDate, GraduationDate
FROM Students
WHERE GraduationDate IS NULL
UNION
SELECT 'GRADUATED' AS Status, FirstName, LastName, EnrollmentDate, GraduationDate
FROM Students
WHERE GraduationDate IS NOT NULL
ORDER BY EnrollmentDate;

SELECT D.DepartmentName, C.CourseID
FROM Departments AS D
	LEFT JOIN Courses AS C ON D.DepartmentID = C.DepartmentID
WHERE C.CourseID IS NULL;

SELECT *
FROM Instructors;
SELECT *
FROM Departments;

SELECT COUNT(InstructorID) AS 'Instructor Count', AVG(AnnualSalary) AS 'Average Annual Salary'
FROM Instructors
WHERE Status = 'F';

SELECT D.DepartmentName, COUNT(InstructorID) AS 'Instructor Count', MAX(AnnualSalary) AS 'Highest Paid Instructor Annual Salary'
FROM Instructors AS I
	JOIN Departments AS D ON I.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName
ORDER BY 'Instructor Count' DESC;

SELECT (I.FirstName + ' ' + I.LastName) AS 'Full Name', COUNT(C.CourseID) AS 'Number Of Courses', SUM(C.CourseUnits) AS 'Sum Of Course Units'
FROM Instructors as I
	JOIN Courses as C ON I.InstructorID = C.InstructorID 
GROUP BY (I.FirstName + ' ' + I.LastName)
ORDER BY SUM(C.CourseUnits) DESC;

SELECT D.DepartmentName, C.CourseDescription, COUNT(SC.StudentID) as 'Number Of Students'
FROM Departments AS D 
	JOIN Courses AS C ON D.DepartmentID = C.DepartmentID
	JOIN StudentCourses AS SC ON C.CourseID = SC.CourseID
GROUP BY D.DepartmentName, C.CourseDescription 
ORDER BY D.DepartmentName, COUNT(SC.StudentID);

SELECT S.StudentID, SUM(C.CourseUnits) AS 'Sum Of Course Units'
FROM Students AS S
	JOIN StudentCourses AS SC ON S.StudentID = SC.StudentID
    JOIN Courses AS C ON SC.CourseID = C.CourseID
WHERE GraduationDate IS NULL 
GROUP BY S.StudentID
HAVING SUM(C.CourseUnits) > 9
ORDER BY SUM(C.CourseUnits) DESC;

SELECT (I.LastName + ', ' + I.FirstName) AS 'Full Name', COUNT(C.CourseID) AS 'Number Of Courses' 
FROM Instructors AS I
	JOIN Courses AS C ON I.InstructorID = C.InstructorID
WHERE I.Status = 'P'
GROUP BY ROLLUP(I.LastName + ', ' + I.FirstName);

SELECT *
FROM HumanResources.Department;
SELECT*
FROM HumanResources.EmployeeDepartmentHistory;


SELECT Name AS 'Department Name', COUNT(HRED.DepartmentID) AS 'Number of Employees'
FROM HumanResources.Department AS HRD
	JOIN HumanResources.EmployeeDepartmentHistory AS HRED 
		ON HRD.DepartmentID = HRED.DepartmentID
WHERE EndDate IS NULL
GROUP BY Name,HRED.DepartmentID
ORDER BY Name;




