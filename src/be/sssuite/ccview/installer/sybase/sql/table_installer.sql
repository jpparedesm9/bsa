use cobis
go
if exists (select 1
            from  sysobjects
            where  id = object_id('platform_installer')
            and    type = 'U')
   drop table platform_installer
go
CREATE TABLE platform_installer  ( 
	inst_rol     	int NOT NULL,
	inst_ip_co      varchar(255) NOT NULL,
	inst_ip_ws      varchar(255) NOT NULL
)
go
declare @w_rol smallint
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
insert into platform_installer values(@w_rol, '[servername]', '[cts_servername]')
go
