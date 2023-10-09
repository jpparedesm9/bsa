use cob_bvirtual
go
if object_id('sp_bloq_usuario') is not null
		drop proc sp_bloq_usuario
go

/******************************************************************************/
/*      Stored procedure:       b2c_bloq_usuario.sp                           */
/*      Base de datos:          cob_bvirtual                                  */
/******************************************************************************/
/*                                 IMPORTANTE                                 */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                                PROPOSITO                                   */
/*   Registrar el final de sesion para Cobis Internet                         */
/******************************************************************************/
/*                              MODIFICACIONES                                */
/******************************************************************************/
/*  FECHA       VERSION   AUTOR                 RAZON                         */
/******************************************************************************/
/*  11-Dic-2018           Estefania Ramirez     Emision inicial               */
/*  03-Jul-2019           Alexander Inca        Se agrega envio de mail       */
/*  18-Oct-2019           Jonathan Ramirez      Agrega registro log B2C       */
/******************************************************************************/   

Create Procedure sp_bloq_usuario
    @s_ssn             int          = null,
    @s_srv             varchar(30)  = null,
    @s_lsrv            varchar(30)  = null,
    @s_user            varchar(30)  = null,
    @s_sesn            int          = null,
    @s_term            varchar(10)  = null,
    @s_date            datetime     = null,
    @s_ofi             smallint     = null,    -- Localidad origen transaccion
    @s_rol             smallint     = null,
    @s_org_err         char(1)      = null,    -- Origen de error: [A], [S]
    @s_error           int          = null,
    @s_sev             tinyint      = null,
    @s_msg             mensaje      = null,
    @s_org             char(1)      = null,
    @t_debug           char(1)      = 'N',
    @t_file            varchar(14)  = null,
    @t_from            varchar(32)  = null,
    @t_rty             char(1)      = 'N',
    @t_trn             int          = null,
    @i_login           varchar(64)  = null,
    @i_ente            int          = null,
    @i_ente_mis        int          = null,
    @i_clave		   varchar(64)  = null,
    @i_servicio        int          = null,
	@i_operacion       char(1),
    @i_terminal_ip     varchar(30) = null,
    @i_server          varchar(30) = null,
    @i_webserver       varchar(30) = null
 
As  
  declare 
	@w_return             int,
	@w_sp_name            varchar(30),
	@w_ente               int,
	@w_mail               varchar(255),
	@w_id                 int = 0,
    @w_subject            varchar(100),
    @w_body               varchar(500),
	@w_error              int,
    @w_msg                varchar(200),
	@w_enteCobis          int,
	@w_nombreC            varchar(250),
    @w_anio               varchar(4),	
    @w_mes_in			  varchar(15),
    @w_mes_es			  varchar(15),
    @w_dia 				  varchar(2),
    @w_fecha_b            varchar(25),
	@w_parraf_1           varchar(250),
	@w_parraf_2           varchar(250)

	
	
select @w_sp_name = 'sp_bloq_usuario'   

