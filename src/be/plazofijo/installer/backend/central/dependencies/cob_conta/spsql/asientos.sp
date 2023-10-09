/************************************************************************/
/*	Archivo: 		asientos.sp                             */
/*	Stored procedure: 	sp_sasiento				*/
/*	Base de datos:  	cob_conta                               */
/*	Producto:               contabilidad                            */
/*	Disenado por:           Jose Orlando Forero Ramirez             */
/*	Fecha de escritura:     22/Oct/2003                             */
/************************************************************************/
/*				IMPORTANTE                              */
/*	Este programa es parte de los paquetes bancarios propiedad de   */
/*	"MACOSA", representantes exclusivos para el Ecuador de la       */
/*	"NCR CORPORATION".                                              */
/*	Su uso no autorizado queda expresamente prohibido asi como      */
/*	cualquier alteracion o agregado hecho por alguno de sus         */
/*	usuarios sin el debido consentimiento por escrito de la         */
/*	Presidencia Ejecutiva de MACOSA o su representante.             */
/*				PROPOSITO                               */
/*	Este programa procesa las transacciones de:                     */
/*	Inserta los asientos de un comprobante a la tabla temporal      */
/*	de comprobantes generados por un subsistema                     */
/*				MODIFICACIONES                          */
/*	FECHA		AUTOR		RAZON                           */
/*      18-MAR-04	diegoAyala	Uso de tablas temporales diarias*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_sasiento')
	drop proc sp_sasiento
go

create proc sp_sasiento(
	@s_ssn			int = null,
	@s_date			datetime = null,
	@s_user			login = null,
	@s_term			descripcion = null,
	@s_corr			char(1) = null,
	@s_ssn_corr		int = null,
	@s_ofi			smallint = null,
	@t_rty			char(1) = null,
	@t_trn			smallint = null,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion		char(1) = null,
	@i_fecha_tran		datetime = null,
	@i_comprobante		int = null,
	@i_empresa		tinyint = null,
	@i_asiento		int = null,
	@i_cuenta		cuenta = null,
	@i_oficina_dest		smallint = null,
	@i_area_dest		smallint = null,
	@i_credito		money = 0,
	@i_debito		money = 0,
	@i_concepto		descripcion = null,
	@i_credito_me		money = 0,
	@i_debito_me		money = 0,
	@i_moneda		tinyint = 0,
	@i_cotizacion		float = 0,
	@i_tipo_doc		char(1) = null,
	@i_genera_posicion	char(1) = 'S',
	@i_tipo_tran		char(1) = null,
	@i_producto		tinyint = null,
	@i_debcred		char(1) = null,
	@i_opcion		tinyint = null,
	@i_fecha_est		datetime = null,
	@i_detalle		int = null,
	@i_ente			int = null,
	@i_con_rete		char(4) = null,
	@i_base			money = null,
	@i_valret		money = null,
	@i_con_iva		char(4) = null,
	@i_valor_iva		money = null,
	@i_iva_retenido		money = null,
	@i_con_ica		char(4) = null,
	@i_valor_ica		money = null,
	@i_con_timbre		char(4) = null,
	@i_valor_timbre		money = null,
	@i_con_iva_reten	char(4) = null,
	@i_codigo_regimen	char(4) = null,
	@i_con_ivapagado	char(4) = null,
	@i_valor_ivapagado	money = null,
	@i_documento		varchar(24) = null,
	@i_mayorizado		char(1) = 'N',
	@i_oper_banco		char (4) = null,
	@i_doc_banco		char(20) = null,
	@i_cheque		varchar (64) = null,
	@i_fecha_fin_difer	datetime = null,
	@i_desc_difer		descripcion = null,
	@i_perfil		varchar(20) = null,
	@i_tran_modulo		varchar(20) = '6',
	@i_modo			tinyint = 0,
	@i_con_dptales		char(4) = null,
	@i_valor_dptales	money = null,
	@o_desc_error		varchar(255) = null out
)
as
declare	@w_sp_name		varchar(32),
	@w_moneda_base		tinyint,
	@w_banco		varchar (3),
	@w_ctacte		varchar (20),
	@w_debito		money,
	@w_credito		money,
	@w_debito_me		money,
	@w_credito_me		money,
	@w_sum_debito_me	money,
	@w_sum_credito_me	money,
	@w_proceso		smallint,
	@w_condicion		char(4),
	@w_fechahoy		char(10),
	@w_moneda		tinyint,
	@w_count		int,
	@w_return		int,
	@w_valor		money,
	@w_estado		char(1),
	@w_horabase		datetime,
	@w_fecha		datetime,
	@w_fecha_conta		datetime,
	@w_tran_modulo		varchar(20),
	@w_asiento		int,
	@w_numerror		int,
	@w_mensaje		varchar(255),
	@w_perfil		varchar(20),
	@w_oficina		smallint,
	@w_fecha_min		datetime,
	@w_fecha_max		datetime,
	@w_comprobmin		int,
	@w_comprobmax		int,
	@w_comprobante		int,
	@w_cortes		int,
	@w_dias			int,
	@w_error		descripcion,
	@w_producto             tinyint

select	@w_sp_name = 'sp_sasiento',	@w_fechahoy = convert(char(10),getdate(),101),
	@w_horabase = getdate(),	@w_count = @@trancount


if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_fecha_tran	= @i_fecha_tran,
		i_comprobante	= @i_comprobante,
		i_empresa	= @i_empresa,
		i_asiento	= @i_asiento,
		i_cuenta	= @i_cuenta ,
		i_oficina_dest	= @i_oficina_dest,
		i_area_dest	= @i_area_dest,
		i_credito	= @i_credito,
		i_debito	= @i_debito,
		i_credito_me	= @i_credito_me,
		i_debito_me	= @i_debito_me,
		i_cotizacion	= @i_cotizacion,
		i_tipo_doc	= @i_tipo_doc,
		i_tipo_tran	= @i_tipo_tran,
		i_concepto	= @i_concepto,
		i_producto	= @i_producto,
		i_ente		= @i_ente
	exec cobis..sp_end_debug
end




/********  VALIDACIONES MASIVAS DE ASIENTOS CONTABLES  ***********/
if @i_operacion = 'V'
begin
  print 'Se esta invocando a la version incorrecta. Debe utilizar: cob_conta..sp_sasiento_val'
  return 1
--exec cobis..sp_reloj 1, @w_horabase, @w_horabase, 0
/* CALCULA LA FECHA MINIMA Y MAXIMA DE LOS COMPROBANTES DEL MODULO */
select @w_fecha_min = min(sc_fecha_tran), @w_fecha_max = max(sc_fecha_tran)
from cob_conta_tercero..ct_scomprobante_tmp
where sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_estado = 'I'
if @w_fecha_min is null or @w_fecha_max is null
begin
	print 'No existen comprobantes para validar la interfaz contable en la fecha y producto dados'
	return 0
end

/* VERIFICA LA EXISTENCIA DE LOS CORTES DE CONTABILIDAD */
select @w_cortes = count(1) from cob_conta..cb_corte
where co_empresa = @i_empresa
and co_estado in ('A','V')
and co_fecha_ini between @w_fecha_min and @w_fecha_max
and co_fecha_ini in (select distinct sc_fecha_tran from cob_conta_tercero..ct_scomprobante_tmp
                    where sc_empresa = @i_empresa
                     and sc_producto = @i_producto
                     and sc_fecha_tran between @w_fecha_min and @w_fecha_max
                     and sc_comprobante >= 0)

select @w_cortes = count(distinct sc_fecha_tran)
from cob_conta_tercero..ct_scomprobante_tmp
where sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_comprobante >= 0
if @w_cortes = @w_dias
begin
	print 'Los cortes no se encuentran vigentes para las fechas a Contabilizar'
	return 0
end


/* SELECCIONA LA MONEDA BASE DE LA EMPRESA */
select @w_moneda_base = em_moneda_base
from cob_conta..cb_empresa where em_empresa = @i_empresa
if @@rowcount = 0
begin
	print 'No existe empresa especificada'
	return 601018
end

/* VERIFICA EL PRODUCTO EN COBIS Y CONTABILIDAD */
select @w_producto = pd_producto from cobis..cl_producto
where  pd_producto = @i_producto
and    pd_estado = 'V'
if @@rowcount = 0
begin
	print 'No existe producto cobis'
	return 601168
end


select @w_producto = pr_producto
from cob_conta..cb_producto
where pr_empresa = @i_empresa
and pr_producto = @i_producto
and pr_estado = 'V'
if @@rowcount = 0
begin
	print 'No existe producto en contabilidad'
	return 601168
end


/* LIMPIA LAS TABLAS TEMPORALES DE ERRORES Y DE TRABAJO */
/*   Y LOS ASIENTOS Y COMPROBANTES EN ESTADO 'E'        */

begin tran
delete cob_conta_tercero..ct_tmp_ter
where pt_empresa = @i_empresa
and pt_producto = @i_producto
delete cob_conta_tercero..ct_error_asientot
where ea_empresa = @i_empresa
and ea_producto = @i_producto
delete cob_conta_tercero..ct_tmp_plangral
where sa_empresa = @i_empresa
and sa_producto = @i_producto
delete cob_conta_tercero..ct_tmp_asientocon
where sa_empresa = @i_empresa
and sa_producto = @i_producto
delete cob_conta_tercero..ct_tmp_comprob
where sc_empresa = @i_empresa
and sc_producto = @i_producto
delete cob_conta_tercero..ct_tmp_asientot
where sa_empresa = @i_empresa
and sa_producto = @i_producto
commit tran




begin tran
insert into cob_conta_tercero..ct_tmp_ter
select cp_empresa, @i_producto, cp_proceso, cu_cuenta, cp_condicion
from	cob_conta..cb_cuenta_proceso,
	cob_conta..cb_cuenta --(index cb_cuenta_Key)
