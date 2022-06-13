USE [u_nstaron]
GO

/****** Object:  View [dbo].[GetConferencePayments]    Script Date: 13.06.2022 22:37:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[GetConferencePayments] AS
SELECT C.Name, CD.Date, CL.[Client Name], SUM(P.Amount) AS Paid, SUM(C.Price) AS [Have To Pay] FROM Payments AS P
JOIN Reservations AS R
	ON R.Id = P.[Reservation Id]
JOIN Clients AS CL
	ON CL.Id = R.[Client Id]
JOIN ConferenceDays AS CD
	ON CD.Id = R.[Conference Day Id]
JOIN Conferences AS C
	ON C.Id = CD.[Conference Id]
GROUP BY  C.Name, CD.Date, CL.Id, CL.[Client Name]
GO

