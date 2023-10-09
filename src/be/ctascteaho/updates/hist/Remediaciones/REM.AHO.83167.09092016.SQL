use cob_ahorros
go

/* ah_det_estado_cuenta */
print '=====> ah_det_estado_cuenta'
go
if exists (select * from sysobjects where name = 'ah_det_estado_cuenta') 
 drop table ah_det_estado_cuenta
go 

CREATE TABLE dbo.ah_det_estado_cuenta
        (
        de_fecha          VARCHAR (12) COLLATE Latin1_General_BIN NULL,
        de_cta_banco      cuenta NULL,
        de_oficina        SMALLINT NOT NULL,
        de_nombre         VARCHAR (15) COLLATE Latin1_General_BIN NULL,
        de_correcion      CHAR (1) COLLATE Latin1_General_BIN NULL,
        de_transaccion    VARCHAR (326) COLLATE Latin1_General_BIN NULL,
        de_signo          VARCHAR (1) COLLATE Latin1_General_BIN NULL,
        de_valor          MONEY NULL,
        de_saldo_contable MONEY NULL,
        de_impuesto       MONEY NULL,
        de_interes        MONEY NOT NULL,
        de_secuencial     INT NOT NULL,
        de_cod_alterno    INT NULL,
        de_tipotran       INT NOT NULL,
        de_serial         VARCHAR (30) COLLATE Latin1_General_BIN NULL,
        de_destino        VARCHAR (30) COLLATE Latin1_General_BIN NULL,
        de_causa          CHAR (3) COLLATE Latin1_General_BIN NOT NULL,
        de_estado         CHAR (1) COLLATE Latin1_General_BIN NULL,
        de_ssnbranch      INT NULL,
        de_hora           SMALLDATETIME NULL,
        de_valcomision    MONEY NULL
        )
GO


CREATE UNIQUE CLUSTERED INDEX ah_det_estado_cuenta_Key
    ON ah_det_estado_cuenta (de_fecha,de_cta_banco,de_transaccion, de_secuencial,de_tipotran,de_serial,de_causa)
GO