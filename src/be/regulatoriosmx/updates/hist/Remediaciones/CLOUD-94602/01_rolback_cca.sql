PRINT ''
PRINT ''
PRINT '------------------------------------------------'
PRINT 'REMOVIENDO CAMPOS EN TABLAS DE DOMICILIACION'
PRINT '------------------------------------------------'
PRINT ''
PRINT ''
go

	
USE cobis
GO
declare 
	@w_nemonico2         VARCHAR(6)

SELECT 
	@w_nemonico2         = 'TESEG'


DELETE FROM cobis..cl_parametro WHERE pa_nemonico = @w_nemonico2
GO


---------------------------------------------------------------------------------
----------------------------ca_santander_orden_retiro------------------------------------
---------------------------------------------------------------------------------
USE cob_cartera
GO

IF EXISTS(select idx.name,*
          from sysobjects obj, sysindexes idx
          where obj.name  = 'ca_santander_orden_retiro'
          and   obj.id = idx.id
          and   idx.name = 'idx1')
BEGIN
	DROP INDEX ca_santander_orden_retiro.idx1
END

GO


IF EXISTS(select idx.name,*
          from sysobjects obj, sysindexes idx
          where obj.name  = 'ca_santander_orden_retiro'
          and   obj.id = idx.id
          and   idx.name = 'idx2')
BEGIN
	DROP INDEX ca_santander_orden_retiro.idx2
END

GO


if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ca_santander_orden_retiro'
          and   obj.id = col.id
          and   col.name = 'sor_consecutivo')
begin
	ALTER TABLE ca_santander_orden_retiro DROP COLUMN sor_consecutivo
end
GO



if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ca_santander_orden_retiro'
          and   obj.id = col.id
          and   col.name = 'sor_fecha_clave')
begin
	ALTER TABLE ca_santander_orden_retiro DROP COLUMN sor_fecha_clave
end
go



if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ca_santander_orden_retiro'
          and   obj.id = col.id
          and   col.name = 'sor_error')
begin
	ALTER TABLE ca_santander_orden_retiro DROP COLUMN sor_error
end
go


if  exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ca_santander_orden_retiro'
          and   obj.id = col.id
          and   col.name = 'sor_procesado')
begin
	ALTER TABLE ca_santander_orden_retiro DROP COLUMN sor_procesado
end
go


