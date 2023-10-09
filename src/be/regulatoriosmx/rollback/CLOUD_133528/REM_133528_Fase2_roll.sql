
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
