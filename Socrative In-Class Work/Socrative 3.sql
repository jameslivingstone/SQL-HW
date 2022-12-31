SELECT InvoiceID, InvoiceLineItemAmount, (InvoiceLineItemAmount * 1.15) AS NewAmount
FROM InvoiceLineItems
WHERE InvoiceLineItemDescription = 'Freight' --should have been LIKE '%Frieght%'
ORDER BY NewAmount DESC;

SELECT * 
FROM InvoiceLineItems

SELECT *
FROM Invoices

SELECT InvoiceID, InvoiceDate, InvoiceDueDate AS InvoiceDue, CONVERT(VARCHAR(6), InvoiceDueDate, 100) AS 'InvoiceDue'
FROM Invoices;

