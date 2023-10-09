
use cob_cartera 
go 

declare
@w_oficial_ant   login,
@w_oficial_dest   login,
@w_commit        char(1),
@w_login_dest login,
@w_oficina_dest   int,
@w_msg           varchar(255),
@w_grupo         int ,
@w_banco_grupal  varchar(50),
@w_fila          int, 
@w_error         int,
@w_funcionario_dest   int,
@w_ciudad_dest    int 

create table #grupos ( grupo int , funcionario_dest int)
create table #operaciones_hija  (tramite int,  banco varchar(32) null, operacion int,  estado smallint null) 
create table #operaciones_padre (tramite int , banco varchar(50),      operacion int)

--GRUPO- NOMBRE                - PERTENECE A                                    ---- CAMBIA A 

--462  - NEGOCIO MUJER         - Yamidt Itzel Cedillo Usuario: yicedillo(189)   ---- Urbano Conchillos Ram�rez Usuario: uconchillos(156)
insert into #grupos values (462, 156) -- antes 189

--487  - LUNA Y SOL	           - Yamidt Itzel Cedillo Usuario: yicedillo(189)   ---- Urbano Conchillos Ram�rez Usuario: uconchillos(156)						
insert into #grupos values (487, 156) -- antes 189

--555  - COLIBRI NEZA          - Anyuli Michelle Guti�rrez Usuario: amgutierrez(130)	---- Jos� Manuel Est�vez Usuario: jmestevez(265)						
insert into #grupos values (555, 265) -- antes 130

--546  - LAS CAMPEONAS DE LA 23- Yamidt Itzel Cedillo Usuario: yicedillo(189)   ---- Urbano Conchillos Ram�rez Usuario: uconchillos(156)						
insert into #grupos values (546, 156) -- antes 189

--643  - SOLECITO              - Yamidt Itzel Cedillo Usuario: yicedillo(189)   ---- Urbano Conchillos Ram�rez Usuario: uconchillos(156)						
insert into #grupos values (643, 156) -- antes 189

--728  - PALACIO               - Anyuli Michelle Guti�rrez Usuario: amgutierrez(130) ---- Jos� Manuel Est�vez Usuario: jmestevez(265)						
insert into #grupos values (728, 265) -- antes 130

--798  - VIRGEN DEL SOCORRO    - Urbano Conchillos Ram�rez Usuario: uconchillos(156) ---- Yamidt Itzel Cedillo Usuario: yicedillo(189)					
insert into #grupos values (798, 189) -- antes 156

--849  - STICH	               - Urbano Conchillos Ram�rez Usuario: uconchillos(156) ---- Yamidt Itzel Cedillo Usuario: yicedillo(189)				
insert into #grupos values (849, 189) -- antes 156 

--891  - BLANCA NIEVES	       - Anyuli Michelle Guti�rrez Usuario: amgutierrez(130) ---- Jos� Manuel Est�vez Usuario: jmestevez(265)
insert into #grupos values (891, 265) -- antes 130 

--908  - LAS EXCLUSIVAS        - Anyuli Michelle Guti�rrez Usuario: amgutierrez(130) ---- Jos� Manuel Est�vez Usuario: jmestevez(265)
insert into #grupos values (908, 265) -- antes 130 

--957  - DIAMANTE NEZA         - Anyuli Michelle Guti�rrez Usuario: amgutierrez(130) ---- Jos� Manuel Est�vez Usuario: jmestevez(265)
insert into #grupos values (957, 265) -- antes 130 

--984  - LAS NENAS	           - Jos� Manuel Est�vez Usuario: jmestevez(265)         ---- M�nica Monserrat Landa Usuario: mmlanda(141)
insert into #grupos values (984, 141) -- antes 265 

--1092 - MUCHACHITAS	       - Jos� Manuel Est�vez Usuario: jmestevez(265)         ---- Anyuli Michelle Guti�rrez Usuario: amgutierrez(130)
insert into #grupos values (1092, 130) -- antes 265 

--1118 - LOS EMPRENDEDORES	   - Jos� Manuel Est�vez Usuario: jmestevez(265)         ---- Anyuli Michelle Guti�rrez Usuario: amgutierrez(130)
insert into #grupos values (1118, 130) -- antes 265

select 
@w_grupo       = 0

