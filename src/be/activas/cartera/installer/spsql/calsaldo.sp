/************************************************************************/
/*   Archivo:              calsaldo.sp                                  */
/*   Stored procedure:     sp_calcula_saldo                             */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         MARCELO POVEDA                               */
/*   Fecha de escritura:   Nov. 2.001                                   */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/*                                   PROPOSITO                          */
/*   Consulta saldo de una operaci¢n a la fecha.                        */
/*   Q: Consulta de negociacion de abonos automaticos                   */
/*   F: Finaciaci¢n de Obligaciones                                     */
/************************************************************************/
/*                                 MODIFICACIONES                       */
/*   FECHA      AUTOR            RAZON                                  */
/*   FEB-2003   Elcira Pelaez    Personalizacion BAC                    */
/*   ABR-2006   Elcira Pelaez    CXCINTES  NR 379                       */ 
/*   MAY-2006   Elcira Pelaez    def 6591 BAC                           */
/*   JUN-2006   Elcira Pelaez    def 6704 BAC                           */
/*   JUL-2009   Francisco Lopez  Add Valor Otros para Suspenso y Cancel.*/
/*   03/09/2020 D. Cumbal        Inc #146782                            */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_calcula_saldo')
   drop proc sp_calcula_saldo
go


create proc sp_calcula_saldo
@i_operacion          int,
@i_tipo_pago          char(1)  = 'E',
@i_renovacion         char(1)  = 'N',
@i_num_periodo_d      int      = null,
@i_periodo_d          catalogo = null,
@i_fecha_ult_proceso  datetime = null,
@i_moneda             smallint = null,
@i_op_estado          tinyint  = null,
@i_dias_anio          int      = null,         
@i_base_calculo       char(1)  = null,
@i_atx                char(1)  = 'N',
@i_decimales_op       tinyint  = null,
@i_div_vigente        int      = null,
@i_di_fecha_ven       datetime = null,
@i_concepto_cap       catalogo = null,
@i_max_div_vencido    int      = null,
@i_max_div_vigente    int      = null,
@o_saldo              money    = 0 out
as

declare
@w_sp_name                 descripcion,
@w_return                  int,
@w_fecha_hoy               datetime,
@w_tipo_rubro              char(1),
@w_ro_concepto             catalogo,
@w_ro_fpago                char(1),
@w_concepto_int            catalogo,
@w_concepto_cap            catalogo,
@w_operacion               int,
@w_di_estado               tinyint,
@w_est_vigente             tinyint,
@w_est_novigente           tinyint,
@w_est_cancelado           tinyint,
@w_estado_op               tinyint,
@w_est_vencido             tinyint,
@w_capital                 money, 
@w_interes                 money, 
@w_mora                    money,
@w_mora_acum               money,
@w_otros                   money,
@w_otros_g                 money,
@w_valor_futuro_int        money, 
@w_div_vigente             int,
@w_dividendo               int,
@w_categoria               char(1),
@w_valor_rubro             money,
@w_num_periodo_d           int,
@w_periodo_d               catalogo,
@w_valor_pagado            money,
@w_fecha_proceso           datetime,
@w_valor_dia_rubro         money,
@w_dias                    int,
@w_dias_div                int,
@w_di_fecha_ini            datetime,
@w_di_fecha_ven            datetime,
@w_dias_faltan_cuota       int,
@w_devolucion              money,
@w_dias_anio               int,       
@w_base_calculo            char(1),
@w_forma_pago_int          char(1),
@w_num_dec_tapl            tinyint,
@w_porcentaje              float,
@w_tasa_prepago            float,
@w_vp_total                money,
@w_vp_cobrar               money,
@w_interes_vencido         money,
@w_cuota_cap               money,
@w_valor_int_cap           money,
@w_no_cobrado_int          money,
@w_int_en_vp               money,
@w_numdec_op               smallint,
@w_moneda                  smallint,
@w_est_suspenso            tinyint,
@w_max_div_vencido         int,
@w_saldo_otr_ven           money,
@w_saldo_otr_ven_acum      money,
@w_saldo_otro              money,
@w_max_div_vigente         int,
@w_interes_acumulado       money,
@w_div_cancelado           int,
@w_min_div_vencido         int,
@w_div_novigente           int,
@w_op_gracia_int           int,
@w_moneda_nacional         tinyint,
@w_max_sec                 int,
@w_max_div                 int,
@w_parametro_cxcintes      catalogo,    ---NR 379
@w_concepto_traslado       catalogo,    ---NR 379
@w_intereses_trasladados   money,       ---NR 379
@w_otros_g_tmp             money,       -- REQ 175: PEQUEÑA EMPRESA
@w_int_g_tmp               money,        -- REQ 175: PEQUEÑA EMPRESA
@w_op_banco                cuenta,
@w_op_cliente              int,
@w_normalizacion           char(1),
@w_codigo                  int

  

