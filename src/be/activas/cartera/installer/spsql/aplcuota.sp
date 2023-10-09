/************************************************************************/
/*      Base de datos:           cob_cartera                            */
/*      Producto:                Cartera                                */
/*      Archivo:                 aplcuota.sp                            */
/*      Procedimiento:           sp_aplicacion_cuota                    */
/*      Disenado por:            MPO                                    */
/*      Fecha de escritura:      15 de Abril 1997                       */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'.                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Aplica el abono. Este procedimiento considera la aplicacion por */
/*      cuota.                                                          */
/*                    CAMBIOS                                           */
/*      FECHA         AUTOR         CAMBIO                              */
/*      Enero-2003    EPB           Personalizacion BAC                 */
/*      SEP 2006      FQ            Optimizacion 152                    */
/*      ENE-28-2010   ITO           Req.00088 CalHOnorarios             */
/*      JUL-04-2012   LCM           Req.00293 Rec FNG y USAID           */
/*      JUL-08-2014   LCM           Req.00433 Pagos Anticipados         */
/*      FEB-25-2014   I.Berganza    Req: 397 - Reportes FGA             */
/*      ABR-2014      LCO           Req424 Ajuste pagos recibidos de    */
/*                                         clientes con reconocimiento  */
/*                                         de garantías con recuperación*/
/*      05/12/2016          R. Sánchez            Modif. Apropiación    */
/*      05/05/2020    DCU           Req. 138837 desplazamiento          */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_aplicacion_cuota')
   drop proc sp_aplicacion_cuota
go
---Homologar 397 y 424 VAr.PRod. 
create proc sp_aplicacion_cuota
@s_sesn                 int          = NULL,
@s_user                 login        = NULL,
@s_term                 varchar (30) = NULL,
@s_date                 datetime     = NULL,
@s_ofi                  smallint     = NULL,
@i_secuencial_ing       int,
@i_secuencial_pag       int,
@i_fecha_proceso        datetime,
@i_operacionca          int,
@i_en_linea             char(1),
@i_tipo_reduccion       char(1),
@i_tipo_cobro           char(1),
@i_monto_pago           float,
@i_cotizacion           money,
@i_tcotizacion          char(1),
@i_num_dec              smallint,
@i_saldo_capital        money     = NULL,
@i_pago_vigente         char(1)   = 'N',
@i_dias_anio            int       = 360,
@i_base_calculo         char(1)   = 'R',
@i_tipo                 char(1)   = 'N',
@i_aceptar_anticipos    char(1),
@i_tasa_prepago         float     = 0,
@i_dividendo            int       = 0,       
@i_cancela              char(1)   = 'N',
@i_monto_vencido        money     = 0,
@i_cotizacion_dia_sus   float     = null,
@i_tiene_reco           char(1)   = 'N',
@i_abono_extraordinario char(1)   = 'N',
@o_sobrante             money     = NULL out

