use cobis
go


/******************************************************/
--Fecha Creación del Script: 2016/06/24     
--Historial  Dependencias:            
-- 24/06/2016  Juan Tagle      SE agrega Trn Autorizada para cliente 
-- 24/06/2016  Walther Toledo  Se agregan Producto-Transaccion 709,740
--Codigo de error de PFI           
--Modulo: PFI                           
/******************************************************/


use cobis
go

if exists (select 1 from cobis..cl_errores where numero = 141195)
    delete cobis..cl_errores where numero = 141195
go

insert into cobis..cl_errores values (141195, 0, 'No existen registros que cumplan la(s) condición(es) dada(s)')
go



------------------------------------------------------------------------

declare 
     @w_rol      int,
     @w_moneda   tinyint,
     @w_producto tinyint

select @w_producto = 4

select @w_rol = ro_rol
  from ad_rol
--where ro_descripcion like 'ADMINISTRADOR'
 where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

------------------CL_TTRANSACCION----------------------------
delete from cl_ttransaccion where tn_trn_code = 1020
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (1020, 'CONSULTA DATOS CLIENTE', 'CDC', 'CONSULTA DATOS CLIENTE')

-------------------AD_PRO_TRANSACCION----------------------------
DELETE FROM ad_pro_transaccion where pt_transaccion=1020 and pt_producto=2 and pt_procedure=1194
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (2, 'R', @w_moneda, 1020, 'V', getdate(), 1194, NULL)

----------------------AD_PROCEDURE------------------------------
DELETE FROM ad_procedure WHERE pd_procedure = 1194
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (1194, 'sp_datos_cliente', 'cobis', 'V',  getdate(), 'cldatcli.sp')

------------------AD_TR_AUTORIZADA----------------------------
delete from ad_tr_autorizada where ta_producto = @w_producto and ta_rol = @w_rol and ta_transaccion in (1020)
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 1020, @w_rol, getdate(), 1, 'V', getdate())

GO

------------------------------------------------------------------------

use cobis
GO

print '===> ah_protran.sql'
 
set nocount on
declare @w_producto tinyint

select @w_producto = 10 -- REMESAS Y CAMARA
-- -----------------------------------
delete cobis..ad_pro_transaccion
 where pt_producto = @w_producto
   AND pt_transaccion in (709,740)

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', 0, 709, 'V', getdate(), 708, NULL)
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', 0, 740, 'V', getdate(), 717, NULL)
go


/************************************************/
---No Bug: 75622
---Título del Bug: Back Office - Aumentar Días de Retención para Canje
---Fecha: 24/06/2016
--Descripción del Problema: Autorización de transacciones
--Descripción de la Solución: Se registra sp y transaccion 
--Autor: Roxana Sanchez / Tania Baidal
/**************************************************/

use cobis
go


DECLARE @w_cod_procedure int, 
        @w_rol           int, 
        @w_moneda        tinyint,
        @w_producto      tinyint,
        @w_transaccion   int

--**************** Transaccion 710 ********************

select @w_rol = ro_rol
from ad_rol
-- where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'


select @w_producto = 10

select @w_transaccion =710

--ad_procedure
if exists (select 1 from ad_procedure where pd_stored_procedure = 'sp_addhold_locales' and pd_base_datos = 'cob_remesas')
begin
    delete from ad_procedure where pd_stored_procedure = 'sp_addhold_locales' and pd_base_datos = 'cob_remesas'
end

SELECT @w_cod_procedure = max(pd_procedure)+1 FROM ad_procedure

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (@w_cod_procedure, 'sp_addhold_locales', 'cob_remesas', 'V', getdate(), 're_addhold.sp')

--ad_pro_transaccion
if exists (select 1 from ad_pro_transaccion where pt_transaccion = @w_transaccion)
begin
    delete from ad_pro_transaccion where pt_transaccion = @w_transaccion
end

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_cod_procedure, NULL)


--cl_ttransaccion
if exists (select 1 from cl_ttransaccion where tn_trn_code = @w_transaccion)
begin
    delete from cl_ttransaccion where tn_trn_code = @w_transaccion
end

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, 'ACTUALIZACION CONCEPTO CONTABLE', 'APCC', 'ACTUALIZACION CONCEPTO CONTABLE')

--ad_tr_autorizada
if exists (select 1 from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol)
begin
    delete from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol
end

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())

go

-------------------------
/************************************************/
---No Bug: 73522 --Ojo no es bug es Historia
---Título del Bug: 
---Fecha: 24/06/2016
--Descripción del Problema: Autorización de transacciones para pantallas ftra2797, FTRAN080 y FTRAN090
--Descripción de la Solución: Se registra sp y transacciones 
--Autor: Tania Baidal
/**************************************************/

use cobis
go


--******** Pantalla ftra2797 ********

DECLARE @w_cod_procedure int, 
        @w_rol           int, 
        @w_moneda        tinyint,
        @w_producto      tinyint,
		@w_transaccion   int

select @w_rol = ro_rol
from ad_rol
-- where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'

select @w_producto = 1

--********** Transaccion 15029 ***********
select @w_transaccion = 15029

--ad_tr_autorizada
if exists (select 1 from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol)
begin
    delete from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol
end

INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())


--********** Transaccion 1572 ************
select @w_transaccion = 1572

--ad_tr_autorizada
if exists (select 1 from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol)
begin
    delete from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol
end

INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())



--********** Transaccion 2796 ************

