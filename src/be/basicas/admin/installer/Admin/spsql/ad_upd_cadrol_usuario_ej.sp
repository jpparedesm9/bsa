/************************************************************************/
/*  Archivo:            ad_upd_cadrol_usuario_ej.sp                     */
/*  Stored procedure:   sp_upd_cadrol_usuario_ej                        */
/*  Base de datos:      cobis                                     		*/      
/*  Producto: 			Admin Batch                            		    */
/*  Disenado por:  		Edison Andrade      							*/
/*  Fecha de escritura: 24-May-2012                                     */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  Cobiscorp. Su uso no autorizado queda expresamente prohibido        */
/*  asi como cualquier alteracion o agregado hecho por alguno de        */
/*  sus usuarios sin el debido consentimiento por escrito de la         */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/
/*              PROPOSITO                                               */
/* Este programa realiza la actualizacion masiva de fechas de caducidad */
/* a roles de funcionario HSBC Costa Rica								*/
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  11-03-2016  BBO         Migracion Sybase-Sqlserver FAL              */
/************************************************************************/
use cobis
GO

if exists (select 1 from sysobjects where name = 'sp_upd_cadrol_usuario_ej')
   drop proc sp_upd_cadrol_usuario_ej
GO

create proc sp_upd_cadrol_usuario_ej(
	@s_ssn          	int	    	= null,
	@s_user         	login       = null,
	@s_term         	varchar(30) = null,
	@s_date         	datetime    = null,
	@s_srv          	varchar(30) = null,
	@s_lsrv         	varchar(30) = null,
	@s_ofi          	smallint    = NULL,
	@s_rol          	smallint    = NULL,
	@s_org_err      	char(1)     = NULL,
	@s_error        	int         = NULL,
	@s_sev         		tinyint     = NULL,
	@s_msg          	descripcion = NULL,
	@s_org          	char(1)     = NULL,
	@t_from         	varchar(32) = null,
	@t_trn          	int         = null,
	@t_show_version		bit 	    = 0, 		-- Mostrar la version del programa
	@t_file             varchar(14) = null,
  	@t_debug            char(1)     = 'N',	
	@i_filial 			tinyint		,
	@i_fecha 			datetime 	,		
	@i_sarta 			int 		= null,
	@i_batch 			int 		= null,
	@i_secuencial 		int 		= null,
	@i_corrida 			int 		= null,
	@i_intento 			int 		= null,
	@i_path_sapp        varchar(255)

)
as
declare
	@w_error	  		int,
	@w_sp_name      	varchar(32), -- Nombre stored proc
	@w_today      		datetime,    
	@w_servidor			varchar(24),
	@w_login            varchar(30),
	@w_fecha_cad		datetime,
	@w_rol			    tinyint,
	@w_retorno		    int,
	@w_retorno_ej		int,
	@w_flag				int,
	@w_tipo_horario     tinyint,
	@w_fecha_ini_rol    datetime, 
	@w_patharch			varchar(30),
	@w_archivo1			varchar(255),
	@w_cmd				varchar (255),
	@w_mensaje			varchar (60),
	@w_ssn				int,
	@w_secuencial		int,
	@w_mes				char (2),
	@w_dia				char (2),
	@w_anio				char (4),
	
	@w_bcp_cmdfile      varchar(255),  -- JSA 08/10/2012 Configuracion BCP
	@w_bcp_cmdpath      varchar(255)   -- JSA 08/10/2012 Configuracion BCP

select @w_today = getdate()
select @w_sp_name = 'sp_upd_cadrol_usuario_ej'


-------------------- CREAR TABLA TEMPORAL --------------------
-- JSA 09102012 Creacion tabla fisica
if object_id('tmp_usuarios_rol') is not null
begin
  drop table tmp_usuarios_rol
  if object_id('tmp_usuarios_rol') is not null
  begin
    print 'FALLO BORRADO DE TABLA tmp_usuarios_rol'
  end
end

create table tmp_usuarios_rol(
	login      varchar(30)  not null,
	rol        tinyint      not null,
	fecha_cad  datetime     not null
)

