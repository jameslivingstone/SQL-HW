SELECT *
FROM Person.Address;

SELECT InvoiceTotal, 
		(InvoiceTotal-(PaymentTotal+CreditTotal)) AS BalanceDue,
		(InvoiceTotal * 0.10) AS '10%', 
		(InvoiceTotal + (InvoiceTotal *0.10)) AS 'Plus10%'
FROM Invoices
WHERE (InvoiceTotal-(PaymentTotal+CreditTotal)) > 1000
ORDER BY InvoiceTotal DESC;

SELECT *
FROM Invoices;

SELECT ProductID, 
		Name AS ProductName, 
		ProductNumber, 
		MakeFlag, 
		FinishedGoodsFlag, 
		Color, 
		(ListPrice - StandardCost) AS Profit
FROM Production.Product
WHERE Color = 'Blue'
	AND
		MakeFlag = 1
ORDER BY Profit DESC;

SELECT *
FROM Invoices;

SELECT PaymentDate, InvoiceTotal, PaymentTotal
FROM Invoices
WHERE PaymentDate IS NULL AND ((InvoiceTotal - PaymentTotal) != 0)
							OR PaymentDate IS NOT NULL

SELECT *
FROM Invoices
WHERE ((InvoiceTotal - PaymentTotal - CreditTotal) 
		AND PaymentDate is NULL


SELECT *
FROM Vendors
	JOIN Invoices ON vendors.VendorID = invoices.VendorID
WHERE VendorAddress1 IS NULL;
