USE [u_nstaron]
GO

/****** Object:  StoredProcedure [dbo].[AddReservation]    Script Date: 13.06.2022 22:40:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddReservation]

    @ConferenceDayId int,
    @WorkshopId int,
    @ClientId int,
    @Result varchar(50) OUTPUT

AS
BEGIN
	SET NOCOUNT ON;

    SET @Result = 'OK';

	IF (@ConferenceDayId IS NULL AND @WorkshopId IS NULL) OR (@ConferenceDayId IS NOT NULL AND @WorkshopId IS NOT NULL)
	BEGIN 
		SET @Result = 'Reservation must be on conference or workshop'
		RETURN 1
	END


	DECLARE @ConferenceDate Date = (SELECT [Date] FROM ConferenceDays WHERE Id = @ConferenceDayId)
	

	IF DATEDIFF(DAY, CONVERT(DATE, GETDATE()), @ConferenceDate) < dbo.GetAddParticipantsDeadline()
	OR DATEDIFF(DAY, CONVERT(DATE, GETDATE()), @ConferenceDate) < dbo.GetPayDeadline()
	BEGIN
		SET @Result = 'Too late for reservation'
		RETURN 1
	END
	
	IF (@WorkshopId IS NULL 
		AND (SELECT (Capacity - Occupied) FROM GetConferencesOccupancy WHERE [Conference Day Id] = @ConferenceDayId) <= 0
		) OR (SELECT (Capacity - Occupied) FROM GetWorkshopsOccupancy WHERE [Workshop Id] = @WorkshopId) <= 0
	BEGIN
		SET @Result = 'Too  many participants'
		RETURN 1
	END

		
	INSERT INTO dbo.Reservations (
        [Conference Day Id], [Workshop Id], [Client Id], [Status Id]
    )
    VALUES (
        @ConferenceDayId, @WorkshopId, @ClientId, dbo.GetDefaultStatusId()
    )

    RETURN
END
GO