---- VERSIONAMIENTO DEL PROGRAMA ----
if @t_show_version = 1
begin
    print 'Stored procedure sp_upd_cadrol_usuario_ej, Version 4.0.0.0'
    return 0
end

if not exists (select 1 from cobis..cl_filial 
                where fi_filial = @i_filial)
begin    
	exec @w_retorno_ej    = cobis..sp_ba_error_log
         @i_sarta         = @i_sarta,
         @i_batch         = @i_batch,
         @i_secuencial    = @i_secuencial,
         @i_corrida       = @i_corrida,
         @i_intento       = @i_intento,
         @i_error         = 101002,
         @i_detalle       = 'ERROR: No existe la filial'
        
	if @w_retorno_ej > 0
	begin        
    	return @w_retorno_ej
	end
	else
	begin
    	return 101002
	end
end

-- obtener el nombre del servidor de ejecucion 
select @w_servidor = ba_serv_destino
from  cobis..ba_batch
where ba_batch = @i_batch

-- Obtener el path de archivos de contabilidad 
select @w_patharch = pa_char 
from cobis..cl_parametro 
where pa_producto = 'CON'
and pa_nemonico='RUARC'

-- JSA 08102012
-- Obtener path de archivos cmd
select @w_bcp_cmdpath = pa_char
from cobis..cl_parametro
where pa_nemonico = 'PACMD'
and   pa_producto = 'ADM'


-------------------- BCP DE CARGA DE ARCHIVO --------------------
if datepart(mm, @i_fecha) < 10
   select @w_mes  = '0' + convert(char(1), datepart(mm, @i_fecha))
else
   select @w_mes  = convert(char(2), datepart(mm, @i_fecha))
   
if datepart(day,@i_fecha) < 10
   select @w_dia  = '0' + convert(char(1), datepart(day, @i_fecha))
else
   select @w_dia  = convert(char(2), datepart(day, @i_fecha))

select @w_anio = convert(char(4), datepart(yy, @i_fecha))

-- JSA 09102012
-- Configuracion BCP
--select @w_bcp_cmdfile = @w_bcp_cmdpath + 'xsapp.cmd'

select @w_archivo1 = @w_patharch + 'upd_cad_rol_usuario_'+ @w_mes + @w_dia + @w_anio + '.txt'

--select @w_cmd = @w_bcp_cmdfile + ' ' + 'cobis..tmp_usuarios_rol in' + ' ' + @w_archivo1  + ' ' + @w_bcp_cmdpath + ' ' + '\t'

--select @w_cmd = 's_app.exe bcp -auto -login temp..tmp_usuarios_rol in ' + '"' + @w_archivo1  + '"' + ' -c'

--exec @w_retorno = master..xp_cmdshell @w_cmd

if patindex ('%Windows%', @@version) <> 0 --Si la version del Sistema Operativo es Windows
    select @w_cmd  = @i_path_sapp + 's_app bcp -auto -login cobis..tmp_usuarios_rol in ' + @w_archivo1 + ' -c -t \t'
else
    select @w_cmd  = @i_path_sapp + 's_app bcp -auto cobis..tmp_usuarios_rol in ' + @w_archivo1 + ' -c -t \\t'
         
exec @w_error = master..xp_cmdshell @w_cmd

if @@error != 0
begin
  return 190031 --ERROR EN LA EJECUCION DEL PROCESO
end   

if @w_retorno > 0
begin
	select @w_mensaje = 'ERROR EJECUCION: No se encuentra el archivo de carga: ' + @w_archivo1
	
	exec @w_retorno_ej = cobis..sp_ba_error_log
         @i_sarta      = @i_sarta,
         @i_batch      = @i_batch,
         @i_secuencial = @i_secuencial,
         @i_corrida    = @i_corrida,
         @i_intento    = @i_intento,
         @i_error      = @w_retorno,
         @i_detalle    = @w_mensaje

	if @w_retorno_ej > 0
  	begin        
		return @w_retorno_ej 
	end
	else	
	begin		
		return @w_retorno
	end
end

