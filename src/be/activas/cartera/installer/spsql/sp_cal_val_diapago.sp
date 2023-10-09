
/************************************************************************/
/*      Archivo:                sp_valida_diapago.sp                    */
/*      Stored procedure:       sp_valida_diapago                       */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Dario Cumbal                            */
/*      Fecha de escritura:     14/Nov/2022                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'                                                        */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Realiza el desplazmiento por dia de pago.                       */
/*                            ACTUALIZACIONES                           */
/*      FECHA            AUTOR          MODIFICACION                    */
/*    14-11-2022         DCU            Inicio                          */
/************************************************************************/


use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_cal_val_diapago')
   drop proc sp_cal_val_diapago
go

create proc sp_cal_val_diapago
(  
  @i_banco            cuenta,
  @i_dias_evaluar     int = 0,
  @o_valor_int        money   = null out,
  @o_iva_int          money   = null out 
)
as declare 
@w_fecha_proceso      datetime,
@w_dias_primer_pago   int,
@w_cap_tmp            money,
@w_dia_inicio         int,
@w_tramite            int,
@w_sp_name            varchar(100),
@w_error              int,
@w_operacionca        int,
@w_tasa               float,
@w_iva_tasa           float,
@w_iva_tmp            money,
@w_int_tmp            money,
@w_moneda             int,
@w_num_dec            int  

print 'INICIA sp_cal_val_diapago'
select @w_sp_name = 'sp_cal_val_diapago'

select 
@w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso 

select 
@w_operacionca = opt_operacion,
@w_moneda = opt_moneda
from cob_cartera..ca_operacion_tmp
where opt_banco = @i_banco

if @w_operacionca is null
   select @w_operacionca = op_operacion,
   @w_moneda = op_moneda
   from cob_cartera..ca_operacion
   where op_banco = @i_banco


---NUMERO DE DECIMALES 
exec sp_decimales
@i_moneda       = @w_moneda,
@o_decimales    = @w_num_dec out


select @w_cap_tmp = sum(amt_cuota) 
from cob_cartera..ca_amortizacion_tmp 
where amt_operacion = @w_operacionca 
and amt_concepto = 'CAP' 

if @w_cap_tmp is null
   select @w_cap_tmp = sum(am_cuota) 
   from cob_cartera..ca_amortizacion 
   where am_operacion = @w_operacionca 
   and am_concepto = 'CAP' 

select @w_tasa = isnull(rot_porcentaje/100,0) 
   from ca_rubro_op_tmp 
   where rot_operacion = @w_operacionca
   and rot_concepto    = 'INT'
   
if @w_tasa is null   
   select @w_tasa = isnull(ro_porcentaje/100,0) 
   from ca_rubro_op
   where ro_operacion = @w_operacionca
   and ro_concepto    = 'INT'
   
select @w_iva_tasa = isnull(rot_porcentaje/100,0) 
from   ca_rubro_op_tmp
where  rot_operacion = @w_operacionca
and    rot_concepto = 'IVA_INT'   

if @w_iva_tasa is null
   select @w_iva_tasa = isnull(ro_porcentaje/100,0) 
   from   ca_rubro_op
   where  ro_operacion = @w_operacionca
   and    ro_concepto = 'IVA_INT'    
 
select @i_dias_evaluar = isnull(@i_dias_evaluar,0)
select @w_int_tmp = round(isnull(@w_cap_tmp * @w_tasa/360 ,0),@w_num_dec) * @i_dias_evaluar
select @w_iva_tmp = round(@w_int_tmp * @w_iva_tasa, @w_num_dec)
 
print '@w_int_tmp FIN: ' + convert(varchar,@w_int_tmp)
print '@w_iva_tmp FIN: ' + convert(varchar,@w_iva_tmp)

select @o_valor_int  = isnull(@w_int_tmp,0)
select @o_iva_int    = isnull(@w_iva_tmp,0)

 
return 0


GO