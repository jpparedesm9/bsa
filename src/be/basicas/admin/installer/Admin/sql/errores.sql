/********************************************************************************/
/*   Archivo:                errores.sql                                        */
/*   Base de datos:          cobis                                              */
/*   Producto:               Cobis                                              */
/*   Disenado por:           PCL                                                */
/********************************************************************************/
/*                                 IMPORTANTE                                   */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.     */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier         */
/* alteracion o agregado hecho por alguno de usuarios sin el debido             */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp          */
/* o su representante.                                                          */
/********************************************************************************/
/*                           PROPOSITO                                          */
/* Errores para internacionalizacion                                            */
/********************************************************************************/
/*                           MODIFICACIONES                                     */
/********************************************************************************/
/* FECHA         VERSION    AUTOR   RAZON                                       */
/********************************************************************************/
/* 27-Abr-2012   4.0.0.0    PCL     Internacionalizacion                        */
/********************************************************************************/

use cobis
GO

SET NOCOUNT ON
GO

DECLARE
    @w_numero_error     INT,
    @w_severidad_error  INT,
    @w_mensaje_error    VARCHAR(132)


PRINT '****************************************************************************************************************'

SELECT
    @w_numero_error = 1850358,
    @w_severidad_error = 1,
    @w_mensaje_error = 'El sistema necesita una cultura por defecto'

PRINT 'INSERTAR CODIGO ERROR ' + convert(varchar, @w_numero_error)

IF NOT EXISTS (SELECT 1 FROM cl_errores WHERE numero = @w_numero_error)
    INSERT cl_errores
        (numero, severidad, mensaje)
    VALUES
        (@w_numero_error, @w_severidad_error, @w_mensaje_error)
ELSE
BEGIN
    SELECT * FROM cl_errores WHERE numero = @w_numero_error

    PRINT 'ERROR YA EXISTE - SE PROCEDE A ACTUALIZARLO'

    UPDATE cl_errores
    SET mensaje = @w_mensaje_error
    WHERE numero = @w_numero_error
END

SELECT * FROM cl_errores WHERE numero = @w_numero_error

PRINT '****************************************************************************************************************'

SELECT
    @w_numero_error = 1850359,
    @w_severidad_error = 1,
    @w_mensaje_error = 'Recurso no especificado'

PRINT 'INSERTAR CODIGO ERROR ' + convert(varchar, @w_numero_error)

IF NOT EXISTS (SELECT 1 FROM cl_errores WHERE numero = @w_numero_error)
    INSERT cl_errores
        (numero, severidad, mensaje)
    VALUES
        (@w_numero_error, @w_severidad_error, @w_mensaje_error)
ELSE
BEGIN
    SELECT * FROM cl_errores WHERE numero = @w_numero_error

    PRINT 'ERROR YA EXISTE - SE PROCEDE A ACTUALIZARLO'

    UPDATE cl_errores
    SET mensaje = @w_mensaje_error
    WHERE numero = @w_numero_error
END

SELECT * FROM cl_errores WHERE numero = @w_numero_error


GO

SET NOCOUNT OFF
GO