as
declare
@w_ap_prioridad         int,
@w_est_cancelado        tinyint,
@w_est_vencido          tinyint,
@w_est_novigente        tinyint,
@w_est_vigente          tinyint,
@w_max_dividendo        int,   
@w_di_dividendo         int,
@w_di_fecha_ini         datetime,
@w_di_fecha_ini_aux     datetime,
@w_di_fecha_ven         datetime,
@w_di_fecha_ven_aux     datetime,
@w_monto_prioridad      money,
@w_monto_dividendo      money,
@w_monto_dividendo_a    money,
@w_monto_pago           money,
@w_am_concepto          catalogo,
@w_ro_tipo_rubro        char(1),
@w_monto_rubro          money,
@w_total_div            money,
@w_salir_prioridad      char(1),
@w_salir_dividendo      char(1),
@w_salir_rubro          char(1),
@w_salir_secuencia      char(1),
@w_secuencia            int,
@w_pa                   char(1),
@w_div_vigente          int,
@w_contador             int,
@w_inicial_prioridad    float,
@w_inicial_rubro        float,
@w_tipo                 char(1),
@w_ahorro               money,
@w_devolucion           money,
@w_ahorro_tot           money,
@w_cancelar_div         char(1),
@w_tipo_cobro_o         char(1),
@w_fpago                char(1),
@w_periodo_int          int,
@w_tdividendo           catalogo,
@w_di_estado            int,
@w_forma_pago_int       char(1),
@w_base_calculo         char(1),
@w_recalcular           char(1),
@w_saldo_oper           money,
@w_saldo_ant            money,
@w_saldo_ven            money,
@w_tasa_prepago         float,
@w_contador_div         int,
@w_dias_cuota           int ,
@w_dd                   int ,
@w_dd_antes             int ,
@w_dd_despues           int ,
@w_num_dec_tapl         tinyint,
@w_tramite              int,
@w_moneda               smallint,
@w_concepto_int         catalogo,
@w_gar_admisible        char(1),
@w_codvalor_nov         int,
@w_codvalor_vig         int,
@w_monto_intfact        money,
@w_numdec_op            tinyint,
@w_causacion            char(1),
@w_ro_concepto          catalogo,
@w_ro_fpago             char(1),
@w_am_cuota_anterior    money,
@w_am_pagado_anterior   money,
@w_op_banco             cuenta, 
@w_dias_anio            smallint,
@w_float                float,
@w_valor_calc           money,
@w_ro_porcentaje        float,
@w_error                int,
@w_de_capital           char(1),
@w_primer_vigente       int,
@w_banco                cuenta,
@w_num_dividendos       int,
@w_cuota                money,
@w_fecha_fin            datetime,
@w_estado_dividendo     int,
@w_int_ant              catalogo,
@w_fecha_ven_op         datetime,
@w_fecha_cartera        datetime,
@w_modo                 char(1),
@w_est_suspenso         tinyint, 
@w_estado_op            tinyint, 
@w_edad_op              tinyint, 
@w_categoria_forma      catalogo,
@w_nota_debito          char(1),
@w_forma_pago           catalogo,
@w_int                  catalogo,
@w_dias                 int,
@w_dias_paso            int,
@w_valor_futuro_int     money,
@w_vp_int               money,
@w_acumulado_int_org    money,
@w_causacion_pte        money,
@w_fecha_ult_proceso    datetime,
@w_gerente              int,
@w_am_periodo           tinyint,
@w_secuencial_vp        int,
@w_toperacion           catalogo,
@w_causacion_pte_mn     money,
@w_codvalor             int,
@w_reestructuracion     char(1),
@w_am_estado            tinyint,
@w_oficina_op           int,
@w_calificacion         char(1),
@w_codvalor1            int,
@w_observacion          varchar(50),
@w_cuota_cap            money,
@w_valor_int_cap        money,
@w_no_cobrado_int       money,
@w_int_en_vp            money,
@w_dias_vp              int,
@w_max_secuencia        int,
@w_moneda_uvr           smallint,
@w_seguro               char(1),
@w_saldo_seg            money,
@w_saldo_seg_cot_hoy    money,
@w_saldo_seg_mn         money,
@w_vlr_despreciable     float,
@w_bandera_be           char(1),  --Para enviarla a Garantias
@w_rowcount_act         int,
@w_rowcount             int,
@w_estado_cob           char(4),  -- ITO 25Ene2010
@w_monto_cuota          money,    
@w_monto_honorario      float,
@w_monto_iva            float,
@w_hono_cc              catalogo,
@w_hono_cp              catalogo,
@w_hono_cj              catalogo,
@w_iva_cc               catalogo,
@w_iva_cp               catalogo,
@w_iva_cj               catalogo,
@w_iva                  float,
@w_proporcional         char(1),
@w_monto_analisis       money,
@w_monto_mipyme         money,
@w_monto_ivapyme        money,
@w_ivamipymes           catalogo,
@w_mipymes              catalogo,
@w_gracia_int           smallint,                              -- REQ 175: PEQUEÑA EMPRESA
@w_dist_gracia          char(1),                               -- REQ 175: PEQUEÑA EMPRESA
@w_numdec_mn            tinyint,                               -- REQ 175: PEQUEÑA EMPRESA
@w_secuencial           int,                                   -- REQ 175: PEQUEÑA EMPRESA
@w_tacuerdo             char(1),                               -- REQ 089: ACUERDOS DE PAGO - 14/ENE/2011
@w_concepto_CAP         catalogo,
@w_porc_cubrim          float, --LCM - 293
@w_vlr_cap              money, --LCM - 293
@w_vlr_req              money, --LCM - 293
@w_sob_rec              money,  --LCM - 293
@w_monto_reconocer      money, --LCM - 293
@w_sec_rpa_rec          int, --LCM - 293
@w_sec_rpa_pag          int, --LCM - 293
@w_cap_pag_rec          money, --LCM - 293
@w_1_div_vencido        tinyint, --LCM - 293
@w_porc_rec             float,   --LCM - 293
@w_cap_div              money,   --LCM - 293
@w_vlr_calc_fijo        money,       --LCM - 293
@w_div_pend             money,        --LCM - 293
--REQ424
@w_vlr_amort            money,   
@w_div_venc             smallint, 
@w_recono               money,
@w_operacionca          int,
@w_pri_div_pag          int

-- REQ 089: ACUERDOS DE PAGO - 14/ENE/2011

-- REQ 089: ACUERDOS DE PAGO - 14/ENE/2011
-- INICIALIZACION DE VARIABLES

select 
@w_no_cobrado_int    = 0,
@w_int_en_vp         = 0,
@w_cuota_cap         = 0,
@w_valor_int_cap     = 0,
@w_est_novigente     = 0,
@w_est_vigente       = 1,
@w_est_vencido       = 2,
@w_est_cancelado     = 3,
@w_salir_prioridad   = 'N',
@w_salir_dividendo   = 'N',
@w_salir_rubro       = 'N',
@w_salir_secuencia   = 'N',
@w_di_fecha_ini      = @i_fecha_proceso,
@w_ahorro_tot        = 0,
@w_tipo_cobro_o      = @i_tipo_cobro,
@w_tasa_prepago      = @i_tasa_prepago,
@w_contador_div      = 0,
@w_num_dec_tapl      = null,
@w_nota_debito       = 'N',
@w_acumulado_int_org = 0,
@w_causacion_pte     = 0,
@w_monto_pago        = @i_monto_pago,
@w_dias_vp           = 0,
@w_max_secuencia     = 0,
@w_vlr_despreciable  = 0,
@w_porc_cubrim       = 0, --LCM - 293
@w_vlr_cap           = 0, --LCM - 293
@w_vlr_req           = 0, --LCM - 293
@w_vlr_calc_fijo     = 0, --LCM - 293
@w_div_pend          = 0,  --LCM - 293
@w_operacionca       = @i_operacionca

--REQ424
--VALOR DE AMORTIZACIÓN DEL RECONOCIMIENTO Y DIVIDENDO 
select
@w_vlr_amort     = pr_vlr_amort,  
@w_div_venc      = pr_div_venc 
from cob_cartera..ca_pago_recono
where pr_operacion = @i_operacionca
and   pr_estado    = 'A'

select @w_vlr_despreciable = 1.0 / power(10, isnull(@i_num_dec, 4))

select @w_est_suspenso  = isnull(es_codigo, 255)
from   ca_estado
where  rtrim(ltrim(es_descripcion)) = 'SUSPENSO'

select @w_est_novigente  = isnull(es_codigo, 255)
from ca_estado
where rtrim(ltrim(es_descripcion)) = 'NO VIGENTE'

