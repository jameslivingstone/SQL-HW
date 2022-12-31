SELECT SOH.SalesOrderID, OrderDate, ShipDate
FROM Sales.SalesOrderHeader AS SOH
	JOIN Sales.SalesOrderDetail AS SOD
		ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE OrderDate LIKE '%2014%'
GROUP BY SOH.SalesOrderID, SOH.OrderDate, SOH.ShipDate
HAVING COUNT(SOD.SalesOrderDetailID) = 12;


SELECT *
FROM Sales.SalesOrderHeader
SELECT *
FROM Sales.SalesOrderDetail
