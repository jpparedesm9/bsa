use cob_remesas_his
go


print 'Creando tabla re_camara_hist'
IF EXISTS (select 1 from sysobjects where name = 're_camara_hist')
   DROP TABLE re_camara_hist
go

CREATE TABLE re_camara_hist (
    ca_fecha             DATETIME NOT NULL,
    ca_secuencial        INT NOT NULL,
    ca_tipo_cheque       CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ca_cuenta            VARCHAR (24) COLLATE Latin1_General_BIN NOT NULL,
    ca_num_cheque        INT NOT NULL,
    ca_valor             MONEY NOT NULL,
    ca_moneda            TINYINT NOT NULL,
    ca_estado            CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ca_oficina           SMALLINT NOT NULL,
    ca_banco             TINYINT NULL,
    ca_mensaje           VARCHAR (64) COLLATE Latin1_General_BIN NULL,
    ca_cta_dep           VARCHAR (24) COLLATE Latin1_General_BIN NULL,
    ca_producto          TINYINT NULL,
    ca_tipo_error        VARCHAR (1) COLLATE Latin1_General_BIN NULL,
    ca_causa_dev         VARCHAR (64) COLLATE Latin1_General_BIN NULL,
    ca_tipo_equip        VARCHAR (1) COLLATE Latin1_General_BIN NULL,
    ca_tipo_tran         INT NULL,
    ca_secuencial_unisys INT NULL,
    ca_sec_det           INT NULL,
    ca_sec_cab           INT NULL,
    ca_comision          MONEY NULL,
    ca_portes            MONEY NULL,
    ca_iva               MONEY NULL,
    ca_portes_dev        MONEY NULL,
    ca_iva_dev           MONEY NULL,
    ca_procesado         VARCHAR (1) COLLATE Latin1_General_BIN NULL,
    ca_bcoced            INT NULL,
    ca_tipo_compensa     VARCHAR (1) COLLATE Latin1_General_BIN NULL,
    ca_digito_46         TINYINT NULL,
    ca_oficina_cta       SMALLINT NULL
    )
go

