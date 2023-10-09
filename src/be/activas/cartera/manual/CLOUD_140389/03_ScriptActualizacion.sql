use cob_cartera
go

declare 
@w_operacion           int = 0,
@w_cliente             int,
@w_num_div             int,
@w_monto_int_desp      money,
@w_int_espera          varchar(15),
@w_fecha_proceso       datetime,
@w_banco               cuenta,
@w_moneda              int,
@w_oficina             int,
@w_toperacion          varchar(10),
@w_error               int,
@w_cuotas_a_desplazar  int,
@w_fecha_desp          datetime,
@w_fecha_ini           datetime,
@w_secuencial_des      int,
@w_fecha_desembolso    datetime

SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso
select @w_fecha_desembolso = '05/28/2020' --Fecha desde la cual las operaciones desplazadas tiene problemas 

select *
into #operacion_140389
from cob_cartera..ca_operacion
where op_estado in (1 , 2)
and   op_operacion in (select op_operacion from ca_operaciones_140389)


select *
from #operacion_140389


select @w_operacion = 0

while 1 = 1 begin

   SELECT top 1
   @w_operacion    = op_operacion,
   @w_banco        = op_banco,
   @w_moneda       = op_moneda,
   @w_oficina      = op_oficina,
   @w_cliente      = op_cliente,
   @w_fecha_ini    = op_fecha_ini
   FROM #operacion_140389 
   WHERE op_operacion > @w_operacion
   order by op_operacion asc
   
   if @@rowcount = 0 break 
   
   
   ----Llevar operaciones a fecha de inicio   
   exec @w_error = sp_fecha_valor 
        @s_date        = @w_fecha_proceso,
        @s_user        = 'usrbatch',
        @s_term        = 'consola',
        @s_ofi         = @w_oficina,
        @t_trn         = 7049,
        @i_fecha_mov   = @w_fecha_proceso,
        @i_fecha_valor = @w_fecha_proceso,
        @i_banco       = @w_banco,
        @i_operacion   = 'F'            
       
   if @w_error <> 0
      goto Siguiente
                

   Siguiente:   
end



select op_fecha_ult_proceso, *
from ca_operacion
where op_operacion in (select op_operacion from ca_operaciones_140389)




select 'FINAL'= count(1)
from ca_abono
where ab_operacion in (select op_operacion from ca_operaciones_140389)
and   ab_estado    in ('A','ING')



drop table #operacion_140389
go
