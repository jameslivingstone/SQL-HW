SELECT *
FROM Courses;

SELECT CourseNumber, CourseDescription, CourseUnits
FROM Courses
ORDER BY CourseNumber ASC;

SELECT LastName, +' '+ FirstName AS FullName
FROM STUDENTS
WHERE LastName BETWEEN 'A' and 'M'
ORDER BY LastName ASC;

SELECT LastName +', '+ FirstName AS FullName
FROM STUDENTS
WHERE LastName BETWEEN 'A' and 'M'
ORDER BY LastName ASC;

SELECT LastName, FirstName, AnnualSalary
FROM Instructors
WHERE AnnualSalary >= 60000
ORDER BY AnnualSalary DESC;

SELECT LastName, FirstName, HireDate
FROM Instructors
WHERE HireDate BETWEEN '2019-01-01' AND '2019-12-31'
ORDER BY HireDate ASC;

SELECT FirstName, LastName, EnrollmentDate, CurrentDate, DATEDIFF(month, EnrollmentDate, CurrentDate) AS MonthsAttended
FROM 
(SELECT FirstName, LastName, EnrollmentDate, GETDATE() AS CurrentDate
FROM Students) StudentsWithDate
ORDER BY MonthsAttended ASC;

SELECT TOP 20 PERCENT (AnnualSalary),FirstName, LastName
FROM Instructors
ORDER BY AnnualSalary DESC;

SELECT LastName, FirstName
FROM Students
WHERE LastName LIKE 'G%'
ORDER BY LastName ASC;

SELECT LastName, FirstName, EnrollmentDate, GraduationDate
FROM Students
WHERE EnrollmentDate > '2019-12-01'
	AND GraduationDate IS NULL;

SELECT FullTimeCost, PerUnitCost, Units, TotalPerUnitCost, FullTimeCost + TotalPerUnitCost AS TotalTuition
FROM(
SELECT FullTimeCost, PerUnitCost, Units, PerUnitCost * Units AS TotalPerUnitCost
FROM (
		SELECT
			PerUnitCost,
			FullTimeCost,
			'12' AS Units
		FROM 
			Tuition) TuitionWithUnits)TotalTuitionCost;







