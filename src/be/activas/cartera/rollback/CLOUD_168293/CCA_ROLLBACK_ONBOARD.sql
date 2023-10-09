
use cob_cartera 
go 


declare @w_usuario_onboard int


select @w_usuario_onboard = fu_funcionario 
from cobis..cl_funcionario 
where fu_login = 'onboarding'


select  'EJECUTANDO ROLLBACK'

if object_id ('dbo.ca_onboard_seguro_ext') is not null
	select 'ANTES' , * from ca_onboard_seguro_ext
	
select 'ANTES' , * from ca_param_seguro_externo
select 'ANTES' , * from cobis..cl_catalogo , cobis..cl_tabla  where cl_tabla.tabla in ('ca_producto_seguro')  and cl_tabla.codigo = cl_catalogo.tabla 
select 'ANTES' , * from cobis..cl_tabla where cl_tabla.tabla in  ('ca_producto_seguro')
select 'ANTES' , * from cobis..cc_oficial where oc_funcionario =  @w_usuario_onboard
select 'ANTES' , * from cobis..cl_funcionario where fu_funcionario =  @w_usuario_onboard




--BORRADO TABLA DE SEGUROS 
if exists (select 1 from sysindexes  where name = 'cseg1')
   drop index cseg1 on ca_onboard_seguro_ext


if object_id ('dbo.ca_onboard_seguro_ext') is not null
	drop table dbo.ca_onboard_seguro_ext




--ELIMINACION DE CAMPO PRODUCTO PARA LOS SEGUROS

if exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'se_producto'
              and  c1.table_name = 'ca_param_seguro_externo')
begin 
    alter table ca_param_seguro_externo
   drop column se_producto 
end





--ELIMINACION DE CATALOGO PARA PRODUCTOS DE SEGURO --PARA PARAMETRIA 

delete cobis..cl_catalogo from cobis..cl_tabla  where cl_tabla.tabla in ('ca_producto_seguro')  and cl_tabla.codigo = cl_catalogo.tabla                                      
delete cobis..cl_tabla where cl_tabla.tabla in  ('ca_producto_seguro')                                    
--SE ELIMINAN NUEVOS VALORES PARA LA PARAMETRIS DEL SEGURO POR PRODUCTO 
delete ca_param_seguro_externo where se_id in ( 4,5,6)



if  @w_usuario_onboard is not null begin 
   delete  cobis..cc_oficial where oc_funcionario =  @w_usuario_onboard
   delete from cobis..cl_funcionario where fu_funcionario =  @w_usuario_onboard
end 


--VERIFICACION

select 'VERIFICACION'




if object_id ('dbo.ca_onboard_seguro_ext') is not null
	select 'DESPUES' , * from ca_onboard_seguro_ext
	
	

select 'DESPUES' , * from ca_param_seguro_externo
select 'DESPUES' , * from cobis..cl_catalogo , cobis..cl_tabla  where cl_tabla.tabla in ('ca_producto_seguro')  and cl_tabla.codigo = cl_catalogo.tabla 
select 'DESPUES' , * from cobis..cl_tabla where cl_tabla.tabla in  ('ca_producto_seguro')
select 'DESPUES' , * from cobis..cc_oficial where oc_funcionario =  @w_usuario_onboard
select 'DESPUES' , * from cobis..cl_funcionario where fu_funcionario =  @w_usuario_onboard





