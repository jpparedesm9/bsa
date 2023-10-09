/************************************************************************/
/*   Archivo              :    qrpagos.sp                               */
/*   Stored procedure     :    sp_qr_pagos                              */
/*   Base de datos        :    cob_cartera                              */
/*   Producto             :    Cartera                                  */
/*   Disenado por         :    Fabian de la Torre, Rodrigo Garces       */
/*   Fecha de escritura   :    Ene. 98                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                               PROPOSITO                              */
/*   Consulta para front end de pagos                                   */
/************************************************************************/
/*                              ACTUALIZACIONES                         */
/*      FECHA               AUTOR            CAMBIO                     */
/*   AGO-11-2003  Elcira P.       Actualizaciones para el BAC           */
/*   22/Nov/2005  Ivan Jimenez    REQ 379 Traslado de Intereses         */
/*   09/Jun/2010  ELcira Pelaez   Quitar Causacion Pasivas y comentados */
/*   04/10/2010   Yecid Martinez  Fecha valor baja Intensidad           */
/*                                       NYMR 7x24                      */
/*   18/01/2012   Luis C. Moreno  RQ293 Adicionar saldo por amortizar   */
/*                                por pago por recon a saldo capital    */
/*   25/02/2014   I.Berganza      Req: 397 - Reportes FGA               */
/*   21/NOV/2014  Elcira PElaez   Homologados NR.394 y 424              */
/*   28/08/2019   A. ORTIZ        Req. 118442 Forma de pago             */
/************************************************************************/

use cob_cartera
go
set ansi_warnings off
go
if exists (select 1 from sysobjects where name = 'tmp_totales_pag')
   drop table tmp_totales_pag
go
---AGO.03.2015
create table tmp_totales_pag (
        operacion     int         not null,
        concepto      catalogo    not null,
        descripcion   descripcion not null,
        vencido1      money       not null,
        vigente1      money       not null,
        devolucion    money       not null,
        subtotal1     money       not null,
        spid          int         not null,
	    recono        money       not null
) 


if exists (select 1 from sysobjects where name = 'sp_qr_pagos')
   drop proc sp_qr_pagos
go
--CCA424 ABR.28.2014
create proc sp_qr_pagos
@s_sesn                 int          = NULL,
@s_user                 login        = 'consulta',
@s_term                 varchar (30) = 'consulta',
@s_date                 datetime     = NULL,
@s_ofi                  smallint     = 9000,
@i_banco                cuenta,
@i_formato_fecha        int,
@i_tipo_pago            char(1)      = null,
@i_tipo_pago_can        char(1)      = null,
@i_cancela              char(1)      = 'N',
@i_calcula_devolucion   char(1)      = null,
@o_saldo_cap			money		 = null out
as
declare
@w_sp_name              varchar(32),
@w_error                int,
@w_operacionca          int,
@w_fecha_ven            datetime,
@w_di_fecha_ven         datetime,
@w_vencido1             money,
@w_vigente1             money,
@w_descripcion          varchar(20),
@w_est_novigente        tinyint,
@w_est_vigente          tinyint,
@w_est_cancelado        tinyint,
@w_est_castigo_oper     tinyint,
@w_est_suspenso         tinyint,
@w_est_ajuste           tinyint,
@w_est_recompra         tinyint,
@w_est_intsuscap        tinyint,
@w_moneda_op            smallint,
@w_fecha_proceso        datetime,
@w_fpago                char(1),
@w_num_periodo_d        smallint,
@w_periodo_d            catalogo,
@w_dias_anio            smallint,
@w_base_calculo         char(1),
@w_est_vencido          tinyint,
@w_causacion            char(1),
@w_di_fecha_ini         datetime,
@w_dias_calc            smallint,
@w_valor_rubro          money,
@w_num_dec              tinyint,
@w_devolucion           money,
@w_capital_dev          money,
@w_sector               catalogo,
@w_convierte_tasa       char(1),
@w_calcula_devolucion   char(1),
@w_ro_porcentaje        float,
@w_tipo_cobro           char(1),
@w_dias_recalcular      int,
@w_acumulado            money,
@w_valor_calc           money,
@w_monto_cap            money,
@w_tasa_recalculo       float,
@w_concepto_intant      catalogo,
@w_subtotal             money,
@w_di_dividendo         int,
@w_di_estado            tinyint,
@w_est_castigado        tinyint,
@w_am_concepto          catalogo,
@w_proyectado           money,
@w_saldo_cap            money,
@w_estado               tinyint,
@w_ro_fpago             char(1),
@w_ro_tipo_rubro        char(1),
@w_dividendo_sig        int,
@w_categoria_rubro      char(1),
@w_valor_pagado         money,
@w_di_dias_cuota        int,
@w_int                  catalogo,
@w_dias                 int,
@w_valor_futuro_int     money,
@w_vp_cobrar            money,
@w_tasa_prepago         float,
@w_tasa_op              float,
@w_valor_int            money,
@w_valor_otros          money,
@w_decimales_tasa       tinyint,
@w_cuota_cap            money,
@w_valor_int_cap        money,
@w_no_cobrado_int       money,
@w_int_en_vp            money,
@w_ult_vencido          int,
@w_maximo_div           int,
@w_int_dev              money,
@w_devolver_int         char(1),
@w_div_vigente          int,
@w_parametro_cap        catalogo,
@w_max_secuencia        int,
@w_valor_intant         money,
@w_tasa_intant          float,
@w_valor_calc_vig       money,
@w_max_sec              int,
@w_tipo                 char(1),
@w_rowcount             int,
@w_alerta               varchar(50),
@w_accion               varchar(10),
@w_cliente              int,
@w_estado_cobranza      catalogo,
@w_total_honabo         money,
@w_regimen              char(1),
@w_porc_juridico        float,
@w_divisor              float,
@w_monto_base           money,
@w_monto_honabo         money,
@w_monto_iva            money,
@w_porc_prejuridico     float,
@w_iva                  float,
@w_return               int,
@w_vlr_x_amort          money,       --LCM - 293
@w_tiene_reco           char(1),     --LCM - 293
@w_porc_cubrim          float,       --LCM - 293
@w_recono               money,       --LCM - 293
@w_1_vlr_venc           money,       --LCM - 293
@w_1_div_venc           int,  --LCM - 293
@w_1_vlr_cap_venc       money,       --LCM - 293
@w_concepto_rec_fng     varchar(30), --LCM - 293
@w_concepto_rec_usa     varchar(30), --LCM - 293
@w_sec_rpa_rec          int,         --LCM - 293
@w_sec_rpa_pag          int,         --LCM - 293
@w_cap_pag_rec          money,       --LCM - 293
@w_cap_div              money,       --LCM - 293
@w_monto_reconocer      money,       --LCM - 293
@w_vlr_calc_fijo        money,       --LCM - 293
@w_div_pend             money,        --LCM - 293
@w_vlr_amort            money,   --REQ424
@w_div_venc             smallint,    --REQ424
@w_dividendo_medio        smallint,
@w_comprecan_ref        catalogo,
@w_iva_comprecan_ref        catalogo,
@w_toperacion           catalogo,
@w_tasa_comprecan       float,
@w_iva_comprecan        float,
@w_mul_precan           money, 
@w_total_precan         money,
@w_dias_prestamo        int,
@w_limite_comprecan     int,
@w_cobrar_comprecan     char(1),
@w_comprecan            varchar(10),
@w_estado_desc          descripcion