--ESTADOS PARA CARTERA
select 
@w_est_vigente            = 1,
@w_est_novigente          = 0,
@w_est_vencido            = 2,
@w_est_cancelado          = 3,
@w_est_suspenso           = 9,
@w_capital                = 0,
@w_interes                = 0,
@w_mora                   = 0,
@w_otros                  = 0,
@w_otros_g                = 0,
@w_div_vigente            = 0,
@w_devolucion             = 0,
@w_valor_futuro_int       = 0,
@w_vp_total               = 0,
@w_vp_cobrar              = 0,
@w_interes_vencido        = 0,
@w_no_cobrado_int         = 0,
@w_int_en_vp              = 0,
@w_cuota_cap              = 0,
@w_valor_int_cap          = 0,
@w_numdec_op              = 0,
@w_interes_acumulado      = 0,
@w_div_cancelado          = 0,
@w_moneda_nacional        = 0,
@w_max_sec                = 0,
@w_intereses_trasladados  = 0,
@w_int_g_tmp              = 0           -- REQ 175: PEQUEÑA EMPRESA
       

if @w_estado_op = @w_est_cancelado
begin
   select @o_saldo = 0
   return 0
end

select @w_codigo = codigo
 from   cobis..cl_tabla
 where tabla = 'ca_conceptos_exc'
   
if @@rowcount = 0
   print 'No existe catalogo  ca_conceptos_exc'
   
-- CODIGO DE LA MONEDA LOCAL
select @w_moneda_nacional = pa_tinyint
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'MLO'
set transaction isolation level read uncommitted

if @i_atx = 'N' 
begin
   -- DATOS DE LA OBLIGACION
   select 
   @w_num_periodo_d   = op_periodo_int,
   @w_periodo_d       = op_tdividendo,
   @w_fecha_proceso   = op_fecha_ult_proceso,
   @w_moneda          = op_moneda,
   @w_estado_op       = op_estado,
   @w_dias_anio       = op_dias_anio,
   @w_base_calculo    = op_base_calculo,
   @w_op_banco        = op_banco,
   @w_op_cliente      = op_cliente
   from   ca_operacion
   where  op_operacion = @i_operacion
   
   -- MANEJO DE DECIMALES
   exec @w_return = sp_decimales
        @i_moneda    = @w_moneda,
        @o_decimales = @w_numdec_op out
   
   select @w_div_vigente  = isnull(di_dividendo,0),
          @w_di_fecha_ven = di_fecha_ven 
   from   ca_dividendo
   where  di_operacion = @i_operacion
   and    di_estado = @w_est_vigente
   
   select @w_max_div_vencido = isnull(max(di_dividendo), 0)
   from   ca_dividendo
   where  di_operacion = @i_operacion
   and    di_estado    = @w_est_vencido
   
   select @w_max_div_vigente = isnull(max(di_dividendo), 0)
   from   ca_dividendo
   where  di_operacion = @i_operacion
   and    di_estado    = @w_est_vigente
   
   if @w_max_div_vigente = 0
      select @w_max_div_vigente = @w_max_div_vencido
