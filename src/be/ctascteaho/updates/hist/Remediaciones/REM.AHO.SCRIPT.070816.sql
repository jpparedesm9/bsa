use cobis
go

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--•   trn 734 -- > Cob_remesas  - re_protran.sql
declare 
     @w_rol      int,
     @w_moneda   tinyint,
     @w_producto tinyint
select @w_producto = 10
select @w_rol = ro_rol  from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cl_parametro where pa_nemonico = 'CMNAC'   and pa_producto = 'ADM'
-----------------------------------------------------ah_tran.sql
delete from cl_ttransaccion where tn_trn_code=734
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (734, 'MANTENIMIENTO PRODUCTO AHORRO CONTRACTUAL', 'MAAH', 'MANTENIMIENTO PRODUCTO AHORRO CONTRACTUAL')
-------re_protran.sql
delete from ad_pro_transaccion WHERE pt_transaccion = 734 and pt_producto=@w_producto and pt_moneda=@w_moneda
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto,'R', @w_moneda, 734, 'V', getdate(), 716, NULL)
-------re_traut.sql
delete ad_tr_autorizada where ta_producto = @w_producto and ta_rol = @w_rol and ta_moneda = @w_moneda and ta_transaccion = 734
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values (@w_producto, 'R', @w_moneda, 734, @w_rol, getdate(), 1, 'V', getdate())
-------re_proc.sql
delete from ad_procedure where pd_procedure=716
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (716, 'sp_mto_aho_contractual', 'cob_remesas', 'V', getdate(), 'remaahco.sp')
go
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--•   default de oficina  -- > Agregado al script ah_catlgo.sql
--        insert into cl_default values(9,1,'1','CASA MATRIZ','CLOUDSRV')
use cobis
go
declare @w_codigo integer
-- ---------------------------
select @w_codigo = codigo from cobis..cl_tabla WHERE tabla='cl_oficina'

delete from cobis..cl_default where tabla = @w_codigo and oficina = 1
insert into cl_default (tabla, oficina, codigo, valor, srv)
values(@w_codigo,1,'1','CASA MATRIZ','CLOUDSRV')
go
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--•   trn 747
declare 
     @w_rol      int,
     @w_moneda   tinyint,
     @w_producto tinyint
select @w_producto = 10
select @w_rol = ro_rol  from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cl_parametro where pa_nemonico = 'CMNAC'   and pa_producto = 'ADM'
---------------------------------------------------------ah_tran.sql
delete cl_ttransaccion where tn_trn_code=747
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (747, 'BUSQUEDA DE RELACION CUENTA A CANAL', 'BRCC', 'BUSQUEDA DE RELACION CUENTA A CANAL')
-------re_protran.sql
delete from ad_pro_transaccion WHERE pt_transaccion = 747 and pt_producto=@w_producto and pt_moneda=@w_moneda
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto,'R', @w_moneda, 747, 'V', getdate(), 720, NULL)
-------re_traut.sql 
delete ad_tr_autorizada where ta_producto = @w_producto and ta_rol = @w_rol and ta_moneda = @w_moneda and ta_transaccion = 747
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 747, @w_rol,  getdate(), 1, 'V',  getdate())
-------re_proc.sql
delete from ad_procedure where pd_procedure=720
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (720, 'sp_relacion_cta_canal', 'cob_remesas', 'V', getdate(), 'rerelctacan.sp')
go
-----------------------------------------------------------------------------------------
--•   Usted no ha sido autorizado para ejecutar cob_remesas-sp_consulta_prod: 475
declare 
     @w_rol      int,
     @w_moneda   tinyint,
     @w_producto tinyint,
     @w_trx      smallint
