USE [u_nstaron]
GO

/****** Object:  StoredProcedure [debug].[CreateTables]    Script Date: 13.06.2022 22:41:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [debug].[CreateTables]
AS
BEGIN
	CREATE TABLE Clients(
	[Id] int IDENTITY(1, 1) PRIMARY KEY NOT NULL ,
	[Client Name] nvarchar(50) NOT NULL,
	[Region] nvarchar(50) NOT NULL,
	[City] nvarchar(50) NOT NULL,
	[Address] nvarchar(50) NOT NULL,
	[NIP] nvarchar(50) NOT NULL
);

CREATE TABLE Conferences(
	[Id] int IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[Name] nvarchar(50) NOT NULL,
	[Capacity] int NOT NULL,
	[Price] float NOT NULL,
	[Region] nvarchar(50) NOT NULL,
	[City] nvarchar(50) NOT NULL,
	[Address] nvarchar(50) NOT NULL
);

CREATE TABLE ConferenceDays(
	[Id] int IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[Conference Id] int FOREIGN KEY REFERENCES Conferences(Id) NOT NULL,
	[Date] Date NOT NULL,
	[Start Time] Time NOT NULL,
	[Finish Time] Time NOT NULL
);

CREATE TABLE Workshops(
	[Id] int IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[Conference Day Id] int FOREIGN KEY REFERENCES ConferenceDays(Id) NOT NULL,
	[Name] nvarchar(50) NOT NULL,
	[Start Time] Time NOT NULL,
	[Finish Time] Time NOT NULL,
	[Capacity] int NOT NULL,
	[Price] float NOT NULL,
	[Region] nvarchar(50) NOT NULL,
	[City] nvarchar(50) NOT NULL,
	[Address] nvarchar(50) NOT NULL
);

CREATE TABLE ReservationStatuses(
	[Id] int IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[Label] nvarchar(50) NOT NULL
);

INSERT INTO ReservationStatuses(Label)
	VALUES  ('Waiting for confirmation'),
			('Waiting for confirmation after the deadline'),
			('Confirmed'),
			('Done'),
			('Canceled')

CREATE TABLE Reservations(
	[Id] int IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[Conference Day Id] int FOREIGN KEY REFERENCES ConferenceDays(Id) NULL,
	[Workshop Id] int FOREIGN KEY REFERENCES Workshops(Id) NULL,
	[Client Id] int FOREIGN KEY REFERENCES Clients(Id) NOT NULL,
	[Status Id] int FOREIGN KEY REFERENCES ReservationStatuses(Id) NOT NULL,
);


CREATE TABLE Participants(
	[Id] int IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[First Name] nvarchar(50) NOT NULL,
	[Last Name] nvarchar(50) NOT NULL,
	[Region] nvarchar(50) NOT NULL,
	[City] nvarchar(50) NOT NULL,
	[Address] nvarchar(50) NOT NULL,
	[Birth Date] Date NOT NULL
);

CREATE TABLE ConferenceParticipants(
	[Id] int IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[Participant Id] int FOREIGN KEY REFERENCES Participants(Id) NOT NULL,
	[Reservation Id] int FOREIGN KEY REFERENCES Reservations(Id) NOT NULL,
);

CREATE TABLE WorkshopParticipants(
	Id int IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[Conference Participants Id] int FOREIGN KEY REFERENCES ConferenceParticipants(Id) NOT NULL,
	[Reservation Id] int FOREIGN KEY REFERENCES Reservations(Id) NOT NULL
);

CREATE TABLE Payments(
	[Id] int IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	[Reservation Id] int FOREIGN KEY REFERENCES Reservations(Id) NOT NULL,
	[Amount] float NOT NULL,
	[Date] DateTime NOT NULL
);
END
GO

