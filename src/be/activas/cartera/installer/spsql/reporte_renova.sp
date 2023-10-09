
/************************************************************************/
/*   Archivo:              reporte_renova.sp                            */
/*   Stored procedure:     sp_riesgo_provision                          */
/*   Base de datos:        cob_ccnta_super                              */
/*   Producto:             Regulatorios                                 */
/*   Disenado por:                                                      */
/*   Fecha de escritura:   Marzo 2018                                   */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Genera archivo de interface para operaciones en mora diarias       */
/*   banco SANTANDER MX.                                                */
/*                              CAMBIOS                                 */
/*   20/05/2021         DCU            Emision Inicial*/
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_reporte_proc_renova')
   drop proc sp_reporte_proc_renova
go

create proc sp_reporte_proc_renova
(
   @i_param1   datetime = null   --FECHA REPROCESO
)

as
declare 
@w_fecha           datetime,
@w_fecha_ant       datetime,
@w_ciudad_nacional int,
@w_batch           int,
@w_ruta_arch	   varchar(255),
@w_nombre_arch	   varchar(100),
@w_query           varchar(8000),
@w_destino         varchar(400),
@w_nom_log         varchar(255),
@w_errores         varchar(400),
@w_comando         varchar(400),
@w_s_app           varchar(400),
@w_msg             varchar(400),
@w_error           int,
@w_formato_fecha   int,
@w_mes             varchar(2),
@w_dia             varchar(2)
select 
@w_batch         = 7976,
@w_formato_fecha = 111,
@w_fecha         = @i_param1

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'



select @w_fecha = @i_param1
select @w_fecha_ant =  dateadd(day,-1,@w_fecha)


while exists(select 1 from cobis..cl_dias_feriados 
					where df_ciudad = @w_ciudad_nacional	
					and   df_fecha  = @w_fecha_ant ) begin
	select @w_fecha_ant = dateadd(day,-1,@w_fecha_ant)
end

select
@w_mes = case when month(@w_fecha_ant)<10 then '0'+ convert(varchar(2),month(@w_fecha_ant)) else  convert(varchar(2),month(@w_fecha_ant)) end,         
@w_dia = case when day(@w_fecha_ant) <10 then '0'+ convert(varchar(2),day(@w_fecha_ant)) else  convert(varchar(2),day(@w_fecha_ant)) end         

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM' and pa_nemonico = 'S_APP'

select	
@w_ruta_arch	= ba_path_destino,
@w_nombre_arch	= ba_arch_resultado + convert(varchar(4),year(@w_fecha)) + @w_mes + @w_dia,
@w_nom_log      = ba_arch_resultado + convert(varchar(4),year(@w_fecha)) + @w_mes + @w_dia  
from cobis..ba_batch
where ba_batch = @w_batch

select 
@w_nombre_arch,
@w_fecha

select 
'CreditoOrigen'       = or_num_operacion,
'CreditoDestino'      = n.op_banco        ,
'CodigoCliente'       = n.op_cliente      ,
'Buc'                 = convert(varchar(20),null),
'FechaAlta'           = n.op_fecha_ini,
'FechaFormalizacion'  = n.op_fecha_ini,
'SituacionConta'      = convert(varchar(10),null),
'ClasificacionDest'   = convert(varchar(10),'0201'),
'DiasMora'            = convert(int,0),
'ExigibleOrigen'      = convert(money,0), --10
'ExigibleAct'         = convert(money,0),
'ImporteRefin'        = convert(money,null),
'MontoFormalizado'    = convert(money,n.op_monto),
'FlagCarenciaInt'        = convert(int,0),
'InicioCarenciaIntDes'= convert(datetime,null), 
'FinCarenciaIntDes'   = convert(datetime,null), 
'FlagCarenciaCap'     = convert(int,0),
'InicioCarenciaCapDes'= convert(datetime,null), 
'FinCarenciaCapDes'   = convert(datetime,null), 
'QuitaCapDestino'     = convert(money,null),--20
'QuitaIntDestino'     = convert(money,null),
'QuitaCapOrigen'      = convert(money,null),
'QuitaIntOrigen'      = convert(money,null),
'FechaFinContrato'    = n.op_fecha_fin, 
'MontoPagoCliente'    = convert(money,0),
'AmortizaCapOri'      = convert(varchar(10),null),
'AmortizaIntOri'      = convert(varchar(10),null),
'AmortizaCapDes'      = convert(varchar(10),null),
'AmortizaIntDes'      = convert(varchar(10),null),
'secuencial_ren'      = convert(int,0),
'secuencial_pag'      = convert(int,0),
'operacion_ant'       = a.op_operacion,
'fecha_pag'           = convert(datetime,null)
into #reporte 
from cob_credito..cr_op_renovar,
cob_cartera..ca_operacion n,
cob_cartera..ca_operacion a
where or_operacion_original = n.op_operacion
and or_num_operacion = a.op_banco 
and or_finalizo_renovacion = 'S'
and n.op_fecha_ini = @w_fecha_ant

