/********************************************************************************/
/*   Archivo:                param.sql                                          */
/*   Base de datos:          cobis                                              */
/*   Producto:               Cobis                                              */
/*   Disenado por:           Paul Clavijo                                       */
/********************************************************************************/
/*                               IMPORTANTE                                     */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.     */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier         */
/* alteracion o agregado hecho por alguno de usuarios sin el debido             */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp          */
/* o su representante.                                                          */
/********************************************************************************/
/*                               PROPOSITO                                      */
/* Parametros para internacionalizacion                                         */
/********************************************************************************/
/*                             MODIFICACIONES                                   */
/********************************************************************************/
/* FECHA        VERSION  AUTOR  RAZON                                           */
/********************************************************************************/
/* 27-Abr-2012  4.0.0.0  PCL    Emision Inicial                                 */
/********************************************************************************/

use cobis
GO

SET NOCOUNT ON
GO


DECLARE
    @w_nemonico CHAR(6),
    @w_producto CHAR(3)

SELECT
    @w_nemonico = 'CULTDF',
    @w_producto = 'ADM'

PRINT '==================================================='
PRINT ' PARAMETRO ' + @w_nemonico
PRINT '==================================================='

BEGIN TRANSACTION

delete cobis..cl_parametro where pa_nemonico in ('TEMFU') and pa_producto in ('ADM')

INSERT INTO cobis..cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto) 
VALUES ('TIPO EMAIL FUNC','TEMFU', 'C','0','ADM')
go

IF EXISTS (SELECT 1 FROM cl_parametro
             WHERE pa_nemonico = @w_nemonico
               and pa_producto = @w_producto)
    DELETE FROM cl_parametro
    WHERE pa_nemonico  = @w_nemonico
      and pa_producto = @w_producto

INSERT INTO cl_parametro
    (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
VALUES
    ('CULTURA POR DEFECTO', @w_nemonico, 'C', 'ES-EC', @w_producto)

COMMIT TRANSACTION

SELECT * FROM cl_parametro
  WHERE pa_nemonico = @w_nemonico
   and  pa_producto = @w_producto

GO


SET NOCOUNT OFF
GO
