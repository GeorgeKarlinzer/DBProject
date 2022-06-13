USE [u_nstaron]
GO

/****** Object:  StoredProcedure [dbo].[MakePayment]    Script Date: 13.06.2022 22:40:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Heorhi Kupryianau
-- Create date: 18.05.2022
-- Description:	Adding a new payment
-- =============================================
CREATE PROCEDURE [dbo].[MakePayment]
	@Amount float,
	@ReservationId int,
	@Date date,
	@Result varchar(50) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	SET @Result = 'OK'

	IF dbo.IsReservationChangable(@ReservationId) = 0
	BEGIN 
		SET @Result = 'Reservation does not exist or not active'
		RETURN 1
	END

	IF @Amount <= 0
	BEGIN
		SET @Result = 'Payment amount must be greater than 0'
		RETURN 1
	END

	INSERT INTO Payments([Reservation Id], Amount, Date)
		VALUES(@ReservationId, @Amount, @Date)
		
	EXEC UpdateResStatus @ReservationId;
END
GO