-- CONSULTA DE LOS DATOS DE LA OPERACION
select 
@w_op_banco          = op_banco,
@w_dias_anio         = op_dias_anio,
@w_estado_op         = op_estado,    
@w_edad_op           = op_edad,
@w_periodo_int       = op_periodo_int,
@w_tdividendo        = op_tdividendo,
@w_base_calculo      = op_base_calculo,
@w_recalcular        = op_recalcular_plazo,
@w_tramite           = op_tramite,
@w_tipo              = op_tipo,
@w_causacion         = op_causacion,
@w_gar_admisible     = op_gar_admisible,
@w_moneda            = op_moneda,
@w_banco             = op_banco,
@w_cuota             = op_cuota,
@w_gerente           = op_oficial,
@w_fecha_ult_proceso = op_fecha_ult_proceso,
@w_reestructuracion  = op_reestructuracion,
@w_calificacion      = op_calificacion,
@w_oficina_op        = op_oficina,
@w_toperacion        = op_toperacion,
@w_estado_cob        = op_estado_cobranza,
@w_gracia_int        = op_gracia_int,                          -- REQ 175: PEQUEÑA EMPRESA
@w_dist_gracia       = op_dist_gracia                          -- REQ 175: PEQUEÑA EMPRESA
from   ca_operacion 
where  op_operacion = @i_operacionca

-- INICIO - REQ 089: ACUERDOS DE PAGO - 30/NOV/2010
select @w_tacuerdo = ac_tacuerdo
from cob_credito..cr_acuerdo
where ac_banco                   = @w_op_banco
and   ac_estado                  = 'V'                         -- NO ANULADOS
and   @w_fecha_ult_proceso between ac_fecha_ingreso and ac_fecha_proy

if @@rowcount = 0 select @w_tacuerdo = 'X'
-- FIN - REQ 089: ACUERDOS DE PAGO - 30/NOV/2010

-- PARAMETROS GENERALES
select @w_int_ant = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'INTANT'
if @@rowcount = 0  
   return 710256

-- PARAMETROS GENERALES
select @w_moneda_uvr = pa_tinyint
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'MUVR'
if @@rowcount = 0   
   return 710256

-- PARAMETROS GENERALES
select @w_int = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'INT'
if @@rowcount = 0   
   return 710256

   
select @w_iva = pa_float
from  cobis..cl_parametro
where pa_nemonico = 'PIVA'
and pa_producto = 'CTE'
if @@rowcount = 0
   return 710256
      

-- PARAMETROS GENERALES
select @w_ivamipymes  =  pa_char
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'IVAMIP'
if @@rowcount = 0
   return 710256

   
select @w_mipymes  =  pa_char
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'MIPYME'
if @@rowcount = 0
   return 710256

select @w_concepto_CAP  =  pa_char
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'CAP'
if @@rowcount = 0
   return 710256
     
-- SELECCION DEL DIVIDENDO VIGENTE
select @w_div_vigente = isnull(max(di_dividendo),0)
from   ca_dividendo
where  di_operacion   = @i_operacionca
and    di_estado      = @w_est_vigente

if @w_div_vigente = 0
begin
   select @w_div_vigente = isnull(max(di_dividendo), -1)
   from   ca_dividendo
   where  di_operacion   = @i_operacionca
   and    di_estado      = 2
   
   if @w_div_vigente = -1
      return 708163
end


/* LCM - 293: CONSULTA LA TABLA DE RECONOCIMIENTO PARA VALIDAR SI LA OBLIGACION TIENE RECONOCIMIENTO */
if @i_tiene_reco = 'S'
   select @w_vlr_calc_fijo = isnull(pr_vlr_calc_fijo,0),
          @w_div_pend      = isnull(pr_div_pend,0)
   from ca_pago_recono with (nolock)
   where pr_operacion = @i_operacionca
   and   pr_estado = 'A'
-- SIGLA DE PERIODICIDAD ANUAL
select @w_pa = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'PAN'
and    pa_producto = 'CCA'

-- FORMA DE PAGO DEL RUBRO INTERES
select @w_forma_pago_int = ro_fpago,
       @w_num_dec_tapl   = ro_num_dec,
       @w_concepto_int   = ro_concepto
from   ca_rubro_op
where  ro_operacion  = @i_operacionca
and    ro_tipo_rubro = 'I'

if @w_forma_pago_int = 'P' 
   select @w_forma_pago_int = 'V'

-- MANEJO DE DECIMALES
exec @w_error = sp_decimales
@i_moneda       = @w_moneda,
@o_decimales    = @w_numdec_op out,
@o_dec_nacional = @w_numdec_mn out

-- DETERMINAR CATEGORIA FORMA DE PAGO
select @w_forma_pago = abd_concepto
from   ca_abono_det
where  abd_operacion = @i_operacionca
and    abd_secuencial_ing = @i_secuencial_ing
and    abd_tipo = 'PAG'

select @w_categoria_forma = cp_categoria
from   ca_producto
where  cp_producto = @w_forma_pago

if @w_categoria_forma in ('NDAH', 'NDCC')
   select @w_nota_debito = 'S'
else
   select @w_nota_debito = 'N' 

-- ESTO SE MANEJA PARA EL RETORNO DE LOS MONTO PROYECTADOS DE CADA RUBRO
if @i_tipo_cobro = 'E'  
    select @i_tipo_cobro = 'P'
    
