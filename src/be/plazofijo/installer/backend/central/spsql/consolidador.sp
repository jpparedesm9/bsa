/*****************************************************************************/
/*  ARCHIVO:         consolidador.sp                                         */
/*  NOMBRE LOGICO:   sp_consolidador                                         */
/*  PRODUCTO:        Depositos a Plazo Fijo                                  */
/*****************************************************************************/
/*                            IMPORTANTE                                     */
/* Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp */
/* Su uso no autorizado queda  expresamente  prohibido asi como cualquier    */
/* alteracion o agregado hecho  por alguno de sus usuarios sin el debido     */
/* consentimiento por escrito de COBISCorp. Este programa esta protegido por */
/* la ley de derechos de autor y por las convenciones internacionales de     */
/* propiedad intelectual.  Su uso  no  autorizado dara derecho a COBISCORP   */
/* para obtener ordenes  de secuestro o  retencion  y  para  perseguir       */
/* penalmente a  los autores de cualquier infraccion.                        */
/*****************************************************************************/
/*                               PROPOSITO                                   */
/* Ingresar informacion a las tablas de REC.                                 */
/*****************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where type = 'P' and name = 'sp_consolidador')
   drop proc sp_consolidador
go

create proc sp_consolidador
with encryption
as
declare
@w_error                int,
@w_msg                  descripcion,
@w_fecha_proc           datetime,
@w_fecha_ini            datetime,
@w_ciudad               int,
@w_sig_habil            datetime,
@w_fin_mes              char(1)

select @w_fin_mes = 'N'

-- CIUDAD DE FERIADOS 
select @w_ciudad = pa_int
from cobis..cl_parametro
where pa_nemonico = 'CIUN'
and   pa_producto = 'ADM'


/* TRAER LA FECHA DE PROCESO DEL SISTEMA PARA EL MODULO */
select
@w_fecha_proc    = fc_fecha_cierre,
@w_fecha_ini     = dateadd(dd,1-datepart(dd,fc_fecha_cierre), fc_fecha_cierre)
from  cobis..ba_fecha_cierre
where fc_producto = 14

create table #cotizacion(
moneda     tinyint,
valor      money)

select 
ct_moneda     as uc_moneda, 
max(ct_fecha) as uc_fecha
into  #ult_cotiz
from  cob_conta..cb_cotizacion
where ct_fecha <=  @w_fecha_proc
group by ct_moneda

insert into #cotizacion
select ct_moneda, ct_valor
from   cob_conta..cb_cotizacion, #ult_cotiz
where  ct_moneda = uc_moneda
and    ct_fecha  = uc_fecha


/* ENTRAR BORRANDO TODA LA INFORMACION GENERADA POR PFIJO EN COB_EXTERNOS */
delete cob_externos..ex_dato_pasivas
where dp_aplicativo = 14

if @@error <> 0 begin
   select
   @w_error = 147000,
   @w_msg = 'Error al eliminar registros cob_externos..ex_dato_pasivas'
   goto ERROR
end

delete cob_externos..ex_dato_transaccion
where dt_aplicativo = 14

if @@error <> 0 begin
   select
   @w_error = 147000,
   @w_msg = 'Error al eliminar registros cob_externos..ex_dato_transaccion'
   goto ERROR
end

delete cob_externos..ex_dato_transaccion_det
where dd_aplicativo = 14

if @@error <> 0 begin
   select
   @w_error = 147000,
   @w_msg = 'Error al eliminar registros cob_externos..ex_dato_transaccion_det'
   goto ERROR
end

delete cob_externos..ex_dato_cuota_pry
where dc_aplicativo = 14

if @@error <> 0 begin
   select
   @w_error = 147000,
   @w_msg = 'Error al eliminar registros cob_externos..ex_dato_cuota_pry'
   goto ERROR
end

delete cob_externos..ex_dato_rubro_pry
where dr_aplicativo = 14

