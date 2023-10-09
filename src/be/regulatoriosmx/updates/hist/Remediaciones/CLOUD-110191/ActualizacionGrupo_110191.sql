
select *
from cobis..cl_parametro 
where  pa_producto = 'CCA'
and    pa_nemonico = 'SALMIN'

update  cobis..cl_parametro 
set pa_money= 0.01
where  pa_producto = 'CCA'
and    pa_nemonico = 'SALMIN'

select *
from cobis..cl_parametro 
where  pa_producto = 'CCA'
and    pa_nemonico = 'SALMIN'
 
use cob_cartera 
go

declare
@w_oficial_ant login,
@w_oficial_dest login,
@w_commit char(1),
@w_login_dest login,
@w_oficina_dest int,
@w_msg varchar(255),
@w_grupo int ,
@w_banco_grupal varchar(50),
@w_fila int, 
@w_error int,
@w_funcionario_dest int,
@w_ciudad_dest int

create table #grupos ( grupo int , funcionario_dest int)
create table #operaciones_hija (tramite int, banco varchar(32) null, operacion int, estado smallint null) 
create table #operaciones_padre (tramite int , banco varchar(50), operacion int)

insert into #grupos values (3, 48)
insert into #grupos values (11, 31)
insert into #grupos values (19, 340)
insert into #grupos values (20, 40)
insert into #grupos values (22, 50)
insert into #grupos values (28, 43)
insert into #grupos values (31, 35)
insert into #grupos values (38, 74)
insert into #grupos values (43, 78)
insert into #grupos values (44, 68)
insert into #grupos values (45, 58)
insert into #grupos values (48, 72)
insert into #grupos values (49, 72)
insert into #grupos values (51, 50)
insert into #grupos values (52, 48)
insert into #grupos values (53, 49)
insert into #grupos values (57, 78)
insert into #grupos values (58, 309)
insert into #grupos values (59, 50)
insert into #grupos values (70, 49)
insert into #grupos values (77, 53)
insert into #grupos values (78, 74)
insert into #grupos values (79, 81)
insert into #grupos values (83, 35)
insert into #grupos values (84, 47)
insert into #grupos values (86, 38)
insert into #grupos values (88, 49)
insert into #grupos values (89, 317)
insert into #grupos values (96, 49)
insert into #grupos values (103, 48)
insert into #grupos values (132, 53)
insert into #grupos values (172, 229)
insert into #grupos values (206, 35)
insert into #grupos values (295, 406)
insert into #grupos values (845, 81)
insert into #grupos values (855, 35)
insert into #grupos values (907, 340)
insert into #grupos values (1188, 43)
insert into #grupos values (1348, 48)
insert into #grupos values (1637, 40)
insert into #grupos values (1660, 316)
insert into #grupos values (1663, 43)
insert into #grupos values (2038, 50)
insert into #grupos values (2071, 48)
insert into #grupos values (2126, 179)
insert into #grupos values (2276, 336)


select 
  @w_grupo = 0

