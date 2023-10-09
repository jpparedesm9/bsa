/* ********************************************************************* */
/*      Archivo:                sp_reporte_asigna_mora.sp                */
/*      Stored procedure:       sp_reporte_asigna_mora                   */
/*      Base de datos:          cob_conta_super                          */
/*      Producto:               Regulatorios                             */
/*      Disenado por:           Sonia Rojas                              */
/*      Fecha de escritura:     14-Julio-2020                            */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/* ********************************************************************* */
/*                              PROPOSITO                                */
/*      Programa temporal para sumatoria de contabilidad                 */
/* ********************************************************************* */
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    14/Jul/2020           SRO              Emision inicial             */
/*    12/12/2020            JCASTRO          REQ#145941                  */
/* ********************************************************************* */
use cob_conta_super
go 

if not object_id('sp_reporte_asigna_mora') is null
   drop proc sp_reporte_asigna_mora
go

create proc sp_reporte_asigna_mora
(
   @i_param1   datetime = null   --FECHA REPROCESO
)
as
declare
@w_min_atraso             int,
@w_max_atraso             int,
@w_error                  int,
@w_fecha_proceso          datetime,
@w_fecha_corte            datetime,
@w_ciudad_nacional        int,
@w_query                  varchar(6000),
@w_comando                varchar(6000),
@w_errores                varchar(255),
@w_s_app                  VARCHAR(100),
@w_cmd                    varchar(5000),
@w_est_vencido            int,
@w_est_vigente            int,
@w_est_castigado          int,
@w_est_suspenso           INT,
@w_arch_resultado         VARCHAR(50),
@w_path_destino           VARCHAR(60),
@w_destino_reporte        VARCHAR(200),
@w_mes_anterior           int,
@w_ult_dia_mes_anterior   datetime


select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

if @i_param1 is null
   select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
else
   select @w_fecha_proceso = @i_param1   
   
select @w_fecha_corte  = @w_fecha_proceso

while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_corte)
begin
   if datepart(dd, @w_fecha_corte) != 1 select @w_fecha_corte = dateadd(dd, -1, @w_fecha_corte) else break
end

select 
@w_arch_resultado       = ba_arch_resultado,
@w_path_destino         = ba_path_destino
from cobis..ba_batch 
where ba_batch = 28798

PRINT @w_arch_resultado


--CONSULTAR ESTADO VENCIDO/VIGENTE PARA CARTERA
exec @w_error    = cob_externos..sp_estados
@i_producto      = 7,
@o_est_vencido   = @w_est_vencido   out,
@o_est_vigente   = @w_est_vigente   out,
@o_est_castigado = @w_est_castigado out,
@o_est_suspenso  = @w_est_suspenso  out 

if @@error <> 0 begin
   print 'No Encontro Estado Vencido/Vigente/Castigado para Cartera'
   return 1
end

select 
@w_mes_anterior         = datepart(mm, @w_fecha_corte) - 1,
@w_ult_dia_mes_anterior = dateadd (dd, -1, dateadd(month, datediff(month, 0,@w_fecha_corte), 0))


while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_ult_dia_mes_anterior)
begin
   if datepart(dd, @w_ult_dia_mes_anterior) != 1 select @w_ult_dia_mes_anterior = dateadd(dd, -1, @w_ult_dia_mes_anterior) else break
end


select 
am_cliente                     = do_codigo_cliente,
am_banco                       = do_banco,
am_pagos_vencidos              = convert(int, do_num_cuotaven),
am_dias_morosos                = convert(int, do_dias_mora_365),
am_total_deudor                = convert(money, null),
am_monto_moroso                = convert(money, null),
am_pago_minimo                 = convert(money, null),
am_monto_ultimo_pago           = convert(money, do_valor_ult_pago),
am_fecha_ultimo_pago           = convert(varchar(10), do_fecha_ult_pago,103),
am_ultimo_saldo_mes_anterior   = convert(money, null),
am_saldo_vencido_30_dias       = convert(money, null),
am_saldo_vencido_60_dias       = convert(money, null),
am_saldo_vencido_90_dias       = convert(money, null),
am_saldo_vencido_120_dias      = convert(money, null),
am_fecha_prox_vencimiento      = case when do_fecha_prox_vto < @w_fecha_corte or do_fecha_prox_vto is null then convert(varchar(10), dateadd(dd, 1, @w_fecha_corte), 103) else convert(varchar(10), do_fecha_prox_vto, 103) end,
am_plazo_pactado               = convert(int, null),
am_clasif                      = convert(int,null),
am_motivo                      = convert(varchar(10), ''),
am_pv_1mes_atras               = convert(varchar(10), ''),
am_pv_2mes_atras               = convert(varchar(10), ''),
am_pv_3mes_atras               = convert(varchar(10), ''),
am_pv_4mes_atras               = convert(varchar(10), ''),
am_pv_5mes_atras               = convert(varchar(10), ''),
am_pv_6mes_atras               = convert(varchar(10), ''),
am_trascodificada              = convert(varchar(10), ''),
am_interes_ordinario           = convert(money, null),
am_interes_ordinario_iva       = convert(money, null),
am_comision_mora               = convert(money, null),
am_comision_mora_iva           = convert(money, null)
into #asigna_mora
from cob_conta_super..sb_dato_operacion
where do_dias_mora_365 > 0
and   do_fecha = @w_fecha_corte
and   do_aplicativo = 7

