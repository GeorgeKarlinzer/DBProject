USE [u_nstaron]
GO

/****** Object:  UserDefinedFunction [dbo].[GetDoneStatusId]    Script Date: 13.06.2022 22:43:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetDoneStatusId]
(
)
RETURNS int
AS
BEGIN
	DECLARE @Id int;

	SELECT @Id = Id FROM ReservationStatuses
		WHERE Label = 'Done'

	RETURN @Id

END
GO