--INCIO REQ424
--PAGO PENDIENTE DE RECONOCIMIENTO EN DIVIDENDO
if @i_tiene_reco = 'S'
   begin
      select @w_cap_pag_rec = 0
      /* BUSCA EL MOVIMIENTO DEL RECONOCIMIENTO Y VALIDA QUE EFECTIVAMENTE HAYA SALDADO EL CAPITAL DEL DIVIDENDO */
      select @w_sec_rpa_rec = dtr_secuencial
      from
      ca_transaccion with (nolock),
      ca_det_trn with (nolock)
      where tr_operacion  = @i_operacionca
      and   tr_operacion  = dtr_operacion
      and   tr_secuencial = dtr_secuencial
      and   tr_secuencial > 0
      and   tr_tran       = 'RPA'
      and   tr_estado     <> 'RV'
      and  dtr_concepto in (select c.codigo
                            from cobis..cl_tabla t, cobis..cl_catalogo c
                            where t.tabla = 'ca_fpago_reconocimiento'
                            and   t.codigo = c.tabla)

      /* OBTIENE EL SECUENCIAL PAG DEL PAGO POR RECONOCIMIENTO */
      select @w_sec_rpa_pag = ab_secuencial_pag
      from ca_abono with (nolock)
      where ab_operacion = @i_operacionca
      and   ab_secuencial_rpa = @w_sec_rpa_rec

      if @w_sec_rpa_pag <> 0
      begin 
       
         /* BUSCA EL PRIMER DIVIDENDO QUE AFECTARIA EL PAGO */
	     select @w_pri_div_pag = min(di_dividendo)
         from   ca_dividendo
         where  di_operacion  = @i_operacionca
         and    di_dividendo <= @w_div_vigente 
         and    di_estado    <> @w_est_cancelado

         if @@rowcount = 0
         begin
	        PRINT 'Error Buscando dividendo actual'
		    return 701103
	     end 
	  
         /* BUSCA EL VALOR POR RECONOCIMIENTO ACUMULADO EN EL DETALLE DE LA TRANSACCION PARA ESTAR AL DIA
            CON LOS PAGOS */
         select @w_recono = sum(dtr_monto)
         from   ca_det_trn 
         where  dtr_operacion    =  @i_operacionca
         and    dtr_secuencial   =  @w_sec_rpa_pag
         and    dtr_dividendo    <  @w_pri_div_pag
         and    dtr_concepto     =  'CAP'
         and    dtr_dividendo    <= @w_div_venc
	  
         select @w_recono = isnull(@w_recono,0)

	     if @w_vlr_amort < @w_recono
		 begin
		  
            select @w_recono = sum(@w_recono - @w_vlr_amort)
			select @w_sob_rec = 0
		  
            exec @w_error = sp_pagxreco
                 @s_user             = @s_user,
                 @s_term             = @s_term,
                 @s_date             = @s_date,
                 @i_tipo_oper        = 'P',
                 @i_secuencial_pag   = @i_secuencial_pag,
                 @i_operacionca      = @i_operacionca,
                 @i_en_linea         = @i_en_linea,
                 @i_oficina_orig     = @s_ofi,
                 @i_num_dec          = @i_num_dec,
                 @i_monto_pago       = @w_recono,
			        @i_dividendo        = @w_di_dividendo,  --LC REQ 424 10ABR2014
                 @o_sobrante         = @w_sob_rec out
              
            if @w_error <> 0 return @w_error
               select @i_monto_pago = @i_monto_pago - @w_recono + @w_sob_rec
	     end
	 end
end --FIN REQ424
    
   
-- CURSOR POR DIVIDENDOS
-- ESTE CURSOR SELECCIONA LOS DIVIDENDOS MAS VENCIDOS HASTA EL VIGENTE
if @i_dividendo = 0 
   declare dividendos cursor for select 
   di_dividendo, di_fecha_ven, di_estado, di_dias_cuota,  di_fecha_ini
   from   ca_dividendo
   where  di_operacion  = @i_operacionca
 --  and    di_dividendo <= @w_div_vigente 
   and    di_estado    <> @w_est_cancelado
   order  by di_dividendo
   for read only
ELSE   ---PARA DD
   declare dividendos cursor for select 
   di_dividendo, di_fecha_ven, di_estado, di_dias_cuota, di_fecha_ini
   from   ca_dividendo
   where  di_operacion  = @i_operacionca
   and    di_dividendo  = @i_dividendo
   and    di_estado    <> @w_est_cancelado
   order  by di_dividendo
   for read only 

open dividendos

fetch dividendos
into @w_di_dividendo, @w_di_fecha_ven, @w_di_estado, @w_dias_cuota, @w_di_fecha_ini