end 
else 
begin
   select 
   @w_num_periodo_d   = @i_num_periodo_d,
   @w_periodo_d       = @i_periodo_d,
   @w_fecha_proceso   = @i_fecha_ult_proceso,
   @w_moneda          = @i_moneda,
   @w_estado_op       = @i_op_estado,
   @w_dias_anio       = @i_dias_anio,
   @w_base_calculo    = @i_base_calculo,
   @w_numdec_op       = @i_decimales_op,
   @w_div_vigente     = @i_div_vigente,
   @w_di_fecha_ven    = @i_di_fecha_ven,
   @w_concepto_cap    = @i_concepto_cap,
   @w_max_div_vencido = @i_max_div_vencido,
   @w_max_div_vigente = @i_max_div_vigente 
end

-- CONCEPTO RUBRO CAPITAL
-- ************************
select @w_concepto_cap = ro_concepto
from   ca_rubro_op
where  ro_operacion  = @i_operacion
and    ro_tipo_rubro = 'C'

-- FORMA DE PAGO DEL RUBRO INTERES
-- *********************************
select 
@w_forma_pago_int = ro_fpago,
@w_num_dec_tapl   = ro_num_dec,
@w_concepto_int   = ro_concepto,
@w_porcentaje     = ro_porcentaje
from   ca_rubro_op
where  ro_operacion  = @i_operacion
and    ro_tipo_rubro = 'I'

select @w_op_gracia_int = op_gracia_int
from   ca_operacion
where  op_operacion = @i_operacion

select @w_normalizacion = 'N'
if exists (select 1 from  cob_credito..cr_normalizacion
           where nm_cliente = @w_op_cliente
		   and   nm_operacion = @w_op_banco)
begin
  select @w_normalizacion = 'S'
end

-- REQ 175: PEQUEÑA EMPRESA - DETERMINAR SI LOS OTROS RUBROS SE ENCUENTRAN EN PERIODO DE GRACIA
if @w_op_gracia_int > 0 and @w_div_vigente <= @w_op_gracia_int
   select @i_tipo_pago = 'A'   

   
if @w_estado_op  = 4
    select @i_tipo_pago = 'A'


if @w_estado_op  = 9
begin
   select @w_max_sec  = isnull(max(am_secuencia) ,0)
   from ca_amortizacion
   where am_operacion = @i_operacion
   and am_dividendo = @w_div_vigente
   
   if  @w_max_sec > 1
      select @i_tipo_pago = 'A'
end    

if @w_moneda  <>  @w_moneda_nacional
    select @i_tipo_pago = 'A'

--- INICIO REQ 379 IFJ 22/Nov/2005 
If exists (Select 1 from ca_traslado_interes
           where ti_operacion = @i_operacion
           and  ti_estado     = 'P')
begin
   select @w_parametro_cxcintes = pa_char
   from cobis..cl_parametro
   where pa_producto = 'CCA'
   and   pa_nemonico = 'CXCINT'
   set transaction isolation level read uncommitted
   
   select @w_concepto_traslado  = co_concepto
   from ca_concepto
   where co_concepto = @w_parametro_cxcintes
   
   if @@rowcount = 0 
      return 711017   
        
   select @i_tipo_pago = 'A'
end

--- FIN REQ 379 IFJ 22/Nov/2005 

-- MAXIMO DIVIDENDO 
-- ************************
select @w_max_div = isnull(max(di_dividendo), 0)
from   ca_dividendo
where  di_operacion = @i_operacion
      
-- MIN DIVIDENDO VENCIDO 
-- ************************
select @w_min_div_vencido = isnull(min(di_dividendo), 0)
from   ca_dividendo
where  di_operacion = @i_operacion
and    di_estado    = @w_est_vencido

-- DIVIDENDO NO VIGENTE
-- ***********************
select @w_div_novigente = isnull(min(di_dividendo), 0)
from   ca_dividendo
where  di_operacion = @i_operacion
and    di_estado    = @w_est_novigente
if @w_div_novigente = 0
   select @w_div_novigente =  @w_max_div + 1

-- MODALIDAD DE PAGO, ANTI/VENCIDA
if @w_forma_pago_int = 'P' 
   select @w_forma_pago_int = 'V'

select @w_ro_concepto = ''

