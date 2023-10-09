/************************************************************************/
/*   Stored procedure:     sp_verifica_vencimiento                      */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Fabian de la Torre                           */
/*   Fecha de escritura:   Ene. 1998                                    */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */

/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Procedimiento que verifica los vencimientos de los dividendos      */
/*      cambiando los estados de los dividendos y rubros por tabla de   */
/*      amortizacion. Controla adicionalmente si el vencimiento se      */
/*      produce en dias feriados para generar dias de gracia para el    */
/*      cobro de la mora.                                               */
/************************************************************************/
/*                              CAMBIOS                                 */
/*      FECHA         AUTOR         CAMBIO                              */
/*   JUN-09-2010      EPB           Quitar Codigo Causacion Pasivas     */
/*   MAY-12-2014      EPB           NR.392 Tablas Fexibles Bancamia     */
/*   JUL-04-2019      DCU           Cambios Soporte #119330             */
/*   JUN-06-2019      ANDYG         Req 116911 Venc Cap LCR             */
/*   SEP-17-2019      LGU           Caso 125959 ajuste estado op lcr    */
/*   FEB-10-2020      DCU           Caso 135046 ajuste cambios de estado*/
/*   JUL-13-2020      DCU           Caso 142361 ajuste cambios          */
/*   NOV-29-2021      DCU           Caso 170130 - IFRS - F1             */
/*   ENE-27-2022      DCU           Caso 177407 - IFRS                  */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_verifica_vencimiento')
   drop proc sp_verifica_vencimiento
go

---NR.392 TABLS FLEXIBLES

create proc sp_verifica_vencimiento
   @s_user            login,
   @s_term            varchar(30),
   @s_date            datetime,
   @s_ofi             int,
   @i_fecha_proceso   datetime,
   @i_operacionca     int,
   @i_oficina         smallint,
   @i_cotizacion      float

as
declare 
   @w_error                int,
   @w_return               int,
   @w_dias_gracia          smallint,
   @w_dia_feriado          datetime,
   @w_siguiente_dia        datetime,
   @w_ciudad               int,
   @w_di_dividendo         smallint,
   @w_di_gracia            smallint,
   @w_di_estado            smallint,
   @w_est_novigente        tinyint,
   @w_est_vigente          tinyint,
   @w_moneda_op            smallint,
   @w_num_dec_op           smallint,
   @w_moneda_mn            smallint,
   @w_num_dec_mn           smallint,
   @w_est_vencido          tinyint,
   @w_est_cancelado        tinyint,
   @w_est_suspenso         tinyint,
   @w_est_castigado        tinyint,
   @w_est_nuevo            tinyint,
   @w_op_estado            tinyint,
   @w_fecha_fin            datetime,
   @w_total_cuota          money,
   @w_total_pagado         money,
   @w_evitar_feriados      char(1),
   @w_banco                cuenta,
   @w_toperacion           catalogo,
   @w_moneda               int,
   @w_fecha_liq            datetime,
   @w_oficial              int,
   @w_oficina              int,
   @w_mora_retroactiva     char(1),
   @w_dias_gracia_disp     int,
   @w_gar_admisible        char,
   @w_reestructuracion     char,
   @w_calificacion         char,
   @w_moneda_nacional      tinyint,
   @w_fecha_ult_proceso    datetime,
   @w_reg_seg              char(1),
   @w_am_concepto          varchar(10),
   @w_am_saldo             float,
   @w_secuencial_prv       int,
   @w_codvalor_base        int,
   @w_sec_ref              int,
   @w_di_fecha_ini         datetime,
   @w_di_fecha_ven         datetime,
   @w_mipymes              catalogo,
   @w_sigte_cuota          smallint,
   @w_parametro_fag        varchar(20),  
   @w_dividendo_vig        int,
   @w_tacuerdo             char(1),           -- REQ 089 - ACUERDOS DE PAGO - 01/DIC/2010   
   @w_tabla_amortizacion   catalogo,           --REQ. 392   Pagos Flexibles
   @w_tflexible            catalogo,           --REQ. 392   Pagos Flexibles
   @w_dias_anio            smallint,
   @w_garantia_gng         char(1),
   @w_parametro_fng        catalogo,
   @w_estado               tinyint,
   @w_valor_commora        money,
   @w_commora_ref          catalogo,
   @w_saldo_mover          money,
   @w_est_etapa2           int