--- CREACION TABLAS DE TRABAJO
delete tmp_totales_pag where spid = @@spid

--- INICIALIZACION DE VARIABLES
select @w_sp_name             = 'sp_qr_pagos',
       @w_est_novigente       = 0,
       @w_est_vigente         = 1,
       @w_no_cobrado_int      = 0,
       @w_int_en_vp           = 0,
       @w_cuota_cap           = 0,
       @w_valor_int_cap       = 0,
       @w_est_cancelado       = 3,
       @w_est_vencido         = 2,
       @w_est_castigado       = 4,
       @w_est_castigo_oper    = 8,
       @w_est_suspenso        = 9,
       @w_dividendo_sig       = 0,
       @w_valor_pagado        = 0,
       @w_valor_int           = 0,
       @w_saldo_cap           = 0,
       @w_valor_otros         = 0,
       @w_maximo_div          = 0,
       @w_int_dev             = 0,
       @w_devolver_int        = 'N',
       @w_div_vigente         = 0,
       @w_max_secuencia       = 0,
       @w_valor_calc_vig      = 0,
       @w_max_sec             = 0,
       @w_vlr_x_amort         = 0,
       @w_tiene_reco          = 'N',
       @w_porc_cubrim         = 0,
       @w_recono              = 0,
       @w_mul_precan          = 0, 
       @w_total_precan        = 0,
       @w_cobrar_comprecan    = 'N',
       @w_comprecan           = 'COMPRECAN'

--- PARAMETROS GENERALES

select @w_int = pa_char
from  cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'INT'
select @w_rowcount = @@rowcount
set transaction isolation level read uncommitted

if @w_rowcount = 0
   PRINT 'no se definio paraemtro general INT'

select @w_concepto_intant = pa_char
from cobis..cl_parametro
where pa_nemonico = 'INTANT'
and   pa_producto = 'CCA'
set transaction isolation level read uncommitted

/* OBTIENE PARAMETROS DE RECONOCIMIENTO */
select @w_concepto_rec_fng = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'RECFNG'

if @@rowcount = 0
   PRINT 'no se definio paraemtro general RECFNG'

select @w_concepto_rec_usa = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'RECUSA'

if @@rowcount = 0
   PRINT 'no se definio paraemtro general RECUSA'

--- INFORMACION DE OPERACION
select @w_operacionca        = op_operacion,
       @w_fecha_ven          = op_fecha_fin,
       @w_moneda_op          = op_moneda,
       @w_fecha_proceso      = op_fecha_ult_proceso,
       @w_num_periodo_d      = op_periodo_int,
       @w_periodo_d          = op_tdividendo,
       @w_dias_anio          = op_dias_anio,
       @w_base_calculo       = op_base_calculo,
       @w_causacion          = op_causacion,
       @w_sector             = op_sector,
       @w_convierte_tasa     = op_convierte_tasa,
       @w_calcula_devolucion = isnull(op_calcula_devolucion,'N'),
       @w_tipo_cobro         = op_tipo_cobro,
       @w_monto_cap          = op_monto,
       @w_estado             = op_estado,
       @w_tipo               = op_tipo,
       @w_cliente            = op_cliente,
       @w_estado_cobranza    = op_estado_cobranza,
       @w_toperacion         = op_toperacion,
       @w_dias_prestamo      = datediff(dd,op_fecha_ini,op_fecha_ult_proceso)
