/*************************************************************************/
/*   Archivo:            sp_negocio_cliente.sp                           */
/*   Stored procedure:   sp_negocio_cliente                              */
/*   Base de datos:      cobis                                           */
/*   Producto:           Prestamos Grupales                              */
/*   Disenado por:       Milton Custode                                  */
/*   Fecha de escritura: 20/04/2017                                      */
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
/*     I            Creación de un negocio de un cliente                 */
/*     U            Actualización de un negocio de un cliente            */
/*     D            Eliminación de un negocio de un cliente              */
/*     S            Listado de los negocio de un cliente                 */
/*     Q            Consulta de un negocio de un cliente                 */
/*    I,U           Agregar/actualizar teléfono en direcciones           */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA        AUTOR                       RAZON                      */
/*   08-04-2017   Milton Custode              Versión Inicial            */
/*	 15-06-2017   Paúl Ortiz                  Agregado de búsqueda 'H'   */
/*	 15-06-2017   Paúl Ortiz                  Agregado Destino Credito   */
/*	 17-08-2017   Paúl Ortiz                  Actualización a Clientes   */
/*	 04-09-2017   Paúl Ortiz                  Teléfono en direcciones    */
/*************************************************************************/
use cobis
go
if object_id ('sp_negocio_cliente') is not null
	drop procedure sp_negocio_cliente
go
create proc sp_negocio_cliente (
   @s_ssn             int         = null,
   @s_user            login       = null,
   @s_term            varchar(32) = null,
   @s_date            datetime    = null,
   @s_sesn            int         = null,
   @s_culture         varchar(10) = null,
   @s_srv             varchar(30) = null,
   @s_lsrv            varchar(30) = null,
   @s_ofi             smallint    = null,
   @s_rol             smallint    = NULL,
   @s_org_err         char(1)     = NULL,
   @s_error           int         = NULL,
   @s_sev             tinyint     = NULL,
   @s_msg             descripcion = NULL,
   @s_org             char(1)     = NULL,
   @t_debug           char(1)     = 'N',
   @t_file            varchar(10) = null,
   @t_from            varchar(32) = null,
   @t_trn             int         = null,
   @t_show_version    bit         = 0,
   @i_operacion       char(1),
   @i_codigo          int         = null,
   @i_ente            int         = null,
   @i_nombre          varchar(60) = null,
   @i_giro            varchar(10) = null,
   @i_fecha_apertura  datetime    = null,
   @i_calle           varchar(80) = null,
   @i_nro             int         = null,
   @i_colonia         varchar(10) = null,
   @i_localidad       varchar(10) = null,
   @i_municipio       varchar(10) = null,
   @i_estado          varchar(10) = null,
   @i_codpostal       varchar(30) = null,
   @i_pais            varchar(10) = null,
   @i_telefono        varchar(20) = null,
   @i_actividad_ec    varchar(10) = null,
   @i_tiempo_activida int         = null,
   @i_tiempo_dom_neg  int         = null,
   @i_emprendedor     char(1)     = null,
   @i_recurso         varchar(10) = null,
   @i_ingreso_mensual money       = null,
   @i_tipo_local      varchar(10) = null,
   @i_estado_reg      char(10)    = null,
   @i_destino_credito varchar(10) = null,
   @i_canal           varchar(30) = null,
   @i_otro_recurso    varchar(30) = null,
   @o_codigo          int         = null  output,
   @o_telefono_id     int         = null  output
)as
declare 
   @w_ts_name         varchar(32),
   @w_num_error       int,
   @w_sp_name         varchar(32),
   @w_codigo          int,
   @w_ente            int,
   @w_nombre          varchar(60),
   @w_giro            varchar(10),
   @w_fecha_apertura  datetime,
   @w_calle           varchar(80),
   @w_nro             int,
   @w_colonia         varchar(10),
   @w_localidad       varchar(10),
   @w_municipio       varchar(10),
   @w_estado          varchar(10),
   @w_codpostal       varchar(30),
   @w_pais            varchar(10),
   @w_telefono        varchar(20),
   @w_actividad_ec    varchar(10),
   @w_tiempo_activida int,
   @w_tiempo_dom_neg  int,
   @w_emprendedor     char(1),
   @w_recurso         varchar(10),
   @w_ingreso_mensual money,
   @w_tipo_local      varchar(10),
   @w_otro_recurso    varchar(30),
   @w_estado_reg      char(10),
   @w_param_emprede   int,          --variable de tiempo para ser emprendedor
   @w_diff_dias       int,
   @w_destino_credito varchar(10),
   @w_direccion       int,
   @w_cod_area        int,
   @w_len             int,
   @w_secuencial      int,
   @w_telefono_aux    varchar(20),
   @w_telefono_id     int,
   @w_error           int
   
