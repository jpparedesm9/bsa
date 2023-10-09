use cobis
go

if exists(select * from sysobjects where name = 'sp_val_rol')
	drop proc sp_val_rol
go

create proc sp_val_rol (
	@i_modo		tinyint,
	@i_login 	varchar(30),
	@i_rol		tinyint = null
	)
as

if @i_modo = 0
begin
	select ur_login, ur_rol
	  from ad_usuario_rol
	 where ur_login = @i_login
	return 1 
end

if @i_modo = 1
begin
	if exists(select *
		  from ad_usuario_rol
		  where  ur_login = @i_login
		    and  ur_rol = @i_rol)
		return 1
	else
		return -1
end

go