if @@error <> 0 begin
   select
   @w_error = 147000,
   @w_msg = 'Error al eliminar registros cob_externos..ex_dato_rubro_pry'
   goto ERROR
end


delete cob_externos..ex_dato_deudores
where de_aplicativo = 14

if @@error <> 0 begin
   select
   @w_error = 147000,
   @w_msg = 'Error al eliminar registros cob_externos..ex_dato_rubro_pry'
   goto ERROR
end





select
pf_fecha              = @w_fecha_proc,
pf_operacion          = op_operacion,
pf_banco              = convert(varchar(24),op_num_banco),
pf_toperacion         = convert(varchar(10),op_toperacion),
pf_fpago              = op_fpago,
pf_aplicativo         = convert(tinyint,14),
pf_ente               = op_ente,
pf_categoria          = (select eq_val_interfaz from pf_equivalencias where eq_tabla = 'CATPRODUCT' and op_num_dias between convert(int, eq_val_pfi_ini) and convert(int, eq_val_pfi_fin)),
pf_naturaleza_cli     = convert(varchar, null),
pf_documento_tipo     = convert(varchar, null),
pf_documento_nume     = convert(varchar, null),
pf_oficina            = convert(int, op_oficina),
pf_oficial            = convert(int, 0),
pf_usuario            = op_oficial_principal,
pf_moneda             = op_moneda,
pf_monto              = op_monto,
pf_interes            = isnull(op_total_int_ganados, 0) - isnull(op_total_int_pagados, 0),
pf_tasa               = case when op_tasa_efectiva = 0 then op_tasa else op_tasa_efectiva end,
pf_modalidad          = case op_fpago when 'ANT' then 'A' else 'V' end,
pf_plazo_dias         = op_num_dias,
pf_fecha_ape          = case when datediff(dd,op_fecha_valor, op_fecha_ingreso) >= 0 then op_fecha_ingreso else  op_fecha_valor  end,
pf_fecha_radicacion   = op_fecha_ingreso,
pf_fecha_ven          = op_fecha_ven,
pf_num_renovaciones   = op_renovaciones,
pf_estado             = op_estado,
pf_razon_cancelacion  = convert(varchar,null),
pf_num_cuotas         = 1,
pf_ppago              = op_ppago,
pf_periodicidad_cuota = case op_fpago when 'VEN' then op_num_dias else convert(int,null) end,
pf_total_int_estimado = op_total_int_estimado,
pf_fecha_cancela      = op_fecha_cancela,
-- 
pf_tasa_variable      = op_tasa_variable,
pf_referencial_tasa   = op_mnemonico_tasa,
pf_puntos_tasa_ref    = CASE WHEN   op_tasa_variable = 'S' 
                        then (select top 1 hv_spread_vigente from cob_pfijo..pf_hist_tasa_variable
                              where  hv_tipo_monto =  op_tipo_monto   -- 'M6'          
                              and    hv_tipo_plazo =  op_tipo_plazo   -- 'P14'        
                              and    hv_fecha_crea <= op_fecha_valor  -- '06/24/2011'
                              order by hv_fecha_crea DESC  )
                         else
                              0
                         end,
pf_signo_tasa_ref     =  CASE WHEN   op_tasa_variable = 'S' 
                         then (select top 1 hv_operador from cob_pfijo..pf_hist_tasa_variable
                              where  hv_tipo_monto =  op_tipo_monto   -- 'M6'          
                              and    hv_tipo_plazo =  op_tipo_plazo   -- 'P14'        
                              and    hv_fecha_crea <= op_fecha_valor  -- '06/24/2011'
                              order by hv_fecha_crea DESC  )
                         --else
                         --     '+'
                         end,
pf_signo_spread       = CASE WHEN   op_tasa_variable = 'S'   then pf_operacion.op_operador end,
pf_spread             = CASE WHEN   op_tasa_variable = 'S'   then isnull(pf_operacion.op_spread, 0)  end,
                     
