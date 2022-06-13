USE [u_nstaron]
GO

/****** Object:  StoredProcedure [debug].[DropTables]    Script Date: 13.06.2022 22:41:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [debug].[DropTables]
AS
BEGIN
	SET NOCOUNT ON;
	DROP TABLE IF EXISTS Payments;
	DROP TABLE IF EXISTS WorkshopParticipants;
	DROP TABLE IF EXISTS ConferenceParticipants;
	DROP TABLE IF EXISTS Participants;
	DROP TABLE IF EXISTS Reservations;
	DROP TABLE IF EXISTS ReservationStatuses;
	DROP TABLE IF EXISTS Workshops;
	DROP TABLE IF EXISTS ConferenceDays;
	DROP TABLE IF EXISTS Conferences;
	DROP TABLE IF EXISTS Clients;
END
GO

