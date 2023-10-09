use cob_bvirtual
go

if object_id('sp_imagen_seguridad') is not null
   drop proc sp_imagen_seguridad
go
/******************************************************************************/	 
/*	Archivo:bv_imagen_seguridad.sp			                                  */	                          
/*	Stored procedure: sp_imagen_seguridad  		                              */	                      
/*	Producto: BANCA VIRTUAL   			                                      */	                              
/******************************************************************************/ 
/*                     IMPORTANTE			                                  */                            
/*   Esta aplicacion es parte de los  paquetes bancarios                      */ 
/*   propiedad de MACOSA S.A.				                                  */                            
/*   Su uso no autorizado queda  expresamente  prohibido                      */ 
/*   asi como cualquier alteracion o agregado hecho  por                      */ 
/*   alguno de sus usuarios sin el debido consentimiento                      */ 
/*   por escrito de MACOSA.				                                      */ 
/*   Este programa esta protegido por la ley de derechos                      */ 
/*   de autor y por las convenciones  internacionales de                      */ 
/*   propiedad intelectual.  Su uso  no  autorizado dara                      */ 
/*   derecho a MACOSA para obtener ordenes  de secuestro                      */  	
/*   o  retencion  y  para  perseguir  penalmente a  los                      */ 
/*   autores de cualquier infraccion.			                              */ 
/******************************************************************************/  
/*                     PROPOSITO                                              */  
/*	Mantenimiento de imagen de seguridad				                      */
/******************************************************************************/
/*		    	 MODIFICACIONES			                                      */ 
/* FECHA	 	  VERSION        	AUTOR		           RAZON	          */ 
/* 05-Nov-2015	                 David Morla	     Emision inicial	      */ 
/* 06-Dic-2018	  4.4.0.5        Erica Ortega	     Emision inicial	      */
/* 03-Julio-2019                 Alexander Inca      Envio de correos         */
/* 18-Oct-2019                   Jonathan R          Agrega registro log B2C  */
/* 07-Feb-2022                   Sonia Rojas         Req #158566              */
/******************************************************************************/ 


Create Procedure sp_imagen_seguridad( 
	@s_ssn              int = null,
    @s_user             login = null, 
    @s_date             datetime = null, 
    @s_srv              varchar(30) = null, 
	@s_lsrv             varchar(30) = null,
    @s_ofi              smallint = null, 
    @s_term        		varchar(30) = null,
	@t_trn         		int      = null,
	@t_debug    		char(1)  = 'N',
    @t_file     		varchar(14) = null,
    @i_operacion		char(2) = 'Q',
	@i_login			varchar(64)=null,
	@i_imagen			varchar(max) = null,
	@i_alias			varchar(64) = null,
	@i_estado			char(1) = 'V',
    @i_firstTime        int            = 1,
    @i_login_migrado    varchar(64)    = null -- Identifica si el usuario es migrado cambio para FIE
)	
As 
declare 
@w_return       	  int,
@w_sp_name            varchar(30),
@w_imagen             varchar(max),
@w_id                 int,
@w_alias              varchar(64),
@w_count              int,
@w_leyenda			  varchar(150),
@w_telefono           varchar(30),
@w_enteImg            int,
@w_enteCobis          int,
@w_mail               varchar(255),
@w_id_template        int = 0,
@w_subject            varchar(100),
@w_body               varchar(500),
@w_error              int,
@w_msg                varchar(200),
@w_validador          varchar(1) = 'N',
@w_nombreC            varchar(250),
@w_anio               varchar(4),	
@w_mes_in			  varchar(15),
@w_mes_es			  varchar(15),
@w_dia 				  varchar(2),
@w_fecha_b            varchar(25),
@w_parraf_1           varchar(250),
@w_parraf_2           varchar(250),
@w_num_telf           varchar(10),
@w_plantilla          int,
@w_bloque             int
		
		
select @w_sp_name = 'sp_imagen_seguridad'

