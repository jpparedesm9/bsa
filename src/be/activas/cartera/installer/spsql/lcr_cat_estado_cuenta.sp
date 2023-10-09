

/*************************************************************************/
/*   ARCHIVO:         lcr_cat_estado_cuenta.sp                           */
/*   NOMBRE LOGICO:   sp_lcr_cat_estado_cuenta                           */
/*   Base de datos:   cob_cartera                                        */
/*   PRODUCTO:        Cartera                                            */
/*   DISEÑADO:        ANDY GONZALEZ                                      */
/*   Fecha de escritura:   Julio 2021                                    */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                     PROPOSITO                                         */
/*  Calcula el valor de la tasa de interes producto de los movimientos de*/
/*  la LCR dentro del mes                                                */
/*************************************************************************/
/*                     MODIFICACIONES                                    */
/* FECHA                AUTOR                DETALLE                     */
/* 13/JUL/2021          AGO                  VERSION INICIAL             */
/*************************************************************************/

use cob_cartera
go

if exists(select 1 from sysobjects where name = 'sp_lcr_cat_estado_cuenta')
    drop proc sp_lcr_cat_estado_cuenta
go

create proc sp_lcr_cat_estado_cuenta (
    @i_banco       cuenta ,
	@o_interes_estado_cuenta float = 0 out
)as
declare
@w_fecha_proceso datetime, 
@w_fecha_fin     datetime,
@w_fecha_ini     datetime, 
@w_saldo_ini     money,
@w_tasa_int      float ,
@w_msg           varchar(255),
@w_error         int,
@w_dias_anio     int ,
@w_numdec        int , 
@w_moneda        int ,
@w_interes       float ,
@w_suma_promedios float,
@w_intereses_efect_generados float,
@w_interes_estado_cuenta float,
@w_operacionca    int ,
@w_pago_minimo    money,
@w_est_vigente    int ,    
@w_est_vencida    int ,
@w_genera_int_cat  char(1),
@w_ciudad_nacional  int  


--estados cca
exec @w_error   = sp_estados_cca
@o_est_vigente  = @w_est_vigente out,
@o_est_vencido  = @w_est_vencida out


select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'


--DATOS DEL PRESTAMO 
select 
@w_operacionca       = op_operacion,
@w_moneda            = op_moneda,
@w_dias_anio         = isnull(op_dias_anio,360)   
from   ca_operacion
where  op_banco = @i_banco

if @@rowcount = 0  begin 
   select 
   @w_msg = 'NO EXISTE LA OPERACION LCR',
   @w_error = 700001
   goto ERROR_PROCESO

end 


select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso


--ESTO SE EJECUTA UN DIA DESPUES POR TANTO SE DEBE VERIFICAR CON EL DÍA ANTERIOR HABIL 
while exists( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional and df_fecha = @w_fecha_proceso) 
   select @w_fecha_proceso =dateadd(dd,-1,@w_fecha_proceso)


--PAGO MINIMO 
select @w_pago_minimo = isnull(sum(am_cuota - am_pagado),0)
from ca_amortizacion, ca_dividendo
where am_operacion = @w_operacionca
and am_operacion   = di_operacion
and am_dividendo   = di_dividendo
and (di_estado     = @w_est_vencida or (di_estado = @w_est_vigente and di_fecha_ven = @w_fecha_proceso ))

--EN CASO DE NO TENER PAGO MINIMO QUIERE DECIR QUE PAGO LA CUOTA COMPLETA O NO TIENE MOVIMIENTOS

if @w_pago_minimo = 0 begin 
  
   select @o_interes_estado_cuenta =0 
   return 0

end 

--select @w_fecha_proceso = '03/01/2019'

select @w_tasa_int   = isnull(ro_porcentaje,0) 
from  ca_rubro_op 
where ro_operacion  = @w_operacionca 
and   ro_concepto   = 'INT'

if @@rowcount = 0  or @w_tasa_int  = 0 begin 
   select 
   @w_msg = 'NO EXISTE LA TASA DE LA OPERACION LCR',
   @w_error = 700002
   goto ERROR_PROCESO

end 

select 
@w_fecha_fin   = dateadd(dd,0-datepart(dd,@w_fecha_proceso),@w_fecha_proceso)

select
@w_fecha_ini  = dateadd(dd,1-datepart(dd,@w_fecha_fin),@w_fecha_fin)
   
   
--select @w_fecha_fin,@w_fecha_ini


exec @w_error = sp_decimales
@i_moneda      = @w_moneda ,
@o_decimales   = @w_numdec out


