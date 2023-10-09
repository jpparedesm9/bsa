USE cob_cartera
GO


IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'mta_112580_total')
   DROP TABLE mta_112580_total
GO
  
CREATE TABLE mta_112580_total(
to_secuencial       INT IDENTITY,
to_sec_corresponsal INT,
to_grupo            INT,
to_operacion_padre  INT,
to_operacion        INT,
to_monto            MONEY,
to_monto_total      MONEY,
to_cuota            MONEY,
to_banco            VARCHAR(32),
to_oficina          INT,
to_secuencial_ing   INT,
to_secuencial_pag   INT,
to_fecha_pag        DATETIME,
to_ab_estado        VARCHAR(10),
to_procesado        VARCHAR(10)
)
GO

