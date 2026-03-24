-- Procedure to update customer details
IF OBJECT_ID('usp_UpdateCustomer', 'P') IS NOT NULL
    DROP PROCEDURE usp_UpdateCustomer;
GO

CREATE PROCEDURE usp_UpdateCustomer
    @CustomerID INT,
    @FullName NVARCHAR(50),
    @Address NVARCHAR(150),
    @DateOfBirth DATE,
    @UserName NVARCHAR(50),
    @Password NVARCHAR(50),
    @Email NVARCHAR(100),
    @PhoneNumber NVARCHAR(20)
AS
BEGIN
    UPDATE Customers
    SET 
        FullName = @FullName,
        Address = @Address,
        DateOfBirth = @DateOfBirth,
        UserName = @UserName,
        Password = @Password,
        Email = @Email,
        PhoneNumber = @PhoneNumber
    WHERE CustomerID = @CustomerID;
END;
GO


-- Procedure to search accounts by name
IF OBJECT_ID('usp_SearchAccountsByName', 'P') IS NOT NULL
    DROP PROCEDURE usp_SearchAccountsByName;
GO

CREATE PROCEDURE usp_SearchAccountsByName
    @AccountName NVARCHAR(100)
AS
BEGIN
    SELECT *
    FROM Accounts
    WHERE AccountName LIKE '%' + @AccountName + '%';
END;
GO
