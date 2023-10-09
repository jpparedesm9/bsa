use cobis
go

delete from ad_procedure where pd_procedure = 6910
	
insert into ad_procedure 
(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values 
(6910, 'sp_solicitud_reportes_reg', 'cob_conta', 'V', getdate(), 'sol_rep_reg.sp')
go


delete from cl_ttransaccion where tn_trn_code in (6640, 6641, 6642, 6643)

insert into cl_ttransaccion 
(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
values 
(6640, 'CONSULTA LISTADO REPORTES REGULATORIOS', '6640', 'CONSULTA LISTADO REPORTES REGULATORIOS')

insert into cl_ttransaccion 
(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
values 
(6641, 'VERIFICACION LISTADO REPORTES REGULATORIOS', '6641', 'VERIFICACION LISTADO REPORTES REGULATORIOS')

insert into cl_ttransaccion 
(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
values 
(6642, 'INGRESO LISTADO REPORTES REGULATORIOS', '6642', 'INGRESO LISTADO REPORTES REGULATORIOS')

insert into cl_ttransaccion 
(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
values 
(6643, 'QUERY LISTADO REPORTES REGULATORIOS', '6643', 'QUERY LISTADO REPORTES REGULATORIOS')
go


declare @w_moneda  tinyint

select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'


delete from ad_pro_transaccion where pt_transaccion in (6640, 6641, 6642, 6643)

insert into ad_pro_transaccion 
(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values 
(6, 'R', @w_moneda, 6640, 'V', getdate(), 6910, null)

insert into ad_pro_transaccion 
(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values 
(6, 'R', @w_moneda, 6641, 'V', getdate(), 6910, null)

insert into ad_pro_transaccion 
(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values 
(6, 'R', @w_moneda, 6642, 'V', getdate(), 6910, null)

insert into ad_pro_transaccion 
(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values 
(6, 'R', @w_moneda, 6643, 'V', getdate(), 6910, null)
go


declare @w_rol     smallint,
		@w_moneda  tinyint
		
select @w_rol = ro_rol 
from  ad_rol
where ro_descripcion = 'MENU POR PROCESOS' 
and   ro_filial = 1

select @w_moneda = pa_tinyint
from  cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'


delete from ad_tr_autorizada where ta_rol = @w_rol and ta_transaccion in (6640, 6641, 6642, 6643)

insert into ad_tr_autorizada 
(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values 
(6, 'R', @w_moneda, 6640, @w_rol, getdate(), 3, 'V', getdate()) 

insert into ad_tr_autorizada 
(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values 
(6, 'R', @w_moneda, 6641, @w_rol, getdate(), 3, 'V', getdate()) 

insert into ad_tr_autorizada 
(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values 
(6, 'R', @w_moneda, 6642, @w_rol, getdate(), 3, 'V', getdate()) 

insert into ad_tr_autorizada 
(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values 
(6, 'R', @w_moneda, 6643, @w_rol, getdate(), 3, 'V', getdate()) 
go


delete from cl_errores 
where numero in (609312, 609313, 609314, 609323, 609324, 609325, 609326, 609327, 609328, 609329, 609330)

insert into cl_errores 
(numero, severidad, mensaje) 
values 
(609312, 0, 'ERROR: EN LA CONSULTA DE SOLICITUD DE REPORTES')

insert into cl_errores 
(numero, severidad, mensaje) 
values 
(609313, 0, 'ERROR: EN LA CONSULTA DE LISTADO DE REPORTES')

insert into cl_errores 
(numero, severidad, mensaje) 
values 
(609314, 0, 'ERROR: YA SE PROCESO LA SOLICITUD PARA LA FECHA')

insert into cl_errores 
(numero, severidad, mensaje) 
values 
(609323, 0, 'ERROR: PETICION EXCEDE EL LIMITE DE TIEMPO MAXIMO DE GENERACION')

insert into cl_errores 
(numero, severidad, mensaje) 
values 
(609324, 0, 'ERROR: EN INGRESO DE TRANSACCION DE SERVICIO')

insert into cl_errores 
(numero, severidad, mensaje) 
values 
(609325, 0, 'ERROR: EN EL BORRADO DE SOLICITUD')

insert into cl_errores 
(numero, severidad, mensaje) 
values 
(609326, 0, 'ERROR: EN EL INGRESO DE SOLICITUD')

insert into cl_errores 
(numero, severidad, mensaje) 
values 
(609327, 0, 'ERROR: NO EXISTE PARAMETRO CFN')

insert into cl_errores 
(numero, severidad, mensaje) 
values 
(609328, 0, 'ERROR: AL CALCULAR FECHA DE FIN DE MES')

insert into cl_errores 
(numero, severidad, mensaje) 
values 
(609329, 0, 'ERROR: NO EXISTE PROCESO DE SOLICITUD DE REPORTE')

insert into cl_errores 
(numero, severidad, mensaje) 
values 
(609330, 0, 'ERROR: NO EXISTE FECHA PROCESO')

insert into cl_errores 
(numero, severidad, mensaje) 
values 
(609331, 0, 'ERROR: EN LA CONSULTA DE DIAS FERIADOS')
go