pf_signo_puntos       = CASE WHEN   op_tasa_variable = 'S'   then pf_operacion.op_operador end,
pf_puntos             = CASE WHEN   op_tasa_variable = 'S'   then isnull(pf_operacion.op_puntos, 0) end
  
into  #pf_operaciones
from  pf_operacion
where op_estado in ('ACT', 'VEN')
or    (op_estado = 'CAN' and op_fecha_cancela between @w_fecha_ini and @w_fecha_proc   )

update #pf_operaciones set
pf_naturaleza_cli     = case c_tipo_compania when 'OF' then 'O' else 'P' end,
pf_documento_tipo     = en_tipo_ced,
pf_documento_nume     = en_ced_ruc
from cobis..cl_ente
where en_ente = pf_ente

update #pf_operaciones set
pf_periodicidad_cuota = pp_factor_dias
from  pf_ppago
where pf_fpago  = 'PER'
and   pf_ppago  = pp_codigo
and   pp_estado = 'A'

update #pf_operaciones set
pf_oficial = oc_oficial
from   cobis..cl_funcionario, cobis..cc_oficial
where  oc_funcionario = fu_funcionario
and    fu_login       = pf_usuario

select
ope  = pf_operacion,
numc = max(cu_cuota)
into  #cuotas
from  pf_cuotas, #pf_operaciones
where cu_operacion = pf_operacion
and   pf_fpago     = 'PER'
group by pf_operacion

update #pf_operaciones set
pf_num_cuotas = numc
from  #cuotas
where pf_operacion = ope

insert into cob_externos..ex_dato_pasivas(
dp_fecha,              dp_banco,              dp_toperacion,
dp_aplicativo,         dp_categoria_producto, dp_naturaleza_cliente,
dp_cliente,            dp_documento_tipo,     dp_documento_numero,
dp_oficina,            dp_oficial,            dp_moneda,
dp_monto,              dp_tasa,               dp_modalidad,
dp_plazo_dias,         dp_fecha_apertura,     dp_fecha_vencimiento,
dp_num_renovaciones,   dp_estado,            
dp_razon_cancelacion,  dp_num_cuotas,         dp_periodicidad_cuota,
dp_saldo_disponible,   dp_saldo_camara12h,    dp_saldo_camara24h,
dp_saldo_camara48h,    dp_saldo_remesas,      dp_saldo_int,
dp_fecha_radicacion,   dp_tasa_variable,      dp_referencial_tasa,
dp_puntos_tasa_ref,    dp_signo_tasa_ref,     dp_signo_spread,
dp_spread,             dp_signo_puntos,       dp_puntos )

select
pf_fecha,              pf_banco,              pf_toperacion,
pf_aplicativo,         pf_categoria,          pf_naturaleza_cli,
pf_ente,               pf_documento_tipo,     pf_documento_nume,
pf_oficina,            pf_oficial,            pf_moneda,
pf_monto,              pf_tasa,               pf_modalidad,
pf_plazo_dias,         pf_fecha_ape,          case when pf_estado = 'CAN' then pf_fecha_cancela else pf_fecha_ven end,
pf_num_renovaciones,   (select eq_val_interfaz from pf_equivalencias where eq_tabla = 'TIPESTPRY' and eq_val_pfijo = pf_estado),
pf_razon_cancelacion,  pf_num_cuotas,         pf_periodicidad_cuota,
0,                     0,                     0,
0,                     0,                     pf_interes,
pf_fecha_radicacion,   pf_tasa_variable,      pf_referencial_tasa,
pf_puntos_tasa_ref,    pf_signo_tasa_ref,     pf_signo_spread,
pf_spread,             pf_signo_puntos,       pf_puntos        
from #pf_operaciones

if @@error <> 0 begin
   select
   @w_error = 143003,
   @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_pasivas'
   goto ERROR
end