from   ca_operacion
where  op_banco       = @i_banco

if @@rowcount = 0
begin
   select @w_error = 701025
   goto ERROR
end


--PRINT '--INICIO NYMR 7x24 Ejecuto FECHA VALOR BAJA INTENSIDAD ' + CAST(@w_operacionca as varchar)
  
EXEC @w_return = sp_validar_fecha
   @s_user                  = @s_user,
   @s_term                  = @s_term,
   @s_date                  = @s_date ,
   @s_ofi                   = @s_ofi,
   @i_operacionca           = @w_operacionca,
   @i_debug                 = 'N' 

   if @w_return <> 0 
   begin
      select @w_error = @w_return 
      goto ERROR
   end



--- DECIMALES
exec sp_decimales
     @i_moneda    = @w_moneda_op,
     @o_decimales = @w_num_dec out


---INICIALIZACION DE VARIABLES
select @i_tipo_pago          = isnull(@i_tipo_pago, @w_tipo_cobro)
select @i_calcula_devolucion = isnull(@i_calcula_devolucion,@w_calcula_devolucion)

/** INICIO REQ 379 IFJ 22/Nov/2005 **/
If exists (Select 1 from ca_traslado_interes
          Where ti_operacion = @w_operacionca
          And  ti_estado     = 'P')
begin
    select @i_tipo_pago = 'A'
end
/** FIN REQ 379 IFJ 22/Nov/2005 **/

---LAS OBLIGACIONES CASTIGADO
if @w_estado = @w_est_castigado
   select  @i_tipo_pago = 'A'

select @w_div_vigente = isnull(max(di_dividendo), 0)
from   ca_dividendo
where  di_operacion = @w_operacionca
and    di_estado    = 1

if @w_estado = @w_est_suspenso
begin
   select @w_max_sec  = isnull(max(am_secuencia) ,0)
   from   ca_amortizacion
   where  am_operacion = @w_operacionca
   and    am_dividendo = @w_div_vigente

   if @w_max_sec > 1
      select  @i_tipo_pago = 'A'
end

/* LCM - 293: CONSULTA LA TABLA DE RECONOCIMIENTO PARA VALIDAR SI LA OBLIGACION TIENE RECONOCIMIENTO */
select @w_tiene_reco      = 'N',
       @w_vlr_x_amort     = 0,
       @w_vlr_calc_fijo   = 0,
       @w_div_pend        = 0,
       @w_monto_reconocer = 0

select
@w_vlr_calc_fijo = pr_vlr_calc_fijo,
@w_div_pend      = pr_div_pend,
@w_vlr_x_amort   = pr_vlr - pr_vlr_amort,
@w_vlr_amort     = pr_vlr_amort,   --REQ424
@w_div_venc      = pr_div_venc     --REQ424
from cob_cartera..ca_pago_recono
where pr_operacion = @w_operacionca
and   pr_estado    = 'A'

if @@rowcount > 0
   select @w_tiene_reco = 'S'

if @w_tiene_reco = 'S'

   -- Obtener valor de cuota fija a reconocer por concepto de capital para el dividendo vigente
   if @w_div_pend > 0
      select @w_monto_reconocer = round(isnull(@w_vlr_calc_fijo / @w_div_pend, 0),0)

--- PROCESO POR DIVIDENDO
declare
   cursor_dividendo cursor
   for select di_dividendo,   di_fecha_ini,  di_fecha_ven,
              di_estado,      di_dias_cuota, am_concepto,
              isnull(sum((abs(am_cuota + am_gracia - am_pagado)+am_cuota + am_gracia - am_pagado)/2.0),0),
              isnull(sum((abs(am_acumulado + am_gracia - am_pagado)+am_acumulado + am_gracia - am_pagado)/2.0),0)
       from  ca_dividendo,
             ca_amortizacion,
             ca_rubro_op,
             ca_concepto
       where am_operacion = @w_operacionca
       and   di_operacion = @w_operacionca
       and   ro_operacion = @w_operacionca
       and   am_operacion = di_operacion
       and   am_concepto  = ro_concepto
       and   di_operacion = ro_operacion
       and   (di_estado  = 2 or di_estado = 1 )
       and   co_concepto  = am_concepto
       and   am_estado    <> 3
       and  (
             (am_dividendo = di_dividendo + charindex (ro_fpago, 'A') and not(co_categoria in ('S','A') and am_secuencia > 1)
             )
             or (co_categoria in ('S','A') and am_secuencia > 1 and am_dividendo = di_dividendo)
            )
       group by di_dividendo, di_fecha_ini, di_fecha_ven, di_estado, di_dias_cuota, am_concepto
   for read only

open cursor_dividendo

fetch cursor_dividendo
into  @w_di_dividendo,  @w_di_fecha_ini,  @w_di_fecha_ven,
      @w_di_estado,     @w_di_dias_cuota, @w_am_concepto,
      @w_proyectado,    @w_acumulado