select @w_sp_name = 'sp_negocio_cliente'

   -- Validar codigo de transacciones --
if ((@t_trn <> 1709 and @i_operacion = 'I') or
    (@t_trn <> 1710 and @i_operacion = 'U') or
    (@t_trn <> 1711 and @i_operacion = 'D') or
    (@t_trn <> 1712 and (@i_operacion = 'S' or @i_operacion = 'Q' or @i_operacion = 'H')))
begin
   select @w_num_error = 151051 --Transaccion no permitida
   goto errores
end
--validacion para distinguir emprendedor
if @i_operacion in ('I', 'U')
begin
   select @w_param_emprede = pa_smallint from cl_parametro where  pa_nemonico = 'NDEP' and pa_producto = 'MIS'
   select @w_diff_dias =  datediff(mm, @i_fecha_apertura, (select fp_fecha from ba_fecha_proceso))
   if @w_diff_dias <= @w_param_emprede
      select @w_emprendedor = 'S'
   else
      select @w_emprendedor = 'N'
end

if @i_operacion = 'I'
begin
    begin tran
    exec @w_num_error = cobis..sp_cseqnos
   @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_negocio_cliente',
        @o_siguiente = @w_codigo out
        
    select @o_codigo = @w_codigo
       

        if @w_num_error <> 0
        begin
            select @w_num_error = 2101007 --NO EXISTE TABLA EN TABLA DE SECUENCIALES
            goto errores
        end
    
    if(@s_ofi = 9001) --Es el movil
    begin
    	
    	SELECT TOP 1 @w_direccion = di_direccion FROM cobis..cl_direccion 
    	WHERE di_ente = @i_ente
    	AND di_tipo = 'AE'
    	
    	
    	SELECT @w_len = len(@i_telefono)
    	SELECT @w_len = @w_len - 9      
    	
    	SELECT @w_cod_area = substring(@i_telefono,0,@w_len)
    	
    	SELECT @w_telefono_aux = RIGHT(@i_telefono, 10)--substring(@i_telefono,4,12)
    	
    	--PRINT @w_len
    	--PRINT @w_cod_area
    	--PRINT @i_telefono
    	
    	if exists(select 1 from cl_telefono where te_ente = @i_ente 
			and te_direccion = @w_direccion and te_tipo_telefono = 'D' and te_valor = @w_telefono_aux)
    	begin
			select top 1 @w_secuencial = te_secuencial from cl_telefono where te_ente = @i_ente 
			and te_direccion = @w_direccion and te_tipo_telefono = 'D' and te_valor = @w_telefono_aux
		end
		
		if (@w_secuencial is not null)
		begin
		
			exec @w_error    = cobis..sp_telefono 
			@i_ente          = @i_ente,
			@i_direccion     = @w_direccion,
			@i_secuencial    = @w_secuencial,
			@i_valor         = @w_telefono_aux,
			@i_tipo_telefono = 'D',
			@i_cod_area      = @w_cod_area,
			@i_canal         = @i_canal,
			@t_trn           = 112,               --Update en telefonos
			@i_operacion     = 'U',
			@s_srv           = @s_srv,
			@s_user          = @s_user,
			@s_term          = @s_term,
			@s_ofi           = @s_ofi,
			@s_rol           = @s_rol,
			@s_ssn           = @s_ssn,
			@s_lsrv          = @s_lsrv,
			@s_date          = @s_date,
			@s_sesn          = @s_sesn,
			@s_org           = @s_org
			
			if @@error <> 0 or @w_error = 0
	        begin
	           exec sp_cerror
	                @t_debug        = @t_debug,
	                @t_file         = @t_file,
	                @t_from         = @w_sp_name,
	                @i_num          = 105035 --'Error en creacion de telefono'
	           return 105035
	        end
    		
			/* Reasigno para no perder valores en mobile */
    		select @o_telefono_id = @w_secuencial
    		
    	end
    	else
    	begin
    		
    		EXEC @w_error     = cobis..sp_telefono 
			@i_ente           = @i_ente,
			@i_direccion      = @w_direccion,
			@i_valor          = @w_telefono_aux,
			@i_tipo_telefono  = 'D',
			@i_cod_area       = @w_cod_area,
			@t_trn            = 111,               --Insert en telefonos
			@i_operacion      = 'I',
			@i_canal          = @i_canal,
			@s_srv            = @s_srv,
			@s_user           = @s_user,
			@s_term           = @s_term,
			@s_ofi            = @s_ofi,
			@s_rol            = @s_rol,
			@s_ssn            = @s_ssn,
			@s_lsrv           = @s_lsrv,
			@s_date           = @s_date,
			@s_sesn           = @s_sesn,
			@s_org            = @s_org
			
			
			if @@error <> 0 or @w_error <> 0
	        begin
	           exec sp_cerror
	                @t_debug        = @t_debug,
	                @t_file         = @t_file,
	                @t_from         = @w_sp_name,
	                @i_num          = 103038 --Error en creacion de telefono
	           return 103038
	        end
			
	    	/* Envio código de telefono */
			select @o_telefono_id = te_secuencial
			from cobis..cl_telefono 
			where te_ente = @i_ente
			and te_direccion = @w_direccion
			and te_valor = @w_telefono_aux
			and te_tipo_telefono = 'D'
    		
    	end
    	
    end
    
    
    insert into cl_negocio_cliente(
    nc_codigo,          nc_ente,            nc_nombre,         nc_giro,                nc_fecha_apertura,      nc_calle,
    nc_nro,             nc_colonia,         nc_localidad,      nc_municipio,           nc_estado,              nc_codpostal,
    nc_pais,            nc_telefono,        nc_actividad_ec,   nc_tiempo_actividad,    nc_tiempo_dom_neg,      nc_emprendedor,
    nc_recurso,         nc_ingreso_mensual, nc_tipo_local,     nc_estado_reg,          nc_destino_credito,     nc_otro_recurso)
    values(
    @w_codigo,          @i_ente,            @i_nombre,         @i_giro,                @i_fecha_apertura,      @i_calle,
    @i_nro,             @i_colonia,         @i_localidad,      @i_municipio,           @i_estado,              @i_codpostal,
    @i_pais,            @i_telefono,        @i_actividad_ec,   @i_tiempo_activida,     @i_tiempo_dom_neg,      @w_emprendedor,
    @i_recurso,         @i_ingreso_mensual, @i_tipo_local,     'V',                    @i_destino_credito,     @i_otro_recurso)
    if @@error <> 0
      begin   
         select @w_num_error = 108003 --ERROR AL INSERTAR NEGOCIO DEL CLIENTE!
         goto errores
      end
    
    insert into ts_negocio_cliente(
    ts_secuencial,      ts_codigo,          ts_ente,            ts_nombre,            ts_giro,                ts_fecha_apertura,
    ts_calle,           ts_nro,             ts_colonia,         ts_localidad,         ts_municipio,           ts_estado,
    ts_codpostal,       ts_pais,            ts_telefono,        ts_actividad_ec,      ts_tiempo_actividad,    ts_tiempo_dom_neg,
    ts_emprendedor,     ts_recurso,         ts_ingreso_mensual, ts_tipo_local,        ts_usuario,             ts_oficina,
    ts_fecha_proceso,   ts_operacion,       ts_estado_reg,      ts_destino_credito,   ts_hora,                ts_canal,
	ts_otro_recurso)
    values (
    @s_sesn,            @w_codigo,          @i_ente,            @i_nombre,            @i_giro,                @i_fecha_apertura,     
    @i_calle,           @i_nro,             @i_colonia,         @i_localidad,         @i_municipio,           @i_estado,
    @i_codpostal,       @i_pais,            @i_telefono,        @i_actividad_ec,      @i_tiempo_activida,     @i_tiempo_dom_neg,
    @w_emprendedor,     @i_recurso,         @i_ingreso_mensual, @i_tipo_local,        @s_user,                @s_ofi,
    @s_date,            @i_operacion,       'V',                @i_destino_credito,   getdate(),              @i_canal,
	@i_otro_recurso)
    if @@error <> 0
      begin   
         select @w_num_error = 190515 --ERROR AL REGISTRAR TRANSACCION DE SERVICIO
         goto errores
      end
    commit tran
    
	-- Actualizacion Automatica de Prospecto a Cliente
	exec cobis..sp_seccion_validar
		@i_ente			= @i_ente,
		@i_operacion 	= 'V',
		@i_seccion 		= '3', --3 es Negocios
		@i_completado 	= 'S'
    
    goto fin
