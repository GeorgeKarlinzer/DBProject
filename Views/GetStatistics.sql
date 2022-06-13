USE [u_nstaron]
GO

/****** Object:  View [dbo].[GetStatistics]    Script Date: 13.06.2022 22:38:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[GetStatistics] AS
SELECT C.[Client Name], COUNT(R.Id) AS [Reservation Count] FROM Reservations AS R
JOIN Clients AS C
	ON R.[Client Id] = C.Id
GROUP BY C.Id, C.[Client Name]
GO

