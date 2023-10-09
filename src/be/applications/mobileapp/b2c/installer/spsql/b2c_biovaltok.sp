use cob_bvirtual
go

if object_id ('sp_biomobil_validacion_token') is not null
   drop procedure sp_biomobil_validacion_token
go
/*************************************************************************/
/*   Archivo:            b2c_biovaltok.sp                                    */
/*   Stored procedure:   sp_biomobil_validacion_token                    */
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
/*   Este procedimiento almacenado,guarda respuesta del servicio de      */
/*   "validacion de Token Opaco" de biomobil(FingerID).                  */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA         AUTOR         RAZON                                   */
/*   21-03-2022    WTO           Emision Inicial                         */
/*************************************************************************/
create procedure sp_biomobil_validacion_token(
	@t_debug       	  char(1)     = 'N',
	@t_from        	  varchar(30) = null,
	@s_ssn            int         = null,
	@s_user           varchar(30) = null,
	@s_sesn           int		  = null,
	@s_term           varchar(30) = null,
	@s_date           datetime	  = null,
	@s_srv            varchar(30) = null,
	@s_lsrv           varchar(30) = null,
	@s_ofi            smallint	  = null,
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
	@i_operacion      char(1)     = null,
	@i_id_cliente     varchar(20) = null,
    @i_tipo_trx       varchar(50) = null,
    @i_id_trx         varchar(50) = null,
	@i_codigo_respuesta_minucia int = null,
	@i_similitud2	  varchar(10) = null,
	@i_similitud7	  varchar(10) = null,
	@i_fecha_ini	  varchar(10) = null,
	@i_fecha_fin	  varchar(10) = null,
	@i_codigo_err	  varchar(20) = null,
	
	@i_codigo_respuesta 			int = null ,
	@i_fecha_hora_peticion 			varchar(30) = null ,
	@i_indice_solicitud 			varchar(100) = null ,
	@i_tiempo_procesamiento 		int = null ,
	@i_codigo_respuesta_datos 		int = null ,
	@i_is_ocr 						bit = null ,
	@i_is_numero_emision_credencial bit = null ,
	@i_is_nombre 					bit = null ,
	@i_is_curp 						bit = null ,
	@i_is_clave_elector 			bit = null ,
	@i_is_apellido_paterno 			bit = null ,
	@i_is_apellido_materno 			bit = null ,
	@i_is_anio_emision 				bit = null ,
	@i_is_anio_registro 			bit = null ,
	@i_tipo_reporte_robo_extravio 	varchar(100) = null ,
	@i_tipo_situacion_registral 	varchar(30) = null ,
	@i_x_serial_number				varchar(100) = null ,
	@i_signature_value 				varchar(100) = null ,
	-- @i_signed_info 					varchar(100) = null ,
	@i_metodo_canonicalizacion	    varchar(100) = null ,
	@i_metodo_firma	                varchar(100) = null ,
	@i_alg_metodo_digestion         varchar(100) = null ,
	@i_valor_metodo_digestion       varchar(100) = null ,
	@i_uri_metodo_digestion         varchar(100) = null ,

	@i_momento 						varchar(100) = null ,
	@i_indice 						varchar(100) = null ,
	@i_numero_serie 				varchar(100) = null ,
	@i_hash 						varchar(200) = null ,
	@i_desc_tipo_trx 				varchar(10) = null ,
	-- -----
	@o_respuesta	  				varchar(50) = null out
)
as
declare
  @w_return  int,
  @w_sp_name varchar(30),
  @w_error   int,
  @w_msg     varchar(132),
  -- ---------------------
  @w_monto            varchar(30),
  @w_valores 		  varchar(100),
  @w_resultado 	      varchar(255)
  
