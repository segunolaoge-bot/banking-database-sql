CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(50) NOT NULL,
    Address NVARCHAR(150) NOT NULL,
    DateOfBirth DATE NOT NULL,
    UserName NVARCHAR(50) NOT NULL UNIQUE,
    Password NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NULL,
    PhoneNumber NVARCHAR(20) NULL
);

CREATE TABLE Accounts (
    AccountID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    AccountName NVARCHAR(100) NOT NULL,
    AccountType NVARCHAR(20) NOT NULL,
    OpeningDate DATE NOT NULL,
    Status NVARCHAR(20) NOT NULL,
    ClosedOrFrozenDate DATE NULL,
    LoanReferenceNo NVARCHAR(30) NULL,
    CurrentBalance DECIMAL(18,2) NOT NULL DEFAULT (0),

    CONSTRAINT FK_Accounts_Customers
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),

    CONSTRAINT CK_Accounts_AccountType
        CHECK (AccountType IN ('Savings', 'Checking', 'Loan', 'Credit Card', 'Investment')),

    CONSTRAINT CK_Accounts_Status
        CHECK (Status IN ('Active', 'Dormant', 'Closed', 'Frozen')),

    CONSTRAINT CK_Accounts_CloseFreezeDate
        CHECK (
            (Status IN ('Closed', 'Frozen') AND ClosedOrFrozenDate IS NOT NULL)
            OR
            (Status IN ('Active', 'Dormant') AND ClosedOrFrozenDate IS NULL)
        )
);

CREATE TABLE BankTransactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    AccountID INT NOT NULL,
    TransactionDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    DueDate DATETIME2 NULL,
    CompletionDate DATETIME2 NULL,
    TransactionType NVARCHAR(20) NOT NULL,
    Amount DECIMAL(18,2) NOT NULL,
    Description NVARCHAR(255) NULL,

    CONSTRAINT FK_BankTransactions_Customers
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),

    CONSTRAINT FK_BankTransactions_Accounts
        FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),

    CONSTRAINT CK_BankTransactions_TransactionType
        CHECK (TransactionType IN ('Deposit', 'Withdrawal', 'Transfer', 'Payment')),

    CONSTRAINT CK_BankTransactions_Amount
        CHECK (Amount > 0)
);

CREATE TABLE OverdueFees (
    FeesID INT IDENTITY(1,1) PRIMARY KEY,
    TransactionID INT NOT NULL,
    CustomerID INT NOT NULL,
    AccountID INT NOT NULL,
    DaysOverdue INT NOT NULL,
    FeesAmount DECIMAL(18,2) NOT NULL,
    TotalOwed DECIMAL(18,2) NOT NULL,
    TotalPayback DECIMAL(18,2) NOT NULL DEFAULT (0),
    OutstandingBalance AS (TotalOwed - TotalPayback) PERSISTED,
    CreatedAt DATETIME2(0) NOT NULL DEFAULT SYSDATETIME(),

    CONSTRAINT FK_OverdueFees_Transactions
        FOREIGN KEY (TransactionID) REFERENCES BankTransactions(TransactionID),

    CONSTRAINT FK_OverdueFees_Customers
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),

    CONSTRAINT FK_OverdueFees_Accounts
        FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Repayments (
    RepaymentID INT IDENTITY(1,1) PRIMARY KEY,
    FeeID INT NOT NULL,
    AmountPaid DECIMAL(18,2) NOT NULL,
    PaymentDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    PaymentMethod NVARCHAR(50) NOT NULL,

    CONSTRAINT FK_Repayments_OverdueFees
        FOREIGN KEY (FeeID) REFERENCES OverdueFees(FeesID),

    CONSTRAINT CK_Repayments_AmountPaid
        CHECK (AmountPaid > 0)
);