if @@error <> 0 begin
   print 'Error en generacion de data base'
   return 1
end


create index idx1 on #asigna_mora(am_banco)

update #asigna_mora set 
am_ultimo_saldo_mes_anterior = do_saldo
from cob_conta_super..sb_dato_operacion
where  do_banco = am_banco
and    do_fecha = @w_ult_dia_mes_anterior

select 
dr_banco,
dr_cap_ven_ex            = sum(case when dr_categoria  = 'C'  and dr_estado in (@w_est_vencido,@w_est_castigado)  and dr_exigible   = 1 then   isnull(dr_valor,0) else 0 end),
dr_saldo_ex              = sum(case when dr_exigible   = 1   then   isnull(dr_valor, 0) else 0 end),
dr_saldo_prestamo        = sum( isnull(dr_valor,0))
into #rubros
from #asigna_mora, cob_conta_super..sb_dato_operacion_rubro
where dr_fecha      = @w_fecha_corte
and   dr_aplicativo = 7
and   dr_banco      = am_banco
group by dr_banco

select dr_banco,
       dr_valor,
       dr_concepto,
       dr_categoria
into   #rubros_dos
from   #asigna_mora, cob_conta_super..sb_dato_operacion_rubro
where  dr_fecha      = @w_fecha_corte
and    dr_aplicativo = 7
and    dr_banco      = am_banco
and    dr_estado     = 4

update #asigna_mora
set    am_interes_ordinario = dr_valor
from   #rubros_dos
where  am_banco = dr_banco
and    dr_categoria = 'I' 
and    dr_concepto  = 'INT'

update #asigna_mora
set    am_interes_ordinario_iva = dr_valor
from   #rubros_dos
where  am_banco = dr_banco
and    dr_categoria = 'A' 
and    dr_concepto  = 'IVA_INT'

update #asigna_mora
set    am_comision_mora = dr_valor
from   #rubros_dos
where  am_banco = dr_banco
and    dr_categoria = 'O' 
and    dr_concepto  = 'COMMORA'

update #asigna_mora
set    am_comision_mora_iva = dr_valor
from   #rubros_dos
where  am_banco = dr_banco
and    dr_categoria = 'A' 
and    dr_concepto  = 'IVA_CMORA'

PRINT 2
update #asigna_mora set
am_total_deudor           = dr_saldo_prestamo,
am_monto_moroso           = dr_cap_ven_ex,
am_pago_minimo            = dr_saldo_ex,
am_saldo_vencido_30_dias  = case when am_dias_morosos between 0  and 30 then dr_saldo_ex else 0.0 end,
am_saldo_vencido_60_dias  = case when am_dias_morosos between 31 and 60 then dr_saldo_ex else 0.0 end,
am_saldo_vencido_90_dias  = case when am_dias_morosos between 61 and 90 then dr_saldo_ex else 0.0 end,
am_saldo_vencido_120_dias = case when am_dias_morosos >= 91 then dr_saldo_ex else 0.0             end
from #rubros
where am_banco  = dr_banco 


PRINT 14
truncate table  cob_conta_super..sb_reporte_asigna_mora

