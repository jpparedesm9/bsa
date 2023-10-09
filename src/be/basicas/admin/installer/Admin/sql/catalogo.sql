/********************************************************************************/
/*   Archivo:                catalogo.sql                                       */
/*   Base de datos:          cobis                                              */
/*   Producto:               Admin                                              */
/********************************************************************************/
/*                                 IMPORTANTE                                   */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.     */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier         */
/* alteracion o agregado hecho por alguno de usuarios sin el debido             */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp          */
/* o su representante.                                                          */
/********************************************************************************/
/*                           PROPOSITO                                          */
/* Creacion de catalogos de Internet Banking para Internacionalizacion          */
/********************************************************************************/
/*                           MODIFICACIONES                                     */
/********************************************************************************/
/* FECHA         VERSION    AUTOR   RAZON                                       */
/********************************************************************************/
/* 08/Ago/2012   1.0.0.0    PCL     Emision inicial                             */
/* 28/Nov/2012   1.0.0.1    MSA     Correccion de instaladores IB				*/
/* 12/ABR/2016   1.0.0.2    BBO     Migracion SYBASE-SQLServer FAL              */
/********************************************************************************/

use cobis
GO

SET NOCOUNT ON
GO

PRINT '============================================================'
PRINT '==               Creacion de catalogos                    =='
PRINT '============================================================'

DECLARE
    @w_tabla_codigo INT,
    @w_tabla CHAR(30),
    @w_tabla_descripcion VARCHAR(64),
    @w_return INT
	
SELECT
    @w_tabla = 'ad_cultura',
    @w_tabla_descripcion = 'CULTURAS DE COBIS'
	
PRINT 'Catalogo: ' + @w_tabla

BEGIN TRANSACTION

SELECT @w_tabla_codigo = codigo
FROM cl_tabla
WHERE tabla = @w_tabla

IF @w_tabla_codigo IS NOT NULL
BEGIN
	print '@w_tabla_codigo IS NOT NULL'

    DELETE cl_catalogo
    WHERE tabla = @w_tabla_codigo

    DELETE cl_tabla
    WHERE tabla = @w_tabla
END	

--Creacion cl_tabla --
SELECT @w_tabla_codigo = NULL

EXEC @w_return  = sp_cseqnos
    @i_tabla        = 'cl_tabla',
    @o_siguiente    = @w_tabla_codigo OUT

	
INSERT INTO cl_tabla
    (codigo, tabla, descripcion)
VALUES
    (@w_tabla_codigo, @w_tabla, @w_tabla_descripcion)

--Creacion en cl_catalogo--
INSERT INTO cl_catalogo
    (tabla, codigo, valor, estado)
VALUES
    (@w_tabla_codigo, 'EN-US', 'INGLES-ESTADOS UNIDOS', 'V')

INSERT INTO cl_catalogo
    (tabla, codigo, valor, estado)
VALUES
    (@w_tabla_codigo, 'ES-EC', 'ESPANOL-ECUADOR', 'V')

INSERT INTO cl_catalogo
    (tabla, codigo, valor, estado)
VALUES
    (@w_tabla_codigo, 'ES-BO', 'ESPANOL-BOLIVIA', 'V')

SELECT *
FROM cl_catalogo
WHERE tabla = @w_tabla_codigo

COMMIT TRANSACTION
GO

SET NOCOUNT OFF
GO
