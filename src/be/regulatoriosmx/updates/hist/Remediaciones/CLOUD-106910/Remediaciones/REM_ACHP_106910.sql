use cob_cartera
go

IF OBJECT_ID ('dbo.ca_log_dispercion_gl') IS NOT NULL
    DROP TABLE dbo.ca_log_dispercion_gl
GO

 create table ca_log_dispercion_gl(
    ld_gl_id         int,
    ld_fecha_proceso datetime,
    ld_fecha_real    datetime,
    ld_grupo         int,
    ld_cliente       int, 
    ld_tramite_padre int, 
    ld_pag_valor     money,
    ld_operacion     int,
    ld_banco         varchar(32)
 )
go
