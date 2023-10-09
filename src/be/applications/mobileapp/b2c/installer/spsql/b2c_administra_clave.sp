use cob_bvirtual
go

if object_id('sp_administra_clave') is not null
begin
  drop procedure sp_administra_clave
  if object_id('sp_administra_clave') is not null
    print 'FAILED DROPPING PROCEDURE sp_administra_clave'
end
go

/******************************************************************************/
/*   ARCHIVO:         sp_administra_clave.sp                            */
/*   NOMBRE LOGICO:   sp_administra_clave                               */
/*   PRODUCTO:        BANCAMOVIL                                             */
/******************************************************************************/
/*                                 IMPORTANTE                                 */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                     PROPOSITO                                              */
/*   Operaciones creación recuperación de claves                              */
/*                                                                            */
/******************************************************************************/
/*                              MODIFICACIONES                                */
/******************************************************************************/
/*  FECHA       VERSION         AUTOR                      RAZON              */
/******************************************************************************/
/* 19/May/14     1.0.0.0        Iván Martínez           Emision Inicial       */
/* 05/Jul/19     1.0.0.1        Alexander Inca          Envío de correos      */
/* 18/Oct/2019                  Jonathan R            Agrega registro log B2C */
/******************************************************************************/
create procedure sp_administra_clave( 
   @t_show_version          bit = 0,
   @s_date                  datetime = null,
   /*@s_user                  varchar(30),
   @s_ofi                   smallint,
   @s_term                  varchar(10),
   @s_rol                   smallint,
   @s_srv                   varchar(30),*/
   @s_ssn_branch            int = null,
   @s_ssn                   int = null,
   @s_lsrv                  varchar(30) = null,
   @s_servicio              tinyint = 8,
   @s_culture               varchar(10) = 'ES-EC', --se debe enviar la cultura del dispositivo en @i_servicio
   @t_trn                   int,
   @t_debug                 char(1) = 'N',
   @t_file                  varchar(14) = null,
   @t_from                  varchar(32) = null,
   @i_operacion             char(1),
   @o_lo_cambiar_login      char(1) = null out,
   @i_ente_ib               int = null,
   @i_servicio              tinyint = null,
   @i_login                 varchar(64) = null,
   @i_clave_temp            varchar(64) = null,
   @i_clave_def             varchar(64) = null,
   @i_clave                 varchar(64) = null
)

as

declare
    @w_sp_name            varchar(64),
	@w_return             int,
    @w_producto           tinyint,
	@w_aux3               varchar(100),
    @w_enteImg            int,
    @w_enteCobis          int,
    @w_mail               varchar(255),
    @w_id_template        int = 0,
    @w_subject            varchar(100),
    @w_body               varchar(500),
    @w_error              int,
    @w_msg                varchar(200),
	@w_nombreC            varchar(250),
    @w_anio               varchar(4),	
    @w_mes_in			  varchar(15),
    @w_mes_es			  varchar(15),
    @w_dia 				  varchar(2),
    @w_fecha_b            varchar(25),
	@w_parraf_1           varchar(250),
	@w_parraf_2           varchar(250)

select @w_sp_name = 'sp_administra_clave'

--PRODUCTO BANCA VIRTUAL PARA NOTIFICACION
select @w_producto = 18

-- Mostrar la version del programa
if @t_show_version = 1
begin
   print 'Stored procedure = ' + @w_sp_name + '1.0.0.0'
   return 0
end
	
-- Modo de debug
if @t_trn != 17006
begin
-- Error en codigo de transaccion 
   exec cobis..sp_cerror
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_num       = 17001
   return 1
end

-- CONSULTA TIENE CLAVE TEMPORAL
if @i_operacion = 'Q' 
begin
    if exists (select 1 
        from bv_login
        where lo_ente = @i_ente_ib
            and lo_servicio = @i_servicio
            and lo_login = @i_login
            and lo_cambiar_login is not null
    )
    begin
        --select @o_lo_cambiar_login = lo_cambiar_login 
        --from bv_login
        --where lo_ente = @i_ente_ib 
        --    and lo_servicio = @i_servicio
        --    and lo_login = @i_login
		if exists (select 1 
			from bv_login
			where lo_ente = @i_ente_ib 
				and lo_servicio = @i_servicio
				and lo_login = @i_login
				and lo_clave_def = null
				and lo_clave_temp is not null) 
			
			select @o_lo_cambiar_login  = 'S'			
		else
			select @o_lo_cambiar_login  = 'N'
			
    end
    else
    begin
        exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 17024
        return 17024 --Error al consultar clave temporal
    end
end

