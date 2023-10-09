/*************************************************************************************/
--No Historia				 : H83163
--Título de la Historia		 : Funcionalidad de consulta de Retencion en productos
--Fecha					     : 09/06/2016
--Descripción del Problema	 : Se requiero de una funcionalidad que consulte las 
--                             retenciones (ISR) generadas por todos los productos COBIS
--Descripción de la Solución : Creacion de catalogo de aplicativos con transacciones ISR 
--Autor						 : Jorge Salazar Andrade
--Instalador                 : reg_catalogo.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/RegulatoriosMX/sql
/*************************************************************************************/
use cobis
go

delete from cl_catalogo where tabla in (select codigo from cl_tabla where tabla = 'sb_aplicativo_isr')
go

delete from cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = 'sb_aplicativo_isr')
go

delete from cl_tabla where tabla = 'sb_aplicativo_isr'
go

declare @w_codigo int

select @w_codigo = max(codigo) + 1 from cl_tabla
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'sb_aplicativo_isr', 'Aplicativos con Transacciones ISR')
insert into cl_catalogo_pro values ('REC', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'CUENTA DE AHORROS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '14', 'DEPOSITOS A PLAZO FIJO', 'V')
go


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


/*************************************************************************************/
--No Historia				 : H83163
--Título de la Historia		 : Funcionalidad de consulta de Retencion en productos
--Fecha					     : 09/06/2016
--Descripción del Problema	 : Se requiero de una funcionalidad que consulte las 
--                             retenciones (ISR) generadas por todos los productos COBIS
--Descripción de la Solución : Creacion de equivalencias de catalogos
--Autor						 : Jorge Salazar Andrade
--Instalador                 : validacion_equivalencias.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/ParamMX/sql
/*************************************************************************************/

use cob_conta_super
go

delete sb_equivalencias where eq_catalogo in ('TRN_PERFIL','CONCON_PRO')
go

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('TRN_PERFIL', 'NDE', '4', 'NOTA DE DEBITO CUENTAS DE AHORRO', 'V')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('CONCON_PRO', 'NDERTEFTE', '4', 'NOTA DE DEBITO IMPUESTO ISR CUENTAS DE AHORRO', 'V')
go


declare @w_codigo int 

select @w_codigo = codigo FROM cobis..cl_tabla
where tabla = 'ec_equivalencias'

delete cobis..cl_catalogo
 where codigo in ('TRN_PERFIL', 'CONCON_PRO')
   and tabla  = @w_codigo

insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo, 'TRN_PERFIL', 'TIPOS DE TRANSACCIONES DEL PERFIL POR PRODUCTO', 'V', NULL, NULL, NULL)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo, 'CONCON_PRO', 'CONCEPTOS CONTABLES POR PRODUCTO', 'V', NULL, NULL, NULL)
go

