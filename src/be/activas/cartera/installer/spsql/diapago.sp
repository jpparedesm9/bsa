/************************************************************************/
/*      Archivo:                diapago.sp                              */
/*      Stored procedure:       sp_dia_pago                             */
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

if exists (select 1 from sysobjects where name = 'sp_dia_pago')
   drop proc sp_dia_pago
go

create proc sp_dia_pago
(  
  @i_banco            cuenta,
  @i_fecha_inicio     datetime     = null,
  @i_num_dias         int          = null,
  @i_oper_nueva       char(1)      = 'S',
  @o_msg              varchar(65)  = null out,
  @o_error            int          = null out  
)
as declare 
@w_fecha_proceso         datetime, 
@w_diario                char(1),
@w_operacionca           int,
@w_cliente               int, 
@w_estado       		 int,
@w_toperacion    		 varchar(24),
@w_moneda        	 	 int,
@w_fecha_ult_proceso     datetime,
@w_oficina               int,
@w_tdividendo            catalogo,
@w_periodo_int           int,
@w_oficial               int,
@w_tasa                  float,
@w_iva_tasa              float,
@w_est_cancelado         int,
@w_est_castigado         int,
@w_est_novigente         int,
@w_est_vencido           int,
@w_di_fecha_ini          datetime,
@w_di_fecha_ven          datetime ,
@w_di_dividendo          int ,
@w_dias_cuota            int,
@w_error      			 int ,
@w_per_cuotas            int ,
@w_fecha_fin             datetime ,
@w_fecha_ini             datetime ,
@w_commit                char(1),
@w_int_dsp               money,
@w_iva_int_dsp           money,
@w_est_vigente           int ,
@w_num_dec               int ,
@w_di_dividendo_ini      int,
@w_di_dividendo_fin      int,
@w_dividendo             int ,
@w_cap_dsp_tmp           money, -- es temporal
@w_monto_tmp             money, -- es temporal
@w_fecha_valor           datetime,
@w_dividendo_desp        int,
@w_fecha_ven             datetime,
@w_numero_dias_div       int

--VALIDACIONES 


--- ESTADOS DE CARTERA 
exec  sp_estados_cca
@o_est_cancelado  = @w_est_cancelado out,
@o_est_castigado  = @w_est_castigado out,
@o_est_vigente    = @w_est_vigente   out,
@o_est_novigente  = @w_est_novigente out,
@o_est_vencido    = @w_est_vencido   out      


select 
@w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso 

if @i_oper_nueva = 'N'  
begin
   select 
   @w_operacionca       = op_operacion,
   @w_cliente           = op_cliente, 
   @w_estado            = op_estado,
   @w_toperacion        = op_toperacion,
   @w_moneda            = op_moneda ,
   @w_fecha_ult_proceso = op_fecha_ult_proceso,
   @w_oficina           = op_oficina,
   @w_tdividendo        = op_tdividendo,
   @w_periodo_int       = op_periodo_int,
   @w_oficial           = op_oficial,
   @w_monto_tmp         = op_monto
   from ca_operacion 
   where op_banco = @i_banco

   if @@rowcount = 0 begin 
      select 
      @o_error =  700001
      GOTO ERROR_FIN
   end 
   
   select @w_cap_dsp_tmp = sum(am_cuota) 
   from ca_amortizacion
   where am_operacion = @w_operacionca
   and   am_concepto  = 'CAP'

   if( @w_cap_dsp_tmp = 0 or @w_monto_tmp = 0) return 0

   select @w_tasa = isnull(ro_porcentaje/100,0) 
   from ca_rubro_op
   where ro_operacion = @w_operacionca
   and ro_concepto    = 'INT'
   
   select @w_iva_tasa = isnull(ro_porcentaje/100,0) 
   from   ca_rubro_op
   where  ro_operacion = @w_operacionca
   and    ro_concepto = 'IVA_INT' 
   
end
else
begin
   select 
   @w_operacionca       = opt_operacion,
   @w_cliente           = opt_cliente, 
   @w_estado            = opt_estado,
   @w_toperacion        = opt_toperacion,
   @w_moneda            = opt_moneda ,
   @w_fecha_ult_proceso = opt_fecha_ult_proceso,
   @w_oficina           = opt_oficina,
   @w_tdividendo        = opt_tdividendo,
   @w_periodo_int       = opt_periodo_int,
   @w_oficial           = opt_oficial,
   @w_monto_tmp         = opt_monto
   from ca_operacion_tmp
   where opt_banco = @i_banco

   if @@rowcount = 0 begin 
      select 
      @o_msg   = 'ERROR: NO EXISTE OPERACION',
      @o_error =  700001
      GOTO ERROR_FIN
   end 
   
   select @w_cap_dsp_tmp = sum(amt_cuota) 
   from ca_amortizacion_tmp 
   where amt_operacion = @w_operacionca
   and   amt_concepto  = 'CAP'

   if( @w_cap_dsp_tmp = 0 or @w_monto_tmp = 0) return 0

   
   select @w_tasa = isnull(rot_porcentaje/100,0) 
   from ca_rubro_op_tmp 
   where rot_operacion = @w_operacionca
   and rot_concepto    = 'INT' 
   
   select @w_iva_tasa = isnull(rot_porcentaje/100,0) 
   from   ca_rubro_op_tmp
   where  rot_operacion = @w_operacionca
   and    rot_concepto = 'IVA_INT'

