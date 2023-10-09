use cobis
go

declare @w_rol			int,
        @w_funcionario 	int

--Crear roles 
 
select @w_rol = isnull(max(ro_rol),0) + 1
  from ad_rol
  
if not exists (select 1 from ad_rol where ro_descripcion = 'ADMINISTRADOR')
begin
insert into ad_rol	(ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
		values	(@w_rol, 1, 'ADMINISTRADOR', getdate(), 1, 'V', getdate(),900)
end

if not exists (select 1 from ad_rol where ro_descripcion = 'OPERADOR DE BATCH COBIS')
begin	
select @w_rol = @w_rol + 1
insert into ad_rol	(ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
		values	(@w_rol, 1, 'OPERADOR DE BATCH COBIS', getdate(), 1, 'V', getdate(),900)
end

if not exists (select 1 from ad_rol where ro_descripcion = 'FUNCIONARIO OFICINA')
begin	
select @w_rol = @w_rol + 1
insert into ad_rol	(ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
		values	(@w_rol, 1, 'FUNCIONARIO OFICINA', getdate(), 1, 'V', getdate(),900)
end


if not exists (select 1 from ad_rol where ro_descripcion = 'CONSULTA')
begin	
select @w_rol = @w_rol + 1
insert into ad_rol	(ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
		values	(@w_rol, 1, 'CONSULTA', getdate(), 1, 'V', getdate(),900)
end

if not exists (select 1 from ad_rol where ro_descripcion = 'ASESOR')
begin			
select @w_rol = @w_rol + 1
insert into ad_rol	(ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
		values	(@w_rol, 1, 'ASESOR', getdate(), 1, 'V', getdate(),900)
end

if not exists (select 1 from ad_rol where ro_descripcion = 'OPERADOR SOFOME')
begin			
select @w_rol = @w_rol + 1
insert into ad_rol	(ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
		values	(@w_rol, 1, 'OPERADOR SOFOME', getdate(), 1, 'V', getdate(),900)
end

    
if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'CALL CENTER')
begin 
select @w_rol =  max(ro_rol)+1 
insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
        values (@w_rol, 1, 'CALL CENTER', getdate(), 1, 'V', getdate(), 9000)
end

select @w_rol = @w_rol + 1

update cl_seqnos
   set siguiente = @w_rol
 where tabla = 'ad_rol'

--Crear funcionarios
delete cl_funcionario where fu_nombre in ('usradmin', 'usroficina', 'usrconsulta', 'usrbatch', 'usrasesor', 'usrsofom')

select @w_funcionario = max(fu_funcionario) + 1
  from cl_funcionario
  
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_oficina, fu_departamento, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave, fu_offset, fu_cedruc)
values	(@w_funcionario, 'usradmin', 'M', 'N', 1, 1, 1, 3, 0, null, getdate(), 'usradmin', null, null,'V', '11111111', 0x65C3D47899A7F406DE19E3F1E671C73F, '1111111111')

select @w_funcionario = @w_funcionario + 1
  
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_oficina, fu_departamento, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave, fu_offset, fu_cedruc)
values	(@w_funcionario, 'usroficina', 'M', 'N', 1, 1, 1, 3, 0, null, getdate(), 'usroficina', null, null,'V', '11111111', 0x834CBE04EB1714D18E953A1184916EE0, '2222222222')

select @w_funcionario = @w_funcionario + 1
  
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_oficina, fu_departamento, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave, fu_offset, fu_cedruc)
values	(@w_funcionario, 'usrconsulta', 'M', 'N', 1, 1, 1, 3, 0, null, getdate(), 'usrconsulta', null, null,'V', '11111111', 0xB21F8FEA1CA37E66812870F7B9BE3053, '33333333333')

select @w_funcionario = @w_funcionario + 1
  
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_oficina, fu_departamento, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave, fu_offset, fu_cedruc)
values	(@w_funcionario, 'usrbatch', 'M', 'N', 1, 1, 1, 3, 0, null, getdate(), 'usrbatch', null, null,'V', '11111111', 0x431574CF3D79CFD840884AF3E4DF8F48, '4444444444')

select @w_funcionario = @w_funcionario + 1
  
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_oficina, fu_departamento, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave, fu_offset, fu_cedruc)
values	(@w_funcionario, 'usrasesor', 'M', 'N', 1, 1, 1, 3, 0, null, getdate(), 'usrasesor', null, null,'V', '11111111', 0x4EAD90A477A108C49DF09B67C58E448C, '55555555555')


select @w_funcionario = @w_funcionario + 1
  
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_oficina, fu_departamento, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave, fu_offset, fu_cedruc)
values	(@w_funcionario, 'usrsofom', 'M', 'N', 1, 1, 1, 3, 0, null, getdate(), 'usrsofom', null, null,'V', '11111111', 0x4EAD90A477A108C49DF09B67C58E448C, '55555555555')


select @w_funcionario = @w_funcionario + 1

update cl_seqnos
   set siguiente = @w_funcionario
 where tabla = 'cl_funcionario'
 
--Crear usuarios
delete ad_usuario where us_login in ('usradmin', 'usroficina', 'usrconsulta', 'usrbatch', 'usrasesor', 'usrsofom')


insert into ad_usuario	(us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_estado, us_fecha_ult_mod, us_fecha_ult_pwd)
values	(1, 1, 1, 'usradmin', getdate(), 1, 'V', getdate(), getdate())

insert into ad_usuario	(us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_estado, us_fecha_ult_mod, us_fecha_ult_pwd)
values	(1, 1, 1, 'usroficina', getdate(), 1, 'V', getdate(), getdate())

