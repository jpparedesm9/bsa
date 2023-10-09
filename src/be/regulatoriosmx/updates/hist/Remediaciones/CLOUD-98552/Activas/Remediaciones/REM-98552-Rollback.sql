use cobis
go

--Elimina catalogo de accion de dispersiones rechazadas
delete cl_catalogo_pro from cl_tabla
where tabla in ('ca_accion_disperciones')
and codigo = cp_tabla

delete cl_catalogo  from cl_tabla
where cl_tabla.tabla in ('ca_accion_disperciones')
and cl_tabla.codigo = cl_catalogo.tabla

delete cl_tabla
where cl_tabla.tabla in ('ca_accion_disperciones')

--

delete cl_catalogo_pro from cl_tabla
where tabla in ('ca_tipo_disperciones')
and codigo = cp_tabla

delete cl_catalogo  from cl_tabla
where cl_tabla.tabla in ('ca_tipo_disperciones')
and cl_tabla.codigo = cl_catalogo.tabla

delete cl_tabla
where cl_tabla.tabla in ('ca_tipo_disperciones')
 
go

--Elimina opcion del Menu
DECLARE @w_id_menu_padre_n1 int, 
        @w_id_menu_padre_n2 int,
        @w_menu_id int,
        @w_producto int,
        @w_rol int,
        @w_menu_order int,
		@w_option_menu varchar(100)

select @w_option_menu = 'MNU_REGULARIZE_REJECTED_DISPERSIONS'
print 'Inicia rollback para cew_menu_role'
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_menu_id = me_id from cew_menu where me_name = @w_option_menu
  
if exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
begin
    print 'Elimina de la cew_menu_role'
    delete cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol
end
else
begin
    print 'No existe el menu asignado al rol:' + convert(varchar, @w_rol)
end

print 'Inicia rollback para cew_menu'
--Nivel - Operaciones
select @w_id_menu_padre_n1 = me_id from cobis..cew_menu
where  me_name = 'MNU_OPER'

print 'Padre nivel 1' + convert(varchar,@w_id_menu_padre_n1)
--Nivel - Prospectos
select @w_id_menu_padre_n2 = me_id from cobis..cew_menu
where  me_id_parent =  @w_id_menu_padre_n1 
and    me_name = 'MNU_ASSETS'

print 'Padre nivel 2' + convert(varchar,@w_id_menu_padre_n2)

-- Datos para guardar
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'

if exists (	select 1 from cew_menu where me_id_parent = @w_id_menu_padre_n2 and me_name = @w_option_menu
            and me_url = 'views/ASSTS/TRNSC/T_ASSTSOSPSJXWE_883/1.0.0/VC_REGULARIOE_732883_TASK.html'
            and me_id_cobis_product = @w_producto )
begin
    print 'Elimina de la cew_menu'
    delete cew_menu where me_id_parent = @w_id_menu_padre_n2 and me_name = @w_option_menu
        and me_url = 'views/ASSTS/TRNSC/T_ASSTSOSPSJXWE_883/1.0.0/VC_REGULARIOE_732883_TASK.html'
        and me_id_cobis_product = @w_producto	
end
else
begin
    print 'No existe registro en cew_menu'
end

--Eliminar tabla, alter e index
use cob_cartera
go

DROP INDEX ca_santander_orden_deposito_fallido.ca_santander_orden_deposito_fallido_1
DROP INDEX ca_santander_orden_deposito_fallido.ca_santander_orden_deposito_fallido_2
DROP INDEX ca_santander_orden_deposito_fallido.ca_santander_orden_deposito_fallido_3
DROP INDEX ca_santander_orden_deposito_fallido.ca_santander_orden_deposito_fallido_4

DROP TABLE ca_santander_orden_deposito_fallido

---
ALTER TABLE cob_cartera..ca_santander_orden_deposito DROP COLUMN sod_monto
ALTER TABLE cob_cartera..ca_santander_orden_deposito DROP COLUMN sod_cliente
ALTER TABLE cob_cartera..ca_santander_orden_deposito DROP COLUMN sod_cuenta

go

--Eliminar trn de servicios
declare @w_rol tinyint,  
		@trn int

select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion like 'MENU POR PROCESOS'

select @trn  = 77502

if exists(select 1 from cobis..cl_ttransaccion where tn_trn_code= @trn)
	delete cobis..cl_ttransaccion where tn_trn_code= @trn
	
if exists(select 1 from cobis..ad_procedure where pd_procedure = @trn)
	delete cobis..ad_procedure where pd_procedure = @trn
	
if exists(select 1 from cobis..ad_pro_transaccion where pt_transaccion = @trn)
	delete cobis..ad_pro_transaccion where pt_transaccion = @trn

if exists(select 1 from cobis..ad_tr_autorizada where ta_transaccion = @trn)
	delete cobis..ad_tr_autorizada where ta_transaccion = @trn
	
---
go

declare @w_rol tinyint,  
		@trn int

select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion like 'MENU POR PROCESOS'

select @trn  = 77503

if exists(select 1 from cobis..cl_ttransaccion where tn_trn_code= @trn)
	delete cobis..cl_ttransaccion where tn_trn_code= @trn
	
if exists(select 1 from cobis..ad_procedure where pd_procedure = @trn)
	delete cobis..ad_procedure where pd_procedure = @trn
	
if exists(select 1 from cobis..ad_pro_transaccion where pt_transaccion = @trn)
	delete cobis..ad_pro_transaccion where pt_transaccion = @trn

if exists(select 1 from cobis..ad_tr_autorizada where ta_transaccion = @trn)
	delete cobis..ad_tr_autorizada where ta_transaccion = @trn


