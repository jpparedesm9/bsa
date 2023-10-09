/*************************************************/
---Fecha Creación del Script: 
--TBA        06/23/2016     Se modifica vista cl_sucursal para que considere las oficinas tipo S
/***************************************************/

use cobis
go

IF OBJECT_ID ('dbo.cl_sucursal') IS NOT NULL
    DROP VIEW dbo.cl_sucursal
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
