/* Autorización para usar el Monitor con el rol 116 */

use cobis
go

declare @w_rol int

select @w_rol = inst_rol from cobis..platform_installer

-- Cobis Workflow Monitor
delete an_role_component where rc_co_id = 85000 and rc_rol = @w_rol
delete an_role_module where rm_mo_id = 85000 and rm_rol = @w_rol
delete an_role_page where rp_pa_id = 85000 and rp_rol = @w_rol
insert into an_role_component values(85000,@w_rol)
delete from an_role_module where rm_mo_id = 85000
insert into an_role_module values(85000,@w_rol)
delete from an_role_page where rp_pa_id = 85000
insert into an_role_page values(85000,@w_rol)   
go
   
