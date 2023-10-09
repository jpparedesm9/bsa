
use cob_cartera 
go 



declare
@w_fecha_proceso datetime,  
@w_cliente       int ,
@w_incremento    money,
@w_cupo          money, 
@w_monto_fin     money,
@w_operacionca   int   

---colocar el codigo del cliente , e incremento

select  @w_cliente =  1705  , @w_incremento = 300

 
select  @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
 

select 
@w_operacionca   = op_operacion  ,
@w_cupo          = op_monto_aprobado
from ca_operacion 
where op_cliente =  @w_cliente 
and op_toperacion = 'REVOLVENTE'
and op_operacion >0


--Update a la tabla ca_operacion, el campo op_monto_aprobado, --Realizar update de op_monto_aprobado , valor actual del monto más el incremento
update ca_operacion
set op_monto_aprobado = op_monto_aprobado + isnull(@w_incremento,0)
where op_operacion = @w_operacionca


update ca_operacion_his
set oph_monto_aprobado = oph_monto_aprobado + isnull(@w_incremento,0)
where oph_operacion = @w_operacionca


update cob_cartera_his..ca_operacion_his
set oph_monto_aprobado = oph_monto_aprobado + isnull(@w_incremento,0)
where oph_operacion = @w_operacionca



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



---------------------------------------------------------------------

--colocar el codigo del cliente , e incremento

select  @w_cliente = 13012 , @w_incremento = 300

 
select  @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
 

select 
@w_operacionca   = op_operacion  ,
@w_cupo          = op_monto_aprobado
from ca_operacion 
where op_cliente =  @w_cliente 
and op_toperacion = 'REVOLVENTE'
and op_operacion >0



--Update a la tabla ca_operacion, el campo op_monto_aprobado, --Realizar update de op_monto_aprobado , valor actual del monto más el incremento
update ca_operacion
set op_monto_aprobado = op_monto_aprobado + isnull(@w_incremento,0)
where op_operacion = @w_operacionca


update ca_operacion_his
set oph_monto_aprobado = oph_monto_aprobado + isnull(@w_incremento,0)
where oph_operacion = @w_operacionca


update cob_cartera_his..ca_operacion_his
set oph_monto_aprobado = oph_monto_aprobado + isnull(@w_incremento,0)
where oph_operacion = @w_operacionca



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



-----------------------------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------

--colocar el codigo del cliente , e incremento

select  @w_cliente = 13018 , @w_incremento = 300

 
select  @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
 



select 
@w_operacionca   = op_operacion  ,
@w_cupo          = op_monto_aprobado
from ca_operacion 
where op_cliente =  @w_cliente 
and op_toperacion = 'REVOLVENTE'
and op_operacion >0



--Update a la tabla ca_operacion, el campo op_monto_aprobado, --Realizar update de op_monto_aprobado , valor actual del monto más el incremento
update ca_operacion
set op_monto_aprobado = op_monto_aprobado + isnull(@w_incremento,0)
where op_operacion = @w_operacionca


update ca_operacion_his
set oph_monto_aprobado = oph_monto_aprobado + isnull(@w_incremento,0)
where oph_operacion = @w_operacionca


update cob_cartera_his..ca_operacion_his
set oph_monto_aprobado = oph_monto_aprobado + isnull(@w_incremento,0)
where oph_operacion = @w_operacionca



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