update #reporte set
secuencial_ren = tr_secuencial
from cob_cartera..ca_transaccion
where tr_banco = CreditoOrigen
and tr_tran    = 'REN'
and tr_secuencial > 0
and tr_estado <> 'RV'

update #reporte set
secuencial_pag = tr_secuencial,
fecha_pag      = tr_fecha_ref
from cob_cartera..ca_transaccion
where tr_banco = CreditoOrigen
and tr_tran    = 'PAG'
and tr_secuencial > 0
and tr_estado <> 'RV'
and tr_observacion =  'RENOVACION'

update #reporte set
SituacionConta = '040' + case when oph_estado = 1 then '0' else '1' end
from cob_cartera..ca_operacion_his
where oph_operacion = operacion_ant
and   oph_secuencial = secuencial_pag

update #reporte set
SituacionConta = '040' + case when oph_estado = 1 then '0' else '1' end
from cob_cartera_his..ca_operacion_his
where oph_operacion = operacion_ant
and   oph_secuencial = secuencial_pag


select d.*
into #ca_dividendo
from cob_cartera..ca_dividendo_his d,
#reporte
where dih_operacion  = operacion_ant
and   dih_secuencial = secuencial_pag 

insert into #ca_dividendo
select d.*
from cob_cartera_his..ca_dividendo_his d,
#reporte
where dih_operacion  = operacion_ant
and   dih_secuencial = secuencial_pag 


select m.*
into #ca_amortizacion
from cob_cartera..ca_amortizacion_his m,
#reporte
where amh_operacion  = operacion_ant
and   amh_secuencial = secuencial_pag 

insert into #ca_amortizacion
select m.*
from cob_cartera_his..ca_amortizacion_his m,
#reporte
where amh_operacion  = operacion_ant
and   amh_secuencial = secuencial_pag 

----

select d.*
into #ca_dividendo_act
from cob_cartera..ca_dividendo_his d,
#reporte
where dih_operacion  = operacion_ant
and   dih_secuencial = secuencial_ren 

insert into #ca_dividendo_act
select d.*
from cob_cartera_his..ca_dividendo_his d,
#reporte
where dih_operacion  = operacion_ant
and   dih_secuencial = secuencial_ren


select m.*
into #ca_amortizacion_act
from cob_cartera..ca_amortizacion_his m,
#reporte
where amh_operacion  = operacion_ant
and   amh_secuencial = secuencial_ren 

insert into #ca_amortizacion_act
select m.*
from cob_cartera_his..ca_amortizacion_his m,
#reporte
where amh_operacion  = operacion_ant
and   amh_secuencial = secuencial_ren 
----
select operacion = operacion_ant, fecha_ven = min(dih_fecha_ven)
into #operaciones_atraso
from #reporte,
#ca_dividendo
where dih_operacion  = operacion_ant
and   dih_secuencial = secuencial_pag
and   dih_estado     = 2
group by operacion_ant

update #reporte set
ClasificacionDest = '0202',
DiasMora = datediff(dd,fecha_ven, fecha_pag)
from #operaciones_atraso
where operacion = operacion_ant