while 1=1 
begin
   select top(1)
   @w_tipo_rubro  = ro_tipo_rubro,
   @w_ro_concepto = ro_concepto,
   @w_categoria   = co_categoria,
   @w_ro_fpago    = ro_fpago
   from   ca_rubro_op,  ca_concepto
   where  ro_operacion = @i_operacion
   and    ro_concepto  > @w_ro_concepto
   and    ro_fpago <> 'L'
   and    ro_concepto = co_concepto
   order by ro_concepto

   if @@rowcount = 0
      break
   
   -- CAPITAL
   if @w_tipo_rubro = 'C'
   begin
      select @w_capital = @w_capital + isnull(sum(am_cuota + am_gracia - am_pagado),0)
      from   ca_amortizacion
      where  am_operacion =  @i_operacion
      and    am_dividendo > @w_div_cancelado
      and    am_concepto  =  @w_ro_concepto
      and    am_gracia    >= 0
   end
 
   -- INTERES
   if @w_tipo_rubro = 'I' 
   begin
      if @i_tipo_pago = 'P' -- Paga los interes proyectados
      begin
          select @w_interes = @w_interes +(sum(am_cuota + am_gracia  - am_pagado) +  abs(sum(am_cuota + am_gracia - am_pagado)))/2
          from   ca_amortizacion
          where  am_operacion = @i_operacion
          and    am_dividendo < @w_div_novigente  --Minimo no vigente
          and    am_concepto  = @w_ro_concepto 
          and    am_estado   <> @w_est_cancelado
          and    am_gracia    >= 0
      end

      if @i_tipo_pago = 'A' -- Paga los interes acumulados
      begin
          select @w_interes = @w_interes +(sum(am_acumulado + am_gracia  - am_pagado) +  abs(sum(am_acumulado + am_gracia - am_pagado)))/2
          from   ca_amortizacion
          where  am_operacion = @i_operacion
          and    am_dividendo > @w_div_cancelado
          and    am_concepto  = @w_ro_concepto
          and    am_estado   <> @w_est_cancelado
      end
         
      if @i_tipo_pago = 'E' --Paga los interese en valor presente
      begin
          select @w_interes_vencido = @w_interes_vencido +(sum(am_acumulado + am_gracia  - am_pagado) +  abs(sum(am_acumulado + am_gracia - am_pagado)))/2
          from   ca_amortizacion
          where  am_operacion = @i_operacion
          and    am_dividendo >= @w_min_div_vencido
          and    am_dividendo <= @w_max_div_vencido
          and    am_concepto  = @w_ro_concepto

          --Acumulado del Vigente
          select @w_interes_acumulado = sum(am_acumulado + am_gracia  - am_pagado)
          from   ca_amortizacion
          where  am_operacion = @i_operacion
          and    am_dividendo = @w_div_vigente 
          and    am_concepto  = @w_ro_concepto
       
          if @w_div_vigente > 0 and @w_ro_fpago = 'P'  and @w_interes_acumulado > 0.1
          begin
              declare
              dividendos_vp cursor
              for select di_dividendo, di_fecha_ini, di_fecha_ven, di_estado
              from   ca_dividendo
              where  di_operacion  = @i_operacion
              and    di_dividendo >= @w_div_vigente
              order  by di_dividendo desc
              for read only

              open dividendos_vp
         
              fetch dividendos_vp
              into  @w_dividendo, @w_di_fecha_ini, @w_di_fecha_ven, @w_di_estado
          
              while @@fetch_status = 0
              begin
                  if (@@fetch_status = -1)
                     return 708899
             
                  select @w_valor_futuro_int = isnull(sum(am_cuota
                                             + case when am_gracia > 0 then 0 else am_gracia end -- FQ NO DEBE TENER EN CUENTA LA GRACIA COBRABLE
                                                - am_pagado),0)
                  from   ca_amortizacion, ca_rubro_op
                  where  ro_operacion  = @i_operacion
                  and    ro_operacion  = am_operacion
                  and    ro_concepto   = am_concepto
                  and    am_dividendo  = @w_dividendo
                  and    ro_fpago      <> 'A'
                  and    ro_tipo_rubro = 'I'
                  and    am_estado     <> 3 -- NO INCLUYA LOS INTERESES PAGADOS EN VALOR PRESENTE
             
                  if @w_dias_anio = 360 
                  begin 
                      exec sp_dias_cuota_360
                           @i_fecha_ini = @w_fecha_proceso,
                           @i_fecha_fin = @w_di_fecha_ven,
                           @o_dias      = @w_dias out
                  end
                  else
                      select @w_dias = datediff(dd, @w_fecha_proceso, @w_di_fecha_ven)
             
                  exec @w_return = sp_conversion_tasas_int
                       @i_dias_anio      = @w_dias_anio,
                       @i_base_calculo   = @w_base_calculo,
                       @i_periodo_o      = @w_periodo_d,
                       @i_modalidad_o    = @w_forma_pago_int,
                       @i_num_periodo_o  = @w_num_periodo_d,
                       @i_tasa_o         = @w_porcentaje,
                       @i_periodo_d      = 'D',
                       @i_modalidad_d    = 'A',
                       @i_num_periodo_d  = @w_dias,
                       @i_num_dec        = @w_num_dec_tapl,
                       @o_tasa_d         = @w_tasa_prepago output
             
                  if @w_return <> 0
                     return @w_return
             
                  select @w_cuota_cap  = isnull(am_cuota - am_pagado,0)
                  from   ca_amortizacion
                  where  am_operacion = @i_operacion
                  and    am_dividendo = @w_dividendo
                  and    am_concepto  = @w_concepto_cap

                  select  @w_valor_int_cap = @w_valor_futuro_int + @w_cuota_cap
             
                  exec @w_return = sp_calculo_valor_presente
                       @i_tasa_prepago     = @w_tasa_prepago,
                       @i_valor_int_cap    = @w_valor_int_cap,
                       @i_dias             = @w_dias,
                       @i_valor_futuro_int = @w_valor_futuro_int,
                       @i_numdec_op        = @w_numdec_op,
                       @o_monto            = @w_vp_cobrar  output
             
                  select @w_vp_total = @w_vp_total + @w_vp_cobrar
             
                  fetch dividendos_vp
                  into  @w_dividendo, @w_di_fecha_ini, @w_di_fecha_ven, @w_di_estado

              end -- CURSOR dividendos_vp
          
              close dividendos_vp
              deallocate dividendos_vp

              if @w_interes_acumulado > 0 and @w_vp_total < 0 
              begin
                  select @w_vp_total = @w_vp_total + @w_interes_acumulado 
              end 

          end ---Si existe dividendo vigente
          else
              select @w_vp_total = 0
       
          select @w_interes = @w_vp_total  + isnull(@w_interes_vencido,0)
          select @w_interes = round(@w_vp_total  + isnull(@w_interes_vencido,0),@w_numdec_op)

      end --FIN @i_tipo_pago = 'E'
   end --FIN @w_tipo_rubro = 'I'
   
   -- MORA
   if @w_tipo_rubro = 'M'
   begin
      select @w_mora = isnull(@w_mora,0) + sum(isnull(am_cuota,0) + isnull(am_gracia,0)  - isnull(am_pagado,0))
      from   ca_amortizacion
      where  am_operacion  = @i_operacion
      and    am_dividendo  > 0
      and    am_concepto   = @w_ro_concepto
      and    am_estado    <> @w_est_cancelado
      and    am_gracia    >= 0
      
      select @w_mora_acum = isnull(@w_mora_acum,0) + isnull(@w_mora,0)
   end
   
   -- OTROS GRACIA DE TODOS LOS CONCEPTOS
   if @w_ro_concepto not in (select  codigo from cobis..cl_catalogo where tabla = @w_codigo)
   begin
    if @w_tipo_rubro not in ('C', 'M', 'I')
    begin
      --LOS VALORES ACUMULADOS DE OTROS RUBROS SON SOLO DE LAS CUOTAS VIGENTES y VENCIDAS
      if @i_tipo_pago = 'P' 
      begin
         select @w_otros = isnull(@w_otros, 0) + isnull(sum(am_cuota + am_gracia - am_pagado),0)
         from ca_amortizacion, ca_dividendo
         where am_operacion  = @i_operacion
         and   di_operacion  = @i_operacion
         and   am_operacion  = di_operacion
         and   am_dividendo  = di_dividendo
         and   am_concepto   = @w_ro_concepto
         and   di_estado    in (@w_est_vigente, @w_est_vencido)
         and   am_estado    <> @w_est_cancelado
         and   am_gracia    >= 0
      end
      else
      begin
         select @w_saldo_otr_ven = isnull((sum(am_acumulado + am_gracia - am_pagado) +  abs(sum(am_acumulado + am_gracia - am_pagado)))/2,0)
         from   ca_amortizacion, ca_rubro_op  
         where  am_operacion    = @i_operacion
         and    am_concepto     = @w_ro_concepto
         and    am_dividendo    > @w_div_cancelado
         and    am_estado      <> @w_est_cancelado
         and    ro_operacion    = am_operacion
         and    ro_concepto     = am_concepto
         and    ro_tipo_rubro not in ('C', 'I', 'M')
       
         if @w_saldo_otr_ven < 0 
            select @w_saldo_otr_ven = 0
            
         select @w_saldo_otr_ven_acum = isnull(@w_saldo_otr_ven_acum,0) + isnull(@w_saldo_otr_ven,0)
       
         if @i_renovacion = 'N'  --PARA TODOS LOS CASOS QUE NO SEAN RENOVACION
         begin
             select @w_saldo_otro = isnull(sum(am_acumulado + am_gracia - am_pagado),0)
             from   ca_amortizacion, ca_rubro_op
             where  am_operacion  = @i_operacion
             and    am_dividendo  = @w_max_div_vigente + 1
             and    am_operacion  =  ro_operacion
             and    am_estado     = 2
             and    am_concepto   = ro_concepto
             and    ro_tipo_rubro not in ('C','I','M')
             and    ro_fpago      = 'A'
         end
         else
             select @w_saldo_otro = 0
             ---print '@w_saldo_otr_ven ' + cast (@w_saldo_otr_ven as varchar) +  ' @w_saldo_otro  : ' + cast ( @w_saldo_otro as varchar)
         select @w_otros = isnull(@w_saldo_otr_ven_acum,0) + isnull(@w_saldo_otro,0) 
      end

      -- NR 379
      select @w_intereses_trasladados = (sum(am_acumulado - am_pagado) +  abs(sum(am_acumulado - am_pagado)))/2
      from   ca_amortizacion,
             ca_rubro_op
      where  am_operacion = @i_operacion
      and    am_dividendo > @w_div_vigente 
      and    am_estado   <> @w_est_cancelado
      and    am_operacion = ro_operacion
      and    am_concepto  = ro_concepto
      and    ro_fpago = 'M'
      and    ro_concepto <> 'INT_ESPERA'
      and    am_estado = 0
      
      select @w_otros = isnull(@w_otros, 0) + isnull(@w_intereses_trasladados,0)
     end
   end --concepto 
