use cobis
go
declare @w_resource_id int,
		@w_rol			int
		
select @w_resource_id=re_id from cew_resource where re_pattern='/cobis/web/views/BSSNS/.*'

delete from cew_resource_rol where rro_id_resource = @w_resource_id
delete from cew_resource where re_id = @w_resource_id

select @w_resource_id = max(re_id)+1 from cew_resource

insert into cew_resource values(@w_resource_id,'/cobis/web/views/BSSNS/.*')

insert into cew_resource_rol (rro_id_resource,rro_id_rol)
 select @w_resource_id, ro_rol
 from ad_rol 
 where ro_descripcion in('ADMINISTRADOR',
						'FUNCIONARIO OFICINA',
						'CONSULTA',
						'ASESOR',
						'GERENTE REGIONAL',
						'MESA DE OPERACIONES',
						'NORMATIVO',
						'GERENTE OFICINA',
						'AUDITORIA')
go
--SE INSERTA PANTALLA EN an_component
declare @w_component_id int,
		@w_module_id int
		
delete from an_component where co_name='Investigar Negocio' and co_class='VC_GENERALBSI_401479_TASK.html'

select @w_component_id = max(co_id) +1 from an_component
select @w_module_id = mo_id from an_module where mo_name='IBX.InboxOficial'

insert into an_component values(@w_component_id,@w_module_id,'Investigar Negocio','VC_GENERALBSI_401479_TASK.html','views/BSSNS/CSTMR/T_BSSNSKNPPLXIB_479/1.0.0/','I',NULL,'WF')
go
