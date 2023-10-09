use cob_cartera 
go

declare 
@w_fecha_obj datetime,
@w_cont int,
@w_grupo int ,
@w_ciclo int ,
@w_commit char(1)


select 
@w_fecha_obj = '12/10/2018', --COLOCAR LA FECHA EN LA QUE SE DEBIO DESEMBOLSAR EL PRES
@w_grupo = 1200 --GRUPO


select @w_ciclo = isnull(max(dc_ciclo_grupo),-1) from ca_det_ciclo where dc_grupo = @w_grupo
if @w_ciclo = -1 begin 
print 'No existe ciclo'
GOTO FIN 
end

select 
operacion = op_operacion,
banco = op_banco, 
fecha_ini = op_fecha_ini, 
dias = datediff(dd, op_fecha_ini , @w_fecha_obj)
into #operaciones
from ca_operacion 
where op_operacion in (select dc_operacion from ca_det_ciclo where dc_ciclo_grupo = @w_ciclo and dc_grupo = @w_grupo) 
and op_fecha_ini < @w_fecha_obj
and op_estado = 1

if @@rowcount = 0 begin 

print 'NO EXISTEN PRESTAMOS A PROCESAR'
goto FIN
end

if @@trancount = 0 begin 
select @w_commit = 'S'
begin tran
end

update ca_operacion set 
op_fecha_fin =dateadd(dd,dias,op_fecha_fin)
from #operaciones
where op_operacion = operacion 
if @@error <> 0 goto FIN


update ca_operacion_his set 
oph_fecha_fin =dateadd(dd,dias,oph_fecha_fin)
from #operaciones
where oph_operacion = operacion 
if @@error <> 0 goto FIN

update cob_cartera_his..ca_operacion_his set 
oph_fecha_fin =dateadd(dd,dias,oph_fecha_fin)
from #operaciones
where oph_operacion = operacion 
if @@error <> 0 goto FIN

update ca_dividendo set 
di_fecha_ini = dateadd(dd, case when di_dividendo = 1 then 0 else dias end, di_fecha_ini),
di_fecha_ven = dateadd(dd, dias,di_fecha_ven),
di_dias_cuota = di_dias_cuota + case when di_dividendo = 1 then dias else 0 end
from #operaciones
where di_operacion = operacion 
if @@error <> 0 goto FIN 

update ca_dividendo_his set 
dih_fecha_ini = dateadd(dd, case when dih_dividendo = 1 then 0 else dias end, dih_fecha_ini),
dih_fecha_ven = dateadd(dd, dias,dih_fecha_ven),
dih_dias_cuota = dih_dias_cuota + case when dih_dividendo = 1 then dias else 0 end
from #operaciones
where dih_operacion = operacion 
if @@error <> 0 goto FIN 

update cob_cartera_his..ca_dividendo_his set 
dih_fecha_ini = dateadd(dd, case when dih_dividendo = 1 then 0 else dias end, dih_fecha_ini),
dih_fecha_ven = dateadd(dd, dias,dih_fecha_ven),
dih_dias_cuota = dih_dias_cuota + case when dih_dividendo = 1 then dias else 0 end
from #operaciones
where dih_operacion = operacion 
if @@error <> 0 goto FIN


if @w_commit = 'S' begin 
select @w_commit = 'N'
commit tran
end

drop table #operaciones

FIN:

if @w_commit = 'S' begin 
select @w_commit = 'N'
rollback tran
end

go