--determinar saldo incial con que parte la cuota 
select 
@w_saldo_ini = sum(case tr_tran when 'DES' then dtr_monto else -1*dtr_monto end)
from ca_transaccion, ca_det_trn
where tr_operacion  = dtr_operacion 
and   tr_secuencial = dtr_secuencial
and   tr_fecha_ref  <= @w_fecha_ini
and   tr_tran  in ('PAG', 'DES')
and   dtr_concepto = 'CAP'
and   tr_estado <> 'RV'
and   tr_secuencial >0
and tr_operacion = @w_operacionca  



select 
fecha    = co_fecha_ini,
saldo    =0
into #saldos_inicial
from cob_conta..cb_corte 
where co_empresa = 1
and co_fecha_ini between @w_fecha_ini and @w_fecha_fin


--select * from #saldos_inicial

--determinar saldo despues de la fecha fin  
select 
fechatr = tr_fecha_ref,
monto = sum(case tr_tran when 'DES' then dtr_monto else -1*dtr_monto end)
into #transacciones
from ca_transaccion, ca_det_trn
where tr_operacion  = dtr_operacion 
and   tr_secuencial = dtr_secuencial
and   tr_fecha_ref  between dateadd(dd,1,@w_fecha_ini) and @w_fecha_fin
and   tr_tran  in ('DES', 'PAG')
and   tr_estado <> 'RV'
and   tr_secuencial >0
and   dtr_concepto = 'CAP'
and   tr_operacion = @w_operacionca  
group by tr_fecha_ref



insert into #transacciones values (@w_fecha_ini,@w_saldo_ini) --REGISTRO PARA RESUMIR EL SALDO INICIAL 



select 
fecha    = fecha,
saldo    = isnull(sum(saldo+monto) ,0),
interes  = convert(money,0)
into #saldos_diarios 
from #transacciones,#saldos_inicial
where fecha >=fechatr
group by fecha


--select 1, * from #saldos_inicial

--select 2, * from #transacciones

update #saldos_diarios set 
interes  = isnull(interes,0) +((saldo*@w_tasa_int)/100)/@w_dias_anio


--CALCULO DE INTERES E IVA 

select @w_interes = isnull(sum(interes),0) 
from #saldos_diarios

if @w_interes = 0  begin 
   select 
   @w_msg = 'NO EXISTE VALOR DE TASA INTERES PARA CALCULO DIARIO',
   @w_error = 700009
   goto ERROR_PROCESO

end 


--print 'EL VALOR DEL INTERES CALCULADO PARA EL CORTE ES:'+convert(varchar,@w_interes) 
--select 'SALDO INICIAL',* 	from #saldos_diarios
--select 'TRANSACCIONES', * from #transacciones
--select 'SALDOS DIARIOS', * FROM #saldos_diarios 


---CALCULO FINALES 
select 
intereses_efect_generados = sum(interes),
prom_diario_revolvente    = sum(saldo)/30,
prom_diario_con_intereses = convert(money, null),
prom_diario_sin_intereses = convert(money, null),
suma_promedios            = convert (money, null),
tasa_interes_salida       = convert(float,null)
into #calculo_total
from #saldos_diarios


--SUMATORIA DE LOS PROMEDIOS 
update #calculo_total set 
suma_promedios = (isnull(prom_diario_revolvente,0) +isnull(prom_diario_con_intereses,0) +isnull(prom_diario_sin_intereses,0))

select 
@w_suma_promedios             = isnull(suma_promedios,0),
@w_intereses_efect_generados  =intereses_efect_generados
from #calculo_total

if @w_suma_promedios = 0 if @@rowcount = 0  begin 
   select 
   @w_msg = 'NO EXISTE LA VALOR PARA LA SUMA DE LOS PROMEDIOS',
   @w_error = 700003
   goto ERROR_PROCESO

end 

--select '#calculo_total', * from #calculo_total

--CALCULO DEL INTERES GENRADO 
select @w_interes_estado_cuenta = @w_intereses_efect_generados/@w_suma_promedios/30*@w_dias_anio



select @o_interes_estado_cuenta = round(@w_interes_estado_cuenta*100,@w_numdec)


return 0

ERROR_PROCESO:
    select @w_msg = isnull(@w_msg, 'ERROR GENRAL DEL PROCESO')
	exec cobis..sp_errorlog 
	@i_fecha        = @w_fecha_proceso,
	@i_error        = @w_error,
	@i_usuario      = 'usrbatch',
	@i_tran         = 1,
	@i_descripcion  = @w_msg,
	@i_tran_name    =null,
	@i_rollback     ='S'
	return @w_error



GO
