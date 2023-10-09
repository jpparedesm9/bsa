/************************************************************************/
/*	Archivo: 		migrale.sp  			        */
/*	Stored procedure: 	sp_migra_log_errores			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Marcelo Poveda     	        	*/
/*	Fecha de escritura:    	Enero 25 de 2002			*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*									*/
/*				PROPOSITO				*/
/*	Inserta un registro por error en la validacion de migracion     */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR			RAZON			*/
/************************************************************************/

use cob_conta
go

IF EXISTS(SELECT * FROM sysobjects WHERE name = 'sp_migra_log_errores')
        DROP PROC sp_migra_log_errores
GO

CREATE PROC sp_migra_log_errores
        (
        @i_fuente               char(160),
        @i_fila                 int              = 0,
        @i_campo                char(30)        = '',
        @i_dato                 char(250)        = '',
        @i_referencia           int ,
        @i_operacion            int ,
        @i_producto             tinyint         = 2
        )                               
AS                                      
DECLARE                                 
        @w_sp_name              VARCHAR(30),
        @w_operacion_str        VARCHAR(30)
-- ------------------------------------------------------------------
-- - Cargo el nombre del programa
-- ------------------------------------------------------------------
SELECT  @w_sp_name       = 'sp_migra_log_errores'

        INSERT INTO
                cb_log_errores_mig
                (
                ler_fuente,
                ler_fila,
                ler_campo,
                ler_dato,
                ler_referencia,
                ler_clave,
                ler_producto
                )
        VALUES
                (
                @i_fuente,
                @i_fila,
                @i_campo,
                @i_dato,
                @i_referencia,
                @i_operacion,
                @i_producto
                )
RETURN  0
GO