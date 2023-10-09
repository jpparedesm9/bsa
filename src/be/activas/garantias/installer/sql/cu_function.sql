USE cob_custodia
GO

IF OBJECT_ID ('dbo.conteo_poliza') IS NOT NULL
	DROP FUNCTION dbo.conteo_poliza
GO

CREATE FUNCTION dbo.conteo_poliza() RETURNS int
BEGIN
declare @w_cont int
select @w_cont = count(*) 
	from cu_poliza
	
RETURN @w_cont
END

GO
