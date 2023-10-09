/**********************************************************************/
/*   Archivo:         si_transac.sql                                  */
/*   Data base:       cobis                                           */
/**********************************************************************/
/*                     IMPORTANTE                                     */
/*   Esta aplicacion es parte de los  paquetes bancarios              */
/*   propiedad de COBISCORP.                                          */
/*   Su uso no autorizado queda  expresamente  prohibido              */
/*   asi como cualquier alteracion o agregado hecho  por              */
/*   alguno de sus usuarios sin el debido consentimiento              */
/*   por escrito de COBISCORP.                                        */
/*   Este programa esta protegido por la ley de derechos              */
/*   de autor y por las convenciones  internacionales de              */
/*   propiedad intelectual.  Su uso  no  autorizado dara              */
/*   derecho a COBISCORP para obtener ordenes  de secuestro           */
/*   o  retencion  y  para  perseguir  penalmente a  los              */
/*   autores de cualquier infraccion.                                 */
/**********************************************************************/
/*                      PROPOSITO                                     */
/*      EGISTRO SP - SEGURIDADES -- MOVILEINTEGRATION                 */
/**********************************************************************/
/*                      MODIFICACIONES                                */
/*   FECHA              AUTOR                  RAZON                  */
/*   02-08-2017         Paúl Ortiz             Emision Inicial        */
/**********************************************************************/


--------------------------------------------------------------------------------------------
-- REGISTRO SP - SEGURIDADES -- Mobile   --
--------------------------------------------------------------------------------------------
PRINT '--->> Registro de sp sp_sincroniza_mobil.sp'
GO

use cobis
GO

DECLARE 
@w_numero      int, 
@w_producto    int,
@w_rol         int, 
@w_moneda      int

select @w_numero = 21609
select @w_producto = 21
-- reprocesable
delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = @w_producto
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero
delete cobis..ad_procedure where pd_procedure = @w_numero

-- sql\ca_segur.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_sincroniza_mobil','cob_sincroniza','V',getdate(),'sp_si_mobi.sp')


INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (1713, 'INSERTAR DISPOSITIVO OFICIAL', '1713', 'INSERTAR DISPOSITIVO OFICIAL')

INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (1714, 'ACTUALIZAR DISPOSITIVO OFICIAL', '1714', 'ACTUALIZAR DISPOSITIVO OFICIAL')

INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (1715, 'ELIMINAR DISPOSITIVO OFICIAL', '1715', 'ELIMINAR DISPOSITIVO OFICIAL')

INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (1716, 'LISTAR Y OBTIENE DISPOSITIVO OFICIAL', '1716', 'LISTAR Y OBTIENE DISPOSITIVO OFICIAL')


insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol int
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
set    @w_fecha = getdate()

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())


SELECT @w_producto = pd_producto
FROM cobis..cl_producto 
WHERE pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

select @w_moneda = 0
select @w_numero = 17

--CONSULTAR DISPOSITIVOS MÓVILES POR FILTRO
delete from ad_procedure where pd_procedure = 1717
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (1717,'sp_sincroniza_mobil','cob_credito','V',getdate(),'sp_sincroniza_mobil.sp')

delete cl_ttransaccion where tn_trn_code = 1717
insert into dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1717, 'CONSULTAR DISPOSITIVOS MÓVILES POR FILTRO', '1717', 'CONSULTAR DISPOSITIVOS MÓVILES POR FILTRO')

delete ad_pro_transaccion where pt_transaccion = 1717
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,1717,'V',getdate(),1717)

delete ad_tr_autorizada where ta_transaccion = 1717 and ta_rol in (select rol_id from @w_rol_table)
insert into ad_tr_autorizada 
select (@w_producto, 'R',@w_moneda, 1, @w_rol, getdate(), 1, 'V', getdate())
