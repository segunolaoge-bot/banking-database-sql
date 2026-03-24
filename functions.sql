-- Function to return the number of account holders for a given account number
IF OBJECT_ID('uf_NumberOfAccountHolders', 'FN') IS NOT NULL
    DROP FUNCTION uf_NumberOfAccountHolders;
GO

CREATE FUNCTION uf_NumberOfAccountHolders (@accountnumber NVARCHAR(30))
RETURNS INT
AS
BEGIN
    RETURN (
        SELECT COUNT(*)
        FROM Accounts
        WHERE LoanReferenceNo = @accountnumber
           OR AccountName = @accountnumber
    );
END;
GO


-- Function to calculate days overdue for a payment
IF OBJECT_ID('fn_CalculateDaysOverdue', 'FN') IS NOT NULL
    DROP FUNCTION fn_CalculateDaysOverdue;
GO

CREATE FUNCTION fn_CalculateDaysOverdue
(
    @DueDate DATETIME2,
    @CompletionDate DATETIME2
)
RETURNS INT
AS
BEGIN
    DECLARE @DaysOverdue INT;

    IF @CompletionDate IS NULL
        SET @DaysOverdue = DATEDIFF(DAY, @DueDate, GETDATE());
    ELSE
        SET @DaysOverdue = DATEDIFF(DAY, @DueDate, @CompletionDate);

    RETURN CASE 
        WHEN @DaysOverdue < 0 THEN 0
        ELSE @DaysOverdue
    END;
END;
GO