end


---NUMERO DE DECIMALES 
exec sp_decimales
@i_moneda       = @w_moneda,
@o_decimales    = @w_num_dec out


select 
@w_estado            = op_estado
from ca_operacion 
where op_banco = @i_banco
 

if @w_estado in ( @w_est_castigado, @w_est_cancelado) begin 
   select 
   @o_msg   = 'ERROR: EL ESTADO DE LA OPERACION NO PERMITE DESPLAZAMIENTOS',
   @o_error =  700001
   GOTO ERROR_FIN
end 


select 
@w_di_fecha_ini  = dit_fecha_ini ,
@w_di_fecha_ven  = dit_fecha_ven ,
@w_di_dividendo  = dit_dividendo ,
@w_dias_cuota    = datediff(dd,dit_fecha_ini, dit_fecha_ven) 
from ca_dividendo_tmp 
where dit_operacion   = @w_operacionca
and   dit_dividendo   = 1  

if @@rowcount = 0
   select 
   @w_di_fecha_ini  = di_fecha_ini ,
   @w_di_fecha_ven  = di_fecha_ven ,
   @w_di_dividendo  = di_dividendo ,
   @w_dias_cuota    = datediff(dd,di_fecha_ini, di_fecha_ven) 
   from ca_dividendo 
   where di_operacion  = @w_operacionca
   and  di_dividendo   = 1

print '@w_di_fecha_ini: ' + convert(varchar,@w_di_fecha_ini)
print '@w_di_fecha_ven: ' + convert(varchar,@w_di_fecha_ven)
print '@w_di_dividendo: ' + convert(varchar,@w_di_dividendo)
print '@i_fecha_inicio: ' + convert(varchar,@i_fecha_inicio)
print '@i_num_dias: ' + convert(varchar,@i_num_dias)

--select @w_int_dsp = round(isnull(@w_cap_dsp_tmp * @w_tasa/360 ,0),@w_num_dec) * @i_num_dias

exec cob_cartera..sp_cal_val_diapago
@i_banco        = @i_banco,
@i_dias_evaluar = @i_num_dias, 
@o_valor_int    = @w_int_dsp out, 
@o_iva_int      = @w_iva_int_dsp out 

select @w_int_dsp = isnull(@w_int_dsp,0)
select @w_iva_int_dsp = isnull(@w_iva_int_dsp,0)

select @w_di_fecha_ini = dateadd(dd, @i_num_dias *(-1), @i_fecha_inicio)
select @w_numero_dias_div = datediff(dd, @w_di_fecha_ini, @w_di_fecha_ven)

print '@w_di_fecha_ini: ' + convert(varchar,@w_di_fecha_ini)
print '@w_numero_dias_div: ' + convert(varchar,@w_numero_dias_div)
print '@w_cap_dsp_tmp: ' + convert(varchar,@w_cap_dsp_tmp)
print '@w_int_dsp: ' + convert(varchar,@w_int_dsp)
print '@w_iva_int_dsp: ' + convert(varchar,@w_iva_int_dsp)
/*
update ca_operacion set 
op_fecha_ini = @w_di_fecha_ini
where op_operacion = @w_operacionca */

update ca_operacion_tmp set 
opt_fecha_ini = @w_di_fecha_ini,
opt_fecha_liq = @w_di_fecha_ini,
opt_fecha_ult_proceso = @w_di_fecha_ini
where opt_operacion = @w_operacionca 
and  @w_di_fecha_ini is not null

update cob_credito..cr_tramite set
tr_fecha_dispersion = @w_di_fecha_ini
from ca_operacion_tmp
where opt_operacion = @w_operacionca--@w_tramite
and opt_tramite = tr_tramite
and @w_di_fecha_ini is not null
--select * from ca_operacion_tmp where opt_operacion = @w_operacionca
/*
update ca_dividendo set
di_fecha_ini = @w_di_fecha_ini
where di_operacion  = @w_operacionca
and  di_dividendo   = 1*/

update ca_dividendo_tmp set
dit_fecha_ini = @w_di_fecha_ini,
dit_dias_cuota= @w_numero_dias_div
where dit_operacion  = @w_operacionca
and  dit_dividendo   = 1
and  @w_di_fecha_ini is not null

--select * from ca_dividendo_tmp where dit_operacion = @w_operacionca

update ca_amortizacion_tmp set
amt_cuota = amt_cuota + isnull(@w_int_dsp,0)
where amt_operacion  = @w_operacionca
and   amt_dividendo  = 1
and   amt_concepto   = 'INT' 

update ca_amortizacion_tmp set
amt_cuota = amt_cuota + isnull(@w_iva_int_dsp,0)
where amt_operacion  = @w_operacionca
and   amt_dividendo  = 1
and   amt_concepto   = 'IVA_INT' 

/*
update ca_amortizacion set
am_cuota = am_cuota + @w_int_dsp
where am_operacion  = @w_operacionca
and   am_dividendo  = 1
and   am_concepto   = 'INT'*/

update cob_cartera..ca_dia_pago set
dp_valor_int = @w_int_dsp
where dp_banco = @i_banco

/*
if @w_commit = 'S' begin 
   select @w_commit = 'N'
   commit tran
end*/

 
return 0

ERROR_FIN:

if @w_commit = 'S'begin 
   select @w_commit = 'N'
   rollback tran    
end 

select @w_error= @o_error

return @w_error


GO