------------------- Obtener el secuencial SSN ------------------
exec @w_ssn = ADMIN...rp_ssn	
select @w_ssn = isnull(@w_ssn,0)

begin tran
------------------- CURSOR tmp_usuarios_rol --------------------

declare user_rol cursor for
	select login, rol, fecha_cad
	from tmp_usuarios_rol -- JSA 09102012 #tmp_usuarios_rol
     
open user_rol

fetch user_rol into
	  @w_login,
      @w_rol,
      @w_fecha_cad

if (@@fetch_status = -1)  --sqlstatus: mig syb-sqls 11032016
begin
    close user_rol          --mig syb-sqls 11032016
    deallocate user_rol     --mig syb-sqls 11032016
    
    -- Error al abrir un cursor --
    exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 2101028
    return 2101028
end
      
while @@fetch_status = 0    --sqlstatus: mig syb-sqls 11032016
begin
	
	select @w_flag = 1
	
	if not exists(select 1 from cobis..cl_funcionario where fu_login = @w_login)
	begin
	
		select @w_secuencial = isnull(max(eb_secuencial_error),0) + 1 from cobis..ad_error_batch where eb_fecha_proceso = @i_fecha
		
		insert ad_error_batch (eb_secuencial_error, eb_fecha_proceso, eb_sarta,     eb_batch,
		                 eb_secuencial,       eb_corrida,       eb_intento,   eb_fecha_error,
		                 eb_msj_error,        eb_detalle)
		          values(@w_secuencial,       @i_fecha,         @i_sarta,     @i_batch,
		                 @i_secuencial,       @i_corrida,       @i_intento,   getdate(),
		                 'Login no existe: ' + @w_login,  'Error sp_upd_cadrol_usuario_ej.. Login no existe tabla cobis..cl_funcionario')
		if @@error  <> 0
    	begin
	         -- Error, en la insercion de registro
	         exec cobis..sp_cerror   
	         @t_debug = @t_debug,
	         @t_file  = @t_file,
	         @t_from  = @w_sp_name,
	         @i_num   = 3603012
	         return 3603012
    	end
                          
		select @w_flag = 0
	end
   
	if not exists(select 1 from cobis..ad_rol where ro_rol = @w_rol)
	begin
	
	  	select @w_secuencial = isnull(max(eb_secuencial_error),0) + 1 from cobis..ad_error_batch where eb_fecha_proceso = @i_fecha
		
		insert ad_error_batch (eb_secuencial_error, eb_fecha_proceso, eb_sarta,     eb_batch,
		                 eb_secuencial,       eb_corrida,       eb_intento,   eb_fecha_error,
		                 eb_msj_error,        eb_detalle)
		          values(@w_secuencial,       @i_fecha,         @i_sarta,     @i_batch,
		                 @i_secuencial,       @i_corrida,       @i_intento,   getdate(),
		                 'Rol no existe: ' + convert(varchar(3),@w_rol),  'Error sp_upd_cadrol_usuario_ej.. Rol no existe tabla cobis..ad_rol')
		if @@error  <> 0
    	begin
	         -- Error, en la insercion de registro
	         exec cobis..sp_cerror   
	         @t_debug = @t_debug,
	         @t_file  = @t_file,
	         @t_from  = @w_sp_name,
	         @i_num   = 3603012
	         return 3603012
    	end
    	
       select @w_flag = 0
	end
   
	if not exists(select 1 from cobis..ad_usuario where us_login = @w_login)
	begin
		select @w_secuencial = isnull(max(eb_secuencial_error),0) + 1 from cobis..ad_error_batch where eb_fecha_proceso = @i_fecha
		
		insert ad_error_batch (eb_secuencial_error, eb_fecha_proceso, eb_sarta,     eb_batch,
		                 eb_secuencial,       eb_corrida,       eb_intento,   eb_fecha_error,
		                 eb_msj_error,        eb_detalle)
		          values(@w_secuencial,       @i_fecha,         @i_sarta,     @i_batch,
		                 @i_secuencial,       @i_corrida,       @i_intento,   getdate(),
		                 'Rol no esta asociado a login: ' + @w_login,  'Error sp_upd_cadrol_usuario_ej.. Rol no esta asociado a login tabla cobis..ad_usuario')
		if @@error  <> 0
    	begin
	         -- Error, en la insercion de registro
	         exec cobis..sp_cerror   
	         @t_debug = @t_debug,
	         @t_file  = @t_file,
	         @t_from  = @w_sp_name,
	         @i_num   = 3603012
	         return 3603012
    	end
    	
       select @w_flag = 0
	end
	
	
	if @w_flag = 1
	begin
		select @w_tipo_horario  = ur_tipo_horario, 
		       @w_fecha_ini_rol = ur_fecha_ini_rol
		from cobis..ad_usuario_rol 
		where ur_login = @w_login
		  and ur_rol = @w_rol
      
		exec @w_retorno = cobis..sp_usuario_rol
			 @s_ssn   	      = @w_ssn,
			 @s_user  	      = 'sa',
			 @s_term  	      = 'consola',
			 @s_date  	      = @i_fecha,
			 @s_srv           = @w_servidor,
			 @s_lsrv          = @w_servidor,
			 @s_ofi           = 1,
			 @t_trn           = 571,
			 @i_operacion     = 'U',
			 @i_autorizante   = 1, -- sa
			 @i_fecha_aut	  = @w_today,
			 @i_login 	      = @w_login,
			 @i_rol 	      = @w_rol,
			 @i_tipoh         = @w_tipo_horario,
			 @i_fecha_ini_rol = @w_fecha_ini_rol,
			 @i_fec_cad_rol   = @w_fecha_cad
			 
		IF @w_retorno > 0
		BEGIN
			
	        exec @w_retorno_ej = cobis..sp_ba_error_log
		         @i_sarta      = @i_sarta,
		         @i_batch      = @i_batch,
		         @i_secuencial = @i_secuencial,
		         @i_corrida    = @i_corrida,
		         @i_intento    = @i_intento,
		         @i_error      = @w_retorno,
		         @i_detalle    = 'ERROR EJECUCION: sp_usuario_rol'
		         
		    IF @w_retorno_ej > 0
	  	    BEGIN 
			    return @w_retorno_ej 
	        END
	        ELSE
	        BEGIN
	            return @w_retorno
	        END
   		END

		exec @w_retorno = cobis..sp_usuario_rol_hsbc
		   	 @s_ssn   	      = @w_ssn,
			 @s_user  	      = 'sa',
			 @s_term  	      = 'consola',
			 @s_date  	      = @i_fecha,
			 @s_srv           = @w_servidor,
			 @s_lsrv          = @w_servidor,
			 @s_ofi           = 1,
			 @t_trn           = 571,
			 @i_operacion     = 'U',
			 @i_autorizante   = 1, -- sa
			 @i_fecha_aut	  = @w_today,
			 @i_login 	      = @w_login,
			 @i_rol 	      = @w_rol,
			 @i_tipoh         = @w_tipo_horario,
			 @i_fecha_ini_rol = @w_fecha_ini_rol,
			 @i_fec_cad_rol   = @w_fecha_cad
			 	 
		IF @w_retorno > 0
		BEGIN     
	        exec @w_retorno_ej = cobis..sp_ba_error_log
		         @i_sarta      = @i_sarta,
		         @i_batch      = @i_batch,
		         @i_secuencial = @i_secuencial,
		         @i_corrida    = @i_corrida,
		         @i_intento    = @i_intento,
		         @i_error      = @w_retorno,
		         @i_detalle    = 'ERROR EJECUCION: sp_usuario_rol_hsbc'
		         
		    IF @w_retorno_ej > 0
	  	    BEGIN 
			    return @w_retorno_ej 
	        END
	        ELSE
	        BEGIN
	            return @w_retorno
	        END
   		END
			
	end	--if @w_flag = 1
		

	fetch user_rol into
	      @w_login,
          @w_rol,
          @w_fecha_cad
    
    select @w_ssn = @w_ssn + 1
    
end --while

close user_rol
deallocate user_rol

commit tran

drop table tmp_usuarios_rol

return 0


GO

