
use cob_cartera 
go 



declare
@w_fecha_proceso datetime,  
@w_cliente       int ,
@w_incremento    money,
@w_cupo          money, 
@w_monto_fin     money,
@w_operacionca   int ,
@w_msg           descripcion , 
@w_commit        char(1)  

---colocar el codigo del cliente , e incremento

select  
@w_incremento = 300,
@w_commit     = 'N'

select  @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso



select
cliente = en_ente
into #clientes  
from cobis..cl_ente  where en_ente in 
(
3585     , 
8682     ,
9402     ,
9421     ,
9425     ,
10307    ,
10318    ,
13068    )


/*
COBIS   NOMBRE
3585     EDITH AGUILAR SÁNCHEZ
8682     GABRIELA AGUILAR SARABIA
9402     YOSELYN PILAR BAILÓN GONZÁLEZ
9421     HUGO GERARDO OCHOA BAILÓN
9425     ISIDRA REYES GARCÍA
10307    RUFINA MARTÍNEZ JUAN
10318    NORMA IVONNE PAREDES VALVERDE
13068    REBECA RAMÍREZ ZEPEDA
*/

select 'RESULTADOS ANTES DE LOS INCREMENTOS'


select 'ca_operacion', op_cliente,op_monto_aprobado from ca_operacion where op_cliente in ( select cliente from #clientes) and  op_toperacion = 'REVOLVENTE'

select 'ca_operacion_his', oph_cliente,oph_monto_aprobado from ca_operacion_his where oph_cliente in ( select cliente from #clientes) and  oph_toperacion = 'REVOLVENTE'
 
select 'bdd..ca_operacion_his', oph_cliente,oph_monto_aprobado from cob_cartera_his..ca_operacion_his where oph_cliente in ( select cliente from #clientes)and  oph_toperacion = 'REVOLVENTE'

select 'ca_incremento_cupo', * from ca_incremento_cupo 
where ic_operacion in ( select op_operacion from ca_operacion where op_cliente in ( select cliente from #clientes) and op_toperacion = 'REVOLVENTE')




 
select @w_cliente = 0 , @w_incremento = 300


while (1=1) begin  


  
   select top 1 
   @w_cliente = cliente 
   from #clientes
   where cliente >@w_cliente
   order by cliente
   if @@rowcount = 0 break 
   

   select 
   @w_operacionca   = op_operacion  ,
   @w_cupo          = op_monto_aprobado
   from ca_operacion 
   where op_cliente =  @w_cliente 
   and op_toperacion = 'REVOLVENTE'
   and op_operacion >0
   
   

   
   if @@trancount = 0 begin 
    select @w_commit = 'S'
    begin tran 
   end


   --Update a la tabla ca_operacion, el campo op_monto_aprobado, --Realizar update de op_monto_aprobado , valor actual del monto más el incremento
   update ca_operacion
   set op_monto_aprobado = op_monto_aprobado + isnull(@w_incremento,0)
   where op_operacion = @w_operacionca
   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera..ca_operacion'
      goto ERROR
   end

    
   update ca_operacion_his
   set oph_monto_aprobado = oph_monto_aprobado + isnull(@w_incremento,0)
   where oph_operacion = @w_operacionca
   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera..ca_operacion_his'
      goto ERROR
   end

  
   update cob_cartera_his..ca_operacion_his
   set oph_monto_aprobado = oph_monto_aprobado + isnull(@w_incremento,0)
   where oph_operacion = @w_operacionca
   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera_his..ca_operacion_his'
      goto ERROR
   end

   
   
   select 
   @w_monto_fin            = op_monto_aprobado
   from ca_operacion
   where  op_operacion    =  @w_operacionca
   
   insert into ca_incremento_cupo(
   ic_operacion,   ic_fecha_proceso,      ic_monto_aprobado_ini,
   ic_incremento,  ic_monto_aprobado_fin)
   values (
   @w_operacionca, @w_fecha_proceso, @w_cupo, 
   @w_incremento,  @w_monto_fin)
   
   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL ACTUALIZAR cob_cartera..ca_incremento_cupo'
      goto ERROR
   end

   
   if @w_commit = 'S' begin 
      select @w_commit = 'N'
      commit tran 
   end 
   
   
   goto SIGUIENTE 

   ERROR:
   print isnull(@w_msg ,'no hay mensaje')

   if @w_commit = 'S' begin 
   select @w_commit = 'N'
   rollback tran 
   end 
   
   
   
  SIGUIENTE: 
end 


select 'RESULTADOS DESPUES DE  LOS INCREMENTOS'



select 'ca_operacion', op_cliente,op_monto_aprobado from ca_operacion where op_cliente in ( select cliente from #clientes) and  op_toperacion = 'REVOLVENTE'

select 'ca_operacion_his', oph_cliente,oph_monto_aprobado from ca_operacion_his where oph_cliente in ( select cliente from #clientes) and  oph_toperacion = 'REVOLVENTE'
 
select 'bdd..ca_operacion_his', oph_cliente,oph_monto_aprobado from cob_cartera_his..ca_operacion_his where oph_cliente in ( select cliente from #clientes)and  oph_toperacion = 'REVOLVENTE'

select 'ca_incremento_cupo', * from ca_incremento_cupo 
where ic_operacion in ( select op_operacion from ca_operacion where op_cliente in ( select cliente from #clientes) and op_toperacion = 'REVOLVENTE')




drop table #clientes 
go