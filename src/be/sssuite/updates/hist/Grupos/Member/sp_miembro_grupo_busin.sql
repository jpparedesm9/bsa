IF OBJECT_ID ('dbo.sp_miembro_grupo_busin') IS NOT NULL
	DROP PROCEDURE dbo.sp_miembro_grupo_busin
GO

create proc sp_miembro_grupo_busin (
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
    @i_usuario              login           = null, 
    @i_oficial              int             = null, -- Codigo del oficial   
    @i_fecha_asociacion     datetime        = null, -- Fecha de asociación del grupo--i_fecha_reg
    @i_rol                  catalogo        = null, -- Rol que desempeña el miembro de grupo
    @i_estado               catalogo        = null, -- Estado del Grupo Economico    
    @i_calif_interna        catalogo        = null, -- Calificacion Interna
    @i_fecha_desasociacion  datetime        = NULL, -- Fecha de desasociacion del grupo
    @i_cg_ahorro_voluntario MONEY			=NULL,  -- ahorro voluntario nuevo campo
    @i_cg_lugar_reunion 	CHAR(1)			=NULL   -- nuevo campo lugar de reunion

)    
as
declare @w_siguiente        int,
        @w_return           int,
        @w_num_cl_gr        int,
        @w_contador         int,
        @w_sp_name          varchar(32),
        @w_error                int,        
        @w_ente                 int,
        @w_grupo                int,
        @w_usuario              login,
        @w_oficial              int,
        @w_fecha_asociacion     datetime,
        @w_rol                  catalogo,
        @w_estado               catalogo,
        @w_calif_interna        catalogo,
        @w_fecha_desasociacion  datetime,
        @v_ente                 int,
        @v_grupo                int,
        @v_usuario              login,
        @v_oficial              int,
        @v_fecha_asociacion     datetime,
        @v_rol                  catalogo,
        @v_estado               catalogo,
        @v_calif_interna        catalogo,
        @v_fecha_desasociacion  datetime,
        @v_cg_ahorro_voluntario money,--nuevo campo ahorro voluntario
    	@v_cg_lugar_reunion 	char(1),-- nuevo campo lugar de reunion
		@w_tab_id_rol           int,
		@w_tab_id_calif         int,
		@w_tab_id_estado        int,		
		@w_rol_desc             descripcion,
        @w_estado_desc          descripcion,
        @w_calif_interna_desc   descripcion,
		@w_cliente_nomlar       varchar(254),
		@w_cg_ahorro_voluntario money,--nuevo campo ahorro voluntario
    	@w_cg_lugar_reunion 	char(1)-- nuevo campo lugar de reunion
	   
		
                                                                                                                                              
-------------------------------- VERSIONAMIENTO DE SP --------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_miembro_grupo_busin, Version 1.0.0.0'
    return 0
end
--------------------------------------------------------------------------------------
select @w_sp_name = 'sp_miembro_grupo_busin'

if @t_trn != 810
begin
    select @w_error = 151051 -- TRANSACCION NO PERMITIDA
    goto ERROR
end

select @w_tab_id_rol = codigo from cobis..cl_tabla where tabla  = 'cl_rol_grupo'
select @w_tab_id_calif = codigo from cobis..cl_tabla where tabla  = 'cl_calif_cliente'
select @w_tab_id_estado = codigo from cobis..cl_tabla where tabla = 'cl_estado_ambito'
		
