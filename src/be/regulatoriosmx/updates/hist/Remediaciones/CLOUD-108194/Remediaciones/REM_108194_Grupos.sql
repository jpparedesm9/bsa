--Grupo	                    Fecha de desembolso Cobis	Fecha desembolso real	Fecha primer pago solicitada
--#1917     BONSAI 1	    23/10/2018	                24/10/2018	            31/10/2018
--#1913     CAMPO SOTELOS	23/10/2018	                24/10/2018	            31/10/2018
--#1916     CELESTE1	    22/10/2018	                25/10/2018	            01/11/2018


use cob_cartera 
go

declare 
@w_fecha_obj datetime,
@w_cont int,
@w_grupo int ,
@w_ciclo int ,
@w_commit char(1),
@w_fila          int, 
@w_error         int


IF OBJECT_ID('tempdb..#grupos') IS NOT NULL
BEGIN
   drop table #grupos
END


create table #grupos(grupo int, fecha datetime)

insert into #grupos values (1917, '10/24/2018'),(1913, '10/24/2018'), (1916, '10/25/2018'), (748, '10/25/2018')

select @w_grupo = 0

while (1=1)
begin

    select top 1  
    @w_grupo       = grupo,
	@w_fecha_obj   = fecha
    from #grupos
    where grupo > @w_grupo 
    order by grupo 
    
    select @w_fila = @@rowcount, @w_error = @@error    
    if @w_fila = 0 begin 
       print 'TERMINA LAZO DE GRUPOS'
       break
    end 
    
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
end
	
drop table #grupos

FIN:

if @w_commit = 'S' begin 
select @w_commit = 'N'
rollback tran
end

go