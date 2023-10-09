print '-->cco_error_conaut_his'
go
if exists(select 1 from sysobjects where name = 'cco_error_conaut_his' and type = 'U')
                DROP TABLE dbo.cco_error_conaut_his
GO

CREATE TABLE cco_error_conaut_his 
(
    eh_empresa     tinyint       NOT NULL,
    eh_producto    tinyint       NOT NULL,
    eh_fecha_conta datetime      NOT NULL,
    eh_secuencial  int           NOT NULL,
    eh_fecha       datetime      NOT NULL,
    eh_tran_modulo varchar(20)   NOT NULL,
    eh_asiento     smallint      NOT NULL,
    eh_numerror    int           NULL,
    eh_mensaje     [descripcion] NOT NULL,
    eh_perfil      varchar(20)   NULL,
    eh_oficina     smallint      NULL,
    eh_valor       money         NULL,
    eh_comprobante int           NULL
)
Go



