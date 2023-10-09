
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
/*    14-11-2020         DCU            Inicio                          */
/************************************************************************/


use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_valida_diapago')
   drop proc sp_valida_diapago
go

create proc sp_valida_diapago
(  
  @i_banco            cuenta,
  @i_fecha_dispersion datetime     = null,
  @i_dia_pago         datetime     = null,
  @i_periodo_int      int          = null,
  @i_tplazo           catalogo     = null,
  @o_fecha_inicio     datetime     = null out,
  @o_dia_inicio       int          = null out,  
  @o_error            int          = null out
)
as declare 
@w_fecha_proceso      datetime,
@w_dias_primer_pago   int,
@w_fecha_inicio_op    datetime,
@w_per_cuotas         int,
@w_fecha_ini_tmp      datetime,
@w_ciudad_nacional    int,
@w_dias_evaluar       int,
@w_dia_inicio         int,
@w_tramite            int,
@w_int_proceso        int,
@w_respuesta          varchar(255),
@w_sp_name            varchar(100),
@w_error              int,
@w_operacionca        int,
@w_int_tmp            money,
@w_iva_tmp            money,
@w_fecha_aux          datetime,
@w_dia_semana_ing     int,   
@w_dia_semana_calc    int

print 'INICIA sp_valida_diapago'
select @w_sp_name = 'sp_valida_diapago'
select 
@w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso 


select @w_tramite = op_tramite,
@w_operacionca = op_operacion
from cob_cartera..ca_operacion
where op_banco = @i_banco

print 'INICIA  1 sp_valida_diapago'
select @w_int_proceso = io_id_inst_proc
from cob_workflow..wf_inst_proceso
where io_campo_3 = @w_tramite

--select top 10 * from cob_workflow..wf_inst_proceso

-- PARAMETRO CODIGO CIUDAD FERIADOS NACIONALES
select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

print 'INICIA  2 sp_valida_diapago'
select @w_dias_primer_pago = 0
   
if @i_fecha_dispersion > @w_fecha_proceso
   select @w_fecha_inicio_op = @i_fecha_dispersion
else
   select @w_fecha_inicio_op = @w_fecha_proceso
   
print 'INICIA  3 sp_valida_diapago'

if @i_dia_pago < @w_fecha_inicio_op begin
    select @o_error = 701197        -- Error fecha de pago menor a la fecha de dispercion
    return 0
end
    
if @i_dia_pago > @w_fecha_inicio_op
   select @w_dias_primer_pago = datediff(dd,@w_fecha_inicio_op,  @i_dia_pago)
   
select @w_per_cuotas = @i_periodo_int * td_factor 
from cob_cartera..ca_tdividendo 
where td_tdividendo = @i_tplazo

print '@i_tplazo: '    + @i_tplazo
print '@w_dias_primer_pago: ' +  convert(varchar,@w_dias_primer_pago)
print '@w_per_cuotas: ' +  convert(varchar,@w_per_cuotas)
print '@w_dias_primer_pago: ' +  convert(varchar,@w_dias_primer_pago)
print '@i_tplazo: ' +  convert(varchar,@i_tplazo)
print '@i_periodo_int: ' +  convert(varchar,@i_periodo_int)
print '@i_fecha_dispersion: ' +  convert(varchar,@i_fecha_dispersion)
   
if @w_dias_primer_pago = 0 --No selecciono ningun cambio en el dia de pago
begin
   select @w_fecha_ini_tmp = @i_fecha_dispersion 
   select @w_dias_evaluar = 0
