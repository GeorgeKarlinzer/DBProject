USE [u_nstaron]
GO

/****** Object:  StoredProcedure [debug].[CreateTypes]    Script Date: 13.06.2022 22:41:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [debug].[CreateTypes]
AS
BEGIN
	SET NOCOUNT ON;
	--CREATE TYPE PersonList AS TABLE(
	--	Id int IDENTITY(1, 1) PRIMARY KEY,
	--	[First Name] nvarchar(50) NOT NULL,
	--	[Last Name] nvarchar(50) NOT NULL,
	--	Region nvarchar(50) NOT NULL,
	--	[City] nvarchar(50) NOT NULL,
	--	[Address] nvarchar(50) NOT NULL,
	--	[Birth Date] date NOT NULL
	--);

	CREATE TYPE DayList AS TABLE(
		Id int PRIMARY KEY,
		[Date] Date NOT NULL,
		[Start Time] Time NOT NULL,
		[Finish Time] Time NOT NULL
	);
END
GO

