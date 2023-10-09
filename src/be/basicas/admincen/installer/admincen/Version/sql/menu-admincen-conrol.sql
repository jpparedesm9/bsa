/*	             MODIFICACIONES		                                */
/*    FECHA          AUTOR          RAZON	                        */
/*    21-04-2016     BBO            Migracion Sybase-SQL FAL        */
/********************************************************************/
use cobis
go

-- alter table an_label disable trigger
-- alter table an_page  disable trigger
-- alter table an_module_group  disable trigger
-- alter table an_module  disable trigger
-- alter table an_component  disable trigger
-- alter table an_zone  disable trigger
-- alter table an_page_zone  disable trigger
-- alter table an_role_module  disable trigger
-- alter table an_navigation_zone disable trigger
-- alter table an_role_navigation_zone disable trigger
-- alter table an_role_component disable trigger
-- alter table an_role_page disable trigger
-- go 

--Variables de uso general
declare @w_mg_id     int,
        @w_mg_name   varchar(64),  
        @w_rol       int,
        @w_prod_name varchar(10),
        @w_ruta      varchar(255)
          
select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'

--ELIMINACION DE DATOS PREVIOS
if @w_rol is null
    print 'No se encontro id de Rol MENU POR PROCESOS'
else
begin
	delete an_role_page from an_role_page, an_page, an_label where rp_pa_id = pa_id and pa_la_id = la_id and la_prod_name in ('ADMIN') and rp_rol = @w_rol 
	delete an_role_module from an_role_module, an_module, an_label where rm_mo_id = mo_id and mo_la_id = la_id and la_prod_name in ('ADMIN') and rm_mo_id not in (1, 2) and rm_rol = @w_rol
	delete an_role_component from an_role_component,an_component where rc_co_id = co_id and co_prod_name in ('ADMIN') and rc_co_id not in (1, 2, 3) and rc_rol = @w_rol
	delete an_role_install where ri_prod_name in ('ADMIN') and ri_role = @w_rol
	
	print 'Insercion en tabla de roles instalados por producto'
	insert into an_role_install values ('ADMIN', @w_rol)
end


-- DEFINICION DE MODULOS PARA ADMIN CEN
print 'DEFINICION DE MODULOS PARA ADMIN CEN'

declare @w_mo_id_adm integer,
        @w_mo_id_aut integer,         
        @w_la_id_m1 integer,
        @w_la_id_m2 integer

--Modulo de Administracion y Autorización
select @w_mo_id_adm = isnull(max(mo_id),0) + 1 from an_module where mo_name = 'AdminModuleAdministration' and mo_filename = 'COBISCorp.eCOBIS.Admin.Security.AdminCen.dll'
select @w_mo_id_aut = isnull(max(mo_id),0) + 1 from an_module where mo_name = 'AdminModuleAdminAuthorization' and mo_filename = 'COBISCorp.eCOBIS.Admin.Security.AdminCen.dll'

--Registro de asociaciones con el Rol ADMINISTRADOR con Modulos
if @w_rol is null
    print 'No se encontro id de Rol MENU POR PROCESOS'
else
begin
    if not exists (select 1 from an_role_module where rm_mo_id = @w_mo_id_adm and rm_rol = @w_rol)
		insert into an_role_module (rm_mo_id, rm_rol) values (@w_mo_id_adm, @w_rol)
end

-- DEFINICION DE PAGINAS PARA ADMIN CEN
print 'DEFINICION DE PAGINAS PARA ADMIN CEN'

declare @w_pa_id integer,   
        @w_pa_id_padm integer,
        @w_pa_id_paut integer,

        @w_la_id integer, 
        @w_la_id_padm integer,
        @w_la_id_paut integer,

        @id_pz_id integer,
        @w_co_id integer, 
        @w_pa_id_root integer 

-----------------------------------------------

print 'Pagina Padre de Autorización'
select @w_pa_id_paut = isnull(max(pa_id),0) + 1 from an_page where pa_name = 'PagAdminAut'
if @w_rol is null
    print 'No se encontro id de Rol MENU POR PROCESOS'
else
begin 
    if not exists (select 1 from an_role_page where rp_pa_id = @w_pa_id_paut and rp_rol = @w_rol)
		insert into an_role_page values (@w_pa_id_paut, @w_rol)
end

-----------------------------------------------

print 'Pagina de Autorización de Paginas a Rol'
select @w_co_id = isnull(max(co_id),0) + 1 from an_component where co_name = 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View.ModuleRolPageView'
select @w_pa_id = isnull(max(pa_id),0) + 1 from an_page where pa_name = 'PagAdminAPR'

--Registro de asociaciones con el Rol ADMINISTRADOR con Component y Page'
if @w_rol is null
    print 'No se encontro id de Rol MENU POR PROCESOS'
else
begin
    if not exists (select 1 from an_role_component where rc_co_id = @w_co_id and rc_rol = @w_rol)
		insert into an_role_component (rc_co_id, rc_rol) values (@w_co_id, @w_rol)
		
	if not exists (select 1 from an_role_page where rp_pa_id = @w_pa_id and rp_rol = @w_rol)
		insert into an_role_page values (@w_pa_id, @w_rol)
end

-----------------------------------------------

go

-- alter table an_label enable trigger
-- alter table an_page  enable trigger
-- alter table an_module_group  enable trigger
-- alter table an_module  enable trigger
-- alter table an_component  enable trigger
-- alter table an_zone  enable trigger
-- alter table an_page_zone  enable trigger
-- alter table an_role_module  enable trigger
-- alter table an_navigation_zone enable trigger
-- alter table an_role_navigation_zone enable trigger
-- alter table an_role_component enable trigger
-- alter table an_role_page enable trigger
-- go

/*******************************************************************/
/*  ASIGNACION DE TRANSACCIONES DESDE EL ROL ADMINISTRADOR GENERAL */
/*  AL ROL MENU POR PROCESOS                                       */
/*******************************************************************/
print '***  ad_tr_autorizada .....(Asignacion de transacciones a MENU POR PROCESOS)'
go

declare @w_rol_destino int, @w_rol_origen int

select @w_rol_origen = ro_rol
from ad_rol
where ro_descripcion = 'ADMINISTRADOR' and
      ro_filial = 1

select @w_rol_destino = ro_rol
from ad_rol
where ro_descripcion = 'MENU POR PROCESOS' and
      ro_filial = 1

print 'Eliminacion de transacciones autorizadas de Admin a rol MENU POR PROCESOS'
delete ad_tr_autorizada
where ta_rol = @w_rol_destino
and ta_transaccion in (select ta_transaccion from ad_tr_autorizada where ta_rol = @w_rol_origen)

print 'Asignacion de transacciones autorizadas de Admin desde el rol Administador al rol MENU POR PROCESOS'
insert into ad_tr_autorizada 
  select ta_producto, ta_tipo, ta_moneda, ta_transaccion, @w_rol_destino, getdate(), 
         1, ta_estado, getdate()
  from ad_tr_autorizada
  where ta_rol = @w_rol_origen
  and ta_transaccion not in (
     select ta_transaccion from ad_tr_autorizada where ta_rol = @w_rol_destino
  )
go

-----------
print 'FIN'



go