select 
oper_saldo = operacion_ant, 
exigible     = case when dih_fecha_ven <= fecha_pag then 1 else 0 end,
estado       = amh_estado,
saldo_exi    = isnull(sum(case when dih_fecha_ven <= fecha_pag then (isnull(amh_acumulado, 0) - isnull(amh_pagado, 0)) else 0 end), 0),
saldo_no_exi = isnull(sum(case when dih_fecha_ven > fecha_pag then (isnull(amh_acumulado, 0) - isnull(amh_pagado, 0)) else 0 end),0)
into  #saldos
from  #reporte, #ca_dividendo, #ca_amortizacion
where dih_operacion  = operacion_ant
and   dih_secuencial = secuencial_pag
and   amh_operacion  = dih_operacion
and   amh_secuencial = secuencial_pag
and   amh_dividendo  = dih_dividendo
group by operacion_ant, case when dih_fecha_ven <= fecha_pag then 1 else 0 end, amh_estado

select oper_saldo, saldo_exi = sum(saldo_exi)
into #saldos_exigibles
from #saldos
where exigible = 1
group by oper_saldo

update #reporte set
ExigibleOrigen = saldo_exi
from #saldos_exigibles
where operacion_ant = oper_saldo

--

select 
oper_saldo = operacion_ant, 
exigible     = case when dih_fecha_ven <= fecha_pag then 1 else 0 end,
estado       = amh_estado,
saldo_exi    = isnull(sum(case when dih_fecha_ven <= fecha_pag then (isnull(amh_acumulado, 0) - isnull(amh_pagado, 0)) else 0 end), 0),
saldo_no_exi = isnull(sum(case when dih_fecha_ven > fecha_pag then (isnull(amh_acumulado, 0) - isnull(amh_pagado, 0)) else 0 end),0)
into  #saldos_act
from  #reporte, #ca_dividendo_act, #ca_amortizacion_act
where dih_operacion = operacion_ant
and   dih_secuencial = secuencial_ren
and   amh_operacion  = dih_operacion
and   amh_secuencial = secuencial_ren
and   amh_dividendo  = dih_dividendo
group by operacion_ant, case when dih_fecha_ven <= fecha_pag then 1 else 0 end, amh_estado


select oper_saldo, saldo_exi = sum(saldo_exi)
into #saldos_exigibles_act
from #saldos_act
where exigible = 1
group by oper_saldo

update #reporte set
ExigibleAct    = saldo_exi
from #saldos_exigibles_act
where operacion_ant = oper_saldo


select dtr_operacion, monto_pago = sum(dtr_monto)
into #pago_operaciones
from #reporte, cob_cartera..ca_det_trn
where dtr_operacion = operacion_ant
and dtr_secuencial = secuencial_pag
and dtr_concepto <> 'VAC0'
group by dtr_operacion


update #reporte set
ImporteRefin     = monto_pago--,
--MontoPagoCliente = monto_pago
from #pago_operaciones
where operacion_ant = dtr_operacion

update #reporte set
Buc = en_banco
from cobis..cl_ente
where en_ente = CodigoCliente

update #reporte set
FlagCarenciaInt     = 1,
InicioCarenciaIntDes= de_fecha_ini, 
FinCarenciaIntDes   = de_fecha_fin, 
FlagCarenciaCap     = 1,
InicioCarenciaCapDes= de_fecha_ini, 
FinCarenciaCapDes   = de_fecha_fin
from cob_cartera..ca_desplazamiento
where de_banco= CreditoDestino