select
tr_banco         = tr_banco,
tr_operacion     = tr_operacion,
tr_secuencial    = tr_secuencial,     
tr_toperacion    = op_toperacion,     
tr_fecha_mov     = tr_fecha_mov,
tr_tipo_trans    = tp_trn_rec,
tr_naturaleza    = case when tr_tipo_trn = 'APE' or tr_tipo_trn = 'REN' then 'D' else 'C' end,
tr_oficina       = isnull(tr_ofi_usu ,op_oficina),
tr_tipo_trn	 = tr_tipo_trn,
tr_usuario	 = tr_usuario,
tr_terminal	 = tr_terminal,       
tr_fecha_real	 = tr_fecha_real
into  #transacciones
from  pf_transaccion, pf_operacion, pf_tranperfil
where tr_fecha_mov     = @w_fecha_proc
and   tr_estado       <> 'RV'
and   tp_trn_rec <> null
and   tr_operacion     = op_operacion
and   tr_tran          = tp_tran
and   tp_estado        = 'N'


/* REGISTRO DE LAS TRANSACCIONES DIARIAS EN COB_EXTERNOS */
insert into cob_externos..ex_dato_transaccion(
dt_fecha,          dt_secuencial,     dt_banco,
dt_toperacion,     dt_aplicativo,     dt_fecha_trans,
dt_tipo_trans,     dt_reversa,        dt_naturaleza,
dt_canal,          dt_oficina, 	      dt_usuario,
dt_terminal,       dt_fecha_hora)
select
@w_fecha_proc,     tr_secuencial,     tr_banco,
tr_toperacion,     14,                tr_fecha_mov,
tr_tipo_trans,     'N',               tr_naturaleza,
'OFI',             tr_oficina,	      tr_usuario,
tr_terminal,       tr_fecha_real
from  #transacciones

if @@error <> 0 begin
   select
   @w_error = 143003,
   @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_transaccion'
   goto ERROR
end


/* REGISTRO DEL DETALLE DE TRANSACCIONES DIARIAS EN COB_EXTERNOS */
insert into cob_externos..ex_dato_transaccion_det(
dd_fecha,           dd_secuencial,      dd_banco,
dd_toperacion,      dd_aplicativo,      dd_concepto,        
dd_moneda,          dd_cotizacion,      dd_monto,
dd_codigo_valor)
select
@w_fecha_proc,      tr_secuencial,      tr_banco,
tr_toperacion,      14,                 case when eq_val_pfijo = 'AHO' and T.tr_tipo_trn = 'REN' and td_aux is null  then 'NCAH'
					     when eq_val_pfijo = 'AHO' and T.tr_tipo_trn = 'REN' and td_aux is not null  then 'NDAH'
					     when eq_val_pfijo = 'AHO' and T.tr_tipo_trn = 'CAN' then 'NCAH'
					     when eq_val_pfijo = 'AHO' and T.tr_tipo_trn = 'APE' then 'NDAH'
					     else eq_val_interfaz 
					end,
td_moneda,          valor,              sum(td_monto), 
td_codvalor
from  pf_transaccion_det, #transacciones T, #cotizacion, pf_equivalencias
where tr_operacion     = td_operacion
and   tr_secuencial    = td_secuencial
and   moneda           = td_moneda
and   eq_tabla         = 'TIPCONCEPT'
and   eq_val_pfijo     = td_concepto
group by tr_secuencial, 
tr_banco, 
tr_toperacion, 
case when eq_val_pfijo = 'AHO' and T.tr_tipo_trn = 'REN' and td_aux is null  then 'NCAH' 
     when eq_val_pfijo = 'AHO' and T.tr_tipo_trn = 'REN' and td_aux is not null  then 'NDAH'
     when eq_val_pfijo = 'AHO' and T.tr_tipo_trn = 'CAN' then 'NCAH'                    
     when eq_val_pfijo = 'AHO' and T.tr_tipo_trn = 'APE' then 'NDAH'                    
     else eq_val_interfaz                                                                  
