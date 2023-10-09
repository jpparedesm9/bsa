
use cobis
go

declare @w_rol            int,
        @w_maximo       int = 0,
		@w_resource       int = 0

 select @w_rol = ro_rol 
   from ad_rol 
  where ro_descripcion = 'MENU POR PROCESOS'

---Creación Recursos Contenedor 
if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/maps/.*')
 begin
    select @w_resource = max(re_id) + 1 from cew_resource
    insert into cew_resource (re_id, re_pattern)
    values (@w_resource, '/cobis/web/views/maps/.*')
 end

if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/LOANS/.*')
 begin
    select @w_resource = max(re_id) + 1 from cew_resource
    insert into cew_resource (re_id, re_pattern)
    values (@w_resource, '/cobis/web/views/LOANS/.*')
 end

  if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/BSSNS/.*')
 begin
    select @w_resource = max(re_id) + 1 from cew_resource
    insert into cew_resource (re_id, re_pattern)
    values (@w_resource, '/cobis/web/views/BSSNS/.*')
 end
 
if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/BMTRC/.*')
begin
    select @w_resource = max(re_id) + 1 from cew_resource
    insert into cew_resource (re_id, re_pattern)
    values (@w_resource, '/cobis/web/views/BMTRC/.*')
end
 --Autorización recursos al rol Menú por procesos
 if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/maps/.*'))
begin
    insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
    select @w_rol, re_id 
      from cew_resource 
     where re_pattern ='/cobis/web/views/maps/.*'
end

if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/LOANS/.*'))
begin
    insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
    select @w_rol, re_id 
      from cew_resource 
     where re_pattern ='/cobis/web/views/LOANS/.*'
end

if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/CSTMR/.*'))
begin
    insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
    select @w_rol, re_id 
      from cew_resource 
     where re_pattern ='/cobis/web/views/CSTMR/.*'
end

if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/BSSNS/.*'))
begin
    insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
    select @w_rol, re_id 
      from cew_resource 
     where re_pattern ='/cobis/web/views/BSSNS/.*'
end

if not exists (select 1 from cew_resource_rol where rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/BMTRC/.*'))
begin
    
	select @w_resource = re_id from cew_resource where re_pattern = '/cobis/web/views/BMTRC/.*'
	
    insert into cobis..cew_resource_rol (rro_id_resource,rro_id_rol)
    select @w_resource, ro_rol
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
end

go