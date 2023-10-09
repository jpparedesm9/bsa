/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S120038 Interface STD - Clientes
--Fecha                      : 06/07/2017
--Descripción del Problema   : Agregar tabla interface buro
--Descripción de la Solución : Agregar tabla interface buro
--Autor                      : Nelson Trujillo
--Instalador                 : cl_table.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/

USE cob_credito
GO


PRINT '<<<<< DROPPING TABLE cob_credito..cr_interface_buro >>>>>'

IF EXISTS (SELECT 1 FROM sysobjects o, sysusers u WHERE o.uid=u.uid AND o.name = 'cr_interface_buro' AND u.name = 'dbo' AND o.type = 'U')
    DROP TABLE cr_interface_buro 
GO

PRINT '<<<<< CREATING TABLE "cob_credito..cr_interface_buro" >>>>>'
GO

CREATE TABLE cr_interface_buro  (
    ib_cliente	int      	NOT NULL,
    ib_fecha    DATETIME    NULL,
    ib_xml      VARBINARY(8000)   NULL,
    ib_riesgo   int         NULL,
 PRIMARY KEY CLUSTERED ( ib_cliente )
)
GO



