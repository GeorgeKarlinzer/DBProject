USE [u_nstaron]
GO

/****** Object:  View [dbo].[GetWorkshopParticipants]    Script Date: 13.06.2022 22:38:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[GetWorkshopParticipants] AS
SELECT W.Id AS [Workshop Id], W.Name, CD.Date, P.[First Name], P.[Last Name], CL.[Client Name] FROM Workshops AS W
JOIN Reservations AS R
	ON R.[Workshop Id] = W.Id
JOIN ConferenceDays AS CD
	ON CD.Id = W.[Conference Day Id]
JOIN WorkshopParticipants AS WP
	ON WP.[Reservation Id] = R.Id
JOIN ConferenceParticipants AS CP
	ON CP.Id = WP.[Conference Participants Id]
JOIN Participants AS P
	ON P.Id = CP.[Participant Id]
JOIN Clients AS CL
	ON CL.Id = R.[Client Id]
GO

