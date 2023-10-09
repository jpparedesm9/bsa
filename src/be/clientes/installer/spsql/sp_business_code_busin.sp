use cob_pac
go

/************************************************************************/
/*  Archivo:                sp_business_code_busin.sp                   */
/*  Stored procedure:       sp_business_code_busin                      */
/*  Base de Datos:          cob_pac                                     */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 27/Jul/2017                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Consulta los negocios de un cliente, de forma que se muestren en un  */
/* catalogo                                                             */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*  27/Jul/2017 P. Ortiz             Emision Inicial                    */
/* **********************************************************************/

IF OBJECT_ID ('dbo.sp_business_code_busin') IS NOT NULL
	DROP PROCEDURE dbo.sp_business_code_busin
GO

CREATE PROCEDURE 	sp_business_code_busin (
	@s_ssn			int = null,
	@s_user			login = null,
	@s_sesn			int = null,
	@s_term			varchar(30) = null,
	@s_date			datetime = null,
	@s_srv			varchar(30) = null,
	@s_lsrv			varchar(30) = null, 
	@s_rol			smallint = null,
	@s_ofi			smallint = null,
	@s_org_err		char(1) = null,
	@s_error		int = null,
	@s_sev			tinyint = null,
	@s_msg			descripcion = null,
	@s_org			char(1) = null,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@t_trn			smallint =null,
    @i_operacion	varchar(1) = null,
    @i_ente			int = null 
)
as
declare @w_today	datetime,
	@w_sp_name	varchar(32)

select @w_sp_name = 'sp_business_code_busin'

/* ** Insert ** */
if @i_operacion = 'H'
begin
	if @t_trn = 599
	BEGIN
	
		SELECT 	'codigo'= nc_codigo,
		  		'valor'= nc_nombre 
	 	FROM cobis..cl_negocio_cliente
	 	WHERE nc_ente = @i_ente
		and   nc_estado_reg = 'V'
	 	
	RETURN 0
	END
 
 	
 
	else
	begin
		exec cobis..sp_cerror
		   @t_debug	 = @t_debug,
		   @t_file	 = @t_file,
		   @t_from	 = @w_sp_name,
		   @i_num	 = 151051
		   /*  'No corresponde codigo de transaccion' */
		return 1
	end


end



GO

