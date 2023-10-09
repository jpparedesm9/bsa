/***********************************************************************************************************/

---Fecha					: 19/08/2016 
--Descripción               : script para la Historia 80490 
--Descripción de la Solución: Remediacion para la Historia 80490
--Autor						: Jorge Baque
/***********************************************************************************************************/

/* Vista ah_notcredeb */
/* Archivo: $/COB/Desarrollos/DEV_SaaSMX/CtasCteAho/Ahorros/Backend/sql/ah_view.sql */
use cob_ahorros
go
print 'Vista Eliminada ------> ah_notcredeb'
go
if exists (select 1 from sysobjects where type='V' and name='ah_notcredeb')
    drop view ah_notcredeb
go
print 'Vista creada ------> ah_notcredeb'
go
create view ah_notcredeb (
    secuencial, ssn_branch, tipo_tran, oficina, filial,
    usuario, terminal, correccion, sec_correccion, 
    reentry, origen, nodo, fecha, cta_banco, 
    valor, remoto_ssn, moneda, interes, val_cheque, 
    indicador, saldo_lib, control, causa, fecha_efec,
    signo, alterno, saldocont, saldodisp, saldoint, departamento,
    oficina_cta, banco, hora, concepto, estado,
    prod_banc, categoria, monto_imp, tipo_exonerado, serial, tipocta_super,
    turno, ctabanco_dep, cheque, stand_in, canal, clase_clte, oficial,monto_iva,
    cliente, base_imp, base_gmf, chq_locales
) as
select  tm_secuencial, tm_ssn_branch, tm_tipo_tran, tm_oficina, tm_filial,
    tm_usuario, tm_terminal, tm_correccion, tm_sec_correccion,
    tm_reentry, tm_origen, tm_nodo, tm_fecha, tm_cta_banco, 
    tm_valor, tm_remoto_ssn, tm_moneda, tm_interes, tm_efectivo ,  
    tm_indicador, tm_saldo_lib, tm_control, tm_causa, tm_fecha_efec,
    tm_signo, tm_cod_alterno, tm_saldo_contable, tm_saldo_disponible,
    tm_saldo_interes, tm_departamento, tm_oficina_cta, tm_banco, tm_hora,
    tm_concepto, tm_estado,
    tm_prod_banc, tm_categoria, tm_monto_imp, tm_tipo_exonerado_imp, tm_serial, tm_tipocta_super,
    tm_turno, tm_ctadestino, tm_cheque, tm_stand_in, tm_canal, tm_clase_clte,tm_oficial,tm_valor_comision,
    tm_cliente, tm_chq_ot_plazas, tm_base_gmf, tm_chq_locales
  from  ah_tran_monet
 where  tm_tipo_tran in (221, 240, 253, 255, 257, 262, 264, 265, 266, 304, 308, 309)

go

/********************************************************** Catalogos *****************************************/
/* $/COB/Desarrollos/DEV_SaaSMX/CtasCteAho/Dependencias/sql/cc_catlgo.sql */
use cobis
go

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('cc_devolucion_cheque', 'cc_tipos_cheque')
  and codigo = cp_tabla

go

delete cl_catalogo from cl_tabla
where  cl_tabla.tabla in ('cc_devolucion_cheque', 'cc_tipos_cheque')
  and  cl_tabla.codigo = cl_catalogo.tabla

go

delete cl_tabla
 where tabla in ('cc_devolucion_cheque', 'cc_tipos_cheque')
go

declare @w_maxtabla smallint
select @w_maxtabla = max(codigo) + 1
from cl_tabla

update cl_seqnos
set siguiente = @w_maxtabla
where tabla = 'cl_tabla'

declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
 where tabla = 'cl_tabla'