-- Insert --
if @i_operacion = 'I'
begin
     -- verificar que exista el grupo --
     if not exists (select 1 from cobis..cl_grupo where gr_grupo = @i_grupo)
     begin
        select @w_error = 151029 -- No existe el grupo --
        goto ERROR	
     end
     
	-- Verificacion que el ente existe
     if not exists (select 1 from cobis..cl_ente where en_ente = @i_ente)
     begin
        select @w_error = 208907 -- NO EXISTE EL MIEMBRO
        goto ERROR
     end

    --Verifica si existe el grupo y el ente
    if exists ( select 1 from cobis..cl_cliente_grupo where cg_ente = @i_ente and cg_grupo = @i_grupo and cg_fecha_desasociacion is null)
    begin
        select @w_error = 208903 -- YA EXISTE EL MIEMBRO EN EL GRUPO
        goto ERROR	
    end

    --Verifica si existe el miembro en otros grupos
    if exists ( select 1 from cobis..cl_cliente_grupo where cg_ente = @i_ente and cg_grupo != @i_grupo and cg_fecha_desasociacion is null)
    BEGIN
    
        select @w_error = 208908 -- YA EXISTE EL MIEMBRO EN OTRO GRUPO --
        goto ERROR
    END
    --valida que solo un integrante tenga cg_lugar_reunion D o N--
    if exists ( select 1 from cobis..cl_cliente_grupo where cg_grupo = @i_grupo and cg_fecha_desasociacion is NULL AND cg_lugar_reunion IS NOT NULL AND @i_cg_lugar_reunion IS NOT NULL)
    BEGIN
   
        select @w_error = 208909 -- YA EXISTE UN MIEMBRO CON LUGAR DE REUNION --
        goto ERROR
    END
    
    
    
    
    --actaliza  la fecha y el estado cuando la fecha es diferente de null--
    if exists ( select 1 from cobis..cl_cliente_grupo where cg_ente = @i_ente and cg_grupo = @i_grupo and cg_fecha_desasociacion IS NOT null)
    begin
     update cobis..cl_cliente_grupo
     set cg_estado = 'V', cg_fecha_desasociacion=NULL,cg_ahorro_voluntario=@i_cg_ahorro_voluntario ,cg_lugar_reunion=@i_cg_lugar_reunion
    where  cg_ente = @i_ente AND cg_grupo = @i_grupo AND cg_fecha_desasociacion IS not null
    END
    
    -- actualiza el grupo la fecha y el estado cuando la fecha es diferente de null
    if exists ( select 1 from cobis..cl_cliente_grupo where cg_ente = @i_ente and cg_grupo != @i_grupo and cg_fecha_desasociacion IS not null)
    BEGIN
     update cobis..cl_cliente_grupo
     set cg_estado ='V', cg_fecha_desasociacion=NULL, cg_grupo=@i_grupo,cg_ahorro_voluntario=@i_cg_ahorro_voluntario ,cg_lugar_reunion=@i_cg_lugar_reunion
    where  cg_ente = @i_ente AND cg_fecha_desasociacion IS not null
    END
     	
    insert into cobis..cl_cliente_grupo (cg_ente,          cg_grupo,         cg_usuario,    --1
                                         cg_terminal,      cg_oficial,       cg_fecha_reg,  --2
                                         cg_rol,           cg_estado,        cg_calif_interna, --3
                                         cg_fecha_desasociacion, cg_ahorro_voluntario, cg_lugar_reunion--4                           --4
                                        )
    values                              (@i_ente,          @i_grupo,         @s_user,         --1
                                         @s_term,          @i_oficial,       @i_fecha_asociacion,--2
                                         @i_rol,           @i_estado,        @i_calif_interna,--3
                                         @i_fecha_desasociacion, @i_cg_ahorro_voluntario, @i_cg_lugar_reunion --4  --4
                 )
    
    -- si no se puede insertar, error --
    if @@error != 0
    begin
        select @w_error = 208902 -- ERROR EN INGRESO DEL MIEMBRO DE GRUPO
        goto ERROR
    end    
    
    -- Transaccion servicio - cl_cliente_grupo --
    insert into cobis..ts_cliente_grupo (secuencial, tipo_transaccion, clase,  --1
                                         srv,        lsrv,             ente,   --2      
                                         grupo,      usuario,          terminal,--3
                                         oficial,    fecha_reg,        rol,     --4
                                         estado,     calif_interna,    fecha_desasociacion--5
                                         )
    values                              (@s_ssn,      810,              'N',       --1
                                         @s_srv,      @s_lsrv,          @i_ente,   --2                                     
                                         @i_grupo,    @s_user,          @s_term,   --3
                                         @i_oficial,  @i_fecha_asociacion, @i_rol, --4
                                         @i_estado,   @i_calif_interna, @i_fecha_desasociacion--5
                                         )    
    -- Si no se puede insertar transaccion de servicio, error --
    if @@error != 0
    begin
        select @w_error = 103005 -- ERROR EN CREACION DE TRANSACCION DE SERVICIO
        goto ERROR
    end

    -- Actualizacion del grupo en el cliente
    update cobis..cl_ente set en_grupo = @i_grupo 
    where  en_ente = @i_ente
	
end -- Fin Operacion I

