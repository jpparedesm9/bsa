use cobis
GO

IF OBJECT_ID ('dbo.sp_cew_security_otp') IS NOT NULL
	DROP PROCEDURE dbo.sp_cew_security_otp
GO

CREATE PROCEDURE sp_cew_security_otp(
   @i_operacion       CHAR(1),  
   @i_usuario         VARCHAR(30) = NULL,         --Login del usuario
   @i_token           VARCHAR(8)  = NULL,         --Token otp a enviar en notificacion
   @i_medio           VARCHAR(15) = NULL,         --Medio por el cual se enviara la notificacion
   @i_destino         VARCHAR(64) = NULL,         --Correo o numero celular al cual se enviara la notificacion
   @i_timeout	      INT = 2,				      --Timeout
   @i_offset		  VARBINARY(32) = NULL,
   @o_notificar       VARCHAR(1)  = NULL output   --Se envía el correo=S o no se envía el correo=N
)
AS
DECLARE 
   @w_id_template        SMALLINT,        
   @w_mail_funcionario   VARCHAR(64),
   @w_body               NVARCHAR(2000), --Texto del correo
   @w_fu_name            VARCHAR(255),
   @w_fecha              VARCHAR(25),
   @retCode				 SMALLINT,
   @w_dvpw 			     TINYINT,
   @w_avpw               TINYINT,
   @w_fech_pwd_caducado  DATETIME,
   @w_cod_func           SMALLINT


SET @retCode = 0

/*
Operaciones:
	U: Validar si el usuario existe
	I: Obtener información de funcionario y medio (sms, mail)
	V: Consultar vigencia de token
	N: Enviar notificación
	P: Cambiar contraseña
	O: Validar si el token existe						  
*/


-- Consultar existencia de funcionario
DECLARE @w_vigencia CHAR(1)

IF @i_operacion = 'U' 
BEGIN
	IF (EXISTS(SELECT 1 FROM cl_funcionario WHERE fu_login = @i_usuario))
	BEGIN
		SELECT @w_vigencia = fu_estado FROM cl_funcionario WHERE fu_login = @i_usuario
		IF (@w_vigencia = 'V')
			SELECT @retCode = 1
		ELSE
			SELECT @retCode = 2
	END
	ELSE
	BEGIN
		SELECT @retCode = 0
	END
	
	
END

IF @i_operacion = 'P'
BEGIN
	IF (EXISTS(SELECT 1 FROM cl_funcionario WHERE fu_login = @i_usuario))
	BEGIN
		-- Calcular fecha para caducar el password en base a los días de vigencia de la contraseña
		SELECT @w_dvpw = pa_tinyint
		FROM cobis.dbo.cl_parametro
		WHERE pa_nemonico = 'DVPW'
		       
		SELECT @w_avpw = pa_tinyint
		FROM cobis.dbo.cl_parametro
		WHERE pa_nemonico = 'AVPW'
	
		SELECT @w_fech_pwd_caducado = dateadd(dd, (@w_dvpw * -1) - isnull(@w_avpw,0), getdate())
	
		UPDATE cl_funcionario SET
			fu_offset = @i_offset
		WHERE fu_login = @i_usuario
		
		UPDATE ad_usuario SET
			us_estado = 'V',
			us_fecha_ult_mod = @w_fech_pwd_caducado,
			us_fecha_ult_pwd = @w_fech_pwd_caducado
		WHERE us_login = @i_usuario
	END
	IF @@ERROR = 0
	BEGIN
		SELECT @retCode = 1
	END
	ELSE
	BEGIN
		SELECT @retCode = 0
	END	
END


-- Consultar informacion de contacto del funcionario
IF @i_operacion = 'I'
BEGIN

	-- Filtrar por medio y vigencia
	SELECT TOP 1
		fu_nombre,
		fu_login,
		(CASE mf_tipo
			WHEN '0' THEN 'MAIL'
			WHEN '1' THEN 'SMS'
			ELSE '' END) mf_tipo,
			mf_descripcion
		FROM
			cl_funcionario f,
			cl_medios_funcio m
		WHERE
			m.mf_funcionario = f.fu_funcionario
			AND fu_login = @i_usuario
			AND fu_estado = 'V'
			AND mf_estado = 'V'
			AND (CASE mf_tipo
				WHEN '0' THEN 'MAIL'
				WHEN '1' THEN 'SMS'
				ELSE '' END) = UPPER(@i_medio)
		ORDER BY m.mf_codigo DESC
	
END


-- Validar expiracion de token para evitar envio continuo de notificaciones
if @i_operacion = 'V'
begin
   
   if exists (select 1 from cobis_otp 
               where ot_user      = @i_usuario
                 and ot_exp_date >= getdate()
                 and ot_cre_date <= getdate())
      select @o_notificar = 'N'
   else
      select @o_notificar = 'S'
      
   select @o_notificar = 'S'
      
end

-- Enviar notificacion
if @i_operacion = 'N'
begin

   select @w_id_template = te_id
     from ns_template
    where te_nombre = 'not_recupera_pwd.xslt'
      and te_estado = 'A'

   if @@rowcount = 0
   begin
      raiserror('No existe dato solicitado', 16, 101001)
      return 1
   end
   
   /*
   select @w_mail_funcionario = mf_descripcion
     from cl_funcionario 
     join cl_medios_funcio on fu_funcionario = mf_funcionario
    where fu_login  = @i_usuario
      and fu_estado = 'V'
      and mf_estado = 'V'
      
   if @@rowcount = 0
   begin
      raiserror('No existe dato solicitado', 16, 101001)
      return 1
   end */   

   
   SELECT @w_fu_name = fu_nombre, @w_cod_func = fu_funcionario FROM cl_funcionario WHERE fu_login = @i_usuario
   SELECT @w_fecha = convert(VARCHAR, getdate(), 106) + ' ' + convert(VARCHAR, getdate(), 108)
   
   select @w_body = '<?xml version="1.0" encoding="UTF-8"?><data><otp>' + @i_token + '</otp></data>'
   
   PRINT @w_body
   
   exec sp_despacho_ins
        @i_cliente         = @w_cod_func,
        @i_template        = @w_id_template,
        @i_servicio        = 1,
        @i_estado          = 'P',
        @i_tipo            = @i_medio,
        @i_tipo_mensaje    = 'I',
        @i_prioridad       = 1,
        @i_num_dir         = '',
        @i_from            = null,
        @i_to              = @i_destino, 
        @i_cc              = null, 
        @i_bcc             = null,
        @i_subject         = 'Solicitud de contraseña temporal',
        @i_body            = @w_body,
        @i_content_manager = 'HTML',
        @i_retry           = 'S',
        @i_fecha_envio     = null,
        @i_hora_ini        = null,
        @i_hora_fin        = null,        
        @i_tries           = 0,
        @i_max_tries       = 2

end

-- validar existencia y vigencia de otp
if @i_operacion = 'O'
begin
	if exists (select 1 from cobis_otp 
		where ot_user 	= @i_usuario
		and ot_token 	= @i_token) 
	begin
		
		if exists (select 1 from cobis_otp 
			where ot_user      = @i_usuario
			and ot_exp_date <= getdate())
		begin
			select @retCode = 1
		end
	end
end
return @retCode  

GO

