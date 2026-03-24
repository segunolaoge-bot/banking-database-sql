-- View all customers
SELECT * FROM Customers;


-- View all accounts with customer names
SELECT 
    c.CustomerID,
    c.FullName,
    a.AccountID,
    a.AccountName,
    a.AccountType,
    a.CurrentBalance
FROM Customers c
INNER JOIN Accounts a
    ON c.CustomerID = a.CustomerID;


-- Total balance per customer
SELECT 
    c.FullName,
    SUM(a.CurrentBalance) AS TotalBalance
FROM Customers c
INNER JOIN Accounts a
    ON c.CustomerID = a.CustomerID
GROUP BY c.FullName;


-- View all transactions with account details
SELECT 
    t.TransactionID,
    c.FullName,
    a.AccountName,
    t.TransactionType,
    t.Amount,
    t.TransactionDate
FROM BankTransactions t
INNER JOIN Customers c
    ON t.CustomerID = c.CustomerID
INNER JOIN Accounts a
    ON t.AccountID = a.AccountID;


-- Customers with overdue fees
SELECT 
    c.FullName,
    f.TotalOwed,
    f.TotalPayback,
    f.OutstandingBalance
FROM Customers c
INNER JOIN OverdueFees f
    ON c.CustomerID = f.CustomerID
WHERE f.OutstandingBalance > 0;


-- Customers who paid less than 50% of their fees
SELECT 
    c.CustomerID,
    c.FullName,
    f.TotalOwed,
    f.TotalPayback
FROM Customers c
INNER JOIN OverdueFees f
    ON c.CustomerID = f.CustomerID
WHERE ISNULL(f.TotalPayback, 0) < (f.TotalOwed * 0.5);


-- Total transactions per customer
SELECT 
    c.FullName,
    COUNT(t.TransactionID) AS TotalTransactions
FROM Customers c
INNER JOIN BankTransactions t
    ON c.CustomerID = t.CustomerID
GROUP BY c.FullName;