if @i_operacion = 'U'
begin
     -- verificar que exista el grupo --
     if not exists (select 1 from cobis..cl_grupo where gr_grupo = @i_grupo)
     begin
         select @w_error = 151029 -- NO EXISTE GRUPO
         goto ERROR
     end
     
    --Verifica si existe el grupo y el ente a modificar
    if not exists ( select 1 from cobis..cl_cliente_grupo where cg_ente = @i_ente and cg_grupo = @i_grupo)
    begin
         select @w_error = 208904 -- NO EXISTE EL MIEMBRO EN EL GRUPO
         goto ERROR
    END
     --valida que solo un integrante tenga  cg_lugar_reunion D o N--
    if exists ( select 1 from cobis..cl_cliente_grupo where cg_grupo = @i_grupo and cg_fecha_desasociacion is NULL AND cg_lugar_reunion IS NOT NULL AND @i_cg_lugar_reunion IS NOT NULL
    AND cg_ente!=@i_ente)
    BEGIN
   
        select @w_error = 208909 -- YA EXISTE UN MIEMBRO CON LUGAR DE REUNION
        goto ERROR
    END
	--Consulta de Datos
	select @w_ente                = cg_ente,
           @w_grupo               = cg_grupo,
           @w_usuario             = cg_usuario,
           @w_oficial             = cg_oficial,
           @w_fecha_asociacion    = cg_fecha_reg,
           @w_rol                 = cg_rol,
           @w_estado              = cg_estado,
           @w_calif_interna       = cg_calif_interna,
           @w_fecha_desasociacion = cg_fecha_desasociacion,
           @w_cg_ahorro_voluntario = cg_ahorro_voluntario,
    	   @w_cg_lugar_reunion 	  = cg_lugar_reunion
           
    from  cobis..cl_cliente_grupo
	where cg_ente = @i_ente and cg_grupo = @i_grupo

    -- INI Guardar los datos anteriores que han cambiado --	
    select @v_ente                = @w_ente,
           @v_grupo               = @w_grupo,
           @v_usuario             = @w_usuario,
           @v_oficial             = @w_oficial,
           @v_fecha_asociacion    = @w_fecha_asociacion,
           @v_rol                 = @w_rol,
           @v_estado              = @w_estado,
           @v_calif_interna       = @w_calif_interna,
           @v_fecha_desasociacion = @w_fecha_desasociacion,
           @v_cg_ahorro_voluntario = @w_cg_ahorro_voluntario,
           @v_cg_lugar_reunion 	  = @w_cg_lugar_reunion
           

    if @w_ente = @i_ente
        select @w_ente = null, @v_ente = null
    else
        select @w_ente = @i_ente

    if @w_grupo = @i_grupo
        select @w_grupo = null, @v_grupo = null
    else
        select @w_grupo = @i_grupo

    if @w_usuario = @i_usuario
        select @w_usuario = null, @v_usuario = null
    else
        select @w_usuario = @i_usuario	

    if @w_oficial = @i_oficial
        select @w_oficial = null, @v_oficial = null
    else
        select @w_oficial = @i_oficial	

    if @w_fecha_asociacion = @i_fecha_asociacion
        select @w_fecha_asociacion = null, @v_fecha_asociacion = null
    else
        select @w_fecha_asociacion = @i_fecha_asociacion			
		
    if @w_rol = @i_rol
        select @w_rol = null, @v_rol = null
    else
        select @w_rol = @i_rol	

    if @w_estado = @i_estado
        select @w_estado = null, @v_estado = null
    else
        select @w_estado = @i_estado		

    if @w_calif_interna = @i_calif_interna
        select @w_calif_interna = null, @v_calif_interna = null
    else
        select @w_calif_interna = @i_calif_interna

    if @w_fecha_desasociacion = @i_fecha_desasociacion
        select @w_fecha_desasociacion = null, @v_fecha_desasociacion = null
    else
        select @w_fecha_desasociacion = @i_fecha_desasociacion		            

    -- Transaccion servicio - cl_cliente_grupo --
    insert into cobis..ts_cliente_grupo (secuencial, tipo_transaccion, clase,  --1
                                         srv,        lsrv,             ente,   --2      
                                         grupo,      usuario,          terminal,--3
                                         oficial,    fecha_reg,        rol,     --4
                                         estado,     calif_interna,    fecha_desasociacion--5
                                         )
    values                              (@s_ssn,      810,              'P',       --1
                                         @s_srv,      @s_lsrv,          @i_ente,   --2                                     
                                         @i_grupo,    @s_user,          @s_term,   --3
                                         @v_oficial,  @v_fecha_asociacion, @v_rol, --4
                                         @v_estado,   @v_calif_interna, @v_fecha_desasociacion--5
                                         )
    -- Si no se puede insertar transaccion de servicio, error --
    if @@error != 0
    begin
        select @w_error = 103005 -- ERROR EN CREACION DE TRANSACCION DE SERVICIO
        goto ERROR
    end
	
	-- Actualizacion de registros
	update cobis..cl_cliente_grupo
	set    cg_rol                  = @i_rol,
           cg_estado               = @i_estado,
           cg_calif_interna        = @i_calif_interna,
           cg_ahorro_voluntario    = @i_cg_ahorro_voluntario, 
   		   cg_lugar_reunion		   = @i_cg_lugar_reunion    
           
	where  cg_ente = @i_ente and cg_grupo = @i_grupo

    -- Si no se puede modificar, error --
    if @@rowcount = 0
    begin
        select @w_error = 208906  --ERROR EN LA ACTUALIZACIÓN DEL MIEMBRO
        goto ERROR             
    end	

    -- Transaccion servicio - cl_cliente_grupo --
    insert into cobis..ts_cliente_grupo (secuencial, tipo_transaccion, clase,  --1
                                         srv,        lsrv,             ente,   --2      
                                         grupo,      usuario,          terminal,--3
                                         oficial,    fecha_reg,        rol,     --4
                                         estado,     calif_interna,    fecha_desasociacion--5
                                         )
    values                              (@s_ssn,      810,              'A',       --1
                                         @s_srv,      @s_lsrv,          @i_ente,   --2                                     
                                         @i_grupo,    @s_user,          @s_term,   --3
                                         @w_oficial,  @w_fecha_asociacion, @w_rol, --4
         @w_estado,   @w_calif_interna, @w_fecha_desasociacion--5
           )
    -- Si no se puede insertar transaccion de servicio, error --
    if @@error != 0
    begin
        exec cobis..sp_cerror
             @t_debug        = @t_debug,
             @t_file         = @t_file,
             @t_from         = @w_sp_name,
             @i_num          = 103005 -- ERROR EN CREACION DE TRANSACCION DE SERVICIO
        return 1
    end
