USE cob_pac
go
IF OBJECT_ID ('sp_deudores_busin') IS NOT NULL
    DROP PROCEDURE sp_deudores_busin
GO
CREATE PROCEDURE sp_deudores_busin (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_ofi                smallint  = null,
   @s_srv                varchar(30) = null,
   @s_lsrv               varchar(30) = null,
   @s_sesn               int = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_opcion             char(1)  = null,
   @i_tramite            int  = null,
   @i_cliente            int  = null,
   @i_rol                catalogo  = null,
   @i_ced_ruc            numero = null,
   @i_titular            int = null,
   @i_operacion_cca      cuenta = null,
   @i_secuencial         tinyint = null,
   @i_cartera            char(1) = 'N',
   @i_formato_fecha      int = null,   --Policia Nacional se incrementa para busqueda de deudores
   @i_ssn                int = 0,       --Policia Nacional se incrementa para deudores
   @i_fecha_cic          date = null,  --Policia Nacional se incrementa para deudores
   @i_canal              tinyint = 0
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_tramite            int,
   @w_cliente            int,
   @w_rol                catalogo,
   @w_nom_cliente        descripcion,
   @w_seccliente         int,          --Policia Nacional se incrementa para deudores
   @w_rol_wf             char(1),
   @w_tipo_solicit_grup  char(1)

select @w_today = @s_date
select @w_sp_name = 'sp_deudores'


/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 21013 and @i_operacion = 'I') or
   (@t_trn <> 21113 and @i_operacion = 'U') or
   (@t_trn <> 21213 and @i_operacion = 'D') or
   (@t_trn <> 21413 and @i_operacion = 'S') or
   (@t_trn <> 21513 and @i_operacion = 'Q')
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 2101006
    return 1 
end

  select @w_rol_wf = io_campo_7
  from   cob_workflow..wf_inst_proceso
  where  io_campo_3 = @i_tramite

  set @w_tipo_solicit_grup = 'S' -- Grupal

/* Chequeo de Existencias */

/**************************/
if @i_operacion <> 'S' 
begin
    if @w_rol_wf <> @w_tipo_solicit_grup
    begin
        select @w_tramite = de_tramite,
               @w_cliente = de_cliente,
               @w_nom_cliente = rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) + ' ' + rtrim(en_nombre),
               @w_rol = de_rol
        from   cob_credito..cr_deudores LEFT JOIN cobis..cl_ente ON  de_cliente = en_ente 
        where  de_tramite = @i_tramite 
		and    de_cliente = @i_cliente 
    end
    else
    begin
        select @w_tramite = de_tramite,
               @w_cliente = de_cliente,
               @w_nom_cliente = gr_nombre,
               @w_rol = de_rol
	    from   cob_credito..cr_deudores, cobis..cl_grupo
        where  de_tramite = @i_tramite
        and    de_cliente = @i_cliente 
		and    de_cliente = gr_grupo 
    end 
    if @@rowcount > 0
        select @w_existe = 1
    else
        select @w_existe = 0
		
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if 
         @i_tramite = NULL or 
         @i_cliente = NULL or 
         @i_rol = NULL or
     @i_ced_ruc = NULL
    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 2101001
        return 1 
    end
end

/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin
    if @w_existe = 1
    begin
    /* Registro ya existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 2101002
        return 1 
    end
    
    if @w_rol_wf = @w_tipo_solicit_grup
        select @i_rol = @w_rol_wf
    begin tran
         insert into cob_credito..cr_deudores(
              de_tramite,
              de_cliente,
              de_rol,
              de_ced_ruc)
         values (
              @i_tramite,
              @i_cliente,
              @i_rol,
              @i_ced_ruc)

         if @@error <> 0 
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 2103001
             return 1 
         end

         /* Transaccion de Servicio */
         /***************************/

         insert into cob_credito..ts_deudores
         values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,'cr_deudores',@s_lsrv,@s_srv,
         @i_tramite,
         @i_cliente,
         @i_rol,
         NULL
         )

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 2103003
             return 1 
         end
 
    /* Controles Adicionales para Operaciones de Cartera */
    if @i_cartera = 'S'
    begin

       -- Actualizacion de tabla ca_operacion
       if @i_rol = 'D'
       begin
          -- encontrar el nombre del cliente 
          select @w_nom_cliente = rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) + ' ' + rtrim(en_nombre)
          from  cobis..cl_ente
          where en_ente = @i_cliente

          update cob_cartera..ca_operacion
          set    op_cliente = @i_cliente,
             op_nombre  = @w_nom_cliente
          where  op_tramite = @i_tramite

          if @@rowcount != 1
          begin
                /* Error en insercion de registro */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file, 
                @t_from  = @w_sp_name,
                @i_num   = 2103001,
                @i_msg   = '[sp_deudores] Error al Actualizar Cliente en Cartera'
                return 1 
          end
       end
    end

    commit tran 
