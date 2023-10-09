

use cobis
go

IF OBJECT_ID ('cl_sucursal') IS NOT NULL
    DROP VIEW cl_sucursal
GO

CREATE VIEW cl_sucursal (
             filial,
             sucursal,
             nombre,
             direccion,
             ciudad,
             telefono,
             subtipo,
             sucursal1
) AS SELECT 
        of_filial,
        of_oficina, 
        of_nombre,
        of_direccion,
        of_ciudad,
        of_telefono,
        of_subtipo,
        of_sucursal
FROM       cl_oficina  
WHERE      of_subtipo IN ('R', 'S')  /* ORM 25/06/2003 */

GO