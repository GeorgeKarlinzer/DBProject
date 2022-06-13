USE [u_nstaron]
GO

/****** Object:  StoredProcedure [debug].[RecreateTypes]    Script Date: 13.06.2022 22:41:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [debug].[RecreateTypes]
AS
BEGIN
	SET NOCOUNT ON;
	EXEC debug.DropTypes;
	EXEC debug.CreateTypes;
END
GO

