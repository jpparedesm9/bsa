/**************************************************************/
--- REPORTE DATOS MODIFICADOS req.123670
/**************************************************************/
use cob_conta_super
go

print 'ELIMINACION TABLA: sb_reporte_mod_datos'
if object_id ('dbo.sb_reporte_mod_datos') is not null
	drop table dbo.sb_reporte_mod_datos
go

print 'ELIMINACION INDEX: idx_cliente_mod_dat'
if exists (select name from sysindexes where name='idx_cliente_mod_dat')
    drop index sb_reporte_mod_datos.idx_cliente_mod_dat
go
print 'ELIMINACION INDEX: idx_fecha_mod_dat'
if exists (select name from sysindexes where name='idx_fecha_mod_dat')
    drop index sb_reporte_mod_datos.idx_fecha_mod_dat
go
print 'ELIMINACION INDEX: idx_usuario_mod_dat'
if exists (select name from sysindexes where name='idx_usuario_mod_dat')
    drop index sb_reporte_mod_datos.idx_usuario_mod_dat
go

/**************************************************************/
--- REPORTE DATOS MODIFICADOS LINEA req.123670
/**************************************************************/ 
print 'ELIMINACION TABLA: sb_reporte_mod_datos_linea'
if object_id ('dbo.sb_reporte_mod_datos_linea') is not null
	drop table dbo.sb_reporte_mod_datos_linea
go

go