-- CODIGO DE LA MONEDA LOCAL
select @w_moneda_nacional = pa_tinyint
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'ADM'
and    pa_nemonico = 'MLO'

-- CONCEPTO MIPYME
select @w_mipymes = pa_char 
from cobis..cl_parametro with (nolock)
where pa_producto  = 'CCA'
and   pa_nemonico  = 'MIPYME'

/*PARAMETRO DE LA GARANTIA DE FAG*/
select @w_parametro_fag = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'CMFAGP'  -- JAR REQ 197



/*PARAMETRO DE LA GARANTIA DE FAG*/
select @w_parametro_fng = pa_char 
from cobis..cl_parametro 
where pa_producto = 'CCA'
and   pa_nemonico = 'COMFNG'


/*PARAMETRO TIPO DE AMORTIZACION */

 select @w_tflexible = pa_char
 from cobis..cl_parametro
where pa_nemonico = 'TFLEXI'
   if @@rowcount = 0 return  724007 


select 
@w_banco             = op_banco,
@w_toperacion        = op_toperacion,
@w_moneda            = op_moneda,
@w_fecha_liq         = op_fecha_liq,
@w_oficial           = op_oficial,
@w_oficina           = op_oficina,
@w_fecha_ult_proceso = op_fecha_ult_proceso,
@w_mora_retroactiva  = op_mora_retroactiva,
@w_gar_admisible     = isnull(op_gar_admisible,'N'),
@w_reestructuracion  = isnull(op_reestructuracion,'N'),
@w_calificacion      = isnull(op_calificacion,'A'),
@w_op_estado         = op_estado,
@w_moneda_op         = op_moneda,
@w_evitar_feriados   = op_evitar_feriados,
@w_fecha_fin         = op_fecha_fin,
@w_tabla_amortizacion = op_tipo_amortizacion,
@w_dias_anio          = op_dias_anio,
@w_estado             = op_estado
from   ca_operacion with (nolock)
where  op_operacion  = @i_operacionca

-- INICIO - REQ 089: ACUERDOS DE PAGO - 30/NOV/2010



select 
@w_tacuerdo      = ac_tacuerdo
from cob_credito..cr_acuerdo
where ac_banco          = @w_banco
and   ac_estado         = 'V'                         -- NO ANULADOS
and   @w_fecha_ult_proceso between ac_fecha_ingreso and ac_fecha_proy

if @@rowcount = 0 select @w_tacuerdo = 'X'

-- FIN - REQ 089: ACUERDOS DE PAGO - 30/NOV/2010

select 
@w_sec_ref = 0

if @i_fecha_proceso = @w_fecha_liq begin

   select @w_sec_ref = tr_secuencial
   from ca_transaccion
   where tr_operacion = @i_operacionca
   and   tr_tran      = 'DES'
   and   tr_fecha_ref = @i_fecha_proceso
   and   tr_estado   in ('ING','CON')
   
   if @@rowcount = 0 select @w_sec_ref = -999

end



