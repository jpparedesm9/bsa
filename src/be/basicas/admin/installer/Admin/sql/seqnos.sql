/********************************************************************************/
/*   Archivo:                seqnos.sql                                         */
/*   Base de datos:          cobis                                              */
/*   Producto:               Cobis                                              */
/********************************************************************************/
/*                                 IMPORTANTE                                   */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.     */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier         */
/* alteracion o agregado hecho por alguno de usuarios sin el debido             */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp          */
/* o su representante.                                                          */
/********************************************************************************/
/*                                  PROPOSITO                                   */
/* Tablas de secuenciales para internacionalizacion                             */
/********************************************************************************/
/*                                MODIFICACIONES                                */
/********************************************************************************/
/* FECHA         VERSION    AUTOR   RAZON                                       */
/********************************************************************************/
/* 27-Abr-2012   4.0.0.0    PCL     Internacionalizacion                        */
/********************************************************************************/

use cobis
GO

SET NOCOUNT ON
GO


PRINT '=====> ad_pseudo_catalogo'
IF NOT EXISTS   (   SELECT 1
                    FROM cl_seqnos
                    WHERE tabla = 'ad_pseudo_catalogo'
                )
INSERT INTO cl_seqnos
    ( bdatos, tabla, siguiente, pkey )
VALUES
    ( 'cobis', 'ad_pseudo_catalogo', 0, 'pc_id' )
GO

PRINT '=====> cl_tabla'
IF NOT EXISTS   (   SELECT 1
                    FROM cl_seqnos
                    WHERE tabla = 'cl_tabla'
                )
INSERT INTO cl_seqnos
    ( bdatos, tabla, siguiente, pkey )
VALUES
    ( 'cobis', 'cl_tabla', 0, 'codigo' )
GO



SET NOCOUNT OFF
GO
