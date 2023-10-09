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


use cob_custodia
go

--cu_custodia
if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'cu_custodia' and
        a.id = b.id and
        a.name = 'ccu_cuenta_tipo')
begin
 alter table cu_custodia add ccu_cuenta_tipo tinyint NULL 
 select 'Se ejecuto correctamente.'
end
else
begin
 select 'Existe campo ccu_cuenta_tipo.'
end
go

if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'cu_custodia' and
        a.id = b.id and
        a.name = 'cu_cuenta_hold')
begin
 alter table cu_custodia add cu_cuenta_hold varchar(30) NULL 
 select 'Se ejecuto correctamente.'
end
else
begin
 select 'Existe campo cu_cuenta_hold.'
end
go

if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'cu_custodia' and
        a.id = b.id and
        a.name = 'cu_cuenta_tipo')
begin
 alter table cu_custodia add cu_cuenta_tipo tinyint NULL 
 select 'Se ejecuto correctamente.'
end
else
begin
 select 'Existe campo cu_cuenta_tipo.'
end
go

--cu_tipo_custodia
if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'cu_tipo_custodia' and
        a.id = b.id and
        a.name = 'tc_porcentaje')
begin
 alter table cu_tipo_custodia add tc_porcentaje float NULL 
 select 'Se ejecuto correctamente.'
end
else
begin
 select 'Existe campo tc_porcentaje.'
end
go

if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'cu_tipo_custodia' and
        a.id = b.id and
        a.name = 'tc_producto')
begin
 alter table cu_tipo_custodia add tc_producto tinyint NULL 
 select 'Se ejecuto correctamente.'
end
else
begin
 select 'Existe campo tc_producto.'
end
go

if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'cu_tipo_custodia' and
        a.id = b.id and
        a.name = 'tc_clase_garantia')
begin
 alter table cu_tipo_custodia add tc_clase_garantia catalogo NULL 
 select 'Se ejecuto correctamente.'
end
else
begin
 select 'Existe campo tc_clase_garantia.'
end
go


use cob_credito
go

--cr_tramite
if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'cr_tramite' and
        a.id = b.id and
        a.name = 'tr_id_inst_proceso')
begin
 alter table cr_tramite add tr_id_inst_proceso int NULL 
 select 'Se ejecuto correctamente.'
end
else
begin
 select 'Existe campo tr_id_inst_proceso.'
end
go

use cob_cartera
go

--ca_default_toperacion
if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'ca_default_toperacion' and
        a.id = b.id and
        a.name = 'dt_subtipo_cartera')
begin
 alter table ca_default_toperacion add dt_subtipo_cartera catalogo NULL 
 select 'Se ejecuto correctamente.'
end
else
begin
 select 'Existe campo dt_subtipo_cartera.'
end
go

if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'ca_default_toperacion' and
        a.id = b.id and
        a.name = 'dt_tipo_cartera')
begin
 alter table ca_default_toperacion add dt_tipo_cartera catalogo NULL 
 select 'Se ejecuto correctamente.'
end
else
begin
 select 'Existe campo dt_tipo_cartera.'
end
go

--ca_default_toperacion_ts
if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'ca_default_toperacion_ts' and
        a.id = b.id and
        a.name = 'dts_subtipo_cartera')
begin
 alter table ca_default_toperacion_ts add dts_subtipo_cartera catalogo NULL 
 select 'Se ejecuto correctamente.'
end
else
begin
 select 'Existe campo dts_subtipo_cartera.'
end
go

if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'ca_default_toperacion_ts' and
        a.id = b.id and
        a.name = 'dts_tipo_cartera')
begin
 alter table ca_default_toperacion_ts add dts_tipo_cartera catalogo NULL 
 select 'Se ejecuto correctamente.'
end
else
begin
 select 'Existe campo dts_tipo_cartera.'
end
go

