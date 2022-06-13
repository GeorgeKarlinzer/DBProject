USE [u_nstaron]
GO

/****** Object:  View [dbo].[GetWorkshopPayments]    Script Date: 13.06.2022 22:38:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[GetWorkshopPayments] AS
SELECT W.Name, CD.Date, CL.[Client Name], SUM(P.Amount) AS Paid, SUM(W.Price) AS [Have To Pay] FROM Payments AS P
JOIN Reservations AS R
	ON R.Id = P.[Reservation Id]
JOIN Clients AS CL
	ON CL.Id = R.[Client Id]
JOIN Workshops AS W
	ON W.Id = R.[Workshop Id]
JOIN ConferenceDays AS CD
	ON CD.Id = W.[Conference Day Id]
GROUP BY W.Id, W.Name, CD.Date, CL.Id, CL.[Client Name]
GO