update #reporte set
AmortizaCapOri = case 
                 when td_tdividendo = 'D' and (op_periodo_cap * td_factor) < 10  then '10' + convert(varchar(4),op_periodo_cap * td_factor)
                 when td_tdividendo = 'D' and (op_periodo_cap * td_factor) >= 10 then '1' + convert(varchar(4),op_periodo_cap * td_factor)
                 when td_tdividendo = 'W' and (op_periodo_cap * td_factor) < 10  then '10' + convert(varchar(4),op_periodo_cap * td_factor)
                 when td_tdividendo = 'W' and (op_periodo_cap * td_factor) >= 10 then '1' + convert(varchar(4),op_periodo_cap * td_factor)
                 when td_tdividendo = 'Q' then '1' + convert(varchar(4),op_periodo_cap * td_factor)
                 when td_tdividendo = 'M' then '20' + convert(varchar(4),op_periodo_cap)
                 when td_tdividendo = 'T' and (op_periodo_cap * 3) < 10 then '20' + convert(varchar(4),op_periodo_cap * 3)
                 when td_tdividendo = 'T' and (op_periodo_cap * 3) >= 10 then '2' + convert(varchar(4),op_periodo_cap * 3)
                 when td_tdividendo = 'S' and (op_periodo_cap * 6) < 10 then '20' + convert(varchar(4),op_periodo_cap * 6)
                 when td_tdividendo = 'S' and (op_periodo_cap * 6) >= 10 then '2' + convert(varchar(4),op_periodo_cap * 6)
                 when td_tdividendo = 'A' then '2' + convert(varchar(4),op_periodo_cap * 12)
                 end,
AmortizaIntOri = case 
                 when td_tdividendo = 'D' and (op_periodo_int * td_factor) < 10  then '10' + convert(varchar(4),op_periodo_int * td_factor)
                 when td_tdividendo = 'D' and (op_periodo_int * td_factor) >= 10 then '1' + convert(varchar(4),op_periodo_int * td_factor)
                 when td_tdividendo = 'W' and (op_periodo_int * td_factor) < 10  then '10' + convert(varchar(4),op_periodo_int * td_factor)
                 when td_tdividendo = 'W' and (op_periodo_int * td_factor) >= 10 then '1' + convert(varchar(4),op_periodo_int * td_factor)
                 when td_tdividendo = 'Q' then '1' + convert(varchar(4),op_periodo_int * td_factor)
                 when td_tdividendo = 'M' then '20' + convert(varchar(4),op_periodo_int)
                 when td_tdividendo = 'T' and (op_periodo_int * 3) < 10 then '20' + convert(varchar(4),op_periodo_int * 3)
                 when td_tdividendo = 'T' and (op_periodo_int * 3) >= 10 then '2' + convert(varchar(4),op_periodo_int * 3)
                 when td_tdividendo = 'S' and (op_periodo_int * 6) < 10 then '20' + convert(varchar(4),op_periodo_int * 6)
                 when td_tdividendo = 'S' and (op_periodo_int * 6) >= 10 then '2' + convert(varchar(4),op_periodo_int * 6)
                 when td_tdividendo = 'A' then '2' + convert(varchar(4),op_periodo_int * 12)
                 end                 
from cob_cartera..ca_operacion,
cob_cartera..ca_tdividendo
where op_banco    = CreditoOrigen
and op_tdividendo = td_tdividendo

update #reporte set
AmortizaCapDes = case 
                 when td_tdividendo = 'D' and (op_periodo_cap * td_factor) < 10  then '10' + convert(varchar(4),op_periodo_cap * td_factor)
                 when td_tdividendo = 'D' and (op_periodo_cap * td_factor) >= 10 then '1' + convert(varchar(4),op_periodo_cap * td_factor)
                 when td_tdividendo = 'W' and (op_periodo_cap * td_factor) < 10  then '10' + convert(varchar(4),op_periodo_cap * td_factor)
                 when td_tdividendo = 'W' and (op_periodo_cap * td_factor) >= 10 then '1' + convert(varchar(4),op_periodo_cap * td_factor)
                 when td_tdividendo = 'Q' then '1' + convert(varchar(4),op_periodo_cap * td_factor)
                 when td_tdividendo = 'M' then '20' + convert(varchar(4),op_periodo_cap)
                 when td_tdividendo = 'T' and (op_periodo_cap * 3) < 10 then '20' + convert(varchar(4),op_periodo_cap * 3)
                 when td_tdividendo = 'T' and (op_periodo_cap * 3) >= 10 then '2' + convert(varchar(4),op_periodo_cap * 3)
                 when td_tdividendo = 'S' and (op_periodo_cap * 6) < 10 then '20' + convert(varchar(4),op_periodo_cap * 6)
                 when td_tdividendo = 'S' and (op_periodo_cap * 6) >= 10 then '2' + convert(varchar(4),op_periodo_cap * 6)
                 when td_tdividendo = 'A' then '2' + convert(varchar(4),op_periodo_cap * 12)
                 end,