end

if @i_operacion = 'U'
begin
    select
        @w_codigo            = nc_codigo,
        @w_ente              = nc_ente,
        @w_nombre            = nc_nombre,
        @w_giro              = nc_giro,
        @w_fecha_apertura    = nc_fecha_apertura,
        @w_calle             = nc_calle,
        @w_nro               = nc_nro,         
        @w_colonia           = nc_colonia,
        @w_localidad         = nc_localidad,
        @w_municipio         = nc_municipio,     
        @w_estado            = nc_estado,
        @w_codpostal         = nc_codpostal,
        @w_pais              = nc_pais,
        @w_telefono          = nc_telefono,
        @w_actividad_ec      = nc_actividad_ec,
        @w_tiempo_activida   = nc_tiempo_actividad,
        @w_tiempo_dom_neg    = nc_tiempo_dom_neg,
        @w_recurso           = nc_recurso,
        @w_ingreso_mensual   = nc_ingreso_mensual,
        @w_tipo_local        = nc_tipo_local,
        @w_estado_reg        = nc_estado_reg,
        @w_destino_credito   = nc_destino_credito,
        @w_otro_recurso      = nc_otro_recurso
    from cl_negocio_cliente
    where nc_codigo = @i_codigo
    if @@rowcount = 0
      begin
         select @w_num_error =  108006 --NO EXISTE NEGOCIO DEL CLIENTE
         goto errores
      end 
    
    begin tran
    
    
    if(@s_ofi = 9001) --Es el movil
    begin
    	
    	SELECT TOP 1 @w_direccion = di_direccion FROM cobis..cl_direccion 
    	WHERE di_ente = @i_ente
    	AND di_tipo = 'AE'
    	
    	
    	SELECT @w_len = len(@i_telefono)
    	SELECT @w_len = @w_len - 9      
    	
    	SELECT @w_cod_area = substring(@i_telefono,0,@w_len)
    	
    	SELECT @w_telefono_aux = RIGHT(@i_telefono, 10)--substring(@i_telefono,4,12)
    	
    	--PRINT @w_len
    	--PRINT @w_cod_area
    	--PRINT @i_telefono
    	
    	
    	if exists(select 1 from cl_telefono where te_ente = @i_ente 
			and te_direccion = @w_direccion and te_tipo_telefono = 'D' and te_valor = @w_telefono_aux)
    	begin
			select top 1 @w_secuencial = te_secuencial from cl_telefono where te_ente = @i_ente 
			and te_direccion = @w_direccion and te_tipo_telefono = 'D' and te_valor = @w_telefono_aux
		end
		else
		begin
			select top 1 @w_secuencial = te_secuencial from cl_telefono where te_ente = @i_ente 
			and te_direccion = @w_direccion	and te_tipo_telefono = 'D'
		end
		
		
		if (@w_secuencial is not null)
		begin
		
			exec @w_error     = cobis..sp_telefono 
			@i_ente           = @i_ente,
			@i_direccion      = @w_direccion,
			@i_secuencial     = @w_secuencial,
			@i_valor          = @w_telefono_aux,
			@i_canal          = @i_canal,
			@i_tipo_telefono  = 'D',
			@i_cod_area       = @w_cod_area,
			@t_trn            = 112,               --Update en telefonos
			@i_operacion      = 'U',
			@s_srv            = @s_srv,
			@s_user           = @s_user,
			@s_term           = @s_term,
			@s_ofi            = @s_ofi,
			@s_rol            = @s_rol,
			@s_ssn            = @s_ssn,
			@s_lsrv           = @s_lsrv,
			@s_date           = @s_date,
			@s_sesn           = @s_sesn,
			@s_org            = @s_org
			
			if @@error <> 0 or @w_error <> 0
	        begin
	           exec sp_cerror
	                @t_debug        = @t_debug,
	                @t_file         = @t_file,
	                @t_from         = @w_sp_name,
	                @i_num          = 105035 --'Error en creacion de telefono'
	           return 105035
	        end
    		
			/* Reasigno para no perder valores en mobile */
    		select @o_telefono_id = @w_secuencial
    		select @o_codigo = @i_codigo
    		
    	end
    	else
    	begin
    		
    		EXEC cobis..sp_telefono @i_ente= @i_ente,
			@i_direccion= @w_direccion,
			@i_valor= @w_telefono_aux,
			@i_tipo_telefono='D',
			@i_cod_area= @w_cod_area,
			@t_trn=111,               --Insert en telefonos
			@i_operacion='I',
			@s_srv=@s_srv,
			@s_user=@s_user,
			@s_term=@s_term,
			@s_ofi=@s_ofi,
			@s_rol=@s_rol,
			@s_ssn=@s_ssn,
			@s_lsrv=@s_lsrv,
			@s_date=@s_date,
			@s_sesn=@s_sesn,
			@s_org=@s_org
			
			if @@error <> 0
		    begin
		       exec sp_cerror
		            @t_debug        = @t_debug,
		            @t_file         = @t_file,
		            @t_from         = @w_sp_name,
		            @i_num          = 103038 --Error en creacion de telefono
		       return 103038
		    end
    		
    		/* Envio código de telefono */
			select @o_telefono_id = te_secuencial
			from cobis..cl_telefono 
			where te_ente = @i_ente
			and te_direccion = @w_direccion
			and te_valor = @w_telefono_aux
			and te_tipo_telefono = 'D'
    		
			/* Reasigno para no perder valores en mobile */
    		SELECT @o_codigo = @i_codigo
    		
    	end
    	
    end
    
    
    insert into ts_negocio_cliente(
    ts_secuencial,      ts_codigo,          ts_ente,            ts_nombre,            ts_giro,                ts_fecha_apertura,
    ts_calle,           ts_nro,             ts_colonia,         ts_localidad,         ts_municipio,           ts_estado,
    ts_codpostal,       ts_pais,            ts_telefono,        ts_actividad_ec,      ts_tiempo_actividad,    ts_tiempo_dom_neg,
    ts_emprendedor,     ts_recurso,         ts_ingreso_mensual, ts_tipo_local,        ts_usuario,             ts_oficina,
    ts_fecha_proceso,   ts_operacion,       ts_estado_reg,      ts_destino_credito,   ts_hora,                ts_canal,
	ts_otro_recurso)
    values (
    @s_sesn,            @w_codigo,          @w_ente,            @w_nombre,            @w_giro,                @w_fecha_apertura,     
    @w_calle,           @w_nro,             @w_colonia,         @w_localidad,         @w_municipio,           @w_estado,
    @w_codpostal,       @w_pais,            @w_telefono,        @w_actividad_ec,      @w_tiempo_activida,     @w_tiempo_dom_neg,
    @w_emprendedor,     @w_recurso,         @w_ingreso_mensual, @w_tipo_local,        @s_user,                @s_ofi,
    @s_date,            'A',                @w_estado_reg,      @w_destino_credito,   getdate(),              @i_canal,
	@w_otro_recurso)        --A = Registro actual
    if @@error <> 0
      begin   
         select @w_num_error = 190515 --ERROR AL REGISTRAR TRANSACCION DE SERVICIO
         goto errores
      end
      
    if @i_ente is not null
        select @w_ente = @i_ente
    
    if @i_nombre is not null
        select @w_nombre = @i_nombre
        
    if @i_giro is not null
        select @w_giro = @i_giro
    
    if @i_fecha_apertura is not null
        select @w_fecha_apertura = @i_fecha_apertura
    
    if @i_calle is not null
        select @w_calle = @i_calle
    
    if @i_nro is not null
        select @w_nro = @i_nro
        
    if @i_colonia is not null
        select @w_colonia = @i_colonia
    
    if @i_localidad is not null
        select @w_localidad = @i_localidad
        
    if @i_municipio is not null
        select @w_municipio = @i_municipio
        
    if @i_estado is not null
        select @w_estado = @i_estado

    if @i_codpostal is not null
        select @w_codpostal = @i_codpostal
        
    if @i_pais is not null
        select @w_pais = @i_pais
        
    if @i_telefono is not null
        select @w_telefono = @i_telefono

    if @i_actividad_ec is not null
        select @w_actividad_ec = @i_actividad_ec
        
    if @i_tiempo_activida is not null
        select @w_tiempo_activida = @i_tiempo_activida
        
    if @i_tiempo_dom_neg is not null
        select @w_tiempo_dom_neg = @i_tiempo_dom_neg
    
    if @i_recurso is not null
        select @w_recurso = @i_recurso
        
    if @i_ingreso_mensual is not null
        select @w_ingreso_mensual = @i_ingreso_mensual
		
    if @i_tipo_local is not null
        select @w_tipo_local = @i_tipo_local
        
    if @i_estado_reg is not null
        select @w_estado_reg = @i_estado_reg
        
    if @i_destino_credito is not null
        select @w_destino_credito = @i_destino_credito
        
    -- if @i_otro_recurso is not null
    select @w_otro_recurso = @i_otro_recurso
         
    update cl_negocio_cliente
    set nc_ente               =      @w_ente,
        nc_nombre             =      @w_nombre,
        nc_giro               =      @w_giro,
        nc_fecha_apertura    =       @w_fecha_apertura,
        nc_calle              =      @w_calle,
        nc_nro                =      @w_nro,
        nc_colonia            =      @w_colonia,
        nc_localidad          =      @w_localidad,
        nc_municipio          =      @w_municipio,
        nc_estado             =      @w_estado,
        nc_codpostal          =      @w_codpostal,
        nc_pais               =      @w_pais,
        nc_telefono           =      @w_telefono,
        nc_actividad_ec       =      @w_actividad_ec,
        nc_tiempo_actividad   =      @w_tiempo_activida,
        nc_tiempo_dom_neg     =      @w_tiempo_dom_neg,
        nc_emprendedor        =      @w_emprendedor,
        nc_recurso            =      @w_recurso,
        nc_ingreso_mensual    =      @w_ingreso_mensual,
        nc_tipo_local         =      @w_tipo_local,
        nc_otro_recurso       =      @w_otro_recurso,
        nc_estado_reg         =      @w_estado_reg,
        nc_destino_credito    =      @w_destino_credito
    where nc_codigo = @i_codigo
      
      if @@error != 0
      begin
         select @w_num_error = 108004 --ERROR AL ACTUALIZAR NEGOCIO DEL CLIENTE!
         goto errores
      end
    
    insert into ts_negocio_cliente(
    ts_secuencial,      ts_codigo,          ts_ente,           ts_nombre,             ts_giro,                ts_fecha_apertura,
    ts_calle,           ts_nro,             ts_colonia,        ts_localidad,          ts_municipio,           ts_estado,
    ts_codpostal,       ts_pais,            ts_telefono,       ts_actividad_ec,       ts_tiempo_actividad,    ts_tiempo_dom_neg,
    ts_emprendedor,     ts_recurso,         ts_ingreso_mensual,ts_tipo_local,         ts_usuario,             ts_oficina,
    ts_fecha_proceso,   ts_operacion,       ts_estado_reg,     ts_destino_credito,    ts_hora,                ts_canal,
	ts_otro_recurso)
    values (
    @s_sesn,            @w_codigo,          @w_ente,            @w_nombre,            @w_giro,                @w_fecha_apertura,     
    @w_calle,           @w_nro,             @w_colonia,         @w_localidad,         @w_municipio,           @w_estado,
    @w_codpostal,       @w_pais,            @w_telefono,        @w_actividad_ec,      @w_tiempo_activida,     @w_tiempo_dom_neg,
    @w_emprendedor,     @w_recurso,         @w_ingreso_mensual, @w_tipo_local,        @s_user,                @s_ofi,
    @s_date,            'D',                @w_estado_reg,      @w_destino_credito,   getdate(),              @i_canal,
	@w_otro_recurso)       --P = Registro modificado
    if @@error <> 0
    begin   
       select @w_num_error = 190515 --ERROR AL REGISTRAR TRANSACCION DE SERVICIO
       goto errores
    end
    
    commit tran
    
    /* Validar negocio */
    exec cobis..sp_seccion_validar
    @i_ente			= @i_ente,
    @i_operacion 	= 'V',
    @i_seccion 	= '3', --3 es Negocios
    @i_completado = 'S'
    
