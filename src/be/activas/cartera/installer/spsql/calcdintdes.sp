/************************************************************************/
/*   Archivo:             calcdintdes.sp                                */
/*   Stored procedure:    sp_calculo_diario_int_des                     */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Cartera                                       */
/*   Disenado por:        Dario Cumbal                                  */
/*   Fecha de escritura:  Mayo. 2020                                    */
/************************************************************************/
/*                                IMPORTANTE                            */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                 PROPOSITO                            */
/*   Procedimiento que realiza el calculo diario de intereses desplazado*/
/*                              CAMBIOS                                 */
/************************************************************************/
/*      FECHA             AUTOR       CAMBIO                            */
/*      11-May-2020       D. Cumbal   Devengamiento de los rubros de    */
/*                                    desplazamiento                    */
/*      13-Jul-2020       DCU         Caso 142361 ajuste cambios        */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_calculo_diario_int_des')
   drop proc sp_calculo_diario_int_des
go

create proc sp_calculo_diario_int_des
   @s_user                login,
   @s_term                varchar(30),
   @s_date                datetime,
   @i_operacionca         int,
   @i_monto_int           money    = null,
   @i_fecha_proceso       datetime = null
as
declare
   @w_error                   int,
   @w_tipo_amortizacion       varchar(10),
   @w_interes_desplazado      money,
   @w_fecha_ini_desplaza      datetime,
   @w_fecha_fin_desplaza      datetime,
   @w_numero_dias             int,
   @w_monto_dia               money,
   @w_moneda                  tinyint,
   @w_num_dec                 tinyint,
   @w_dividendo               int,
   @w_am_cuota                money,
   @w_am_acumulado            money,
   @w_diferencia              money,
   @w_monto_prv               money,
   @w_ro_concepto             catalogo,
   @w_est_vigente             tinyint,
   @w_est_vencido             tinyint,
   @w_est_cancelado           tinyint,
   @w_est_suspenso            tinyint,
   @w_est_castigado           tinyint,
   @w_oficina_op              int    ,
   @w_estado_op               tinyint,
   @w_monto_int               money  ,
   @w_codvalor                int    ,
   @w_codvalor_iva            int    ,
   @w_am_secuencia            tinyint,
   @w_sector                  int    ,
   @w_rubro_iva               catalogo,       -- CGS-S112643 PARAMETRIZACIÓN BASE DE CARTERA APF
   @w_tasa_iva                float  ,
   @w_tasa_ref_iva            catalogo,
   @w_toperacion              catalogo,
   @w_monto_iva               money   ,
   @w_diferencia_iva          money   ,
   @w_diferencia_int          money
   
--VARIABLES DE TRABAJO
select 
@w_ro_concepto    = 'INT_ESPERA'



---ESTADOS DE LA CARTERA
exec @w_error   = sp_estados_cca
@o_est_vigente   = @w_est_vigente   out,
@o_est_vencido   = @w_est_vencido   out,
@o_est_suspenso  = @w_est_suspenso  out,
@o_est_cancelado = @w_est_cancelado out,
@o_est_castigado = @w_est_castigado out

if @w_error != 0 return @w_error

select 
@w_oficina_op        = op_oficina,
@w_tipo_amortizacion = op_tipo_amortizacion,
@w_moneda            = op_moneda ,
@w_estado_op         = op_estado ,
@w_sector            = op_sector ,
@w_toperacion        = op_toperacion
from   ca_operacion
where  op_operacion = @i_operacionca

if @w_tipo_amortizacion = 'ROTATIVA' return 0
if not exists (select 1 from ca_desplazamiento where de_operacion = @i_operacionca and de_estado = 'A') return 0


select
@w_rubro_iva       = ru_concepto,
@w_tasa_ref_iva    = ru_referencial
from   ca_rubro
where  ru_toperacion          = @w_toperacion
and    ru_moneda              = @w_moneda
and    ru_concepto_asociado   = @w_ro_concepto

if @@rowcount <> 0 begin
   select @w_tasa_iva = vd_valor_default
   from   ca_valor, ca_valor_det
   where  va_tipo   = @w_tasa_ref_iva
   and    vd_tipo   = @w_tasa_ref_iva
   and    vd_sector = @w_sector
      
   if @@rowcount = 0
   begin
      print '(rubrotmp.sp) concepto asociado. Parametrizar Tasa para rubro.. @w_sector ' + cast(@w_tasa_ref_iva as varchar) + ' ' + cast(@w_sector as varchar)
      if @w_error != 0 return 710076          
   end
end
   
   
-- DECIMALES
exec @w_error  = sp_decimales
@i_moneda      = @w_moneda,
@o_decimales   = @w_num_dec out

select 
@w_numero_dias        = datediff(dd,@i_fecha_proceso, de_fecha_fin)
from ca_desplazamiento 
where de_operacion = @i_operacionca
and   de_estado    = 'A'
and   de_fecha_ini <= @i_fecha_proceso
and   de_fecha_fin >  @i_fecha_proceso 

select @w_numero_dias = isnull(@w_numero_dias,1)