/* ESTADOS DE CARTERA */
exec @w_error = sp_estados_cca
@o_est_novigente  = @w_est_novigente out,
@o_est_vigente    = @w_est_vigente   out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_suspenso   = @w_est_suspenso  OUT,
@o_est_castigado  = @w_est_castigado  OUT,
@o_est_etapa2     = @w_est_etapa2    out 

       
/* GENERAR TRANSACCION VEN SOLO SI ES VENCIMIENTO DE CUOTA */
if @w_sec_ref = 0 begin

   select @w_di_dividendo = di_dividendo
   from   ca_dividendo with (nolock)
   where  di_operacion = @i_operacionca
   and    di_estado    = @w_est_vigente
   and   (di_fecha_ven = @i_fecha_proceso)
   
   if isnull(@w_di_dividendo, 0) > 0
   begin
      exec @w_secuencial_prv = sp_gen_sec
      @i_operacion = @i_operacionca
   
      exec @w_return = sp_historial
      @i_operacionca = @i_operacionca,
      @i_secuencial  = @w_secuencial_prv
   
      if @w_return <> 0 return @w_return
	  
	  
	  ------------------------------------------------------------------------------------------------------------------
	  
      if @w_tabla_amortizacion = 'ROTATIVA'  
      begin
	    /*DETERMINAR TASA DEL COMMORA */
         select
         @w_commora_ref   = ru_referencial
         from   ca_rubro
         where  ru_toperacion = @w_toperacion
         and    ru_moneda     = @w_moneda
         and    ru_concepto   = 'COMMORA'
         
         if @@rowcount = 0 return 701178
         
         /* DETERMINAR LA TASA DE LA COMISION DE MORA */
         select 
         @w_valor_commora  = vd_valor_default 
         from   ca_valor, ca_valor_det
         where  va_tipo   = @w_commora_ref
         and    vd_tipo   = @w_commora_ref
         and    vd_sector = 1 /* sector comercial */
         
         if @@rowcount = 0 return 701085

	
     
        --ingresar el commora en la cuota que vence con el sp_ingreso otros cargos con valor de 60
         exec @w_error     = sp_otros_cargos
         @s_date           = @i_fecha_proceso,
         @s_user           = @s_user,
         @s_term           = @s_term,
         @s_ofi            = @w_oficina,
         @i_banco          = @w_banco,
         @i_moneda         = @w_moneda, 
         @i_operacion      = 'I',
         @i_toperacion     = @w_toperacion,
         @i_desde_batch    = 'N',   
         @i_en_linea       = 'N',
         @i_tipo_rubro     = 'O',
         @i_concepto       = 'COMMORA' ,
         @i_monto          = @w_valor_commora,      
         @i_div_desde      = @w_di_dividendo,      
         @i_div_hasta      = @w_di_dividendo,
         @i_generar_trn     = 'N', 
         @i_comentario     = 'GENERADO POR: sp_verifica_vencimiento'      
                     
         if @w_error <> 0  return @w_error
        
         
		 insert into ca_transaccion_prv with (rowlock)
         select
         tp_fecha_mov       = @s_date,
         tp_operacion       = @i_operacionca,
         tp_fecha_ref       = @i_fecha_proceso,
         tp_secuencial_ref  = @w_sec_ref,      ---------
         tp_estado          = 'ING',
         tp_comprobante     = 0,
         tp_fecha_cont      = null,
         tp_dividendo       = am_dividendo,
         tp_concepto        = am_concepto,
         tp_codvalor        = (co_codigo * 1000) + ((case when @w_estado = @w_est_etapa2 then @w_est_etapa2 else am_estado end) * 10), 
         tp_monto           = am_cuota-am_pagado,
         tp_secuencia       = am_secuencia,
         tp_ofi_oper        = @w_oficina
         from ca_amortizacion, ca_rubro_op, ca_concepto
         where am_operacion = ro_operacion
         and   am_concepto  = ro_concepto
         and   am_concepto  = co_concepto 
         and   ro_provisiona = 'S'
         and   ro_concepto_asociado is null
         and   ro_operacion  = @i_operacionca
         and   am_dividendo  = @w_di_dividendo		 
         and   am_cuota-am_acumulado  >= 0.01    
         and   am_estado <> @w_est_cancelado
         
         if @@error <> 0 return  710001 
		 
         --llevar el acumulado al total acumulado cuota INT e IVAINT 
       
         update ca_amortizacion with (rowlock)  set    
         am_acumulado = am_cuota
         from   ca_rubro_op
         where  am_operacion = ro_operacion
         and    am_concepto  = ro_concepto
         and    (am_gracia <= 0 or am_cuota <> 0)                  
         and    ro_operacion = @i_operacionca
         and    am_dividendo = @w_di_dividendo
         and    ro_provisiona = 'S'
         --and    ro_concepto_asociado is null --El IVA_INT a pesar que no se contabilice, se debe igual el proyectado al acumulado al vencimiento
         and    am_cuota-am_acumulado  >= 0.01 
         and   am_estado <> @w_est_cancelado		 
        
      end --SOLO PARA TABLAS ROTATIVAS
	  
	  ------------------------------------------------------------------------------------------------------------------
	 
	  ---Generacion cabecera por vencimiento de dividendo (reclasificacion de cuentas)
      insert into ca_transaccion with (rowlock)(
      tr_secuencial,       tr_fecha_mov,              tr_toperacion,
      tr_moneda,           tr_operacion,              tr_tran,
      tr_en_linea,         tr_banco,                  tr_dias_calc,
      tr_ofi_oper,         tr_ofi_usu,                tr_usuario,
      tr_terminal,         tr_fecha_ref,              tr_secuencial_ref,
      tr_estado,           tr_observacion,            tr_gerente,
      tr_comprobante,      tr_fecha_cont,             tr_gar_admisible,
      tr_reestructuracion, tr_calificacion)           
      values(                                         
      @w_secuencial_prv,   @s_date,                   @w_toperacion,
      @w_moneda,           @i_operacionca,            'VEN',
      'N',                 @w_banco,                  0,
      @w_oficina,          @w_oficina,                @s_user,
      @s_term,             @i_fecha_proceso,          0,
      'ING',               'VERIFICA VENCIMIENTO',    @w_oficial,
      0,                   @s_date,                   @w_gar_admisible,
      @w_reestructuracion, @w_calificacion)
            
      if @@error <> 0 return 703041
   
      ---Generacion de detalles por vencimiento de dividendo (reclasificacion de cuentas)
      insert into ca_det_trn
      select 
      dtr_secuencial   = @w_secuencial_prv,
      dtr_operacion    = @i_operacionca,
      dtr_dividendo    = @w_di_dividendo,
      dtr_concepto     = am_concepto,
      dtr_estado       = @w_est_vigente,
      dtr_periodo      = 0,
	      dtr_codvalor     = co_codigo * 1000 + case when @w_estado = @w_est_etapa2 then @w_est_etapa2 * 10 + am_estado else am_estado * 10 end , 
      dtr_monto        = sum(am_acumulado - am_pagado),  
      dtr_monto_mn     = 0,
      dtr_moneda       = @w_moneda,
      dtr_cotizacion   = 1,
      dtr_tcotizacion  = 'N',
      dtr_afectacion   = 'D',
      dtr_cuenta       = '',
      dtr_beneficiario = '',
      dtr_monto_cont   = 0
      from ca_amortizacion, 
           ca_concepto
      where am_operacion = @i_operacionca
      and   am_dividendo = @w_di_dividendo
      and   co_concepto  = am_concepto
	  and   am_estado <> @w_est_cancelado
      group by am_dividendo, am_concepto, case am_estado when @w_est_novigente then @w_estado else am_estado end,
               --co_codigo * 1000 + am_estado * 10
               co_codigo * 1000 + case when @w_estado = @w_est_etapa2 then @w_est_etapa2 * 10 + am_estado else am_estado * 10 end
      having sum(am_acumulado - am_pagado) > 0	
	
      if @@error <> 0 return 710031
      ---Generacion de detalles por vencimiento de dividendo (reclasificacion de cuentas)
   end
