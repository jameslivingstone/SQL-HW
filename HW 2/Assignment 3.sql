SELECT *
FROM Courses

SELECT *
FROM Departments

SELECT *
FROM Instructors

SELECT *
FROM StudentCourses

SELECT *
FROM Students

SELECT CourseNumber, CourseDescription, DepartmentName
FROM Courses AS C
JOIN Departments AS D ON C.DepartmentID = D.DepartmentID
ORDER BY DepartmentName, CourseNumber ASC; 

SELECT LastName, FirstName, CourseNumber, CourseDescription
FROM Instructors AS I
JOIN Courses AS C ON I.DepartmentID = C.DepartmentID
WHERE Status = 'P'
ORDER BY LastName, FirstName ASC;

SELECT DepartmentName, CourseDescription, LastName, FirstName
FROM Departments AS D
	JOIN Courses AS C ON C.DepartmentID = D.DepartmentID
	JOIN Instructors AS I ON I.DepartmentID = C.DepartmentID
ORDER BY DepartmentName, CourseDescription ASC;

SELECT DepartmentName, CourseDescription, LastName, FirstName
FROM Departments AS D
	JOIN Courses AS C ON C.DepartmentID = D.DepartmentID
	JOIN StudentCourses AS SC ON SC.CourseID = C.CourseID
	JOIN Students AS S ON S.StudentID = SC.StudentID
WHERE DepartmentName = 'English'
ORDER BY DepartmentName, CourseDescription ASC;
	
SELECT ID.DepartmentName AS 'InstructorDept', I.LastName, I.FirstName, C.CourseDescription, CD.DepartmentName AS 'CourseDept'
FROM Courses AS C
	JOIN Departments AS CD ON C.DepartmentID = CD.DepartmentID 
	JOIN Instructors AS I ON C.InstructorID = I.InstructorID 
	JOIN Departments AS ID ON I.DepartmentID = ID.DepartmentID
WHERE CD.DepartmentID != ID.DepartmentID;

SELECT *
FROM HumanResources.Employee

SELECT *
FROM Person.Person

SELECT * 
FROM Sales.SalesPerson

SELECT HR.BusinessEntityID AS ID, LastName AS 'last name', FirstName AS 'first name', JobTitle AS 'job title', BirthDate AS 'date of birth'
FROM HumanResources.Employee AS HR
JOIN Person.Person AS P ON HR.BusinessEntityID = P.BusinessEntityID
ORDER BY 'last name', 'first name';

SELECT LastName +', '+ FirstName AS FullName, SalesYTD, CommissionPct * SalesYTD AS 'CommissionYTD'
FROM Sales.SalesPerson AS S
JOIN Person.Person AS P ON S.BusinessEntityID = P.BusinessEntityID
ORDER BY SalesYTD DESC
OFFSET 0 ROWS 
FETCH FIRST 5 ROWS ONLY;

SELECT *
FROM HumanResources.Employee;
SELECT *
FROM Person.Person;
SELECT *
FROM Person.BusinessEntityAddress;
SELECT *
FROM Person.Address;
SELECT *
FROM Person.StateProvince;
SELECT *
FROM Person.PersonPhone;
SELECT *
FROM Person.PhoneNumberType;

SELECT LastName +', '+ FirstName AS 'EmpolyeeName', JobTitle AS 'job title', 
BirthDate AS 'date of birth', AddressLine1 + ' ' + City + ' ' + 'State' + ' ' + PostalCode AS CSZ, 
PhoneNumber AS 'phone number', PPN.PhoneNumberTypeID AS 'type of phone number'
FROM HumanResources.Employee AS HR
JOIN Person.Person AS P ON HR.BusinessEntityID = P.BusinessEntityID
JOIN Person.BusinessEntityAddress AS PB ON P.BusinessEntityID = PB.BusinessEntityID
JOIN Person.Address AS PA ON PB.AddressID = PA.AddressID
JOIN Person.StateProvince AS PSP ON PA.StateProvinceID = PSP.StateProvinceID
JOIN Person.PersonPhone AS PPP ON HR.BusinessEntityID = PPP.BusinessEntityID
JOIN Person.PhoneNumberType AS PPN ON PPP.PhoneNumberTypeID = PPN.PhoneNumberTypeID;

SELECT BusinessEntityID, FirstName, MiddleName, LastName
FROM Person.Person
WHERE FirstName LIKE '[EIN]_____'
	AND LastName LIKE 'Z%';

SELECT LastName + ', ' + FirstName AS EmployeeName, EmailAddress AS Email
FROM HumanResources.Employee AS HR
	JOIN Person.Person AS P ON HR.BusinessEntityID = P.BusinessEntityID
	JOIN HumanResources.EmployeeDepartmentHistory AS HRDH ON P.BusinessEntityID = HRDH.BusinessEntityID
	JOIN HumanResources.Department AS HRD ON HRDH.DepartmentID = HRD.DepartmentID
	JOIN Person.EmailAddress AS PE ON HRDH.BusinessEntityID = PE.BusinessEntityID
WHERE EndDate IS NULL AND GroupName = 'Executive General and Administration';

SELECT LastName + ', ' + FirstName AS EmployeeName, EmailAddress AS Email
FROM HumanResources.Employee AS HR
	JOIN Person.Person AS P ON HR.BusinessEntityID = P.BusinessEntityID
	JOIN HumanResources.EmployeeDepartmentHistory AS HRDH ON P.BusinessEntityID = HRDH.BusinessEntityID
		AND EndDate IS NULL
	JOIN HumanResources.Department AS HRD ON HRDH.DepartmentID = HRD.DepartmentID
	JOIN Person.EmailAddress AS PE ON HRDH.BusinessEntityID = PE.BusinessEntityID
WHERE GroupName = 'Executive General and Administration';