if @i_operacion = 'I'
begin 

    select @w_plantilla = pa_int
    from cobis..cl_parametro
    where pa_nemonico = 'IMGTPL'
    and   pa_producto = 'BVI'
    
    select @w_bloque = codigo 
    from cobis..cl_catalogo 
    where valor = 'NA'
    and   tabla = (select codigo from cobis..cl_tabla where tabla = 'ns_bloque_sms')
    
    if not exists(select 1 from bv_login_imagen where li_login = @i_login)
    begin
            if not exists(select 1 from bv_catg_img where ci_id = @i_imagen)
            begin
                exec cobis..sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @i_msg		 = "No existe registro de imagen seleccionada",
                @t_from     = @w_sp_name,
                @i_num      = 1850070
            end
            else
            begin
                select @w_imagen = ci_imagen 
                from bv_catg_img
                where ci_id = @i_imagen
                
                insert into bv_login_imagen (li_login,li_imagen,li_alias, li_estado )  
                values(@i_login, @w_imagen, @i_alias, 'V')
                
                if @@error != 0
                begin
                    exec cobis..sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @i_msg		 = "Error al ingresar imagen de Seguridad",
                    @t_from     = @w_sp_name,
                    @i_num      = 1850070
                end
                               
                -- Busqueda del cliente cobis
                select @w_enteCobis = te_ente 
                from cobis..cl_telefono 
                where te_valor = @i_login
                and   te_tipo_telefono = 'C'
                
                -- Ejecucion del sp para las notificaciones y envio de sms
                exec @w_return        = cobis..sp_despacho_ins
                @i_cliente            = @w_enteCobis,
                @i_servicio           = 8,--@i_canal,
                @i_estado             = 'P',
                @i_tipo               = 'SMS',
                @i_tipo_mensaje       = 'I',
                @i_prioridad          = 1,
                @i_from               = @i_login,
                @i_to                 = null,
                @i_cc                 = '',
                @i_bcc                = '',
                @i_subject            = 'Notificación Imagen de Seguridad',
                @i_body               = '',
                @i_content_manager    = 'TEXT',
                @i_retry              = 'N',
                @i_tries              = 0,
                @i_max_tries          = 0,
                @i_template			 = '',
                @i_var1               = @w_bloque, -- bloque
                @i_var2               = @w_plantilla, -- plantilla
                @i_var3               = @w_enteCobis, 
                @i_var4               = 'S' -- Si valida el buc o no
                                      	   
                if @w_error <> 0
                begin
                   select @w_msg = 'ERROR AL ENVIAR NOTIFICACION DE LA IMAGEN DEL CLIENTE'+convert(varchar(100),@w_enteCobis)
                   select @w_error = 5000   
                end	
            end
	end
	else
	begin       
		
		if @i_firstTime = 1   --Logeo por primera vez
		begin
			if not exists(select 1 from bv_catg_img where ci_id = @i_imagen)
				begin
				
					update bv_login_imagen
					set li_imagen = @i_imagen,
					li_alias  = @i_alias,
					li_estado = @i_estado
					where li_login=@i_login
					
					if @@error != 0
					begin
						exec cobis..sp_cerror
							@t_debug    = @t_debug,
							@t_file     = @t_file,
							@i_msg		 = "Error al Actualizar imagen de Seguridad",
							@t_from     = @w_sp_name,
							@i_num      = 1850070
					end		  
					
				end
			else
				begin
				     
                    if exists (select 1 from cob_bvirtual..bv_login_imagen where li_login = @i_login)
					begin
					   select @w_validador = 'S'
					   print 'Ingreso a revisar si tiene una imagen'
					end
					
					select @w_imagen = ci_imagen 
					from bv_catg_img
					where ci_id = @i_imagen

					update bv_login_imagen
					set li_imagen = @w_imagen,
					li_alias  = @i_alias,
					li_estado = @i_estado
					where li_login=@i_login
					
					if @@error != 0
					begin
					exec cobis..sp_cerror
						@t_debug    = @t_debug,
						@t_file     = @t_file,
						@i_msg		 = "Error al Actualizar imagen de Seguridad",
						@t_from     = @w_sp_name,
						@i_num      = 1850070
					end
					
					if @w_validador = 'S'
					begin				  
					   
					   -- Busqueda del cliente de la b2c con el login
                       select @w_enteImg=lo_ente 
                       from cob_bvirtual..bv_login 
                       where lo_login = @i_login
                       
                       -- Busqueda del cliente cobis
                       select @w_enteCobis=en_ente_mis 
                       from cob_bvirtual..bv_ente 
                       where en_ente = @w_enteImg
                       
                       --Comentado por cambio SMS (158566): Busqueda direccion cliente cobis
                       --select @w_mail=di_descripcion
                       --from cobis..cl_direccion
                       --where di_ente = @w_enteCobis
                       --and di_tipo = 'CE'
                       
                       -- Busqueda telefono cliente cobis
                       
                       select top 1 
                       @w_num_telf = te_valor 
                       from cobis..cl_telefono
                       where te_ente = @w_enteCobis
                       and te_tipo_telefono = 'C'
                       order by te_direccion, te_secuencial
                       
                       /*Comentado por cambio SMS (158566)*/
                       -- Consulta nombre del cliente
                       -- select @w_nombreC = isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') + ' '+isnull(p_p_apellido,'') +' '+ isnull(p_s_apellido,'')
                       -- from cobis..cl_ente
                       -- where en_ente = @w_enteCobis
                       
                       -- Obtener fecha para body del correo
                       -- select @w_anio = LTRIM(RTRIM(convert(varchar,DATENAME(yyyy,getdate()))))
                       -- select @w_mes_in  = LTRIM(RTRIM(convert(varchar,DATENAME(mm,getdate()))))
                       -- select @w_dia  = LTRIM(RTRIM(convert(varchar,DATENAME(dd,getdate()))))
                       -- 
                       -- select @w_mes_es = (case @w_mes_in when 'January' then 'Enero' 
                       --                           when 'February' then 'Febrero' when 'March' then 'Marzo' 
                       --                           when 'April' then 'Abril' when 'May' then 'Mayo' 
                       --                           when 'June' then 'Junio' when 'July' then 'Julio' 
                       --                           when 'August' then 'Agosto'
                       --                           when 'September' then 'Septiembre' when 'October' then 'Octubre' 
                       --                           when 'November' then 'Noviembre' when 'December' then 'Diciembre' end)
                       -- 
                       --select @w_fecha_b =  @w_dia+'-'+@w_mes_es+'-'+@w_anio
                       
                       -- Seleccionar template si existiera
                       --select @w_id_template = te_id from cobis..ns_template where te_nombre = 'NotificacionGenerica.xslt'
                       
                       -- Creacion de un subject
                       --select @w_subject = 'Modificacion del mensaje e imagen de Bienvenida.'
                       
                       --Datos primer parrafo del body del correo
                       --select @w_parraf_1 = 'Se cambio la imagen de bienvenida de tu aplicacion Tuiio movil.'
                       
                       -- Creacion del body del correo
                       --select @w_body = 'Estimado cliente,'+CHAR(13)+CHAR(10)+'Se actualizo con exito su mensaje e imagen de Bienvenida'
                       --select @w_body = '<?xml version=''1.0'' encoding=''ISO-8859-1''?><data><fechaDoc>'+@w_fecha_b+'</fechaDoc><nombreC>'+@w_nombreC+'</nombreC><parrafoDoc>'+@w_parraf_1+'</parrafoDoc></data>'
                       
                       -- Ejecucion del sp para las notificaciones y envio de sms
                       exec @w_return        = cobis..sp_despacho_ins
                       @i_cliente            = @w_enteCobis,
                       @i_servicio           = 8,--@i_canal,
                       @i_estado             = 'P',
                       @i_tipo               = 'SMS',
                       @i_tipo_mensaje       = 'I',
                       @i_prioridad          = 1,
                       @i_from               = @w_num_telf,
                       @i_to                 = null,
                       @i_cc                 = '',
                       @i_bcc                = '',
                       @i_subject            = 'Notificación Imagen de Seguridad',
                       @i_body               = '',
                       @i_content_manager    = 'TEXT',
                       @i_retry              = 'N',
                       @i_tries              = 0,
                       @i_max_tries          = 0,
                       @i_template			 = '',
                       @i_var1               = @w_bloque, -- bloque
                       @i_var2               = @w_plantilla, -- plantilla
                       @i_var3               = @w_enteCobis, 
                       @i_var4               = 'S' -- Si valida el buc o no
                           
                       if @w_error <> 0
                       begin
                          select @w_msg = 'ERROR AL ENVIAR NOTIFICACION DE LA IMAGEN DEL CLIENTE'+convert(varchar(100),@w_enteCobis)
                          select @w_error = 5000   
                       end
                   end
                end
                -- REGISTRO LOG B2C
                exec cob_bvirtual..sp_b2c_registro_transacciones
                @s_ssn = @s_ssn,
                @s_lsrv = @s_lsrv,
                @s_date = @s_date,
                @i_tipo_tran = @t_trn,
                @i_login = @i_login
         end
         else
            exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @i_msg		 = "Ya existe una imagen de Seguridad ingresada",
            @t_from     = @w_sp_name,
            @i_num      = 1850070
    end
    
    --Validacion para login Migrado FIE
    if @i_login_migrado = 'IMAGEN'
    begin
        update bv_login
        set lo_origen = 'PREGUNT'
        where lo_login = @i_login 
        --and lo_servicio = @w_servicio
        --and lo_ente = @w_grupo_cliente 
    end
