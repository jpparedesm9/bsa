
use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_rep_oper_mc_collect') IS NOT NULL
	DROP table dbo.sb_rep_oper_mc_collect
go

use cob_conta_super
go
if object_id ('dbo.sb_rep_ini_cobis_collect') is not null
	drop table dbo.sb_rep_ini_cobis_collect
go

delete from cobis..cl_parametro
where pa_producto='REC'
and pa_nemonico='PHCMCC'

use cob_conta_super
go
if object_id ('dbo.sb_rep_cob_mc_cobis') is not null
	drop table dbo.sb_rep_cob_mc_cobis
go

delete from cobis..ba_batch 
where ba_batch = 287933

Update cobis..ba_batch
set ba_path_destino='C:\Cobis\VBatch1\Regulatorios\listados\McCollect\',
ba_path_fuente='C:\Cobis\VBatch1\Regulatorios\Objetos\'
where ba_batch in (287931,287932,287933)

use cob_cartera
go
if object_id ('dbo.ca_pago_sol_grp_tmp') is not null
	drop table dbo.ca_pago_sol_grp_tmp
go

use cob_cartera
go
IF OBJECT_ID ('dbo.ca_pago_sol_grp_tmp') IS NOT NULL
	DROP table dbo.ca_pago_sol_grp_tmp
go

use cob_cartera
go
IF OBJECT_ID ('dbo.ca_pag_grp_sol_det') IS NOT NULL
	DROP table dbo.ca_pag_grp_sol_det
go