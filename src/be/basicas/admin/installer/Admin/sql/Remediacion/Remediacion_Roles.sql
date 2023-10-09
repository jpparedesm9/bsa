use cobis
go
declare @w_rol int

select @w_rol = isnull(max(ro_rol),0) + 1
  from ad_rol  
  
if not exists (select 1 from ad_rol where ro_descripcion = 'ADMINISTRADOR')
insert into ad_rol	(ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
		values	(@w_rol, 1, 'ADMINISTRADOR', getdate(), 1, 'V', getdate(),900)

if not exists (select 1 from ad_rol where ro_descripcion = 'OPERADOR DE BATCH COBIS')
begin		
select @w_rol = @w_rol + 1
insert into ad_rol	(ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
		values	(@w_rol, 1, 'OPERADOR DE BATCH COBIS', getdate(), 1, 'V', getdate(),900)
end
	
if not exists (select 1 from ad_rol where ro_descripcion = 'MENU POR PROCESOSS')
begin
select @w_rol = @w_rol + 1
insert into ad_rol	(ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
		values	(@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(),900)
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
go