end

/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
    if @w_existe = 0
    begin
    /* Registro a actualizar no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 2105002
        return 1 
    end

    begin tran
        update cob_credito..cr_deudores
        set    de_rol = @i_rol
        where  de_tramite = @i_tramite 
		and    de_cliente = @i_cliente

        if @@error <> 0 
        begin
        /* Error en actualizacion de registro */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 2105001
            return 1 
        end

         /* Transaccion de Servicio */
         /***************************/

         insert into cob_credito..ts_deudores
         values (@s_ssn,     @t_trn,        'P',     @s_date,    @s_user,    @s_term,
		         @s_ofi,     'cr_deudores', @s_lsrv, @s_srv,     @w_tramite, 
				 @w_cliente, @w_rol,        NULL
                 )

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 2103003
             return 1 
         end

         /* Transaccion de Servicio */
         /***************************/

         insert into cob_credito..ts_deudores
         values (@s_ssn,     @t_trn,        'A',     @s_date, @s_user,    @s_term,
		         @s_ofi,     'cr_deudores', @s_lsrv, @s_srv,  @i_tramite,
                 @i_cliente, @i_rol, NULL
                 )

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 2103003
             return 1 
         end
    commit tran
end


/* Eliminacion de registros */
/****************************/

if @i_operacion = 'D'
begin
    if @w_existe = 0
    begin
    /* Registro a eliminar no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 2107002
        return 1 
    end


    begin tran
        delete cob_credito..cr_deudores
        where  de_tramite = @i_tramite 
		and    de_cliente = @i_cliente
                      
        if @@error <> 0
        begin
        /*Error en eliminacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 2107001
             return 1 
        end

         /* Transaccion de Servicio */
         /***************************/

         insert into cob_credito..ts_deudores
         values (@s_ssn,     @t_trn,      'B',      @s_date, @s_user,   @s_term,
		         @s_ofi,     'cr_deudores',@s_lsrv, @s_srv,  @w_tramite,
                 @w_cliente, @w_rol,       NULL
                )

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 2103003
             return 1 
         end
  
    commit tran
end

/**** Search ****/
/****************/

if @i_operacion = 'S'
begin

    if @w_rol_wf <> @w_tipo_solicit_grup
    begin
    set rowcount 20
    select @i_cliente = isnull(@i_cliente , 0)
        select  'Rol' = de_rol, 
                'Cliente' = de_cliente,
                'Nombre'  = ltrim(substring(rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) + ' ' + rtrim(en_nombre),1,36)), 
                'Ced/RUC' = de_ced_ruc,
                'Vinculado' = isnull(en_vinculacion,'N'),
                'debtorIdType' = (case when len(ltrim(rtrim(en_ced_ruc))) = 13 then '02' else (case when len(ltrim(rtrim(en_ced_ruc))) = 10 then '01' else '03' end) end),--e.en_tipo_ced,--Policia Nacional se comenta
                'qualification' = en_calificacion,
				'fechaCIC'    = null, --Se igual al GS
				'tipoPersona' = '', --Se igual al GS
				'SubTipo'     = '', --Se igual al GS
				'Nit'         = en_nit
        from    cob_credito..cr_deudores,   
                cobis..cl_ente   
        where   ( de_cliente = en_ente) and  
                ( de_tramite = @i_tramite) and
                ( de_cliente > @i_cliente) 
        order by de_rol desc
        set rowcount 0
    end
    else
    begin
        set rowcount 20
        select @i_cliente = isnull(@i_cliente , 0)
        select  'Rol' = de_rol, 
                'Cliente' = de_cliente,
                'Nombre'  = gr_nombre, 
                'Ced/RUC' = de_ced_ruc,
                'Vinculado' = 'N',
                'debtorIdType' = NULL,--(case when len(ltrim(rtrim(en_ced_ruc))) = 13 then '02' else (case when len(ltrim(rtrim(en_ced_ruc))) = 10 then '01' else '03' end) end),--e.en_tipo_ced,--Policia Nacional se comenta
                'qualification' = null,
				'fechaCIC'    = null, --Se igual al GS
				'tipoPersona' = '', --Se igual al GS
				'SubTipo'     = '', --Se igual al GS
				'nit'         = ''
        from    cob_credito..cr_deudores,   
                cobis..cl_grupo   
        where   ( de_cliente = gr_grupo) and  
                ( de_tramite = @i_tramite) and
                ( de_cliente > @i_cliente) 
        order by de_rol desc
        set rowcount 0
      end