while @@fetch_status = 0
begin
   --- INICIALIZACION DE VARIABLES
   select @w_vencido1   = 0,
          @w_vigente1   = 0,
          @w_devolucion = 0,
          @w_subtotal   = 0,
          @w_valor_calc_vig = 0

   if @w_acumulado < 0
      select @w_acumulado = 0

   if @w_proyectado < 0
      select @w_proyectado = 0

   --- INFORMACION DE CONCEPTO
   select @w_descripcion = co_descripcion,
          @w_categoria_rubro = co_categoria
   from   ca_concepto
   where  co_concepto = @w_am_concepto

   --- INFORMACION DE CONCEPTO  DE LA OPERACION
   select @w_ro_fpago        = ro_fpago,
          @w_ro_tipo_rubro   = ro_tipo_rubro
   from   ca_rubro_op
   where  ro_operacion = @w_operacionca
   and    ro_concepto  = @w_am_concepto

   
   if @w_am_concepto = @w_concepto_intant
   begin
      select @w_ro_porcentaje  = ro_porcentaje
      from   ca_rubro_op
      where  ro_operacion = @w_operacionca
      and    ro_concepto  = @w_am_concepto
   end

   if @w_am_concepto = @w_int
   begin
      select @w_ro_porcentaje  = ro_porcentaje,
             @w_decimales_tasa = isnull(ro_num_dec,2)
      from   ca_rubro_op
      where  ro_operacion = @w_operacionca
      and    ro_concepto  = @w_int
   end

   if @i_tipo_pago = 'P' or @i_tipo_pago = 'E'
   begin
      if @w_ro_fpago = 'A'
         select @w_vencido1 = round(@w_proyectado, @w_num_dec)
      else
         select @w_vencido1 = round(@w_proyectado, @w_num_dec)

      select @w_vigente1   = 0
      select @w_devolucion = 0
      select @w_subtotal   = round(@w_vencido1 + @w_vigente1,@w_num_dec)
   end

   if @i_tipo_pago = 'A'
   begin
      if @w_ro_fpago = 'A'
         select @w_vencido1   = round(@w_acumulado, @w_num_dec)
      else
         select @w_vencido1   = round(@w_proyectado, @w_num_dec)

      select @w_vigente1   = 0
      select @w_devolucion = 0
      select @w_subtotal   = round(@w_vencido1 + @w_vigente1,@w_num_dec)
   end

   
   
   
   ---Inicio Calculo Dividendo VIGENTE
   if @w_di_estado = @w_est_vigente
   begin  ---Dividendo VIGENTE
      if @i_tipo_pago = 'P'   --PROYECTADO
      begin
         if @w_ro_fpago = 'A'    --ANTICIPADO
         begin
            select @w_dividendo_sig = 0

            select @w_dividendo_sig = isnull(di_dividendo,0)
            from ca_dividendo
            where di_operacion =  @w_operacionca
            and di_dividendo   =  @w_di_dividendo

            if @w_dividendo_sig > 0
            begin
               select @w_valor_calc  = isnull(sum(am_cuota - am_pagado),0)
               from ca_amortizacion
               where am_operacion =  @w_operacionca
               and   am_dividendo =  @w_dividendo_sig + 1
               and   am_concepto  =  @w_am_concepto
               and   am_estado    <> @w_est_cancelado
            end
            else
               select @w_valor_calc = 0

            select @w_vencido1 = 0
            select @w_vigente1 = round(isnull(@w_valor_calc,0) + isnull(@w_valor_calc_vig,0) ,@w_num_dec)

            select @w_devolucion = 0
            select @w_subtotal = round(@w_vencido1 + @w_vigente1,@w_num_dec)
         end
         ELSE
         begin  ---Para OTROS RUBROS

            select @w_vencido1 = 0
            select @w_vigente1 = round(@w_proyectado, @w_num_dec)
            select @w_devolucion = 0
            select @w_subtotal = round(@w_vencido1 + @w_vigente1,@w_num_dec)
         end
      end

      if @i_calcula_devolucion = 'S' and @w_am_concepto = @w_concepto_intant
      begin
         select @w_devolucion = isnull(an_valor_pagado - an_valor_amortizado ,0)
         from ca_amortizacion_ant
         where an_operacion =   @w_operacionca
         and   an_dividendo = @w_di_dividendo

         select @w_devolucion = round(isnull(@w_devolucion,0),@w_num_dec)
      end
      else
         select @w_devolucion = 0

      if @i_tipo_pago = 'A'     --ACUMULADO
      begin
         if @w_ro_fpago = 'A' -- ANTICIPADO
         begin
            select @w_dividendo_sig = 0

            select @w_dividendo_sig = isnull(di_dividendo,0)
            from ca_dividendo
            where di_operacion =  @w_operacionca
            and di_dividendo   =  @w_di_dividendo

            if @w_dividendo_sig > 0
            begin
               select @w_valor_calc  = isnull(sum(am_cuota - am_pagado),0)
               from ca_amortizacion
               where am_operacion =  @w_operacionca
               and   am_dividendo =  @w_dividendo_sig + 1
               and   am_concepto  =  @w_am_concepto
               and   am_estado    <> @w_est_cancelado
            end
            ELSE
               select @w_valor_calc = 0

            select @w_vencido1 = 0
            select @w_vigente1 = round(isnull(@w_valor_calc,0)  +  isnull(@w_valor_calc_vig,0) ,@w_num_dec)

            select @w_devolucion = @w_devolucion
            select @w_subtotal = round(@w_vencido1 + @w_vigente1,@w_num_dec)
         end
         ELSE
         begin
            select @w_vencido1 = 0
            select @w_vigente1 = round(@w_acumulado,@w_num_dec)
            select @w_devolucion = 0
            select @w_subtotal = round(@w_vencido1 + @w_vigente1,@w_num_dec)
         end
      end   ---ACUMULADOS


      --- VALOR PRESENTE (VP)
      if @i_tipo_pago = 'E'
      begin
         select @w_valor_calc = 0

         if @w_ro_fpago = 'A'
         begin
            select @w_dividendo_sig = 0

            select @w_dividendo_sig = isnull(di_dividendo, 0)
            from   ca_dividendo
            where  di_operacion =  @w_operacionca
            and    di_dividendo   =  @w_di_dividendo

            if @w_dividendo_sig > 0
            begin
               select @w_valor_calc  = isnull(sum(am_cuota - am_pagado),0)
               from ca_amortizacion
               where am_operacion =  @w_operacionca
               and   am_dividendo =  @w_dividendo_sig + 1
               and   am_concepto  =  @w_am_concepto
               and   am_estado    <> @w_est_cancelado
            end
            ELSE
               select @w_valor_calc = 0
         end
         ELSE -- VENCIDOS
         begin
            select @w_valor_calc = isnull(sum(am_acumulado - am_pagado),0)
            from ca_amortizacion
            where am_operacion =  @w_operacionca
            and am_dividendo   =  @w_di_dividendo
            and am_concepto    =  @w_am_concepto
            and am_concepto    <> @w_int
         end

         --- SELECCION DE LA MAXIMA SECUENCIA DEL RUBRO
         select @w_max_secuencia = max(am_secuencia)
         from ca_amortizacion
         where am_operacion = @w_operacionca
         and am_dividendo   = @w_di_dividendo
         and am_concepto    = @w_int

         select @w_valor_futuro_int = isnull(sum(am_cuota
                                               + case when am_gracia > 0 then 0 else am_gracia end
                                               - am_pagado) ,0)
         from ca_amortizacion
         where am_operacion = @w_operacionca
         and am_dividendo   = @w_di_dividendo
         and am_estado     <> 3
         and am_concepto    = @w_int

         ---PRINT 'qrpagos.sp antes de validacion para valor presente @w_max_secuencia' + @w_max_secuencia

         if  @w_am_concepto  = @w_int  and @w_di_fecha_ven > @w_fecha_proceso  and @w_max_secuencia = 1  and @w_valor_futuro_int > 0
         begin
            select @w_dias = datediff(dd,@w_fecha_proceso,@w_di_fecha_ven)

            if @w_dias_anio = 360
            begin
              exec sp_dias_cuota_360
                   @i_fecha_ini  = @w_fecha_proceso,
                   @i_fecha_fin  = @w_di_fecha_ven,
                   @o_dias       = @w_dias out
            end

            ---TASA EQUIVALENTE A LOS DIAS QUE FALTAN
            exec @w_error =  sp_conversion_tasas_int
                 @i_dias_anio      = @w_dias_anio,
                 @i_base_calculo   = @w_base_calculo,
                 @i_periodo_o      = @w_periodo_d,
                 @i_modalidad_o    = 'V',
                 @i_num_periodo_o  = @w_num_periodo_d,
                 @i_tasa_o         = @w_ro_porcentaje,
                 @i_periodo_d      = 'D',
                 @i_modalidad_d   = 'A', ---La tasa equivalente  debe ser anticipada
                 @i_num_periodo_d  = @w_dias,
                 @i_num_dec        = @w_decimales_tasa,
                 @o_tasa_d         = @w_tasa_prepago output

            if @w_error <> 0
            begin
               goto ERROR
            end

            select @w_cuota_cap  = isnull(sum(am_cuota + am_gracia - am_pagado) ,0)
            from   ca_amortizacion,ca_rubro_op
            where  am_operacion = @w_operacionca
            and    am_operacion  = ro_operacion
            and    am_concepto = ro_concepto
            and    ro_tipo_rubro = 'C'
            and    am_dividendo   = @w_di_dividendo

            select  @w_valor_int_cap = @w_valor_futuro_int + @w_cuota_cap

            exec @w_error = sp_calculo_valor_presente
                 @i_tasa_prepago       = @w_tasa_prepago,
                 @i_valor_int_cap      = @w_valor_int_cap,
                 @i_dias               = @w_dias,
                 @i_valor_futuro_int   = @w_valor_futuro_int,
                 @i_numdec_op          = @w_num_dec,
                 @o_monto              = @w_vp_cobrar  output

            if @w_error <> 0
               goto ERROR

            select @w_int_en_vp = @w_vp_cobrar

            if @w_int_en_vp > 0
               select @w_valor_calc = @w_int_en_vp
            else
               select @w_valor_calc = 0,
                      @w_int_dev = @w_int_en_vp * -1
         end   ---Rubro Interes pagado antes de la fecha de pago
         ELSE
         begin
            if  @w_am_concepto  = @w_int  and @w_di_fecha_ven = @w_fecha_proceso
            begin
               select @w_valor_calc = isnull(sum(am_acumulado - am_pagado),0)
               from ca_amortizacion
               where am_operacion = @w_operacionca
               and am_dividendo   = @w_di_dividendo
               and am_concepto    = @w_int
            end
            ELSE
            if @w_am_concepto  = @w_int  and @w_di_fecha_ven > @w_fecha_proceso  and @w_max_secuencia > 1
            begin
               select @w_valor_calc = isnull(sum(am_acumulado - am_pagado),0)
               from ca_amortizacion
               where am_operacion = @w_operacionca
               and am_dividendo   = @w_di_dividendo
               and am_concepto    = @w_int
            end
         end

         select @w_vencido1 = 0
         select @w_vigente1 = round(@w_valor_calc  + @w_valor_calc_vig ,@w_num_dec)
         select @w_devolucion = 0
         select @w_subtotal = round(@w_vencido1 + @w_vigente1 ,@w_num_dec)
      end --- FIN VALOR PRESENTE (VP)
   end   --- Dividendo VIGENTE

   ---Fin Calculo Dividendo VIGENTE
   ---Inicio Calculo Dividendo No VIGENTE
   if @w_di_estado = @w_est_novigente
   begin
      if @w_ro_fpago = 'A'
      begin
         select @w_vencido1 = 0
         select @w_vigente1 = round(@w_proyectado,@w_num_dec)
         select @w_devolucion = 0
         select @w_subtotal = round(@w_vencido1 + @w_vigente1,@w_num_dec)
      end
   end
   
   ---Fin  Calculo Dividendo No VIGENTE

   --- ACTUALIZACION DE TOTALES
   if ( @w_vencido1 > 0 ) or (@w_vigente1 > 0) or (@w_devolucion > 0) or ( @w_subtotal > 0)
   begin
      if exists(select 1
                from  tmp_totales_pag
                where operacion = @w_operacionca
                and   concepto = @w_am_concepto
                and   spid = @@spid)
      begin
         update tmp_totales_pag
         set    vencido1   = vencido1 + @w_vencido1,
                vigente1   = vigente1 + @w_vigente1,
                devolucion = devolucion + @w_devolucion,
                subtotal1  = subtotal1 + @w_subtotal
         where  operacion = @w_operacionca
         and    concepto  = @w_am_concepto
         and    spid      = @@spid
      end
      ELSE
      begin
         insert tmp_totales_pag
         values (@w_operacionca, @w_am_concepto,   @w_descripcion,
                 @w_vencido1,    @w_vigente1,      @w_devolucion,
                 @w_subtotal,    @@spid,           0)
      end
   end ---valores mayores a cero

   fetch cursor_dividendo
   into  @w_di_dividendo,  @w_di_fecha_ini,  @w_di_fecha_ven,
         @w_di_estado,     @w_di_dias_cuota, @w_am_concepto,
         @w_proyectado,    @w_acumulado
