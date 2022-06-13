USE [u_nstaron]
GO

/****** Object:  UserDefinedFunction [dbo].[GetDefaultStatusId]    Script Date: 13.06.2022 22:43:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetDefaultStatusId]()
RETURNS int
AS
BEGIN
	RETURN 1
END
GO

