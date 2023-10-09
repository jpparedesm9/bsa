use cob_conta
go


if exists (select 1 from sysobjects 
           where name = 'cb_listado_reportes_reg' and type = 'U')
	drop table cb_listado_reportes_reg
go

create table cb_listado_reportes_reg
(
	lr_reporte		varchar(6)	not null,
	lr_descripcion	varchar(40) not null,
	lr_estado		varchar(1)	not null,
	lr_depende_pro	char(1)		not null default 'N'
)
go

create unique clustered index cb_listado_reportes_reg_PK
	on cb_listado_reportes_reg (lr_reporte)
go


if exists (select 1 from sysobjects 
           where name = 'cb_solicitud_reportes_reg' and type = 'U')
	drop table cb_solicitud_reportes_reg
go

create table cb_solicitud_reportes_reg
(
	sr_fecha	datetime	not null,
	sr_reporte	varchar(6)	not null,
	sr_mes		tinyint		not null,
	sr_anio		smallint	not null,
	sr_status	char(1)		not null default 'I'
)
go

create clustered index cb_solicitud_reportes_reg_PK
	on cb_solicitud_reportes_reg (sr_fecha, sr_reporte)
go


if exists (select 1 from sys.views 
           where object_id = OBJECT_ID(N'ts_solicitud_reportes_reg'))
	drop view ts_solicitud_reportes_reg
go

create view ts_solicitud_reportes_reg
(
 secuencial, tipo_transaccion, clase, fecha, usuario, 
 terminal, oficina, fecha_actual, fecha_sol, reporte, 
 mes, anio, estado
)
as
select	
 ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha, ts_usuario,
 ts_terminal, ts_oficina, ts_fecha_fin, ts_fecha_ini, ts_tipo_doc,
 ts_producto, ts_area, ts_estado
from cb_tran_servicio
where ts_tipo_transaccion in (6640, 6641, 6642, 6643)
go

