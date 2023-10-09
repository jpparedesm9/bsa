
use 
cobis
go

if exists (SELECT * FROM cl_parametro WHERE pa_nemonico = 'FDVP' AND pa_producto = 'CLI')
begin
    UPDATE cl_parametro 
    SET pa_int = 12
    WHERE pa_producto = 'FDVP'
    AND pa_nemonico = 'CLI'
end
else
begin
    INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('Fecha de vigencia de datos personale', 'FDVP', 'I', NULL, NULL, NULL, 12, NULL, NULL, NULL, 'CLI')
end
GO

if exists (SELECT * FROM cl_parametro WHERE pa_nemonico = 'FDVD' AND pa_producto = 'CLI')
begin
    UPDATE cl_parametro 
    SET pa_int = 6
    WHERE pa_producto = 'FDVD'
    AND pa_nemonico = 'CLI'
end
else
begin
  INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('Fecha de vigencia de direcciones', 'FDVD', 'I', NULL, NULL, NULL,6, NULL, NULL, NULL, 'CLI')
end
GO
-------
/***********************************************************************/
--No Bug:
--Título del Bug: crear campos en tabla de oficiales
--Fecha:2017-06-15
--Descripción del Problema:
--crear nuevo campo para ingreso del email del oficial
--Descripción de la Solución: crear campos
--Autor:LGU
/***********************************************************************/

use cobis
go

--oc_mail
if not exists(select 1
          from cobis..sysobjects obj, cobis..syscolumns col
          where obj.name = 'cc_oficial'
          and   obj.id = col.id
          and   col.name = 'oc_mail')
begin
alter table cobis..cc_oficial
   add oc_mail varchar(254) null
end
go