goto fin
end

if @i_operacion = 'D'
begin
    select (1) from cl_negocio_cliente where nc_codigo = @i_codigo
    if @@rowcount = 0
      begin
         select @w_num_error =  108006 --NO EXISTE NEGOCIO DEL CLIENTE!
         goto errores
      end 
      begin tran
      select
        @w_codigo            = nc_codigo,
        @w_ente              = nc_ente,
        @w_nombre            = nc_nombre,
        @w_giro              = nc_giro,
        @w_fecha_apertura   = nc_fecha_apertura,
        @w_calle             = nc_calle,
        @w_nro               = nc_nro,         
        @w_colonia           = nc_colonia,
        @w_localidad         = nc_localidad,
        @w_municipio         = nc_municipio,     
        @w_estado            = nc_estado,
        @w_codpostal         = nc_codpostal,
        @w_pais              = nc_pais,
        @w_telefono          = nc_telefono,
        @w_actividad_ec      = nc_actividad_ec,
        @w_tiempo_activida   = nc_tiempo_actividad,
        @w_tiempo_dom_neg    = nc_tiempo_dom_neg,
        @w_emprendedor       = nc_emprendedor,
        @w_recurso           = nc_recurso,
        @w_ingreso_mensual   = nc_ingreso_mensual,
        @w_tipo_local        = nc_tipo_local,
        @w_otro_recurso      = nc_otro_recurso,
        @w_estado_reg        = nc_estado_reg,
        @w_destino_credito   = nc_destino_credito
    from cl_negocio_cliente
    where nc_codigo = @i_codigo
    if @@rowcount = 0
      begin
         select @w_num_error =  108006 --NO EXISTE NEGOCIO DEL CLIENTE
         goto errores
      end 
    
    insert into ts_negocio_cliente(
    ts_secuencial,      ts_codigo,          ts_ente,           ts_nombre,             ts_giro,                ts_fecha_apertura,
    ts_calle,           ts_nro,             ts_colonia,        ts_localidad,          ts_municipio,           ts_estado,
    ts_codpostal,       ts_pais,            ts_telefono,       ts_actividad_ec,       ts_tiempo_actividad,    ts_tiempo_dom_neg,
    ts_emprendedor,     ts_recurso,         ts_ingreso_mensual,ts_tipo_local,         ts_usuario,             ts_oficina,
    ts_fecha_proceso,   ts_operacion,       ts_estado_reg,     ts_destino_credito,    ts_hora,                ts_canal,
	ts_otro_recurso	)
    values (
   @s_sesn,            @w_codigo,          @w_ente,            @w_nombre,             @w_giro,                @w_fecha_apertura,     
    @w_calle,           @w_nro,             @w_colonia,         @w_localidad,         @w_municipio,           @w_estado,
    @w_codpostal,       @w_pais,            @w_telefono,        @w_actividad_ec,      @w_tiempo_activida,     @w_tiempo_dom_neg,
    @w_emprendedor,     @w_recurso,         @w_ingreso_mensual, @w_tipo_local,        @s_user,                @s_ofi,
    @s_date,            'A',                @w_estado_reg,      @w_destino_credito,   getdate(),              @i_canal,
	@w_otro_recurso)       --A = Registro actual
    if @@error <> 0
      begin   
         select @w_num_error = 190515 --ERROR AL REGISTRAR TRANSACCION DE SERVICIO
         goto errores
      end
    
    update cl_negocio_cliente
    set nc_estado_reg = 'E'     --estado eliminado
    where nc_codigo = @i_codigo
  
    if @@error <> 0
    begin
     select @w_num_error = 108005 --ERROR AL ELIMINAR NEGOCIO DEL CLIENTE!
     goto errores
    end
    
    insert into ts_negocio_cliente(
    ts_secuencial,      ts_codigo,          ts_ente,           ts_nombre,             ts_giro,                ts_fecha_apertura,
    ts_calle,           ts_nro,             ts_colonia,        ts_localidad,          ts_municipio,           ts_estado,
    ts_codpostal,       ts_pais,            ts_telefono,       ts_actividad_ec,       ts_tiempo_actividad,    ts_tiempo_dom_neg,
    ts_emprendedor,     ts_recurso,         ts_ingreso_mensual,ts_tipo_local,         ts_usuario,             ts_oficina,
    ts_fecha_proceso,   ts_operacion,       ts_estado_reg,     ts_destino_credito,    ts_hora,                ts_canal,
	ts_otro_recurso	)
    values (
    @s_sesn,            @w_codigo,          @w_ente,            @w_nombre,            @w_giro,                @w_fecha_apertura,     
    @w_calle,           @w_nro,             @w_colonia,         @w_localidad,         @w_municipio,           @i_estado,
    @w_codpostal,       @w_pais,            @w_telefono,        @w_actividad_ec,      @w_tiempo_activida,     @w_tiempo_dom_neg,
    @w_emprendedor,     @w_recurso,         @w_ingreso_mensual, @w_tipo_local,        @s_user,                @s_ofi,
    @s_date,            'D',                @w_estado_reg,      @w_destino_credito,   getdate(),              @i_canal,
	@w_otro_recurso)       --D = Registro Eliminado
    if @@error <> 0
      begin   
         select @w_num_error = 190515 --ERROR AL REGISTRAR TRANSACCION DE SERVICIO
         goto errores
      end
    commit tran
