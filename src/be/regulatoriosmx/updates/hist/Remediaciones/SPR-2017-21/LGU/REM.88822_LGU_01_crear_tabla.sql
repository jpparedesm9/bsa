USE cob_credito
GO


SELECT  
tg_tramite, tg_grupo, tg_cliente, tg_monto, tg_grupal, 
'tg_operacion' = isnull(tg_operacion,-1), 
'tg_prestamo' = isnull(tg_prestamo, '-1'), 
'tg_referencia_grupal' = isnull(tg_referencia_grupal,'-1'), 
tg_cuenta, tg_cheque, tg_participa_ciclo, tg_monto_aprobado, tg_ahorro, tg_monto_max, tg_bc_ln, tg_incremento, tg_monto_ult_op, tg_monto_max_calc, tg_nueva_op, tg_monto_min_calc
INTO tg_lgu
FROM cob_credito..cr_tramite_grupal tg

GO

IF OBJECT_ID ('dbo.cr_tramite_grupal') IS NOT NULL
	DROP TABLE dbo.cr_tramite_grupal
GO

CREATE TABLE dbo.cr_tramite_grupal
	(
	tg_tramite           INT NOT NULL,
	tg_grupo             INT NOT NULL,
	tg_cliente           INT NOT NULL,
	tg_monto             MONEY NOT NULL,
	tg_grupal            CHAR (1) NOT NULL,
	tg_operacion         INT          NOT NULL,
	tg_prestamo          VARCHAR (15) NOT NULL,
	tg_referencia_grupal VARCHAR (15) NOT NULL,
	tg_cuenta            VARCHAR (45) NULL,
	tg_cheque            INT NULL,
	tg_participa_ciclo   CHAR (1) NULL,
	tg_monto_aprobado    MONEY NULL,
	tg_ahorro            MONEY NULL,
	tg_monto_max         MONEY NULL,
	tg_bc_ln             CHAR (10) NULL,
	tg_incremento        NUMERIC (8,4) NULL,
	tg_monto_ult_op      MONEY NULL,
	tg_monto_max_calc    MONEY NULL,
	tg_nueva_op          INT NULL,
	tg_monto_min_calc    MONEY NULL
	)
GO

CREATE CLUSTERED INDEX idx1
	ON dbo.cr_tramite_grupal (tg_tramite,tg_cliente)
GO

CREATE NONCLUSTERED INDEX idx2
	ON dbo.cr_tramite_grupal (tg_cliente,tg_grupo)
GO



INSERT INTO cob_credito..cr_tramite_grupal 
SELECT * FROM tg_lgu

GO

