use cobis
go

delete from cl_parametro where pa_nemonico='VBIO' and pa_producto='CLI'

insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('BANDERA PARA HABILITAR VALIDACION BIOMETRICA EN FLUJO','VBIO','C','N','CLI')
go

--SE INSERTA PANTALLA EN an_component
--SE INSERTA PANTALLA EN an_component
declare @w_component_id int,
		@w_module_id int
		
delete from an_component where co_name='VALIDACION BIOMETRICO' and co_class='VC_BIOVALIDSA_412339_TASK.html'

select @w_component_id = max(co_id) +1 from an_component
select @w_module_id = mo_id from an_module where mo_name='IBX.InboxOficial'

insert into an_component values(@w_component_id,@w_module_id,'VALIDACION BIOMETRICO','VC_BIOVALIDSA_412339_TASK.html','views/BMTRC/TRNSC/T_BMTRCXBFSYZSS_339/1.0.0/','I',NULL,'WF')
go

declare @w_id int

select @w_id = max(re_id )+1 from cew_resource

delete from cew_resource_rol where rro_id_resource = (select re_id from cew_resource where re_pattern = '/cobis/web/views/BMTRC/.*')
delete from cew_resource where re_pattern = '/cobis/web/views/BMTRC/.*'

insert into cew_resource values (@w_id,'/cobis/web/views/BMTRC/.*')

insert into cew_resource_rol (rro_id_resource,rro_id_rol)
 select @w_id, ro_rol
 from ad_rol 
 where ro_descripcion in('ADMINISTRADOR',
						'FUNCIONARIO OFICINA',
						'CONSULTA',
						'ASESOR',
						'GERENTE REGIONAL',
						'MESA DE OPERACIONES',
						'NORMATIVO',
						'GERENTE OFICINA',
						'AUDITORIA',
						'OPERADOR SOFOME',
						'PERFIL DE OPERACIONES')
go

use cob_workflow
go

declare
@w_rs_codigo_resultado int,
@o_siguiente           int


if not exists(select 1 from wf_resultado where rs_nombre_resultado = 'DEVOLVER INICIO')
begin
   exec cobis..sp_cseqnos
   @i_tabla     = 'wf_resultado',
   @o_siguiente = @w_rs_codigo_resultado out
	   
   select @o_siguiente = @w_rs_codigo_resultado
   insert into cob_workflow..wf_resultado values (@o_siguiente,'DEVOLVER INICIO','N','S')
end
go
--SE CREA EL CATALOGO SIN PARAMETRIA YA QUE NO SE HA DEFINIDO
use cobis
go
declare @w_id int 

delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='cl_ofi_biocheck')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='cl_ofi_biocheck')
delete from cl_tabla where tabla ='cl_ofi_biocheck'

select @w_id= max(codigo) +1 from cl_tabla 

insert into cl_tabla values(@w_id,'cl_ofi_biocheck','OFICINAS PARA VALIDAR BIOCHECK')
insert into cl_catalogo_pro values('ADM',@w_id)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_id, '0', 'OFICINA 0', 'V', NULL, NULL, NULL)

go