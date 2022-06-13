USE [u_nstaron]
GO

/****** Object:  StoredProcedure [dbo].[CancelReservation]    Script Date: 13.06.2022 22:40:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Heorhi Kupryianau
-- Create date: 18.05.2022
-- Description:	Cancel reservation
-- =============================================
CREATE PROCEDURE [dbo].[CancelReservation]
	@ReservationId int,
	@Result varchar(50) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	SET @Result = 'OK'

	IF NOT EXISTS(SELECT * FROM Reservations WHERE Id = @ReservationId)
	BEGIN
		SET @Result = 'Reservation does not exist'
		RETURN 1
	END

	UPDATE Reservations
	SET [Status Id] = dbo.GetCancelStatusId()
	WHERE Id = @ReservationId

	RETURN
END
GO

