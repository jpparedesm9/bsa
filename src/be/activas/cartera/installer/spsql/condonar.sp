/************************************************************************/
/*  Archivo:              condonar.sp                                   */
/*  Stored procedure:     sp_abono_condonaciones                        */
/*  Base de datos:        cob_cartera                                   */
/*  Producto:             Credito y Cartera                             */
/*  Disenado por:         Fabian de la Torre                            */  
/*  Fecha de escritura:   Abril 01 de 1997                              */ 
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA'                                                            */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/  
/*              PROPOSITO                                               */
/*  Procedimiento que realiza el abono de los rubros condonados         */
/*  de Cartera.                                                         */
/*                               CAMBIOS                                */
/*      FECHA              AUTOR          CAMBIO                        */
/*      FEB-2003           Elcira Pelaez  personalizacion BAC           */
/*    11/06/2020           D. Cumbal      Cambios Condonacion Rubros    */
/*                                        de desplazamiento             */
/************************************************************************/  


use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_abono_condonaciones')
   drop proc sp_abono_condonaciones
go

---Inc-23822 Partiendo de la version 3  junio - 30 -2011

create proc sp_abono_condonaciones
@s_ofi                  smallint,
@s_sesn                 int,
@s_user                 login,
@s_term                 varchar (30) = NULL,
@s_date                 datetime     = NULL,
@i_secuencial_ing       int,
@i_secuencial_pag       int,
@i_secuencial_rpa       int,
@i_div_vigente          int,
@i_fecha_pago           datetime = NULL,
@i_en_linea             char(1) = 'N',
@i_tipo_cobro           char(1) = 'A',
@i_operacionca          int,
@i_dividendo            int = 0

as 
declare 
@w_return               int,
@w_sp_name              varchar(30),
@w_concepto             catalogo,
@w_est_cancelado        smallint,
@w_est_novigente        smallint,
@w_monto_rubro          money,
@w_monto_con            float,
@w_monto_con1           money,
@w_dividendo            int,
@w_tcotizacion          char(1),
@w_cotizacion           float,
@w_fecha_ven            datetime,
@w_fpago                char(1),
@w_ro_tipo_rubro        catalogo,
@w_dias_cuota           int,
@w_tasa_prepago         float,
@w_dias                 int,
@w_monto_acum           float,
@w_monto_acum1          money,
@w_op_moneda            smallint,
@w_min_fecha_ven       datetime,
@w_saldo_capital       money,
@w_deuda_OTROS         money,
@w_deuda_CAP           money,
@w_saldo_IMO           money,
@w_saldo_INT           money,
@w_con_tot_CONDONAR    money,
@w_fecha_ult_proceso   datetime,
@w_porcentaje_cond     float,
@w_tipo_cobro          char(1),
@w_num_dec             int 



-- CARGADO DE VARIABLES DE TRABAJO 
select 
@w_sp_name       = 'sp_abono_condonaciones',
@w_con_tot_CONDONAR = 0,
@w_est_cancelado = 3,
@w_est_novigente = 0,
@w_saldo_capital  = 0,
@w_deuda_OTROS    = 0,
@w_deuda_CAP      = 0,
@w_saldo_IMO      = 0,
@w_saldo_INT      = 0,
@w_porcentaje_cond= 1,
@w_tipo_cobro     = 'A'

select @w_op_moneda = op_moneda,
       @w_fecha_ult_proceso = op_fecha_ult_proceso
from ca_operacion
where op_operacion = @i_operacionca


-- LECTURA DE DECIMALES
exec  sp_decimales
     @i_moneda       = @w_op_moneda,
     @o_decimales    = @w_num_dec out
     
select @w_min_fecha_ven = min(di_fecha_ven)
from ca_dividendo
where di_operacion = @i_operacionca
and di_estado  in(1,2)


select @w_saldo_capital = isnull(sum(am_cuota + am_gracia - am_pagado),0)
from   ca_amortizacion, ca_rubro_op
where  am_operacion  = @i_operacionca
and    ro_operacion  = am_operacion
and    ro_concepto   = am_concepto 
and    ro_tipo_rubro = 'C'

if @w_saldo_capital is null
   select @w_saldo_capital = 0
   

select @w_saldo_INT = isnull(sum(am_cuota + am_gracia - am_pagado),0)
from   ca_amortizacion, ca_rubro_op,ca_dividendo
where  am_operacion  = @i_operacionca
and    ro_operacion  = am_operacion
and    ro_concepto   = am_concepto 
and    ro_tipo_rubro = 'I'
and    di_operacion = am_operacion
and    di_dividendo = am_dividendo
and    di_estado in (1,2)

if @w_saldo_INT is null
   select @w_saldo_INT = 0

