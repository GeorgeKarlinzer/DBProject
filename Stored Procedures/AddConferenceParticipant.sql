USE [u_nstaron]
GO

/****** Object:  StoredProcedure [dbo].[AddConferenceParticipant]    Script Date: 13.06.2022 22:39:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddConferenceParticipant]
	@ParticipantId int,
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

	IF (SELECT [Conference Day Id] FROM Reservations WHERE Id = @ReservationId) IS NULL
	BEGIN
		SET @Result = 'Reservation must be on conference'
		RETURN 1
	END

	IF EXISTS(SELECT * FROM ConferenceParticipants WHERE [Reservation Id] = @ReservationId)
	BEGIN
		SET @Result = 'There is already participant'
		RETURN 1
	END

	INSERT INTO ConferenceParticipants([Participant Id], [Reservation Id])
	VALUES(@ParticipantId, @ReservationId);

	
	EXEC UpdateResStatus @ReservationId;
END
GO