end

-- MANEJO DE DECIMALES
exec @w_return = sp_decimales
@i_moneda      = @w_moneda_op,
@o_decimales   = @w_num_dec_op out

if @w_return <> 0 return @w_return

-- DETERMINAR DIAS DE GRACIA PARA NO COBRAR MORA EN FERIADOS
select @w_ciudad  = of_ciudad
from   cobis..cl_oficina with (nolock)
where  of_oficina = @i_oficina
set transaction isolation level read uncommitted

exec @w_return = sp_dia_habil
@i_fecha  = @i_fecha_proceso,
@i_ciudad = @w_ciudad,
@i_real   = 'S',
@o_fecha  = @w_siguiente_dia out

if @w_return <> 0 return @w_return

select 
@w_di_dividendo     = di_dividendo
from   ca_dividendo with (nolock)
where  di_operacion = @i_operacionca
and    di_fecha_ven = @i_fecha_proceso

select 
@w_dias_gracia      = 0,
@w_dias_gracia_disp = 0

if @w_mora_retroactiva = 'S'  begin--si generan dias de gracia automaticos 
   select @w_dias_gracia      = datediff(dd,@i_fecha_proceso,@w_siguiente_dia)
   select @w_dias_gracia_disp = @w_dias_gracia
end 

if @w_dias_gracia = 0
   select 
   @w_dias_gracia      = isnull(di_gracia,0),
   @w_dias_gracia_disp = isnull(di_gracia_disp,0)
   from   ca_dividendo with (nolock)
   where  di_operacion = @i_operacionca
   and    di_fecha_ven = @i_fecha_proceso
   

