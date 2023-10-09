/**********************************************************************************************************************/
--Incidencia                 : NO Nro historia CGS-S129665 
--Fecha                      : 24/08/2017
--Descripción del Problema   : Incrementar campo  cl_direccion 
--Descripción de la Solución : anadir campo a la tabla cl_direccion
--Autor                      : Patricio Samueza
--Instalador                 : cl_table.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql/cl_table.sql
/**********************************************************************************************************************/

use cobis
go

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'di_poblacion' AND TABLE_NAME = 'cl_direccion')
BEGIN
    ALTER TABLE cobis..cl_direccion ADD di_poblacion CHAR(30) NULL
END
else
begin
 ALTER TABLE cobis..cl_direccion ALTER COLUMN di_poblacion CHAR(30) NULL
END

GO
-------------


/**********************************************************************************************************************/
--Incidencia                 : NO historia Nro CGS-S129665 
--Fecha                      : 24/08/2017
--Descripción del Problema   : Incrementar campo  ea_fiel 
--Descripción de la Solución : anadir campo a la tabla cl_ente_aux
--Instalador                 : cl_table.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql/cl_table.sql 
/**********************************************************************************************************************/

use cobis
go

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ea_fiel' AND TABLE_NAME = 'cl_ente_aux')
BEGIN
    ALTER TABLE cobis..cl_ente_aux ADD ea_fiel VARCHAR(20) NULL  
END
else
BEGIN
 ALTER TABLE cobis..cl_ente_aux ALTER COLUMN ea_fiel VARCHAR(20) NULL
END
GO
use cobis
GO
UPDATE  cobis..cl_ente_aux SET ea_fiel='No Aplica' 
GO