end 

   
if @w_dias_primer_pago <> 0
begin
   if @i_tplazo = 'W' and @i_periodo_int = 1 --Semanal
   begin  
      if @w_dias_primer_pago > @w_per_cuotas
      begin
         select @w_fecha_ini_tmp = dateadd (dd, (@w_per_cuotas) * (-1), @i_dia_pago)  
         while exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fecha_ini_tmp and df_ciudad = @w_ciudad_nacional)
		 begin
		    select @o_error = 701198        -- Error fecha de pago menor a la fecha de dispercion
            return 0
		 end 
            --select @w_fecha_ini_tmp = dateadd (dd,-1,@w_fecha_ini_tmp)          
      end   
         
      if @w_dias_primer_pago = @w_per_cuotas
         select @w_fecha_ini_tmp = @i_fecha_dispersion   
         
      select @w_dias_evaluar = @w_dias_primer_pago - @w_per_cuotas    
         
   end
   else
   begin -- Cuando no son semanales 
      print '@i_dia_pago: ' + convert(varchar,@i_dia_pago)
      select @w_dia_semana_ing = datepart(WEEKDAY, @i_dia_pago)
      print '@w_dia_semana_ing: ' + convert(varchar,@w_dia_semana_ing)
      select @w_fecha_aux = dateadd (dd, @w_per_cuotas, @i_dia_pago)
      print '@w_fecha_aux 1: ' + convert(varchar,@w_fecha_aux)
      
      select @w_dia_semana_calc =  datepart(WEEKDAY, @w_fecha_aux)
      while (@w_dia_semana_calc <> @w_dia_semana_ing) begin
         select @w_fecha_aux = dateadd(dd,1,@w_fecha_aux)
         select @w_dia_semana_calc =  datepart(WEEKDAY, @w_fecha_aux)
      end
      print '@w_fecha_aux 2: ' + convert(varchar,@w_fecha_aux)
      
      print '@w_dia_semana_calc: ' + convert(varchar,@w_dia_semana_calc) 
      select @w_fecha_ini_tmp = dateadd (dd, (@w_per_cuotas) * (-1), @w_fecha_aux)
      
      print '@w_fecha_ini_tmp 1: ' + convert(varchar,@w_fecha_ini_tmp) 
      
      if day(eomonth(@w_fecha_ini_tmp)) = 31 and month(@w_fecha_ini_tmp)<> month(@w_fecha_aux) 
             select @w_fecha_ini_tmp = dateadd (dd, -1, @w_fecha_ini_tmp)
      
      print '@w_fecha_ini_tmp 2: ' + convert(varchar,@w_fecha_ini_tmp) 
      
             
      /*while exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fecha_ini_tmp and df_ciudad = @w_ciudad_nacional)
	  begin
	       print 'dia feriado'
		    select @o_error = 701198        -- Error fecha de pago menor a la fecha de dispercion
            return 0
	  end 
	  */
	 
	  
      print '@w_fecha_aux 2: ' + convert(varchar,@w_fecha_aux)
      print '@w_dia_semana_calc: ' + convert(varchar,@w_dia_semana_calc) 
      
      
       --select @w_fecha_ini_tmp = @i_dia_pago
      select @w_dias_evaluar = datediff(dd,@i_fecha_dispersion, @i_dia_pago)
   end   
end 
print '@w_dias_evaluar: ' + convert(varchar,@w_dias_evaluar)    
      
print '@w_fecha_ini_tmp: ' +  convert(varchar,@w_fecha_ini_tmp)
select @w_dia_inicio = datediff(dd,@i_fecha_dispersion, @w_fecha_ini_tmp)
print '@w_dia_inicio: ' + convert(varchar,@w_dia_inicio)
select @w_dias_evaluar =isnull(@w_dias_evaluar,-1)

if @w_fecha_ini_tmp is null
begin
    select @o_error = 701196        -- Error fecha de pago menor a la fecha de dispercion
    return 0
end  

select @w_dias_evaluar = isnull(@w_dias_evaluar,0)

exec cob_cartera..sp_cal_val_diapago
@i_banco        = @i_banco,
@i_dias_evaluar = @w_dias_evaluar, 
@o_valor_int    = @w_int_tmp out, 
@o_iva_int      = @w_iva_tmp out

delete cob_cartera..ca_dia_pago where dp_banco = @i_banco
insert into cob_cartera..ca_dia_pago (dp_banco, dp_ini_operacion_tmp, dp_fecha_dispercion, dp_fecha_dia_pag,dp_dias_calc_int, dp_dias_regla, dp_valor_int)
values(@i_banco, @w_fecha_ini_tmp, @i_fecha_dispersion, @i_dia_pago, @w_dia_inicio, @w_dias_evaluar, @w_int_tmp )


exec @w_error = cob_credito..sp_eje_calendario_dia_pago
@i_id_inst_proc = @w_int_proceso, --codigo de instancia del proceso
@o_respuesta    = @w_respuesta out

if @w_respuesta <> 'SI' or @w_error <> 0 or @w_respuesta is null
begin
    print '@w_respuesta: ' + @w_respuesta
    print '@w_error: ' + convert(varchar,@w_error)
    select @o_error = 701196        -- Error fecha de pago menor a la fecha de dispercion
    return 0
end
   
   
 
print '@w_respuesta FIN: ' + @w_respuesta
print '@w_fecha_ini_tmp FIN: ' + convert(varchar,@w_fecha_ini_tmp)
select @o_fecha_inicio = @w_fecha_ini_tmp
select @o_dia_inicio   = @w_dia_inicio
select @o_error = 0 
 
return 0


GO