while @@fetch_status = 0
begin
   if (@@fetch_status = -1)
   begin
      close dividendos
      deallocate dividendos
      return 708899
   end
   select @w_dias = @w_dias_cuota
      
   if @i_abono_extraordinario = 'S' select @i_tipo_cobro = 'A'
   
   if exists (select * from ca_rubro_op, ca_concepto
             where ro_concepto = co_concepto
             and   co_categoria = 'S'
             and   ro_operacion =  @i_operacionca)
      select  @w_seguro = 'S'
   else
      select  @w_seguro = 'N'

   -- SACO LOS 4 VALORES  -- ITO 27Ene2010

   select @w_monto_cuota = sum(am_cuota + am_gracia - am_pagado)
   from   ca_amortizacion
   where  am_operacion = @i_operacionca
   and    am_dividendo = @w_di_dividendo
  

   if @w_estado_cob in ('CP','CJ') and @i_monto_pago < @w_monto_cuota
   begin
      exec sp_monto_pago_rubrocpcj
      @i_operacionca       = @i_operacionca,
      @i_monto_pago        = @i_monto_pago,
      @i_estado_cobranza   = @w_estado_cob,
      @i_dividendo         = @w_di_dividendo,
      @o_monto_honorario   = @w_monto_honorario out,
      @o_monto_iva         = @w_monto_iva out

      --fin ITO 27Ene2010

   end
   
   /*REQ 177 BANCAMIA */
   select @w_monto_analisis = 0   
   select @w_monto_analisis = isnull(sum(am_cuota + am_gracia - am_pagado), 0)
   from   ca_amortizacion
   where  am_operacion = @i_operacionca
   and    am_dividendo = @w_di_dividendo
   and    am_concepto in (@w_mipymes, @w_ivamipymes)
  
   -- CURSOR POR PRIORIDADES DE PAGO
   
   declare  prioridades cursor   for select 
   distinct ap_prioridad
   from   ca_abono_prioridad
   where  ap_operacion      = @i_operacionca
   and    ap_secuencial_ing = @i_secuencial_ing
   and    (@w_di_estado in (@w_est_vigente, @w_est_vencido) or (@w_di_estado = @w_est_novigente and ap_concepto in ('INT_ESPERA', 'IVA_ESPERA')) )
   order  by ap_prioridad 
   for read only
   
   open prioridades
   
   fetch prioridades
   into  @w_ap_prioridad
   
   while @@fetch_status = 0
   begin
   
      if (@@fetch_status = -1)
      begin
      
        close prioridades
        deallocate prioridades

        close dividendos
        deallocate dividendos
        
         return 708899
      end
            
      -- SELECCION DE LA MAXIMA SECUENCIA DEL RUBRO
      select @w_max_secuencia = max(am_secuencia)
      from   ca_amortizacion
      where  am_operacion = @i_operacionca
      and    am_dividendo   = @w_di_dividendo
      and    am_concepto    in ( @w_int,@w_int_ant)
      
      if @w_max_secuencia > 1 and @w_tacuerdo <> 'P'           -- @w_tacuerdo <> 'P' - REQ 089: ACUERDOS DE PAGO - 17/ENE/2011
         select @i_tipo_cobro = 'P'
         
      -- MONTO DE LA PRIORIDAD POR TIPO DE COBRO
      
      exec @w_error    = sp_monto_pago 
      @i_operacionca    = @i_operacionca,
      @i_dividendo      = @w_di_dividendo,
      @i_tipo_cobro     = @i_tipo_cobro,
      @i_fecha_pago     = @i_fecha_proceso,
      @i_prioridad      = @w_ap_prioridad,
      @i_secuencial_ing = @i_secuencial_ing,
      @i_dividendo_vig  = @w_div_vigente,
      @i_cancelar       = @i_cancela,
      @o_monto          = @w_monto_prioridad out

      if @w_error <> 0
      begin
        close prioridades
        deallocate prioridades

        close dividendos
        deallocate dividendos

         
         return @w_error
      end
      
     
      if @w_monto_prioridad <= 0 --NADA QUE PAGAR EN ESTA PRIORIDAD
      begin
         fetch prioridades
         into  @w_ap_prioridad
         continue
      end 
     
      select @w_inicial_prioridad = @w_monto_prioridad
      
      -- NO SE PUEDE PAGAR UN VALOR MAYOR AL VALOR DEL PAGO
      if @w_monto_prioridad >= @i_monto_pago
         select @w_monto_prioridad = @i_monto_pago
      
      select 
      ro_concepto, ro_tipo_rubro, ro_fpago
      from   ca_abono_prioridad, ca_rubro_op
      where  ap_secuencial_ing = @i_secuencial_ing
      and    ap_operacion      = @i_operacionca
      and    ap_prioridad      = @w_ap_prioridad
      and    ro_operacion      = @i_operacionca
      and    ro_concepto       = ap_concepto 
      and    @w_monto_prioridad > 0
      
      -- SELECCION DE LOS RUBROS POR PRIORIDAD Y DIVIDENDO
      declare  rubros cursor  for select 
      ro_concepto, ro_tipo_rubro, ro_fpago
      from   ca_abono_prioridad, ca_rubro_op
      where  ap_secuencial_ing = @i_secuencial_ing
      and    ap_operacion      = @i_operacionca
      and    ap_prioridad      = @w_ap_prioridad
      and    ro_operacion      = @i_operacionca
      and    ro_concepto       = ap_concepto 
      and    @w_monto_prioridad > 0 -- PARA QUE PAGUE VALORES POSITIVOS
      for read only
      
      open rubros
      
      fetch rubros
      into  @w_am_concepto, @w_ro_tipo_rubro, @w_fpago
      
      while @@fetch_status = 0
      begin         
         if (@@fetch_status = -1)
         begin

            close rubros
            deallocate rubros

            close prioridades
            deallocate prioridades
         
            close dividendos
            deallocate dividendos

            return 710004
         end
         
         /* En el calculo del Iva (Robro Anterior) no es posible realizar proporcionalidad por el valor sobrante */
         if @w_proporcional = '0' and @w_am_concepto = @w_mipymes begin
               close rubros
               deallocate rubros
               goto PROXIMO
         end
                  
         select @w_proporcional = 'N'
         
         if @w_am_concepto = @w_ivamipymes and @i_monto_pago <= @w_monto_analisis    --SE APLICA PROPORCIONALIDAD
         begin
            select @w_monto_mipyme  = @i_monto_pago /(1+ @w_iva /100)
            select @w_monto_ivapyme = @w_monto_mipyme * @w_iva /100
            
            if @w_monto_ivapyme > @w_monto_prioridad 
               select @w_monto_ivapyme = @w_monto_ivapyme - (@w_monto_ivapyme - @w_monto_prioridad)

            select @w_monto_rubro       = isnull(@w_monto_ivapyme,0),
                   @w_monto_prioridad   = isnull(@w_monto_ivapyme,0),
  	               @w_inicial_prioridad = isnull(@w_monto_ivapyme,0)
  	                                       
  	        if @w_monto_mipyme > 1 and  @w_monto_ivapyme > 1      
               select @w_proporcional = 'S'
            else begin
               close rubros
               deallocate rubros
               select @w_proporcional = '0'
               goto PROXIMO
            end
            
         end            
         
         -- ITO 25/Ene/2010
         -- MONTO DEL RUBRO SELECCIONADO
         if @w_am_concepto in (@w_hono_cp,@w_hono_cj,@w_iva_cp,@w_iva_cj) and @i_monto_pago < @w_monto_cuota
         begin
            if @w_am_concepto in (@w_hono_cp,@w_hono_cj)
               select @w_monto_rubro       = isnull(@w_monto_honorario,0),
		              @w_inicial_prioridad = isnull(@w_monto_prioridad,0)

            if @w_am_concepto in (@w_iva_cp,@w_iva_cj)
               select @w_monto_rubro       = isnull(@w_monto_iva,0),
		              @w_inicial_prioridad = isnull(@w_monto_prioridad,0)
		              
		     select @w_proporcional = 'S'         
         end
         -- FIN ITO 25/Ene/2010
         
         
         if @w_proporcional = 'N'  begin   -- MONTO DEL RUBRO SELECCIONADO
         
            exec @w_error = sp_monto_pago_rubro
            @i_operacionca    = @i_operacionca,
            @i_dividendo      = @w_di_dividendo,
            @i_tipo_cobro     = @i_tipo_cobro,
            @i_fecha_pago     = @i_fecha_proceso,
            @i_concepto       = @w_am_concepto,
            @i_dividendo_vig  = @w_div_vigente,
            @i_cancelar       = @i_cancela,
            @o_monto          = @w_monto_rubro out
         
            if @w_error <> 0  begin
               close rubros
               deallocate rubros
            
               close prioridades
               deallocate prioridades
            
               close dividendos
               deallocate dividendos
               
                return @w_error
            end
         end
            
            select @w_inicial_rubro = @w_monto_rubro
         
         -- APLICACION DEL PAGO PARA EL RUBRO
         exec @w_error       = sp_abona_rubro
         @s_ofi               = @s_ofi,
         @s_sesn              = @s_sesn,
         @s_user              = @s_user,
         @s_term              = @s_term,
         @s_date              = @s_date,
         @i_secuencial_pag    = @i_secuencial_pag,
         @i_operacionca       = @i_operacionca,
         @i_dividendo         = @w_di_dividendo,
         @i_concepto          = @w_am_concepto,
         @i_monto_pago        = @i_monto_pago,
         @i_monto_prioridad   = @w_monto_prioridad,
         @i_monto_rubro       = @w_monto_rubro,
         @i_tipo_cobro        = @i_tipo_cobro,
         @i_en_linea          = @i_en_linea,
         @i_tipo_rubro        = @w_ro_tipo_rubro,
         @i_fecha_pago        = @i_fecha_proceso,
         @i_condonacion       = 'N',
         @i_cotizacion        = @i_cotizacion,
         @i_tcotizacion       = @i_tcotizacion,
         @i_inicial_prioridad = @w_inicial_prioridad,
         @i_inicial_rubro     = @w_inicial_rubro,
         @i_fpago             = @w_fpago,
         @i_secuencial_ing    = @i_secuencial_ing,
         @i_di_estado         = @w_di_estado, 
         @i_dias_pagados      = @w_dias,
         @i_tasa_pago         = @i_tasa_prepago,
         @i_cotizacion_dia_sus = @i_cotizacion_dia_sus,
         @o_sobrante_pago     = @i_monto_pago      out
       
         if @w_error <> 0
         begin

            close rubros
            deallocate rubros

            close prioridades
            deallocate prioridades
         
            close dividendos
            deallocate dividendos
            
            return @w_error
         end
                  
         if @w_monto_prioridad <= 0
            select @w_salir_rubro = 'S'
         
         if @i_monto_pago < @w_vlr_despreciable
         begin
            select @w_salir_rubro = 'S',
                   @w_salir_dividendo = 'S',
                   @w_salir_prioridad = 'S'
         end
         
         if @w_salir_rubro = 'S'
         begin
            select @w_salir_rubro = 'N'
            break
         end
         
         fetch rubros
         into  @w_am_concepto, @w_ro_tipo_rubro, @w_fpago
      end -- CURSOR RUBROS
      
      close rubros
      deallocate rubros
      
      if @w_salir_prioridad = 'S'
      begin
         select @w_salir_prioridad = 'N'
         break
      end
      
      PROXIMO:
      
      fetch prioridades
      into  @w_ap_prioridad
   end -- CURSOR PRIORIDADES
   
   close prioridades
   deallocate prioridades


   
   -- INTERESES ANTICIPADOS
   -- **********************
   if @w_forma_pago_int = 'A' and @w_devolucion > 0 and @w_tipo <> 'D'
   begin
      select @w_codvalor_nov = co_codigo*1000
      from   ca_concepto
      where  co_concepto = @w_concepto_int
      
      insert into ca_det_trn (
      dtr_secuencial, dtr_operacion,    dtr_dividendo,
      dtr_concepto,
      dtr_estado,     dtr_periodo,      dtr_codvalor,
      dtr_monto,      dtr_monto_mn,     dtr_moneda,
      dtr_cotizacion, dtr_tcotizacion,  dtr_afectacion,
      dtr_cuenta,     dtr_beneficiario, dtr_monto_cont )
      values(
      @i_secuencial_pag,  @i_operacionca,@w_di_dividendo,
      @w_concepto_int,
      1,                  0,            @w_codvalor_nov,
      @w_devolucion*-1, round(@w_devolucion*@i_cotizacion, @w_numdec_op)*-1,
      @w_moneda,
      @i_cotizacion,      @i_tcotizacion,              'D',
      '',             '',               0 )
      
      if @@error <> 0
      begin
         close dividendos
         deallocate dividendos
         return 708166
      end
   end
   
   -- FIN INTERESES ANTICIPADOS
   -- ***********************
   
   -- VERIFICAR CANCELACION DEL DIVIDENDO
   select @w_cancelar_div = 'N'
   
   /*if @i_tipo_cobro in ('A', 'E')
   begin
      select @w_total_div=isnull(sum(am_acumulado+am_gracia-am_pagado),0)
      from   ca_amortizacion, ca_rubro_op,ca_concepto
      where  am_operacion = @i_operacionca
      and    ro_operacion = am_operacion
      and    ro_concepto  = am_concepto
      and    ro_concepto  = co_concepto
      and    am_estado   <> @w_est_cancelado
      and    (
              (    am_dividendo = @w_di_dividendo + charindex (ro_fpago, 'A')
               and not(co_categoria in ('S','A') and am_secuencia > 1)
              )
              or (co_categoria in ('S','A') and am_secuencia > 1 and am_dividendo = @w_di_dividendo)
             )
      
      if round(@w_total_div, @w_numdec_op) <= @w_vlr_despreciable 
         select @w_cancelar_div = 'S'
   end
   ELSE*/
   begin
      select @w_total_div=isnull(sum(am_cuota+am_gracia-am_pagado),0)
      from   ca_amortizacion, ca_rubro_op,ca_concepto
      where  am_operacion = @i_operacionca
      and    ro_operacion = am_operacion
      and    ro_concepto  = am_concepto
      and    ro_concepto  = co_concepto
      and    am_estado      <> @w_est_cancelado
      and   (
             (     am_dividendo = @w_di_dividendo + charindex (ro_fpago, 'A')
              and not(co_categoria in ('S','A') and am_secuencia > 1)
             )
             or (co_categoria in ('S','A') and am_secuencia > 1 and am_dividendo = @w_di_dividendo)
            )
      
      if round(@w_total_div, @w_numdec_op) < @w_vlr_despreciable
         select @w_cancelar_div = 'S'
   end
   
   if @w_cancelar_div = 'S'  and @i_cancela = 'N'
   begin  
      
      -- INI - REQ 175: PEQUEÑA EMPRESA - PROVISION FALTANTE DE INTERESES EN GRACIA
      if @w_gracia_int > 0 and @w_dist_gracia <> 'C' and @w_tacuerdo <> 'P'               -- @w_tacuerdo <> 'P' - REQ 089: ACUERDOS DE PAGO
      begin            
         if exists(
         select 1
         from ca_amortizacion, ca_rubro_op
         where am_operacion  = @i_operacionca
         and   am_dividendo  = @w_di_dividendo
         and   am_gracia     < 0
         and   am_cuota      > am_acumulado
         and   ro_operacion  = am_operacion
         and   ro_concepto   = am_concepto
         and   ro_tipo_rubro = 'I'            )
         begin
            -- PROVISION DEL VALOR DE GRACIA
		

			
            insert into ca_transaccion_prv with (rowlock)(
            tp_fecha_mov,              tp_operacion,              tp_fecha_ref,
            tp_secuencial_ref,         tp_estado,                 tp_dividendo,
            tp_concepto,               tp_codvalor,               
            tp_monto,                  tp_secuencia,              tp_comprobante,
            tp_ofi_oper)
            select
            @s_date,                   @i_operacionca,            @i_fecha_proceso,
            @i_secuencial_pag,         'ING',                     @w_di_dividendo,
            am_concepto,               co_codigo * 1000 + am_estado * 10 + am_periodo,
            am_cuota - am_acumulado,   am_secuencia,              0,
            @w_oficina_op
            from ca_amortizacion, ca_rubro_op, ca_concepto
            where am_operacion  = @i_operacionca
            and   am_dividendo  = @w_di_dividendo
            and   am_gracia     < 0
            and   am_cuota      > am_acumulado
            and   ro_operacion  = am_operacion
            and   ro_concepto   = am_concepto
            and   ro_tipo_rubro = 'I'
            and   co_concepto   = ro_concepto
            
            if @@error <> 0
            begin
               close dividendos
               deallocate dividendos
               return 708165
            end

            
           

            
            update ca_amortizacion
            set am_acumulado = am_cuota
            from ca_rubro_op
            where am_operacion  = @i_operacionca
            and   am_dividendo  = @w_di_dividendo
            and   am_gracia     < 0
            and   am_cuota      > am_acumulado
            and   ro_operacion  = am_operacion
            and   ro_concepto   = am_concepto
            and   ro_tipo_rubro = 'I'
            
            if @@error <> 0 begin
               close dividendos
               deallocate dividendos
               return 710002
            end
         end
      end
      -- FIN - REQ 175: PEQUEÑA EMPRESA
      
      update ca_dividendo set    
      di_estado    = @w_est_cancelado,
      di_fecha_can = @w_fecha_ult_proceso
      where  di_operacion = @i_operacionca
      and    di_dividendo = @w_di_dividendo
      
      if @@error <>0  begin
         close dividendos
         deallocate dividendos
         return 710002
      end
      
      update ca_amortizacion
      set    am_estado = @w_est_cancelado
      from   ca_amortizacion
      where  am_operacion = @i_operacionca
      and    am_dividendo = @w_di_dividendo
      
      if @@error <>0 begin
         close dividendos
         deallocate dividendos
         return 710002
      end
      
      if @w_di_estado = @w_est_vigente begin
      
         -- VIGENTE EL SIGUIENTE
         update ca_dividendo
         set    di_estado = @w_est_vigente
         where  di_operacion = @i_operacionca
         and    di_dividendo = @w_di_dividendo + 1
         and    di_estado    = @w_est_novigente
         
         if @@error <>0  begin
            close dividendos
            deallocate dividendos
            return 710002
         end
         
         update ca_amortizacion
         set    am_estado = @w_est_vigente
         from   ca_amortizacion 
         where  am_operacion = @i_operacionca
         and    am_dividendo = @w_di_dividendo + 1
         and    am_estado    = @w_est_novigente
         
         if @@error <>0 begin
            close dividendos
            deallocate dividendos
            return 710002
         end
      
         if @w_tacuerdo <> 'P'                           -- REQ 089: ACUERDOS DE PAGO
         begin
            update ca_amortizacion with (rowlock) set   
            am_acumulado = am_cuota,
            am_estado    = @w_estado_op
            from ca_rubro_op
            where am_operacion  = ro_operacion
            and   am_concepto   = ro_concepto
            and   ro_provisiona = 'N'
            and   ro_tipo_rubro <> 'C'
            and   ro_operacion  = @i_operacionca
            and   am_dividendo  = @w_di_dividendo + 1
            
            if @@error <>0 begin
               close dividendos
               deallocate dividendos
               return 710002
            end
			
        
	
            insert into ca_transaccion_prv
            select
            tp_fecha_mov       = @s_date,
            tp_operacion       = @i_operacionca,
            tp_fecha_ref       = @i_fecha_proceso,
            tp_secuencial_ref  = @i_secuencial_pag,
            tp_estado          = 'ING',
            tp_comprobante     = 0,
            tp_fecha_cont      = null,
            tp_dividendo       = am_dividendo,
            tp_concepto        = am_concepto,
            tp_codvalor        =(co_codigo * 1000) + (@w_estado_op * 10),
            tp_monto           = am_cuota,
            tp_secuencia       = am_secuencia,
            tp_ofi_oper	       = @w_oficina_op
            from ca_amortizacion, ca_rubro_op, ca_concepto
            where am_operacion = ro_operacion
            and   am_concepto  = ro_concepto
            and   am_concepto  = co_concepto 
            and   ro_provisiona = 'N'
            and   ro_tipo_rubro <> 'C'
            and   ro_operacion  = @i_operacionca
            and   am_dividendo  = @w_di_dividendo + 1
            and   am_cuota  >= 0.01 
			and   am_concepto  not in (select ro_concepto 
                                       from   ca_rubro_op where ro_concepto_asociado in (select ro_concepto  from ca_rubro_op where ro_fpago  = 'M' and ro_operacion =@w_operacionca)          and    ro_operacion = @w_operacionca
                                       union
                                       select ro_concepto 
                                       from   ca_rubro_op
                                       where  ro_fpago    = 'M'
                                       and    ro_operacion =@w_operacionca) --EVITAR CONSIDERAR LOS RUBROS MULTA Y LOS ASOCIADOS A LAS MULTAS
            
            if @@error <>0 begin
               close dividendos
               deallocate dividendos
               return 710001
            end
         end         
      end
      
   end  ---cancelar_div 
   
   if @i_fecha_proceso < @w_di_fecha_ven
      select @w_di_fecha_ini = @w_di_fecha_ven
   
   -- FIN PARA CANCELAR EL RUBRO EN ca_amortizacion
   
   if @w_salir_dividendo <> 'N'
   begin
      select @w_salir_dividendo = 'N'
      break
   end
   
   fetch dividendos
   into  @w_di_dividendo, @w_di_fecha_ven, @w_di_estado, @w_dias_cuota, @w_di_fecha_ini
