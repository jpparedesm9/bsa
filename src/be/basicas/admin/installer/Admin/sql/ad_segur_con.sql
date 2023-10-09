/************************************************************************/
/*	Archivo:		ad_segur.sql				*/
/*	Base de datos:		cobis					*/
/*	Producto:		Controlador				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	'MACOSA', representantes exclusivos para el Ecuador de la 	*/
/*	'NCR CORPORATION'.						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este script realiza el proceso de autorizacion de transacciones	*/
/*	del CONTROLADOR							*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*  12/ABR/2016 BBO         Migracion SYBASE-SQLServer FAL              */
/************************************************************************/

use cobis
go


/************************************************************************/
/*                              ad_procedure                            */
/************************************************************************/

print '----->  ad_procedure'
go
delete ad_procedure
where pd_procedure = 5107
   or pd_procedure between 5109 and 5114
go   

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (5107,'sp_mapa','cobis','V',getdate(),'mapa.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (5109,'sp_nodo_nivel','cobis','V',getdate(),'nodo_niv.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (5110,'sp_nodo_nivel_2','cobis','V',getdate(),'nodo_ni2.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (5111,'sp_nivel_mapa','cobis','V',getdate(),'niv_map.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (5112,'sp_cat_icono','cobis','V',getdate(),'cat_ico.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (5113,'sp_icono','cobis','V',getdate(),'icono.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (5114,'sp_nivel','cobis','V',getdate(),'nivel.sp')
go


/************************************************************************/
/*                              ad_pro_transaccion                      */
/************************************************************************/
print '----->  ad_pro_transaccion'
go
delete ad_pro_transaccion
where pt_procedure = 5107
   or pt_procedure between 5109 and 5114
go   

declare @w_moneda int
--select @w_moneda = 1
select @w_moneda = pa_tinyint
from cl_parametro
where pa_nemonico = 'MLO'
 and pa_producto = 'ADM'

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15107,'V',getdate(),5113)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15109,'V',getdate(),5113)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15110,'V',getdate(),5113)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15111,'V',getdate(),5113)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15157,'V',getdate(),5113)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15158,'V',getdate(),5113)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15159,'V',getdate(),5113)

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15112,'V',getdate(),5114)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15113,'V',getdate(),5114)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15114,'V',getdate(),5114)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15115,'V',getdate(),5114)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15116,'V',getdate(),5114)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15117,'V',getdate(),5114)

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15118,'V',getdate(),5107)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15119,'V',getdate(),5107)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15120,'V',getdate(),5107)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15121,'V',getdate(),5107)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15122,'V',getdate(),5107)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15123,'V',getdate(),5107)

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15125,'V',getdate(),5109)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15126,'V',getdate(),5109)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15127,'V',getdate(),5109)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15128,'V',getdate(),5109)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15129,'V',getdate(),5109)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15130,'V',getdate(),5109)

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15131,'V',getdate(),5110)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15132,'V',getdate(),5110)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15133,'V',getdate(),5110)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15134,'V',getdate(),5110)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15135,'V',getdate(),5110)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15136,'V',getdate(),5110)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15137,'V',getdate(),5110)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15138,'V',getdate(),5110)

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15139,'V',getdate(),5111)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15140,'V',getdate(),5111)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15141,'V',getdate(),5111)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15142,'V',getdate(),5111)

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15143,'V',getdate(),5112)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15144,'V',getdate(),5112)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15145,'V',getdate(),5112)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15146,'V',getdate(),5112)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15147,'V',getdate(),5112)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15148,'V',getdate(),5112)
go


/************************************************************************/
/*                              ad_tr_autorizada                        */
/************************************************************************/
print '----->  ad_tr_autorizada'
go
delete ad_tr_autorizada
where ta_producto = 1
  and ta_rol = 1
  and (ta_transaccion = 15107
   or ta_transaccion between 15109 and 15123)
go   

declare @w_moneda int
--select @w_moneda = 1
select @w_moneda = pa_tinyint
from cl_parametro
where pa_nemonico = 'MLO'
 and pa_producto = 'ADM'
 
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15107,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15109,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15110,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15111,1,getdate(),1,'V',getdate())

insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15112,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15113,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15114,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15115,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15116,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15117,1,getdate(),1,'V',getdate())

insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15118,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15119,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15120,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15121,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15122,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15123,1,getdate(),1,'V',getdate())
go

delete ad_tr_autorizada
where ta_producto = 1
  and ta_rol = 1
  and ta_transaccion between 15125 and 15138
go   

declare @w_moneda int
--select @w_moneda = 1
select @w_moneda = pa_tinyint
from cl_parametro
where pa_nemonico = 'MLO'
 and pa_producto = 'ADM'
 
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15125,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15126,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15127,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15128,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15129,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15130,1,getdate(),1,'V',getdate())

insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15131,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15132,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15133,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15134,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15135,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15136,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15137,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15138,1,getdate(),1,'V',getdate())
go

delete ad_tr_autorizada
where ta_producto = 1
  and ta_rol = 1
  and (ta_transaccion between 15139 and 15148
    or ta_transaccion between 15157 and 15159)
go   

