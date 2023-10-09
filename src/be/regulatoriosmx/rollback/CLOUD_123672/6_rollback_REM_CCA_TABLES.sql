use cob_externos 
go

if exists ( select  1 from    syscolumns where id = OBJECT_ID('ex_dato_cuota_pry')
                and name = 'dc_com_lcr' ) 
	alter table ex_dato_cuota_pry drop column dc_com_lcr money
go

if exists ( select  1 from    syscolumns where id = OBJECT_ID('ex_dato_cuota_pry')
                and name = 'dc_ivacom_lcr' ) 
	alter table ex_dato_cuota_pry drop column dc_ivacom_lcr
go

use cob_conta_super 
go

if exists ( select  1 from    syscolumns where id = OBJECT_ID('sb_dato_cuota_pry')
                and name = 'dc_com_lcr' ) 
	alter table sb_dato_cuota_pry drop column dc_com_lcr 
go


if exists ( select  1 from    syscolumns where id = OBJECT_ID('sb_dato_cuota_pry')
                and name = 'dc_ivacom_lcr' ) 
	alter table sb_dato_cuota_pry drop column dc_ivacom_lcr
go

use cobis 
go 

delete from cobis..cl_parametro where pa_producto = 'CCA' and  pa_nemonico = 'EJEHIS'
