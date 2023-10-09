Use cob_conta
go


IF OBJECT_ID ('dbo.cb_campos_banco') IS NOT NULL
	DROP TABLE dbo.cb_campos_banco
GO

CREATE TABLE dbo.cb_campos_banco
	(
	cb_codigo        CHAR (3) COLLATE Latin1_General_BIN NOT NULL,
	cb_nombre        CHAR (40) COLLATE Latin1_General_BIN NOT NULL,
	cb_tipo_registro TINYINT NULL
	)
GO


INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Reg', 'TIPO REGISTRO', 1)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Tmo', 'TIPO MONEDA', 1)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Cta', 'NUMERO DE CUENTA', 1)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Fin', 'FECHA INICIAL', 1)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Ffi', 'FECHA FINAL', 1)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Sin', 'SALDO INICIAL', 1)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Reg', 'TIPO REGISTRO', 2)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Val', 'VALOR', 2)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Cta', 'NUMERO DE CUENTA', 2)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Dia', 'DIA TRAN', 2)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Mes', 'MES TRAN', 2)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Ano', 'ANIO TRAN', 2)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Nat', 'NATURALEZA', 2)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Doc', 'DOCUMENTO', 2)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Tra', 'TRANSACCION', 2)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Reg', 'TIPO REGISTRO', 3)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Sfi', 'SALDO FINAL', 3)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Cde', 'CANTIDAD DEBITOS', 3)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Vde', 'VALOR DEBITOS', 3)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Ccr', 'CANTIDAD CREDITOS', 3)
GO

INSERT INTO dbo.cb_campos_banco (cb_codigo, cb_nombre, cb_tipo_registro)
VALUES ('Vcr', 'VALOR CREDITOS', 3)
GO
