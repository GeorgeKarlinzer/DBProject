USE [u_nstaron]
GO

/****** Object:  StoredProcedure [dbo].[AddConference]    Script Date: 13.06.2022 22:39:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Heorhi Kupryianau
-- Create date: 17.05.2022
-- Description:	Add new conference to database
-- =============================================
CREATE PROCEDURE [dbo].[AddConference]
	@Name nvarchar(50),
	@Days DayList READONLY,
	@Capacity int,
	@Price float,
	@Region nvarchar(50),
	@City nvarchar(50),
	@Address nvarchar(50),
	@Result varchar(50) OUTPUT

AS
BEGIN
	
	SET NOCOUNT ON;
	SET @Result = 'OK'
	
	IF @Name IS NULL OR @Name = ''
		OR @Capacity IS NULL 
		OR @Price IS NULL 
		OR @Region IS NULL OR @Region = ''
		OR @City IS NULL OR @City = ''
		OR @Address IS NULL OR @Address = ''
	BEGIN
		SET @Result = 'Parameters cannot be NULL or empty'
		RETURN 1
	END
	
	IF @Capacity <= 0 
	BEGIN 
		SET @Result = 'Capacity must be greater than 0'
		RETURN 1
	END

	IF @Price < 0
	BEGIN
		SET @Result = 'Price cannot be lower than 0'
		RETURN 1
	END

	IF EXISTS(SELECT * FROM @Days WHERE [Start Time] >= [Finish Time])
	BEGIN
		SET @Result = 'Conference must finish later than begin'
		RETURN 1
	END

	IF EXISTS(SELECT * FROM @Days WHERE [Date] < GETDATE())
	BEGIN
		SET @Result = 'Conference cannot start in the past'
		RETURN 1
	END

	IF (SELECT COUNT(DISTINCT Date) FROM @Days) < (SELECT COUNT(Date) FROM @Days)
	BEGIN
		SET @Result = 'Two the same days'
		RETURN 1
	END

	IF DATEDIFF(day, (SELECT TOP 1 Date FROM @Days ORDER BY Date), (SELECT TOP 1 Date FROM @Days ORDER BY Date Desc)) <> ((SELECT COUNT(*) FROM @Days) - 1) 
	BEGIN
		SET @Result = 'Conference days must go one by one'
		RETURN 1
	END

	IF (SELECT COUNT(1) FROM @Days) = 0
	BEGIN
		SET @Result = 'Conference cannot have zero days'
		RETURN 1
	END

	INSERT INTO dbo.Conferences (
		Name, Capacity, Price, Region, City, Address
	)
	VALUES(
		@Name, @Capacity, @Price, @Region, @City, @Address
	);
	
	DECLARE @ConferenceId int = SCOPE_IDENTITY(),
			@i int = 1,
			@daysCount int,
			@TempDate Date,
			@TempST Time,
			@TempFT Time


	SELECT @daysCount = COUNT(0) FROM @Days;


	WHILE @i <= @daysCount
	BEGIN
		SELECT @TempDate = [Date], @TempST = [Start Time], @TempFT = [Finish Time] FROM @Days
		WHERE Id = @i

		INSERT INTO dbo.ConferenceDays([Conference Id], [Date], [Start Time], [Finish Time])
			VALUES(@ConferenceId, @TempDate, @TempST, @TempFT);
		
		SET @i = @i + 1
	END
	 
	RETURN
END
GO

