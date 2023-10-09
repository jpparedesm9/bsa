/************************************************************************/
/*  archivo:                lcr_crearcuota_tmp.sp                       */
/*  stored procedure:       sp_lcr_crear_cuota_tmp                      */
/*  base de datos:          cob_cartera                                 */
/*  producto:               credito                                     */
/*  disenado por:           Dario Cumbal                                */
/*  fecha de documentacion: Marzo 2021                                  */
/************************************************************************/
/*          importante                                                  */
/*  este programa es parte de los paquetes bancarios propiedad de       */
/*  "macosa",representantes exclusivos para el ecuador de la            */
/*  at&t                                                                */
/*  su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  presidencia ejecutiva de macosa o su representante                  */
/************************************************************************/
/*          proposito                                                   */
/*             CREA CUOTA MINIMA DE LA LCR                              */
/************************************************************************/
/*                             MODIFICACION                             */
/* 16/06/2021         DCU                 Inicial                       */
/************************************************************************/  

use cob_cartera 
go

if exists(select 1 from sysobjects where name ='Lcr_Calcular_Cuota_Tmp')
	drop function Lcr_Calcular_Cuota_Tmp
go

create function Lcr_Calcular_Cuota_Tmp(
@i_banco              varchar(20),
@i_fecha_proceso      datetime        =null  
)
returns money
as
begin
   declare 
   @w_tdividendo 		 char(2),
   @w_periodo_int    	 int,
   @w_plazo  			 int,
   @w_evitar_feriados   char(1),
   @w_ciudad_nacional   int,
   @w_fecha_fin         datetime ,
   @w_dias_gracia       int ,
   @w_est_suspenso      tinyint,
   @w_param_cuotas      int,
   @w_param_umbral      money,
   @w_param_vencidos    int,
   @w_moneda            int,
   @w_numdec            int,
   @w_saldo_cap         money,
   @w_sp_name           descripcion,
   @w_banco             cuenta,
   @w_iva               float,
   @w_fecha_proceso     datetime,
   @w_monto             money,
   @w_cap_min           money,
   @w_factor            int,
   @w_dia_pago          int,
   @w_toperacion        catalogo, 
   @w_oficina_op        int ,     
   @w_fecha_ult_proceso datetime ,
   @w_oficial           int,
   @w_tasa_int          float,
   @w_interes           money ,
   @w_op_estado         int,
   @w_cuota             money ,
   @w_tramite           int,
   @w_dias_anio         int,
   @w_diferencia        FLOAT ,
   @w_sec_ultima_dispo  int,
   @w_interes_calc      money,
   @w_valor_calculado   money,
   @w_operacionca       int
  
   
   --INICIALIZACION DE VARIABLES   
   select 
   @w_sp_name          = 'sp_lcr_crear_cuota',  
   @w_numdec           = 2,
   @w_fecha_proceso    = fp_fecha from cobis..ba_fecha_proceso
   
   
   --INICIALIZACION DE CUOTA MINIMA    
   select @w_ciudad_nacional = pa_int
   from   cobis..cl_parametro with (nolock)
   where  pa_nemonico = 'CIUN'
   and    pa_producto = 'ADM'
   
   /* CONTROLAR DIA MINIMO DEL MES PARA FECHAS DE VENCIMIENTO */
    
   --DIAS DE GRACIA
   select @w_dias_gracia = pa_int
   from   cobis..cl_parametro with (nolock)
   where  pa_nemonico = 'LCRGRA'
   and    pa_producto = 'CCA'
   
   --PARAMETRO DE CUOTA DIVIDIR 
   select @w_param_cuotas = pa_int
   from   cobis..cl_parametro with (nolock)
   where  pa_nemonico = 'LCRCUO'
   and    pa_producto = 'CCA'
   
   --PARAMETRO UMBRAL
   select @w_param_umbral = pa_money
   from   cobis..cl_parametro with (nolock)
   where  pa_nemonico = 'LCRUMB'
   and    pa_producto = 'CCA'
   
   --PARAMETRO CUOTAS VENCIDAS
   select @w_param_vencidos = pa_int
   from   cobis..cl_parametro with (nolock)
   where  pa_nemonico = 'NCPPV'
   and    pa_producto = 'CCA'

   
   select 
   @w_dias_gracia     = isnull(@w_dias_gracia, 7),
   @w_param_cuotas    = isnull(@w_param_cuotas, 3),
   @w_param_umbral    = isnull(@w_param_umbral, 100.0),
   @w_param_vencidos  = isnull(@w_param_vencidos , 3)
   
   select 
   @w_operacionca       = op_operacion,
   @w_banco             = op_banco,
   @w_fecha_fin         = op_fecha_fin,
   @w_periodo_int       = op_periodo_int,
   @w_plazo             = op_plazo,
   @w_tdividendo        = op_tdividendo,
   @w_evitar_feriados   = op_evitar_feriados,
   @w_moneda            = op_moneda,
   @w_monto             = op_monto,
   @w_dia_pago          = op_dia_fijo,
   @w_toperacion        = op_toperacion,
   @w_oficina_op        = op_oficina,
   @w_fecha_ult_proceso = op_fecha_ult_proceso,
   @w_oficial           = op_oficial,
   @w_op_estado         = op_estado,
   @w_tramite           = op_tramite,
   @w_dias_anio         = isnull(op_dias_anio,360)   
   from   ca_operacion
   where  op_banco   = @i_banco
        
   select @w_factor  = td_factor
   from   ca_tdividendo 
   where  td_tdividendo = @w_tdividendo
   
   select @w_iva     = ro_porcentaje 
   from  ca_rubro_op 
   where ro_operacion  = @w_operacionca 
   and   ro_concepto   = 'IVA_INT'
   
   select @w_tasa_int   = ro_porcentaje 
   from  ca_rubro_op 
   where ro_operacion  = @w_operacionca 
   and   ro_concepto   = 'INT'
   
   --VERIFICAR SI TIENE 3 CUOTAS VENCIDAS 
   select @w_sec_ultima_dispo = max(tr_secuencial)
   from cob_cartera..ca_transaccion
   where tr_operacion = @w_operacionca
   and tr_secuencial  > 0
   and tr_tran       = 'DES'
   and tr_estado    <> 'RV'
   and tr_fecha_ref < @i_fecha_proceso

   select @w_saldo_cap = dtr_monto
   from cob_cartera..ca_det_trn
   where dtr_operacion = @w_operacionca
   and dtr_secuencial  = @w_sec_ultima_dispo
   and dtr_concepto    = 'CAP' 
     
   --CASO 1 SALDO CAPITAL ES MAYOR A TRES VECES EL UMBRAL 
   if (@w_saldo_cap > @w_param_cuotas*@w_param_umbral )  select @w_cap_min = isnull(round(@w_saldo_cap/@w_param_cuotas,@w_numdec),0)
   --CASO 2 SALDO CAPITAL ENTRE 3 VECES EL UMBRAL Y EL UMBRAL 
   if (@w_saldo_cap between @w_param_umbral and (@w_param_cuotas*@w_param_umbral)) select @w_cap_min =@w_param_umbral
   --CASO 3 EL SALDO DE CAPITAL ES MENOR AL UMBRAL 
   if (@w_saldo_cap < @w_param_umbral) select @w_cap_min = @w_saldo_cap  
   
   --determinar saldo incial con que parte la cuota 
   select @w_interes_calc  = round(((@w_cap_min*@w_tasa_int)/100)/@w_dias_anio,@w_numdec)
   
   
   --CALCULO DE INTERES E IVA 
   select @w_iva = round(@w_interes_calc*ro_porcentaje/100, @w_numdec)
   from ca_rubro_op 
   where ro_operacion = @w_operacionca
   and ro_concepto = 'IVA_INT'

   select @w_iva = isnull(@w_iva,0)

   select @w_valor_calculado = isnull(@w_cap_min,0) + isnull(@w_iva,0) + isnull(@w_interes_calc,0)

   return @w_valor_calculado

end

go