use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_actualiza_garantias_neg')
   drop proc sp_actualiza_garantias_neg
go

create proc sp_actualiza_garantias_neg
as
declare
@w_tramite          int,
@w_tipo             catalogo,
@w_porcentaje       float,
@w_return           int,
@w_today            datetime,
@w_operacion        int,
@w_moneda           tinyint,
@w_saldo_cap        money,
@w_saldo_mn         money,
@w_cotizacion       money,
@w_codigo_externo   varchar(64),

@w_filial           tinyint,
@w_sucursal         smallint,
@w_custodia         int,
@w_valor_actual_cal money,
@w_valor_actual     money,
@w_tipo_sup         catalogo,
@w_mensaje          varchar(255)


select @w_today = fp_fecha
from cobis..ba_fecha_proceso

declare cursor_consulta cursor for
select gp_tramite, cu_tipo, cu_porcentaje_cobertura, cu_codigo_externo, cu_valor_actual
from cob_custodia..cu_garnegativa
for read only

open cursor_consulta
fetch cursor_consulta into @w_tramite, @w_tipo, @w_porcentaje, @w_codigo_externo, @w_valor_actual


while @@fetch_status = 0
   begin 
      select @w_operacion = op_operacion, 
             @w_moneda    = op_moneda
      from cob_cartera..ca_operacion
      where op_tramite = @w_tramite


      select @w_saldo_cap = sum(am_cuota + am_gracia - am_pagado)
      from   cob_cartera..ca_amortizacion, cob_cartera..ca_rubro_op
      where  ro_operacion  = @w_operacion
      and    ro_tipo_rubro = 'C'
      and    am_operacion  = @w_operacion
      and    am_estado <> 3
      and    am_concepto   = ro_concepto

      exec @w_return = cob_cartera..sp_conversion_moneda
	   @s_date               = @w_today,
           @i_opcion             = 'L',
           @i_moneda_monto       = @w_moneda,
           @i_moneda_resultado   = 0,
           @i_monto              = @w_saldo_cap,
           @i_fecha              = @w_today,
           @o_monto_resultado    = @w_saldo_mn out,
           @o_tipo_cambio        = @w_cotizacion out

     if @w_return <> 0
     begin
        select @w_mensaje = 'Error al convertir el valor del saldo de capital de la operacion ' + convert(varchar,@w_operacion)
        print @w_mensaje
        goto SIGUIENTE
     end

      exec sp_compuesto
         @t_trn       = 19245,
         @i_operacion = 'Q',
         @i_compuesto = @w_codigo_externo,
         @o_filial    = @w_filial out,
         @o_sucursal  = @w_sucursal out,
         @o_tipo      = @w_tipo out,
         @o_custodia  = @w_custodia out


     if @w_return <> 0
     begin
        select @w_mensaje = 'No se puede separar el codigo externo ' + @w_codigo_externo
        print @w_mensaje
        goto SIGUIENTE
     end



      select @w_tipo_sup = tc_tipo_superior
      from cob_custodia..cu_tipo_custodia
      where tc_tipo = @w_tipo


      select @w_valor_actual_cal = @w_saldo_mn * @w_porcentaje / 100

  
      exec @w_return = sp_modvalor
           @s_date            = @w_today, 
           @s_user            = 'garbatch',
           @i_operacion       = 'I',
           @i_filial          = @w_filial ,
           @i_sucursal        = @w_sucursal ,
           @i_tipo_cust       = @w_tipo ,
           @i_custodia        = @w_custodia ,
           @i_fecha_tran      = @w_today,
           @i_debcred         = 'D',
           @i_valor           = @w_valor_actual,
           @i_descripcion     = 'CAMBIO DE VALOR',
           @i_usuario         = 'garbatch',
           @i_terminal        = 'garbatch',
           @i_autoriza        = 'garbatch',
           @i_nuevo_comercial = @w_valor_actual_cal,
           @i_tipo_superior   = @w_tipo_sup

     if @w_return <> 0
     begin
        select @w_mensaje = 'No se puede modificar el valor de la garantia ' + @w_codigo_externo
        print @w_mensaje
        goto SIGUIENTE
     end



      goto SIGUIENTE

      SIGUIENTE:
      fetch cursor_consulta into @w_tramite, @w_tipo, @w_porcentaje, @w_codigo_externo, @w_valor_actual
end


return 0
go

