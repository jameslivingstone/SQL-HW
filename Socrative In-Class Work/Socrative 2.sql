SELECT *
FROM Vendors AS V
JOIN Invoices AS I ON V.VendorID = I.VendorID
WHERE VendorAddress1 IS NULL
ORDER BY InvoiceID;

SELECT *
FROM Vendors
SELECT *
FROM Invoices

SELECT VendorName, InvoiceNumber, InvoiceTotal
FROM Vendors as V
LEFT JOIN Invoices AS I ON V.VendorID = I.VendorID
ORDER BY VendorName;