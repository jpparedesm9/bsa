use cobis
go

declare
@w_codigo int 

select @w_codigo=codigo from cobis..cl_tabla
where tabla='ca_param_notif'

delete from cobis..cl_catalogo
where tabla=@w_codigo
and codigo in ('ETLCR_NJAS','ETLCR_NPDF','ETLCR_NXML')

go

use cobis 
go
declare
@w_cod int 
   
select @w_cod=codigo  from cobis..cl_tabla 
   where tabla = 'ca_grupal'   

select @w_cod

if exists(select * from cobis..cl_catalogo where codigo='REVOLVENTE' and tabla =@w_cod )
begin
delete from cobis..cl_catalogo
where  codigo='REVOLVENTE' and tabla =@w_cod
end 
go

use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_info_cre_tmp_lcr') IS NOT NULL
	DROP table dbo.sb_info_cre_tmp_lcr
go

use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_resumen_pagos_tmp_lcr') IS NOT NULL
	DROP table dbo.sb_resumen_pagos_tmp_lcr
go

use cob_conta_super
go

IF OBJECT_ID ('dbo.sb_dato_operacion_abono_temp_lcr') IS NOT NULL
	DROP table dbo.sb_dato_operacion_abono_temp_lcr
go

use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_estcta_cab_tmp_lcr') IS NOT NULL
	DROP table dbo.sb_estcta_cab_tmp_lcr
go

USE cobis
go

delete from cobis..cl_parametro
where pa_nemonico in ('DPELCR','FPELCR')
and pa_producto='REC'
go

