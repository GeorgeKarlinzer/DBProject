USE [u_nstaron]
GO

/****** Object:  StoredProcedure [dbo].[UpdateResStatus]    Script Date: 13.06.2022 22:40:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateResStatus] 
	@ResId int
AS
BEGIN
	IF dbo.GetReservationPrice(@ResId) > dbo.GetAmountPaid(@ResId)
		RETURN

	IF NOT EXISTS(SELECT * FROM ConferenceParticipants WHERE [Reservation Id] = @ResId)
	AND NOT EXISTS(SELECT * FROM WorkshopParticipants WHERE [Reservation Id] = @ResId)
		RETURN



	UPDATE Reservations
	SET [Status Id] = dbo.GetConfirmedStatusId()
	WHERE Id = @ResId;
END
GO

