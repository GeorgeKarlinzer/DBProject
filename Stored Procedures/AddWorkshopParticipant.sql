USE [u_nstaron]
GO

/****** Object:  StoredProcedure [dbo].[AddWorkshopParticipant]    Script Date: 13.06.2022 22:40:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddWorkshopParticipant]
	@ConferenceParticipant int,
	@ReservationId int,
	@Result varchar(50) OUTPUT
AS
BEGIN
	SET @Result = 'OK'

	IF dbo.IsReservationChangable(@ReservationId) = 0
	BEGIN
		SET @Result = 'Reservation is not changable'
		RETURN 1
	END

	IF (SELECT [Workshop Id] FROM Reservations WHERE Id = @ReservationId) IS NULL
	BEGIN
		SET @Result = 'Reservation must be for workshop'
		RETURN 1
	END

	IF EXISTS(SELECT * FROM WorkshopParticipants WHERE [Reservation Id] = @ReservationId)
	BEGIN
		SET @Result = 'There is already participant'
		RETURN 1
	END

	IF NOT EXISTS(
		SELECT * FROM ConferenceParticipants AS CP
		INNER JOIN Reservations AS CR
			ON CR.Id = CP.[Reservation Id]
		WHERE CP.Id = @ConferenceParticipant
			AND CR.[Conference Day Id] = (
				SELECT W.[Conference Day Id] FROM Reservations AS R 
				JOIN Workshops AS W
					ON W.Id = R.[Workshop Id]
					AND R.Id = @ReservationId)
	) AND NOT EXISTS(SELECT * FROM WorkshopParticipants 
					 WHERE [Conference Participants Id] = @ConferenceParticipant
	)
	BEGIN
		SET @Result = 'Person must be conference participant'
		RETURN 1
	END

	INSERT INTO WorkshopParticipants([Conference Participants Id], [Reservation Id])
	VALUES(@ConferenceParticipant , @ReservationId);

	EXEC UpdateResStatus @ReservationId;
END
GO