goto fin
end

if @i_operacion = 'S'
begin

       SELECT TOP 1 @w_direccion = di_direccion FROM cobis..cl_direccion 
    	WHERE di_ente = @i_ente
    	AND di_tipo = 'AE'
    	
    	SELECT TOP 1 @w_telefono_aux = te_valor, 
    	             @w_telefono_id  = te_secuencial
    	FROM cobis..cl_telefono WHERE te_ente = @i_ente 
		AND te_direccion = @w_direccion
		AND te_tipo_telefono = 'D'
		
    	    
		IF(@w_telefono_aux IS NOT NULL)

    	begin
		if( len(@w_telefono_aux)>9)
		begin
		SELECT @w_len = len(@w_telefono_aux)
    	SELECT @w_len = @w_len - 9      
    	
        SELECT @w_len = len(@w_telefono_aux)
    	SELECT @w_len = @w_len - 9  
    		SELECT @w_cod_area = substring(@w_telefono_aux,0,@w_len)
    	
		 	SELECT @w_telefono_aux = RIGHT(@w_telefono_aux, 10)
    	end
		end
    --set rowcount 20
    select 
        'codCliente'         = nc_ente,
        'NomCliente'         = en_nombre,
        'nombre'             = nc_nombre,
        'giro'               = nc_giro,
        'fechaApertura'      = convert(char(10), nc_fecha_apertura, 103),
        'despDestinoCred'    = null,
        'calle'              = nc_calle,
     'nro'                = nc_nro,
        'colonia'            = nc_colonia,
        'localidad'          = nc_localidad,
        'municipio'          = nc_municipio,     
        'codEstado'          = nc_estado,
        'desEstado'          = null,
        'codPostal'          = nc_codpostal,
        'codPais'            = nc_pais,
        'desPais'            = null,
        'telefono'           = @w_telefono_aux,
        'codActividad'       = nc_actividad_ec,
        'desActividad'       = (select ac_descripcion from cl_actividad_ec where ac_codigo=nc_actividad_ec),
        'timeActivi'         = nc_tiempo_actividad,
        'timeDomNeg'         = nc_tiempo_dom_neg,
        'emprendedor'        = nc_emprendedor,
        'recurso'            = nc_recurso,
        'ingMensual'         = nc_ingreso_mensual,
        'tipoLocal'          = nc_tipo_local,
        'codigo'             = nc_codigo,
        'destinoCredito'     = nc_destino_credito,
        'codTelefono'        = @w_telefono_id,
		'otroRecurso'		 = nc_otro_recurso
    from cl_negocio_cliente
    inner join cl_ente on (en_ente = nc_ente)
    where nc_ente =  @i_ente
    and   nc_codigo > isnull(@i_codigo, 0)
    and   nc_estado_reg = 'V'
