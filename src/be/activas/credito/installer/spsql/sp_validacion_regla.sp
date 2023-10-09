/************************************************************************/
/*  Archivo:                sp_validacion_regla.sp                      */
/*  Stored procedure:       sp_validacion_regla                         */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           ACH                                         */
/*  Fecha de Documentacion: 15/Nov/2022                                 */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*                           PROPOSITO                                  */
/* Procedure tipo automatico para ejecutar regla                        */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*  FECHA        AUTOR                   RAZON                          */
/*  15/11/2022    ACH     Emision Inicial - REQ#194284 Dia de Pago      */
/* **********************************************************************/

USE cob_credito
GO

if exists(select 1 from sysobjects where name ='sp_validacion_regla')
	DROP proc sp_validacion_regla
GO

CREATE PROC sp_validacion_regla
(	@s_ssn        	INT         = NULL,
	@s_ofi        	SMALLINT    = NULL,
	@s_user       	login       = NULL,
	@s_date       	DATETIME    = NULL,
	@s_srv		   	VARCHAR(30) = NULL,
	@s_term	   		descripcion = NULL,
	@s_rol		   	SMALLINT    = NULL,
	@s_lsrv	   		VARCHAR(30)	= NULL,
	@s_sesn	   		INT 	    = NULL,
	@s_org		   	CHAR(1)     = NULL,
	@s_org_err	    INT 	    = NULL,
	@s_error     	INT 	    = NULL,
	@s_sev        	TINYINT     = NULL,
	@s_msg        	descripcion = NULL,
	@t_rty        	CHAR(1)     = NULL,
	@t_trn        	INT         = NULL,
	@t_debug      	CHAR(1)     = 'N',
	@t_file       	VARCHAR(14) = NULL,
	@t_from       	VARCHAR(30) = NULL,
	--variables
	@i_id_inst_proc	INT,    -- Codigo de instancia del proceso
	@i_id_inst_act 	INT,	-- Codigo instancia de la atividad
	@i_id_empresa	INT,	-- Codigo de la empresa
	@o_id_resultado SMALLINT  OUT
)
AS 
DECLARE	-- Variables de trabajo
@w_sp_name                  varchar(20),
@w_msg                      varchar(255),
@w_error					int,
@w_valor_ant                varchar(255), 
@w_respuesta                varchar(10)

select @w_sp_name = 'sp_validacion_regla'
select @o_id_resultado = 2 -- Seteo para salida de la tarea con DEVOLVER 

exec sp_eje_calendario_dia_pago
@i_id_inst_proc = @i_id_inst_proc,
@o_respuesta    = @w_respuesta out

-- VALIDA SI pasa OK O DEVOLVER
if ltrim(rtrim(@w_respuesta)) = 'SI'
begin
	-- Seteo variables de salida
	select @o_id_resultado = 1 -- Seteo para salida de la tarea con OK	
end

return 0
