USE [u_nstaron]
GO

/****** Object:  UserDefinedFunction [dbo].[GetPayDeadline]    Script Date: 13.06.2022 22:43:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetPayDeadline]
(
)
RETURNS int
AS
BEGIN
	RETURN 7
END
GO