select @w_producto = 10
select @w_rol = ro_rol  from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cl_parametro where pa_nemonico = 'CMNAC'   and pa_producto = 'ADM'
select @w_trx = 475
---------------------------------------------------------ah_tran.sql
delete cl_ttransaccion where tn_trn_code=@w_trx
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_trx, 'CONSULTA DE PRODUCTOS COBIS', 'COPC', 'CONSULTA DE PRODUCTOS COBIS')
-------re_protran.sql
delete from ad_pro_transaccion WHERE pt_transaccion = @w_trx and pt_producto=@w_producto and pt_moneda=@w_moneda
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto,'R', @w_moneda, @w_trx, 'V', getdate(), 460, NULL)
-------re_proc.sql
delete ad_tr_autorizada where ta_producto = @w_producto and ta_rol = @w_rol and ta_moneda = @w_moneda and ta_transaccion = @w_trx
insert into cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, @w_rol, getdate(), 1, 'V', getdate())
-------re_traut.sql
delete from ad_procedure where pd_procedure=460
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (460, 'sp_consulta_prod', 'cob_remesas', 'V', getdate(), 'reprocob.sp')
go
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--•   Usted no ha sido autorizado para ejecutar cob_remesas-sp_consulta_prod: 741
-----------------------------------------------------------------------------------------
declare 
     @w_rol      int,
     @w_moneda   tinyint,
     @w_producto tinyint,
     @w_trx      smallint
select @w_producto = 10
select @w_rol = ro_rol  from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cl_parametro where pa_nemonico = 'CMNAC'   and pa_producto = 'ADM'
select @w_trx = 741
---------------------------------------------------------ah_tran.sql
delete cl_ttransaccion where tn_trn_code=@w_trx 
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_trx , 'BUSQUEDA DE CAUSALES', 'BUCAU', 'BUSQUEDA DE CAUSALES')
-------re_protran.sql
delete from ad_pro_transaccion WHERE pt_transaccion = @w_trx  and pt_producto=@w_producto and pt_moneda=@w_moneda
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, 'V', getdate(), 718, NULL)
-------re_traut.sql 
delete ad_tr_autorizada where ta_producto = @w_producto and ta_rol = @w_rol and ta_moneda = @w_moneda and ta_transaccion = @w_trx 
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, @w_rol, getdate(), 1, 'V', getdate())
-------re_proc.sql
delete from ad_procedure where pd_procedure=718
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (718, 'sp_caubusq', 'cob_remesas', 'V', getdate(), 'recaubusq.sp')
go
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--•   Usted no ha sido autorizado para ejecutar cob_remesas-sp_tr_crea_acciond: 700
-----------------------------------------------------------------------------------------
declare 
     @w_rol      int,
     @w_moneda   tinyint,
     @w_producto tinyint,
     @w_trx      smallint
select @w_producto = 10
select @w_rol = ro_rol  from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cl_parametro where pa_nemonico = 'CMNAC'   and pa_producto = 'ADM'
select @w_trx = 700
---------------------------------------------------------ah_tran.sql
delete cl_ttransaccion where tn_trn_code=@w_trx 
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_trx, 'CONSULTA DE ACCION NOTAS DEBITO', 'CAND', 'CONSULTA DE ACCION DE NOTAS DEBITO')
-------re_protran.sql
delete from ad_pro_transaccion WHERE pt_transaccion = @w_trx  and pt_producto=@w_producto and pt_moneda=@w_moneda
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto,'R', @w_moneda, @w_trx, 'V', getdate(), 635, NULL)
-------re_proc.sql
delete ad_tr_autorizada where ta_producto = @w_producto and ta_rol = @w_rol and ta_moneda = @w_moneda and ta_transaccion = @w_trx 
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, @w_rol, getdate(), 1, 'V', getdate())
-------re_traut.sql 
delete from ad_procedure where pd_procedure=635
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (635, 'sp_tr_crea_acciond', 'cob_remesas', 'V',  getdate(), 'ccpaccin.sp')
go
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--•   Usted no ha sido autorizado para ejecutar cob_remesas-sp_consulta_prod: 1610
-----------------------------------------------------------------------------------------
declare 
     @w_rol      int,
     @w_moneda   tinyint,
     @w_producto tinyint,
     @w_trx      smallint
