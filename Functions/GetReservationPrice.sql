USE [u_nstaron]
GO

/****** Object:  UserDefinedFunction [dbo].[GetReservationPrice]    Script Date: 13.06.2022 22:43:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetReservationPrice]
(
	@ReservationId int
)
RETURNS float
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM Reservations WHERE Id = @ReservationId)
		RETURN 0

	DECLARE @ConferencePrice float,
			@WorkshopPrice float;

	IF (SELECT [Workshop Id] FROM Reservations WHERE Id = @ReservationId) IS NULL
	BEGIN
		SELECT @ConferencePrice = Price
		FROM Reservations
		INNER JOIN ConferenceDays
			ON ConferenceDays.Id = Reservations.[Conference Day Id]
			AND Reservations.Id = @ReservationId
		INNER JOIN Conferences
			ON ConferenceDays.[Conference Id] = Conferences.Id
		RETURN @ConferencePrice
	END
	ELSE
	BEGIN
		SELECT @WorkshopPrice = Price
		FROM Reservations
		INNER JOIN Workshops
			ON Workshops.Id = Reservations.[Workshop Id]
			AND Reservations.Id = @ReservationId
		RETURN @WorkshopPrice
	END

	RETURN 0
END
GO

