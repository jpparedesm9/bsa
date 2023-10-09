/************************************************************************/
/*   Archivo:              cuotfran.sp                                  */
/*   Stored procedure:     sp_cuota_francesa                            */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Fabian de la Torre                           */
/*   Fecha de escritura:   Jul. 1997                                    */
/************************************************************************/
/*   IMPORTANTE                                                         */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/  
/*   PROPOSITO                                                          */
/*   Procedimiento  que calcula valor de la cuota en sistema frances    */
/************************************************************************/  
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_cuota_francesa')
   drop proc sp_cuota_francesa
go

create proc sp_cuota_francesa
   @i_operacionca          int,
   @i_monto_cap            money,
   @i_gracia_cap           int,
   @i_tasa_int             money,
   @i_fecha_ini            datetime,
   @i_dias_anio            int = 360,
   @i_num_dec              int = 0,
   @i_periodo_crecimiento  smallint = 0,
   @i_tasa_crecimiento     float = 0,
   @i_tipo_crecimiento     char(1),
   @i_opcion_cap           char(1),
   @i_causacion            char(1) = 'L', 
   @o_cuota                money out
as
declare 
   @w_error                int,
   @w_num_dividendos       int,
   @w_adicionales          money,
   @w_saldo_cap            money,
   @w_cuota                money,
   @w_adicional            money,
   @w_factor_i             float,
   @w_ro_porcentaje        float,
   @w_dias_int             int,
   @w_valor_calc           money,
   @w_periodo_cap          smallint                                  -- REQ 175: PEQUEÑA EMPRESA


-- CALCULAR EL NUMERO DE DIVIDENDOS DE CAPITAL
select @w_num_dividendos = count(1)
from   ca_dividendo_tmp
where  dit_operacion  = @i_operacionca
and    dit_de_capital = 'S'
and    dit_dividendo  > @i_gracia_cap                                -- REQ 175: PEQUEÑA EMPRESA

select 
-- @w_num_dividendos = @w_num_dividendos - @i_gracia_cap,               REQ 175: PEQUEÑA EMPRESA
@w_cuota          = @i_monto_cap
       
if @w_num_dividendos <= 0 begin
   select @w_error = 710005
   goto ERROR
end

-- CUOTAS ADICIONALES
select @w_cuota = @w_cuota - sum(cat_cuota)
from   ca_cuota_adicional_tmp, ca_dividendo_tmp
where  dit_operacion = @i_operacionca
and    cat_operacion = @i_operacionca
and    cat_operacion = @i_operacionca
and    cat_dividendo = dit_dividendo


if @w_cuota <= 0 begin
   select @o_cuota = 0
   return 0
end

if @i_periodo_crecimiento = 0  begin

   select 
   @w_dias_int    = opt_periodo_int * td_factor,                        -- REQ 175: PEQUEÑA EMPRESA opt_periodo_int POR opt_periodo_cap
   @w_periodo_cap = opt_periodo_cap / opt_periodo_int                   -- REQ 175: PEQUEÑA EMPRESA
   from ca_operacion_tmp, ca_tdividendo
   where opt_operacion  = @i_operacionca
   and   opt_tdividendo =  td_tdividendo
   and   td_estado      = 'V'
   
   if @@rowcount = 0 select @w_dias_int = 30                         -- REQ 175: PEQUEÑA EMPRESA @w_dias_cap POR @w_dias_int
   
   -- CONTROL DE DIAS PARA ANIOS BISIESTOS   
   exec @w_error = sp_dias_anio
   @i_fecha     = @i_fecha_ini,
   @i_dias_anio = @i_dias_anio,
   @o_dias_anio = @i_dias_anio out   
   
   if @w_error != 0 return @w_error
   
   select @w_factor_i = (@i_tasa_int * @w_dias_int / (@i_dias_anio * 100.00))       -- REQ 175: PEQUEÑA EMPRESA - AJUSTE PARA PERIODICIDADES DIFERENTES A MENSUAL
   
   select @w_adicionales = sum(cat_cuota / power(1 + @w_factor_i, ceiling((cat_dividendo - @i_gracia_cap) / convert(float, @w_periodo_cap))))       -- REQ 175: PEQUEÑA EMPRESA - AJUSTE PARA CALCULO DE CUOTAS ADICIONALES CON GRACIA
   from   ca_cuota_adicional_tmp, ca_dividendo_tmp
   where  dit_operacion = @i_operacionca 
   and    cat_operacion = dit_operacion
   and    cat_dividendo = dit_dividendo   
    
   -- PRIMERA APROXIMACION DE LA CUOTA POR FORMULA 
   exec @w_error = sp_formula_francesa
   @i_operacionca         = @i_operacionca,
   @i_monto_cap           = @i_monto_cap,
   @i_tasa_int            = @i_tasa_int,
   @i_dias_anio           = @i_dias_anio,
   @i_num_dec             = @i_num_dec, 
   @i_dias_cap            = @w_dias_int,                             -- REQ 175: PEQUEÑA EMPRESA
   @i_adicionales         = @w_adicionales,
   @i_num_dividendos      = @w_num_dividendos,
   @i_periodo_crecimiento = @i_periodo_crecimiento,
   @i_tasa_crecimiento    = @i_tasa_crecimiento,
   @o_cuota               = @w_cuota out 
   
   if @w_error != 0 return @w_error
   
end else begin

   if @i_tipo_crecimiento = 'P' begin
      select @w_cuota = @i_monto_cap / @w_num_dividendos
      select @w_cuota = @w_cuota + @w_cuota * @i_tasa_crecimiento / 100
   end else begin
      select @w_cuota = @i_monto_cap / @w_num_dividendos 
   end
      
   select @w_cuota = @w_cuota  + @w_cuota / (@i_monto_cap / @i_tasa_crecimiento  * @w_num_dividendos / @i_periodo_crecimiento)
end



   

if @w_cuota < 0  select @w_cuota = 10000
   select @o_cuota = round(@w_cuota, @i_num_dec)

return 0

ERROR:

return @w_error
 
go