if @i_operacion = 'D'
begin
	select @w_ente = en_ente from bv_ente 
	where en_ente_mis = @i_ente_mis

	if @i_login = null
	begin
		exec cobis..sp_cerror
			@t_from  = @w_sp_name,
			@i_num   = 1875000 
		return 1875000
	end

	select 1 from bv_login
	where lo_login = @i_login
	and lo_ente = @w_ente
	and lo_estado = 'T'
	and lo_servicio = @i_servicio

	if @@rowcount = 0
	   BEGIN
		  exec cobis..sp_cerror
			  @t_from  = @w_sp_name,
			  @i_num   = 1890010 
		  return 1890010
	   END

	-- Obtención del mail del cliente
	select @w_mail = di_descripcion
    from cobis..cl_direccion
    where di_ente = @i_ente_mis
    and di_tipo = 'CE'	
	
	-- Consulta nombre del cliente
	select @w_nombreC = isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') + ' '+isnull(p_p_apellido,'') +' '+ isnull(p_s_apellido,'')
    from cobis..cl_ente
    where en_ente = @i_ente_mis
	
	-- Obtener fecha para body del correo
    select @w_anio = LTRIM(RTRIM(convert(varchar,DATENAME(yyyy,getdate()))))
    select @w_mes_in  = LTRIM(RTRIM(convert(varchar,DATENAME(mm,getdate()))))
    select @w_dia  = LTRIM(RTRIM(convert(varchar,DATENAME(dd,getdate()))))
    
    select @w_mes_es = (case @w_mes_in when 'January' then 'Enero' 
                              when 'February' then 'Febrero' when 'March' then 'Marzo' 
                              when 'April' then 'Abril' when 'May' then 'Mayo' 
                              when 'June' then 'Junio' when 'July' then 'Julio' 
                              when 'August' then 'August' when 'August' then 'August' 
                              when 'September' then 'Septiembre' when 'October' then 'Octubre' 
                              when 'November' then 'Noviembre' when 'December' then 'Diciembre' end)
    
    select @w_fecha_b =  @w_dia+'-'+@w_mes_es+'-'+@w_anio
	
	-- Seleccionar template si existiera
    select @w_id = te_id from cobis..ns_template where te_nombre = 'NotificacionGenerica.xslt'
	
	
	begin tran 

	update bv_login 
	set lo_estado = 'A'
	where lo_login = @i_login
	and lo_ente = @w_ente
	and lo_servicio = @i_servicio
	if @@error != 0
	begin
	-- Error en la actualización de cliente
		exec cobis..sp_cerror
		@t_from  = @w_sp_name,
		@i_num   = 1850031
	rollback tran
	return 1
	end

	exec cob_bvirtual..sp_b2c_registro_transacciones
		@s_ssn = @s_ssn,
		@s_lsrv = @s_lsrv,
		@s_date = @s_date,
		@i_tipo_tran = @t_trn,
		@i_login = @i_login

	/*
	insert into ts_login(
	secuencial, cod_alterno, tipo_transaccion,
	clase, fecha, usuario,
	terminal, oficina, tabla,
	lsrv, srv, ente,
	servicio, login, fecha_mod, tipo_vigencia, 
	dias_vigencia, renovable, hora, 
	descripcion)
	values (
	@s_ssn, 5, @t_trn,
	'U', @s_date, @s_user, 
	@s_term, @s_ofi, 'bv_login', 
	@s_lsrv, @s_srv, @w_ente, 
	@i_servicio, @i_login, @s_date,'I',
	null, 'S', convert(varchar(8), getdate(),108), 
	'Bloqueo temporal')  --BBO 17-02-2000

	if @@error != 0
	begin
	-- Error en la insercion en la tabla de servicio
		exec cobis..sp_cerror
		@t_from  = @w_sp_name,
		@i_num   = 1850034
	rollback tran
	return 1
	end
	*/
	
	delete bv_in_login where il_login = @i_login
	
	-- Creacion de un subject
    select @w_subject = 'Desbloqueo de la aplicación.'
	
	--Datos primer parrafo del body del correo
	select @w_parraf_1 = 'Hemos desactivado el bloqueo de tu aplicación Tuiio móvil, ahora puedes seguir utilizándola.'
	
	--Datos segundo parrafo del body del correo
	select @w_parraf_2 = 'Contratar créditos que excedan tu capacidad de pago afecta tu historial crediticio.'

    -- Creacion del body del correo
    --select @w_body = 'Estimado,' + CHAR(13) + CHAR(10) + ' El desbloque fue realizado con exito.'
	select @w_body = '<?xml version=''1.0'' encoding=''ISO-8859-1''?><data><fechaDoc>'+@w_fecha_b+'</fechaDoc><nombreC>'+@w_nombreC+'</nombreC><parrafoDoc>'+@w_parraf_1+'</parrafoDoc><parrafoDoc2>'+@w_parraf_2+'</parrafoDoc2></data>'

	
	-- Ejecucion del sp para las notificaciones y envio de mail
    exec @w_error =  cobis..sp_despacho_ins
         @i_cliente          = @i_ente_mis,
         @i_template         = @w_id,
         @i_servicio         = 1,
         @i_estado           = 'P',
         @i_tipo             = 'MAIL',
         @i_tipo_mensaje     = 'I',
         @i_prioridad        = 1,
         @i_from             = null,
         @i_to               = @w_mail,
         @i_cc               = null,
         @i_bcc              = null,
         @i_subject          = @w_subject,
         @i_body             = @w_body,
         @i_content_manager  = 'HTML',
         @i_retry            = 'S',
         @i_fecha_envio      = null,
         @i_hora_ini         = null,
         @i_hora_fin         = null,
         @i_tries            = 0,
         @i_max_tries        = 2,
         @i_var1             = null
    	   
    if @w_error <> 0
    begin
       select @w_msg = 'ERROR AL ENVIAR NOTIFICACION DE LA CODIGO DEL CLIENTE'+convert(varchar(100),@i_ente_mis)
       select @w_error = 5000
       
    end
	commit tran
end