while(1=1) begin
  
   select top 1 
   @w_grupo = grupo,
   @w_funcionario_dest = funcionario_dest 
   from #grupos
   where grupo > @w_grupo 
   order by grupo

   select @w_fila = @@rowcount, @w_error = @@error 
   if @w_fila = 0 begin 
      print 'TERMINA LAZO DE GRUPOS'
      break
   end

   select 
   @w_login_dest = fu_login, 
   @w_oficina_dest = fu_oficina
   from cobis..cl_funcionario
   where fu_funcionario = @w_funcionario_dest

   if @@rowcount = 0 begin 
      select @w_msg = 'ERROR: FUNCIONARIO '+CONVERT(varchar, isnull(@w_funcionario_dest,'n/a')) + ' NO EXISTE'
      goto ERROR 
   end 
    
   select @w_oficial_dest = oc_oficial 
   from cobis..cc_oficial
   where oc_funcionario = @w_funcionario_dest
    
   if @@rowcount = 0 begin 
      select @w_msg = 'ERROR: OFICIAL '+CONVERT(varchar, isnull(@w_oficial_dest, 'n/a')) + ' NO EXISTE'
      goto ERROR 
   end
   
   --SE OBTIENE LA CIUDAD DEL OFICIAL 
   select @w_ciudad_dest = of_ciudad from cobis..cl_oficina--***Se aumenta
   where of_oficina = @w_oficina_dest--@w_oficina_des 

   --VALIDAR QUE EL CARGO DEL OFICIAL SEA ASESOR 
   truncate table #operaciones_hija
   truncate table #operaciones_padre
     
   --BANCO GRUPAL REFERENCIA OPERACION PADRE VIGENTES Y EN VUELO
   insert into #operaciones_padre
   select DISTINCT tg_tramite,tg_referencia_grupal,0
   from cob_credito..cr_tramite_grupal
   where tg_grupo = @w_grupo 
   
   --ACTUALIZAR a NUMEROS DE OPERACION PARA EVITAR TABLE SCAN EN LAS HIS 
   update #operaciones_padre set
   operacion = op_operacion 
   from ca_operacion 
   where op_banco = banco
   
   --OPERACIONES HIJAS DEL GRUPO --TRAMITES EN VUELO WORFLOW 
   insert into #operaciones_hija
   select 
   tramite = 0,
   banco = tg_prestamo,
   operacion = tg_operacion,
   estado = ''
   from cob_credito..cr_tramite_grupal 
   where tg_grupo = @w_grupo
   and tg_monto > 0 
   and tg_participa_ciclo = 'S' 
   and tg_prestamo <> tg_referencia_grupal
   
   --ACTUALIZAR NUMEROS DE TRAMITES A LAS OP HIJAS 
   update #operaciones_hija set
   tramite = op_tramite ,
   estado = op_estado
   from cob_cartera..ca_operacion
   where op_operacion = operacion
   
   --BORRAR CANCELADAS 
   delete #operaciones_hija where estado = 3

   if @@trancount = 0 begin 
      select @w_commit = 'S'
      begin tran 
   end
   
   
   /**************************************************************************/
   --CLIENTE
   update cobis..cl_ente set
   en_oficial = @w_oficial_dest,
   c_funcionario = @w_login_dest,
   en_oficina = @w_oficina_dest
   where en_ente in (select cg_ente 
                     from cobis..cl_cliente_grupo 
                     where cg_grupo  = @w_grupo
                     and   cg_estado = 'V')

   select @w_fila = @@rowcount, @w_error = @@error 
   select ' CL_ENTE AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cobis..cl_ente'
      goto ERROR
   end

   --GRUPO
   update cobis..cl_grupo set 
   gr_oficial = @w_oficial_dest,
   gr_sucursal = @w_oficina_dest--**Se aumenta
   where gr_grupo = @w_grupo
   
   select @w_fila = @@rowcount, @w_error = @@error
   select ' cobis..cl_grupo AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cobis..cl_grupo'
      goto ERROR
   end
    
   --CLIENTES -DEL GRUPO
   update cobis..cl_cliente_grupo set
   cg_usuario = @w_login_dest
   where cg_grupo = @w_grupo

   select @w_fila = @@rowcount, @w_error = @@error
   select ' cobis..cl_cliente_grupo AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cobis..cl_cliente_grupo'
      goto ERROR
   end
   
   --OPERACION PADRE CA_OPERACION
   update cob_cartera..ca_operacion set 
   op_oficial = @w_oficial_dest,
   op_ciudad = @w_ciudad_dest, --**Se aumenta
   op_oficina = @w_oficina_dest --**Se aumenta 
   where op_operacion in (select operacion from #operaciones_padre)
   
   select @w_fila = @@rowcount, @w_error = @@error
   select ' cob_cartera..ca_operacion PADRE AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera..ca_operacion PADRE'
      goto ERROR
   end

   --OPERACIONES HIJAS CA_OPERACION 
   update cob_cartera..ca_operacion set 
   op_oficial = @w_oficial_dest,
   op_ciudad = @w_ciudad_dest, --**Se aumenta
   op_oficina = @w_oficina_dest --**Se aumenta 
   where op_operacion in (select operacion from #operaciones_hija)
    
   select @w_fila = @@rowcount, @w_error = @@error
   select ' cob_cartera..ca_operacion HIJA AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera..ca_operacion HIJAS'
      goto ERROR
   end
    
   --update cob_cartera..ca_operacion_his no para el padre
   --OPERACION CA_OPERACION_HIS HIJAS
   update cob_cartera..ca_operacion_his set 
   oph_oficial = @w_oficial_dest,
   oph_ciudad = @w_ciudad_dest, 
   oph_oficina = @w_oficina_dest 
   where oph_operacion in (select operacion from #operaciones_hija)
    
   select @w_fila = @@rowcount, @w_error = @@error
   select ' cob_cartera..ca_operacion_his HIJA AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera..ca_operacion_his HIJAS'
      goto ERROR
   end
   
   --OPERACION HIJAS COB_CARTERA_HIS
   update cob_cartera_his..ca_operacion set 
   op_oficial = @w_oficial_dest,
   op_ciudad = @w_ciudad_dest,
   op_oficina = @w_oficina_dest
   where op_operacion in (select operacion from #operaciones_hija)
   
   select @w_fila = @@rowcount, @w_error = @@error
   select ' cob_cartera_his..ca_operacion HIJA AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera_his..ca_operacion_his HIJAS '
      goto ERROR
   end

   --OPERACION HIJAS COB_CARTERA_HIS
   update cob_cartera_his..ca_operacion_his set 
   oph_oficial = @w_oficial_dest,
   oph_ciudad = @w_ciudad_dest, 
   oph_oficina = @w_oficina_dest 
   where oph_operacion in (select operacion from #operaciones_hija)

   select @w_fila = @@rowcount, @w_error = @@error
   select ' cob_cartera_his..ca_operacion_his HIJA AFECTADOS' = @w_fila , 'ERROR' = @w_error
    
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera_his..ca_operacion_his HIJAS '
      goto ERROR
   end
   
   --TRAMITE GRUPAL
   update cob_credito..cr_tramite set
   tr_oficina = @w_oficina_dest, -- 
   tr_oficial = @w_oficial_dest--,
   where tr_tramite in(select tramite from #operaciones_padre)
    
   select @w_fila = @@rowcount, @w_error = @@error
   select ' cob_credito..cr_tramite PADRE AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_credito..cr_tramite GRUPAL'
      goto ERROR
   end
    
   --TRAMITE HIJAS 
   update cob_credito..cr_tramite set 
   tr_oficina = @w_oficina_dest,
   tr_oficial = @w_oficial_dest--, 
   where tr_tramite in (select tramite from #operaciones_hija)
    
   select @w_fila = @@rowcount, @w_error = @@error
   select ' cob_credito..cr_tramite HIJA AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_credito..cr_tramite'
      goto ERROR
   end
   
   update cob_cartera..ca_transaccion set--***Se aumenta
   tr_ofi_oper = @w_oficina_dest
   --tr_ofi_usu y tr_usuario -- no se actualiza este campo porque es información referente a donde se realiza la transaccion 
   where tr_operacion in ( select operacion from #operaciones_hija)

   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera..ca_transaccion'
      goto ERROR
   end 
   
   if @w_commit = 'S' begin 
      select @w_commit = 'N'
      commit tran 
   end 
   /**************************************************************************/
   
   goto SIGUIENTE 

   ERROR:
   print isnull(@w_msg ,'no hay mensaje')

   if @w_commit = 'S' begin 
      select @w_commit = 'N'
      rollback tran 
   end 

   SIGUIENTE: 
end

fin:
select * from #grupos
select * from #operaciones_hija
select * from #operaciones_padre

drop table #grupos
drop table #operaciones_hija
drop table #operaciones_padre
go