end,                                                                                       
td_moneda, 
valor,
td_codvalor

if @@error <> 0 begin
   select
   @w_error = 143003,
   @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_transaccion_det'
   goto ERROR
end



/* DETERMINAR SI HOY ES EL ULTIMO HABIL DEL MES */

select @w_sig_habil = dateadd(dd, 1, @w_fecha_proc)

while exists (select 1
                  from cobis..cl_dias_feriados
                  where df_fecha = @w_sig_habil
                  and   df_ciudad = @w_ciudad)
begin
   select @w_sig_habil = dateadd(dd, 1, @w_sig_habil)
end

if datepart(mm, @w_sig_habil) <> datepart(mm, @w_fecha_proc)
   select @w_fin_mes = 'S'

if @w_fin_mes = 'S' 
or exists (	select 	 1
		from 	cob_conta_super..sb_calendario_proyec
		where cp_fecha_proc = @w_fecha_proc
	)
begin

	/* SE REPORTAN TODAS LAS CUOTAS DIFERENTES DE CANCELADAS DE LOS OPERACIONES ACTIVAS */
	/* PRIMERO LAS OPERACIONES AL VENCIMIENTO CON LOS DATOS DEL MAESTRO */
	insert into cob_externos..ex_dato_cuota_pry(
	dc_fecha,         dc_banco,         dc_toperacion,
	dc_aplicativo,    dc_num_cuota,     dc_fecha_vto,
	dc_valor_pry,
	dc_estado)
	select
	@w_fecha_proc,    pf_banco,         pf_toperacion,
	14,               1,                pf_fecha_ven,
	pf_monto + pf_total_int_estimado,
	(select eq_val_interfaz from pf_equivalencias where eq_tabla = 'TIPESTPRY' and eq_val_pfijo = pf_estado)
	from   #pf_operaciones
	where  pf_fpago = 'VEN'
	and    pf_estado in ('ACT', 'VEN')
	
	if @@error <> 0 begin
	   select
	   @w_error = 143003,
	   @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_cuota_pry al vencimiento'
	   goto ERROR
	end
	
	insert into cob_externos..ex_dato_cuota_pry(
	dc_fecha,         dc_banco,         dc_toperacion,
	dc_aplicativo,    dc_num_cuota,     dc_fecha_vto,
	dc_valor_pry,
	dc_estado)
	select
	@w_fecha_proc,    pf_banco,         pf_toperacion,
	14,               cu_cuota,         cu_fecha_pago,
	case when datediff(dd,cu_fecha_pago,pf_fecha_ven) = 0 then pf_monto + cu_valor_cuota else cu_valor_cuota end,
	case
	when cu_estado = 'V' then '1'
	else '3' end
	from   #pf_operaciones, pf_cuotas
	where  pf_fpago     = 'PER'
	and    pf_operacion = cu_operacion
	and    cu_estado    = 'V'
	
	if @@error <> 0 begin
	   select
	   @w_error = 143003,
	   @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_cuota_pry periodica'
	   goto ERROR
	end

end  -- IF EXISTS

--  beneficiarios

insert into cob_externos..ex_dato_deudores
select 	@w_fecha_proc,
	op_num_banco,
	op_toperacion,
	14,		
	be_ente, 
	case when B.be_rol  = 'A' then 'B' else B.be_rol end
from 	pf_beneficiario B,  
	pf_operacion
where 	be_operacion 	= op_operacion
and	be_operacion 	= op_operacion
and	op_estado 	in ('ACT', 'VEN')
and	be_estado 	= 'I' 
and	be_estado_xren 	<> 'S'
and	be_tipo 	<> 'F'
order by be_operacion, be_secuencia

return 0

ERROR:
exec sp_errorlog
@i_fecha   = @w_fecha_proc,
@i_error   = @w_error,
@i_usuario = 'batch',
@i_tran    = 0,
@i_cuenta  = @w_msg

return @w_error
go

