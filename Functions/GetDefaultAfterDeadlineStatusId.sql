USE [u_nstaron]
GO

/****** Object:  UserDefinedFunction [dbo].[GetDefaultAfterDeadlineStatusId]    Script Date: 13.06.2022 22:42:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetDefaultAfterDeadlineStatusId]
(
)
RETURNS int
AS
BEGIN
	RETURN 2
END
GO

