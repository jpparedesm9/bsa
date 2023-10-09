
use cobis
go

declare @w_rol			int,
        @w_funcionario 	int
		

delete ad_rol where ro_descripcion = 'OPERADOR SOFOME'
  
--CREACION ROL	
if not exists (select 1 from ad_rol where ro_descripcion = 'OPERADOR SOFOM')
begin			
	select @w_rol = isnull(max(ro_rol),0) + 1
      from ad_rol
  
	insert into ad_rol	(ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
	values	(@w_rol, 1, 'OPERADOR SOFOM', getdate(), 1, 'V', getdate(),900)
	
	update cl_seqnos
       set siguiente = @w_rol
     where tabla = 'ad_rol'
end



--CREACION FUNCIONARIO
delete cl_funcionario where fu_nombre in ('usrsofom')

select @w_funcionario = max(fu_funcionario) + 1
  from cl_funcionario
  
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_oficina, fu_departamento, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave, fu_offset, fu_cedruc)
values	(@w_funcionario, 'usrsofom', 'M', 'N', 1, 1, 1, 3, 0, null, getdate(), 'usrsofom', null, null,'V', '44444444', 0x610AEF0C6DE58AF2B5ACFAAF8A08EC2C, '6666666666')

update cl_seqnos
   set siguiente = @w_funcionario
 where tabla = 'cl_funcionario'
 
--CREACIÓN USUARIO
delete ad_usuario where us_login in ('usrsofom')

insert into ad_usuario	(us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_estado, us_fecha_ult_mod, us_fecha_ult_pwd)
values	(1, 1, 1, 'usrsofom', getdate(), 1, 'V', getdate(), getdate())

--ASOCIACIÓN USUARIO - ROL
delete ad_usuario_rol where ur_login in ('usrsofom')

select @w_rol 		  = ro_rol
  from ad_rol
 where ro_descripcion = 'OPERADOR SOFOM'
 
insert into ad_usuario_rol	(ur_login, ur_rol, ur_fecha_aut,ur_autorizante, ur_estado, ur_fecha_ult_mod,ur_tipo_horario)
values	('usrsofom', @w_rol, getdate(),1, 'V', getdate(),1)


--AUTORIZACIONES MANEJO DE FONDOS

delete cew_menu_role where mro_id_role = @w_rol
delete cew_resource_rol where rro_id_rol = @w_rol
delete ad_tr_autorizada where ta_rol = @w_rol
delete ad_servicio_autorizado where ts_rol = @w_rol


delete from cew_menu_role where mro_id_role = @w_rol 

insert into cew_menu_role
select me_id,  @w_rol
from cew_menu
where me_name in ('MNU_OPER', 'MNU_ASSETS', 'MNU_FUND') 

if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/ASSTS/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/ASSTS/.*'
end


if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/customer/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/customer/.*'
end



if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/resources/ASSTS/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/resources/ASSTS/.*'
end


if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/resources/ASSTS/CMMNS/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/resources/ASSTS/CMMNS/.*'
end

if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/ASSTS/CMMNS/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/ASSTS/CMMNS/.*'
end

if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/ASSTS/assets/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/ASSTS/assets/.*'
end


if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/customer/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/customer/.*'
end



if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Loan.FundManagement.CreateFundResource' and ts_rol = @w_rol)
begin
INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('Loan.FundManagement.CreateFundResource', @w_rol, 7, 'R', 0, getdate(), 'V', getdate())
end

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Loan.FundManagement.SearchFundResource' and ts_rol = @w_rol)
begin
INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('Loan.FundManagement.SearchFundResource', @w_rol, 7, 'R', 0, getdate(), 'V', getdate())
end

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Loan.FundManagement.UpdateFundResource' and ts_rol = @w_rol)
begin
INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('Loan.FundManagement.UpdateFundResource', @w_rol, 7, 'R', 0, getdate(), 'V', getdate())
end

go