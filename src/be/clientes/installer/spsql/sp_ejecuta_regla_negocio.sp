/*************************************************************************/
/*   Archivo:            sp_ejecuta_regla_negocio.sp                     */
/*   Stored procedure:   sp_ejecuta_regla_negocio                        */
/*   Base de datos:      cobis                                           */
/*   Producto:           Clientes                                        */
/*   Disenado por:       Patricio Samueza                                */
/*   Fecha de escritura: 01/07/2018                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'MACOSA', representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este programa da mantenimiento a la tabla cl_negocio_cliente        */
/*************************************************************************/
/*                               OPERACIONES                             */
/*   OPER. OPCION                     DESCRIPCION                        */
/*     I            Creación de una alerta                               */
/*     D            Eliminación (estado E) una operacion inusual (OI)    */
/*     S            Listado todas las OI ingresadas en el día            */
/*     S            Listado las alertas de riesgo ingresadas del día     */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA        AUTOR                       RAZON                      */
/* 01/07/2018   PXSG               Versión Inicial                       */
/*************************************************************************/
USE cobis
go
IF OBJECT_ID ('dbo.sp_ejecuta_regla_negocio') IS NOT NULL
	DROP PROCEDURE dbo.sp_ejecuta_regla_negocio
GO

CREATE PROCEDURE sp_ejecuta_regla_negocio (	
	@t_debug                   char(1) 	     = 'N',
	@t_file                    varchar(14)   = null,
	@t_from                    varchar(32)   = null,
	@t_show_version            bit           = 0,
	@s_rol                     smallint      = null,
	@i_param1                  char(1)       = null,
	@i_param2                  DATETIME      = null
)
as 

DECLARE
    @w_sp_name               varchar(32),   
    @w_mensaje_fallo_regla   varchar(100),
	@w_ejecutar_regla        char(1) = 'S',
    @w_variables             varchar(255),
    @w_result_values         varchar(max),
    @w_error                 int,
	@w_error_mens            varchar(255)
   
	      
/*  Inicializacion de Variables  */
select @w_sp_name = 'sp_ejecuta_regla_negocio'

    
      PRINT'Reglas de Negocio'
	  EXEC cobis..sp_regla_regla_negocio
     @i_operacion            = @i_param1,
     @i_fecha_proceso        = @i_param2
                 
            
RETURN 0

GO

