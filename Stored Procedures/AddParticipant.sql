USE [u_nstaron]
GO

/****** Object:  StoredProcedure [dbo].[AddParticipant]    Script Date: 13.06.2022 22:39:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddParticipant]
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@Region nvarchar(50),
	@City nvarchar(50),
	@Address nvarchar(50),
	@BirthDate date,
	@Result varchar(50) OUTPUT
AS
BEGIN
	SET @Result = 'OK';
	
	IF @FirstName IS NULL OR
		@LastName IS NULL OR
		@Region IS NULL OR
		@City IS NULL OR
		@Address IS NULL OR
		@BirthDate IS NULL
	BEGIN
		SET @Result = 'Parameters cannot be null'
		RETURN 1
	END

	INSERT INTO Participants([First Name], [Last Name], Region, Address, City, [Birth Date])
	VALUES(@FirstName, @LastName, @Region, @Address, @City, @BirthDate)
END
GO