select @w_producto = 2
select @w_rol = ro_rol  from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cl_parametro where pa_nemonico = 'CMNAC'   and pa_producto = 'ADM'
select @w_trx = 1610
---------------------------------------------------------mis_tran.sql
delete cl_ttransaccion where tn_trn_code=@w_trx 
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_trx, 'TRANSACCION CONSULTA HOMINI VALIDA', 'TRCHV', 'TRANSACCION CONSULTA HOMINI VALIDA')
-------mis_protran.sql
delete from ad_pro_transaccion WHERE pt_transaccion = @w_trx  and pt_producto=@w_producto and pt_moneda=@w_moneda
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, 'V', getdate(), 7067105, NULL)
-------mis_traut.sql
delete ad_tr_autorizada where ta_producto = @w_producto and ta_rol = @w_rol and ta_moneda = @w_moneda and ta_transaccion = @w_trx 
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, @w_rol, getdate(), 1, 'V', getdate())
-------mis_proc.sql
delete from ad_procedure where pd_procedure=7067105
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (7067105, 'sp_tr_consulta_homini', 'cobis', 'V', getdate(), 'cltrconhom.sp')
go

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--•   Usted no ha sido autorizado para ejecutar cob_remesas-sp_consulta_prod: 2576
-----------------------------------------------------------------------------------------
declare 
     @w_rol      int,
     @w_moneda   tinyint,
     @w_producto tinyint,
     @w_trx      smallint
select @w_producto = 10
select @w_rol = ro_rol  from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cl_parametro where pa_nemonico = 'CMNAC'   and pa_producto = 'ADM'
select @w_trx = 2576
---------------------------------------------------------ah_tran.sql
delete cl_ttransaccion where tn_trn_code=@w_trx
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_trx, 'CONSULTA CATALOGO TRN MONET Y SERV', 'CTMS', 'CONSULTA CATALOGO DE TRANSACCIONES MONETARIAS Y DE SERVICIOS')
-------re_protran.sql
delete from ad_pro_transaccion WHERE pt_transaccion = @w_trx  and pt_producto=@w_producto and pt_moneda=@w_moneda
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, 'V', getdate(), 2524, NULL)
-------re_traut.sql
delete ad_tr_autorizada where ta_producto = @w_producto and ta_rol = @w_rol and ta_moneda = @w_moneda and ta_transaccion = @w_trx 
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, @w_rol, getdate(), 1, 'V', getdate())
-------re_proc.sql
delete from ad_procedure where pd_procedure=2524
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (2524, 'sp_qry_tranms', 'cob_remesas', 'V', getdate(), 'ccqrytms.sp')
go

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--•   Cancelación de cuentas: [201196] ERROR EN PARAMETRO DE CONCEPTO DE RETENCION
-----------------------------------------------------------------------------------------
-- cm_datini.sql  <-- Remesas
use cob_remesas
go
delete from re_concepto_imp where ci_tran = 308 and ci_causal='0' and ci_impuesto='R' and ci_contabiliza='tm_valor'
INSERT INTO re_concepto_imp (ci_tran, ci_causal, ci_impuesto, ci_concepto, ci_producto, ci_base1, ci_base2, ci_contabiliza, ci_fecha)
VALUES (308, '0', 'R', '0210', 4, 'tm_interes', NULL, 'tm_valor', '10/17/2010')
go

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--•   Usted no ha sido autorizado para ejecutar cob_remesas-sp_consulta_prod: 2700
-----------------------------------------------------------------------------------------
use cobis
go
declare 
     @w_rol      int,
     @w_moneda   tinyint,
     @w_producto tinyint,
     @w_trx      smallint
select @w_producto = 3
select @w_rol = ro_rol  from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cl_parametro where pa_nemonico = 'CMNAC'   and pa_producto = 'ADM'
select @w_trx = 2700
---------------------------------------------------------
delete cl_ttransaccion where tn_trn_code=@w_trx
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_trx, 'CONSULTA NACIONAL DE CAJA', 'CNAC', 'CONSULTA NACIONAL DE CAJA')
-------
delete from ad_pro_transaccion WHERE pt_transaccion = @w_trx  and pt_producto=@w_producto and pt_moneda=@w_moneda
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, 'V', getdate(), 2579, NULL)
-------
delete ad_tr_autorizada where ta_producto = @w_producto and ta_rol = @w_rol and ta_moneda = @w_moneda and ta_transaccion = @w_trx 
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, @w_rol, getdate(), 1, 'V', getdate())
-------
delete from ad_procedure where pd_procedure=2579
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2579, 'sp_tr_cons_tot_nal_adm', 'cob_cuentas', 'V', getdate(), 'tr_tot_nac.sp')

