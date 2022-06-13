USE [u_nstaron]
GO

/****** Object:  UserDefinedFunction [dbo].[GetAmountPaid]    Script Date: 13.06.2022 22:42:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetAmountPaid]
(
	@ReservationId float
)
RETURNS float
AS
BEGIN
	DECLARE @Amount float;

	SELECT @Amount = SUM([Amount]) FROM Payments
	GROUP BY [Reservation Id]
	HAVING [Reservation Id] = @ReservationId

	RETURN ISNULL(@Amount, 0)
END
GO

