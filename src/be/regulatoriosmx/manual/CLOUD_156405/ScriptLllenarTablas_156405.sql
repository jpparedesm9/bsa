use cob_conta_super
go

declare 
@w_mes         int,
@w_anio        int,
@w_mes_actual  int,
@w_anio_actual int,
@w_fin_mes     datetime,
@w_fecha_aux   datetime,
@w_registros   int

select 
@w_mes_actual  = month(fp_fecha),
@w_anio_actual = year(fp_fecha)
from cobis..ba_fecha_proceso

select @w_mes = 1, @w_anio = 2017

while 1 = 1
begin
   if (@w_anio = @w_anio_actual and @w_mes_actual = @w_mes)
      break
   
   
   select @w_fecha_aux = convert(datetime, convert(varchar(2),@w_mes) +'/01/'+convert(varchar(4), @w_anio)) 
   
   exec cob_conta..sp_calcula_ultima_fecha_habil
   @i_reporte			= 'NINGUN',
   @i_fecha             = @w_fecha_aux,
   @o_fin_mes_hab		= @w_fin_mes out
   
   select @w_registros = count(1) from cob_conta_super..sb_dato_operacion where do_fecha = @w_fin_mes
   select @w_mes, @w_anio, @w_fecha_aux, @w_fin_mes, @w_registros
   
     
   insert into dbo.sb_operacion(  
   op_fecha         ,   op_operacion,      op_banco,
   op_cliente       ,   op_toperacion,     op_aplicativo)
   select
   do_fecha         ,   op_operacion,      do_banco,
   do_codigo_cliente,   do_tipo_operacion, 7
   from cob_conta_super..sb_dato_operacion,
   cob_cartera..ca_operacion t
   where do_fecha = @w_fin_mes
   and do_banco = op_banco
   and not  exists (select 1 from sb_operacion s where s.op_operacion = t.op_operacion)
     
   
   
   select @w_mes = @w_mes + 1
   if @w_mes > 12 
   begin
      select @w_mes = 1
      select @w_anio = @w_anio + 1
   end
   
     
      
end  
