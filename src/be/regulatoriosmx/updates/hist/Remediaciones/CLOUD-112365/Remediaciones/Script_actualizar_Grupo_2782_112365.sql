use cob_cartera
go

declare @w_grupo       int        ,
        @w_fecha_valor datetime   ,
        @s_user        login      ,        
        @s_term        varchar(30),
        @s_date        datetime   ,
        @w_operacion   int,
        @w_banco       varchar(20),
        @w_error       int

declare 
        @w_fecha_obj datetime,
        @w_cont int,
        @w_ciclo int ,
        @w_commit char(1)
        
         
select @s_user = 'usrbatch',
       @s_term = 'consola'

select @s_date = fp_fecha
from cobis..ba_fecha_proceso
       

create table #grupos
(grupo            int      null,
 fecha_valor      datetime null,
 fecha_desembolso datetime null
)
 
create table #operaciones_grupos
( operacion   int          null,
  banco       varchar(20)  null)
               
create table #operaciones
(operacion int          null,
 banco     varchar(20)  null,
 fecha_ini datetime     null,
 dias      int          null)

insert into #grupos(grupo, fecha_valor, fecha_desembolso) values(2782 , '01/02/2019', '01/02/2019')


select @w_grupo = 0



while 1 = 1
begin
    select top 1 @w_grupo       = grupo,
                 @w_fecha_valor = fecha_valor,
                 @w_fecha_obj   = fecha_desembolso
    from #grupos
    where grupo > @w_grupo
    order by grupo
    
    if @@ROWCOUNT = 0
       break
    
    select 'Grupo'   = @w_grupo      ,
           'Fecha'   = @w_fecha_valor,
           '@s_user' = @s_user,
           '@s_term' = @s_term,
           '@s_date' = @s_date
        
    truncate table #operaciones_grupos
        
    insert into #operaciones_grupos(
           operacion   , banco)
    select tg_operacion, tg_prestamo
    from cob_credito..cr_tramite_grupal,
         cob_cartera..ca_operacion
    where tg_grupo     = @w_grupo
    and   tg_operacion = op_operacion
    and   tg_participa_ciclo = 'S'
    
    if @@trancount <> 0 begin   
       select @w_commit = 'S'
       begin tran
    end

    select @w_operacion = 0
    
    while 1 = 1
    begin
         select top 1 
                @w_operacion = operacion,
                @w_banco     = banco
         from #operaciones_grupos
         where operacion> @w_operacion
         order by operacion
         
         if @@ROWCOUNT = 0
            break
         
         select 'Grupo'     = @w_grupo    ,
                'Operacion' = @w_operacion,
                'Banco'     = @w_banco
         
         exec @w_error = sp_fecha_valor 
              @s_date        = @s_date,
              @s_user        = @s_user,
              @s_term        = @s_term,
              @t_trn         = 7049,
              @i_fecha_mov   = @s_date,
              @i_fecha_valor = @w_fecha_valor,
              @i_banco       = @w_banco,
              @i_secuencial  = 1,
              @i_operacion   = 'F'                        
              
         if @w_error <> 0
         begin
             goto FIN
         end           
    end
    
    -----------------------------------------------
    print 'Grupo ' + convert(varchar, @w_grupo)
    ----------------------------------------------
    select @w_ciclo = isnull(max(dc_ciclo_grupo),-1) from ca_det_ciclo where dc_grupo = @w_grupo
    if  @w_ciclo = -1 begin 
        print 'No existe ciclo'
        GOTO FIN 
    end
    
    truncate table #operaciones
    
    insert into #operaciones(
        operacion,  banco, fecha_ini, dias)
    select 
        operacion = op_operacion,
        banco     = op_banco, 
        fecha_ini = op_fecha_ini, 
        dias      = 30--datediff(dd, op_fecha_ini , @w_fecha_obj)
    from ca_operacion 
    where op_operacion in (select dc_operacion from ca_det_ciclo where dc_ciclo_grupo = @w_ciclo and dc_grupo = @w_grupo) 
    and op_fecha_ini < @w_fecha_obj
    and op_estado = 1
    
    if @@rowcount = 0 begin 
       print 'NO EXISTEN PRESTAMOS A PROCESAR'
       goto FIN
    end
    
    select * from #operaciones
    
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
end  


FIN:
    
if @w_commit = 'S' begin 
      select @w_commit = 'N'
      rollback tran
end


drop table #grupos
drop table #operaciones_grupos
drop table #operaciones















go



