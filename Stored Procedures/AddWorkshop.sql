USE [u_nstaron]
GO

/****** Object:  StoredProcedure [dbo].[AddWorkshop]    Script Date: 13.06.2022 22:40:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Natalia Staroń
-- Create date: 17.05.2022
-- Description:	add new workshop to database
-- =============================================
CREATE PROCEDURE [dbo].[AddWorkshop]

    @Name nvarchar(50),
    @StartTime time,
    @FinishTime time,
    @Capacity int,
    @Price float,
    @Region nvarchar(50),
    @City nvarchar(50),
    @Address nvarchar(50),
    @ConferenceDayId int,
    @Result varchar(50) OUTPUT

	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    
    SET @Result = 'OK';

    IF @Name IS NULL OR @Name = ''
        OR @StartTime IS NULL OR @StartTime = ''
        OR @FinishTime IS NULL OR @FinishTime = ''
        OR @Capacity IS NULL 
        OR @Price IS NULL 
        OR @Region IS NULL OR @Region = ''
        OR @City IS NULL OR @City = ''
        OR @Address IS NULL OR @Address = ''
		OR @ConferenceDayId IS NULL
    BEGIN 
    
		SET @Result = 'Parameters cannot be NULL or empty';
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

    IF @StartTime > @FinishTime
	BEGIN
		SET @Result = 'Workshop cannot finish earlier than begin'
		RETURN 1
	END 

	IF EXISTS(SELECT * FROM ConferenceDays WHERE Id = @ConferenceDayId AND Date < GETDATE())
	BEGIN
		SET @Result = 'Conference day is over'
		RETURN 1
	END

    DECLARE @st Time, @ft Time

    SELECT @st = [Start Time], @ft = [Finish Time]
    FROM dbo.ConferenceDays
    WHERE Id = @ConferenceDayId

    IF @st > @StartTime OR @ft < @FinishTime
	BEGIN
		SET @Result = 'Workshops have to be done at Conference time'
		RETURN 1
	END

	DECLARE @ConferenceCap int;

	SELECT @ConferenceCap = Capacity FROM Conferences 
		INNER JOIN ConferenceDays 
			ON [Conference Id] = Conferences.Id
		WHERE ConferenceDays.Id = @ConferenceDayId

	IF @Capacity > @ConferenceCap
	BEGIN
		SET @Result = 'Too many participants'
		RETURN 1
	END

    INSERT INTO dbo.Workshops (
        [Conference Day Id], Name, [Start Time], [Finish Time], Capacity, Price, Region, City, Address
    )
    VALUES (
		@ConferenceDayId, @Name, @StartTime, @FinishTime, @Capacity, @Price, @Region, @City, @Address
    )

    RETURN
END
GO