end

close cursor_dividendo
deallocate cursor_dividendo


if @i_tipo_pago = 'E'
begin
   ---MAXIMO DIVIDENDO
   select @w_maximo_div = max(di_dividendo)
   from   ca_dividendo
   where  di_operacion = @w_operacionca

   ---DIVIDENDO VIGENTE
   select @w_div_vigente = max(di_dividendo)
   from   ca_dividendo
   where  di_operacion = @w_operacionca
   and    di_estado      =  @w_est_vigente

   --VALIDAR SI HAY DEVOLUCION DE INTERESES
   if @w_maximo_div = @w_div_vigente and @w_int_dev > 0
   begin
      select @w_parametro_cap = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'CCA'
      and    pa_nemonico = 'CAP'
      select @w_rowcount = @@rowcount
      set transaction isolation level read uncommitted

      if @w_rowcount = 0
      begin
         select @w_error = 701059
         goto ERROR
      end

      update tmp_totales_pag
      set    subtotal1  = subtotal1 - @w_int_dev,
             devolucion = devolucion + @w_int_dev
      where  operacion = @w_operacionca
      and    concepto  = @w_parametro_cap
      and    spid      = @@spid
   end
end

select @w_1_vlr_cap_venc = 0,
       @w_1_div_venc = 0,
       @w_1_vlr_venc = 0

