/***********************************************************************************************************/
---No Bug					: 
---Título del Bug			: Pantallas Autorizantes, Ejecutores, Notas débito/crédito y Autorización de ND/NC
---Fecha					: 06/07/2016 
--Descripción del Problema	: Transaccion autorizada en Pantalla de Apertura
--Descripción de la Solución: se crea script de remediación
--Autor						: Juan Tagle
/***********************************************************************************************************/

------------------------------------------------------------------------
use cobis
go


------------------------------------------------------------------------
declare @w_rol int, @w_moneda tinyint, @w_producto tinyint, @w_transaccion int, @w_descripcion varchar(64), @w_nemonico varchar(10), @w_desc_larga varchar(100), @w_procedure int, @w_base varchar(30), @w_nombresp varchar(50), @w_filesp varchar(50)
select @w_rol = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
select @w_producto    = 4,
	   @w_transaccion = 411,
	   @w_descripcion = 'CONSULTA DE FUNC. AUTORIZANTE NC/ND',
	   @w_nemonico    = 'CFAN',
	   @w_desc_larga  = 'CONSULTA DE FUNCIONARIO AUTORIZANTE NC/ND',
	   @w_procedure   = 4066,
	   @w_base        = 'cob_remesas',
	   @w_nombresp    = 'sp_tr_mant_fun_aut',
	   @w_filesp      = 'mantfunaut.sp'
-- CL_TTRANSACCION---ah_tran.sql---------------------------------
DELETE cl_ttransaccion where tn_trn_code = @w_transaccion
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, @w_descripcion, @w_nemonico, @w_desc_larga)
-- AD_PROCEDURE---ah_proc.sql------------------------------------
DELETE from cobis..ad_procedure WHERE pd_procedure = @w_procedure
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (@w_procedure, @w_nombresp, @w_base, 'V',  getdate(), @w_filesp)
-- AD_PRO_TRANSACCION---ah_protran.sql---------------------------
DELETE from ad_pro_transaccion where pt_transaccion = @w_transaccion
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)
-- AD_TR_AUTORIZADA---ah_traut.sql------------------------------
DELETE from ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_rol = @w_rol
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
go


------------------------------------------------------------------------
declare @w_rol int, @w_moneda tinyint, @w_producto tinyint, @w_transaccion int, @w_descripcion varchar(64), @w_nemonico varchar(10), @w_desc_larga varchar(100), @w_procedure int, @w_base varchar(30), @w_nombresp varchar(50), @w_filesp varchar(50)
select @w_rol = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
select @w_producto    = 4,
	   @w_transaccion = 412,
	   @w_descripcion = 'INGRESO DE FUNC. AUTORIZANTE NC/ND',
	   @w_nemonico    = 'IFAN',
	   @w_desc_larga  = 'INGRESO DE FUNCIONARIO AUTORIZANTE NC/ND',
	   @w_procedure   = 4066
-- CL_TTRANSACCION---ah_tran.sql---------------------------------
DELETE cl_ttransaccion where tn_trn_code = @w_transaccion
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, @w_descripcion, @w_nemonico, @w_desc_larga)
-- AD_PRO_TRANSACCION---ah_protran.sql---------------------------
DELETE from ad_pro_transaccion where pt_transaccion = @w_transaccion
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)
-- AD_TR_AUTORIZADA---ah_traut.sql------------------------------
DELETE from ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_rol = @w_rol
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
go


------------------------------------------------------------------------
declare @w_rol int, @w_moneda tinyint, @w_producto tinyint, @w_transaccion int, @w_descripcion varchar(64), @w_nemonico varchar(10), @w_desc_larga varchar(100), @w_procedure int, @w_base varchar(30), @w_nombresp varchar(50), @w_filesp varchar(50)
select @w_rol = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
select @w_producto    = 4,
	   @w_transaccion = 413,
	   @w_descripcion = 'ELIMINACION DE FUNC. AUTORIZANTE NC/ND',
	   @w_nemonico    = 'EFAN',
	   @w_desc_larga  = 'ELIMINACION DE FUNCIONARIO AUTORIZANTE NC/ND',
	   @w_procedure   = 4066
-- CL_TTRANSACCION---ah_tran.sql---------------------------------
DELETE cl_ttransaccion where tn_trn_code = @w_transaccion
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, @w_descripcion, @w_nemonico, @w_desc_larga)
-- AD_PRO_TRANSACCION---ah_protran.sql---------------------------
DELETE from ad_pro_transaccion where pt_transaccion = @w_transaccion
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)
-- AD_TR_AUTORIZADA---ah_traut.sql------------------------------
DELETE from ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_rol = @w_rol
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
go


