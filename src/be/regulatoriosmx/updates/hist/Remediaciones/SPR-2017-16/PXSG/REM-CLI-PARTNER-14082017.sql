
/**********************************************************************************************************************/
--Incidencia                 : NO
--Fecha                      : 10/08/2017
--Descripción del Problema   : Incrementar campo  cl_ente_aux 
--Descripción de la Solución : anadir campo a la tabla cl_ente_aux
--Autor                      : Patricio Samueza
--Instalador                 : 
--Ruta Instalador            : 
/**********************************************************************************************************************/

use cobis
go

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ea_partner' AND TABLE_NAME = 'cl_ente_aux')
BEGIN
    ALTER TABLE cobis..cl_ente_aux ADD ea_partner CHAR(1) NULL
END
else
begin
 ALTER TABLE cobis..cl_ente_aux ALTER COLUMN ea_partner CHAR(1) NULL
END

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ea_lista_negra' AND TABLE_NAME = 'cl_ente_aux')
BEGIN
    ALTER TABLE cobis..cl_ente_aux ADD ea_lista_negra CHAR(1) NULL
END
else
begin
 ALTER TABLE cobis..cl_ente_aux ALTER COLUMN ea_lista_negra CHAR(1)  NULL
END
go

/**********************************************************************************************************************/
--No Bug                     : SI
--Título de la Historia      : 
--Fecha                      : 23/07/2017
--Descripción del Problema   : No existe control de errores
--Descripción de la Solución : Agregar el error
--Autor                      : Patricio Samueza
--Instalador                 : 8_sta_error.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- Agregar error
--------------------------------------------------------------------------------------------
use cobis
GO

delete cobis..cl_errores
where numero in (149055)

INSERT INTO dbo.cl_errores (numero, severidad, mensaje)
VALUES (149055, 0, 'ES TITULAR DE LA CUENTA GRUPAL')
GO