end


---PARA PROBAR CUANDO HAY ERRORES
---------------------------------
/*
PRINT '@w_capital '    + CAST(@w_capital AS VARCHAR)
PRINT '@w_interes '    + CAST(@w_interes AS VARCHAR)
PRINT '@w_mora '       + CAST(@w_mora_acum AS VARCHAR)
PRINT '@w_otros '      + CAST(@w_otros AS VARCHAR)
PRINT '@w_otros_g '    + CAST(@w_otros_g AS VARCHAR)
PRINT '@w_devolucion ' + CAST(@w_devolucion AS VARCHAR)
*/

if @w_normalizacion = 'S'
begin
	select @o_saldo = isnull(sum(am_acumulado-am_pagado),0)
	from ca_amortizacion,ca_dividendo
	where am_operacion =  @i_operacion
	and am_operacion = di_operacion
	and am_dividendo = di_dividendo
	and am_gracia >= 0
end
ELSE
begin
select @o_saldo = round( isnull(@w_capital,0)
                       + isnull(@w_interes,0)
                       + isnull(@w_mora_acum,0)
                       + isnull(@w_otros,0)
                       + isnull(@w_otros_g,0)
                       - isnull(@w_devolucion,0), @w_numdec_op)
end
--PRINT '@o_saldo ' + CAST(@o_saldo AS VARCHAR)
return 0
go
