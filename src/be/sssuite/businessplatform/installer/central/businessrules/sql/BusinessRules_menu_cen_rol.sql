use cobis
go

declare @w_rol  int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
	select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
	insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
	values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

delete an_role_component 
where rc_co_id in (86001, 86002)
  and rc_rol = @w_rol

delete an_role_module 
where rm_mo_id in (86001, 86002)
  and rm_rol = @w_rol
  
delete an_role_page 
where rp_pa_id in (86000, 86001, 86002)
  and rp_rol = @w_rol

insert into an_role_page values(86000,@w_rol)
 
-- Cobis Workflow Monitor
insert into an_role_component values(86001,@w_rol)
insert into an_role_module values(86001,@w_rol)
insert into an_role_page values(86001,@w_rol)   

insert into an_role_component values(86002,@w_rol)
insert into an_role_module values(86002,@w_rol)
insert into an_role_page values(86002,@w_rol)   

go