select @w_saldo_IMO = isnull(sum(am_cuota + am_gracia - am_pagado),0)
from   ca_amortizacion, ca_rubro_op,ca_dividendo
where  am_operacion  = @i_operacionca
and    ro_operacion  = am_operacion
and    ro_concepto   = am_concepto 
and    ro_tipo_rubro = 'M'
and    di_operacion = am_operacion
and    di_dividendo = am_dividendo
and    di_estado in (1,2)

if @w_saldo_IMO is null
   select @w_saldo_IMO = 0

select @w_deuda_CAP = isnull(sum(am_cuota + am_gracia - am_pagado),0)
from   ca_amortizacion, ca_rubro_op,ca_dividendo
where  am_operacion  = @i_operacionca
and    ro_operacion  = am_operacion
and    ro_concepto   = am_concepto 
and    ro_tipo_rubro = 'C'
and    di_operacion = am_operacion
and    di_dividendo = am_dividendo
and    di_estado in (1,2)

if @w_deuda_CAP is null
   select @w_deuda_CAP = 0



select @w_deuda_OTROS = isnull(sum(am_cuota + am_gracia - am_pagado),0)
from   ca_amortizacion, ca_rubro_op,ca_dividendo
where  am_operacion  = @i_operacionca
and    ro_operacion  = am_operacion
and    ro_concepto   = am_concepto 
and    ro_tipo_rubro  not in ( 'C','I','M')
and    di_operacion = am_operacion
and    di_dividendo = am_dividendo
and    di_estado in (1,2)

if @w_deuda_OTROS is null
    select @w_deuda_OTROS = 0

select @w_con_tot_CONDONAR  = (@w_deuda_CAP + @w_deuda_OTROS + @w_saldo_INT + @w_saldo_IMO)
if @w_con_tot_CONDONAR is null
   select @w_con_tot_CONDONAR = 0

insert into ca_datos_condonaciones  values (@i_operacionca,@i_secuencial_pag,@w_min_fecha_ven,@w_saldo_capital,
                                            @w_saldo_INT,  @w_saldo_IMO,     @w_deuda_CAP,    @w_deuda_OTROS,
                                            @w_con_tot_CONDONAR,             @w_fecha_ult_proceso)


-- RUBROS A SER CONDONADOS       
declare cursor_condonaciones cursor for
select
abd_concepto, 
abd_monto_mop,
abd_cotizacion_mop,
abd_tcotizacion_mop
from ca_abono_det
where abd_secuencial_ing = @i_secuencial_ing
and   abd_operacion      = @i_operacionca
and   abd_tipo           = 'CON'
for read only

open cursor_condonaciones

fetch cursor_condonaciones into 
@w_concepto,
@w_monto_con,
@w_cotizacion,
@w_tcotizacion

