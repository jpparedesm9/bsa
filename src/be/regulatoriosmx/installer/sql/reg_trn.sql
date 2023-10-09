/************************************************************************/
/*    ARCHIVO:         reg_trn.sql                                      */
/*    NOMBRE LOGICO:   reg_trn.sql                                      */
/*    PRODUCTO:        REGULATORIOS                                     */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                     PROPOSITO                                        */
/*   Script de creacion de transaccion autorizada    */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/************************************************************************/

use cobis
go

DELETE FROM dbo.cl_ttransaccion
WHERE tn_trn_code = 36002 
AND tn_descripcion = 'CONSULTA DE TRANSACCIONES REPORTADAS' 
AND tn_nemonico = 'CTRR' 
AND tn_desc_larga = 'CONSULTA DE TRANSACCIONES REPORTADAS'
GO

DELETE FROM dbo.ad_pro_transaccion
WHERE pt_producto = 36 
AND pt_tipo = 'R' 
AND pt_moneda = 0 
AND pt_transaccion = 36002 
AND pt_estado = 'V' 
AND pt_procedure = 36002
GO

DELETE FROM dbo.ad_procedure
WHERE pd_procedure = 36002 
AND pd_stored_procedure = 'sp_cons_trns' 
AND pd_base_datos = 'cob_conta_super' 
AND pd_estado = 'V' 
AND pd_archivo = 'constrnrep.sp'
GO

DELETE FROM dbo.ad_tr_autorizada
WHERE ta_producto = 36 
AND ta_tipo = 'R' 
AND ta_moneda = 0 
AND ta_transaccion = 36002 
AND ta_rol = 3 
AND ta_autorizante = 1 
AND ta_estado = 'V'
GO

INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (36002, 'CONSULTA DE TRANSACCIONES REPORTADAS', 'CTRR', 'CONSULTA DE TRANSACCIONES REPORTADAS')
GO

INSERT INTO dbo.ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (36, 'R', 0, 36002, 'V', getdate(), 36002, NULL)
GO

INSERT INTO dbo.ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (36002, 'sp_cons_trns', 'cob_conta_super', 'V', getdate(), 'constrnrep.sp')
GO

INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (36, 'R', 0, 36002, 3, getdate(), 1, 'V', getdate())
GO


/*************************************************************************************/
--No Historia				 : H83163
--Título de la Historia		 : Funcionalidad de consulta de Retencion en productos
--Fecha					     : 09/06/2016
--Descripción del Problema	 : Se requiero de una funcionalidad que consulte las 
--                             retenciones (ISR) generadas por todos los productos COBIS
--Descripción de la Solución : Creacion de transacciones 
--                             36003: CONSULTA DE RETENCIONES POR PRODUCTO
--Autor						 : Jorge Salazar Andrade
--Instalador                 : reg_trn.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/RegulatoriosMX/sql
/*************************************************************************************/
use cobis
go

declare @w_moneda tinyint,
        @w_rol    tinyint
    
select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

select @w_rol = ro_rol
  from cobis..ad_rol
 where ro_descripcion like '%MENU POR PROCESOS%'
   
delete from cl_ttransaccion
 where tn_trn_code    = 36003
   and tn_nemonico    = 'CREPRO'

delete from ad_pro_transaccion
 where pt_producto    = 36
   and pt_tipo        = 'R'
   and pt_moneda      = @w_moneda
   and pt_transaccion = 36003
   and pt_procedure   = 36003

delete from ad_procedure
 where pd_procedure        = 36003 
   and pd_stored_procedure = 'sp_tran_prod_isr' 
   and pd_base_datos       = 'cob_conta_super'

delete from ad_tr_autorizada
 where ta_producto    = 36
   and ta_tipo        = 'R' 
   and ta_moneda      = @w_moneda
   and ta_transaccion = 36003 
   and ta_rol         = @w_rol