if @i_operacion = 'B'
begin
	select 1 from bv_login
	where lo_login = @i_login
	and lo_ente = @i_ente
	and lo_estado = 'A'
	and lo_servicio = @i_servicio

	if @@rowcount = 0
	   BEGIN
		  exec cobis..sp_cerror
			  @t_from  = @w_sp_name,
			  @i_num   = 1802154 --el usuario no esta activo
		  return 1802154
	   END
	select @w_ente = lo_ente from bv_login
	where lo_login = @i_login
	and lo_ente = @i_ente
	and lo_estado = 'A'
	and lo_servicio = @i_servicio
	
	-- Busqueda del cliente cobis
    select @w_enteCobis=en_ente_mis 
    from cob_bvirtual..bv_ente 
    where en_ente = @w_ente
    
    -- Busqueda dirección cliente cobis
    select @w_mail=di_descripcion
    from cobis..cl_direccion
    where di_ente = @w_enteCobis
    and di_tipo = 'CE'
	
	-- Consulta nombre del cliente
	select @w_nombreC = isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') + ' '+isnull(p_p_apellido,'') +' '+ isnull(p_s_apellido,'')
    from cobis..cl_ente
    where en_ente = @w_enteCobis
	
	-- Obtener fecha para body del correo
    select @w_anio = LTRIM(RTRIM(convert(varchar,DATENAME(yyyy,getdate()))))
    select @w_mes_in  = LTRIM(RTRIM(convert(varchar,DATENAME(mm,getdate()))))
    select @w_dia  = LTRIM(RTRIM(convert(varchar,DATENAME(dd,getdate()))))
    
    select @w_mes_es = (case @w_mes_in when 'January' then 'Enero' 
                              when 'February' then 'Febrero' when 'March' then 'Marzo' 
                              when 'April' then 'Abril' when 'May' then 'Mayo' 
                              when 'June' then 'Junio' when 'July' then 'Julio' 
                              when 'August' then 'August' when 'August' then 'August' 
                              when 'September' then 'Septiembre' when 'October' then 'Octubre' 
                              when 'November' then 'Noviembre' when 'December' then 'Diciembre' end)
    
    select @w_fecha_b =  @w_dia+'-'+@w_mes_es+'-'+@w_anio
	
	-- Seleccionar template si existiera
    select @w_id = te_id from cobis..ns_template where te_nombre = 'NotificacionGenerica.xslt'

	begin tran 

	update bv_login 
	set lo_estado = 'T'
	where lo_login = @i_login
	and lo_ente = @i_ente
	and lo_servicio = @i_servicio
	if @@error != 0
	begin
	-- Error en la actualización de cliente
		exec cobis..sp_cerror
		@t_from  = @w_sp_name,
		@i_num   = 1850031
	rollback tran
	return 1
	end

	exec cob_bvirtual..sp_b2c_registro_transacciones
		@s_ssn = @s_ssn,
		@s_lsrv = @s_lsrv,
		@s_date = @s_date,
		@i_tipo_tran = @t_trn,
		@i_login = @i_login

	/*
	insert into ts_login(
	secuencial, cod_alterno, tipo_transaccion,
	clase, fecha, usuario,
	terminal, oficina, tabla,
	lsrv, srv, ente,
	servicio, login, fecha_mod, tipo_vigencia, 
	dias_vigencia, renovable, hora, 
	descripcion)
	values (
	@s_ssn, 5, @t_trn,
	'U', @s_date, @s_user, 
	@s_term, @s_ofi, 'bv_login', 
	@s_lsrv, @s_srv, @w_ente, 
	@i_servicio, @i_login, @s_date,'I',
	null, 'S', convert(varchar(8), getdate(),108), 
	'Desbloqueo de usuario')  

	if @@error != 0
	begin
	-- Error en la insercion en la tabla de servicio
		exec cobis..sp_cerror
		@t_from  = @w_sp_name,
		@i_num   = 1850034
	rollback tran
	return 1
	end
	*/
	
	-- Creacion de un subject
    select @w_subject = 'Bloqueo de la aplicación.'
	
	--Datos primer parrafo del body del correo
	select @w_parraf_1 = 'Hemos activado el bloqueo seguro de tu aplicación Tuiio móvil, para desbloquearla ingresa a tu aplicación móvil e responde las preguntas de seguridad.'
	select @w_parraf_2 = ''
    -- Creacion del body del correo
    --select @w_body = 'Estimado,' + CHAR(13) + CHAR(10) + ' Su cuenta ha sido bloqueda con exito.'
	select @w_body = '<?xml version=''1.0'' encoding=''ISO-8859-1''?><data><fechaDoc>'+@w_fecha_b+'</fechaDoc><nombreC>'+@w_nombreC+'</nombreC><parrafoDoc>'+@w_parraf_1+'</parrafoDoc></data>'

	-- Ejecucion del sp para las notificaciones y envio de mail
    exec @w_error =  cobis..sp_despacho_ins
         @i_cliente          = @w_enteCobis,
         @i_template         = @w_id,
         @i_servicio         = 1,
         @i_estado           = 'P',
         @i_tipo             = 'MAIL',
         @i_tipo_mensaje     = 'I',
         @i_prioridad        = 1,
         @i_from             = null,
         @i_to               = @w_mail,
         @i_cc               = null,
         @i_bcc              = null,
         @i_subject          = @w_subject,
         @i_body             = @w_body,
         @i_content_manager  = 'HTML',
         @i_retry            = 'S',
         @i_fecha_envio      = null,
         @i_hora_ini         = null,
         @i_hora_fin         = null,
         @i_tries            = 0,
         @i_max_tries        = 2,
         @i_var1             = null
    	   
    if @w_error <> 0
    begin
       select @w_msg = 'ERROR AL ENVIAR NOTIFICACION DE LA CODIGO DEL CLIENTE'+convert(varchar(100),@w_enteCobis)
       select @w_error = 5000
       
    end	
	commit tran
end 
return 0 


GO