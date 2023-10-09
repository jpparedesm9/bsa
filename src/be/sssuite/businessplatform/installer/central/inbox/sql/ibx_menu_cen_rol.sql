use cobis
go

-- dump tran cobis with no_log
go


-- dump tran tempdb with no_log
go

declare 
   @w_rol int

select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS' 

delete an_role_component 
where rc_co_id in (73001, 73002, 73003)
  and rc_rol = @w_rol

delete an_role_module 
where rm_mo_id in (73001, 73002, 73003)
  and rm_rol = @w_rol
  
delete an_role_page 
where rp_pa_id in (73004, 73001, 73002, 73003)
  and rp_rol = @w_rol

insert into an_role_page values(73004,@w_rol) 

--Inbox.Web
insert into an_role_component values(73001,@w_rol)
insert into an_role_module values(73001,@w_rol)
insert into an_role_page values(73001,@w_rol)   

--Inbox.Supervisor
insert into an_role_component values(73002,@w_rol)
insert into an_role_module values(73002,@w_rol)
insert into an_role_page values(73002,@w_rol)

--Inbox.Supervisor
insert into an_role_component values(73003,@w_rol)
insert into an_role_module values(73003,@w_rol)
insert into an_role_page values(73003,@w_rol)

go

   
