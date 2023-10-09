use cob_cartera
go

declare 
@w_secuencial int,
@w_cliente    int,
@w_operacion  int,
@w_banco      varchar(24)

create table #actualizar_ciclos(
secuencial       int identity,
cliente          int,
operacion_grupal int,
banco_grupal     varchar(24)
)

create table #cliente_actualizar(
grupo        int,
ciclo_grupo  int,
cliente      int,
operacion    int,
ciclo        int)

insert into #actualizar_ciclos(
operacion_grupal, cliente, banco_grupal)
select distinct dc_operacion, dc_cliente, tg_referencia_grupal
from cob_cartera..ca_det_ciclo,
cob_cartera..ca_operacion,
cob_credito..cr_tramite_grupal
where dc_operacion = op_operacion
and op_banco = tg_referencia_grupal
and tg_prestamo = tg_referencia_grupal

select count(1) from #actualizar_ciclos

select @w_secuencial = 0
while 1 =1
begin
   
   truncate table #cliente_actualizar
   
   select top 1
   @w_secuencial = secuencial,
   @w_cliente    = cliente   ,
   @w_operacion  = operacion_grupal,
   @w_banco      = banco_grupal
   from #actualizar_ciclos
   where secuencial > @w_secuencial
   order by secuencial
   
   if @@ROWCOUNT = 0 break
   
   print '@w_secuencial: ' + convert(varchar,@w_secuencial) + ' @w_cliente: '+ convert(varchar,@w_cliente)

   
   insert into #cliente_actualizar(
   grupo        , ciclo_grupo  ,    cliente   , operacion   , ciclo   )
   select dc_grupo, dc_ciclo_grupo, dc_cliente, dc_operacion, case when dc_ciclo - 1 <=0 then 1 else dc_ciclo - 1 end
   from cob_cartera..ca_det_ciclo   
   where dc_cliente = @w_cliente
   and   dc_operacion > @w_operacion
   order by dc_operacion   
   
   if exists(select 1  from cob_credito..cr_tramite_grupal,
             cob_cartera..ca_operacion
             where op_operacion = @w_operacion
             and   op_banco     = tg_referencia_grupal
             and   tg_cliente   = @w_cliente
             and   tg_monto = 0)
    begin
          print 'Eliminando @w_operacion: ' + convert(varchar,@w_operacion)
          print 'Eliminando @w_cliente: ' + convert(varchar,@w_cliente)
          
          delete cob_cartera..ca_det_ciclo 
          where dc_operacion = @w_operacion 
          and dc_cliente = @w_cliente
          
          update cob_cartera..ca_det_ciclo set
          dc_ciclo = ciclo
          from #cliente_actualizar
          where grupo     = dc_grupo
          and cliente     = dc_cliente
          and operacion   = dc_operacion
          and ciclo_grupo = dc_ciclo_grupo
          
          select * from #cliente_actualizar
          
    end   
end 

drop table #actualizar_ciclos
drop table #cliente_actualizar