------------------------------------------------------------------------
declare @w_rol int, @w_moneda tinyint, @w_producto tinyint, @w_transaccion int, @w_descripcion varchar(64), @w_nemonico varchar(10), @w_desc_larga varchar(100), @w_procedure int, @w_base varchar(30), @w_nombresp varchar(50), @w_filesp varchar(50)
select @w_rol = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
select @w_producto    = 4,
	   @w_transaccion = 414,
	   @w_descripcion = 'CONSULTA DE FUNC. EJECUTOR NC/ND',
	   @w_nemonico    = 'CFEN',
	   @w_desc_larga  = 'CONSULTA DE FUNCIONARIO EJECUTOR NC/ND',
	   @w_base        = 'cob_remesas',
	   @w_procedure   = 4066
-- CL_TTRANSACCION---ah_tran.sql---------------------------------
DELETE cl_ttransaccion where tn_trn_code = @w_transaccion
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, @w_descripcion, @w_nemonico, @w_desc_larga)
-- AD_PRO_TRANSACCION---ah_protran.sql---------------------------
DELETE from ad_pro_transaccion where pt_transaccion = @w_transaccion
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)
-- AD_TR_AUTORIZADA---ah_traut.sql------------------------------
DELETE from ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_rol = @w_rol
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
go


------------------------------------------------------------------------
declare @w_rol int, @w_moneda tinyint, @w_producto tinyint, @w_transaccion int, @w_descripcion varchar(64), @w_nemonico varchar(10), @w_desc_larga varchar(100), @w_procedure int, @w_base varchar(30), @w_nombresp varchar(50), @w_filesp varchar(50)
select @w_rol = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
select @w_producto    = 4,
	   @w_transaccion = 415,
	   @w_descripcion = 'INGRESO DE FUNC. EJECUTOR NC/ND',
	   @w_nemonico    = 'IFEN',
	   @w_desc_larga  = 'INGRESO DE FUNCIONARIO EJECUTOR NC/ND',
	   @w_procedure   = 4066
-- CL_TTRANSACCION---ah_tran.sql---------------------------------
DELETE cl_ttransaccion where tn_trn_code = @w_transaccion
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, @w_descripcion, @w_nemonico, @w_desc_larga)
-- AD_PRO_TRANSACCION---ah_protran.sql---------------------------
DELETE from ad_pro_transaccion where pt_transaccion = @w_transaccion
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)
-- AD_TR_AUTORIZADA---ah_traut.sql------------------------------
DELETE from ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_rol = @w_rol
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
go


------------------------------------------------------------------------
declare @w_rol int, @w_moneda tinyint, @w_producto tinyint, @w_transaccion int, @w_descripcion varchar(64), @w_nemonico varchar(10), @w_desc_larga varchar(100), @w_procedure int, @w_base varchar(30), @w_nombresp varchar(50), @w_filesp varchar(50)
select @w_rol = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
select @w_producto    = 4,
	   @w_transaccion = 416,
	   @w_descripcion = 'ELIMINACION DE FUNC. EJECUTOR NC/ND',
	   @w_nemonico    = 'EFEN',
	   @w_desc_larga  = 'ELIMINACION DE FUNCIONARIO EJECUTOR NC/ND',
	   @w_procedure   = 4066
-- CL_TTRANSACCION---ah_tran.sql---------------------------------
DELETE cl_ttransaccion where tn_trn_code = @w_transaccion
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, @w_descripcion, @w_nemonico, @w_desc_larga)
-- AD_PRO_TRANSACCION---ah_protran.sql---------------------------
DELETE from ad_pro_transaccion where pt_transaccion = @w_transaccion
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)
-- AD_TR_AUTORIZADA---ah_traut.sql------------------------------
DELETE from ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_rol = @w_rol
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
go