print 'Insercion de catalogo de devolucion de cheques'
insert into cl_tabla values (@w_codigo,'cc_devolucion_cheque','Motivos Rechazos Chs del Exterior DM')
insert into cl_catalogo_pro values ('CTE', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '1','No tiene fondos','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '2','Girado contra producto','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '3','Cuenta cerrada','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '4','Anulacion de pago','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '5','Falta fecha','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '6','Fecha vencida','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '7','Fecha alterada','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '8','Fecha incompleta','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '9','Falta nombre de beneficiario','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '10','Nombre del beneficiario alterado','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '11','Falta cantidades en letras','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '12','Cantidad en letras alterada','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '13','Falta cantidades en numeros','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '14','Cantidad en numeros alterada','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '15','Cantidad en numeros y letras difieren','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '16','No esta firmado','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '17','Falta una firma','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '18','Primera firma no registrada','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '19','Segunda firma no registrada','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '20','Tercera firma no registrada','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '21','Firma incompleta','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '22','firma falsificada','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '23','Firma alterada','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '24','Firma incorrecta','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '25','Firma no registrada','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '26','Falta endoso beneficiario','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '27','Mal endosado','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '28','Mal girado','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '29','Alterado','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '30','Cheque falsificado','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '31','Falta endoso previo garantizado','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '32','No hay avisos','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '33','Embargo judicial','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '34','Cheque mal sumado','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '35','Cuenta de ahorro requiere libreta','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '36','Documento no negociable','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '37','Cuenta no existe','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '38','Falta sello ','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '39','Girador fallecio','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '40','Beneficiario fallecio','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '41','Refierase al girador','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '42','Pagadero fuera de Estados Unidos','V')

select @w_codigo = @w_codigo + 1
print 'cc_tipos_cheque'
insert into cl_tabla values (@w_codigo,'cc_tipos_cheque','Tipos de Cheque')
insert into cl_catalogo_pro values ('REM', @w_codigo)
insert into cl_catalogo (tabla,codigo,valor,estado) values(@w_codigo, '3', 'Cheque Propio', 'V')

update cl_seqnos
   set siguiente = @w_codigo
 where tabla = 'cl_tabla'

 go

 ----------------------------------------------------------------------------------------------------------------
 /* $/COB/Desarrollos/DEV_SaaSMX/CtasCteAho/Remesas/BackEnd/sql/re_catlgo.sql */
 delete cl_catalogo_pro from cl_tabla
where  cl_tabla.tabla in ('re_producto_chq', 're_echeque')
  and  codigo = cp_tabla

delete cl_catalogo from cl_tabla
where  cl_tabla.tabla in ('re_producto_chq', 're_echeque')
  and  cl_tabla.codigo = cl_catalogo.tabla

delete cl_tabla
where  cl_tabla.tabla in ('re_producto_chq', 're_echeque')
go

declare @w_maxtabla smallint
select @w_maxtabla = max(codigo) + 1
from cl_tabla

update cl_seqnos
set siguiente = @w_maxtabla
where tabla = 'cl_tabla'

declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
 where tabla = 'cl_tabla'
  
print 'Producto Estados Cheque'
insert into cl_tabla values(@w_codigo, 're_producto_chq', 'PRODUCTO ESTADO CHEQUES')
insert into cl_catalogo_pro values ('REM', @w_codigo)
insert into cl_catalogo values (@w_codigo, '4', 'CUENTA DE AHORROS', 'V', null, null, null)
---------------------------------------------------------------------------------------------------

select @w_codigo = @w_codigo + 1
print 'Estado de Detalle de Cheques de Camara'
insert into cl_tabla values(@w_codigo, 're_echeque', 'ESTADOS DE DETALLE DE CHEQUES DE CAMARA')
insert into cl_catalogo_pro values ('REM', @w_codigo)
insert into cl_catalogo values(@w_codigo,'I','PENDIENTE DE CONFIRMACION','V',null,null,null)
insert into cl_catalogo values(@w_codigo,'C','CONFIRMADO','V',null,null,null)
insert into cl_catalogo values(@w_codigo,'D','DEVUELTO','V',null,null,null)

update cl_seqnos set siguiente = @w_codigo
    where tabla='cl_tabla'
go
/******************************************** ELIMNA INDICES ***********************************************/
/* $/COB/Desarrollos/DEV_SaaSMX/CtasCteAho/Remesas/BackEnd/sql/re_dropp.sql */
/* $/COB/Desarrollos/DEV_SaaSMX/CtasCteAho/Remesas/BackEnd/sql/re_dropf.sql */
/* re_cheque_ofi_mone_Key */
use cob_remesas
go
print 're_cheque_ofi_mone_Key'
if exists (select * from sysindexes where name = 're_cheque_ofi_mone_Key')
   drop index re_cheque_rec.re_cheque_ofi_mone_Key
go

/* re_cheque_rec_Key */
print 're_cheque_rec_Key'
if exists (select * from sysindexes 
	where name = 're_cheque_rec_Key')
drop index re_cheque_rec.re_cheque_rec_Key
go
/******************************************* Crea Indices **************************************************/
/* $/COB/Desarrollos/DEV_SaaSMX/CtasCteAho/Remesas/BackEnd/sql/re_pkey.sql */
/* $/COB/Desarrollos/DEV_SaaSMX/CtasCteAho/Remesas/BackEnd/sql/re_fkey.sql */
/* 're_cheque_ofi_mone_Key' */
print 're_cheque_ofi_mone_Key'
CREATE INDEX re_cheque_ofi_mone_Key ON re_cheque_rec (
        cr_oficina,
        cr_moneda,
        cr_cta_depositada)
go

/* re_cheque_rec */
print 're_cheque_rec_Key'
CREATE UNIQUE CLUSTERED INDEX re_cheque_rec_Key ON re_cheque_rec (
	cr_cta_depositada,
	cr_fecha_ing,
	cr_banco_p,
	cr_cheque_rec)
go

/*************************************************** PARAMETRO *******************************************/
use cobis
go
delete from cl_parametro where pa_producto = 'REM' and pa_nemonico in ('CTEIC')
insert into cobis..cl_parametro (pa_parametro,pa_nemonico, pa_tipo, pa_char, pa_producto) 
values ('CTA CTE INGRESO CAJA', 'CTEIC', 'C', '99999999999', 'REM')
go

/********************************* AUTORIZACION ************************************/
-- $/COB/Desarrollos/DEV_SaaSMX/CtasCteAho/Remesas/BackEnd/sql/re_proc.sql

use cobis
go
declare @w_codigop int
if exists (select * from cobis..ad_procedure where pd_procedure = 7067119)
begin
       delete from ad_procedure where pd_procedure = 7067119
end

insert into cobis..ad_procedure values(7067119,'sp_cheq_aprob_rechaz','cob_remesas','V',getdate(),'che_aprrec.sp')

select @w_codigop = 7067119
-- $/COB/Desarrollos/DEV_SaaSMX/CtasCteAho/Remesas/BackEnd/sql/re_tran.sql
declare @w_codigo int

if exists (select * from cobis..cl_ttransaccion where tn_trn_code = 150017)
begin
       delete from cobis..cl_ttransaccion where tn_trn_code = 150017
end

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (150017, 'APROBACION CHEQ RECHAZADOS', 'ACHRE', 'APROBACION CHEQUES RECHAZADOS')

select @w_codigo = 150017

-- $/COB/Desarrollos/DEV_SaaSMX/CtasCteAho/Remesas/BackEnd/sql/re_protran.sql

if exists (select * from cobis..ad_pro_transaccion where pt_producto = 10 and pt_transaccion = @w_codigo )
begin
	delete from cobis..ad_pro_transaccion where pt_producto = 10 and pt_transaccion = @w_codigo
	and pt_tipo = 'R' and pt_moneda = 0
end

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 150017, 'V', getdate(), @w_codigop, NULL)



-- $/COB/Desarrollos/DEV_SaaSMX/CtasCteAho/Remesas/BackEnd/sql/re_traut.sql

if exists (select * from cobis..ad_tr_autorizada where ta_transaccion = 150017)
begin
    DELETE from cobis..ad_tr_autorizada where ta_transaccion = 150017 and ta_tipo = 'R' and ta_moneda = 0
end

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 150017, 3, getdate(), 1, 'V', getdate())
GO