end

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
    if @w_existe = 1
        select @w_tramite,
               @w_cliente,
               @w_nom_cliente,
               @w_rol
    else
    begin
    /*Registro no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 2101005
        return 1 
    end
end

--Se cambia a definitivas porque para santander se requiere guadar todos los codeudores
if @i_operacion = 'T'
begin

    --if(@i_rol != 'D' and @i_rol != 'G')
    --begin
        begin TRAN
           if @i_ssn = 0 -- null
           begin
              -- print 'llego nulo el secuencial del cliente'
              select @i_ssn = @s_ssn
           END 
           
		   if not exists (select 1 from cob_credito..cr_deudores where de_tramite = @i_tramite and de_cliente = @i_cliente and de_rol = @i_rol)
		   begin
               insert into cob_credito..cr_deudores(
                      de_tramite,
                      de_cliente,
                      de_rol,
                      de_ced_ruc,
                      de_cobro_cen)
                 values (
                      @i_tramite,
                      @i_cliente,
                      @i_rol,
                      @i_ced_ruc,
                      'N')                                   
               if @@error <> 0
               begin
                 /* Error en insercion de registro */
                  return 2103001
               end		   
		   end
    --end
    select @w_seccliente = @i_ssn
        if @i_canal = 0
        select @w_seccliente
    commit tran
    return 0    
    
end

--Policia Nacional se incrementa para busqueda de deudores
if @i_operacion = 'H'
    if @i_opcion = 'G'
    begin
        select 'NombreCompleto'     = gr_nombre,
               'TipoDocumento'      = '',
               'Identificacion'     = null,
               'Calificacion'       = null,
               'EstadoCivil'        = null,
               'Nit'                = null,    
               'FecNac'             = convert(char(10), cg_fecha_reg, @i_formato_fecha),
               'TipoVivienda'       = null,
               'PrimerNombre'       = null,
               'SegundoNombre'      = null,
               'PrimerApellido'     = null,
               'SegundoApellido'    = null,
               'NumHijos'           = null,
               'Profesiones'        = null,
               'Tipo'               = 'G',
               'SubTipo'            = null  
        from cobis..cl_grupo       
        inner join cobis..cl_cliente_grupo on (gr_grupo = cg_grupo)
        where cg_grupo = @i_cliente
    end
    else
    begin
        select 'NombreCompleto'     = e.en_nomlar,
               'TipoDocumento'      = (case when len(ltrim(rtrim(en_ced_ruc))) = 13 then '02' else (case when len(ltrim(rtrim(en_ced_ruc))) = 10 then '01' else '03' end) end),--e.en_tipo_ced,--Policia Nacional se comenta 
               'Identificacion'     = e.en_ced_ruc,
               'Calificacion'       = e.en_calificacion,--e.en_calif_cartera,--Policia Nacional se comenta,
               'EstadoCivil'        = (select  c.valor
                                       from cobis..cl_catalogo c, cobis..cl_tabla t
                                       where c.codigo       = e.p_estado_civil
                                         and c.tabla        = t.codigo
                                         and t.tabla        = 'cl_ecivil'),
                'Nit'               = isnull(e.en_rfc,''),
                'FecNac'            = convert(char(10), e.p_fecha_nac, @i_formato_fecha),
                'TipoVivienda'      = null,--e.p_tipo_vivienda,--Policia Nacional se comenta
                'PrimerNombre'      = e.en_nombre,
                'SegundoNombre'     = null,--e.p_s_nombre,--Policia Nacional se comenta
                'PrimerApellido'    = e.p_p_apellido,
                'SegundoApellido'   = e.p_s_apellido,
                'NumHijos'          = null,--e.p_num_hijos,--Policia Nacional se comenta
                'Profesiones'       = (select  c.valor
                                        from cobis..cl_catalogo c, cobis..cl_tabla t
                                        where c.codigo       = e.p_profesion
                                        and c.tabla        = t.codigo
                                        and t.tabla        = 'cl_profesion'),
                'Tipo'              = e.p_tipo_persona,
                'SubTipo'           = e.en_subtipo
        from    cobis..cl_ente e
        where   en_ente = @i_cliente

        if @@rowcount = 0
        begin
        /* NO EXISTE DATO SOLICITADO */
          return 101001
        end
    end

return 0
GO