/* SI LA OPERACION TIENE UN PAGO POR RECONOCIMIENTO VALIDA SI EL CAPITAL DE LA */
/* PRIMERA CUOTA VENCIDA SE CANCELO POR EL RECONOCIMIENTO */
if @w_tiene_reco = 'S'
begin
  /* BUSCA LA PRIMERA CUOTA VENCIDA QUE TENGA LA OBLIGACION */
   select top 1
   @w_1_div_venc = di_dividendo
   from ca_dividendo, ca_amortizacion
   where di_operacion  = @w_operacionca
   and   am_operacion  = @w_operacionca
   and   di_operacion  = am_operacion
   and   am_dividendo  = di_dividendo
   and   di_estado     = @w_est_vencido
   and   am_estado     <> 3
   group by di_dividendo
   order by di_dividendo

   if @@rowcount > 0
   begin

      select @w_sec_rpa_rec = dtr_secuencial
      from
      ca_transaccion with (nolock),
      ca_det_trn with (nolock)
      where tr_operacion  = @w_operacionca
      and   tr_operacion  = dtr_operacion
      and   tr_secuencial = dtr_secuencial
      and   tr_secuencial > 0
      and   tr_tran       = 'RPA'
      and   tr_estado     <> 'RV'
      and   dtr_concepto  in (select c.codigo
                              from cobis..cl_tabla t, cobis..cl_catalogo c
                              where t.tabla = 'ca_fpago_reconocimiento'
                              and   t.codigo = c.tabla) -- Req. 397 Formas de pago por reconocimiento

      /* OBTIENE EL SECUENCIAL PAG DEL PAGO POR RECONOCIMIENTO */
      select @w_sec_rpa_pag = ab_secuencial_pag
      from ca_abono with (nolock)
      where ab_operacion = @w_operacionca
      and   ab_secuencial_rpa = @w_sec_rpa_rec

      /* OBTIENE CAPITAL PAGADO POR EL RECONOCIMIENTO */
      select @w_cap_pag_rec = isnull(dtr_monto,0)
      from ca_det_trn with (nolock)
      where dtr_operacion = @w_operacionca
      and   dtr_secuencial = @w_sec_rpa_pag
      and   dtr_dividendo = @w_1_div_venc
      and   dtr_concepto = 'CAP'
      if @w_cap_pag_rec <> 0
      begin 
         select @w_cap_div = isnull(am_cuota,0)
         from ca_amortizacion with (nolock)
         where am_operacion = @w_operacionca
         and   am_dividendo = @w_1_div_venc
         and   am_concepto  = 'CAP'

         if @w_cap_div >= @w_cap_pag_rec
         begin
            /* OBTIENE MONTO CUOTA PROXIMA VENCIDA  */
            select @w_1_vlr_venc = sum(am_acumulado)
            from ca_amortizacion
            where am_operacion = @w_operacionca
            and   am_dividendo = @w_1_div_venc
         end 
      end

   end

