

use cob_cartera 
go 


declare
@w_oficial_ant   login,
@w_oficial_des   login,
@w_tramite_max  int,
@w_commit        char(1),
@w_oficial_login login,
@w_oficina       int,
@w_msg           varchar(255),
@w_grupo         int ,
@w_banco_grupal  varchar(50) 



create table #grupos ( grupo int , oficial_dest int)
create table #operaciones(  tramite int,operacion int) 
create table #operaciones_padre(tramite int , banco varchar(50), operacion int)


--COLOCAR AQUI LOS GRUPOS Y OFICIAL DESTINO
/*

id_grupo	NOMBRE GRUPO	id_funcionario	USUARIO
1076	   PLATINO			276				lrochama
1258	   TUIIOXSIEMPRE	274				rmartinezma 
1183	   GABYS			274				rmartinezma 
1008	   DIAMANT			304				macortesos
978	       EMPRENDEDORESS	294				ajgarciaes
1218	   LAS PUNTUALES	295				lfaguirre
1196	   HONEZTIDAD 		304				macortesos

*/


insert into #grupos values (1076,	276)
insert into #grupos values (1258,	274)
insert into #grupos values (1183,	274)
insert into #grupos values (1008,	304)
insert into #grupos values (978	,   294)
insert into #grupos values (1218,	295)
insert into #grupos values (1196,	304)

select 
@w_grupo       = 0,
@w_tramite_max = 0   