AmortizaIntDes = case 
                 when td_tdividendo = 'D' and (op_periodo_int * td_factor) < 10  then '10' + convert(varchar(4),op_periodo_int * td_factor)
                 when td_tdividendo = 'D' and (op_periodo_int * td_factor) >= 10 then '1' + convert(varchar(4),op_periodo_int * td_factor)
                 when td_tdividendo = 'W' and (op_periodo_int * td_factor) < 10  then '10' + convert(varchar(4),op_periodo_int * td_factor)
                 when td_tdividendo = 'W' and (op_periodo_int * td_factor) >= 10 then '1' + convert(varchar(4),op_periodo_int * td_factor)
                 when td_tdividendo = 'Q' then '1' + convert(varchar(4),op_periodo_int * td_factor)
                 when td_tdividendo = 'M' then '20' + convert(varchar(4),op_periodo_int)
                 when td_tdividendo = 'T' and (op_periodo_int * 3) < 10 then '20' + convert(varchar(4),op_periodo_int * 3)
                 when td_tdividendo = 'T' and (op_periodo_int * 3) >= 10 then '2' + convert(varchar(4),op_periodo_int * 3)
                 when td_tdividendo = 'S' and (op_periodo_int * 6) < 10 then '20' + convert(varchar(4),op_periodo_int * 6)
                 when td_tdividendo = 'S' and (op_periodo_int * 6) >= 10 then '2' + convert(varchar(4),op_periodo_int * 6)
                 when td_tdividendo = 'A' then '2' + convert(varchar(4),op_periodo_int * 12)
                 end                 
from cob_cartera..ca_operacion,
cob_cartera..ca_tdividendo
where op_banco    = CreditoDestino
and op_tdividendo = td_tdividendo


truncate table ca_reporte_restructura



insert into dbo.ca_reporte_restructura(  
rr_credito_original      ,    rr_credito_destino       ,   rr_buc                   ,
rr_fecha_alta            ,    rr_fecha_formalizacion   ,   rr_situacion_conta       ,
rr_clasificacion_dest    ,    rr_dia_mora              ,   rr_exigible_origen       ,
rr_exigible_ori_actual   ,    rr_importe_refinan       ,   rr_monto_formalizado     ,
rr_flag_carencia_int     ,    rr_inicio_carencia_int   ,   rr_fin_carencia_int      ,
rr_flag_carencia_cap     ,    rr_inicio_carencia_cap   ,   rr_fin_carencia_cap      ,
rr_quita_cap_destino     ,    rr_quita_int_destino     ,   rr_quita_cap_origen      ,
rr_quita_int_origen      ,    rr_fecha_fin_contrato    ,   rr_monto_pago_cliente    ,
rr_amortiza_cap_ori      ,    rr_amortiza_int_ori      ,   rr_amortiza_cap_des      ,
rr_amortiza_int_des      )
values(
'CREDITO_ORIGEN'               , 'CREDITO_DESTINO'             , 'BUC', 
'FECHA_ALTA'                   , 'FECHA_FORMALIZACION'         , 'SITUACION_CONTABLE_ORIGEN', 
'CLASIFICACION_DESTINO'        , 'DIAS_MORA'                   , 'EXIGIBLE_ORIGEN', 
'EXIGIBLE_ORI_ACTUAL'          , 'IMPORTE_REFINANCIAMIENTO'    , 'MONTO_FORMALIZADO', 
'FLAG_CARENCIA_INTERES_DESTINO', 'INICIO_CARENCIA_INTERES_DEST', 'FIN_CARENCIA_INTERES_DESTINO', 
'FLAG_CARENCIA_CAPITAL_DESTINO', 'INICIO_CARENCIA_CAPITAL_DEST', 'FIN_CARENCIA_CAPITAL_DESTINO', 
'QUITA_CAPITAL_DESTINO'        , 'QUITA_INTERES_DESTINO'       , 'QUITA_CAPITAL_ORIGEN', 
'QUITA_INTERES_ORIGEN'         , 'FECHA_FIN_CONTRATO'          , 'MONTO_PAGO_CLIENTE', 
'AMORTIZACION_CAPITAL_ORI'     , 'AMORTIZACION_INTERES_ORI'    , 'AMORTIZACION_CAPITAL_DEST', 
'AMORTIZACION_INTERES_DEST')