end            

if exists (select 1 from ca_ciclo where ci_prestamo = @i_banco) 
begin
    select @w_estado = min(op_estado)
    from ca_operacion, ca_det_ciclo
    where op_operacion = dc_operacion
    and dc_referencia_grupal = @i_banco 
end 
else 
begin
    select @w_estado = op_estado 
    from ca_operacion 
    where op_banco = @i_banco
end

select @w_estado_desc = es_descripcion 
from ca_estado 
where es_codigo = @w_estado


--- ENVIO DE DATOS DE LA CABECERA
select
op_toperacion,      
op_banco,        
op_moneda,
op_tipo,       
op_oficina,
round(convert(float,op_monto_aprobado),@w_num_dec),
round(convert(float,op_monto), @w_num_dec),
convert(varchar,op_fecha_fin,@i_formato_fecha),
op_cliente,         
op_nombre,       
@w_estado_desc,
convert(varchar,@w_di_fecha_ven,@i_formato_fecha),
op_tipo_cobro,      
op_aceptar_anticipos, 
op_tipo_reduccion,
op_tipo_aplicacion, 
op_cuota_completa,
convert(varchar,op_fecha_ult_proceso,@i_formato_fecha),
op_calcula_devolucion,   --19
@w_1_vlr_venc --VALOR DEL PRIMER CAPITAL VENCIDO PAGADO POR EL RECONOCIMIENTO
from ca_operacion
where op_operacion = @w_operacionca

/* SI TIENE RECONOCIMIENTO OBTIENE LA CUOTA PARA AMORTIZAR EL RECONOCIMIENTO */
if @w_tiene_reco = 'S'
begin

   select @w_sec_rpa_rec = dtr_secuencial
   from
   ca_transaccion with (nolock),
   ca_det_trn with (nolock)
   where tr_operacion  = @w_operacionca
   and   tr_operacion  = dtr_operacion
   and   tr_secuencial = dtr_secuencial
   and   tr_secuencial > 0
   and   tr_tran       = 'RPA'
   and   tr_estado     <> 'RV'
   and   (dtr_concepto  = @w_concepto_rec_fng
   or     dtr_concepto  = @w_concepto_rec_usa)

   /* OBTIENE EL SECUENCIAL PAG DEL PAGO POR RECONOCIMIENTO */
   select @w_sec_rpa_pag = ab_secuencial_pag
   from ca_abono with (nolock)
   where ab_operacion = @w_operacionca
   and   ab_secuencial_rpa = @w_sec_rpa_rec

   if @w_sec_rpa_pag <> 0
   begin 
      select @w_recono = sum(dtr_monto)
      from   ca_det_trn   with (nolock)
      where  dtr_operacion    =  @w_operacionca
      and    dtr_secuencial   =  @w_sec_rpa_pag
      and    dtr_dividendo    <= @w_div_venc
      and    dtr_concepto     =  'CAP'

      if @@rowcount = 0
      begin
	     PRINT 'Error Buscando Detalle Abono por Reconocimiento'
         select @w_error = 721330
         goto ERROR
	  end

      select @w_recono    = isnull(@w_recono, 0),
             @w_vlr_amort = isnull(@w_vlr_amort, 0)
	  
	  if @w_vlr_amort < @w_recono
         select @w_recono = sum(@w_recono - @w_vlr_amort)
               
   end
   
   select @w_recono = @w_monto_reconocer + @w_recono

   /* ACTUALIZA TABLA TEMPORAL CON LOS VALORES DEL RECONOCIMIENTO */
   update tmp_totales_pag
   set    subtotal1  = subtotal1 + @w_recono,
          recono     =  recono + @w_recono
   where  operacion = @w_operacionca
   and    concepto  = 'CAP'
   and    spid      = @@spid
end

select
CONCEPTO     = isnull(concepto, ''),
DESCRIPCION  = isnull(descripcion,''),
VENCIDO      = round(convert(float,isnull(vencido1,0)),@w_num_dec),
VIGENTE      = round(convert(float,isnull(vigente1,0)),@w_num_dec),
RECONO       = round(convert(float,isnull(recono,0)),@w_num_dec),
DEVOLUCION   = round(convert(float,isnull(devolucion,0)),@w_num_dec),
TOTAL        = round(convert(money,isnull(subtotal1,0)),@w_num_dec)
from tmp_totales_pag
where operacion = @w_operacionca
and   spid = @@spid

