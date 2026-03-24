INSERT INTO Customers (FullName, Address, DateOfBirth, UserName, Password, Email, PhoneNumber)
VALUES
('Tope Steven', '25 King Street, Manchester', '1985-04-12', 'tope.steven', 'Password123', 'tope.new@gmail.com', '07999999999'),
('Amina Bello', '12 Oxford Road, Manchester', '1990-07-21', 'amina.bello', 'SecurePass1', 'amina.bello@gmail.com', '07888888888'),
('David Johnson', '40 Salford Crescent, Salford', '1988-11-10', 'david.johnson', 'MyPass456', 'david.johnson@gmail.com', '07777777777');

INSERT INTO Accounts (CustomerID, AccountName, AccountType, OpeningDate, Status, ClosedOrFrozenDate, LoanReferenceNo, CurrentBalance)
VALUES
(1, 'Tope Savings', 'Savings', '2024-01-10', 'Active', NULL, NULL, 1500.00),
(2, 'Amina Checking', 'Checking', '2024-02-15', 'Active', NULL, NULL, 2500.00),
(3, 'David Loan Account', 'Loan', '2024-03-20', 'Active', NULL, 'LN1001', 5000.00);

INSERT INTO BankTransactions (CustomerID, AccountID, TransactionDate, DueDate, CompletionDate, TransactionType, Amount, Description)
VALUES
(1, 1, '2024-04-01 10:00:00', NULL, '2024-04-01 10:00:00', 'Deposit', 1500.00, 'Initial deposit'),
(1, 1, '2024-04-05 14:30:00', NULL, '2024-04-05 14:30:00', 'Withdrawal', 300.00, 'Cash withdrawal'),
(3, 3, '2024-05-01 09:00:00', '2024-05-10 00:00:00', '2024-05-12 15:00:00', 'Payment', 200.00, 'Late loan repayment'),
(3, 3, '2024-06-01 09:30:00', '2024-06-10 00:00:00', NULL, 'Payment', 250.00, 'Pending loan repayment');

INSERT INTO OverdueFees (TransactionID, CustomerID, AccountID, DaysOverdue, FeesAmount, TotalOwed)
VALUES
(3, 3, 3, 2, 20.00, 20.00),
(4, 3, 3, 5, 50.00, 50.00);

INSERT INTO Repayments (FeeID, AmountPaid, PaymentMethod)
VALUES
(1, 10.00, 'Bank Transfer'),
(2, 20.00, 'Debit Card');