insert into ca_reporte_restructura(  
rr_credito_original      , rr_credito_destino    ,       rr_buc,
rr_fecha_alta            , rr_fecha_formalizacion,       rr_situacion_conta,
rr_clasificacion_dest    , rr_dia_mora           ,       rr_exigible_origen,
rr_exigible_ori_actual   , rr_importe_refinan    ,       rr_monto_formalizado,
rr_flag_carencia_int     , rr_inicio_carencia_int,       rr_fin_carencia_int,
rr_flag_carencia_cap     , rr_inicio_carencia_cap,       rr_fin_carencia_cap,
rr_quita_cap_destino     , rr_quita_int_destino  ,       rr_quita_cap_origen,
rr_quita_int_origen      , rr_fecha_fin_contrato ,       rr_monto_pago_cliente,
rr_amortiza_cap_ori      , rr_amortiza_int_ori   ,       rr_amortiza_cap_des,
rr_amortiza_int_des      )
select 
CreditoOrigen                                   , CreditoDestino                                            ,       Buc                 ,
convert(varchar(10),FechaAlta,@w_formato_fecha) , convert(varchar(10),FechaFormalizacion,@w_formato_fecha)  ,       SituacionConta      ,
ClasificacionDest                               , convert(varchar(4),DiasMora)                              ,       convert(varchar(10),ExigibleOrigen)      ,
convert(varchar(10),ExigibleAct)                , convert(varchar(10),ImporteRefin)                         ,       convert(varchar(10),MontoFormalizado)    ,
convert(varchar(2),FlagCarenciaInt)             , convert(varchar(10),InicioCarenciaIntDes,@w_formato_fecha),       convert(varchar(10),FinCarenciaIntDes,@w_formato_fecha),
convert(varchar(2),FlagCarenciaCap)             , convert(varchar(10),InicioCarenciaCapDes,@w_formato_fecha),       convert(varchar(10),FinCarenciaCapDes,@w_formato_fecha),
convert(varchar(10),QuitaCapDestino)            , convert(varchar(10),QuitaIntDestino)                      ,       convert(varchar(10),QuitaCapOrigen)      ,
convert(varchar(10),QuitaIntOrigen)             , convert(varchar(10),FechaFinContrato,@w_formato_fecha)    ,       convert(varchar(10),MontoPagoCliente)    ,
AmortizaCapOri                                  , AmortizaIntOri                                            ,       AmortizaCapDes      ,
AmortizaIntDes
from #reporte


select @w_query   = 'select * from cob_cartera..ca_reporte_restructura order by rr_credito_original desc'

select @w_destino = @w_ruta_arch + @w_nombre_arch+'.txt', -- COB_ODS_07_<aaaa_mm_dd>.txt
       @w_errores = @w_ruta_arch + @w_nom_log +'.err'  -- COB_ODS_07_<aaaa_mm_dd>.err

select @w_comando = 'bcp "' + @w_query + '" queryout "'
select @w_comando = @w_comando + @w_destino + '" -b5000 -c' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'+ ' -t"|" '
--select @w_bcp = @w_bcp + @w_file_cl_in + ' -b5000 -c' + @w_s_app + 's_app.ini -T -e' + @w_file_cl_out   

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
  select
  @w_error = 70146,
  @w_msg   = 'ERROR AL EJECUTAR COMANDO BCP'
end


go

