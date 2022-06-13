USE [u_nstaron]
GO

/****** Object:  StoredProcedure [debug].[DropTypes]    Script Date: 13.06.2022 22:41:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [debug].[DropTypes]
AS
BEGIN
	SET NOCOUNT ON;
	DROP TYPE IF EXISTS DayList;
	DROP TYPE IF EXISTS PersonList;
END
GO