while   @@fetch_status = 0 begin 
 --WHILE CURSOR PRINCIPAL

   if (@@fetch_status = -1) 
      return 708999

   if @w_concepto in ('INT_ESPERA', 'IVA_ESPERA')
   begin
      select @w_porcentaje_cond = pa_float from cobis..cl_parametro where pa_nemonico = 'POCODE'
      select @w_tipo_cobro      = 'P'
      
      select @w_monto_acum = isnull(sum(am_cuota - am_pagado),0)
      from   ca_amortizacion
      where  am_operacion = @i_operacionca
      and    am_concepto  = @w_concepto
      
   end
   else
      --VALIDAR QUE EL VALOR NO SUPERE EL ACUMULADO POR CONCEPTO
      select @w_monto_acum = isnull(sum(am_acumulado - am_pagado),0)
      from   ca_amortizacion
      where  am_operacion = @i_operacionca
      and    am_concepto  = @w_concepto
   
    
   
  
   if @w_op_moneda <> 0
   begin
      select @w_monto_con1  = round(isnull(@w_monto_con * @w_cotizacion,0),0)
      select @w_monto_acum1 = round(isnull(@w_monto_acum * @w_cotizacion,0),0)
   end

   if @w_monto_con1 > @w_monto_acum1  
      return 710514
   
   
     -- CURSOR DE DIVIDENDOS 
  if @i_dividendo = 0
   declare cursor_dividendos cursor for
   select
   di_dividendo,
   di_fecha_ven,
   di_dias_cuota
   from ca_dividendo
   where di_operacion = @i_operacionca
   and di_estado     != @w_est_cancelado
   order by di_dividendo
   for read only
 else
   declare cursor_dividendos cursor for
   select
   di_dividendo,
   di_fecha_ven,
   di_dias_cuota
   from ca_dividendo
   where di_operacion = @i_operacionca
   and di_estado     != @w_est_cancelado
   and di_dividendo   = @i_dividendo
   order by di_dividendo
   for read only
   
   open cursor_dividendos

   fetch cursor_dividendos into 
   @w_dividendo,
   @w_fecha_ven,
   @w_dias_cuota

   while @@fetch_status = 0 begin
      -- CURSOR DIVIDENDOS 

      if (@@fetch_status = -1) 
         return 708999

      select @w_dias = @w_dias_cuota

      -- MONTO DEL RUBRO A CONDONAR 
      exec @w_return = sp_monto_pago_rubro
      @i_operacionca   = @i_operacionca,
      @i_dividendo     = @w_dividendo,
      @i_tipo_cobro    = @w_tipo_cobro,
      @i_fecha_pago    = @i_fecha_pago,
      @i_dividendo_vig = @i_div_vigente,
      @i_concepto      = @w_concepto,
      @o_monto         = @w_monto_rubro out

      if @w_return != 0
         return @w_return

      select @w_monto_rubro = round(@w_monto_rubro * @w_porcentaje_cond,@w_num_dec)
      
      
      select 
      @w_fpago          = ro_fpago,
      @w_ro_tipo_rubro  = ro_tipo_rubro,
      @w_tasa_prepago   = ro_porcentaje
      from ca_rubro_op
      where ro_operacion = @i_operacionca
        and ro_concepto  = @w_concepto

      
      -- APLICACION DE LA CONDONACION
      
      exec @w_return      = sp_abona_rubro
      @s_ofi              = @s_ofi,
      @s_sesn             = @s_sesn,
      @s_user             = @s_user,
      @s_date             = @s_date,
      @s_term             = @s_term,
      @i_secuencial_pag   = @i_secuencial_pag,      
      @i_operacionca      = @i_operacionca,
      @i_dividendo        = @w_dividendo,
      @i_concepto         = @w_concepto,
      @i_monto_pago       = @w_monto_con,
      @i_monto_prioridad  = @w_monto_rubro, 
      @i_monto_rubro      = @w_monto_rubro,
      @i_tipo_cobro       = @i_tipo_cobro,
      @i_fpago            = @w_fpago,
      @i_en_linea         = @i_en_linea,
      @i_fecha_pago       = @i_fecha_pago,
      @i_condonacion      = 'S',
      @i_cotizacion       = @w_cotizacion,
      @i_tcotizacion      = @w_tcotizacion,
      @i_tipo_rubro       = @w_ro_tipo_rubro,   
      @i_dias_pagados     = @w_dias,
      @i_tasa_pago        = @w_tasa_prepago,
      @o_sobrante_pago    = @w_monto_con out

      if (@w_return != 0) 
         return @w_return
      
      
      if @w_monto_con <= 0 
       begin
          --SALIR DEL CURSOR DE DIVIDENDOS 
         break 
      end

      fetch cursor_dividendos into
      @w_dividendo,
      @w_fecha_ven,
      @w_dias_cuota
   end
   close cursor_dividendos
   deallocate cursor_dividendos
 
   fetch cursor_condonaciones into @w_concepto,@w_monto_con,@w_cotizacion,
   @w_tcotizacion
   

end -- WHILE CURSOR PRINCIPAL
close cursor_condonaciones
deallocate cursor_condonaciones

    --- ACTUALIZACION DE CA_ABONO POR QUE DEBE QUEDAR EN A SI YA APLICO

---print 'condonar_23822.sp Antes de update dias:   @i_secuencial_pag: ' +   CAST ( @i_secuencial_pag as varchar)
        
update ca_abono
set    ab_estado           = 'A',
       ab_secuencial_rpa   = @i_secuencial_rpa
where  ab_secuencial_ing   = @i_secuencial_ing
and    ab_operacion        = @i_operacionca
if @@error != 0 return 705048


---EL CODIGO VALOR DE LOS CONCEPTOS CONDONADOS EN LA TRANSACCION RPA
---DEBEN TENER EL MISMO CODIGO VALOR DE LOS CONCEPTOS DE LA TRANSACCION PAG
create table #ca_codvalor_condonados(
    operacion          int      null,
    secuencial         int      null,
    concepto           catalogo null,
    codvalor            int      null
   )    

insert into #ca_codvalor_condonados
select dtr_operacion,dtr_secuencial,dtr_concepto,dtr_codvalor
from ca_det_trn
where dtr_operacion = @i_operacionca
and dtr_secuencial = @i_secuencial_pag
and dtr_estado <> 7

update ca_det_trn
set dtr_codvalor = codvalor
from #ca_codvalor_condonados
where dtr_operacion = @i_operacionca
and dtr_secuencial = @i_secuencial_rpa
and secuencial     = @i_secuencial_pag
and operacion      = dtr_operacion
and concepto       = dtr_concepto
      

return 0
go



