--Question 1
SELECT YEAR(SOH.OrderDate) AS "Year of Order", 
	   DATENAME(MONTH, SOH.OrderDate) AS "Month",
	   COUNT(SOH.AccountNumber) AS "Total Quantity Sold", 
	   SUM(SOH.Subtotal) AS "Total Revenue"
FROM Sales.SalesOrderHeader AS SOH
	 JOIN Sales.SalesOrderDetail AS SOD ON SOH.SalesOrderID = SOD.SalesOrderID
	 JOIN Production.Product AS P ON SOD.ProductID = P.ProductID
	 JOIN Production.ProductSubcategory AS PS ON P.ProductSubcategoryID = PS.ProductSubcategoryID
WHERE PS.Name = 'Road Bikes' 
	  AND YEAR(SOH.OrderDate) IN (2013,2014) 
	  AND MONTH(SOH.OrderDate) = 5
GROUP BY YEAR(SOH.OrderDate), DATENAME(MONTH,SOH.OrderDate);
--

--Question 2
SELECT DISTINCT P.Name AS "Product Name", SUM(PI.Quantity) AS "QtyOnHand"
FROM Production.ProductInventory AS PI
	 JOIN Production.Product AS P ON PI.ProductID = P.ProductID
WHERE P.ProductNumber = 'BK-R93R-48'
GROUP BY P.Name, P.ProductNumber;
--

--Question 3
SELECT P.Name AS "Component Name", SUM(PI.Quantity) AS "QtyOnHand", SUM(POD.OrderQty) AS "QtyOnOrder"
FROM Production.BillofMaterials AS BOM
	 JOIN Production.Product AS P ON BOM.ComponentID = P.ProductID
	 FULL OUTER JOIN Production.ProductInventory AS PI ON BOM.ComponentID = PI.ProductID
	 FULL OUTER JOIN Purchasing.PurchaseOrderDetail AS POD ON BOM.ComponentID = POD.ProductID
WHERE BOM.ProductAssemblyID = 751
GROUP BY P.Name
ORDER BY P.Name;
--

--Question 4
--Yes there will be a problem with the inventory, according to the data the HL Road Frame - Red.48 has no quantity on hand, and has no quantity on order.
--If this is not rectified they will not be able to complete the bicycle. They need to order more of this component. 
--

--Question 5
SELECT DISTINCT P.Name AS "Product Name",  
	   COUNT(SOH.AccountNumber) AS "Total # Sold", 
	   SUM(SOH.Subtotal) AS "Total Revenue"
FROM Sales.SalesOrderHeader AS SOH
	 JOIN Sales.SalesOrderDetail AS SOD ON SOH.SalesOrderID = SOD.SalesOrderID
	 JOIN Production.Product AS P ON SOD.ProductID = P.ProductID
WHERE P.ProductNumber = 'BK-R64Y-40'
	  AND YEAR(SOH.OrderDate) = 2013
	  AND MONTH(SOH.OrderDate) IN (11,12)
GROUP BY P.Name;

--Question 6

SELECT YEAR(SOH.OrderDate) AS Year, MONTH(SOH.OrderDate) AS "Month", 
       COUNT(SOH.AccountNumber) AS "Road Bikes Sold",
	   SUM(SOH.SubTotal) AS "Revenue"
FROM Sales.SalesOrderHeader AS SOH
	  JOIN Sales.SalesOrderDetail AS SOD ON SOH.SalesOrderID = SOD.SalesOrderID
	  JOIN Production.Product AS P ON SOD.ProductID = P.ProductID
	  JOIN Production.ProductSubcategory AS PS ON P.ProductSubcategoryID = PS.ProductSubcategoryID
WHERE PS.Name = 'Road Bikes'
      AND YEAR(SOH.OrderDate) IN (2011,2012,2013,2014) 
	  AND MONTH(SOH.OrderDate) = 5
GROUP BY YEAR(SOH.OrderDate),MONTH(SOH.OrderDate)
ORDER BY YEAR(SOH.OrderDate);
--
--200 more than they can make
SELECT *
FROM Production.BillOfMaterials;
SELECT *
FROM Production.ProductSubcategory;


--Question 7
SELECT TOP 3 P.Name AS "Product Name",  
	   COUNT(SOH.AccountNumber) AS "Total # Sold"
FROM Sales.SalesOrderHeader AS SOH
	 JOIN Sales.SalesOrderDetail AS SOD ON SOH.SalesOrderID = SOD.SalesOrderID
	 JOIN Production.Product AS P ON SOD.ProductID = P.ProductID
WHERE YEAR(SOH.OrderDate) = 2014
	  AND MONTH(SOH.OrderDate) IN (1,2,3,4,5)
	  AND ProductSubcategoryID IN (1,2,3)
GROUP BY P.Name
ORDER BY COUNT(SOH.AccountNumber) DESC;
--

--Question 8
SELECT TOP 3 P.Name AS "Product Name",  
	   SUM(SOH.Subtotal) AS "Total Revenue"
FROM Sales.SalesOrderHeader AS SOH
	 JOIN Sales.SalesOrderDetail AS SOD ON SOH.SalesOrderID = SOD.SalesOrderID
	 JOIN Production.Product AS P ON SOD.ProductID = P.ProductID
WHERE YEAR(SOH.OrderDate) = 2014
	  AND MONTH(SOH.OrderDate) IN (1,2,3,4,5)
	  AND ProductSubcategoryID IN (1,2,3)
GROUP BY P.Name
ORDER BY  SUM(SOH.Subtotal) DESC;
--

--Question 9
--The lists in #7 and #8 output are not the same. The list in #7 is comprised of the top three bikes based on total number sold.
--The list in #8 is comprised of the top three bikes based on total revenue. The Touring bikes are much more expensive than the
--other categories Mountain and Road, and thus even though they sold less in amount, they made up much more in revenue. 


--Question 10
SELECT P.Name AS "Product Name",  
	   SUM(SOH.Subtotal) AS "Total Revenue",
	   SUM(P.STANDARDCOST) AS "Total Cost",
	   (SUM(SOH.SubTotal) - SUM(P.STANDARDCOST)) AS "Profit",
	   CONCAT(CAST(((SUM(SOH.SubTotal) - SUM(P.STANDARDCOST)) / SUM(SOH.SubTotal))
	   AS DECIMAL(4, 4)), '%') AS "Profit Margin"
FROM Production.Product AS P
	 JOIN Production.ProductSubcategory AS PS ON P.ProductSubcategoryID = PS.ProductSubcategoryID
	 JOIN Sales.SalesOrderDetail AS SOD ON P.ProductID = SOD.ProductID
	 JOIN Sales.SalesOrderHeader AS SOH ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE PS.Name = 'Road Bikes'
      AND YEAR(SOH.OrderDate) = 2014
	  AND MONTH(SOH.OrderDate) <= 5
GROUP BY P.Name
ORDER BY  [Profit Margin] DESC;
--This type of profit margin can be achieved by outsourcing the labor to third world countries for example.
--The material itself can be of good quality while cutting cost in labor would increase profit margin, but there is also the option to attempt
--to use cheaper materials and produce lesser quality products but retain the prices they charged otherwise, thus increasing the profit margin even more. 
--With manufacturing being done in the United States, these profit margins are much more difficult to achieve. 