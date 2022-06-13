USE [u_nstaron]
GO

/****** Object:  StoredProcedure [dbo].[DailyUpdate]    Script Date: 13.06.2022 22:40:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DailyUpdate]
AS
BEGIN

	
	-- Zmieniamy status niezapłaconych oraz z nie podaną listą uczestników na Canceled
	SET NOCOUNT ON;
	UPDATE Reservations
	SET [Status Id] = dbo.GetCancelStatusId()
	WHERE Id IN (
		SELECT Reservations.Id FROM Reservations
		LEFT JOIN ConferenceParticipants AS CP
			ON CP.[Reservation Id] = Reservations.Id
		LEFT JOIN WorkshopParticipants AS WP
			ON WP.[Reservation Id] = Reservations.Id
		LEFT JOIN ConferenceDays AS CCD
			ON CCD.Id = Reservations.[Conference Day Id]
		LEFT JOIN Workshops
			ON Workshops.Id = Reservations.[Workshop Id]
		LEFT JOIN ConferenceDays AS WCD
			ON Workshops.[Conference Day Id] = WCD.Id
		WHERE (CP.[Participant Id] IS NULL OR WP.[Participant Id] IS NULL)
		AND DATEDIFF(day, GETDATE(), ISNULL(CCD.Date, WCD.Date)) < dbo.GetAddParticipantsDeadline()
	)
	OR Id IN (
		SELECT Reservations.Id
		FROM Reservations
		INNER JOIN ConferenceDays
			ON ConferenceDays.Id = Reservations.[Conference Day Id]
			AND Reservations.[Status Id] = dbo.GetDefaultStatusId()
			AND DATEDIFF(day, GETDATE(), [Date]) < dbo.GetPayDeadline()
		LEFT JOIN Payments
			ON Payments.[Reservation Id] = Reservations.Id
		GROUP BY Reservations.Id
		HAVING ISNULL(SUM(Payments.Amount), 0) < dbo.GetReservationPrice(Reservations.Id)
	)
	
	-- Zmieniamy status na Done dla rezerwacji które się odbyły
	UPDATE Reservations
	SET [Status Id] = dbo.GetDoneStatusId()
	WHERE Id IN (
		SELECT Reservations.Id FROM Reservations
		LEFT JOIN ConferenceDays AS CCD
			ON CCD.Id = Reservations.[Conference Day Id]
		LEFT JOIN Workshops
			ON Workshops.Id = Reservations.[Workshop Id]
		LEFT JOIN ConferenceDays AS WCD
			ON Workshops.[Conference Day Id] = WCD.Id
		WHERE ISNULL(CCD.Date, WCD.Date) < GETDATE()
		AND Reservations.[Status Id] = dbo.GetConfirmedStatusId()
	)
END
GO

