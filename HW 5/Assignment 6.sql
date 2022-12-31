
--1
SELECT AnnualSalary , AnnualSalary/12 AS MonthlySalary , ROUND(AnnualSalary/12, 2) AS MonthlySalaryRounded 
FROM Instructors;
--2
SELECT EnrollmentDate , YEAR(EnrollmentDate) AS EnrollYear , DAY(EnrollmentDate) AS EnrollDoM , YEAR(DATEADD(YEAR, 4, EnrollmentDate)) AS PossibleGradYear
FROM Students;
--3
SELECT D.DepartmentName, C.CourseNumber, I.FirstName, I.LastName, 
CONCAT(UPPER(SUBSTRING(D.DepartmentName,1,3)), CAST(C.CourseNumber as varchar) ,SUBSTRING(I.FirstName,1,1),  LastName) AS ConcatColumn
FROM Departments AS D
	 JOIN Courses AS C ON D.DepartmentID = C.DepartmentID
	 JOIN Instructors AS I ON D.DepartmentID = I.DepartmentID;

SELECT D.DepartmentName, C.CourseNumber, I.FirstName, I.LastName, 
CONCAT(UPPER(SUBSTRING(D.DepartmentName,1,3)), CAST(C.CourseNumber as varchar) ,ISNULL(SUBSTRING(I.FirstName,1,1),1),  LastName) AS ConcatColumn
FROM Departments AS D
	 JOIN Courses AS C ON D.DepartmentID = C.DepartmentID
	 JOIN Instructors AS I ON C.InstructorID = I.InstructorID;

SELECT D.DepartmentName, C.CourseNumber, I.FirstName, I.LastName,
	   UPPER(LEFT(D.DepartmentName, 3)) + (CAST(C.CourseNumber AS VARCHAR)) +
	   LEFT(ISNULL(I.FirstName, ''),1) +(I.LastName) AS CourseNumber
FROM Departments AS D
	 JOIN Courses AS C ON D.DepartmentID = C.DepartmentID
	 JOIN Instructors AS I ON C.InstructorID = I.InstructorID;

	
--4
SELECT FirstName, LastName, EnrollmentDate, GraduationDate, DATEDIFF(month, EnrollmentDate, GraduationDate) AS MonthsToGraduate
FROM Students AS S 
WHERE GraduationDate IS NOT NULL;

SELECT *
FROM Students;
--5
SELECT (I.LastName + ', ' + I.FirstName) AS 'FullName', COUNT(C.CourseID) AS 'NumberOfCourses',
	 (CASE 
		WHEN I.FirstName IS NULL THEN 'FNU'
		ELSE I.FirstName
	 END) AS FirstName
FROM Instructors AS I
	 LEFT JOIN Courses AS C ON I.InstructorID = C.InstructorID
WHERE I.Status = 'P'
GROUP BY ROLLUP(I.LastName + ', ' + I.FirstName);

SELECT (I.LastName + ', ' + I.FirstName) AS 'FullName', COUNT(C.CourseID) AS 'NumberOfCourses',
		coalesce(I.FirstName, 'FNU')
FROM Instructors AS I
	 LEFT JOIN Courses AS C ON I.InstructorID = C.InstructorID
WHERE I.Status = 'P'
GROUP BY I.FirstName, (I.LastName + ', ' + I.FirstName) WITH ROLLUP;

--5 answer
SELECT COALESCE(CAST(LastName + ', ' + FirstName AS varchar), 'FNU') AS FullName, COUNT(CourseID) AS NumberofCourses
FROM Instructors AS I
	 LEFT JOIN Courses AS C ON I.InstructorID = C.InstructorID
WHERE I.Status = 'P'
GROUP BY (LastName + ', ' + FirstName) WITH ROLLUP;

SELECT CASE WHEN GROUPING(ISNULL(LastName + ', ' + FirstName, 'FNU')) = 1 THEN 'GrandTotal'
			ELSE ISNULL(LastName + ', ' + FirstName, 'FNU') END,
			COUNT(CourseID) AS NumberOfCourses
FROM Instructors AS I
		LEFT JOIN Courses AS C ON I.InstructorID = C.InstructorID
WHERE Status = 'P'
GROUP BY ROLLUP (ISNULL(LastName + ', ' + FirstName, 'FNU'));



SELECT *
FROM Invoices;


SELECT COUNT(*) AS NumberOfSales, InvoiceDate
FROM Invoices
Group By InvoiceDate

--6

SELECT SUM(COUNT(*)) OVER(ORDER BY InvoiceDate) AS RunningTotal, LAG(COUNT(*),7) OVER (ORDER BY InvoiceDate) AS '7-day lag', NmbrSales, InvoiceDate
FROM
	(SELECT InvoiceDate, COUNT(*) AS NmbrSales
	 FROM Invoices
	 GROUP BY InvoiceDate) Invoices
Group By InvoiceDate, NmbrSales
ORDER BY InvoiceDate;



SELECT InvoiceDate, COUNT(*) AS NmbrSales, SUM(COUNT(*)) OVER(ORDER BY InvoiceDate) AS RunningTotal, LAG(COUNT(*),7) OVER (ORDER BY InvoiceDate) AS '7-day lag'
FROM Invoices
Group By InvoiceDate
ORDER BY InvoiceDate;


--7
SELECT (CASE WHEN MiddleName IS NOT NULL
		THEN (FirstName + ', ' + MiddleName + '. ' + LastName)
		ELSE (FirstName + ', ' + LastName)
		END) AS FullName, 
		(CASE WHEN PersonType = 'SC' THEN 'Store Contact'
			  WHEN PersonType = 'IN' THEN 'Individual Customer'
			  WHEN PersonType = 'SP' THEN 'Sales Person'
			  WHEN PersonType = 'EM' THEN 'Employee'
			  WHEN PersonType = 'VC' THEN 'Vendor Contact'
			  WHEN PersonType = 'GC' THEN 'General Contact'
		 END) AS 'Person_Type'
FROM Person.Person;


SELECT Person.Person.PersonType
FROM Person.Person;

--8
SELECT LastName, TerritoryName, CountryRegionName
FROM Sales.vSalesPerson
WHERE TerritoryName IS NOT NULL
ORDER BY (CASE WHEN CountryRegionName = 'United States' THEN TerritoryName
			ELSE CountryRegionName
		 END);