where cp_empresa = @i_empresa
and   cp_proceso in (6003,6095)
and   cu_empresa = cp_empresa
and   rtrim(cu_cuenta) like rtrim(cp_cuenta) + '%'
and   cu_movimiento = 'S'
commit tran





/* REALIZA LAS VERIFICACIONES DE LA CABECERA DE LOS COMPROBANTES */
/* VERIFICA EL CORTE Y EL PERIODO PARA EL CUAL SE PROCESA LA INTERFAZ CONTABLE */
begin tran
insert into cob_conta_tercero..ct_error_asientot
select sc_empresa, sc_producto, sc_fecha_tran, sc_comprobante, getdate(), sc_tran_modulo,
0, 601181,
'FECHA NO AUTORIZADA PARA PROCESAR INTERFAZ CONTABLE ' + convert(varchar(10),sc_fecha_tran,101), sc_perfil,
sc_oficina_orig, sc_tot_debito
from cob_conta_tercero..ct_scomprobante_tmp, cob_conta..cb_corte
where sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_comprobante >= 0
and sc_estado = 'I'
and co_empresa = sc_empresa
and co_periodo >= 0
and co_corte >= 0
and co_fecha_ini >= sc_fecha_tran
and co_fecha_fin <= sc_fecha_tran
and co_estado not in ('A','V')
commit tran





/* VALIDA QUE LA OFICINA ORIGEN EXISTA, SEA DE MOVIMIENTO Y VIGENTE */
begin tran
insert into cob_conta_tercero..ct_error_asientot
select sc_empresa, sc_producto, sc_fecha_tran, sc_comprobante, getdate(), sc_tran_modulo,
0, 601131,
'OFICINA CONSULTADA NO EXISTE, NO ES DE MOVIMIENTO O NO SE ENCUENTRA VIGENTE ' + convert(varchar(10), sc_oficina_orig), sc_perfil,
sc_oficina_orig, sc_tot_debito
from cob_conta_tercero..ct_scomprobante_tmp
where sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_comprobante >= 0
and sc_estado = 'I'
and sc_oficina_orig not in (select of_oficina from cob_conta..cb_oficina
                            where of_empresa = @i_empresa
                            and of_movimiento = 'S' and of_estado = 'V')
commit tran




/* VALIDA QUE EL AREA ORIGEN EXISTA, SEA DE MOVIMIENTO Y VIGENTE */
begin tran
insert into cob_conta_tercero..ct_error_asientot
select sc_empresa, sc_producto, sc_fecha_tran, sc_comprobante, getdate(), sc_tran_modulo,
0, 601131,
'AREA CONSULTADA NO EXISTE, NO ES DE MOVIMIENTO O NO SE ENCUENTRA VIGENTE ' + convert(varchar(10), sc_area_orig), sc_perfil,
sc_oficina_orig, sc_tot_debito
from cob_conta_tercero..ct_scomprobante_tmp
where sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_comprobante >= 0
and sc_estado = 'I'
and sc_area_orig not in (select ar_area from cob_conta..cb_area
                         where ar_empresa = @i_empresa
                         and ar_movimiento = 'S' and ar_estado = 'V')
commit tran





/* VALIDA QUE SEA EQUIVALENTE EL VALOR DEBITO Y CREDITO DEL COMPROBANTE */
begin tran
insert into cob_conta_tercero..ct_error_asientot
select sc_empresa, sc_producto, sc_fecha_tran, sc_comprobante, getdate(), sc_tran_modulo,
0, 601056,
'TOTAL DEBITOS Y CREDITOS EN TABLA AUXILIAR DESCUADRADOS', sc_perfil,
sc_oficina_orig, sc_tot_debito
from cob_conta_tercero..ct_scomprobante_tmp
where sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_comprobante >= 0
and sc_estado = 'I'
and sc_tot_debito <> sc_tot_credito
commit tran




/* VALIDA OFICINA VIGENTE Y DE MOVIMIENTO */
begin tran
insert into cob_conta_tercero..ct_error_asientot
select sa_empresa, sa_producto, sa_fecha_tran, sa_comprobante, getdate(), sc_tran_modulo,
sa_asiento, 601131,
'OFICINA NO EXISTE O NO ES DE MOVIMIENTO ' + convert(varchar(5),sa_oficina_dest), sc_perfil,
sc_oficina_orig, case sa_debito when 0 then sa_credito else sa_debito end
from cob_conta_tercero..ct_scomprobante_tmp, cob_conta_tercero..ct_sasiento_tmp
where sc_empresa = sa_empresa
and sc_producto = sa_producto
and sc_fecha_tran = sa_fecha_tran
and sc_comprobante = sa_comprobante
and sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_estado = 'I'
and sa_oficina_dest not in (select of_oficina from cob_conta..cb_oficina --(index cb_oficina_Key)
                            where of_empresa = @i_empresa
                            and of_oficina >= 0
                            and of_movimiento = 'S' or of_estado = 'V')
commit tran




/* VALIDA AREA VIGENTE Y DE MOVIMIENTO */
begin tran
print 'insert into cob_conta_tercero..ct_error_asientot'
insert into cob_conta_tercero..ct_error_asientot
select sa_empresa, sa_producto, sa_fecha_tran, sa_comprobante, getdate(), sc_tran_modulo,
sa_asiento, 601132,
'AREA NO EXISTE O NO ES DE MOVIMIENTO ' + convert(varchar(5),sa_oficina_dest), sc_perfil,
sc_oficina_orig, case sa_debito when 0 then sa_credito else sa_debito end
from cob_conta_tercero..ct_scomprobante_tmp, cob_conta_tercero..ct_sasiento_tmp
where sc_empresa = sa_empresa
and sc_producto = sa_producto
and sc_fecha_tran = sa_fecha_tran
and sc_comprobante = sa_comprobante
and sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_estado = 'I'
and sa_area_dest not in (select ar_area from cob_conta..cb_area --(index cb_area_Key)
                         where ar_empresa = @i_empresa
                         and ar_area >= 0
                         and ar_movimiento = 'S' or ar_estado = 'V')
commit tran




/* VALIDA COTIZACION MONEDA EXTRANJERA */
begin tran
print 'insert into cob_conta_tercero..ct_error_asientot'
insert into cob_conta_tercero..ct_error_asientot
select sa_empresa, sa_producto, sa_fecha_tran, sa_comprobante, getdate(), sc_tran_modulo,
sa_asiento, 601064,
'COMPROBANTE: ' + convert(varchar(10),sc_comprobante) + ', OF. DEST: '
+ convert(varchar(8),sa_oficina_dest) + ' , AREA DEST: ' + convert(varchar(8),sa_area_dest)
+ ', CUENTA: ' + rtrim(sa_cuenta) + ', SIN COTIZACION.', sc_perfil,
sc_oficina_orig, case sa_debito when 0 then sa_credito else sa_debito end
from cob_conta_tercero..ct_scomprobante_tmp, cob_conta_tercero..ct_sasiento_tmp
where sc_empresa = sa_empresa
and sc_producto = sa_producto
and sc_fecha_tran = sa_fecha_tran
and sc_comprobante = sa_comprobante
and sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_estado = 'I'
and (sa_credito_me <> 0 or sa_debito_me <> 0)
and sa_cotizacion = 0
commit tran




/* VALIDA CUENTA VIGENTE Y DE MOVIMIENTO */
begin tran
print 'insert into cob_conta_tercero..ct_error_asientot'
insert into cob_conta_tercero..ct_error_asientot
select sa_empresa, sa_producto, sa_fecha_tran, sa_comprobante, getdate(), sc_tran_modulo,
sa_asiento, 601109,
'LA CUENTA CONTABLE ' + rtrim(sa_cuenta) + ' NO EXISTE, NO ES DE MOVIMIENTO O NO ESTA VIGENTE',
sc_perfil,
sc_oficina_orig, case sa_debito when 0 then sa_credito else sa_debito end
from cob_conta_tercero..ct_scomprobante_tmp, cob_conta_tercero..ct_sasiento_tmp
where sc_empresa = sa_empresa
and sc_producto = sa_producto
and sc_fecha_tran = sa_fecha_tran
and sc_comprobante = sa_comprobante
and sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_estado = 'I'
and sa_cuenta not in (select cu_cuenta from cob_conta..cb_cuenta
                      where cu_empresa = @i_empresa
                      and cu_cuenta > '0'
                      and cu_movimiento = 'S'
                      and cu_estado = 'V')
commit tran



/* VERIFICAR QUE LA MONEDA DE LA CUENTA CONTABLE CORRESPONDA */
/* A LA MONEDA DEL VALOR MONETARIO A ASIGNAR.                */
begin tran
print 'insert into cob_conta_tercero..ct_error_asientot'
insert into cob_conta_tercero..ct_error_asientot
select sa_empresa, sa_producto, sa_fecha_tran, sa_comprobante, getdate(), sc_tran_modulo,
sa_asiento, 607122,
'LA MONEDA DE LA CUENTA CONTABLE ' + rtrim(sa_cuenta) + ' NO CORRESPONDE.', sc_perfil,
sc_oficina_orig, case sa_debito when 0 then sa_credito else sa_debito end
from cob_conta_tercero..ct_scomprobante_tmp, cob_conta_tercero..ct_sasiento_tmp, cob_conta..cb_cuenta
where sc_empresa = sa_empresa
and sc_producto = sa_producto
and sc_fecha_tran = sa_fecha_tran
and sc_comprobante = sa_comprobante
and cu_empresa = @i_empresa
and sc_producto = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_estado = 'I'
and cu_empresa = sc_empresa
and cu_cuenta = sa_cuenta
and cu_moneda <> sa_moneda
commit tran




