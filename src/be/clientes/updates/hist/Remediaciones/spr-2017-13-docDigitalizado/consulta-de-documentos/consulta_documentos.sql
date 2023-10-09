use cobis
go

--Insercion de servicios QueryDocuments
if not exists(select 1 from cobis..cts_serv_catalog where csc_service_id = 'Loan.QueryDocuments.QueryDocuments')
begin
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('Loan.QueryDocuments.QueryDocuments','cobiscorp.ecobis.assets.cloud.service.IQueryDocuments',
'queryDocuments','Consulta de documentos',21366,null,null,'N')

insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values ('Loan.QueryDocuments.QueryDocuments',3,2,'R',0,getdate(),'V',getdate())

end


--Insercion de servicios QueryMembers
if not exists(select 1 from cobis..cts_serv_catalog where csc_service_id = 'Loan.QueryDocuments.QueryMembers')
begin
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('Loan.QueryDocuments.QueryMembers','cobiscorp.ecobis.assets.cloud.service.IQueryDocuments',
'queryMembers','Consulta de clientes',21366,null,null,'N')

insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values ('Loan.QueryDocuments.QueryMembers',3,2,'R',0,getdate(),'V',getdate())

end



------------------------------------
--Insercion de pantalla en el menu--
------------------------------------
use cobis
go

DECLARE @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_producto int,
        @w_rol int,
        @w_menu_order int 

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
    select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'


SELECT @w_menu_parent_id = me_id FROM cew_menu WHERE me_name = 'MNU_INBOX_QUERY_MAIN'
SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if @w_menu_parent_id is not null
begin
    
    
	--MENU ADMINISTRACION DE DISPOSITIVOS MÓVILES
    if not exists (select 1 from cew_menu where me_name = 'MNU_QUERY_DOCUMENTS')
    begin
        SELECT @w_menu_id = isnull( max(me_id), 0 ) + 1 FROM cew_menu
        SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id
        INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option)
        VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_QUERY_DOCUMENTS', 1, 'views/ASSTS/QERYS/T_ASSTSNTIMXUPV_411/1.0.0/VC_DOCUMENTSS_852411_TASK.html', @w_menu_order, 
        @w_producto, 0)
    end    
    SELECT @w_menu_id = me_id from cew_menu where me_name = 'MNU_QUERY_DOCUMENTS'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end
	
	
end
else
begin
    print 'No existe el menu padre: MNU_ADMIN'
end

go