end 

if @i_operacion = 'U'
	begin 
		-- OBTENER IMAGEN 			
		select @w_imagen = ci_imagen 
		from bv_catg_img
		where ci_id = @i_imagen
		
		if @@rowcount = 0
		begin
			exec cobis..sp_cerror
				@t_debug    = @t_debug,
				@t_file     = @t_file,
				@i_msg		= "Error al obtener imagen de seguridad",
				@t_from     = @w_sp_name,
				@i_num      = 1850071
			return 1850071	
		end
  
		update bv_login_imagen
		set li_imagen  = @w_imagen,
			li_alias   = @i_alias,
			li_estado  = @i_estado
		where li_login = @i_login
		
		if @@rowcount=0
		begin
			exec cobis..sp_cerror
				 @t_debug    = @t_debug,
				 @t_file     = @t_file,
				 @t_from     = @w_sp_name,
				 @i_num      = 1850070
		end
	end 

if @i_operacion = 'Q' 
begin
    if exists(select 1 from bv_login_imagen where li_login = @i_login and li_estado = 'V')
	begin
	    select @w_telefono = pa_char
		from cobis..cl_parametro
		where pa_nemonico = 'TLSC'
		and pa_producto   = 'BVI'
		
		select @w_leyenda = 'Si usted no reconoce la imagen y/o frase de bienvenida favor de comunicarse al servicio de atención TUIIO ' + @w_telefono

		select 	li_imagen, li_alias, li_estado, @w_leyenda
		from bv_login_imagen
		where li_login 	= @i_login
		and   li_estado = 'V'
	end
	else
	begin
		select null,'Registra tu imagen y frase de bienvenida en el menú de configuración',null,null
	end	