end -- CURSOR DIVIDENDOS

close dividendos
deallocate dividendos

-- CONTROL DE CANCELAMIENTO DE LA OPERACION 
select @w_max_dividendo = max(di_dividendo)
from   ca_dividendo
where  di_operacion = @i_operacionca

-- PROCESO PARA CANCELAR TOTALMENTE LA OPERACION
exec  sp_calcula_saldo
     @i_operacion = @i_operacionca,
     @i_tipo_pago = @i_tipo_cobro,
     @o_saldo     = @w_saldo_oper out

if @w_saldo_oper > @w_vlr_despreciable
   select  @i_operacionca =  @i_operacionca
ELSE
begin
   --GENERACION DE LA COMISION DIFERIDA
   exec @w_error     = sp_comision_diferida
   @s_date           = @s_date,
   @i_operacion      = 'A',
   @i_operacionca    = @w_operacionca,
   @i_secuencial_ref = @i_secuencial_pag 
   
   if @w_error <> 0 return 724589  
   
   
   update ca_operacion
   set    op_estado = @w_est_cancelado
   where  op_operacion = @i_operacionca    
   
   update ca_dividendo
   set    di_estado    = @w_est_cancelado,
          di_fecha_can = @w_fecha_ult_proceso
   where  di_operacion = @i_operacionca
   and    di_estado   <> @w_est_cancelado
   
   update ca_amortizacion
   set    am_estado = @w_est_cancelado
   where  am_operacion = @i_operacionca
   
   if @@error <> 0
   begin
      return 710002
   end
   if @i_en_linea = 'N'
      select @w_bandera_be = 'S'
   else
      select @w_bandera_be = 'N'
   
   exec @w_error = cob_custodia..sp_activar_garantia
   @i_opcion         = 'C',
   @i_tramite        = @w_tramite,
   @i_modo           = 2,
   @i_operacion      = 'I',
   @s_date           = @s_date,
   @s_user           = @s_user,
   @s_term           = @s_term,
   @s_ofi            = @s_ofi,
   @i_bandera_be     = @w_bandera_be
   
   if @w_error <> 0
   begin 
      PRINT 'aplcuota.sp  salio por error de cob_custodia..sp_activar_garantia ' + cast(@w_error as varchar)
      while @@trancount > 1
            rollback
      return @w_error
   end
   
   --ACTUALIZA EL ESTADO DEL PRODUCTO EN CLIENTES
   update cobis..cl_det_producto with (rowlock)
   set dp_estado_ser = 'C'
   where dp_producto = 7 
   and dp_cuenta = @w_banco 
end  -- FIN DE CANCELAR TOTALMENTE LA OPERACION

select @o_sobrante = isnull(@i_monto_pago, 0)

return 0

go