insert into ad_usuario	(us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_estado, us_fecha_ult_mod, us_fecha_ult_pwd)
values	(1, 1, 1, 'usrconsulta', getdate(), 1, 'V', getdate(), getdate())

insert into ad_usuario	(us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_estado, us_fecha_ult_mod, us_fecha_ult_pwd)
values	(1, 1, 1, 'usrbatch', getdate(), 1, 'V', getdate(), getdate())

insert into ad_usuario	(us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_estado, us_fecha_ult_mod, us_fecha_ult_pwd)
values	(1, 1, 1, 'usrasesor', getdate(), 1, 'V', getdate(), getdate())

insert into ad_usuario	(us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_estado, us_fecha_ult_mod, us_fecha_ult_pwd)
values	(1, 1, 1, 'usrsofom', getdate(), 1, 'V', getdate(), getdate())

--Asignar roles a usuarios
delete ad_usuario_rol where ur_login in ('usradmin', 'usroficina', 'usrconsulta', 'usrbatch', 'usrasesor', 'usrsofom')

select @w_rol 		  = ro_rol
  from ad_rol
 where ro_descripcion = 'ADMINISTRADOR'

insert into ad_usuario_rol	(ur_login, ur_rol, ur_fecha_aut,ur_autorizante, ur_estado, ur_fecha_ult_mod,ur_tipo_horario)
values	('usradmin', @w_rol, getdate(),1, 'V', getdate(),1)


select @w_rol 		  = ro_rol
  from ad_rol
 where ro_descripcion = 'FUNCIONARIO OFICINA'

insert into ad_usuario_rol	(ur_login, ur_rol, ur_fecha_aut,ur_autorizante, ur_estado, ur_fecha_ult_mod,ur_tipo_horario)
values	('usroficina', @w_rol, getdate(),1, 'V', getdate(),1)


select @w_rol 		  = ro_rol
  from ad_rol
 where ro_descripcion = 'CONSULTA'

insert into ad_usuario_rol	(ur_login, ur_rol, ur_fecha_aut,ur_autorizante, ur_estado, ur_fecha_ult_mod,ur_tipo_horario)
values	('usrconsulta', @w_rol, getdate(),1, 'V', getdate(),1)


select @w_rol 		  = ro_rol
  from ad_rol
 where ro_descripcion = 'ASESOR'
 
insert into ad_usuario_rol	(ur_login, ur_rol, ur_fecha_aut,ur_autorizante, ur_estado, ur_fecha_ult_mod,ur_tipo_horario)
values	('usrasesor', @w_rol, getdate(),1, 'V', getdate(),1)


select @w_rol 		  = ro_rol
  from ad_rol
 where ro_descripcion = 'OPERADOR DE BATCH COBIS'
 
insert into ad_usuario_rol	(ur_login, ur_rol, ur_fecha_aut,ur_autorizante, ur_estado, ur_fecha_ult_mod,ur_tipo_horario)
values	('usrbatch', @w_rol, getdate(),1, 'V', getdate(),1)


select @w_rol 		  = ro_rol
  from ad_rol
 where ro_descripcion = 'OPERADOR SOFOME'
 
insert into ad_usuario_rol	(ur_login, ur_rol, ur_fecha_aut,ur_autorizante, ur_estado, ur_fecha_ult_mod,ur_tipo_horario)
values	('usrsofom', @w_rol, getdate(),1, 'V', getdate(),1)

go

----------------------------------------------------------------------------------------------------------
-- CREACION DE ROLES 
----------------------------------------------------------------------------------------------------------
Declare 
@w_ro_rol INT,
@w_ro_descripcion VARCHAR(64)

--- CREACION DE ROL DE EJECUCION DE SERVICIOS ------------------------------------------------------------

select @w_ro_descripcion = 'PERFIL MOVIL'

DELETE FROM cobis..ad_rol WHERE ro_descripcion = @w_ro_descripcion

-- Se calcula el secuencial
EXEC cobis..sp_cseqnos   @i_tabla = 'ad_rol',  @o_siguiente = @w_ro_rol out

INSERT INTO cobis..ad_rol
(
	ro_rol,       ro_filial,         ro_descripcion,   ro_fecha_crea,  ro_creador,
	ro_estado,    ro_fecha_ult_mod,  ro_time_out,      ro_admin_seg,   ro_departamento,
	ro_oficina,   ro_canal
)
VALUES
(
	@w_ro_rol,    1,                 @w_ro_descripcion, GETDATE(),     1,
	'V',          GETDATE(),         900,               NULL,          NULL, 
	NULL,         'APK'
)

-- verificacion que exista el registro
select * from cobis..ad_rol where ro_descripcion = @w_ro_descripcion

--- CREACION DE PERFILES ---------------------------------------------------------------------------------

SELECT  @w_ro_descripcion  = 'ASESOR EXTERNO'


DELETE FROM cobis..ad_rol WHERE ro_descripcion = @w_ro_descripcion

-- Se calcula el secuencial
EXEC cobis..sp_cseqnos   @i_tabla = 'ad_rol',  @o_siguiente = @w_ro_rol out

-- Se inserta en la tabla el nuevo rol
INSERT INTO cobis..ad_rol
(
	ro_rol,       ro_filial,         ro_descripcion,   ro_fecha_crea,  ro_creador,
	ro_estado,    ro_fecha_ult_mod,  ro_time_out,      ro_admin_seg,   ro_departamento,
	ro_oficina,   ro_canal
)
VALUES
(
	@w_ro_rol,    1,                 @w_ro_descripcion, GETDATE(),     1,
	'V',          GETDATE(),         900,               NULL,          NULL, 
	NULL,         'APK'
)
