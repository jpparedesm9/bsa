
/*******SCRIPT PARA LLENAR LOS VALORES DE MONTO APROBADO *********/
/*******SE DEBE EJECUTAR UNA SOLA VEZ******************/
declare 
@w_operacion int,
@w_valor_incremento money,
@w_fecha_incremento datetime


IF OBJECT_ID('tempdb..#operaciones') IS NOT NULL DROP table #operaciones
IF OBJECT_ID('tempdb..#incrementos') IS NOT NULL DROP table #incrementos


create table #operaciones(
	_operacion int,
	_monto_aprobado money
)

create table #incrementos(
	_operacion int,
	_valor_incremento money,
	_fecha_incremento datetime
)

insert into #operaciones 
select  distinct (do_operacion), null
 from cob_conta_super..sb_dato_operacion
 where 
 do_aplicativo = 7
and   do_tipo_operacion  in ('REVOLVENTE')
group by do_operacion

update #operaciones
set _monto_aprobado = op_monto_aprobado
from cob_cartera..ca_operacion
where op_operacion = _operacion


select @w_operacion = 0

update cob_conta_super..sb_dato_operacion
set do_monto_aprobado = _monto_aprobado
from #operaciones
where do_operacion = _operacion
and do_aplicativo = 7
and   do_tipo_operacion  in ('REVOLVENTE')

print 'antes del while '
	
while (1=1) begin

	select top 1 @w_operacion = _operacion
	from #operaciones
	where _operacion > @w_operacion
	order by _operacion 

	if @@rowcount = 0
		break
	

	truncate table #incrementos
   
   insert into #incrementos
   select ic_operacion,
   ic_monto_aprobado_ini,
   ic_fecha_proceso
   from
   cob_cartera..ca_incremento_cupo 
   where ic_operacion = @w_operacion
   order by ic_fecha_proceso desc
   
   select @w_fecha_incremento = '01/01/2050'
   
   while(1=1) begin
   	select top 1 
   	@w_fecha_incremento = _fecha_incremento,
   	@w_valor_incremento = _valor_incremento
   	from #incrementos
   	where _fecha_incremento<@w_fecha_incremento
   	order by _fecha_incremento desc
   
      if @@rowcount = 0
      	break
      	
      update cob_conta_super..sb_dato_operacion
		set do_monto_aprobado = @w_valor_incremento
	  	where do_operacion = @w_operacion
		and do_aplicativo = 7
		and   do_tipo_operacion  in ('REVOLVENTE')
		and do_fecha <= @w_fecha_incremento
   
   end
   
   
end


