/******************************************************************************/
/* Archivo:            ad_establece_cultura.sp                          	  */
/* Stored procedure:   sp_ad_establece_cultura                          	  */
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
/* Procedimiento para definir la cultura de manera centralizada         	  */
/******************************************************************************/
/*                                MODIFICACIONES                              */
/******************************************************************************/
/* FECHA        VERSION  AUTOR  RAZON                                         */
/******************************************************************************/
/* 03-Oct-2012  4.3.0.0  PCL    Interaccion con CEN              			  */
/******************************************************************************/

use cobis
GO

IF OBJECT_ID('sp_ad_establece_cultura') IS NOT NULL
    DROP PROCEDURE sp_ad_establece_cultura
GO

CREATE PROCEDURE sp_ad_establece_cultura
(
    @t_show_version     BIT         = 0,
    @o_culture          VARCHAR(10) = NULL OUT
)
AS

DECLARE
    @w_sp_name      VARCHAR(32)

SELECT
    @w_sp_name = 'sp_ad_establece_cultura'

---- VERSIONAMIENTO DEL PROGRAMA ----
IF @t_show_version = 1
BEGIN
   print 'Stored Procedure=' + @w_sp_name + ' Version=4.3.0.0'
   RETURN 0
END
-------------------------------------

IF @o_culture = 'NEUTRAL'
    EXEC sp_ad_obtiene_cultura_defecto
        @o_culture = @o_culture OUT
ELSE
BEGIN
    SELECT @o_culture = UPPER(@o_culture)

    -- Interaccion CEN
    DECLARE @w_pos_guion INT
    SELECT @w_pos_guion = CHARINDEX('_', @o_culture)
    IF @w_pos_guion > 0
        SELECT @o_culture = STUFF(@o_culture, @w_pos_guion , 1, '-')

    -- Si llega Cultura no existente
    IF NOT EXISTS ( SELECT 1
                    FROM cl_tabla TAB INNER JOIN cl_catalogo CAT
                        ON TAB.codigo = CAT.tabla
                    WHERE TAB.tabla = 'ad_cultura'
                    AND RTRIM(CAT.codigo) = @o_culture
                  )
        EXEC sp_ad_obtiene_cultura_defecto
            @o_culture = @o_culture OUT
END

RETURN 0

GO