if @i_operacion = 'I'
begin
	-- 1) Guardar Response del SErvicio de Validacion de Token de BioMobil (FingerID)
	insert into bv_respuesta_fingerid(
	    rf_id_cliente,  rf_tipo_trx,    rf_id_trx,      rf_codigo_respuesta_minucia, rf_similitud2, 
		rf_similitud7,  rf_fecha_ini,   rf_fecha_fin,   rf_codigo_err,
		-- -----
		rf_codigo_respuesta,       rf_fecha_hora_peticion, rf_indice_solicitud,             rf_tiempo_procesamiento ,
		rf_codigo_respuesta_datos, rf_is_ocr,		       rf_is_numero_emision_credencial, rf_is_nombre,
		rf_is_curp,                rf_is_clave_elector,    rf_is_apellido_paterno ,         rf_is_apellido_materno ,
        rf_is_anio_emision ,       rf_is_anio_registro,    rf_tipo_reporte_robo_extravio,   rf_tipo_situacion_registral,
		rf_x_serial_number,        rf_signature_value ,    rf_metodo_canonicalizacion 	,   rf_momento,
		rf_indice ,                rf_numero_serie,        rf_hash,                         rf_desc_tipo_trx,
		rf_metodo_firma,           rf_alg_metodo_digestion,rf_valor_metodo_digestion,       rf_uri_metodo_digestion
	)
	values(
	    @i_id_cliente,  @i_tipo_trx,    @i_id_trx,      @i_codigo_respuesta_minucia, @i_similitud2,
		@i_similitud7,  @i_fecha_ini,   @i_fecha_fin,   @i_codigo_err,
		-- -----
		@i_codigo_respuesta,       @i_fecha_hora_peticion, @i_indice_solicitud,             @i_tiempo_procesamiento,
		@i_codigo_respuesta_datos, @i_is_ocr,		       @i_is_numero_emision_credencial, @i_is_nombre,
		@i_is_curp,                @i_is_clave_elector,    @i_is_apellido_paterno,          @i_is_apellido_materno,
		@i_is_anio_emision,        @i_is_anio_registro,    @i_tipo_reporte_robo_extravio,   @i_tipo_situacion_registral,
		@i_x_serial_number,        @i_signature_value,	   @i_metodo_canonicalizacion,      @i_momento,
		@i_indice,                 @i_numero_serie,        @i_hash,                         @i_desc_tipo_trx,
		@i_metodo_firma,	       @i_alg_metodo_digestion,@i_valor_metodo_digestion, 		@i_uri_metodo_digestion   
	)
	if @@error != 0 
	begin
		select @w_error = 710001, @w_msg = 'Error en la Insercion de la Respuesta de FingerID'
		goto ERROR
	end
	-- 2) Eejecutar regla para validacion INE
	select @w_monto = pa_char from cobis..cl_parametro -- Monto para regla VALINE (VAlidacion del INE)
	where pa_nemonico = 'MOVAIN' and pa_producto = 'CLI'
						-- Tipo Operacion|HuellaDactilar|Monto|
	select  @w_valores = 
		'INDIVIDUAL' + '|' + 'N' + '|' + @w_monto + '|' +
		convert(varchar(10),isnull(replace(@i_similitud2,'%',''),0)) + '|' + 
		convert(varchar(10),isnull(replace(@i_similitud7,'%',''),0))
    
	exec @w_error           = cob_cartera..sp_ejecutar_regla
	@s_ssn                  = @s_ssn,
	@s_ofi                  = @s_ofi,
	@s_user                 = @s_user,
	@s_date                 = @s_date,
	@s_srv                  = @s_srv,
	@s_term                 = @s_term,
	@s_rol                  = @s_rol,
	@s_lsrv                 = @s_lsrv,
	@s_sesn                 = @s_sesn,
	@i_regla                = 'VALINE', 
	@i_tipo_ejecucion       = 'REGLA',     
	@i_valor_variable_regla = @w_valores,--'GRUPAL|N|16000|99|12|',
	@o_resultado1           = @w_resultado out 
    
	if @w_error <> 0
	begin
		select @w_msg = 'Error en la Ejecucion de Regla VALINE'
		goto ERROR
	end

	update bv_respuesta_fingerid set 
	rf_resultado        = @w_resultado 
	where rf_id_trx       = @i_id_trx

	select @o_respuesta = @w_resultado

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

