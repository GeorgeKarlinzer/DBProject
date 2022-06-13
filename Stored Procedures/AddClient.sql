USE [u_nstaron]
GO

/****** Object:  StoredProcedure [dbo].[AddClient]    Script Date: 13.06.2022 22:39:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Natalia Staroń
-- Create date: 17.05.2022
-- Description:	Add new client to database
-- =============================================
CREATE PROCEDURE [dbo].[AddClient]

    @ClientName nvarchar(50),
    @Region nvarchar(50),
    @City nvarchar(50),
    @Address nvarchar(50),
    @NIP nvarchar(50),
    @Result varchar(50) OUTPUT

AS
BEGIN
	SET NOCOUNT ON;
    
    SET @Result = 'OK';

    IF @ClientName IS NULL OR @ClientName = ''
        OR @Region IS NULL OR @Region = ''
        OR @City IS NULL OR @City = ''
        OR @Address IS NULL OR @Address = ''
        OR @NIP IS NULL OR @NIP = ''
    BEGIN 
		SET @Result = 'Parameters cannot be NULL or empty';
		RETURN 1
	END

    INSERT INTO dbo.Clients (
        [Client Name], Region, City, Address, NIP
    )
    VALUES (
        @ClientName, @Region, @City, @Address, @NIP
    )

    RETURN
END
GO