end -- Fin Operacion U  

if @i_operacion = 'D' -- Desasignar 
begin
     -- verificar que exista el grupo --
     if not exists (select 1 from cobis..cl_grupo where gr_grupo = @i_grupo)
     begin
         select @w_error = 151029 -- NO EXISTE GRUPO
         goto ERROR
     end
     
    --Verifica si existe el grupo y el ente a modificar
    if not exists ( select 1 from cobis..cl_cliente_grupo where cg_ente = @i_ente and cg_grupo = @i_grupo)
    begin
         select @w_error = 208904 -- NO EXISTE EL MIEMBRO EN EL GRUPO A MODIFICAR
         goto ERROR
    end

	--Consulta de Datos
	select @w_ente                = cg_ente,
           @w_grupo               = cg_grupo,
           @w_usuario             = cg_usuario,
           --@w_terminal            = cg_terminal,
           @w_oficial             = cg_oficial,
           @w_fecha_asociacion    = cg_fecha_reg,
           @w_rol                 = cg_rol,
           @w_estado              = cg_estado,
           @w_calif_interna       = cg_calif_interna,
           @w_fecha_desasociacion = cg_fecha_desasociacion
           --@w_tipo_relacion       = cg_tipo_relacion
    from  cobis..cl_cliente_grupo
	where cg_ente = @i_ente and cg_grupo = @i_grupo
	
	-- INICIO DE DESASOCIACION
	begin tran
        -- desasignar en ente del grupo --		
		update cobis..cl_cliente_grupo
		set    cg_fecha_desasociacion = @s_date,
               cg_estado              = @i_estado	
        from   cobis..cl_cliente_grupo
	    where  cg_ente = @i_ente and cg_grupo = @i_grupo
	    -- si no se puede desasignar, error --
        if @@rowcount != 1 
        begin
             select @w_error = 101109 -- ERROR EN DESASIGNACION DE GRUPO
             goto ERROR	
        end

	    update cobis..cl_ente
	    set    en_grupo = null
	    where  en_ente   = @i_ente
	    and    en_grupo  = @i_grupo

        -- Transaccion servicio - ts_cliente_grupo --
        insert into cobis..ts_cliente_grupo (secuencial, tipo_transaccion, clase,  --1
                                   srv,        lsrv,             ente,   --2      
                                             grupo,      usuario,          terminal,--3
                                             oficial,    fecha_reg,        rol,     --4
                                             estado,     calif_interna,    fecha_desasociacion--5
                                             )
        values                              (@s_ssn,      810,              'B',       --1
                                             @s_srv,      @s_lsrv,          @i_ente,   --2                                     
                                             @i_grupo,    @s_user,          @s_term,   --3
                                             @w_oficial,  @s_date,          @w_rol, --4
                                             @w_estado,   @w_calif_interna, @w_fecha_desasociacion--5
                                             )
        -- Si no se puede insertar transaccion de servicio, error --
        if @@error != 0
        begin
            select @w_error = 103005 -- ERROR EN CREACION DE TRANSACCION DE SERVICIO
            goto ERROR
        end	
	commit tran
