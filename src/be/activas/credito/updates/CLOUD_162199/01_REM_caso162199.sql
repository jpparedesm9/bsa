------------------------>>>>>>>>>>>>>>>------------------------>>>>>><<<<<<<<<
------------------------>>>>>>>>>>>>>>>Tabla para controlar las consultas
------------------------>>>>>>>>>>>>>>>------------------------>>>>>><<<<<<<<<
use cob_credito
go

if OBJECT_ID ('dbo.cr_interface_buro_tmp_consulta') is not null
	drop table dbo.cr_interface_buro_tmp_consulta
GO

create table dbo.cr_interface_buro_tmp_consulta (
    tc_cliente int,
    tc_estado char(1),
    tc_fecha datetime
)
go
------------------------>>>>>>>>>>>>>>>------------------------>>>>>><<<<<<<<<