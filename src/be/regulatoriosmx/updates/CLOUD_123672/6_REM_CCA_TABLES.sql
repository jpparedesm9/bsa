use cob_externos 
go

if not exists ( select  1 from    syscolumns where id = OBJECT_ID('ex_dato_cuota_pry')
                and name = 'dc_com_lcr' ) 
	alter table ex_dato_cuota_pry add dc_com_lcr money null
go




if not exists ( select  1 from    syscolumns where id = OBJECT_ID('ex_dato_cuota_pry')
                and name = 'dc_ivacom_lcr' ) 
	alter table ex_dato_cuota_pry add dc_ivacom_lcr money null
go


use cob_conta_super 
go

if not exists ( select  1 from    syscolumns where id = OBJECT_ID('sb_dato_cuota_pry')
                and name = 'dc_com_lcr' ) 
	alter table sb_dato_cuota_pry add dc_com_lcr money null
go




if not exists ( select  1 from    syscolumns where id = OBJECT_ID('sb_dato_cuota_pry')
                and name = 'dc_ivacom_lcr' ) 
	alter table sb_dato_cuota_pry add dc_ivacom_lcr money null
go




use cobis 
go 


delete from cobis..cl_parametro where pa_producto = 'CCA' and  pa_nemonico = 'EJEHIS'

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIA DE EJECUCION SB_DATO_CUOTA_PRY', 'EJEHIS', 'I', NULL, NULL, NULL, 8, NULL, NULL, NULL, 'CCA')
GO