end 


--Carga de Imagen Personal UX
if @i_operacion = 'P'
begin
   select li_imagen_personal
   from bv_login_imagen
   where li_login  = @i_login
   and   li_estado = 'V' 
end

--Actualizar Imagen Personal
if @i_operacion = 'PU'
begin
   update bv_login_imagen set li_imagen_personal = @i_imagen
   where li_login  = @i_login
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 1850070
   end
end

--Cargar Logo para cliente juridico
if @i_operacion = 'L'
begin
   select li_imagen_logo
   from bv_login_imagen, bv_login
   where li_login           = lo_login
   and lo_tipo_autorizacion = 'T' 
   and lo_servicio          = 1
   and li_estado            = 'V' 
   and lo_ente              = (select lo_ente 
                               from bv_login 
                               where lo_login = @i_login
							   and lo_servicio = 1)
end		

--Cargar Imagen para UX
if @i_operacion = 'G'
begin
   --Tabla temporal ID
   create table #tempid(id     int,
                        imagen varchar(max),				    	   
	     		        alias  varchar(64)) 
   
   if @i_firstTime = 0   --Logeo por primera vez
   begin 				   
      --Cargar imagen del cliente
      select @w_imagen = li_imagen,
             @w_alias  = li_alias
      from bv_login_imagen
      where li_login  = @i_login
      and   li_estado = 'V'
   
      --Obtener id del cliente
      select @w_id = ci_id
      from bv_catg_img
      where ci_imagen = @w_imagen 
      if @@rowcount = 0
	  begin
	     select @w_count = max(ci_id) + 1
		 from bv_catg_img
		 
		 insert into bv_catg_img values(@w_count, @w_imagen, convert(varchar(64), @w_count),'V')
		 select @w_id = @w_count
	  end
	  
      set rowcount 5
	  insert into #tempid(id, imagen, alias)
      select ci_id,
	         ci_imagen,			 
			 null
      from bv_catg_img
	  where ci_id <> @w_id
	  and ci_estado = 'V'
      order by newid()   
	  
	  insert into #tempid(id, imagen, alias)
	  select @w_id,
	         @w_imagen,
			 @w_alias
   end
   else
   begin
      set rowcount 6	  
	  insert into #tempid(id, imagen, alias)
      select ci_id,
	         ci_imagen,			 
			 null
      from bv_catg_img	 
	  where ci_estado = 'V'
      order by newid()
   end
   
   set rowcount 8
   select id,
          imagen,		
		  alias
   from #tempid			  
end

return 0 
go