insert into dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (36003, 'CONSULTA DE RETENCIONES POR PRODUCTO', 'CREPRO', 'CONSULTA DE RETENCIONES POR PRODUCTO')

insert into dbo.ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
values (36, 'R', @w_moneda, 36003, 'V', getdate(), 36003, NULL)

insert into dbo.ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (36003, 'sp_tran_prod_isr', 'cob_conta_super', 'V', getdate(), 'regtrapisr.sp')

insert into dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values (36, 'R', @w_moneda, 36003, @w_rol, getdate(), 1, 'V', getdate())
go

print '-- REGISTRO DE TRANSACCIONES'
go


PRINT '--->> Registro de sp consestcue.sp'
GO

use cobis
GO

DECLARE @w_numero int, @w_producto int
select @w_numero = 36005
select @w_producto = 36
-- reprocesable
delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = @w_producto
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero
delete cobis..ad_procedure where pd_procedure = @w_numero

-- sql\ca_segur.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_cons_estado_cuenta','cob_conta_super','V',getdate(),'consestcue.sp')

insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values (@w_numero, 'OBTENER ESTADO DE CUENTA', convert(varchar,@w_numero), 'OBTENER ESTADO DE CUENTA')

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol int
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
set    @w_fecha = getdate()

select @w_rol = ro_rol   from cobis..ad_rol where ro_descripcion like '%MENU POR PROCESOS%'

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())
go



--------------------------------------------------------------------------------------------
-- REGISTRO SP - SEGURIDADES -- con_conta_super   --sp_estado_cuenta
--------------------------------------------------------------------------------------------
DECLARE @w_numero int, @w_producto int
select @w_numero = 36006 -- también se usa el 36007 con @w_numero+1
select @w_producto = 36
-- reprocesable
delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = @w_producto
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero 
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero+1
delete cobis..ad_procedure where pd_procedure = @w_numero

-- sql\ca_segur.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_estado_cuenta','cob_conta_super','V',getdate(),'sp_es_cuen.sp')


INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (36006, 'INSERTAR ESTADO CUENTA', '36006', 'INSERTA REGISTROS DE ESTADO PARA ESTADO CUENTA')

INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (36007, 'CONSUTA ESTADO CUENTA', '36007', 'CONSULTA TODOS LOS BANCOS A ENVIAR ESTADO CUENTA')

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol int
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
set    @w_fecha = getdate()
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin 

	INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, @w_fecha, 1, 'V', @w_fecha)
	
end
else
begin
	
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
	
	INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, @w_fecha, 1, 'V', @w_fecha)
	
end
go

print '-- REGISTRO DE TRANSACCIONES'
go

use cobis
go

PRINT '--->> Registro de sp sp_lee_inter_factura.sp'
GO

use cobis
GO

DECLARE @w_numero int, @w_producto int
select @w_numero = 36008
select @w_producto = 36
-- reprocesable
delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = @w_producto
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero
delete cobis..ad_procedure where pd_procedure = @w_numero

-- sql\ca_segur.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_lee_inter_factura','cob_conta_super','V',getdate(),'sp_in_fac.sp')

insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values (@w_numero, 'OBTENER DATOS DE INTERFACTURA', convert(varchar,@w_numero), 'OBTENER DATOS DE INTERFACTURA')

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol int
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
set    @w_fecha = getdate()

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())
go

use cobis
GO

DECLARE @w_numero int, @w_producto int
select @w_numero = 36009
select @w_producto = 36
-- reprocesable
delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = @w_producto
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero
delete cobis..ad_procedure where pd_procedure = @w_numero

-- sql\ca_segur.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_equivalencias','cob_conta_super','V',getdate(),'equiv.sp')

insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values (@w_numero, 'OBTENER EQUIVALENCIAS', convert(varchar,@w_numero), 'OBTENER EQUIVALENCIAS')

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol int
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
set    @w_fecha = getdate()

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())
go

