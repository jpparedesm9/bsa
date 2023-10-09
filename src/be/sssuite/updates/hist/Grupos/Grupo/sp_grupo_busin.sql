IF OBJECT_ID ('dbo.sp_grupo_busin') IS NOT NULL
	DROP PROCEDURE dbo.sp_grupo_busin
GO

create proc sp_grupo_busin (
    @s_ssn                  int             = null,
    @s_user                 login           = null,
    @s_term                 varchar(30)     = null,
    @s_date                 datetime        = null,
    @s_srv                  varchar(30)     = null,
    @s_lsrv                 varchar(30)     = null,
    @s_ofi                  smallint        = null,
    @s_rol                  smallint        = NULL,
    @s_org_err              char(1)         = NULL,
    @s_error                int             = NULL,
    @s_sev                  tinyint         = NULL,
    @s_msg                  descripcion     = NULL,
    @s_org                  char(1)         = NULL,
    @t_show_version         bit             = 0,    -- Mostrar la version del programa
    @t_debug                char(1)         = 'N',
    @t_file                 varchar(10)     = null,
    @t_from                 varchar(32)     = null,
    @t_trn                  smallint        = null,
    @i_operacion            char(1),                -- Opcion con que se ejecuta el programa
    @i_modo                 tinyint         = null, -- Modo de busqueda
    @i_tipo                 char(1)         = null, -- Tipo de consulta
    @i_filial               tinyint         = null, -- Codigo de la filial
    @i_oficina              smallint        = null, -- Codigo de la oficina    
    @i_ente                 int             = null, -- Codigo del ente que forma parte del grupo
    @i_grupo                int             = null, -- Codigo del grupo
    @i_nombre               descripcion     = null, -- Nombre del grupo economico
    @i_representante        int             = null, -- Codigo del representante legal
    @i_compania             int             = null, -- Codigo de la compania
    @i_oficial              int             = null, -- Codigo del oficial encargado del grupo econ¢mico
    @i_fecha_registro       datetime        = null, -- Fecha de Registro del grupo
    @i_fecha_modificacion   datetime        = null, -- Fecha de Modificación del grupo 
    @i_ruc                  numero          = null, -- Numero del documento de identificacion
    @i_vinculacion          char(1)         = null, -- Codigo de vinculacion del representante al grupo
    @i_tipo_vinculacion     catalogo        = null, -- Codigo del tipo de vinculacion del representante al grupo
    @i_max_riesgo           money           = null,
    @i_riesgo               money           = null,
    @i_usuario              login           = null,
    @i_reservado            money           = null,
    @i_tipo_grupo           catalogo        = null,
    @i_estado               catalogo        = null, -- Estado del Grupo Economico
    @i_dir_reunion          varchar(125)    = null, -- Direccion de la reunion del grupo
    @i_dia_reunion          catalogo        = null, -- Dia de reunion del grupo
    @i_hora_reunion         datetime        = null, -- Hora de la reunion de del grupo
    @i_comportamiento_pago  varchar(10)     = null, -- 
    @i_num_ciclo            int             = null, --
	@o_grupo                int             = null out,
	@i_gr_tipo    			char(1)         = null, -- campo gr_tipo en grupo   
	@i_gr_cta_grupal        VARCHAR(30)     = null, --campo  cuenta grupal
	@i_gr_sucursal 			int    			= null  --campo sucursal
)
as
declare @w_siguiente        int,
        @w_return               int,
        @w_ente                 int,
        @w_num_cl_gr            int,
        @w_contador             int,
        @w_sp_name              varchar(32),
        @w_error                int,    
        @w_grupo                int,
        @w_nombre               descripcion,
        @w_representante        int,
        @w_compania             int,
        @w_oficial              int,
        @w_fecha_registro       datetime,
        @w_fecha_modificacion   datetime,
        @w_ruc                  numero,
        @w_vinculacion          char(1),
        @w_tipo_vinculacion     catalogo,
        @w_max_riesgo           money,
        @w_riesgo               money,
        @w_usuario              login,
        @w_reservado            money,
        @w_tipo_grupo           catalogo,
        @w_estado               catalogo,
        @w_dir_reunion          varchar(125),
        @w_dia_reunion          catalogo,
        @w_hora_reunion         datetime,
        @w_comportamiento_pago  varchar(10),
        @w_num_ciclo            int,
        @w_gr_tipo 				char(1),
        @w_gr_cta_grupal		VARCHAR(30),
        @w_gr_sucursal 			VARCHAR(30),
        @v_grupo                int,
        @v_nombre               descripcion,
        @v_representante        int,
        @v_compania             int,
        @v_oficial              int,
        @v_fecha_registro       datetime,
        @v_fecha_modificacion   datetime,
        @v_ruc                  numero,
        @v_vinculacion          char(1),
        @v_tipo_vinculacion     catalogo,
        @v_max_riesgo           money,
        @v_riesgo               money,
        @v_usuario              login,
        @v_reservado            money,
        @v_tipo_grupo           catalogo,
        @v_estado               catalogo,
        @v_dir_reunion          varchar(125),
        @v_dia_reunion          catalogo,
        @v_hora_reunion         datetime,
        @v_comportamiento_pago  varchar(10),
        @v_num_ciclo            int,
        @v_gr_tipo 				char(1),
        @v_gr_cta_grupal		VARCHAR(30),
        @v_gr_sucursal 			int
      