select @w_reg_seg = 'S'

if  @w_sec_ref = 0 
and exists (select 1 from   cobis..cl_dias_feriados with (nolock)
where  df_fecha = @i_fecha_proceso
and    df_ciudad =  @w_ciudad)
begin
   select  @w_reg_seg = 'N'
   
   delete  ca_gracia_seguros  
   where gs_operacion = @i_operacionca
   
   insert into ca_gracia_seguros(
   gs_operacion,    gs_fecha_regeneracion,  gs_cuota)
   values(
   @i_operacionca,  @w_siguiente_dia,       @w_di_dividendo)
   
end

---RECALCULO DEL SEGURO
if  @w_reg_seg = 'S'
and @w_sec_ref = 0 
and (@w_op_estado <> 4) -- NO ESTE CASTIGADA
and (select count(1) from ca_rubro_op with (nolock), ca_concepto with (nolock)
     where  ro_concepto  = co_concepto
     and    ro_operacion = @i_operacionca
     and    ro_saldo_insoluto = 'S'
     and    co_categoria = 'S') > 0
begin

   exec @w_return =  sp_recalculo_seguros_sinsol
   @i_operacion = @i_operacionca
   
   if @w_return <> 0 return @w_return
end 
   
-- LAZO PARA PROCESAR LA CUOTA VIGENTE Y NO VIGENTE
declare cur_dividendos cursor for select 
di_dividendo, di_gracia, di_estado, di_fecha_ini, di_fecha_ven
from   ca_dividendo with (nolock)
where  di_operacion = @i_operacionca
and   (di_fecha_ven = @i_fecha_proceso or di_fecha_ini = @i_fecha_proceso)
for read only

open cur_dividendos

fetch cur_dividendos into  
@w_di_dividendo, @w_di_gracia, @w_di_estado, @w_di_fecha_ini, @w_di_fecha_ven