while(1=1) begin 


   select top 1  
   @w_grupo        = grupo,
   @w_oficial_des = oficial_dest	
   from #grupos
   where grupo >@w_grupo 
   order by grupo 
   
   if @@rowcount = 0 break 
   
   select 
   @w_oficial_login = fu_login, 
   @w_oficina       = fu_oficina
   from cobis..cl_funcionario
   where fu_funcionario = @w_oficial_des
   
   if @@rowcount = 0 begin 
   select @w_msg = 'ERROR: OFICIAL '+CONVERT(varchar, @w_oficial_des) + ' NO EXISTE'
      goto ERROR
   
   end 
   
   --VALIDAR QUE EL CARGO DEL OFICIAL SEA ASESOR 
   
   truncate table #operaciones 
   truncate table #operaciones_padre
   
   --MAXIMO TRAMITE GRUPAL 
   select @w_tramite_max  = max(tg_tramite)
   from cob_credito..cr_tramite_grupal
   where tg_grupo = @w_grupo  
    
   
   --BANCO GRUPAL REFERENCIA OPERACION PADRE VIGENTES Y EN VUELO
   insert into #operaciones_padre
   select tg_tramite,tg_referencia_grupal,0
   from   cob_credito..cr_tramite_grupal
   where tg_grupo = @w_grupo  
   
   --ACTUALIZAR a NUMEROS DE OPERACION PARA EVITAR TABLE SCAN EN LAS HIS  
   update #operaciones_padre set
   operacion = op_operacion  
   from #operaciones, ca_operacion 
   where op_banco =  banco
   
   --OPERACIONES HIJAS DEL GRUPO  --TRAMITES EN VUELO WORFLOW 
   insert into #operaciones 
   select 
   tramite  = 0,
   operacion=tg_operacion
   from cob_credito..cr_tramite_grupal 
   where tg_grupo = @w_grupo 
   and tg_tramite = @w_tramite_max 
   and tg_monto > 0 and tg_participa_ciclo = 'S' 
   and tg_prestamo <> tg_referencia_grupal
   
   --OPERACIONES HIJAS DEL GRUPO EN CARTERA  NO ESTEN CANCELADOS Y QUE NO ESTEN EN LA TABLA ANTERIOR 
   
   insert into #operaciones 
   select 
   tramite   = op_tramite,
   operacion = op_operacion 
   from ca_operacion 
   where op_estado not in (3) 
   and op_operacion in (select dc_operacion from ca_det_ciclo where dc_grupo = @w_grupo) 
   and op_operacion not in (select operacion from #operaciones)
   
   --ACTUALIZAR NUMEROS DE TRAMITES A LAS OP HIJAS 
   update #operaciones set
   tramite = tr_tramite 
   from #operaciones, cob_credito..cr_tramite
   where tr_numero_op= operacion
 
   
   if @@trancount = 0 begin 
      select @w_commit = 'S'
	  begin tran 
   end 

    --CLIENTE
   update cobis..cl_ente set    
   en_oficial     = @w_oficial_des,
   c_funcionario  = @w_oficial_login,
   en_oficina     = @w_oficina
   where  en_ente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo)
   
   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cobis..cl_ente'
      goto ERROR
   end 
   
   --GRUPO
   update cobis..cl_grupo set    
   gr_oficial = @w_oficial_des
   where  gr_grupo   = @w_grupo
   
   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cobis..cl_grupo'
      goto ERROR
   end
   
   --CLIENTES -DEL GRUPO
   update cobis..cl_cliente_grupo  set    
   cg_usuario = @w_oficial_login
   where  cg_grupo   = @w_grupo
   and    cg_ente  in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo and cg_estado = 'V')
   
   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cobis..cl_cliente_grupo'
      goto ERROR
   end
   
   
   --OPERACION PADRE CA_OPERACION 
   update cob_cartera..ca_operacion set    
   op_oficial = @w_oficial_des 
   where  op_operacion in(select operacion from #operaciones_padre)
  
   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera..ca_operacion PADRE'
      goto ERROR
   end
   
   --OPERACIONES HIJAS CA_OPERACION 
   update cob_cartera..ca_operacion set    
   op_oficial = @w_oficial_des 
   where op_operacion in (select operacion from #operaciones)
   
   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera..ca_operacion HIJAS'
      goto ERROR
   end
   
    --OPERACION  CA_OPERACION_HIS PADRE
   update cob_cartera..ca_operacion_his set    
   oph_oficial = @w_oficial_des 
   where oph_operacion in(select operacion from #operaciones_padre)
   
    if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera..ca_operacion_his PADRE'
      goto ERROR
   end
   
   --OPERACION  CA_OPERACION_HIS HIJAS 
   update cob_cartera..ca_operacion_his set    
   oph_oficial = @w_oficial_des 
   where oph_operacion in (select operacion from #operaciones)
   
   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera..ca_operacion_his HIJAS'
      goto ERROR
   end
   
   --OPERACION PADRE COB_CARTERA_HIS
   update cob_cartera_his..ca_operacion_his set    
   oph_oficial = @w_oficial_des 
   where oph_operacion in(select operacion from #operaciones_padre)
   
   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera_his..ca_operacion_his  PADRE'
      goto ERROR
   end
   
   --OPERACION HIJAS COB_CARTERA_HIS
   update cob_cartera_his..ca_operacion_his set    
   oph_oficial = @w_oficial_des 
   where  oph_operacion in (select operacion from #operaciones)
   
   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera_his..ca_operacion_his HIJAS '
      goto ERROR
   end
   
   --TRAMITE GRUPAL
   update cob_credito..cr_tramite set
   tr_usuario     = @w_oficial_login,
   tr_usuario_apr = @w_oficial_login,
   tr_oficial     = @w_oficial_des
   where  tr_tramite  in(select tramite from #operaciones_padre)
   
   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_credito..cr_tramite GRUPAL'
      goto ERROR
   end
   
   --TRAMITE HIJAS 
   update cob_credito..cr_tramite set    
   tr_usuario    = @w_oficial_login,
   tr_usuario_apr= @w_oficial_login,
   tr_oficial    = @w_oficial_des
   where  tr_tramite   in (select tramite from #operaciones)
   
   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_credito..cr_tramite'
      goto ERROR
   end
   
 
   if @w_commit = 'S' begin 
      select @w_commit = 'N'
	  commit tran 
   end  
   
   
   goto SIGUIENTE 
   
   ERROR:
   print @w_msg 
   
   if @w_commit = 'S' begin 
      select @w_commit = 'N'
	  rollback tran 
   end  
   
   SIGUIENTE:    
end 


drop table #grupos
drop table #operaciones
drop table #operaciones_padre
go