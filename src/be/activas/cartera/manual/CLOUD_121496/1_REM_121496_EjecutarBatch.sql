USE cob_cartera
GO

EXEC sp_lcr_generar_candidatos
@i_param1          = '07/08/2019',
@i_forzar          = 'S'

GO

SELECT * FROM ca_lcr_candidatos WHERE cc_fecha_ing = '07/08/2019'

GO