-- VALIDACION Y MODIFICACION DE CLAVE
if @i_operacion = 'U' 
begin
    
    if exists (select 1
        from bv_login
        where lo_ente = @i_ente_ib 
            and lo_servicio = @i_servicio
            and lo_login = @i_login
            and lo_clave_def = @i_clave
            --and lo_cambiar_login = 'S'
            and @i_clave is not null
			--and lo_clave_def = null
    )
    begin
        update bv_login
        set lo_clave_def = @i_clave_def,
            lo_cambiar_login = 'N',
			lo_fecha_ult_pwd = getdate()
        from bv_login
        where lo_ente = @i_ente_ib 
            and lo_servicio = @i_servicio
            and lo_login = @i_login
            and lo_clave_def = @i_clave
            --and lo_cambiar_login = 'S'
			--and lo_clave_def = null
		
        -- REGISTRO LOG B2C
		exec cob_bvirtual..sp_b2c_registro_transacciones
			@s_ssn = @s_ssn,
			@s_lsrv = @s_lsrv,
			@s_date = @s_date,
			@i_tipo_tran = @t_trn,
			@i_login = @i_login
            
        select @w_aux3 = 'Banca Movil Password: '+ @i_clave
        
        -- Busqueda del cliente de la b2c con el login
        select @w_enteImg=lo_ente 
        from cob_bvirtual..bv_login 
        where lo_login = @i_login
        
        -- Busqueda del cliente cobis
        select @w_enteCobis=en_ente_mis 
        from cob_bvirtual..bv_ente 
        where en_ente = @w_enteImg
        
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
                                  when 'August' then 'Agosto'
                                  when 'September' then 'Septiembre' when 'October' then 'Octubre' 
                                  when 'November' then 'Noviembre' when 'December' then 'Diciembre' end)
        
        select @w_fecha_b =  @w_dia+'-'+@w_mes_es+'-'+@w_anio
	    
	    -- Seleccionar template si existiera
        select @w_id_template = te_id from cobis..ns_template where te_nombre = 'NotificacionGenerica.xslt'
        
        -- Creacion de un subject
        select @w_subject = 'Modificación de Contraseñas.'
		
		--Datos primer parrafo del body del correo
	    select @w_parraf_1 = 'Se ha realizado el cambio de contraseña para tu aplicación móvil Tuiio móvil.'
	    
	    --Datos segundo parrafo del body del correo
	    select @w_parraf_2 = 'Cuida tu información, evita compartir tus datos personales y contraseñas de tus cuentas a otras personas.'
        
        -- Creacion del body del correo
        --select @w_body = 'Estimado cliente,'+CHAR(13)+CHAR(10)+'Se actualizó con exito su clave de ingreso a Banca Virtual'
		select @w_body = '<?xml version=''1.0'' encoding=''ISO-8859-1''?><data><fechaDoc>'+@w_fecha_b+'</fechaDoc><nombreC>'+@w_nombreC+'</nombreC><parrafoDoc>'+@w_parraf_1+'</parrafoDoc><parrafoDoc2>'+@w_parraf_2+'</parrafoDoc2></data>'
		
		-- Ejecucion del sp para las notificaciones y envio de mail
          exec @w_error =  cobis..sp_despacho_ins
               @i_cliente          = @w_enteCobis,
               @i_template         = @w_id_template,
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
		
		delete from cob_bvirtual..bv_in_login 
		where il_login = @i_login
		
/*			
		exec @w_return  = cob_bvirtual..sp_bv_enviar_notif_ib
             @s_culture        = @s_culture,
             @s_date           = @s_date,
             @t_show_version   = 0,
             @i_servicio       = 1,
             @i_ente_ib        = @i_ente_ib,      --Codigo IB de cliente
             @i_notificacion   = 'N16',           --Codigo de la notificacion
             @i_producto       = 18,        --Codigo del producto
             @i_num_producto   = '',          --Numero del producto
             @i_tipo_mensaje   = 'F',    --Tipo de mensaje a enviar E-Mensaje de Error F-mensaje de finalizada correctamente la transaccion I-Mensaje para oficiales o funcionarios del banco
             @i_aux1           = 'aux1',
             @i_aux2           = 'aux2',
             @i_aux3           = @w_aux3,
             @i_login          = @i_login

             if @w_return <> 0
             begin
			    exec cobis..sp_cerror
                @t_from  = @w_sp_name,
                @i_num   = 1850309
                return 1850309 --ERROR AL ENVIAR EMAIL CON CLAVE TEMPORAL
             end
	*/
    end
    else
    begin
        exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 17025
        return 17025 --Clave temporal incorrecta
    end
end

return 0

go