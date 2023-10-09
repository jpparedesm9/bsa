/******************************************************************************/
/* Archivo:            ad_obtiene_cultura_defecto.sp                          */
/* Stored procedure:   sp_ad_obtiene_cultura_defecto                          */
/* Producto:           VIRTUAL BANKING                                        */
/******************************************************************************/
/*                                 IMPORTANTE                                 */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                                PROPOSITO                                   */
/* Procedimiento para distribuir pseudo-catalogos internacionalizados         */
/******************************************************************************/
/*                                MODIFICACIONES                              */
/******************************************************************************/
/* FECHA        VERSION  AUTOR  RAZON                                         */
/******************************************************************************/
/* 12-Mar-2012  4.0.0.0  PCL    Internacionalizacion (CIB4.1.0.5)             */
/* 19-Abr-2016           BBO    Migracion SYB-SQL FAL                         */
/******************************************************************************/

USE cobis
GO

IF OBJECT_ID('sp_ad_obtiene_cultura_defecto') IS NOT NULL
    DROP PROCEDURE sp_ad_obtiene_cultura_defecto
GO

CREATE PROCEDURE sp_ad_obtiene_cultura_defecto
(
    @t_show_version     BIT         = 0,
    @o_culture          VARCHAR(10) = NULL OUT
)
AS

DECLARE
    @w_sp_name      VARCHAR(32),
    @w_num_error    INT

SELECT
    @w_sp_name = 'sp_ad_obtiene_cultura_defecto'

---- VERSIONAMIENTO DEL PROGRAMA ----
IF @t_show_version = 1
BEGIN
   PRINT 'Stored procedure ' + @w_sp_name + ' Version 4.0.0.0'
   RETURN 0
END
-------------------------------------

SELECT @o_culture = UPPER(pa_char)
FROM cobis..cl_parametro
WHERE pa_producto = 'ADM'
AND pa_nemonico = 'CULTDF'

IF @@ROWCOUNT = 0
BEGIN
    SELECT @w_num_error = 1850358  -- El sistema necesita una cultura por defecto
    EXEC cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = @w_num_error
    RETURN @w_num_error
END

RETURN 0

GO