goto fin
end

if @i_operacion = 'Q'
begin
    select 
        'codCliente'         = nc_ente,
        'NomCliente'         = en_nombre,
        'nombre'             = nc_nombre,
        'giro'               = nc_giro,
        'fechaApertura'      = convert(char(10), nc_fecha_apertura, 103),
        'despDestinoCred'    = null,
        'calle'              = nc_calle,
        'nro'                = nc_nro,
        'colonia'            = nc_colonia,
        'localidad'          = nc_localidad,
        'municipio'          = nc_municipio,     
        'codEstado'          = nc_estado,
        'desEstado'          = null,
        'codPostal'          = nc_codpostal,
        'codPais'            = nc_pais,
        'desPais'            = null,
        'telefono'           = nc_telefono,
        'codActividad'       = nc_actividad_ec,
        'desActividad'       = (select ac_descripcion from cl_actividad_ec where ac_codigo=nc_actividad_ec),
        'timeActivi'         = nc_tiempo_actividad,
        'timeDomNeg'         = nc_tiempo_dom_neg,
        'emprendedor'        = nc_emprendedor,
        'recurso'            = nc_recurso,
        'ingMensual'         = nc_ingreso_mensual,
        'tipoLocal'          = nc_tipo_local,
        'codigo'             = nc_codigo,
        'destinoCredito'     = nc_destino_credito
    from cl_negocio_cliente
    inner join cl_ente on (en_ente = nc_ente)
    where nc_codigo = @i_codigo
    and   nc_estado_reg = 'V'
goto fin
END

if @i_operacion = 'H'
begin
    --POV Consulta Mismo que domicilio
     SELECT
            'pais'      = di_pais, 
            'provincia' = di_provincia, 
            'ciudad'    = di_ciudad, 
            'parroquia' = di_parroquia, 
            'calle'     = di_calle, 
            'no_calle'  = di_nro, 
            'cod_posta' = di_codpostal
     FROM cl_direccion
     WHERE di_ente = @i_ente 
     AND di_tipo = 'RE'
      
     if @@rowcount=0
	     begin
	   		select @w_num_error = 101025 --Transaccion no permitida
	     goto errores
     end
goto fin
end

--Control errores
errores:
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_num_error
   return @w_num_error
fin:
   return 0


go