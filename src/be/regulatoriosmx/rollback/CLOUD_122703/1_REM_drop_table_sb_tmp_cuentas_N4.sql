use cob_conta_super
go

if exists(select 1 from sysobjects
          where name = 'sb_tmp_cuentas_N4')
	drop table sb_tmp_cuentas_N4
go

use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_cuentas_N4_tmp') IS NOT NULL
	DROP table dbo.sb_cuentas_N4_tmp
go

use cobis
go
delete from  cobis..ba_batch where ba_batch = 36432
go

use cobis
go
delete from cl_parametro where pa_nemonico = 'APERN4' and pa_producto='REC'
go