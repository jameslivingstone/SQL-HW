SELECT *
FROM Sales.SalesOrderHeader;

SELECT*
FROM Person.Address;

SELECT*
FROM Person.StateProvince;

SELECT*
FROM Person.CountryRegion;

SELECT *
FROM Sales.SalesOrderDetail;

SELECT *
FROM Production.Product;

SELECT*
FROM Production.ProductSubcategory

SELECT*
FROM Production.ProductCategory;

SELECT YEAR(OrderDate) AS 'Year of Order', SUM(LineTotal) AS 'Total of Online Sales'
FROM Sales.SalesOrderHeader AS SOH
	JOIN Sales.SalesOrderDetail AS SOD ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE YEAR(OrderDate) BETWEEN 2012 AND 2013 AND OnlineOrderFlag = 1
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate) ASC;

SELECT  YEAR(OrderDate) AS 'Year of Order', PCR.Name AS 'Country', PPC.Name AS 'Category', SUM(LineTotal) AS 'Total of Online Sales'
FROM Sales.SalesOrderHeader AS SOH
	JOIN Person.Address AS PA ON SOH.ShipToAddressID = PA.AddressID
	JOIN Person.StateProvince AS PSP ON PA.StateProvinceID = PSP.StateProvinceID
	JOIN Person.CountryRegion AS PCR ON PSP.CountryRegionCode = PCR.CountryRegionCode
	JOIN Sales.SalesOrderDetail AS SOD ON SOH.SalesOrderID = SOD.SalesOrderID
	JOIN Production.Product AS PP ON SOD.ProductID = PP.ProductID
	JOIN Production.ProductSubcategory AS PPS ON PP.ProductSubcategoryID = PPS.ProductSubcategoryID
	JOIN Production.ProductCategory AS PPC ON PPS.ProductCategoryID = PPC.ProductCategoryID
WHERE YEAR(OrderDate) BETWEEN 2012 AND 2013 AND OnlineOrderFlag = 1
GROUP BY YEAR(OrderDate), PCR.Name, PPC.Name
ORDER BY YEAR(OrderDate) ASC, PCR.Name, PPC.Name;

SELECT * 
FROM FactInternetSales;

SELECT*
FROM DimProduct;

SELECT*
FROM DimProductSubcategory;

SELECT*
FROM DimProductCategory;

SELECT*
FROM DimCustomer;

SELECT*
FROM DimGeography;

SELECT YEAR(OrderDate) AS 'Order Date', SUM(SalesAmount) AS 'Total of Internet Sales'
FROM FactInternetSales
WHERE YEAR(OrderDate) BETWEEN 2012 AND 2013
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate) ASC;

SELECT YEAR(OrderDate) AS 'Order Date', EnglishCountryRegionName AS 'Country', EnglishProductCategoryName AS 'Category', SUM(SalesAmount) AS 'Total of Internet Sales'
FROM FactInternetSales AS FIS
	JOIN DimProduct AS DP ON FIS.ProductKey = DP.ProductKey
	JOIN DimProductSubcategory AS DPS ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
	JOIN DimProductCategory AS DPC ON DPS.ProductCategoryKey = DPC.ProductCategoryKey
	JOIN DimCustomer AS DC ON FIS.CustomerKey = DC.CustomerKey
	JOIN DimGeography AS DG ON DC.GeographyKey = DG.GeographyKey
WHERE YEAR(OrderDate) BETWEEN 2012 AND 2013
GROUP BY YEAR(OrderDate), EnglishCountryRegionName, EnglishProductCategoryName
ORDER BY YEAR(OrderDate) ASC, EnglishCountryRegionName, EnglishProductCategoryName;