while @@fetch_status = 0  begin

   if @w_dias_gracia < @w_di_gracia select @w_dias_gracia = @w_di_gracia
   
   select @w_total_cuota = isnull(sum(am_cuota + am_gracia - am_pagado),0)
   from   ca_amortizacion
   where  am_operacion = @i_operacionca
   and    am_dividendo = @w_di_dividendo
   and    am_estado   <> @w_est_cancelado
   
   -- SI LA CUOTA PROCESADA ES VIGENTE Y NO TIENE SALDO, CANCELARLA
   if @w_di_fecha_ven = @i_fecha_proceso and @w_total_cuota < 0.01  begin
   
      update ca_amortizacion  with (rowlock)
      set    am_estado    = @w_est_cancelado
      where  am_operacion = @i_operacionca
      and    am_dividendo = @w_di_dividendo

      if @@error <> 0 return 710002
      
      update ca_dividendo with (rowlock) set    
	  di_estado      = @w_est_cancelado,
      di_gracia      = @w_dias_gracia,
      di_gracia_disp = @w_dias_gracia_disp,
      di_fecha_can   = @w_fecha_ult_proceso
      where  di_operacion = @i_operacionca
      and    di_dividendo = @w_di_dividendo
      
      if @@error <> 0 return 705043
      
      select @w_di_estado = @w_est_cancelado
   end 
   
   -- SI LA CUOTA PROCESADA ES VIGENTE Y TIENE SALDO, DECLARARLA VENCIDA
   if @w_di_fecha_ven = @i_fecha_proceso and @w_total_cuota >= 0.01  
   begin
   
      update ca_dividendo with (rowlock) set   
	  di_estado      = @w_est_vencido,
      di_gracia      = @w_dias_gracia,
      di_gracia_disp = @w_dias_gracia_disp
      where  di_operacion = @i_operacionca
      and    di_dividendo = @w_di_dividendo
      
      if @@error <> 0 return 705043
      
      select @w_di_estado = @w_est_vencido
   end

   -- SI LA CUOTA PROCESADA ES NO VIGENTE, DECLARARLA VIGENTE
   if @w_di_fecha_ini = @i_fecha_proceso  
   begin
      update ca_dividendo with (rowlock) set
	      di_estado = @w_est_vigente
      where  di_operacion = @i_operacionca
      and    di_dividendo = @w_di_dividendo
      
      if @@error <> 0 return 705043
      
      update ca_amortizacion with (rowlock) 
      set    am_estado  = CASE @w_op_estado 
                             WHEN @w_est_vencido   THEN @w_est_suspenso 
                             WHEN @w_est_castigado THEN @w_est_castigado 
                             ELSE @w_est_vigente 
                          END
      where am_operacion = @i_operacionca
      and   am_dividendo = @w_di_dividendo
      and   am_estado    = @w_est_novigente
      and  am_concepto <> 'CAP'
      
      if @@error <> 0 return  705050

      update ca_amortizacion with (rowlock) set
      am_estado  =	CASE @w_op_estado 
	  				WHEN @w_est_vencido   THEN @w_est_vencido 
	  				WHEN @w_est_castigado THEN @w_est_castigado 
	      			ELSE @w_est_vigente 
		  			END
      where am_operacion = @i_operacionca
      and   am_dividendo = @w_di_dividendo
      and   am_estado    = @w_est_novigente
      and   am_concepto  = 'CAP'

      if @@error <> 0 return  705050
      
	  select @w_di_estado = @w_est_vigente
	  
	  insert into ca_transaccion_prv with (rowlock)
      select
      tp_fecha_mov       = @s_date,
      tp_operacion       = @i_operacionca,
      tp_fecha_ref       = @i_fecha_proceso,
      tp_secuencial_ref  = @w_sec_ref,
      tp_estado          = 'ING',
      tp_comprobante     = 0,
      tp_fecha_cont      = null,
      tp_dividendo       = am_dividendo,
      tp_concepto        = am_concepto,
	      tp_codvalor    =(co_codigo * 1000) + ((case when @w_estado = @w_est_etapa2 then @w_est_etapa2 else am_estado end) * 10), --(co_codigo * 1000) + (am_estado * 10),
      tp_monto           = am_cuota - isnull(am_acumulado,0),
      tp_secuencia       = am_secuencia,
      tp_ofi_oper        = @w_oficina
      from ca_amortizacion, ca_rubro_op, ca_concepto
      where am_operacion = ro_operacion
      and   am_concepto  = ro_concepto
      and   am_concepto  = co_concepto 
      and   ro_provisiona = 'S'
      and   ro_tipo_rubro  not in('C','F',	'I','M') 
      and   ro_concepto_asociado is null
      and   ro_operacion  = @i_operacionca
      and   am_dividendo  = @w_di_dividendo  
      and   am_cuota     >= 0.01    
      and   am_cuota     <> am_acumulado
      

      if @@error <> 0 return  710001
       
  
	 update ca_amortizacion with (rowlock)  set    
	  am_acumulado = am_cuota
	  from   ca_rubro_op
      where  am_operacion = ro_operacion
      and    am_concepto  = ro_concepto
      and    (am_gracia <= 0 or am_cuota <> 0)                  -- REQ 175: PEQUE-A EMPRESA - RESPETA ESTADO Y VALOR DE CUOTA DE RUBROS CON GRACIA POSITIVA
      and    ro_operacion = @i_operacionca
      and    am_dividendo = @w_di_dividendo
	  and    ro_provisiona = 'S'
      and    ro_tipo_rubro  not in('C','F',	'I','M') 
      and   ro_concepto_asociado is null
	  
	  if @@error <> 0 return  705050
	  	
      
	  	  
   end --existe dividendo no vigente 
   
   fetch cur_dividendos into  @w_di_dividendo, @w_di_gracia, @w_di_estado, @w_di_fecha_ini, @w_di_fecha_ven
   
end

close cur_dividendos
deallocate cur_dividendos
  
return 0

go