/* VERIFICAR QUE EXISTA LA RELACION DE ACUERDO AL PLAN GENERAL DE CUENTAS */
begin tran
insert into cob_conta_tercero..ct_tmp_plangral
select sa_empresa, sa_producto, sa_fecha_tran, sa_comprobante,
sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest,
sa_debito, sa_credito, pg_clave
from cob_conta_tercero..ct_scomprobante_tmp
inner join cob_conta_tercero..ct_sasiento_tmp on
   sc_empresa = sa_empresa and 
   sc_producto = sa_producto and 
   sc_fecha_tran = sa_fecha_tran and 
   sc_comprobante = sa_comprobante
   left outer join cob_conta..cb_plan_general on
      pg_clave = convert(varchar(30), convert(varchar(5),sa_empresa) +
      convert(varchar(15),sa_cuenta) + convert(varchar(8),sa_oficina_dest) +
      convert(varchar(8),sa_area_dest)) and
      pg_empresa = sa_empresa
where sc_estado = 'I'
and sa_asiento >= 0
and sa_empresa = @i_empresa
and sa_producto = @i_producto
and sa_fecha_tran between @w_fecha_min and @w_fecha_max
and sa_comprobante >= 0
commit tran

begin tran
insert into cob_conta_tercero..ct_error_asientot
select sa_empresa, sa_producto, sa_fecha_tran, sa_comprobante, getdate(), sc_tran_modulo,
sa_asiento, 601109,
'CUENTA CONTABLE ' + rtrim(sa_cuenta) + ' NO ESTA RELACIONADA A OFICINA '
+ convert(varchar(8),sa_oficina_dest) + ' AREA ' + convert(varchar(8),sa_area_dest), sc_perfil,
sc_oficina_orig, case sa_debito when 0 then sa_credito else sa_debito end
from cob_conta_tercero..ct_scomprobante_tmp, cob_conta_tercero..ct_tmp_plangral --(index ct_tmp_plangral_Key)
where sc_empresa = sa_empresa
and sc_producto = sa_producto
and sc_fecha_tran = sa_fecha_tran
and sc_comprobante = sa_comprobante
and sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_estado = 'I'
and sa_clave is null
commit tran




/* VERIFICAR QUE LA MONEDA DE LA CUENTA CONTABLE CORRESPONDA */
/* CON EL VALOR MONETARIO EN MN Y/O EN ME.                   */
begin tran
insert into cob_conta_tercero..ct_error_asientot
select sa_empresa, sa_producto, sa_fecha_tran, sa_comprobante, getdate(), sc_tran_modulo,
sa_asiento, 607122,
'VALOR DE CUENTA: ' + rtrim(sa_cuenta) + ' NO CORRESPONDEN CON TIPO DE MONEDA. OFICINA: '
+ convert(varchar(8),sa_oficina_dest) + ' AREA: ' + convert(varchar(8),sa_area_dest), sc_perfil,
sc_oficina_orig, case sa_debito when 0 then sa_credito else sa_debito end
from cob_conta_tercero..ct_scomprobante_tmp, cob_conta_tercero..ct_sasiento_tmp
where sc_empresa = sa_empresa
and sc_producto = sa_producto
and sc_fecha_tran = sa_fecha_tran
and sc_comprobante = sa_comprobante
and sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_estado = 'I'
and (
(sa_moneda = @w_moneda_base and ((sa_debito_me <> 0 or sa_credito_me <> 0) or (sa_debito = 0 and sa_credito = 0))) or
(sa_moneda <> @w_moneda_base and ((sa_debito = 0 or sa_debito_me = 0) and (sa_credito = 0 or sa_credito_me = 0))) or
(sa_debito <> 0 and sa_credito <> 0 and sa_debito_me <> 0 and sa_credito_me <> 0)
)
commit tran




/* VERIFICA SI EXISTEN DOCUMENTOS DE COMPRA Y/O VENTA PARA CUADRAR ME */
begin tran
insert into cob_conta_tercero..ct_error_asientot
select sa_empresa, sa_producto, sa_fecha_tran, sa_comprobante, getdate(), sc_tran_modulo,
sa_asiento, 601504,
'NO EXISTEN DOCUMENTOS DE COMPRA O VENTA PARA CUADRAR LA M.E.', sc_perfil,
sc_oficina_orig, case sa_debito when 0 then sa_credito else sa_debito end
from cob_conta_tercero..ct_scomprobante_tmp,cob_conta_tercero..ct_sasiento_tmp
where sc_empresa = sa_empresa
and sc_producto = sa_producto
and sc_fecha_tran = sa_fecha_tran
and sc_comprobante = sa_comprobante
and sa_empresa = @i_empresa
and sa_producto = @i_producto
and sa_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_estado = 'I'
and ((sa_posicion = 'S' and sa_moneda <> @w_moneda_base
and sa_debito_me <> 0
and sa_tipo_doc <> 'C')
or
(sa_posicion = 'S' and sa_moneda <> @w_moneda_base
and sa_credito_me <> 0
and sa_tipo_doc <> 'V')
or
(sa_posicion = 'S' and sa_moneda = @w_moneda_base
and sa_tipo_doc <> 'N')
or
(sa_posicion = 'N' and sa_tipo_doc <> 'N'))
commit tran




/* VERIFICA SI EXISTEN CUENTAS ASOCIADAS A TERCEROS CON ENTE VALIDO */
begin tran
insert into cob_conta_tercero..ct_error_asientot
select sa_empresa, sa_producto, sa_fecha_tran, sa_comprobante, getdate(), sc_tran_modulo,
sa_asiento,
case sa_ente when null then
	601069
else
	609134
end,
case sa_ente when null then
	'CUENTA DE TERCERO SIN CODIGO DEL ENTE. CUENTA ' + sa_cuenta
else
	'CODIGO DE ENTE ES CERO (0) O NO EXISTE '
end,
sc_perfil,
sc_oficina_orig, case sa_debito when 0 then sa_credito else sa_debito end
from cob_conta_tercero..ct_scomprobante_tmp, cob_conta_tercero..ct_sasiento_tmp, cob_conta_tercero..ct_tmp_ter
where sc_empresa = sa_empresa
and sc_producto = sa_producto
and sc_fecha_tran = sa_fecha_tran
and sc_comprobante = sa_comprobante
and sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_estado = 'I'
and pt_empresa = sc_empresa
and pt_producto = @i_producto
and sa_cuenta = pt_cuenta
and isnull(sa_ente, 0) = 0
commit tran




/* VERIFICA SI LOS DATOS DEL IMPUESTO Y DEL DOCUMENTO SON VALIDOS */
begin tran
insert into cob_conta_tercero..ct_error_asientot
select sa_empresa, sa_producto, sa_fecha_tran, sa_comprobante, getdate(), sc_tran_modulo,
sa_asiento, 601184,
'CUENTA EXIGE NUMERO DE DOCUMENTO. CUENTA ' + sa_cuenta, sc_perfil,
sc_oficina_orig, case sa_debito when 0 then sa_credito else sa_debito end
from cob_conta_tercero..ct_scomprobante_tmp, cob_conta_tercero..ct_sasiento_tmp, cob_conta_tercero..ct_tmp_ter
where sc_empresa = sa_empresa
and sc_producto = sa_producto
and sc_fecha_tran = sa_fecha_tran
and sc_comprobante = sa_comprobante
and sa_empresa = @i_empresa
and sa_producto = @i_producto
and sa_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_estado = 'I'
and pt_empresa = @i_empresa
and pt_producto = @i_producto
and sa_cuenta  = pt_cuenta
and pt_condicion is not null
and sa_documento is null
commit tran




begin tran
insert into cob_conta_tercero..ct_error_asientot
select sa_empresa, sa_producto, sa_fecha_tran, sa_comprobante, getdate(), sc_tran_modulo,
sa_asiento, 601505,
'CUENTA EXIGE BASE DE IMPUESTO. CUENTA ' + sa_cuenta, sc_perfil,
sc_oficina_orig, case sa_debito when 0 then sa_credito else sa_debito end
from cob_conta_tercero..ct_scomprobante_tmp, cob_conta_tercero..ct_sasiento_tmp, cob_conta_tercero..ct_tmp_ter
where sc_empresa = sa_empresa
and sc_producto = sa_producto
and sc_fecha_tran = sa_fecha_tran
and sc_comprobante = sa_comprobante
and sa_empresa = @i_empresa
and sa_producto = @i_producto
and sa_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_estado = 'I'
and pt_empresa = @i_empresa
and pt_producto = @i_producto
and sa_cuenta  = pt_cuenta
and pt_proceso = 6095
and sa_base is null
commit tran




begin tran
insert into cob_conta_tercero..ct_error_asientot
select sa_empresa, sa_producto, sa_fecha_tran, sa_comprobante, getdate(), sc_tran_modulo,
sa_asiento, 601505,
'FALTAN DATOS DEL IMPUESTO. CUENTA ' + sa_cuenta, sc_perfil,
sc_oficina_orig, case sa_debito when 0 then sa_credito else sa_debito end
from cob_conta_tercero..ct_scomprobante_tmp, cob_conta_tercero..ct_sasiento_tmp, cob_conta_tercero..ct_tmp_ter
where sc_empresa = sa_empresa
and sc_producto = sa_producto
and sc_fecha_tran = sa_fecha_tran
and sc_comprobante = sa_comprobante
and sa_empresa = @i_empresa
and sa_producto = @i_producto
and sa_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_estado = 'I'
and pt_empresa = @i_empresa
and pt_producto = @i_producto
and sa_cuenta  = pt_cuenta
and pt_proceso = 6095
and ((pt_condicion = 'R' and (sa_con_rete is null or sa_valret is null))
or (pt_condicion = 'I' and (sa_con_iva is null or sa_valor_iva is null))
or (pt_condicion = 'C' and (sa_con_ica is null or sa_valor_ica is null))
or (pt_condicion = 'T' and (sa_con_timbre is null or sa_valor_timbre is null))
or (pt_condicion = 'P' and (sa_con_ivapagado is null or sa_valor_ivapagado is null))
or (pt_condicion = 'E' and (sa_con_dptales is null or sa_valor_dptales is null)))
commit tran