go

-----------------------------------------------------------------------------------------------------------------------
--pe_tran.sql
use cobis
go
delete cl_ttransaccion where tn_trn_code =728
insert into cl_ttransaccion values(728, 'INSERCION DE AUTORIZACION DE TRANSACCIONES DE CAJA',  'IATC', 'ICREACION DE AUTORIZACION DE TRANSACCIONES DE CAJA')
delete cl_ttransaccion where tn_trn_code =729
insert into cl_ttransaccion values(729, 'MODIFICION DE AUTORIZACION DE TRANSACCIONES DE CAJA', 'MATC', 'MODIFICACION DE AUTORIZACION DE TRANSACCIONES DE CAJA')
delete cl_ttransaccion where tn_trn_code =730
insert into cl_ttransaccion values(730, 'CONSULTA DE AUTORIZACION DE TRANSACCIONES DE CAJA',   'SATC', 'CONSULTA DE AUTORIZACION DE TRANSACCIONES DE CAJA')
delete cl_ttransaccion where tn_trn_code =731
insert into cl_ttransaccion values(731, 'CATALOGO DE AUTORIZACION DE TRANSACCIONES DE CAJA',   'CATC', 'CATALOGO DE AUTORIZACION DE TRANSACCIONES DE CAJA')

--------------------------------------------------------------------------------------------------------------------------------------
-- cc_proc.sql
use cobis
go

delete from ad_procedure
 where pd_procedure in (  78,2627,2628,2531,2532, 94,99,2530,2579,2669,
                          75,  16,2597,2514)

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2627,'sp_centro_canje','cob_cuentas','V', getdate(),'cccencanje.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2628,'sp_ofi_canje','cob_cuentas','V',getdate(),'ccoficanje.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2531,'sp_tr_crea_ofibanco','cob_cuentas','V',getdate(),'ccpofiba.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2532,'sp_tr_crea_banco','cob_cuentas','V',getdate(),'ccpbanco.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (94,'sp_tr_tot_caj_adm','cob_cuentas','V',getdate(),'cctotcajadm.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (99,'sp_tr_cons_tot_ofi_adm','cob_cuentas','V', getdate(),'cccpmtotofi.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2530, 'sp_tr_crea_rutayt', 'cob_cuentas', 'V', getdate(), 'ccprutat.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2579, 'sp_tr_cons_tot_nal_adm', 'cob_cuentas', 'V', getdate(), 'tr_tot_nac.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (75, 'sp_tr_query_nom_ctacte', 'cob_cuentas', 'V', getdate(), 'ccpconom.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (2669, 'sp_control_efectivo', 'cob_cuentas', 'V', getdate(), 'conefect.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (2597, 'sp_query_excep_sipla', 'cob_cuentas', 'V', getdate(), 'ccqryexs.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (2514, 'sp_plazas_bco_rep', 'cob_cuentas', 'V', getdate(), 'ccplbrep.sp')

INSERT INTO dbo.ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (16, 'sp_tr_pag_chq_xfr', 'cob_cuentas', 'V', getdate(), 'trpaxfr.sp')

INSERT INTO dbo.ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (78, 'sp_tr_anl_chqr_c', 'cob_cuentas', 'V', getdate(), 'ccpanchc.sp')

go

-----------------------------------------------------------------------------------------------------------------------
-- adm_proc.sql
delete from ad_procedure where pd_procedure = 79
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (79, 'sp_cons_param_inicio', 'cobis', 'V', getdate(), 'par.sp')

-----------------------------------------------------------------------------------------------------------------------
-- cc_proc.sql
delete from ad_procedure where pd_procedure = 2597
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (2597, 'sp_query_excep_sipla', 'cob_cuentas', 'V', getdate(), 'ccqryexs.sp')

go

