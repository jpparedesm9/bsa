/**************************************************************/
--- REPORTE DATOS MODIFICADOS req.123670
/**************************************************************/
use cob_conta_super
go

print 'CREACION TABLA: sb_reporte_mod_datos'
if object_id ('dbo.sb_reporte_mod_datos') is not null
	drop table dbo.sb_reporte_mod_datos
go

create table dbo.sb_reporte_mod_datos
(
	[FECHA DE MODIFICACION]          datetime      not null,
	REGION                           varchar(64)   not null,
	SUCURSAL                         varchar(64)   not null,
	[ID CLIENTE]                     int           not null,
	[NOMBRE COMPLETO CLIENTE]        varchar(255)  not null,
	[NO. DE CREDITO]                 varchar(64)   not null,
	[USUARIO QUE MODIFICO]           varchar(14)   not null,
	[CAMPO QUE FUE MODIFICADO]       varchar(64)   not null,
	[DATO ANTERIOR]                  varchar(255)  not null,
	[DATO NUEVO]                     varchar(255)  not null,
	[CANAL DE MODIFICACION]          varchar(32)   not null,
	[ROL DE USUARIO QUE MODIFICO]    varchar(64)   not null
)
go

print 'CREACION INDEX: idx_cliente_mod_dat'
if exists (select name from sysindexes where name='idx_cliente_mod_dat')
    drop index sb_reporte_mod_datos.idx_cliente_mod_dat
go
    create NONCLUSTERED index idx_cliente_mod_dat on cob_conta_super..sb_reporte_mod_datos([ID CLIENTE])
go
print 'CREACION INDEX: idx_fecha_mod_dat'
if exists (select name from sysindexes where name='idx_fecha_mod_dat')
    drop index sb_reporte_mod_datos.idx_fecha_mod_dat
go
    create NONCLUSTERED index idx_fecha_mod_dat on cob_conta_super..sb_reporte_mod_datos([FECHA DE MODIFICACION])
go
print 'CREACION INDEX: idx_usuario_mod_dat'
if exists (select name from sysindexes where name='idx_usuario_mod_dat')
    drop index sb_reporte_mod_datos.idx_usuario_mod_dat
go
    create NONCLUSTERED index idx_usuario_mod_dat on cob_conta_super..sb_reporte_mod_datos([USUARIO QUE MODIFICO])
go


/**************************************************************/
--- REPORTE DATOS MODIFICADOS LINEA req.123670
/**************************************************************/ 
use cob_conta_super
go

print 'CREACION TABLA: sb_reporte_mod_datos_linea'
if object_id ('dbo.sb_reporte_mod_datos_linea') is not null
	drop table dbo.sb_reporte_mod_datos_linea
go

create table dbo.sb_reporte_mod_datos_linea
	(
	rm_cadena varchar (max) 
	)
go