if @i_monto_int is null
   select 
   @w_monto_int = round((sum(am_cuota) - sum(am_acumulado)) / @w_numero_dias, @w_num_dec)
   from ca_amortizacion
   where am_operacion = @i_operacionca
   and   am_concepto  = @w_ro_concepto
else
   select @w_monto_int = @i_monto_int

select @w_monto_int = isnull(@w_monto_int,0)   
print '@w_monto_int: ' + convert(varchar,@w_monto_int)

select 
@w_dividendo = min(am_dividendo)
from ca_amortizacion
where am_operacion = @i_operacionca
and   am_concepto  = @w_ro_concepto
and   am_cuota    <> am_acumulado 

select @w_codvalor =  co_codigo * 1000
from ca_concepto
where co_concepto = @w_ro_concepto

select @w_codvalor_iva =  co_codigo * 1000
from ca_concepto
where co_concepto = @w_rubro_iva


if @w_estado_op = @w_est_vigente 
begin   
   select @w_codvalor     = @w_codvalor + @w_estado_op * 10 + 0,
          @w_codvalor_iva = @w_codvalor_iva + @w_estado_op * 10 + 0
end

if @w_estado_op = @w_est_vencido
begin   
   select @w_codvalor     = @w_codvalor + @w_est_suspenso * 10 + 0,
          @w_codvalor_iva = @w_codvalor_iva + @w_est_suspenso * 10 + 0
end 

if @w_estado_op = @w_est_castigado 
begin 
   select @w_codvalor     = @w_codvalor + @w_est_castigado * 10 + 0,
          @w_codvalor_iva = @w_codvalor_iva + @w_est_castigado * 10 + 0
end

while @w_monto_int > 0
begin
   select @w_diferencia = 0
   
   select
   @w_am_secuencia = am_secuencia          ,
   @w_diferencia   = am_cuota - am_acumulado
   from ca_amortizacion
   where am_operacion = @i_operacionca
   and   am_dividendo = @w_dividendo
   and   am_concepto  = @w_ro_concepto
   
   if @@rowcount = 0 break
   
   if @w_diferencia > @w_monto_int
      select @w_monto_prv  = @w_monto_int
   else
      select @w_monto_prv  = @w_diferencia
   
   select @w_monto_int = @w_monto_int - @w_monto_prv
   
   update ca_amortizacion set    
   am_acumulado  = @w_monto_prv  +  am_acumulado
   where  am_operacion = @i_operacionca
   and    am_dividendo = @w_dividendo
   and    am_concepto  = @w_ro_concepto
   
   insert into ca_transaccion_prv with (rowlock) (
   tp_fecha_mov,        tp_operacion,        tp_fecha_ref,
   tp_secuencial_ref,   tp_estado,           tp_dividendo,
   tp_concepto,         tp_codvalor,         tp_monto,
   tp_secuencia,        tp_comprobante,      tp_ofi_oper)
   values (
   @s_date,             @i_operacionca,      @i_fecha_proceso,
   0,                   'ING',               @w_dividendo   ,
   @w_ro_concepto,      @w_codvalor,         @w_monto_prv, 
   @w_am_secuencia,     0,                   @w_oficina_op)
          
   if @@error != 0 return 708165
   
   if @w_rubro_iva is not null
   begin
      
      select @w_monto_iva = round(@w_monto_prv*@w_tasa_iva/100, @w_num_dec)
      
      select @w_diferencia_iva   = am_cuota - am_acumulado
      from cob_cartera..ca_amortizacion
      where am_operacion = @i_operacionca
      and   am_dividendo = @w_dividendo
      and   am_concepto  = @w_rubro_iva
      
      select @w_diferencia_int   = am_cuota - am_acumulado
      from cob_cartera..ca_amortizacion
      where am_operacion = @i_operacionca
      and   am_dividendo = @w_dividendo
      and   am_concepto  = @w_ro_concepto
      
      if @w_diferencia_int = 0 select @w_monto_iva =@w_diferencia_iva
      
      
      insert into ca_transaccion_prv with (rowlock) (
      tp_fecha_mov,        tp_operacion,        tp_fecha_ref,
      tp_secuencial_ref,   tp_estado,           tp_dividendo,
      tp_concepto,         tp_codvalor,         tp_monto,
      tp_secuencia,        tp_comprobante,      tp_ofi_oper)
      values (
      @s_date,             @i_operacionca,      @i_fecha_proceso,
      0,                   'ING',               @w_dividendo   ,
      @w_rubro_iva   ,      @w_codvalor_iva,    @w_monto_iva   , 
      @w_am_secuencia,     0,                   @w_oficina_op)     
       
      if @@error != 0 return 708165
      
      update ca_amortizacion set    
      am_acumulado  = @w_monto_iva  +  am_acumulado
      where  am_operacion = @i_operacionca
      and    am_dividendo = @w_dividendo
      and    am_concepto  = @w_rubro_iva
      
      if @@error != 0 return 708165
   end
   select @w_dividendo = @w_dividendo + 1
       
end 



return 0

go