begin tran
update cob_conta_tercero..ct_sasiento_tmp set
	sa_ente			= null,
	sa_con_rete		= null,
	sa_base			= null,
	sa_valret		= null,
	sa_con_iva		= null,
	sa_valor_iva		= null,
	sa_iva_retenido		= null,
	sa_con_ica		= null,
	sa_valor_ica		= null,
	sa_con_timbre		= null,
	sa_valor_timbre		= null,
	sa_con_iva_reten	= null,
	sa_con_ivapagado	= null,
	sa_valor_ivapagado	= null,
	sa_documento		= null
from cob_conta_tercero..ct_scomprobante_tmp, cob_conta_tercero..ct_sasiento_tmp
where sc_empresa = sa_empresa
and sc_producto = sa_producto
and sc_fecha_tran = sa_fecha_tran
and sc_comprobante = sa_comprobante
and sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_estado = 'I'
and sa_cuenta not in (select pt_cuenta from cob_conta_tercero..ct_tmp_ter
where pt_empresa = @i_empresa and pt_producto = @i_producto)
commit tran




/* VALIDA CUENTAS QUE MANEJAN CONCILIACION BANCARIA */
begin tran
insert into cob_conta_tercero..ct_conciliacion
	(cl_producto,cl_comprobante,cl_empresa,cl_fecha_tran,
	cl_asiento,cl_cuenta,cl_oficina_dest,cl_area_dest,
	cl_debcred,cl_valor,cl_oper_banco,cl_doc_banco,
	cl_banco,cl_fecha_est,cl_cuenta_cte,cl_detalle,
	cl_relacionado,cl_cheque)
select	sa_producto, sa_comprobante, sa_empresa, sa_fecha_tran,
	sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest,
	sa_debcred, case sa_debcred when '1' then sa_debito else sa_credito end,
	sa_oper_banco, sa_doc_banco,
	ba_banco, sa_fecha_est, ba_ctacte, sa_detalle,
	'N',sa_cheque
from cob_conta_tercero..ct_scomprobante_tmp, cob_conta_tercero..ct_sasiento_tmp, cob_conta..cb_banco
where sc_empresa = sa_empresa
and sc_producto = sa_producto
and sc_fecha_tran = sa_fecha_tran
and sc_comprobante = sa_comprobante
and sc_estado = 'I'
and sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
and ba_empresa = sc_empresa
and ba_cuenta = sa_cuenta
and sa_oper_banco is not null
and sa_cheque is not null
commit tran




/* VERIFICAR QUE @i_oper_banco Y/O @i_cheque NO SEAN NULOS */
begin tran
insert into cob_conta_tercero..ct_error_asientot
select sa_empresa, sa_producto, sa_fecha_tran, sa_comprobante, getdate(), sc_tran_modulo,
sa_asiento, 1,
'CAMPOS @i_oper_banco Y/O @i_cheque TIENEN VALORES NULOS', sc_perfil,
sc_oficina_orig, case sa_debito when 0 then sa_credito else sa_debito end
from cob_conta_tercero..ct_scomprobante_tmp, cob_conta_tercero..ct_sasiento_tmp, cob_conta..cb_banco
where sc_empresa = sa_empresa
and sc_producto = sa_producto
and sc_fecha_tran = sa_fecha_tran
and sc_comprobante = sa_comprobante
and sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_estado = 'I'
and ba_empresa = sc_empresa
and ba_cuenta = sa_cuenta
and (sa_oper_banco is null or sa_cheque is null)
commit tran





/* VALIDACIONES DEL PROCESO CB_VALID.SQR */
/* CARGA EN UNA TABLA TEMPORAL LOS DATOS BASICOS DE LOS ASIENTOS */
begin tran
insert into cob_conta_tercero..ct_tmp_asientocon
select sa_empresa, sa_producto, sa_fecha_tran, sa_comprobante, count(1),
sum(sa_credito),sum(sa_debito)
from cob_conta_tercero..ct_scomprobante_tmp, cob_conta_tercero..ct_sasiento_tmp
where sc_empresa = sa_empresa
and sc_producto = sa_producto
and sc_fecha_tran = sa_fecha_tran
and sc_comprobante = sa_comprobante
and sc_estado = 'I'
and sa_empresa = @i_empresa
and sa_producto = @i_producto
and sa_fecha_tran between @w_fecha_min and @w_fecha_max
and sa_comprobante >= 0
group by sa_empresa, sa_producto, sa_fecha_tran, sa_comprobante
commit tran




/* CARGA EN UNA TABLA TEMPORAL LOS DATOS BASICOS DE LOS COMPROBANTES */
begin tran
insert into cob_conta_tercero..ct_tmp_comprob
select sc_empresa, sc_producto, sc_fecha_tran, sc_comprobante, sc_detalles,
sc_tot_credito, sc_tot_debito, sc_tran_modulo,
sc_perfil, sc_oficina_orig
from cob_conta_tercero..ct_scomprobante_tmp
where sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_comprobante >= 0
and sc_estado = 'I'
commit tran




/* VERIFICA SI DEBITOS Y CREDITOS COINCIDEN EN LOS ASIENTOS Y LAS CABECERAS */
begin tran
insert into cob_conta_tercero..ct_error_asientot
select sc_empresa, sc_producto, sc_fecha_tran, sc_comprobante, getdate(),
sc_tran_modulo, 0, 601056,
'TOTAL DEBITOS Y CREDITOS DESCUADRADOS/DETALLES DESCUADRAROS', sc_perfil,
sc_oficina_orig, sc_tot_debito
from cob_conta_tercero..ct_tmp_comprob,
cob_conta_tercero..ct_tmp_asientocon
where sc_empresa = sa_empresa
and sc_producto = sa_producto
and sc_fecha_tran = sa_fecha_tran
and sc_comprobante = sa_comprobante
and sc_empresa = @i_empresa
and sc_producto = @i_producto
and sa_empresa = @i_empresa
and sa_producto = @i_producto
and ((sa_tot_debito <> sc_tot_debito) or (sa_tot_credito <> sc_tot_credito) or (sc_detalles <> sa_detalles))
commit tran




begin tran
insert into cob_conta_tercero..ct_tmp_asientot
select sa_empresa,sa_producto,sa_fecha_tran,sa_comprobante,sc_detalles,
sc_tran_modulo,sc_perfil,sc_oficina_orig,count(1),
min(sa_asiento) ,max(sa_asiento)
from cob_conta_tercero..ct_scomprobante_tmp, --(index ct_scomprobante_tmp_Key),
cob_conta_tercero..ct_sasiento_tmp
where sc_empresa = @i_empresa
and sc_producto  = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
and sc_comprobante > 0
and sc_estado = 'I'
and sa_empresa = sc_empresa
and sa_producto = sc_producto
and sa_fecha_tran = sc_fecha_tran
and sa_comprobante = sc_comprobante
group by sa_empresa,sa_producto,sa_fecha_tran,sa_comprobante,sc_detalles,sc_tran_modulo,sc_perfil,sc_oficina_orig
having (sc_detalles <> count(1)) or (min(sa_asiento) <> 1) or (max(sa_asiento)<> sc_detalles)
commit tran



begin tran
insert into cob_conta_tercero..ct_error_asientot
select sa_empresa, sa_producto, sa_fecha_tran, sa_comprobante,getdate(),
sa_tran_modulo, 0, 1, 'EL SECUENCIAL DE LOS ASIENTOS ES INCORRECTO', sa_perfil,
sa_oficina_orig, 0
from cob_conta_tercero..ct_tmp_asientot
where sa_empresa = @i_empresa
and sa_producto = @i_producto
commit tran




begin tran
update cob_conta_tercero..ct_scomprobante_tmp set sc_error = 'S', sc_estado = 'E'
from cob_conta_tercero..ct_scomprobante_tmp, cob_conta_tercero..ct_error_asientot
where sc_empresa = ea_empresa
and sc_producto = ea_producto
and sc_fecha_tran = ea_fecha_conta
and sc_comprobante = ea_comprobante
and sc_empresa = @i_empresa
and sc_producto = @i_producto
and sc_fecha_tran between @w_fecha_min and @w_fecha_max
commit tran



begin tran
insert into cob_ccontable..cco_error_conaut (
ec_empresa,ec_producto,ec_fecha_conta,ec_secuencial,ec_fecha,
ec_tran_modulo,ec_asiento,ec_numerror,ec_mensaje,ec_perfil,
ec_oficina,ec_valor,ec_comprobante)
select ea_empresa,ea_producto,ea_fecha_conta,0, ea_fecha,
isnull(ea_tran_modulo,' '),ea_asiento,ea_numerror,ea_mensaje,ea_perfil,
ea_oficina,ea_valor,ea_comprobante
from cob_conta_tercero..ct_error_asientot
where ea_empresa = @i_empresa
and ea_producto = @i_producto
and ea_fecha_conta between @w_fecha_min and @w_fecha_max
and ea_comprobante >= 0
commit tran





-- PASO DE COMPROBANTES Y ASIENTOS DE TABLAS TEMPORALES A DEFINITIVAS
begin tran
insert into cob_conta_tercero..ct_sasiento
select B.*
from	cob_conta_tercero..ct_scomprobante_tmp,
	cob_conta_tercero..ct_sasiento_tmp B
