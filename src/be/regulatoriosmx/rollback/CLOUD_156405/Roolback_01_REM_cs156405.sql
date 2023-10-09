use cob_externos
go

if object_id ('dbo.ex_operacion') is not null
	drop table dbo.ex_operacion
go

use cob_conta_super
go


if object_id ('dbo.sb_operacion') is not null
	drop table dbo.sb_operacion
go


use cobis
go
--Eliminacion anterior
delete from ba_batch where ba_batch= 152026

--Nuevo
delete ba_batch where ba_batch= 36437
delete ba_parametro where pa_batch = 36437

--Nuevo
delete ba_batch where ba_batch= 36438
delete ba_parametro where pa_batch = 36438
go

use cobis
go

delete cl_parametro where pa_nemonico = 'NUDIVI' and pa_producto='ADM'

delete cl_parametro where pa_nemonico = 'DIMAPR' and pa_producto='ADM'