while(1=1) begin 

   select top 1  
   @w_grupo       = grupo,
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
   @w_oficina_dest   = fu_oficina
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
   where of_oficina     = @w_oficina_dest--@w_oficina_des 
   
   --VALIDAR QUE EL CARGO DEL OFICIAL SEA ASESOR    
   truncate table #operaciones_hija
   truncate table #operaciones_padre
       
   --BANCO GRUPAL REFERENCIA OPERACION PADRE VIGENTES Y EN VUELO
   insert into #operaciones_padre
   select DISTINCT tg_tramite,tg_referencia_grupal,0
   from   cob_credito..cr_tramite_grupal
   where tg_grupo = @w_grupo  
   
   --ACTUALIZAR a NUMEROS DE OPERACION PARA EVITAR TABLE SCAN EN LAS HIS  
   update #operaciones_padre set
   operacion = op_operacion  
   from ca_operacion 
   where op_banco =  banco

   --OPERACIONES HIJAS DEL GRUPO  --TRAMITES EN VUELO WORFLOW 
   insert into #operaciones_hija
   select 
   tramite   = 0,
   banco     = tg_prestamo,
   operacion = tg_operacion,
   estado    = ''
   from cob_credito..cr_tramite_grupal 
   where tg_grupo = @w_grupo
   and tg_monto > 0 
   and tg_participa_ciclo = 'S' 
   and tg_prestamo <> tg_referencia_grupal
   
   --ACTUALIZAR NUMEROS DE TRAMITES A LAS OP HIJAS 
   update #operaciones_hija set
   tramite = op_tramite ,
   estado  = op_estado
   from cob_cartera..ca_operacion
   where op_operacion = operacion
   
   if @@trancount = 0 begin 
      select @w_commit = 'S'
	  begin tran 
   end 

   --BORRAR CANCELADAS 
   delete #operaciones_hija  where estado = 3
   
   /**************************************************************************/
    --CLIENTE
   update cobis..cl_ente set
   en_oficial     = @w_oficial_dest,
   c_funcionario  = @w_login_dest,
   en_oficina     = @w_oficina_dest
   where  en_ente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo)
  
   select @w_fila = @@rowcount, @w_error = @@error   
   select ' CL_ENTE AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cobis..cl_ente'
      goto ERROR
   end
   
   --GRUPO
   update cobis..cl_grupo set    
   gr_oficial  = @w_oficial_dest,
   gr_sucursal = @w_oficina_dest--**Se aumenta
   where  gr_grupo   = @w_grupo
   
   select @w_fila = @@rowcount, @w_error = @@error
   select ' cobis..cl_grupo AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cobis..cl_grupo'
      goto ERROR
   end
   
   --CLIENTES -DEL GRUPO
   update cobis..cl_cliente_grupo  set
   cg_usuario = @w_login_dest
   where  cg_grupo   = @w_grupo

   select @w_fila = @@rowcount, @w_error = @@error
   select ' cobis..cl_cliente_grupo AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cobis..cl_cliente_grupo'
      goto ERROR
   end
 
   --OPERACION PADRE CA_OPERACION
   update cob_cartera..ca_operacion set    
   op_oficial  = @w_oficial_dest,
   op_ciudad   = @w_ciudad_dest, --**Se aumenta
   op_oficina  = @w_oficina_dest --**Se aumenta   
   where  op_operacion in (select operacion from #operaciones_padre)
  
   select @w_fila = @@rowcount, @w_error = @@error
   select ' cob_cartera..ca_operacion PADRE AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera..ca_operacion PADRE'
      goto ERROR
   end

   --OPERACIONES HIJAS CA_OPERACION 
   update cob_cartera..ca_operacion set    
   op_oficial = @w_oficial_dest,
   op_ciudad  = @w_ciudad_dest, --**Se aumenta
   op_oficina = @w_oficina_dest --**Se aumenta    
   where op_operacion in (select operacion from #operaciones_hija)
   
   select @w_fila = @@rowcount, @w_error = @@error
   select ' cob_cartera..ca_operacion HIJA AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera..ca_operacion HIJAS'
      goto ERROR
   end

   --update cob_cartera..ca_operacion_his no para el padre
   --OPERACION  CA_OPERACION_HIS HIJAS
   update cob_cartera..ca_operacion_his set    
   oph_oficial = @w_oficial_dest,
   oph_ciudad  = @w_ciudad_dest, 
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
   op_ciudad  = @w_ciudad_dest,
   op_oficina = @w_oficina_dest
   where  op_operacion in (select operacion from #operaciones_hija)

   select @w_fila = @@rowcount, @w_error = @@error
   select ' cob_cartera_his..ca_operacion HIJA AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera_his..ca_operacion_his HIJAS '
      goto ERROR
   end

   --OPERACION HIJAS COB_CARTERA_HIS
   update cob_cartera_his..ca_operacion_his set    
   oph_oficial = @w_oficial_dest,
   oph_ciudad  = @w_ciudad_dest, 
   oph_oficina = @w_oficina_dest   
   where  oph_operacion in (select operacion from #operaciones_hija)

   select @w_fila = @@rowcount, @w_error = @@error
   select ' cob_cartera_his..ca_operacion_his HIJA AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera_his..ca_operacion_his HIJAS '
      goto ERROR
   end
   
   --TRAMITE GRUPAL
   update cob_credito..cr_tramite set
   tr_oficina    = @w_oficina_dest,  -- 
   tr_oficial    = @w_oficial_dest--,
   --tr_usuario    = @w_login_dest,-- no actualizar queda como referencia histo
   --tr_usuario_apr= @w_login_dest -- no actualizar es de apertura
   where  tr_tramite  in(select tramite from #operaciones_padre)

   select @w_fila = @@rowcount, @w_error = @@error
   select ' cob_credito..cr_tramite PADRE AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_credito..cr_tramite GRUPAL'
      goto ERROR
   end
   
   --TRAMITE HIJAS 
   update cob_credito..cr_tramite set    
   tr_oficina    = @w_oficina_dest,
   tr_oficial    = @w_oficial_dest--,   
   --tr_usuario    = @w_login_dest,-- no actualizar queda como referencia histo
   --tr_usuario_apr= @w_login_dest -- no actualizar es de apertura
   where  tr_tramite   in (select tramite from #operaciones_hija)

   select @w_fila = @@rowcount, @w_error = @@error
   select ' cob_credito..cr_tramite HIJA AFECTADOS' = @w_fila , 'ERROR' = @w_error
   
   if @w_error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_credito..cr_tramite'
      goto ERROR
   end

   update cob_cartera..ca_transaccion set--***Se aumenta
   tr_ofi_oper = @w_oficina_dest
   --tr_ofi_usu y tr_usuario -- no se actualiza este campo porque es informaci�n referente a donde se realiza la transaccion   
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