where sc_empresa	= @i_empresa
and   sc_producto	= @i_producto
and   sc_fecha_tran	between @w_fecha_min and @w_fecha_max
and   sc_comprobante	> 0
and   sc_estado		<> 'E'
and   sa_empresa	= sc_empresa
and   sa_producto	= sc_producto
and   sa_fecha_tran	= sc_fecha_tran
and   sa_comprobante	= sc_comprobante
if @@error <> 0
begin
   rollback tran
   print 'Error en el paso de ASIENTOS temporales a definitivos'
   return 1
end
commit tran




begin tran
insert into cob_conta_tercero..ct_scomprobante (
sc_producto,                    sc_comprobante,                 sc_empresa,
sc_fecha_tran,                  sc_oficina_orig,                sc_area_orig,
sc_fecha_gra,                   sc_digitador,                   sc_descripcion,
sc_perfil,                      sc_detalles,                    sc_tot_debito,
sc_tot_credito,                 sc_tot_debito_me,               sc_tot_credito_me,
sc_automatico,                  sc_reversado,                   sc_estado,
sc_mayorizado,                  sc_observaciones,               sc_comp_definit,
sc_usuario_modulo,              sc_causa_error,                 sc_comp_origen,
sc_tran_modulo,                 sc_error )
select
sc_producto,                    sc_comprobante,                 sc_empresa,
sc_fecha_tran,                  sc_oficina_orig,                sc_area_orig,
sc_fecha_gra,                   sc_digitador,                   sc_descripcion,
sc_perfil,                      sc_detalles,                    sc_tot_debito,
sc_tot_credito,                 sc_tot_debito_me,               sc_tot_credito_me,
sc_automatico,                  sc_reversado,                   'B',
sc_mayorizado,                  sc_observaciones,               sc_comp_definit,
sc_usuario_modulo,              sc_causa_error,                 sc_comp_origen,
sc_tran_modulo,                 sc_error
from	cob_conta_tercero..ct_scomprobante_tmp
where sc_empresa	= @i_empresa
and   sc_producto	= @i_producto
and   sc_fecha_tran	between @w_fecha_min and @w_fecha_max
and   sc_comprobante	> 0
and   sc_estado		<> 'E'
if @@error <> 0
begin
   rollback tran
   print 'Error en el paso de COMPROBANTES temporales a definitivos'
   return 1
end
commit tran




begin tran
delete cob_conta_tercero..ct_sasiento_tmp
where sa_empresa = @i_empresa
and   sa_producto = @i_producto
and   sa_fecha_tran between @w_fecha_min and @w_fecha_max
and   sa_comprobante > 0
if @@error <> 0
begin
   rollback tran
   print 'Error en eliminación de asientos con ERROR'
   return 1
end
commit tran



begin tran
delete cob_conta_tercero..ct_scomprobante_tmp
where sc_empresa = @i_empresa
and   sc_producto = @i_producto
and   sc_fecha_tran between @w_fecha_min and @w_fecha_max
and   sc_comprobante > 0

if @@error <> 0
begin
   rollback tran
   print 'Error en eliminación de comprobantes con ERROR'
   return 1
end
commit tran

return 0
end



/******************* INSERTAR SIN VALIDACIONES *****************/
if @i_operacion = 'I' and @i_modo = 0
begin
	insert into cob_conta_tercero..ct_sasiento_tmp (
		sa_producto,sa_fecha_tran,sa_comprobante,sa_empresa,
		sa_asiento,sa_cuenta,sa_oficina_dest,sa_area_dest,
		sa_credito,sa_debito,sa_concepto,
		sa_credito_me,sa_debito_me,sa_cotizacion,
		sa_tipo_doc,sa_tipo_tran,sa_moneda,
		sa_opcion,sa_ente,sa_con_rete,sa_base,
		sa_valret,sa_con_iva,sa_valor_iva,
		sa_iva_retenido,sa_con_ica,sa_valor_ica,
		sa_con_timbre,sa_valor_timbre,sa_con_iva_reten,
		sa_con_ivapagado,sa_valor_ivapagado,
		sa_documento,sa_mayorizado,sa_con_dptales,sa_valor_dptales,
		sa_posicion,sa_debcred,sa_oper_banco,sa_cheque,
		sa_doc_banco,sa_fecha_est, sa_detalle, sa_error)
	values (@i_producto,@i_fecha_tran,@i_comprobante,@i_empresa,
		@i_asiento,@i_cuenta,@i_oficina_dest,@i_area_dest,
		@i_credito,@i_debito,@i_concepto,
		@i_credito_me,@i_debito_me,@i_cotizacion,
		@i_tipo_doc,@i_tipo_tran,@i_moneda,
		@i_opcion,@i_ente,@i_con_rete,@i_base,
		@i_valret,@i_con_iva,@i_valor_iva,
		@i_iva_retenido,@i_con_ica,@i_valor_ica,
		@i_con_timbre,@i_valor_timbre,@i_con_iva_reten,
		@i_con_ivapagado,@i_valor_ivapagado,
		@i_documento,@i_mayorizado,@i_con_dptales,@i_valor_dptales,
		@i_genera_posicion, @i_debcred,@i_oper_banco,@i_cheque,
		@i_doc_banco,@i_fecha_est,@i_detalle, 'N')
	if @@error <> 0
	begin	/* 'Error en insercion del detalle del comprobante en la tabla temporal' */
		return 603020
	end
	return 0
end




/****** INSERTAR CON VALIDACIONES PARA RECHAZOS (CONTABILIDAD ANTIGUA) ***********/
if @i_operacion = 'I' and @i_modo = 1
begin
	if @i_debcred = '1'
		select @w_valor = @i_debito
	else
		select @w_valor = @i_credito

	if not exists (select 1 from cob_conta..cb_empresa
			where em_empresa = @i_empresa)
	begin	/* 'EMPRESA ESPECIFICADA NO EXISTE' */
		while @@trancount > 0
		rollback tran
		begin tran
		delete cob_conta_tercero..ct_scomprobante
		where sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

		delete cob_conta_tercero..ct_sasiento
		where sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

		select @w_error = 'EMPRESA ESPECIFICADA NO EXISTE '
				+ convert(varchar(5),@i_empresa)
		select @o_desc_error = @w_error

		exec @w_return = cob_ccontable..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_fechahoy,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= @i_asiento,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 601018,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @w_valor,
		@i_oficina	= @i_oficina_dest,
		@i_comprobante	= @i_comprobante

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 601018
	end

	select @w_moneda_base = isnull(em_moneda_base,0)
	from cob_conta..cb_empresa where em_empresa = @i_empresa

	if exists (select 1 from cobis..cl_producto
			where pd_producto = @i_producto)
		goto ETIQUETA1
	else
	begin
		while @@trancount > 0
		rollback tran
		begin tran
		delete cob_conta_tercero..ct_scomprobante
		where sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

		delete cob_conta_tercero..ct_sasiento
		where sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

		select @w_error = 'CODIGO DE PRODUCTO NO EXISTE '
				+ convert(varchar(5), @i_producto)
		select @o_desc_error = @w_error

		exec @w_return = cob_ccontable..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_fechahoy,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= @i_asiento,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 151011,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @w_valor,
		@i_oficina	= @i_oficina_dest,
		@i_comprobante	= @i_comprobante

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 151011
	end

ETIQUETA1:
	if exists (select 1 from cob_conta..cb_producto
			where pr_empresa = @i_empresa
			and pr_producto = @i_producto
			and pr_estado   = 'V')
		goto ETIQUETA2
	else
	begin	/* 'REGISTRO NO EXISTE' */
		while @@trancount > 0
		rollback tran
		begin tran
		delete cob_conta_tercero..ct_scomprobante
		where sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

		delete cob_conta_tercero..ct_sasiento
		where sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

		select @w_error = 'CODIGO DE PRODUCTO NO EXISTE EN CONTABILIDAD '
				+ convert(varchar(5), @i_producto)
		select @o_desc_error = @w_error

		exec @w_return = cob_ccontable..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_fechahoy,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= @i_asiento,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 601168,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @w_valor,
		@i_oficina	= @i_oficina_dest,
		@i_comprobante	= @i_comprobante

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 601168
	end

ETIQUETA2:
	if exists (select 1 from cob_conta..cb_oficina where
			of_empresa = @i_empresa and
			of_oficina = @i_oficina_dest and
			of_movimiento = 'S' and
			of_estado = 'V')
		goto ETIQUETA3
	else
	begin	/* 'OFICINA NO EXISTE O NO ES DE MOVIMIENTO' */
		while @@trancount > 0
		rollback tran
		begin tran
		delete cob_conta_tercero..ct_scomprobante
		where sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

		delete cob_conta_tercero..ct_sasiento
		where sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

		select @w_error = 'OFICINA NO EXISTE O NO ES DE MOVIMIENTO '
				+ convert(varchar(10), @i_oficina_dest)
		select @o_desc_error = @w_error

		exec @w_return = cob_ccontable..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_fechahoy,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= @i_asiento,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 601131,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @w_valor,
		@i_oficina	= @i_oficina_dest,
		@i_comprobante	= @i_comprobante

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 601131
	end

ETIQUETA3:
	if exists (select 1 from cob_conta..cb_area where
			ar_empresa = @i_empresa and
			ar_area    = @i_area_dest and
			ar_movimiento = 'S' and
			ar_estado = 'V')
		goto ETIQUETA4
	else
	begin	/* 'AREA NO EXISTE O NO ES DE MOVIMIENTO' */
		while @@trancount > 0
		rollback tran
		begin tran
		delete cob_conta_tercero..ct_scomprobante
		where sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

		delete cob_conta_tercero..ct_sasiento
		where sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

		select @w_error = 'Area no Existe o no es de movimiento '
				+ convert(varchar(10), @i_area_dest)
		select @o_desc_error = @w_error

		exec @w_return = cob_ccontable..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_fechahoy,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= @i_asiento,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 601132,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @w_valor,
		@i_oficina	= @i_oficina_dest,
		@i_comprobante	= @i_comprobante

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 601132
	end

