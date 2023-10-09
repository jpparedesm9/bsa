use cob_bvirtual
go

if object_id ('sp_bioonboarding_ocr_score') is not null
   drop procedure sp_bioonboarding_ocr_score
go
/*************************************************************************/
/*   Archivo:            b2c_bioocrsco.sp                                */
/*   Stored procedure:   sp_bioonboarding_ocr_score                      */
/*   Base de datos:      cob_bvirtual                                    */
/*   Producto:           Banca Mobil                                     */
/*   Disenado por:       WTO                                             */
/*   Fecha de escritura: 15/03/2022                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier acion o agregado hecho por alguno de sus                  */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este procedimiento almacenado, consulta las respuestas OCR y SCORES */
/*   de la cola MQ de BioOnboarding                                      */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA         AUTOR         RAZON                                   */
/*   15-03-2022    WTO           Emision Inicial                         */
/*************************************************************************/
create procedure sp_bioonboarding_ocr_score(
	@t_debug       	  char(1)     = 'N',
	@t_from        	  varchar(30) = null,
	@s_ssn            int         = null,
	@s_user           varchar(30) = null,
	@s_sesn           int			= null,
	@s_term           varchar(30) = null,
	@s_date           datetime	= null,
	@s_srv            varchar(30) = null,
	@s_lsrv           varchar(30) = null,
	@s_ofi            smallint	= null,
	@t_file           varchar(14) = null,
	@s_rol            smallint    = null,
	@s_org_err        char(1)     = null,
	@s_error          int         = null,
	@s_sev            tinyint     = null,
	@s_msg            descripcion = null,
	@s_org            char(1)     = null,
	@s_culture        varchar(10) = 'NEUTRAL',
	@t_trn			  int         = null,
	-- ------------------------------------
    @i_id_expediente  varchar(100)= null,
	@i_operacion      char(1)     = null,
	@i_tipo           char(3)     = 'OCR' -- OCR/SCR/ALL -- Tipo de Respuesta a consultar
)
as
declare
  @w_return  int,
  @w_sp_name varchar(30),
  @w_error   int,
  @w_msg     varchar(132),
  -- -----  
  @w_tipo_desc varchar(30)
  
-- NOMBRE DEL SP
select @w_sp_name = 'sp_bioonboarding_ocr_score'

   
if @i_operacion = 'Q'
begin
	select @w_tipo_desc = 'OCR'
	if not exists (select 1 from bv_onboard_ocr_sco where id_expediente = @i_id_expediente)
	begin
		if @i_tipo != 'OCR' begin select @w_tipo_desc = 'SCORES' end
		select @w_error = 105506, @w_msg = 'No existe Informacion de ' +  @w_tipo_desc
		goto ERROR
	end

	-- OCR/SCORES - CAB
	select top 1 id_expediente, id_validas, document_type
	from bv_onboard_ocr_sco
	where id_expediente = @i_id_expediente and type='OCR'
	
	if @i_tipo = 'OCR' or @i_tipo = 'ALL'
	begin
		-- OCR - DET
		select field_name, name, text
		from bv_onboard_ocr_sco
		where id_expediente = @i_id_expediente and type='OCR'
	end
	
	if @i_tipo = 'SCR' or @i_tipo = 'ALL'
	begin
		-- SCORES - DET: BiometryScores
		select name, value
		from bv_onboard_ocr_sco
		where id_expediente = @i_id_expediente and type='BIO'
		
		-- SCORES - DET: DocumentScores
		select name, value
		from bv_onboard_ocr_sco
		where id_expediente = @i_id_expediente and type= 'DOC'
	end
end

return 0
ERROR:
	exec cobis..sp_cerror
	@t_debug = 'N',
	@t_file  = null,
	@t_from  = @w_sp_name,
	@i_num   = @w_error,
	@i_msg   = @w_msg
	return @w_error

GO
