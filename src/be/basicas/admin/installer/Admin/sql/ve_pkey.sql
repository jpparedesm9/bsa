use cobis
go

if exists (select * from sysindexes where name = 'ad_producto_respaldo_Key' )
   DROP INDEX ad_producto_respaldo.ad_producto_respaldo_Key

-- ad_producto_respaldo
PRINT 'ad_producto_respaldo_Key'
CREATE UNIQUE CLUSTERED INDEX ad_producto_respaldo_Key ON ad_producto_respaldo (
       pr_producto)
go


if exists (select * from sysindexes where name = 'ad_parametriza_respaldo_Key' )
DROP INDEX ad_parametrizacion_respaldo.ad_parametriza_respaldo_Key

-- ad_parametrizacion_respaldo
PRINT 'ad_parametriza_respaldo_Key'
CREATE UNIQUE CLUSTERED INDEX ad_parametriza_respaldo_Key ON ad_parametrizacion_respaldo (
       pr_producto,
       pr_tablas )
go


if exists (select * from sysindexes where name = 'ad_iniciales_catalogo_Key' )
DROP INDEX ad_iniciales_catalogo.ad_iniciales_catalogo_Key

-- ad_iniciales_catalogo
PRINT 'ad_iniciales_catalogo_Key'
CREATE  CLUSTERED INDEX ad_iniciales_catalogo_Key ON ad_iniciales_catalogo (
       ic_producto,
       ic_inicial )
go