------------------------------------------------------------------------
declare @w_rol int, @w_moneda tinyint, @w_producto tinyint, @w_transaccion int, @w_descripcion varchar(64), @w_nemonico varchar(10), @w_desc_larga varchar(100), @w_procedure int, @w_base varchar(30), @w_nombresp varchar(50), @w_filesp varchar(50)
select @w_rol = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
select @w_producto    = 4,
	   @w_transaccion = 264,
	   @w_descripcion = 'N/D',
	   @w_nemonico    = 'NDSL',
	   @w_desc_larga  = 'ESTA TRANSACCION PROCESA LAS NOTAS DE DEBITO DE AHORROS SIN LIBRETA',
	   @w_procedure   = 4067,	  	   
	   @w_base        = 'cob_ahorros',
	   @w_nombresp    = 'sp_autndc_aho',
	   @w_filesp      = 'autndc_aho.sp'
-- CL_TTRANSACCION---ah_tran.sql---------------------------------
DELETE cl_ttransaccion where tn_trn_code = @w_transaccion
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, @w_descripcion, @w_nemonico, @w_desc_larga)
-- AD_PROCEDURE---ah_proc.sql------------------------------------
DELETE from cobis..ad_procedure WHERE pd_procedure = @w_procedure
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (@w_procedure, @w_nombresp, @w_base, 'V',  getdate(), @w_filesp)
-- AD_PRO_TRANSACCION---ah_protran.sql---------------------------
DELETE from ad_pro_transaccion where pt_transaccion = @w_transaccion
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)
-- AD_TR_AUTORIZADA---ah_traut.sql------------------------------
DELETE from ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_rol = @w_rol
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
go


------------------------------------------------------------------------
declare @w_rol int, @w_moneda tinyint, @w_producto tinyint, @w_transaccion int, @w_descripcion varchar(64), @w_nemonico varchar(10), @w_desc_larga varchar(150), @w_procedure int, @w_base varchar(30), @w_nombresp varchar(50), @w_filesp varchar(50)
select @w_rol = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
select @w_producto    = 4,
	   @w_transaccion = 253,
	   @w_descripcion = 'N/C',
	   @w_nemonico    = 'NCSL',
	   @w_desc_larga  = 'ESTA TRANSACCION PROCESA LAS NOTAS DE CREDITO DE AHORROS SIN LIBRETA Y SI HAY VALORES EN SUSPENSO LOS COBRA.',
	   @w_procedure   = 4067
-- CL_TTRANSACCION---ah_tran.sql---------------------------------
DELETE cl_ttransaccion where tn_trn_code = @w_transaccion
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, @w_descripcion, @w_nemonico, @w_desc_larga)
-- AD_PRO_TRANSACCION---ah_protran.sql---------------------------
DELETE from ad_pro_transaccion where pt_transaccion = @w_transaccion
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)
-- AD_TR_AUTORIZADA---ah_traut.sql------------------------------
DELETE from ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_rol = @w_rol
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
go


------------------------------------------------------------------------
declare @w_rol int, @w_moneda tinyint, @w_producto tinyint, @w_transaccion int, @w_descripcion varchar(64), @w_nemonico varchar(10), @w_desc_larga varchar(100), @w_procedure int, @w_base varchar(30), @w_nombresp varchar(50), @w_filesp varchar(50)
select @w_rol = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
select @w_producto    = 4,
	   @w_transaccion = 698,
	   @w_descripcion = 'CREACION DE ACCION NOTAS DEBITO',
	   @w_nemonico    = 'CAND',
	   @w_desc_larga  = 'CREACION DE ACCION NOTAS DEBITO',
	   @w_procedure   = 4068,	   
	   @w_base        = 'cob_remesas',
	   @w_nombresp    = 'sp_tr_autndc_ccah',
	   @w_filesp      = 'autndcccah.sp'
-- CL_TTRANSACCION---ah_tran.sql---------------------------------
DELETE cl_ttransaccion where tn_trn_code = @w_transaccion
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, @w_descripcion, @w_nemonico, @w_desc_larga)
-- AD_PROCEDURE---ah_proc.sql------------------------------------
DELETE from cobis..ad_procedure WHERE pd_procedure = @w_procedure
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (@w_procedure, @w_nombresp, @w_base, 'V',  getdate(), @w_filesp)
-- AD_PRO_TRANSACCION---ah_protran.sql---------------------------
DELETE from ad_pro_transaccion where pt_transaccion = @w_transaccion
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)
-- AD_TR_AUTORIZADA---ah_traut.sql------------------------------
DELETE from ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_rol = @w_rol
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
go


--------------------------------------------------------------
-- cc_table.sql
use cob_cuentas
go

