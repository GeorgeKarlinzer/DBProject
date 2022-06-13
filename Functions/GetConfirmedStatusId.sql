USE [u_nstaron]
GO

/****** Object:  UserDefinedFunction [dbo].[GetConfirmedStatusId]    Script Date: 13.06.2022 22:42:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetConfirmedStatusId]
(
)
RETURNS int
AS
BEGIN
	DECLARE @Id int;

	SELECT @Id = Id FROM ReservationStatuses
		WHERE Label = 'Confirmed'

	RETURN @Id;
END
GO