insert into cob_conta_super..sb_reporte_asigna_mora  (
[NO_CUENTA],[PAGOS_VENCIDOS],[DIAS_MOROSOS],[TOTAL_DEUDOR],           
[MONTO_MOROSO],[PAGO_MINIMO ],[MONTO_ULTIMO_PAGO ],[FECHA_ULTIMO_PAGO],                
[ULTIMO_SALDO_MES_ANTERIOR],[SALDO_VENCIDO_30_DIAS],[SALDO_VENCIDO_60_DIAS],[SALDO_VENCIDO_90_DIAS],          
[SALDO_VENCIDO_120_DIAS ],[FECHA_PROX_VENCIMIENTO],[PLAZO_PACTADO],[CLASIF],            
[MOTIVO],[PV_1MES_ATRAS],[PV_2MES_ATRAS],[PV_3MES_ATRAS],               
[PV_4MES_ATRAS],[PV_5MES_ATRAS],[PV_6MES_ATRAS],[TRASCODIFICADA],
[INTERESES_ORDINARIOS],[IVA_INTERESES_ORDINARIOS],[COMISIONES_FALTA_PAGO],[IVA_COMISIONES])  
VALUES(
'NO_CUENTA','PAGOS_VENCIDOS','DIAS_MOROSOS','TOTAL_DEUDOR',           
'MONTO_MOROSO','PAGO_MINIMO','MONTO_ULTIMO_PAGO','FECHA_ULTIMO_PAGO',                
'ULTIMO_SALDO_MES_ANTERIOR','SALDO_VENCIDO_30_DIAS','SALDO_VENCIDO_60_DIAS','SALDO_VENCIDO_90_DIAS',          
'SALDO_VENCIDO_120_DIAS','FECHA_PROX_VENCIMIENTO','PLAZO_PACTADO','CLASIF',          
'MOTIVO','PV_1MES_ATRAS','PV_2MES_ATRAS','PV_3MES_ATRAS',               
'PV_4MES_ATRAS','PV_5MES_ATRAS','PV_6MES_ATRAS','TRASCODIFICADA',
'INTERESES_ORDINARIOS','IVA_INTERESES_ORDINARIOS','COMISIONES_FALTA_PAGO','IVA_COMISIONES')
PRINT 15

insert into cob_conta_super..sb_reporte_asigna_mora (
[NO_CUENTA],[PAGOS_VENCIDOS],[DIAS_MOROSOS],[TOTAL_DEUDOR],           
[MONTO_MOROSO],[PAGO_MINIMO ],[MONTO_ULTIMO_PAGO ],[FECHA_ULTIMO_PAGO],                
[ULTIMO_SALDO_MES_ANTERIOR],[SALDO_VENCIDO_30_DIAS],[SALDO_VENCIDO_60_DIAS],[SALDO_VENCIDO_90_DIAS],          
[SALDO_VENCIDO_120_DIAS ],[FECHA_PROX_VENCIMIENTO],[PLAZO_PACTADO],[CLASIF],            
[MOTIVO],[PV_1MES_ATRAS],[PV_2MES_ATRAS],[PV_3MES_ATRAS],               
[PV_4MES_ATRAS],[PV_5MES_ATRAS],[PV_6MES_ATRAS],[TRASCODIFICADA],
[INTERESES_ORDINARIOS],[IVA_INTERESES_ORDINARIOS],[COMISIONES_FALTA_PAGO],[IVA_COMISIONES])  
select 
'NO_CUENTA'                    = isnull(convert(varchar(24),am_banco), ''),                   
'PAGOS_VENCIDOS'               = isnull(convert(varchar(30),am_pagos_vencidos), ''),                      
'DIAS_MOROSOS'                 = isnull(convert(varchar(30),am_dias_morosos), ''),             
'TOTAL_DEUDOR'                 = isnull(convert(varchar(30),am_total_deudor), ''),               
'MONTO_MOROSO'                 = isnull(convert(varchar(30),am_monto_moroso), ''),              
'PAGO_MINIMO'                  = isnull(convert(varchar(30),am_pago_minimo), ''),               
'MONTO_ULTIMO_PAGO'            = isnull(convert(varchar(30),am_monto_ultimo_pago), ''),                
'FECHA_ULTIMO_PAGO'            = isnull(convert(varchar(30),am_fecha_ultimo_pago), ''),       
'ULTIMO_SALDO_MES_ANTERIOR'    = isnull(convert(varchar(30),am_ultimo_saldo_mes_anterior), ''),          
'SALDO_VENCIDO_30_DIAS'        = isnull(convert(varchar(30),am_saldo_vencido_30_dias),''),
'SALDO_VENCIDO_60_DIAS'        = isnull(convert(varchar(30),am_saldo_vencido_60_dias),''),     
'SALDO_VENCIDO_90_DIAS'        = isnull(convert(varchar(30),am_saldo_vencido_90_dias),''),     
'SALDO_VENCIDO_120_DIAS'       = isnull(convert(varchar(30),am_saldo_vencido_120_dias), ''),     
'FECHA_PROX_VENCIMIENTO'       = isnull(convert(varchar(30),am_fecha_prox_vencimiento),''),   
'PLAZO_PACTADO'                = isnull(convert(varchar(30),am_plazo_pactado), ''),            
'CLASIF'                       = isnull(convert(varchar(30),am_clasif),''), 
'MOTIVO'                       = isnull(convert(varchar(30),am_motivo),''),                   
'PV_1MES_ATRAS'                = isnull(convert(varchar(30),am_pv_1mes_atras),''),              
'PV_2MES_ATRAS'                = isnull(convert(varchar(30),am_pv_2mes_atras),''),              
'PV_3MES_ATRAS'                = isnull(convert(varchar(30),am_pv_3mes_atras),''),             
'PV_4MES_ATRAS'                = isnull(convert(varchar(30),am_pv_4mes_atras),''),              
'PV_5MES_ATRAS'                = isnull(convert(varchar(30),am_pv_5mes_atras),''),              
'PV_6MES_ATRAS'                = isnull(convert(varchar(30),am_pv_6mes_atras),''),              
'TRASCODIFICADA'               = isnull(convert(varchar(30),am_trascodificada),''),
'INTERESES_ORDINARIOS'         = isnull(convert(varchar(30),format(am_interes_ordinario,'#.00')),'0.00'),
'IVA_INTERESES_ORDINARIOS'     = isnull(convert(varchar(30),format(am_interes_ordinario_iva,'#.00')),'0.00'),
'COMISIONES_FALTA_PAGO'        = isnull(convert(varchar(30),format(am_comision_mora,'#.00')),'0.00'),
'IVA_COMISIONES'               = isnull(convert(varchar(30),format(am_comision_mora_iva,'#.00')),'0.00')
from #asigna_mora            