print 'TABLA ====> cc_funcionario_autoriz '
go
if exists (select * from cob_cuentas..sysobjects
            where name = 'cc_funcionario_autoriz')
   drop table cc_funcionario_autoriz
go
CREATE TABLE  cc_funcionario_autoriz(
	fa_autorizante		smallint	not null,
	fa_ejecutor			smallint	not null,
	fa_tipo				char(1)		not null
)
go



--------------------------------------------------------------
-- ah_error.sql
use cobis
go

delete cl_errores where numero in (201048,201327,201328,203082,203083,203091,207037,
                                   207038,207044,208047,101010,201329,203005,355039,
                                   201004,201030,201330,201332,203005,205000,351088,
                                   353035,357015)
go

insert into cl_errores (numero, severidad, mensaje) values (201048, 1, 'ERROR EN CODIGO DE TRANSACCION')
insert into cl_errores (numero, severidad, mensaje) values (201327, 0, 'EL FUNCIONARIO AUTORIZANTE QUE SE DESEA ELIMINAR TIENE ASOCIADO FUNCIONARIOS DIGITADORES')
insert into cl_errores (numero, severidad, mensaje) values (201328, 0, 'NO EXISTEN FUNCIONARIO AUTORIZANTE')
insert into cl_errores (numero, severidad, mensaje) values (203082, 1, 'ERROR EN CREACION DE AUTORIZANTE DE NOTAS DEBITO / CREDITO')
insert into cl_errores (numero, severidad, mensaje) values (203083, 1, 'ERROR EN CREACION DE EJECUTOR DE NOTAS DEBITO / CREDITO')
insert into cl_errores (numero, severidad, mensaje) values (203091, 0, 'YA EXISTE FUNCIONARIO AUTORIZANTE')
insert into cl_errores (numero, severidad, mensaje) values (207037, 1, 'ERROR AL ELIMINAR REGISTRO DE FUNCIONARIO AUTORIZANTE')
insert into cl_errores (numero, severidad, mensaje) values (207038, 1, 'ERROR AL ELIMINAR REGISTRO DE FUNCIONARIO EJECUTOR')
insert into cl_errores (numero, severidad, mensaje) values (207044, 0, 'EL USUARIO EJECUTOR YA SE ENCUENTRA INGRESADO CON EL MISMO AUTORIZANTE')
insert into cl_errores (numero, severidad, mensaje) values (208047, 0, 'EL FUNCIONARIO EJECUTOR NO PUDE SER AUTORIZANTE DE EL MISMO')
insert into cl_errores (numero, severidad, mensaje) values (101010, 0, 'Departamento no existe')
insert into cl_errores (numero, severidad, mensaje) values (201329, 0, 'FUNCIONARIO NO ES AUTORIZANTE')
insert into cl_errores (numero, severidad, mensaje) values (203005, 1, 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO')
insert into cl_errores (numero, severidad, mensaje) values (355039, 1, 'ERROR AL ACTUALIZAR EL ESTADO DE LA TRANSACCION POR AUTORIZAR')
insert into cl_errores (numero, severidad, mensaje) values (201004, 1, 'CUENTA NO EXISTE')
insert into cl_errores (numero, severidad, mensaje) values (201030, 1, 'CAUSA NO EXISTE')
insert into cl_errores (numero, severidad, mensaje) values (201330, 0, 'FUNCIONARIO NO ESTA DEFINIDO COMO EJECUTOR DE ND/NC')
insert into cl_errores (numero, severidad, mensaje) values (201332, 1, 'CAUSA NO PERMITIDA EN ND/NC POR TERMINAL ADMINISTRATIVA')
insert into cl_errores (numero, severidad, mensaje) values (203005, 1, 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO')
insert into cl_errores (numero, severidad, mensaje) values (205000, 1, 'ERROR EN ACTUALIZACION DE CAJERO REMOTO')
insert into cl_errores (numero, severidad, mensaje) values (351088, 1, 'TRANSACCION DE NOTA DE DEBITO / CREDITO NO PUEDE SER REVERSADA')
insert into cl_errores (numero, severidad, mensaje) values (353035, 1, 'ERROR AL INSERTAR REGISTRO DE AUTORIZACION DE NOTA CREDITO / NOTA DEBITO')
insert into cl_errores (numero, severidad, mensaje) values (357015, 1, 'ERROR EN ELIMINACION DE REGISTRO DE AUTORIZACION DE NOTA CREDITO / NOTA DEBITO')
go
------------------------------------------------------------------

