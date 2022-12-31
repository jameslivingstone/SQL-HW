SELECT *
FROM Sales.SalesOrderHeader;


SELECT DATENAME(WEEKDAY,OrderDate) AS "Day of the Week", SUM(SubTotal) AS "Total Revenue", COUNT(SalesOrderID) AS "Number of Orders", SubTotal AS "Revenue per Order"
FROM Sales.SalesOrderHeader
GROUP BY DATENAME(dy,OrderDate),SubTotal, DATENAME(WEEKDAY,OrderDate)
ORDER BY [Revenue per Order] DESC;

--Question 1
SELECT DATENAME(WEEKDAY,OrderDate) AS "Day of the Week", 
	   SUM(SubTotal) AS "Total Revenue", 
	   COUNT(SalesOrderID) AS "Number of Orders", 
	   AVG(SubTotal) AS "Revenue per Order"
FROM Sales.SalesOrderHeader
WHERE DATENAME(YY, OrderDate) = 2012
GROUP BY  DATENAME(WEEKDAY,OrderDate)
ORDER BY [Revenue per Order] DESC;
--



SELECT*
FROM Sales.SpecialOffer;
SELECT*
FROM Sales.SpecialOfferProduct;

SELECT *
FROM Sales.SpecialOffer AS SSO
	JOIN Sales.SpecialOfferProduct AS SSOP ON SSO.SpecialOfferID = SSOP.SpecialOfferID
WHERE NOT EXISTS 
	(SELECT SpecialOfferID
	 FROM Sales.SpecialOffer
	 WHERE SSO.SpecialOfferID  = SSOP.SpecialOfferID);


SELECT *
FROM Sales.SpecialOffer AS SSO
	JOIN Sales.SpecialOfferProduct AS SSOP ON SSO.SpecialOfferID = SSOP.SpecialOfferID;
--SpecialOfferID 6,


--Question 2
SELECT DISTINCT SSO.SpecialOfferID, SSO.Description, SSO.EndDate
FROM Sales.SpecialOffer AS SSO
	LEFT JOIN Sales.SpecialOfferProduct AS SSOP ON SSO.SpecialOfferID = SSOP.SpecialOfferID
WHERE EndDate > 2012-01-01 AND SSOP.SpecialOfferID IS NULL
GROUP BY SSO.SpecialOfferID,Description, EndDate, DiscountPct
HAVING DiscountPct > 0;
--




SELECT SpecialOfferID, Description AS "SpecialOfferDescription", EndDate AS "SpecialOfferEndDate"
FROM Sales.SpecialOffer
WHERE EndDate > 2012-01-01 AND SpecialOfferID = 6
GROUP BY SpecialOfferID,Description, EndDate, DiscountPct
HAVING DiscountPct > 0;


SELECT*
FROM Sales.SalesOrderHeader;

SELECT TerritoryID, COUNT(case when OnlineOrderFlag = 0 then 1 else null end)*100/(SELECT COUNT(*) FROM Sales.SalesOrderHeader ) AS "OfflineOrders", COUNT(case when OnlineOrderFlag = 1 then 1 else null end)/COUNT(OnlineOrderFlag) *100 AS "OnlineOrders"
FROM Sales.SalesOrderHeader
GROUP BY TerritoryID;

--Question 3
SELECT TerritoryID, 
		COUNT(SalesOrderID) AS TotalOrders,
		CONCAT(CONVERT(INT,ROUND((CAST(COUNT(case when OnlineOrderFlag = 0 then 1 end) AS DECIMAL)/CAST(COUNT(OnlineOrderFlag) AS DECIMAL)) *100,0)), + '%') AS "OfflineOrders",
		CONCAT(CONVERT(INT,ROUND((CAST(COUNT(case when OnlineOrderFlag = 1 then 1 end) AS DECIMAL)/CAST(COUNT(OnlineOrderFlag) AS DECIMAL)) *100,0)), + '%') AS "OnlineOrders"
FROM Sales.SalesOrderHeader
GROUP BY TerritoryID
ORDER BY TerritoryID;
--

SELECT TerritoryID, COUNT(SalesOrderID) AS TotalOrders,
					CAST(ROUND(COUNT(case when OnlineOrderFlag = 0 then 1 else null end),2) AS varchar(6)) + ' %' AS "OfflineOrders",
					CAST(ROUND(COUNT(case when OnlineOrderFlag = 1 then 1 else null end),2) AS varchar(6)) + ' %' AS "OnlineOrders"
FROM Sales.SalesOrderHeader
GROUP BY TerritoryID
ORDER BY TerritoryID;


SELECT TerritoryID, CAST(ROUND(COUNT(case when OnlineOrderFlag = 0 then 1 else null end)*100/ COUNT(*) OVER(PARTITION BY OnlineOrderFlag),2) AS varchar(6)) + ' %' AS "OfflineOrders", CAST(ROUND(COUNT(case when OnlineOrderFlag = 1 then 1 else null end)*100/ COUNT(*) OVER(PARTITION BY OnlineOrderFlag),2) AS varchar(6)) + ' %' AS "OnlineOrders"
FROM Sales.SalesOrderHeader
GROUP BY TerritoryID, OnlineOrderFlag
ORDER BY TerritoryID;
--select Cast(Cast((37.0/38.0)*100 as decimal(18,2)) as varchar(5)) + ' %' as Percentage




SELECT*
FROM Person.Person;




SELECT COUNT(case when EmailPromotion = 0 then 1 else null end) AS "Contact does not wish to receive email promotions",
	   COUNT(case when EmailPromotion = 1 then 1 else null end) AS "Contact does wish to receive email promotions from AdventureWorks", 
	   COUNT(case when EmailPromotion = 2 then 1 else null end) AS "Contact does wish to receive email promotions from AdventureWorks and selected partners" 
FROM Person.Person;

--Question 4
SELECT CASE EmailPromotion
	   When 0 then 'Contact does not wish to receive email promotions.'
	   When 1 then 'Contact does wish to receive email promotions from AdventureWorks.'
	   When 2 then'Contact does wish to receive email promotions from AdventureWorks and selected partners.' 
	   END AS 'Email Preference',
	   COUNT(EmailPromotion) AS "Count"
FROM Person.Person
GROUP BY EmailPromotion
ORDER BY EmailPromotion;
--






SELECT BusinessEntityID, CommissionPct, Bonus,
 DENSE_RANK () OVER (ORDER BY CommissionPct DESC, Bonus DESC) AS "Rank"
FROM Sales.SalesPerson;



--Question 5