ETIQUETA4:
	if (@i_debito_me <> 0 or @i_credito_me <> 0) and (@i_cotizacion = 0)
	begin	/* 'COTIZACION CONSULTADA NO EXISTE' */
		while @@trancount > 0
		rollback tran
		begin tran
		delete cob_conta_tercero..ct_scomprobante
		where sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

		delete cob_conta_tercero..ct_sasiento
		where sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

		select @w_error = 'COMPROB. No. '
				+ convert(varchar(10),@i_comprobante)
				+ ' ,OF.DEST: '
				+ convert(varchar(8),@i_oficina_dest)
				+ ' ,AREA.DEST: '
				+ convert(varchar(8),@i_area_dest)
				+ ' ,CTA: '
				+ rtrim(@i_cuenta)
				+ ' ,SIN COTIZACION '
		select @o_desc_error = @w_error

		exec @w_return = cob_ccontable..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_fechahoy,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= @i_asiento,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 601064,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @w_valor,
		@i_oficina	= @i_oficina_dest,
		@i_comprobante	= @i_comprobante

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 601064
	end

	/* NO EXISTE LA CUENTA CONTABLE, NO ES DE MOVIMIENTO O NO ESTA VIGENTE */
	if exists (select 1 from cob_conta..cb_cuenta
			where cu_empresa = @i_empresa and
			cu_cuenta  = @i_cuenta and
			cu_movimiento = 'S' and
			cu_estado = 'V')
		goto ETIQUETA5
	else
	begin
		while @@trancount > 0
		rollback tran
		begin tran
		delete cob_conta_tercero..ct_scomprobante
		where sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

		delete cob_conta_tercero..ct_sasiento
		where sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

		select @w_error = 'LA CUENTA CONTABLE '
				+ rtrim(@i_cuenta)
				+ ' NO EXISTE,NO ES DE MOVIMIENTO'
				+ ' O NO ESTA VIGENTE'
		select @o_desc_error = @w_error

		exec @w_return = cob_ccontable..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_fechahoy,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= @i_asiento,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 601109,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @w_valor,
		@i_oficina	= @i_oficina_dest,
		@i_comprobante	= @i_comprobante

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 601109
	end

ETIQUETA5:
	/* VERIFICAR QUE LA MONEDA DE LA CUENTA CONTABLE CORRESPONDA */
	/* A LA MONEDA DEL VALOR MONETARIO A ASIGNAR.                */
	select @w_moneda = cu_moneda
	from cob_conta..cb_cuenta
	where   cu_empresa = @i_empresa and
		cu_cuenta  = @i_cuenta

	if @i_moneda != @w_moneda
	begin	/* 'LA MONEDA DE LA CUENTA CONTABLE NO CORRESPONDE' */
		while @@trancount > 0
		rollback tran
		begin tran
		delete cob_conta_tercero..ct_scomprobante
		where sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

		delete cob_conta_tercero..ct_sasiento
		where sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

		select @w_error = 'LA MONEDA DE LA CTA CONTABLE '
				+ rtrim(@i_cuenta)
				+ ' NO CORRESPONDE.'
		select @o_desc_error = @w_error

		exec @w_return = cob_ccontable..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_fechahoy,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= @i_asiento,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 607122,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @w_valor,
		@i_oficina	= @i_oficina_dest,
		@i_comprobante	= @i_comprobante

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 607122
	end

	if exists (select 1 from cob_conta..cb_plan_general
			where pg_empresa = @i_empresa and
			pg_oficina = @i_oficina_dest and
			pg_area = @i_area_dest and
			pg_cuenta = @i_cuenta)
		goto ETIQUETA6
	else
	begin	/* 'NO EXISTE LA CUENTA CONTABLE EN PLAN GENERAL DE CUENTAS' */
		while @@trancount > 0
		rollback tran
		begin tran
		delete cob_conta_tercero..ct_scomprobante
		where sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

		delete cob_conta_tercero..ct_sasiento
		where sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

		select @w_error = 'CUENTA CONTABLE '
				+ rtrim(@i_cuenta)
				+ ' NO ESTA RELACIONADA A OFICINA '
				+ convert(varchar(8),@i_oficina_dest)
				+ ' AREA '
				+ convert(varchar(8),@i_area_dest)
		select @o_desc_error = @w_error

		exec @w_return = cob_ccontable..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_fechahoy,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= @i_asiento,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 601109,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @w_valor,
		@i_oficina	= @i_oficina_dest,
		@i_comprobante	= @i_comprobante

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 601109
	end

ETIQUETA6:
	if (@i_moneda = @w_moneda_base and (@i_debito_me <> 0 or @i_credito_me <> 0)) or
	(@i_moneda <> @w_moneda_base and ((@i_debito = 0 or @i_debito_me = 0)
	and (@i_credito = 0 or @i_credito_me = 0)))
	begin
		while @@trancount > 0
		rollback tran
		begin tran
		delete cob_conta_tercero..ct_scomprobante
		where sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

		delete cob_conta_tercero..ct_sasiento
		where sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

		select @w_error = 'VALOR DE CUENTA: ' + rtrim(@i_cuenta)
				+ ' NO CORRESPONDEN CON TIPO DE MONEDA.'
				+ ' OFICINA: ' + convert(varchar(8),@i_oficina_dest)
				+ ' AREA: ' + convert(varchar(8),@i_area_dest)
		select @o_desc_error = @w_error

		exec @w_return = cob_ccontable..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_fechahoy,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= @i_asiento,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 607122,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @w_valor,
		@i_oficina	= @i_oficina_dest,
		@i_comprobante	= @i_comprobante

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 607122
	end

/*       if (@i_tipo_doc != 'N' and @i_moneda = @w_moneda_base) and
          ((@i_tipo_doc =  'C' and @i_debcred != '1') or
          (@i_tipo_doc =  'V' and @i_debcred != '2'))
*/

if @i_genera_posicion = 'S'
begin
	if @i_moneda = @w_moneda_base and @i_tipo_doc != 'N'
	begin	/* ASIENTOS DE COMPRA O VENTA SOLO AFECTAN A CTAS M.E */
		while @@trancount > 0
		rollback tran
		begin tran
		delete cob_conta_tercero..ct_scomprobante
		where sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

		delete cob_conta_tercero..ct_sasiento
		where sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

		select @w_error = 'ASIENTOS DE COMPRA O VTA.'
				+ 'SOLO AFECTAN A CTAS. EN M.E.'
		select @o_desc_error = @w_error

		exec @w_return = cob_ccontable..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_fechahoy,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= @i_asiento,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 601504,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @w_valor,
		@i_oficina	= @i_oficina_dest,
		@i_comprobante	= @i_comprobante

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 601504
	end


	if @i_moneda != @w_moneda_base and @i_debcred = '1' and @i_tipo_doc != 'C'
	begin	/* ASIENTOS DE COMPRA O VENTA SOLO AFECTAN A CTAS M.E */
		while @@trancount > 0
		rollback tran
		begin tran
		delete cob_conta_tercero..ct_scomprobante
		where sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

		delete cob_conta_tercero..ct_sasiento
		where sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

		select @w_error = 'ASIENTOS DEBITOS ME SON COMPRA DE DIVISAS'
		select @o_desc_error = @w_error

		exec @w_return = cob_ccontable..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_fechahoy,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= @i_asiento,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 601504,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @w_valor,
		@i_oficina	= @i_oficina_dest,
		@i_comprobante	= @i_comprobante

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 601504
	end


	if @i_moneda != @w_moneda_base and @i_debcred = '2' and @i_tipo_doc != 'V'
	begin	/* Asientos de Compra o Venta solo afectan a ctas M.E */
		while @@trancount > 0
		rollback tran
		begin tran
		delete cob_conta_tercero..ct_scomprobante
		where sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

		delete cob_conta_tercero..ct_sasiento
		where sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

		select @w_error = 'ASIENTOS CREDITOS ME SON VENTA DE DIVISAS'
		select @o_desc_error = @w_error

		exec @w_return = cob_ccontable..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_fechahoy,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= @i_asiento,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 601504,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @w_valor,
		@i_oficina	= @i_oficina_dest,
		@i_comprobante	= @i_comprobante

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 601504
	end
end
else
begin
	if @i_tipo_doc != 'N'
	begin
		while @@trancount > 0
		rollback tran
		begin tran
		delete cob_conta_tercero..ct_scomprobante
		where sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

		delete cob_conta_tercero..ct_sasiento
		where sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

		select @w_error = '@i_tipo_doc PARA MOVIMIENTOS QUE NO GENEREN POSICION DEBE SER N'
		select @o_desc_error = @w_error

		exec @w_return = cob_ccontable..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_fechahoy,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= @i_asiento,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 1,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @w_valor,
		@i_oficina	= @i_oficina_dest,
		@i_comprobante	= @i_comprobante

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 1
	end
