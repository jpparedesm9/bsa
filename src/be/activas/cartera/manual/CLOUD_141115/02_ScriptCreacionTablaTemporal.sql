use cob_cartera
go


IF OBJECT_ID ('dbo.ca_condonacion_141115') IS NOT NULL
    DROP TABLE dbo.ca_condonacion_141115
GO


create table ca_condonacion_141115(
co_banco            cuenta  ,
co_procesado        char(1) ,
co_realizado_pago   char(1) ,
co_fecha_ingreso    datetime)

go

create index idx_ca_condonacion_141115 on ca_condonacion_141115 (co_banco) 