-------------------------------- VERSIONAMIENTO DE SP --------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_grupo_busin, Version 1.0.0.0'
    return 0
end
--------------------------------------------------------------------------------------
select @w_sp_name = 'sp_grupo_busin'

if @t_trn != 800
begin
    exec cobis..sp_cerror
         @t_debug      = @t_debug,
         @t_file       = @t_file,
         @t_from       = @w_sp_name,
         @i_num        = 151051 -- TRANSACCION NO PERMITIDA
    return 1
end
    
-- Insert --
if @i_operacion = 'I'
begin
    -- Verificar que otro grupo no tenga el mismo nombre --
    if exists (select 1 from cobis..cl_grupo where gr_nombre = @i_nombre)
    begin
        select @w_error = 208901 -- YA EXISTE EL NOMBRE DEL GRUPO
        goto ERROR
    end

    -- Verificar que exista el oficial --
    if not exists (select * from cobis..cc_oficial where oc_oficial = @i_oficial) and @i_oficial != null
    begin
        select @w_error = 151091 -- No existe oficial --
        goto ERROR
    end

    -- Obtener un secuencial para el nuevo grupo --
    exec cobis..sp_cseqnos
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @t_from,
    @i_tabla        = 'cl_grupo',
    @o_siguiente    = @w_siguiente out
    -- Error con el secuencial
    if @w_siguiente = NULL
    begin
        select @w_error = 2101007 -- NO EXISTE TABLA EN TABLA DE SECUENCIALES
        goto ERROR           
    end

    -- insertar los datos de grupo --
    insert into cobis..cl_grupo (gr_grupo,       gr_nombre,          gr_representante,     gr_compania,    --1
                                 gr_oficial,     gr_fecha_registro,  gr_fecha_modificacion,gr_ruc,         --2  
                                 gr_vinculacion, gr_tipo_vinculacion,gr_max_riesgo,        gr_riesgo,      --3
                                 gr_usuario,     gr_reservado,       gr_tipo_grupo,        gr_estado,      --4
                                 gr_dir_reunion, gr_dia_reunion,     gr_hora_reunion,      gr_comportamiento_pago,  --5 
                                 gr_num_ciclo,	 gr_tipo,			 gr_cta_grupal,    	   gr_sucursal                                                             --6
                                 )
    values                       (@w_siguiente,   @i_nombre,          NULL,                 @i_compania,    --1
                                  @i_oficial,     @i_fecha_registro,  @i_fecha_modificacion,@i_ruc,         --2
                                  @i_vinculacion, @i_tipo_vinculacion,@i_max_riesgo,        @i_riesgo,      --3      
                                  @i_usuario,     @i_reservado,       @i_tipo_grupo,        @i_estado,      --4
                                  @i_dir_reunion, @i_dia_reunion,     @i_hora_reunion,      @i_comportamiento_pago,  --5 
                                  @i_num_ciclo,   @i_gr_tipo,         @i_gr_cta_grupal,     @i_gr_sucursal                                             --6
                                 )                              
    -- si no se puede insertar, error --
    if @@error != 0
    begin
        select @w_error = 103006 -- ERROR EN CREACION DE GRUPO
        goto ERROR 
    end

    -- Transaccion servicio - cl_grupo --
    insert into cobis..ts_grupo  (secuencial,    tipo_transaccion,    clase,                 fecha,    --1
                                  terminal,      srv,                 lsrv,                            --2
                                  grupo,         nombre,              representante,         compania, --3
                                  oficial,       fecha_registro,      fecha_modificacion,    ruc,      --4                      
                                  vinculacion,   tipo_vinculacion,    max_riesgo,            riesgo,   --5                      
                                  usuario,       reservado,           tipo_grupo,            estado,   --6                      
                                  dir_reunion,   dia_reunion,         hora_reunion,          comportamiento_pago,--7                      
                                  num_ciclo)
    values                       (@s_ssn,       800,                 'N',                   @s_date,   --1
                                  @s_term,       @s_srv,              @s_lsrv,                           --2
                                  @w_siguiente,  @i_nombre,           @i_representante,      @i_compania,--3
                                  @i_oficial,    @i_fecha_registro,   @i_fecha_modificacion, @i_ruc,     --4
                                  @i_vinculacion,@i_tipo_vinculacion, @i_max_riesgo,         @i_riesgo,  --5
                                  @i_usuario,    @i_reservado,        @i_tipo_grupo,         @i_estado,  --6
                                  @i_dir_reunion,@i_dia_reunion,      @i_hora_reunion,       @i_comportamiento_pago,--7
                                  @i_num_ciclo                                                           --8
                                 )
    -- Si no se puede insertar transaccion de servicio, error --
    if @@error != 0
    begin
        select @w_error = 103005 -- ERROR EN CREACION DE TRANSACCION DE SERVICIO
        goto ERROR
    end
	
    select @o_grupo = @w_siguiente
	select @o_grupo
			
