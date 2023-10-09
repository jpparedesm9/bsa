
 /*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : 
--Descripción del Problema   :Bug 151272:CGS-B151272 Tamaño de caracteres en correo electrónico
--Responsable                : Patricio Samueza
--Ruta TFS                   : Descripción abajo
--Nombre Archivo             : Descripción abajo
/*----------------------------------------------------------------------------------------------------------------*/

--------------------------------------------------------------------------------------------
-- aumento de tamano en la columna rp_direccion_e en la tabla cl_ref_personal
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql/cl_table.sql

USE cobis 
go

ALTER TABLE cobis..cl_ref_personal ALTER COLUMN rp_direccion_e VARCHAR(40);