--- PRIORIDADES
select
ro_concepto, co_descripcion, ro_prioridad
from ca_rubro_op, ca_concepto
where ro_operacion = @w_operacionca
and   ro_concepto = co_concepto
and   ro_fpago    not in ('L','B')
order by ro_concepto

--- TASA DE PREPAGO
select @w_ro_porcentaje = isnull(@w_ro_porcentaje, 0)
select @w_ro_porcentaje

/* INCLUIR CALCULO DE SALDO DE HONORARIOS */
exec @w_return    = sp_saldo_honorarios
@i_banco          = @i_banco,
@i_num_dec        = @w_num_dec,
@o_saldo_tot      = @w_saldo_cap out

if @w_return <> 0
begin
   select @w_error = @w_return
   goto ERROR
end

/* SI LA OBLIGACION TIENE RECONOCIMIENTO SUMA EL VALOR QUE SE DEBE AL SALDO CAPITAL */
if @w_tiene_reco = 'S'
   select @w_saldo_cap = @w_saldo_cap + @w_vlr_x_amort

select @w_saldo_cap

/*SI SE PRECANCELA EL PRESTAMOS ANTES DEL 50% DE LAS CUOTAS SE PAGA UNA MULTA*/
select @w_limite_comprecan = pa_int 
from cobis..cl_parametro 
where pa_nemonico ='NCMPRE'



if @w_dias_prestamo > @w_limite_comprecan  select @w_cobrar_comprecan = 'S'
else select @w_cobrar_comprecan = 'N'

if @w_cobrar_comprecan = 'S' begin

   select @w_dividendo_medio = max(di_dividendo)/2 
   from cob_cartera..ca_dividendo 
   where di_operacion = @w_operacionca

   if exists (select 1 from ca_dividendo 
   where di_operacion = @w_operacionca
   and   di_dividendo = @w_dividendo_medio
   and   di_fecha_ven >= @w_fecha_proceso)
      select @w_cobrar_comprecan = 'S' 
   else
      select @w_cobrar_comprecan = 'N' 
   
end


if  @w_cobrar_comprecan = 'S' 
begin
   
   select
   @w_comprecan_ref   = ru_referencial
   from   cob_cartera..ca_rubro
   where  ru_toperacion = @w_toperacion
   and    ru_moneda     = @w_moneda_op
   and    ru_concepto   = @w_comprecan 
   
   if @@rowcount = 0 begin
      select @w_error = 701178
      goto ERROR
   end
   
   /* DETERMINAR LA TASA DE LA COMISION POR PRECANCELACI�N */
   select 
   @w_tasa_comprecan  = vd_valor_default / 100
   from   ca_valor, ca_valor_det
   where  va_tipo   = @w_comprecan_ref
   and    vd_tipo   = @w_comprecan_ref
   and    vd_sector = @w_sector /* sector comercial */
   
   if @@rowcount = 0 begin
       select @w_error = 701085
       goto ERROR
   end

   select
   @w_iva_comprecan_ref   = ru_referencial
   from   cob_cartera..ca_rubro
   where  ru_toperacion = @w_toperacion
   and    ru_moneda     = @w_moneda_op
   and    ru_concepto   = 'IVA_COMPRE'
   
   if @@rowcount = 0 begin
      select @w_error = 701178
      goto ERROR
   end
   
   /* DETERMINAR LA TASA DE LA COMISION POR PRECANCELACI�N */
   select 
   @w_iva_comprecan  = vd_valor_default / 100
   from   ca_valor, ca_valor_det
   where  va_tipo   = @w_iva_comprecan_ref
   and    vd_tipo   = @w_iva_comprecan_ref
   and    vd_sector = @w_sector /* sector comercial */
   
   if @@rowcount = 0 begin
       select @w_error = 701085
       goto ERROR
   end
   
end

 /*CALCU:AR EL VALOR DE LA COMISION POR PRECANCELACI�N Y SU RESPECTIVO IVA */
select @w_mul_precan   =  round(@w_saldo_cap * @w_tasa_comprecan, @w_num_dec) 
select @w_mul_precan   = @w_mul_precan + round(@w_mul_precan * @w_iva_comprecan, @w_num_dec)
select @w_total_precan = @w_saldo_cap + isnull(@w_mul_precan,0)
   
select isnull(@w_mul_precan,0), @w_total_precan
select @o_saldo_cap = @w_total_precan
--MUESTRA UNA ALERTA DEL CLIENTE 

select @w_accion = en_accion
from cobis..cl_ente 
where en_ente = @w_cliente
and isnull(en_accion, 'NIN') <> 'NIN'

if @@rowcount <> 0 
begin
   select @w_alerta = valor 
   from   cobis..cl_catalogo 
   where  codigo = @w_accion
   and    tabla in (select codigo from cobis..cl_tabla 
                     where tabla = 'cl_accion_cliente')

   if @w_alerta is not null
   select @w_alerta 
end

delete tmp_totales_pag where spid = @@spid

return 0

ERROR:
delete tmp_totales_pag where spid = @@spid

exec cobis..sp_cerror
     @t_debug = 'N',
     @t_file = null,
     @t_from  = @w_sp_name,
     @i_num = @w_error

return @w_error

go