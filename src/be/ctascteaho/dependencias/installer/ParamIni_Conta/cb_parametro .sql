Use cob_conta
go

IF OBJECT_ID ('dbo.cb_parametro') IS NOT NULL
	DROP TABLE dbo.cb_parametro
GO

CREATE TABLE dbo.cb_parametro
	(
	pa_empresa     TINYINT NOT NULL,
	pa_parametro   VARCHAR (10) COLLATE Latin1_General_BIN NOT NULL,
	pa_descripcion descripcion NOT NULL,
	pa_stored      VARCHAR (20) COLLATE Latin1_General_BIN NOT NULL,
	pa_transaccion INT NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_parametro_Key
	ON dbo.cb_parametro (pa_empresa,pa_parametro)
GO


SELECT * FROM cb_parametro WHERE pa_transaccion = 4


INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, '2120_AHO', 'DEPOSITOS AHORROS', 'sp_ah01_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'AHO_EST', 'CAMBIO DE ESTADO-CAPITAL E INTERESES', 'sp_ah04_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'AH_RBM_TRN', 'COMPENSACION RBM', 'sp_ah02_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'AH_TRASDES', 'TRASLADO ENTRE OFICINAS-CAPITAL E INTERESES DESTINO', 'sp_ah04_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'AH_TRASOR', 'TRASLADO ENTRE OFICINAS-CAPITAL E INTERESES ORIGEN', 'sp_ah04_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'CAJA_AHO', 'DEPOSITOS EN CHEQUES OTRAS PLAZAS AHORROS RECIBIDOS POR CAJA', 'sp_ah02_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'COND_CXC', 'CXC CONDONACION VALORES EN SUSPENSO CTAS DE AHORROS', 'sp_ah02_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'COND_SUS', 'CONDONACION VALORES EN SUSPENSO CTAS DE AHORROS', 'sp_ah02_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'CON_CR_AHO', 'NOTAS CREDITOS AHORROS', 'sp_ah02_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'CON_CR_CUP', 'MOVIMIENTO CUPO CORRESPONSAL CREDITO', 'sp_ah02_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'CON_CR_SUS', 'CONTRA SUSPENSO AHORROS', 'sp_ah02_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'CON_DB_AHO', 'NOTAS DEBITOS AHORROS', 'sp_ah02_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'CON_DB_CUP', 'MOVIMIENTO CUPO CORRESPONSAL DEBITO', 'sp_ah02_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'CON_DB_SUS', 'CARGOS EN SUSPENSO AHORROS', 'sp_ah02_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'CON_GMFAHO', 'GMF A CARGO DEL BANCO EN NCR', 'sp_ah02_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'GASTO_AHO', 'GASTOS DEPOSITOS AHORROS', 'sp_ah05_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'GASTO_GMF', 'GASTO GMF A CARGO DEL BANCO EN NCR', 'sp_ah02_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'INTXP_AHO', 'PROVISION INTERESES DEPOSITOS AHORROS', 'sp_ah03_pf', 4)
GO

INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'REM_AHO', 'DEPOSITOS EN CHEQUES OTRAS PLAZAS AHORROS RECIBIDOS POR CAJA', 'sp_ah02_pf', 4)
GO
