USE [u_nstaron]
GO

/****** Object:  StoredProcedure [debug].[RecreateTables]    Script Date: 13.06.2022 22:41:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [debug].[RecreateTables]
AS
BEGIN
	SET NOCOUNT ON;
	EXEC debug.DropTables;
	EXEC debug.CreateTables;
END
GO

