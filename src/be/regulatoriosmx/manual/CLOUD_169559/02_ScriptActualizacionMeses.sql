use cob_conta_super
go

declare @w_fecha datetime


create table #fecha(fecha datetime)
create table #informacion_tmp (fecha datetime, codigo_cliente int)
create table #primer_credito (cliente int, fecha_ini datetime)
create table #meses_cliente(cliente int, meses int)

insert into #fecha values('06/30/2021')
insert into #fecha values('07/30/2021')
insert into #fecha values('08/31/2021')
insert into #fecha values('09/30/2021')
insert into #fecha values('10/29/2021')

select @w_fecha = '01/01/1900'

while 1 = 1
begin
    select top 1
    @w_fecha = fecha
    from #fecha
    where fecha > @w_fecha
    order by fecha
    
    if @@rowcount = 0 break
    
    select @w_fecha
    
    truncate table #informacion_tmp
    truncate table #primer_credito
    truncate table #meses_cliente
    
    insert into #informacion_tmp(fecha, codigo_cliente)
    select do_fecha, do_codigo_cliente
    from cob_conta_super..sb_dato_operacion
    where do_fecha = @w_fecha
    
    select '#informacion_tmp', count(1) from #informacion_tmp
          
    insert into #primer_credito (cliente, fecha_ini)
    select cliente= op_cliente, fecha_ini = min(op_fecha_ini) 
    from cob_cartera..ca_operacion,
    #informacion_tmp
    where op_cliente = codigo_cliente
    and not exists (select  1 from cob_credito..cr_tramite_grupal where tg_referencia_grupal = op_banco)
    group by op_cliente
    
    select count(1) from #primer_credito


    insert into #meses_cliente(cliente, meses) 
    select 
    cliente,
    meses= convert(float,datediff(dd, fecha_ini, @w_fecha)/30.4)
    from #primer_credito
    
    select count(1) from #meses_cliente
  
    
    update cob_conta_super..sb_dato_operacion set
    do_meses_primer_op = FLOOR(meses)
    from #meses_cliente
    where do_fecha = @w_fecha
    and   do_codigo_cliente = cliente
    
    
end 


drop table #meses_cliente
drop table #fecha
drop table #primer_credito
drop table #informacion_tmp