select @w_producto = 3 

select @w_transaccion =2796

--ad_procedure
if exists (select 1 from ad_procedure where pd_stored_procedure = 'sp_control_efectivo' and pd_base_datos = 'cob_cuentas')
begin
    delete from ad_procedure where pd_stored_procedure = 'sp_control_efectivo' and pd_base_datos = 'cob_cuentas'
end

SELECT @w_cod_procedure = max(pd_procedure)+1 FROM ad_procedure

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (@w_cod_procedure, 'sp_control_efectivo', 'cob_cuentas', 'V', getdate(), 'control_efe.sp')

--cl_ttransaccion

if exists (select 1 from cl_ttransaccion where tn_trn_code = @w_transaccion)
begin
    delete from cl_ttransaccion where tn_trn_code = @w_transaccion
end 

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, 'CONTROL DE EFECTIVO', 'CONEF', 'CONTROL DE EFECTIVO')

--ad_pro_transaccion
if exists (select 1 from ad_pro_transaccion where pt_transaccion = @w_transaccion)
begin
    delete from ad_pro_transaccion where pt_transaccion = @w_transaccion
end

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_cod_procedure, NULL)

--ad_tr_autorizada
if exists (select 1 from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol)
begin
    delete from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol
end

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())

--2733

select @w_transaccion =2733

--ad_procedure

if exists (select 1 from ad_procedure where pd_stored_procedure = 'sp_query_excep_sipla' and pd_base_datos = 'cob_cuentas')
begin
    delete from ad_procedure where pd_stored_procedure = 'sp_query_excep_sipla' and pd_base_datos = 'cob_cuentas'
end 

SELECT @w_cod_procedure = max(pd_procedure)+1 FROM ad_procedure

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (@w_cod_procedure, 'sp_query_excep_sipla', 'cob_cuentas', 'V', getdate(), 'query_ex_si.sp')

--cl_ttransaccion
if exists (select 1 from cl_ttransaccion where tn_trn_code = @w_transaccion)
begin
    delete from cl_ttransaccion where tn_trn_code = @w_transaccion
end

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, 'EXCEP SIPLA', 'EXESIP', 'EXCEP SIPLA')

--ad_pro_transaccion

if exists (select 1 from ad_pro_transaccion where pt_transaccion = @w_transaccion)
begin
    delete from ad_pro_transaccion where pt_transaccion = @w_transaccion
end

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_cod_procedure, NULL)

--ad_tr_autorizada

if exists (select 1 from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol)
begin
 delete from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol
end

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())


--********FTRAN080********
--Transaccion 80 sp_tr_cons_tot_ofi_adm
select @w_producto = 3

--Transaccion 80
select @w_transaccion = 80

--ad_procedure

if exists (select 1 from ad_procedure where pd_stored_procedure = 'sp_query_excep_sipla' and pd_base_datos = 'cob_cuentas')
begin
    delete from ad_procedure where pd_stored_procedure = 'sp_query_excep_sipla' and pd_base_datos = 'cob_cuentas'
end

SELECT @w_cod_procedure = max(pd_procedure)+1 FROM ad_procedure

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (@w_cod_procedure, 'sp_tr_cons_tot_ofi_adm', 'cob_cuentas', 'V', getdate(), 'cons_tot_of.sp')


--cl_ttransaccion
if exists (select 1 from cl_ttransaccion where tn_trn_code = @w_transaccion)
begin
    delete from cl_ttransaccion where tn_trn_code = @w_transaccion
end

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, 'CONSULTA DE TOTALES POR OFICINA', 'CTOF', 'CONSULTA DE TOTALES POR OFICINA')

--ad_pro_transaccion

if exists (select 1 from ad_pro_transaccion where pt_transaccion = @w_transaccion)
begin
    delete from ad_pro_transaccion where pt_transaccion = @w_transaccion
end

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_cod_procedure, NULL)

--ad_tr_autorizada
if exists (select 1 from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol)
begin
    delete from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol
end

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())


--******** Pantalla FTRAN090 ********

--Transaccion 90
select @w_producto = 3
select @w_transaccion = 90

--ad_procedure
if exists (select 1 from ad_procedure where pd_stored_procedure = 'sp_tr_tot_caj_adm' and pd_base_datos = 'cob_cuentas')
begin
    delete from ad_procedure where pd_stored_procedure = 'sp_tr_tot_caj_adm' and pd_base_datos = 'cob_cuentas'
end

SELECT @w_cod_procedure = max(pd_procedure)+1 FROM ad_procedure

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (@w_cod_procedure, 'sp_tr_tot_caj_adm', 'cob_cuentas', 'V', getdate(), 'tr_tot_caj.sp')

--cl_ttransaccion
if exists (select 1 from cl_ttransaccion where tn_trn_code = @w_transaccion)
begin
    delete from cl_ttransaccion where tn_trn_code = @w_transaccion
end

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, 'CONSULTA DE TOTALES POR CAJERO ADM', 'CTCA', 'CONSULTA LOS TOTALES DE CAJERO (ADMINISTRATIVA)')

--ad_pro_transaccion

if exists (select 1 from ad_pro_transaccion where pt_transaccion = @w_transaccion)
begin
    delete from ad_pro_transaccion where pt_transaccion = @w_transaccion
end

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_cod_procedure, NULL)

--ad_tr_autorizada
if exists (select 1 from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol)
begin
    delete from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol
end

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
GO


