USE [u_nstaron]
GO

/****** Object:  UserDefinedFunction [dbo].[IsReservationChangable]    Script Date: 13.06.2022 22:43:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[IsReservationChangable]
(
	@ReservationId int
)
RETURNS bit
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM Reservations WHERE Id = @ReservationId)
		RETURN 0

	DECLARE @ReservationStatusId int;

	SELECT @ReservationStatusId = [Status Id]
	FROM Reservations 
	WHERE Id = @ReservationId

	IF @ReservationStatusId <> dbo.GetDefaultStatusId() AND @ReservationStatusId <> dbo.GetDefaultAfterDeadlineStatusId()
		RETURN 0

	RETURN 1
END
GO