end -- FIN OPCION D

if @i_operacion = 'S'
begin
	
    set rowcount 20
    if @i_modo = 0
    begin
        select 'Ente'       = cg_ente,
               'Id_Grupo'   = cg_grupo,
               'Fecha_Aso'  = cg_fecha_reg,
               'Rol'        = cg_rol,
               'Estado'     = cg_estado,
               'Cal_Interna'= cg_calif_interna,
          'Fecha_Desasociacion' = cg_fecha_desasociacion,
               'Nombre_Cliente'      = en_nomlar, 	  
			   'Rol_Descrip'     = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_rol and codigo = CG.cg_rol),
			   'Estado_Descrip'      = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_estado and codigo = CG.cg_estado),
			   'Cal_Interna'         = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_calif and codigo = CG.cg_calif_interna),
			   'Lugar_Reunion'   	 = cg_lugar_reunion,
			   'Ahorro_Voluntario'   = cg_ahorro_voluntario
        from  cobis..cl_cliente_grupo CG, cobis..cl_ente EN
	    where cg_ente  = en_ente
		and   cg_grupo = @i_grupo
		and   cg_fecha_desasociacion is null
		order by cg_ente
   end

   if @i_modo = 1
   begin
        select 'Ente'       = cg_ente,
               'Id_Grupo'   = cg_grupo,
               'Fecha_Aso'  = cg_fecha_reg,
               'Rol'        = cg_rol,
               'Estado'     = cg_estado,
               'Cal_Interna'= cg_calif_interna,
               'Fecha_Desasociacion' = cg_fecha_desasociacion,
			   'Nombre_Cliente'      = en_nomlar,
			   'Rol_Descrip'         = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_rol and codigo = CG.cg_rol),
			   'Estado_Descrip'      = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_estado and codigo = CG.cg_estado),
			   'Cal_Interna'         = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_calif and codigo = CG.cg_calif_interna),
			   'Lugar_Reunion'   	 = cg_lugar_reunion,
			   'Ahorro_Voluntario'   = cg_ahorro_voluntario
        from  cobis..cl_cliente_grupo CG, cobis..cl_ente EN
	    where cg_ente  = en_ente
		and   cg_grupo = @i_grupo
		and   cg_ente  > @i_ente
		and   cg_fecha_desasociacion is null
		order by cg_ente
   end	
end -- FIN OPCION S

if @i_operacion = 'Q'
begin
	--Consulta de Datos
	select @w_ente                = cg_ente,
           @w_grupo               = cg_grupo,
           @w_fecha_asociacion    = cg_fecha_reg,
           @w_rol                 = cg_rol,
           @w_estado              = cg_estado,
           @w_calif_interna       = cg_calif_interna,
           @w_fecha_desasociacion = cg_fecha_desasociacion,
		   @w_cliente_nomlar      = en_nomlar,
		   @w_cg_ahorro_voluntario =cg_ahorro_voluntario,
           @w_cg_lugar_reunion 	   =cg_lugar_reunion,
		   @w_rol_desc             = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_rol and codigo = CG.cg_rol),
           @w_estado_desc          = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_estado and codigo = CG.cg_estado),
           @w_calif_interna_desc   = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_calif and codigo = CG.cg_calif_interna)
    from  cobis..cl_cliente_grupo CG, cobis..cl_ente EN
	where cg_ente  = en_ente
	and   cg_ente = @i_ente 
	and   cg_grupo = @i_grupo
	and   cg_fecha_desasociacion is null

	select 'Ente'       = @w_ente,
           'Id_Grupo'   = @w_grupo,
           'Fecha_Aso'  = @w_fecha_asociacion,
           'Rol'        = @w_rol,
           'Estado'     = @w_estado,
           'Cal_Interna'= @w_calif_interna,
           'Fecha_Desasociacion' = @w_fecha_desasociacion,
		   'Nombre_Cliente'      = @w_cliente_nomlar,
		   'Rol_Descrip'         = @w_rol_desc,
		   'Estado_Descrip'      = @w_estado_desc,
		   'Cal_Interna'         = @w_calif_interna_desc,
		   'Ahorro_Voluntario'   = @w_cg_ahorro_voluntario, 	  
		   'Lugar_Reunion'   	 = @w_cg_lugar_reunion
end -- FIN OPCION Q
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