select @w_query = 'select [NO_CUENTA]+ char(44) + [PAGOS_VENCIDOS]+ char(44) + [DIAS_MOROSOS]+ char(44) + [TOTAL_DEUDOR]+ char(44) +'            
select @w_query = @w_query + '[MONTO_MOROSO]+ char(44) + [PAGO_MINIMO]+ char(44) + [MONTO_ULTIMO_PAGO]+ char(44) + [FECHA_ULTIMO_PAGO]+ char(44) + '                
select @w_query = @w_query + '[ULTIMO_SALDO_MES_ANTERIOR]+ char(44) + [SALDO_VENCIDO_30_DIAS]+ char(44) + [SALDO_VENCIDO_60_DIAS]+ char(44) + [SALDO_VENCIDO_90_DIAS]+ char(44) +'           
select @w_query = @w_query + '[SALDO_VENCIDO_120_DIAS]+ char(44) + [FECHA_PROX_VENCIMIENTO]+ char(44) + [PLAZO_PACTADO]+ char(44) + [CLASIF]+ char(44) +'             
select @w_query = @w_query + '[MOTIVO]+ char(44) + [PV_1MES_ATRAS]+ char(44) + [PV_2MES_ATRAS]+ char(44) + [PV_3MES_ATRAS]+ char(44) +'                
select @w_query = @w_query + '[PV_4MES_ATRAS]+ char(44) + [PV_5MES_ATRAS]+ char(44) + [PV_6MES_ATRAS]+ char(44) + [TRASCODIFICADA]+ char(44) +'
select @w_query = @w_query + '[INTERESES_ORDINARIOS]+ char(44) +[IVA_INTERESES_ORDINARIOS]+ char(44) +[COMISIONES_FALTA_PAGO]+ char(44) +[IVA_COMISIONES]'
select @w_query = @w_query + ' from cob_conta_super..sb_reporte_asigna_mora'



select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'       

select 
@w_destino_reporte = @w_path_destino + @w_arch_resultado + '_' +replace(convert(varchar, @w_fecha_proceso,103),'/','') + '.txt',
@w_errores         = @w_path_destino + @w_arch_resultado + '_' +replace(convert(varchar, @w_fecha_proceso,103),'/','') + '.err'

select @w_comando = 'bcp "' + @w_query + '" queryout "'	   
select @w_comando = @w_comando + @w_destino_reporte + '" -b5000 -c -C RAW -T -e ' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
  select @w_error = 70146
  return 1
end

return 0
