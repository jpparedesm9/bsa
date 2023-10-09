/************************************************************************/
/*    Archivo:        ad_segurvk.sql                                    */
/*    Base de datos:    cobis                                           */
/*    Producto:        Admin                                            */
/************************************************************************/
/*                IMPORTANTE                                            */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'COBISCORP'                                                       */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de COBISCORP o su representante.            */
/************************************************************************/
/*                PROPOSITO                                             */
/*    Este script realiza el proceso de autorizacion de transacciones   */
/*    del ADMIN                                                         */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA        AUTOR        RAZON                                   */
/*  12/ABR/2016 BBO         Migracion SYBASE-SQLServer FAL              */
/************************************************************************/

use cobis
go


/************************************************************************/
/*                              ad_procedure                            */
-- Procedure 5914, 5915 en ad_segur
/************************************************************************/

print '----->  ad_procedure'
go

if exists (select * from ad_procedure
        where pd_procedure between 5900 and 5913)
    delete ad_procedure where pd_procedure between 5900 and 5913
go



insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values(5900,'sp_vkesta','cobis','V',getdate(),'vkesta.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values(5901,'sp_vkser','cobis','V',getdate(),'vkser.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values(5902,'sp_vkregistro','cobis','V',getdate(),'vkregistro.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values(5903,'sp_vkuser','cobis','V',getdate(),'vkuser.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values(5904,'sp_vkprod','cobis','V',getdate(),'vkprod.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values(5905,'sp_vkcomd','cobis','V',getdate(),'vkcomd.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values(5906,'sp_vkalias','cobis','V',getdate(),'vkalias.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values(5907,'sp_vklogp','cobis','V',getdate(),'vklogp.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values(5908,'sp_vklogpm','cobis','V',getdate(),'vklogpm.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values(5909,'sp_vklogm','cobis','V',getdate(),'vklogm.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values(5910,'sp_vklogmm','cobis','V',getdate(),'vklogmm.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values(5911,'sp_vklopa','cobis','V',getdate(),'vklopa.sp')
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values(5912,'sp_vklopam','cobis','V',getdate(),'vklopam.sp')
/**********Log de transacciones**************/
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values(5913,'sp_vklogtra','cobis','V',getdate(),'vklogtra.sp')
go




/************************************************************************/
/*                              ad_pro_transaccion                      */
/************************************************************************/
print '----->  ad_pro_transaccion'
go

if exists (select * from ad_pro_transaccion
         where pt_producto = 1
        and pt_transaccion between 15900 and 15912)  --15999
    delete ad_pro_transaccion where pt_producto = 1
    and pt_transaccion between 15900 and 15912
go

declare @w_moneda int
--select @w_moneda = 1
select @w_moneda = pa_tinyint
from cl_parametro
where pa_nemonico = 'MLO'
 and pa_producto = 'ADM'
 
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15900,'V',getdate(),5900)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15901,'V',getdate(),5901)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15902,'V',getdate(),5902)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15903,'V',getdate(),5903)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15904,'V',getdate(),5904)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15905,'V',getdate(),5905)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15906,'V',getdate(),5906)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15907,'V',getdate(),5907)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15908,'V',getdate(),5908)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15909,'V',getdate(),5909)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15910,'V',getdate(),5910)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15911,'V',getdate(),5911)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15912,'V',getdate(),5912)
go


/************************************************************************/
/*                              ad_tr_autorizada                        */
/************************************************************************/
print '----->  ad_tr_autorizada'
go


if exists (select *
         from ad_tr_autorizada
        where ta_producto = 1
          and ta_rol = 1
          and ta_transaccion between 15900 and 15912)   --15999
    delete ad_tr_autorizada where ta_producto = 1 and ta_rol = 1 
                      and ta_transaccion between 15900 and 15912
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
values (1,'R',@w_moneda,15900,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15901,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15902,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15903,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15904,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15905,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15906,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15907,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15908,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15909,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15910,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15911,1,getdate(),1,'V',getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod) 
values (1,'R',@w_moneda,15912,1,getdate(),1,'V',getdate())

go

/****************************************************************************/
/*                              cl_ttransaccion                             */
-- Transacciones 15914..15917 estan en ad_segur.sql
/****************************************************************************/
print '----->  cl_ttransaccion'

if exists (select * from cl_ttransaccion
        where tn_trn_code between 15900 and 15912)   --15999
    delete cl_ttransaccion
     where tn_trn_code between 15900 and 15912
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
    tn_desc_larga)
values(15900,'ESTADISTICAS VISOR KERNEL','ESTVK','PERMITE VER LAS ESTADISTICAS DESDE EL VISOR KERNEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
    tn_desc_larga)
values(15901,'SERVIDORES VISOR KERNEL','SERVK','GENERA LA LISTA DE SERVIDORES PARA EL VISOR KERNEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
    tn_desc_larga)
values(15902,'REGISTRO VISOR KERNEL','REGVK','PERMITE EL REGISTRO PARA EL USO DEL VISOR KERNEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
    tn_desc_larga)
values(15903,'USUARIOS VISOR KERNEL','USEVK','vISUALIZA LOS USUARIOS REGISTRADOS EN EL VISOR KERNEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
    tn_desc_larga)
values(15904,'PRODUCTOS VISOR KERNEL','PROVK','vISUALIZA LOS PRODUCTOS Y SU ESTADO EN EL VISOR KERNEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
    tn_desc_larga)
values(15905,'COMANDOS VISOR KERNEL','COMVK','PERMITE LA EJECUCIÓN DE COMANDOS EN EL VISOR KERNEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
    tn_desc_larga)
values(15906,'ALIAS VISOR KERNEL','ALIVK','PERMITE VISUALIZAR Y MODIFICAR LOS ALIAS EN EL VISOR KERNEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
    tn_desc_larga)
values(15907,'LOGGER PROCEDIMIENTOS VISOR KERNEL','LGPVK','VISUALIZAR LOS PROCEDIMIENTOS LOGGER EN EL VISOR KERNEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
    tn_desc_larga)
values(15908,'LOGGER MANTENIMIENTO PROC. VISOR KERNEL','LPMVK','DAR MANTENIMIENTOS A LOS PROCEDIMIENTOS LOGGER EN EL VISOR KERNEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
    tn_desc_larga)
values(15909,'LOGGER MENSAJES PROC. VISOR KERNEL','LMPVK','VISUALIZAR LOS MENSAJES DE LOS PROCEDIMIENTOS LOGGER EN EL VISOR KERNEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
    tn_desc_larga)
values(15910,'LOGGER MENSAJES MANT. PROC. VISOR KERNEL','LMPMVK','DAR MANTENIMIENTO A LOS MENSAJES DE LOS PROCEDIMIENTOS LOGGER EN EL VISOR KERNEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
    tn_desc_larga)
values(15911,'LOGGER PARAMETROS PROC. VISOR KERNEL','LPPVK','VISUALIZAR LOS PARAMETROS DE LOS PROCEDIMIENTOS LOGGER EN EL VISOR KERNEL')
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
    tn_desc_larga)
values(15912,'LOGGER PARAMETROS MANT. PROC. VISOR KERNEL','LPPMVK','DAR MANTENIMIENTO A LOS PARAMETROS DE LOS PROCEDIMIENTOS LOGGER EN EL VISOR KERNEL')


go

-- Se comenta porque no aplica para CTS
--exec ADMIN...rp_addlogin
--        @i_login='vkuser',
--        @i_password='pasvkuser'
--go