end

	select  @w_sum_debito_me  = sum(isnull(sa_debito_me,0)),
		@w_sum_credito_me = sum(isnull(sa_credito_me,0))
	from cob_conta_tercero..ct_sasiento
	where sa_empresa = @i_empresa and
		sa_producto = @i_producto and
		sa_fecha_tran = @i_fecha_tran and
		sa_comprobante = @i_comprobante and
		sa_asiento > 0

	if @w_sum_debito_me <> @w_sum_credito_me
	begin
		if exists (select sa_tipo_doc from cob_conta_tercero..ct_sasiento
				where sa_empresa = @i_empresa and
				sa_producto = @i_producto and
				sa_fecha_tran = @i_fecha_tran and
				sa_comprobante = @i_comprobante and
				sa_asiento > 0 and
				sa_tipo_doc in ('C','V'))
			goto ETIQUETA7
		else
		begin	/* 'NO EXISTEN DOCTOS. DE COMPRA O VENTA PARA CUADRAR LA M.E.' */
			while @@trancount > 0
			rollback tran
			begin tran
			delete cob_conta_tercero..ct_scomprobante
			where sc_empresa = @i_empresa and
				sc_producto = @i_producto and
				sc_fecha_tran = @i_fecha_tran and
				sc_comprobante = @i_comprobante

			delete cob_conta_tercero..ct_sasiento
			where sa_empresa = @i_empresa and
				sa_producto = @i_producto and
				sa_fecha_tran = @i_fecha_tran and
				sa_comprobante = @i_comprobante and
				sa_asiento > 0

			select @w_error = 'NO EXISTEN DOCTOS. DE COMPRA O '
					+ ' VENTA PARA CUADRAR LA M.E.'
			select @o_desc_error = @w_error

			exec @w_return = cob_ccontable..sp_errorcconta
			@t_trn		= 60011,
			@i_operacion	= 'I',
			@i_empresa	= @i_empresa,
			@i_fecha	= @w_fechahoy,
			@i_producto	= @i_producto,
			@i_tran_modulo	= @i_tran_modulo,
			@i_asiento	= @i_asiento,
			@i_fecha_conta	= @i_fecha_tran,
			@i_numerror	= 601504,
			@i_mensaje	= @w_error,
			@i_perfil	= @i_perfil,
			@i_valor	= @w_valor,
			@i_oficina	= @i_oficina_dest,
			@i_comprobante	= @i_comprobante

			if @w_return <> 0
			begin
				return @w_return
			end
			commit tran
			while @w_count > 0
			begin
				select @w_count = @w_count -1
				begin tran
			end
			return 601504
		end
	end

ETIQUETA7:
	select	@w_debito    = 0, @w_credito    = 0,
		@w_debito_me = 0, @w_credito_me = 0

	if @i_debcred = '1'
	begin
		select	@w_debito    = isnull(@i_debito,0),
			@w_debito_me = isnull(@i_debito_me,0)
		if @i_moneda != @w_moneda_base and @i_debito_me != 0
		select @i_cotizacion = round((@i_debito / @i_debito_me),2)
		else select @i_cotizacion = 0
	end
	else
	begin
		select	@w_credito   = isnull(@i_credito,0),
			@w_credito_me = isnull(@i_credito_me,0)
		if @i_moneda != @w_moneda_base and @i_credito_me != 0
		select @i_cotizacion = round((@i_credito / @i_credito_me),2)
		else select @i_cotizacion = 0
	end

	select 	@w_proceso = cp_proceso,
		@w_condicion = cp_condicion
	from cob_conta..cb_cuenta_proceso
	where cp_empresa = @i_empresa
	and   cp_proceso in (6003,6095)
	and   @i_cuenta like rtrim(cp_cuenta) + '%'

	if @@rowcount > 0
	begin
		if @i_ente is null
		begin
			while @@trancount > 0
			rollback tran
			begin tran
			delete cob_conta_tercero..ct_scomprobante
			where sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

			delete cob_conta_tercero..ct_sasiento
			where sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

			select @w_error = 'CUENTA DE TERCERO Y NO VIENE CODIGO DEL ENTE. CUENTA '  + @i_cuenta
			select @o_desc_error = @w_error

			exec @w_return = cob_ccontable..sp_errorcconta
			@t_trn		= 60011,
			@i_operacion	= 'I',
			@i_empresa	= @i_empresa,
			@i_fecha	= @w_fechahoy,
			@i_producto	= @i_producto,
			@i_tran_modulo	= @i_tran_modulo,
			@i_asiento	= @i_asiento,
			@i_fecha_conta	= @i_fecha_tran,
			@i_numerror	= 601069,
			@i_mensaje	= @w_error,
			@i_perfil	= @i_perfil,
			@i_valor	= @w_valor,
			@i_oficina	= @i_oficina_dest,
			@i_comprobante	= @i_comprobante

			if @w_return <> 0
			begin
				return @w_return
			end
			commit tran
			while @w_count > 0
			begin
				select @w_count = @w_count -1
				begin tran
			end
			return 601069
		end

		if exists (select 1 from cobis..cl_ente
				where en_ente = @i_ente )
			goto ETIQUETA8
		else
		begin
			while @@trancount > 0
			rollback tran
			begin tran
			delete cob_conta_tercero..ct_scomprobante
			where sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

			delete cob_conta_tercero..ct_sasiento
			where sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

			select @w_error = 'CODIGO DE ENTE INVALIDO '
			select @o_desc_error = @w_error

			exec @w_return = cob_ccontable..sp_errorcconta
			@t_trn		= 60011,
			@i_operacion	= 'I',
			@i_empresa	= @i_empresa,
			@i_fecha	= @w_fechahoy,
			@i_producto	= @i_producto,
			@i_tran_modulo	= @i_tran_modulo,
			@i_asiento	= @i_asiento,
			@i_fecha_conta	= @i_fecha_tran,
			@i_numerror	= 609134,
			@i_mensaje	= @w_error,
			@i_perfil	= @i_perfil,
			@i_valor	= @w_valor,
			@i_oficina	= @i_oficina_dest,
			@i_comprobante	= @i_comprobante

			if @w_return <> 0
			begin
				return @w_return
			end
			commit tran
			while @w_count > 0
			begin
				select @w_count = @w_count -1
				begin tran
			end
			return 609134
		end

ETIQUETA8:
		if @w_condicion is null
			select @i_documento = null
		else
			if @i_documento is null
			begin
				while @@trancount > 0
				rollback tran
				begin tran
				delete cob_conta_tercero..ct_scomprobante
				where sc_empresa = @i_empresa and
				sc_producto = @i_producto and
				sc_fecha_tran = @i_fecha_tran and
				sc_comprobante = @i_comprobante

				delete cob_conta_tercero..ct_sasiento
				where sa_empresa = @i_empresa and
				sa_producto = @i_producto and
				sa_fecha_tran = @i_fecha_tran and
				sa_comprobante = @i_comprobante and
				sa_asiento > 0

				select @w_error = 'CUENTA EXIGE NUMERO DE DOCUMENTO. CUENTA '  + @i_cuenta
				select @o_desc_error = @w_error

				exec @w_return = cob_ccontable..sp_errorcconta
				@t_trn		= 60011,
				@i_operacion	= 'I',
				@i_empresa	= @i_empresa,
				@i_fecha	= @w_fechahoy,
				@i_producto	= @i_producto,
				@i_tran_modulo	= @i_tran_modulo,
				@i_asiento	= @i_asiento,
				@i_fecha_conta	= @i_fecha_tran,
				@i_numerror	= 1,
				@i_mensaje	= @w_error,
				@i_perfil	= @i_perfil,
				@i_valor	= @w_valor,
				@i_oficina	= @i_oficina_dest,
				@i_comprobante	= @i_comprobante

				if @w_return <> 0
				begin
					return @w_return
				end
				commit tran
				while @w_count > 0
				begin
					select @w_count = @w_count -1
					begin tran
				end
				return 1
			end

		if @w_proceso = 6095 and @i_base is null
		begin
			while @@trancount > 0
			rollback tran
			begin tran
			delete cob_conta_tercero..ct_scomprobante
			where sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

			delete cob_conta_tercero..ct_sasiento
			where sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

			select @w_error = 'CUENTA EXIGE BASE DE IMPUESTO. CUENTA ' + @i_cuenta
			select @o_desc_error = @w_error

			exec @w_return = cob_ccontable..sp_errorcconta
			@t_trn		= 60011,
			@i_operacion	= 'I',
			@i_empresa	= @i_empresa,
			@i_fecha	= @w_fechahoy,
			@i_producto	= @i_producto,
			@i_tran_modulo	= @i_tran_modulo,
			@i_asiento	= @i_asiento,
			@i_fecha_conta	= @i_fecha_tran,
			@i_numerror	= 601505,
			@i_mensaje	= @w_error,
			@i_perfil	= @i_perfil,
			@i_valor	= @w_valor,
			@i_oficina	= @i_oficina_dest,
			@i_comprobante	= @i_comprobante

			if @w_return <> 0
			begin
				return @w_return
			end
			commit tran
			while @w_count > 0
			begin
				select @w_count = @w_count -1
				begin tran
			end
			return 601505
		end

		if @w_proceso = 6095
			if (@w_condicion = 'R' and (@i_con_rete is null or @i_valret is null)) or
			(@w_condicion = 'I' and (@i_con_iva is null or @i_valor_iva is null)) or
			(@w_condicion = 'C' and (@i_con_ica is null or @i_valor_ica is null)) or
			(@w_condicion = 'T' and (@i_con_timbre is null or @i_valor_timbre is null)) or
			(@w_condicion = 'P' and (@i_con_ivapagado is null or @i_valor_ivapagado is null))
			begin
				while @@trancount > 0
				rollback tran
				begin tran
				delete cob_conta_tercero..ct_scomprobante
				where sc_empresa = @i_empresa and
				sc_producto = @i_producto and
				sc_fecha_tran = @i_fecha_tran and
				sc_comprobante = @i_comprobante

				delete cob_conta_tercero..ct_sasiento
				where sa_empresa = @i_empresa and
				sa_producto = @i_producto and
				sa_fecha_tran = @i_fecha_tran and
				sa_comprobante = @i_comprobante and
				sa_asiento > 0

				select @w_error = 'FALTAN DATOS DEL IMPUESTO CUENTA ' + @i_cuenta
				select @o_desc_error = @w_error

				exec @w_return = cob_ccontable..sp_errorcconta
				@t_trn		= 60011,
				@i_operacion	= 'I',
				@i_empresa	= @i_empresa,
				@i_fecha	= @w_fechahoy,
				@i_producto	= @i_producto,
				@i_tran_modulo	= @i_tran_modulo,
				@i_asiento	= @i_asiento,
				@i_fecha_conta	= @i_fecha_tran,
				@i_numerror	= 601505,
				@i_mensaje	= @w_error,
				@i_perfil	= @i_perfil,
				@i_valor	= @w_valor,
				@i_oficina	= @i_oficina_dest,
				@i_comprobante	= @i_comprobante

				if @w_return <> 0
				begin
					return @w_return
				end
				commit tran
				while @w_count > 0
				begin
					select @w_count = @w_count -1
					begin tran
				end
				return 601505
			end

		if @w_proceso = 6003
		begin
			select	@i_con_rete		= null,
				@i_base			= null,
				@i_valret		= null,
				@i_con_iva		= null,
				@i_valor_iva		= null,
				@i_iva_retenido		= null,
				@i_con_ica		= null,
				@i_valor_ica		= null,
				@i_con_timbre		= null,
				@i_valor_timbre		= null,
				@i_con_iva_reten	= null,
				@i_codigo_regimen	= null,
				@i_con_ivapagado	= null,
				@i_valor_ivapagado	= null
		end
	end
	else
	begin
		select	@i_ente			= null,
			@i_con_rete		= null,
			@i_base			= null,
			@i_valret		= null,
			@i_con_iva		= null,
			@i_valor_iva		= null,
			@i_iva_retenido		= null,
			@i_con_ica		= null,
			@i_valor_ica		= null,
			@i_con_timbre		= null,
			@i_valor_timbre		= null,
			@i_con_iva_reten	= null,
			@i_codigo_regimen	= null,
			@i_con_ivapagado	= null,
			@i_valor_ivapagado	= null,
			@i_documento		= null
	end