declare @w_moneda int
--select @w_moneda = 1
select @w_moneda = pa_tinyint
from cl_parametro
where pa_nemonico = 'MLO'
 and pa_producto = 'ADM'

insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15139,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15140,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15141,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15142,1,getdate(),1,'V',getdate())

insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15143,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15144,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15145,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15146,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15147,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15148,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15157,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15158,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15159,1,getdate(),1,'V',getdate())
go

/****************************************************************************/
/*                              cl_ttransaccion                             */
/****************************************************************************/
print '-----> cl_ttransaccion'
delete cl_ttransaccion
where tn_trn_code = 15107
   or tn_trn_code between 15109 and 15123
   or tn_trn_code between 15125 and 15148
   or tn_trn_code between 15157 and 15159
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15109,'SEARCH DE ICONO','SICO','SEARCH DE ICONO')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15110,'QUERY DE ICONO','QICO','QUERY DE ICONO')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15111,'AYUDA DE ICONO','HICO','AYUDA DE ICONO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15112,'INSERCION DE NIVEL','INIV','INSERCION DE NIVEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15107,'ACTUALIZACION DE NIVEL ICONO','ICNI','ACTUALIZACION DE NIVEL ICONO')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15113,'ACTUALIZACION DE NIVEL','UNIV','ACTUALIZACION DE NIVEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15114,'ELIMINACION DE NIVEL','DNIV','ELIMINACION DE NIVEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15115,'SEARCH DE NIVEL','SNIV','SEARCH DE NIVEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15116,'QUERY DE NIVEL','QNIV','QUERY DE NIVEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15117,'AYUDA DE NIVEL','HNIV','AYUDA DE NIVEL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15118,'INSERCION DE MAPA','IMAP','INSERCION DE MAPA')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15119,'ACTUALIZACION DE MAPA','UMAP','ACTUALIZACION DE MAPA')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15120,'ELIMINACION DE MAPA','DMAP','ELIMINACION DE MAPA')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15121,'SEARCH DE MAPA','SMAP','SEARCH DE MAPA')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15122,'QUERY DE MAPA','QMAP','QUERY DE MAPA')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15123,'AYUDA DE MAPA','HMAP','AYUDA DE MAPA')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15125,'INSERCION DE NODO NIVEL','INNI','INSERCION DE NODO NIVEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15126,'ACTUALIZACION DE NODO NIVEL','UNNI','ACTUALIZACION DE NODO NIVEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15127,'ELIMINACION DE NODO NIVEL','DNNI','ELIMINACION DE NODO NIVEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15128,'SEARCH DE NODO NIVEL','SNNI','SEARCH DE NODO NIVEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15129,'QUERY DE NODO NIVEL','QNNI','QUERY DE NODO NIVEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15130,'AYUDA DE NODO NIVEL','HNNI','AYUDA DE NODO NIVEL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15131,'BUSQUEDA MAPA 1ER NIVEL','BMPN','BUSQUEDA MAPA 1ER NIVEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15132,'BUSQUEDA PATH MAPA','BPMA','BUSQUEDA PATH MAPA')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15133,'BUSQUEDA NODOS MAPA NIVEL','BNMN','BUSQUEDA NODOS MAPA NIVEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15134,'BUSQUEDA ICONOS MAPA NIVEL','BIMN','BUSQUEDA ICONOS MAPA NIVEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15135,'BUSQUEDA MAPA HIJO','BMHI','BUSQUEDA MAPA HIJO')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15136,'BUSQUEDA NOMBRES NIVELES','BNNI','BUSQUEDA NOMBRES NIVELES')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15137,'GRABACION COORDENADAS NODOS','GCNO','GRABACION COORDENADAS NODOS')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15138,'GRABACION COORDENADAS ICONOS','GCIC','GRABACION COORDENADAS ICONOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15139,'INSERCION DE NIVEL MAPA','INMC','INSERCION DE NIVEL MAPA')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15140,'SEARCH DE NIVEL MAPA','SNMC','SEARCH DE NIVEL MAPA')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15141,'QUERY DE NIVEL MAPA','QNMC','QUERY DE NIVEL MAPA')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15142,'AYUDA DE NIVEL MAPA','HNMC','AYUDA DE NIVEL MAPA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15143,'INSERCION DE CATALOGO ICONO','ICAI','INSERCION DE CATALOGO ICONO')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15144,'ACTUALIZACION DE CATALOGO ICONO','UCAI','ACTUALIZACION DE CATALOGO ICONO')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15145,'ELIMINACION DE CATALOGO ICONO','DCAI','ELIMINACION DE CATALOGO ICONO')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15146,'SEARCH DE CATALOGO ICONO','SCAI','SEARCH DE CATALOGO ICONO')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15147,'QUERY DE CATALOGO ICONO','QCAI','QUERY DE CATALOGO ICONO')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15148,'AYUDA DE CATALOGO ICONO','HCAI','AYUDA DE CATALOGO ICONO')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15157,'INSERCION DE ICONO','IICO','INSERCION DE ICONO')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15158,'ACTUALIZACION DE ICONO','UICO','ACTUALIZACION DE ICONO')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
	tn_desc_larga)
values(15159,'ELIMINACION DE ICONO','DICO','ELIMINACION DE ICONO')
go