end -- Fin Operacion I
if @i_operacion = 'U'
begin
    -- verificar que exista el grupo --
	if not exists (select 1 from cobis..cl_grupo where gr_grupo = @i_grupo)
	begin
        select @w_error = 151029 -- NO EXISTE GRUPO
        goto ERROR
	end
	
	--Verificar que el oficial exista
    if not exists (select * from cobis..cc_oficial where oc_oficial = @i_oficial) and @i_oficial != null
    begin
        select @w_error = 151091  -- No existe oficial --
        goto ERROR
    end
	
    -- Consulta de datos del grupo
    select @w_grupo               = gr_grupo,
           @w_nombre              = gr_nombre,
           @w_representante       = gr_representante,
           @w_compania            = gr_compania,
           @w_oficial             = gr_oficial,
           @w_fecha_registro      = gr_fecha_registro,
           @w_fecha_modificacion  = gr_fecha_modificacion,
           @w_ruc                 = gr_ruc,
           @w_vinculacion         = gr_vinculacion,
           @w_tipo_vinculacion    = gr_tipo_vinculacion,
           @w_max_riesgo          = gr_max_riesgo,
           @w_riesgo              = gr_riesgo,
           @w_usuario             = gr_usuario,
           @w_reservado           = gr_reservado,
           @w_tipo_grupo          = gr_tipo_grupo,
           @w_estado              = gr_estado,
  		@w_dir_reunion         = gr_dir_reunion,
           @w_dia_reunion         = gr_dia_reunion,
        @w_hora_reunion        = gr_hora_reunion,
           @w_comportamiento_pago = gr_comportamiento_pago,
           @w_num_ciclo           = gr_num_ciclo,
           @w_gr_tipo 			  = gr_tipo,
           @w_gr_cta_grupal 	  = gr_cta_grupal,
           @w_gr_sucursal		  = gr_sucursal
    from   cobis..cl_grupo
    where  gr_grupo = @i_grupo
    
    -- INI Guardar los datos anteriores que han cambiado --
    select @v_grupo               = @w_grupo,
           @v_nombre              = @w_nombre,
           @v_representante       = @w_representante,
           @v_compania            = @w_compania,
           @v_oficial             = @w_oficial,
           @v_fecha_registro      = @w_fecha_registro,
           @v_fecha_modificacion  = @w_fecha_modificacion,
           @v_ruc                 = @w_ruc,
           @v_vinculacion         = @w_vinculacion,
           @v_tipo_vinculacion    = @w_tipo_vinculacion,
           @v_max_riesgo          = @w_max_riesgo,
           @v_riesgo              = @w_riesgo,
           @v_usuario             = @w_usuario,
           @v_reservado           = @w_reservado,
           @v_tipo_grupo          = @w_tipo_grupo,
           @v_estado              = @w_estado,
           @v_dir_reunion         = @w_dir_reunion,
           @v_dia_reunion         = @w_dia_reunion,
           @v_hora_reunion        = @w_hora_reunion,
           @v_comportamiento_pago = @w_comportamiento_pago,
           @v_num_ciclo           = @w_num_ciclo,
           @v_gr_tipo          	  = @w_gr_tipo,
           @v_gr_cta_grupal 	  = @w_gr_cta_grupal,
           @v_gr_sucursal		  = @w_gr_sucursal
           

    if @w_grupo = @i_grupo
        select @w_grupo = null, @v_grupo = null
    else
        select @w_grupo = @i_grupo

    if @w_nombre = @i_nombre
        select @w_nombre = null, @v_nombre = null
    else
        select @w_nombre = @i_nombre

    if @w_representante = @i_representante
        select @w_representante = null, @v_representante = null
    else
        select @w_representante = @i_representante

    if @w_compania = @i_compania
        select @w_compania = null, @v_compania = null
    else
        select @w_compania = @i_compania            
        
    if @w_oficial = @i_oficial
        select @w_oficial = null, @v_oficial = null
    else
        select @w_oficial = @i_oficial
        
    if @w_fecha_registro = @i_fecha_registro
        select @w_fecha_registro = null, @v_fecha_registro = null
    else
        select @w_fecha_registro = @i_fecha_registro        

    if @w_fecha_modificacion = @i_fecha_modificacion
        select @w_fecha_modificacion = null, @v_fecha_modificacion = null
    else
        select @w_fecha_modificacion = @i_fecha_modificacion

    if @w_ruc = @i_ruc
        select @w_ruc = null, @v_ruc = null
    else
        select @w_ruc = @i_ruc        

    if @w_vinculacion = @i_vinculacion
        select @w_vinculacion = null, @v_vinculacion = null
    else
        select @w_vinculacion = @i_vinculacion

    if @w_tipo_vinculacion = @i_tipo_vinculacion
        select @w_tipo_vinculacion = null, @i_tipo_vinculacion = null
    else
        select @w_tipo_vinculacion = @i_tipo_vinculacion
        
    if @w_max_riesgo = @i_max_riesgo
        select @w_max_riesgo = null, @v_max_riesgo = null
    else
        select @w_max_riesgo = @i_max_riesgo

    if @w_usuario = @i_usuario
        select @w_usuario = null, @v_usuario = null
    else
        select @w_usuario = @i_usuario    

    if @w_reservado = @i_reservado
        select @w_reservado = null, @v_reservado = null
    else
        select @w_reservado = @i_reservado

    if @w_tipo_grupo = @i_tipo_grupo
        select @w_tipo_grupo = null, @v_tipo_grupo = null
    else
        select @w_tipo_grupo = @i_tipo_grupo        
        
    if @w_estado = @i_estado
        select @w_estado = null, @v_estado = null
    else
        select @w_estado = @i_estado

    if @w_dir_reunion = @i_dir_reunion
        select @w_dir_reunion = null, @v_dir_reunion = null
    else
        select @w_dir_reunion = @i_dir_reunion
     
    if @w_dia_reunion = @i_dia_reunion
        select @w_dia_reunion = null, @v_dia_reunion = null
    else
       select @w_dia_reunion = @i_dia_reunion    

    if @w_hora_reunion = @i_hora_reunion
        select @w_hora_reunion = null, @v_hora_reunion = null
    else
        select @w_hora_reunion = @i_hora_reunion

    if @w_comportamiento_pago = @i_comportamiento_pago
        select @w_comportamiento_pago = null, @i_comportamiento_pago = null
    else
        select @w_comportamiento_pago = @i_comportamiento_pago    

    if @w_num_ciclo = @i_num_ciclo
        select @w_num_ciclo = null, @i_num_ciclo = null
    else
        select @w_num_ciclo = @i_num_ciclo
        
    -- FIN Guardar los datos anteriores que han cambiado --
    
    -- INI Transaccion servicio - cl_grupo --
    insert into cobis..ts_grupo  (secuencial,    tipo_transaccion,    clase,                 fecha,    --1
                                  terminal,      srv,                 lsrv,                            --2
                                  grupo,         nombre,              representante,         compania, --3
                                  oficial,       fecha_registro,      fecha_modificacion,    ruc,      --4                      
                                  vinculacion,   tipo_vinculacion,    max_riesgo,            riesgo,   --5                      
                                  usuario,       reservado,           tipo_grupo,            estado,   --6                      
                                  dir_reunion,   dia_reunion,         hora_reunion,          comportamiento_pago,--7                      
                                  num_ciclo)
    values                       (@s_ssn,        800,                 'P',                   @s_date,   --1
                                  @s_term,       @s_srv,              @s_lsrv,                           --2
                                  @i_grupo,      @v_nombre,           @v_representante,      @v_compania,--3
                                  @v_oficial,    @v_fecha_registro,   @v_fecha_modificacion, @v_ruc,     --4
                                  @v_vinculacion,@v_tipo_vinculacion, @v_max_riesgo,         @v_riesgo,  --5
                                  @v_usuario,    @v_reservado,        @v_tipo_grupo,         @v_estado,  --6
                                  @v_dir_reunion,@v_dia_reunion,      @v_hora_reunion,       @v_comportamiento_pago,--7
                                  @v_num_ciclo                                                           --8
                                 )
                                 
    -- si no se puede insertar, error --
    if @@error != 0
    begin
        select @w_error = 103005  --ERROR EN CREACION DE TRANSACCION DE SERVICIO
        goto ERROR        
    end

    -- Modificar los datos anteriores -- 
    update cobis..cl_grupo
    set    gr_oficial            = @i_oficial,
           gr_fecha_modificacion = @i_fecha_modificacion,
           gr_estado             = @i_estado,
           gr_dir_reunion        = @i_dir_reunion,
           gr_dia_reunion        = @i_dia_reunion,
           gr_hora_reunion       = @i_hora_reunion,
           gr_tipo				 = @i_gr_tipo,
           gr_cta_grupal		 = @i_gr_cta_grupal,
           gr_sucursal			 = @i_gr_sucursal
           
           --gr_comportamiento_pago= @i_comportamiento_pago
           --gr_num_ciclo          = @i_num_ciclo
    where  gr_grupo = @i_grupo

    -- Si no se puede modificar, error --
    if @@rowcount = 0
    begin
        select @w_error = 105007 --ERROR EN ACTUALIZACION DE GRUPO
        goto ERROR             
    END
    -- Insert en ts_grupo
    insert into cobis..ts_grupo  (secuencial,    tipo_transaccion,    clase,                 fecha,    --1
                                  terminal,      srv,                 lsrv,                            --2
                                  grupo,         nombre,              representante,         compania, --3
                                  oficial,       fecha_registro,      fecha_modificacion,    ruc,      --4                      
                                  vinculacion,   tipo_vinculacion,    max_riesgo,            riesgo,   --5                      
                                  usuario,       reservado,           tipo_grupo,            estado,   --6                      
                                  dir_reunion,   dia_reunion,         hora_reunion,          comportamiento_pago,--7                      
                                  num_ciclo)
    values                       (@s_ssn,        800,                 'A',                   @s_date,   --1
                                  @s_term,       @s_srv,              @s_lsrv,                           --2
                                  @i_grupo,      @w_nombre,           @w_representante,      @w_compania,--3
                                  @w_oficial,    @w_fecha_registro,   @w_fecha_modificacion, @w_ruc,     --4
                                  @w_vinculacion,@w_tipo_vinculacion, @w_max_riesgo,         @w_riesgo,  --5
                                  @w_usuario,    @w_reservado,        @w_tipo_grupo,         @w_estado,  --6
                                  @w_dir_reunion,@w_dia_reunion,      @w_hora_reunion,       @w_comportamiento_pago,--7
                                  @w_num_ciclo                                                          --8
                                 )
    
    -- Si no se puede insertar, error --
    if @@error != 0
    begin
        select @w_error = 103005  --ERROR EN CREACION DE TRANSACCION DE SERVICIO 
        goto ERROR
    end

end -- Fin Operacion U

if @i_operacion = 'Q'
begin
    -- Consulta de datos del grupo
    select 'Id_Gupo'             = gr_grupo,
           'Nombre'              = gr_nombre,
           'Oficial'             = gr_oficial,
           'Fecha_Registro'      = gr_fecha_registro,
           'Fecha_Modificacion'  = gr_fecha_modificacion,
           'Estado'              = gr_estado,
           'Dir_Reunion'         = gr_dir_reunion,
           'Dia_Reunion'         = gr_dia_reunion,
           'Hora_Reunion'        = gr_hora_reunion,
           'Comportamiento_Pago' = gr_comportamiento_pago,
           'Num_Ciclo'           = gr_num_ciclo,
            'Cuenta_grupal'           = gr_cta_grupal,
             'Sucursal'           = gr_sucursal,
              'Tipo'           = gr_tipo
    from   cobis..cl_grupo
    where  gr_grupo = @i_grupo
	
end -- Fin Operacion Q
	
return 0
ERROR:
    begin --Devolver mensaje de Error
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = @w_error
        return @w_error
    end





GO