begin tran
	select @i_asiento = null
	select @i_asiento = max(sa_asiento) + 1
	from cob_conta_tercero..ct_sasiento
	where	sa_empresa = @i_empresa
		and sa_producto = @i_producto
		and sa_fecha_tran = @i_fecha_tran
		and sa_comprobante = @i_comprobante
		and sa_asiento > 0

	if @i_asiento is null select @i_asiento = 1
	insert into cob_conta_tercero..ct_sasiento(
		sa_producto,sa_fecha_tran,sa_comprobante,sa_empresa,
		sa_asiento,sa_cuenta,sa_oficina_dest,sa_area_dest,
		sa_credito,sa_debito,sa_concepto,
		sa_credito_me,sa_debito_me,sa_cotizacion,
		sa_tipo_doc,sa_tipo_tran,sa_moneda,
		sa_opcion,sa_ente,sa_con_rete,sa_base,
		sa_valret,sa_con_iva,sa_valor_iva,
		sa_iva_retenido,sa_con_ica,sa_valor_ica,
		sa_con_timbre,sa_valor_timbre,sa_con_iva_reten,
		sa_con_ivapagado,sa_valor_ivapagado,
		sa_documento,sa_mayorizado)
	values (@i_producto,@i_fecha_tran,@i_comprobante,@i_empresa,
		@i_asiento,@i_cuenta,@i_oficina_dest,@i_area_dest,
		@w_credito,@w_debito,@i_concepto,
		@w_credito_me,@w_debito_me,@i_cotizacion,
		@i_tipo_doc,@i_tipo_tran,@w_moneda,
		@i_opcion,@i_ente,@i_con_rete,@i_base,
		@i_valret,@i_con_iva,@i_valor_iva,
		@i_iva_retenido,@i_con_ica,@i_valor_ica,
		@i_con_timbre,@i_valor_timbre,@i_con_iva_reten,
		@i_con_ivapagado,@i_valor_ivapagado,
		@i_documento,@i_mayorizado)
	if @@error <> 0
	begin	/* 'Error en insercion del detalle del comprobante en la tabla temporal' */
		while @@trancount > 0
		rollback tran
		begin tran
		delete cob_conta_tercero..ct_sasiento
		where   sa_empresa = @i_empresa and
			sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
			sa_asiento > 0

		delete cob_conta_tercero..ct_scomprobante
		where 	sc_empresa = @i_empresa and
			sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante

		select @w_error = 'ERROR EN INSERCION DEL DETALLE DEL COMPROBANTE EN LA TABLA TEMPORAL'
		select @o_desc_error = @w_error

		exec @w_return = cob_ccontable..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_fechahoy,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= @i_asiento,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 603020,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @w_valor,
		@i_oficina	= @i_oficina_dest,
		@i_comprobante	= @i_comprobante

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 603020
	end
	else
	begin
		select @w_banco = ba_banco, @w_ctacte = ba_ctacte
		from   cob_conta..cb_banco
		where  ba_empresa     =  @i_empresa
		and    ba_cuenta      =  @i_cuenta
		if @@rowcount > 0     /* si la cuenta se encuentra relacionada en cb_banco */
		begin
			if @i_debcred = '1'
				select @w_valor = @i_debito
			else
				select @w_valor = @i_credito

			if @i_oper_banco is not null and @i_cheque is not null
			begin
				insert into cob_conta_tercero..ct_conciliacion
					(cl_producto,cl_comprobante,cl_empresa,
					cl_fecha_tran,cl_asiento,cl_cuenta,
					cl_oficina_dest,cl_area_dest,cl_debcred,
					cl_valor,cl_oper_banco,cl_doc_banco,
					cl_banco,cl_fecha_est,cl_cuenta_cte,
					cl_detalle,cl_relacionado,cl_cheque)
				values
					(@i_producto,@i_comprobante,@i_empresa,
					@i_fecha_tran,@i_asiento,@i_cuenta,
					@i_oficina_dest,@i_area_dest,@i_debcred,
					@w_valor,@i_oper_banco,@i_doc_banco,
					@w_banco,@i_fecha_est,@w_ctacte,
					@i_detalle,'N',@i_cheque)
				if @@error <> 0
				begin	/* 'Error en insercion de registro en ct_conciliacion' */
					while @@trancount > 0
					rollback tran
					begin tran
					delete cob_conta_tercero..ct_sasiento
					where sa_empresa = @i_empresa and
						sa_producto = @i_producto and
						sa_fecha_tran = @i_fecha_tran and
						sa_comprobante = @i_comprobante and
						sa_asiento > 0

					delete cob_conta_tercero..ct_scomprobante
					where sc_empresa = @i_empresa and
						sc_producto = @i_producto and
						sc_fecha_tran = @i_fecha_tran and
						sc_comprobante = @i_comprobante

					delete cob_conta_tercero..ct_conciliacion
					where cl_empresa = @i_empresa and
						cl_comprobante = @i_comprobante and
						cl_asiento > 0 and
						cl_fecha_tran = @i_fecha_tran and
						cl_producto = @i_producto

					select @w_error = 'ERROR EN INSERCION DE REGISTRO EN CT_CONCILIACION'
					select @o_desc_error = @w_error

					exec @w_return = cob_ccontable..sp_errorcconta
					@t_trn		= 60011,
					@i_operacion	= 'I',
					@i_empresa	= @i_empresa,
					@i_fecha	= @w_fechahoy,
					@i_producto	= @i_producto,
					@i_tran_modulo	= @i_tran_modulo,
					@i_asiento	= @i_asiento,
					@i_fecha_conta	= @i_fecha_tran,
					@i_numerror	= 603060,
					@i_mensaje	= @w_error,
					@i_perfil	= @i_perfil,
					@i_valor	= @w_valor,
					@i_oficina	= @i_oficina_dest,
					@i_comprobante	= @i_comprobante

					if @w_return <> 0
					begin
						return @w_return
					end
					commit tran
					while @w_count > 0
					begin
						select @w_count = @w_count -1
						begin tran
					end
					return 603060
				end
			end
			else
			begin	/*   @i_oper_banco y/o @i_doc_banco vienen en null */
				while @@trancount > 0
				rollback tran
				begin tran
				delete cob_conta_tercero..ct_sasiento
				where sa_empresa = @i_empresa and
					sa_producto = @i_producto and
					sa_fecha_tran = @i_fecha_tran and
					sa_comprobante = @i_comprobante and
					sa_asiento > 0

				delete cob_conta_tercero..ct_scomprobante
				where sc_empresa = @i_empresa and
					sc_producto = @i_producto and
					sc_fecha_tran = @i_fecha_tran and
					sc_comprobante = @i_comprobante

				delete cob_conta_tercero..ct_conciliacion
				where cl_empresa = @i_empresa and
					cl_comprobante = @i_comprobante and
					cl_asiento > 0 and
					cl_fecha_tran = @i_fecha_tran and
					cl_producto = @i_producto

				select @w_error = 'CAMPOS NO NULOS CON VALORES NULL @i_oper_banco Y/O @i_cheque'
				select @o_desc_error = @w_error

				exec @w_return = cob_ccontable..sp_errorcconta
				@t_trn		= 60011,
				@i_operacion	= 'I',
				@i_empresa	= @i_empresa,
				@i_fecha	= @w_fechahoy,
				@i_producto	= @i_producto,
				@i_tran_modulo	= @i_tran_modulo,
				@i_asiento	= @i_asiento,
				@i_fecha_conta	= @i_fecha_tran,
				@i_numerror	= 601001,
				@i_mensaje	= @w_error,
				@i_perfil	= @i_perfil,
				@i_valor	= @w_valor,
				@i_oficina	= @i_oficina_dest,
				@i_comprobante	= @i_comprobante

				if @w_return <> 0
				begin
					return @w_return
				end
				commit tran
				while @w_count > 0
				begin
					select @w_count = @w_count -1
					begin tran
				end
				return 601001
			end
		end
	end
commit tran
return 0
end


return 0

go

