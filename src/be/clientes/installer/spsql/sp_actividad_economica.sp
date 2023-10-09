use cobis
go
if not object_id('sp_actividad_economica') is null
   drop proc sp_actividad_economica
go
CREATE PROCEDURE sp_actividad_economica(
   @s_ssn              int         = null,
   @s_user             login       = null,
   @s_sesn             int         = null,
   @s_culture          varchar(10) = null,
   @s_term             varchar(32) = null,
   @s_date             datetime    = null,
   @s_srv              varchar(30) = null,
   @s_lsrv             varchar(30) = null,
   @s_ofi              smallint    = null,
   @s_rol              smallint    = NULL,
   @s_org_err          char(1)     = NULL,
   @s_error            int         = NULL,
   @s_sev              tinyint     = NULL,
   @s_msg              descripcion = NULL,
   @s_org              char(1)     = NULL,
   @t_debug            char(1)     = 'N',
   @t_file             varchar(10) = null,
   @t_from             varchar(32) = null,
   @t_trn              smallint    = null,
   @t_show_version     bit        = 0,   --* Mostrar la version del programa
   @i_operacion        char(1)        ,             -- Opcion con la que se ejecuta el programa
   @i_modo             int         = null,  -- Modo de consulta
   @i_secuencial       int         = null,
   @i_ente             int         = null,
   @i_actividad        varchar(10) = null,
   @i_sector           varchar(10) = null,
   @i_subactividad     varchar(10) = null,
   @i_subsector        varchar(10) = null,
   @i_principal        char(1)     = null,
   @i_dias_atencion    varchar(10) = null,
   @i_horario_atencion varchar(20) = null,
   @i_fecha_ini        datetime    = null,
   @i_fuente_ingr      varchar(20) = null,
   @i_antiguedad       int         = null,
   @i_ambiente         varchar(20) = null,
   @i_autorizado       char(1)     = null,
   @i_afiliado         char(1)     = null,
   @i_lugar_afiliacion varchar(64) = null,
   @i_num_empleados    int         = null,
   @i_desc_actividad   varchar(255)= null,
   @i_desc_caedec      varchar(255)= null,
   @i_tipo_propiedad   varchar(10) = null, --ae_ubicacion
   @i_horario_act      varchar(20) = null,
   @i_estado           char(1)     = 'V',
   @i_verificado       char(1)     = null,
   @i_fecha_verif      datetime    = null,
   @i_fuente_verif     varchar(10) = null,
   @i_formato_fecha    int = 103,  -- NULL
   @i_aplicacion       char(1)     = 'C', --C=Clientes, O=Originador
   @i_filtro      	   varchar(50) = NULL,
   @i_codigo      	   varchar(10) = null,
   @o_fecha_ini        varchar(10) = null,
   @o_secuencial       int         = null out

)
as
declare @w_today      datetime,
  @w_sp_name          varchar(32),
  @w_return           int,
  @w_msg              varchar(100),
  @w_siguiente        int,
  @w_secuencial       int,
  @w_ente             int,
  @w_actividad        varchar(10),
  @w_sector           varchar(10),
  @w_subactividad     varchar(10),
  @w_subsector        varchar(10),
  @w_principal        char(1),
  @w_dias_atencion    varchar(10),
  @w_horario_atencion varchar(20),
  @w_fecha_ini        datetime,
  @w_fuente_ing       varchar(20),
  @w_antiguedad       int,
  @w_ambiente         varchar(20),
  @w_autorizado       char(1),
  @w_afiliado         char(1),
  @w_lugar_afiliacion varchar(64),
  @w_num_empleados    int,
  @w_desc_actividad   varchar(255),
  @w_desc_caedec      varchar(255),
  @w_tipo_propiedad   varchar(10), --ae_ubicacion
  @w_horario_act      varchar(20),
  @w_estado           char(1),
  @w_verificado       char(1),
  @w_fecha_verif      datetime,
  @w_fuente_verif     varchar(10),
  @w_ingresoF         varchar(10),
  @v_ente             int,
  @v_actividad        varchar(10),
  @v_sector           varchar(10),
  @v_subactividad     varchar(10),
  @v_subsector        varchar(10),
  @v_principal        char(1),
  @v_dias_atencion    varchar(10),
  @v_horario_atencion varchar(20),
  @v_fecha_ini        datetime,
  @v_fuente_ing       varchar(20),
  @v_antiguedad       int,
  @v_ambiente         varchar(20),
  @v_autorizado       char(1),
  @v_afiliado         char(1),
  @v_lugar_afiliacion varchar(64),
  @v_num_empleados    int,
  @v_desc_actividad   varchar(255),
  @v_desc_caedec      varchar(255),
  @v_tipo_propiedad   varchar(10), --ae_ubicacion
  @v_horario_act      varchar(20),
  @v_estado           char(1),
  @ae_actividad       varchar(10),
  @v_verificado       char(1),
  @v_fecha_verif      datetime,
  @v_fuente_verif     varchar(10),
  @w_error            int,
  @w_funcionario	  login,
  @v_funcionario	  login

select @w_today = @s_date
select @w_sp_name = 'sp_actividad_economica'

--* VERSIONAMIENTO DEL PROGRAMA
if @t_show_version = 1
begin
    print 'Stored procedure sp_actividad_economica, Version 4.0.0.0'
    return 0
end


/*Consulta para catalogos */
if @t_trn not in (2436,2437,2438,2439)
begin
    /* Error en codigo de transaccion */
    select @w_return  = 151051,
           @w_msg     = 'ERROR: CODIGO DE TRANSACCION NO CORRESPONDE'
    goto ERROR
end

if (@i_operacion = 'I' ) and (@t_trn =2437)
begin
    if exists ( select ae_secuencial  from cl_actividad_economica
                 where ae_secuencial = @i_secuencial )
    begin
       /*  Ya existe codigo para esa tabla  */
       select @w_return  = 101104,
              @w_msg     = 'ERROR: EL CODIGO PARA ESTA TABLA YA EXISTE'
       goto ERROR
    end

    -- Validacion Incidencia 62965

    if exists (select 1 from cl_actividad_economica
               where ae_ente = @i_ente
               and ae_actividad = @i_actividad
               and ae_sector = @i_sector
               and ae_subactividad = @i_subactividad
               and ae_subsector = @i_subsector
               and ae_secuencial <> @i_secuencial
               and ae_estado = 'V' )

    begin
         exec sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 107363 -- ERROR AL INGRESAR, ACTIVIDAD ECONOMICA DEL CLIENTE YA EXISTE
          return 107363
     end

    select @o_secuencial = isnull(max(ae_secuencial),0) + 1
      from cl_actividad_economica
    if @@rowcount = 0
    begin
       select @w_return  = 101003,
              @w_msg     = 'ERROR: NO EXISTE TABLA'
       goto ERROR
    end

    --
    select @w_principal = ae_principal
     from cl_actividad_economica
     where ae_ente = @i_ente

    --VALIDA QUE EXISTA UNA ACTIVIDAD PRINCIPAL POR ENTE Y ACTIVIDAD
    if exists (select 1 from cl_actividad_economica
     where ae_ente = @i_ente
     --and ae_actividad=@i_actividad
     and ae_principal='S'
     and @i_principal='S'
     and ae_estado='V')
     begin
         exec sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 107284
          return 107284
     end

    begin tran
      insert into cl_actividad_economica
               ( ae_secuencial,           ae_ente,                ae_actividad,
                 ae_sector,               ae_subactividad,        ae_subsector,
                 ae_fuente_ing,           ae_principal,           ae_dias_atencion,
                 ae_horario_atencion,     ae_fecha_inicio_act,    ae_antiguedad,
                 ae_ambiente,             ae_autorizado,          ae_afiliado,
                 ae_lugar_afiliacion,     ae_num_empleados,       ae_desc_actividad,
                 ae_ubicacion,            ae_horario_actividad,   ae_estado,
                 ae_desc_caedec,          ae_verificado,          ae_fecha_verificacion,
                 ae_fuente_verificacion,  ae_funcionario,         ae_fecha_modificacion)

         values( @o_secuencial,        @i_ente,                    @i_actividad,
                 @i_sector,            @i_subactividad,            @i_subsector,
                 @i_fuente_ingr,       @i_principal,               @i_dias_atencion,
                 @i_horario_atencion,  @i_fecha_ini,               @i_antiguedad,
                @i_ambiente,          @i_autorizado,              @i_afiliado,
                 @i_lugar_afiliacion,  @i_num_empleados,           @i_desc_actividad,
                 @i_tipo_propiedad,    @i_horario_act,             @i_estado,
                 @i_desc_caedec,       isnull(@i_verificado, 'N' ), @i_fecha_verif,
                 @i_fuente_verif,	   @s_user,                    @i_fecha_ini)--jve 57448

      if @@error <> 0
      begin
         select @w_return  = 103016,
                @w_msg     = 'ERROR: ERROR EN CREACION DE ACTIVIDAD'
                goto ERROR
      end
      select @o_secuencial
         --print "ss %1!",    @o_secuencial

    insert into ts_actividad_economica (
        secuencia,        tipo_transaccion,     clase,                fecha,               usuario,
        terminal_s,       srv,                  lsrv,                 hora,                ente,
        actividad,        sector,               subactividad,         subsector,           fuente_ing,
        principal,        dias_atencion,        horario_atencion,     fecha_inicio_act,    antiguedad,
        ambiente,         autorizado,           afiliado,             lugar_afiliacion,    num_empleados,
        desc_actividad,   ubicacion,            horario_actividad,    estado_ae,           desc_caedec,
        verificado,       fecha_verificacion,   fuente_verificacion,	oficina
       )values(
        @s_ssn,              @t_trn,              'N',                   @s_date,               @s_user,
        @s_term,             @s_srv,              @s_lsrv,               getdate(),             @i_ente,
        @i_actividad,        @i_sector,           @i_subactividad,       @i_subsector,          @i_fuente_ingr,
        @i_principal,        @i_dias_atencion,    @i_horario_atencion,   @i_fecha_ini,          @i_antiguedad,
        @i_ambiente,         @i_autorizado,       @i_afiliado,           @i_lugar_afiliacion,   @i_num_empleados,
        @i_desc_actividad,   @i_tipo_propiedad,   @i_horario_act,        @i_estado,             @i_desc_caedec,
        isnull(@i_verificado, 'N' ),       @i_fecha_verif,      @i_fuente_verif,	@s_ofi
       )

       if @@error <> 0
       begin
         exec sp_cerror
           @t_debug    = @t_debug,
           @t_file     = @t_file,
           @t_from     = @w_sp_name,
           @i_num      = 103005
            /* 'Error en creacion de transaccion de servicio'*/
         return 103005
       end


    commit tran
end  --@i_operacion


if (@i_operacion = 'S' ) and (@t_trn =2436)
begin
  --set rowcount 20	--67948
  if @i_aplicacion = 'C' begin  --Clientes
      set rowcount 2   --INC 73486
  end
  else if @i_aplicacion = 'O' begin --Originador
      set rowcount 20
  end

         if @i_modo = 0

        select 'SECUENCIAL'          = ae_secuencial,
               'CLIENTE'             = ae_ente,
               'SECTOR'              = ae_sector,
               'SUB SECTOR'          = ae_subsector,
               'ACTIVIDAD'           = ae_actividad,
               'ACTIVIDAD FIE'       = ae_subactividad,   --FIE CC225  JMA
               'HORARIO DE ATENCION' = ae_horario_atencion,
               'NRO EMPLEADOS'       = ae_num_empleados,
               'PRINCIPAL'           = ae_principal,
               'DIAS DE ATENCION'    = ae_dias_atencion,
               'AMBIENTE'            = ae_ambiente,
               'TIPO DE PROPIEDAD'   = ae_ubicacion,
               'FUENTE DE INGRESO'   = ae_fuente_ing,
               'FECHA INICIO ACT'    = convert(varchar(10),ae_fecha_inicio_act,@i_formato_fecha), --substring(ae_fecha_inicio_act,1,10),
               'ANTIGUEDAD'          = ae_antiguedad,
               'AUTORIZADO'          = ae_autorizado,
               'AFILIADO'            = ae_afiliado,
               'LUGAR DE AFILIACION' = ae_lugar_afiliacion,
               'HORARIO ACTIVIDAD'   = ae_horario_actividad,
    'DESCRIP. CAEDEC'     = ae_desc_caedec,
               'DESCRIP. ACTIVIDAD'  = ae_desc_actividad,
               'VERIFICADO'          = ae_verificado,
               'FECHA VERIF.'        = convert(varchar(10),ae_fecha_verificacion,@i_formato_fecha), --substring(ae_fecha_verificacion,1,10),
               'FUENTE VERIF.'       = ae_fuente_verificacion,
               'ACLARACION FIE'      = (select se_aclaracionFie  from cobis..cl_subactividad_ec where se_codigo=c.ae_subactividad),
               'ACLARACION FIE 2'    = (select se_aclaracionFie2 from cobis..cl_subactividad_ec where se_codigo=c.ae_subactividad), --FIE CC225  JMA
               'ACLARACION FIE 3'    = (select se_aclaracionFie3 from cobis..cl_subactividad_ec where se_codigo=c.ae_subactividad), --FIE CC225  JMA
               'ACLARACION FIE 4'    = (select se_aclaracionFie4 from cobis..cl_subactividad_ec where se_codigo=c.ae_subactividad)  --FIE CC225  JMA
        from cobis..cl_actividad_economica c
       where ae_ente = @i_ente
         and ae_estado = @i_estado
       order by ae_secuencial

         else
        if @i_modo = 1

        select 'SECUENCIAL'			 = ae_secuencial,
               'CLIENTE'			 = ae_ente,
               'SECTOR'				 = ae_sector,
               'SUB SECTOR'			 = ae_subsector,
               'ACTIVIDAD'			 = ae_actividad,
               'ACTIVIDAD FIE'		 = ae_subactividad,
               'HORARIO DE ATENCION' = ae_horario_atencion,
               'NRO EMPLEADOS'		 = ae_num_empleados,
               'PRINCIPAL'			 = ae_principal,
               'DIAS DE ATENCION'    = ae_dias_atencion,
               'AMBIENTE'            = ae_ambiente,
               'TIPO DE PROPIEDAD'   = ae_ubicacion,
               'FUENTE DE INGRESO'   = ae_fuente_ing,
               'FECHA INICIO ACT'    = convert(varchar(10),ae_fecha_inicio_act,@i_formato_fecha),
               'ANTIGUEDAD'          = ae_antiguedad,
               'AUTORIZADO'          = ae_autorizado,
               'AFILIADO'            = ae_afiliado,
               'LUGAR DE AFILIACION' = ae_lugar_afiliacion,
               'HORARIO ACTIVIDAD'   = ae_horario_actividad,
               'DESCRIP. CAEDEC'     = ae_desc_caedec,
               'DESCRIP. ACTIVIDAD'  = ae_desc_actividad,
               'VERIFICADO'          = ae_verificado,
               'FECHA VERIF.'        = convert(varchar(10),ae_fecha_verificacion,@i_formato_fecha),
               'FUENTE VERIF.'       = ae_fuente_verificacion,
               'ACLARACION FIE'      = (select se_aclaracionFie from cobis..cl_subactividad_ec where se_codigo=c.ae_subactividad),
               'ACLARACION FIE 2'    = (select se_aclaracionFie2 from cobis..cl_subactividad_ec where se_codigo=c.ae_subactividad), --FIE CC225  JMA
               'ACLARACION FIE 3'    = (select se_aclaracionFie3 from cobis..cl_subactividad_ec where se_codigo=c.ae_subactividad), --FIE CC225  JMA
               'ACLARACION FIE 4'    = (select se_aclaracionFie4 from cobis..cl_subactividad_ec where se_codigo=c.ae_subactividad)  --FIE CC225  JMA
        from cobis..cl_actividad_economica c
       where ae_secuencial > @i_secuencial
         and ae_ente = @i_ente
         and ae_estado = @i_estado
       order by ae_secuencial
         set rowcount 0
         return 0

end  --@i_operacion

--consulta impresion de datos
if (@i_operacion = 'W' ) and (@t_trn =2436)
begin
  set rowcount 1
         if @i_modo = 0

		  select 'SECUENCIAL'          = ae_secuencial,
               'CLIENTE'             = ae_ente,
               'SECTOR'              = ae_sector,
               'SECTOR Desc'              = (select se_descripcion   from cobis..cl_sector_economico where se_codigo= c.ae_sector ),
               'SUB SECTOR'          = ae_subsector,
			   'SUB SECTOR Desc'         = (select se_descripcion   from cobis..cl_subsector_ec where se_codigo = c.ae_subsector),
               'ACTIVIDAD'           = ae_actividad,
			   'ACTIVIDAD Desc'     = (select ac_descripcion   from cobis..cl_actividad_ec where ac_codigo = c.ae_actividad),
               'ACTIVIDAD FIE'       = ae_subactividad,
               'ACTIVIDAD FIE Desc' = (select se_descripcion    from cobis..cl_subactividad_ec where se_codigo=c.ae_subactividad),
               'FUENTE INGRESO'   = ae_fuente_ing,
			   'FUENTE INGRESO Desc'   = (select valor from cobis..cl_catalogo where tabla in(select codigo from cl_tabla where tabla ='cl_fuente_ingreso') and codigo = c.ae_fuente_ing),
               'NRO EMPLEADOS'       = ae_num_empleados,
               'DESCRIP. CAEDEC'     = ae_desc_caedec,
               'DESCRIP. ACTIVIDAD'  = ae_desc_actividad
        from cobis..cl_actividad_economica c
          where ae_ente = @i_ente
         and ae_estado = @i_estado
		and ae_principal ='S'
       order by ae_secuencial


         set rowcount 0
         return 0

end  --@i_operacion

/*Consulta actividad economica principal de un cliente*/
if (@i_operacion = 'Q' ) and (@t_trn =2436)
begin
   select   ae_actividad,
            b.valor
        from cobis..cl_actividad_economica c,cobis..cl_tabla a,cobis..cl_catalogo b
       where ae_ente = @i_ente
         and ae_principal = 'S'
         and a.tabla  = 'cl_actividad_ec'
         and a.codigo = b.tabla
         and b.codigo = c.ae_actividad
        if @@rowcount <> 1
        begin
            /*  No existe actividad economica  */
            exec cobis..sp_cerror
                @t_debug= @t_debug,
                @t_file = @t_file,
                @t_from = @w_sp_name,
                @i_num  = 101259
            return 1
        end

      return 0
end
/*fin*/

if (@i_operacion = 'U' ) and (@t_trn =2438)
begin
        select   @w_ente              = ae_ente,
                 @w_actividad         = ae_actividad,
                 @w_sector            = ae_sector,
                 @w_subactividad      = ae_subactividad,
                 @w_subsector         = ae_subsector,
                 @w_fuente_ing        = ae_fuente_ing,
                 @w_principal         = ae_principal,
                 @w_dias_atencion     = ae_dias_atencion,
                 @w_horario_atencion  = ae_horario_atencion,
                 @w_fecha_ini         = ae_fecha_inicio_act,--convert(varchar(10),ae_fecha_inicio_act,@i_formato_fecha),
                 @w_antiguedad        = ae_antiguedad,
                 @w_ambiente          = ae_ambiente,
                 @w_autorizado        = ae_autorizado,
                 @w_afiliado          = ae_afiliado,
                 @w_lugar_afiliacion  = ae_lugar_afiliacion,
                 @w_num_empleados     = ae_num_empleados,
                 @w_desc_actividad    = ae_desc_actividad,
                 @w_tipo_propiedad    = ae_ubicacion,
                 @w_horario_act       = ae_horario_actividad,
                 @w_desc_caedec       = ae_desc_caedec,
                 @w_estado            = ae_estado,
                 @w_verificado        = ae_verificado,
                 @w_fecha_verif       = ae_fecha_verificacion,--convert(varchar(10),ae_fecha_verificacion,@i_formato_fecha),
                 @w_fuente_verif      = ae_fuente_verificacion,
				 @w_funcionario		  = ae_funcionario
          from  cl_actividad_economica
         where  ae_secuencial    = @i_secuencial

        if @@rowcount <> 1
        begin
            /*  Registro a actualizar no existe  */
            exec cobis..sp_cerror
                @t_debug= @t_debug,
                @t_file = @t_file,
                @t_from = @w_sp_name,
                @i_num  = 605082
            return 1
        end

        --VALIDA QUE EXISTA UNA ACTIVIDAD PRINCIPAL POR ENTE Y ACTIVIDAD

        if exists (select 1 from cl_actividad_economica
                  where ae_ente = @i_ente
                  --and ae_actividad=@i_actividad    --CC-CLI-323
                  and ae_principal='S'
                  and @i_principal='S'
                  and ae_estado='V'
                  and ae_secuencial<>@i_secuencial)
             begin
                 exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 107284
                  return 107284
             end

        ------

		--VALIDA SI EL SECTOR ECONOMICO DE LA ACT. ECON. ES INGRESO FIJO Y TIENE ASOCIADO UN EMPLEO

		if @i_sector <> @w_sector
		begin
           select @w_ingresoF = pa_char from cobis..cl_parametro where pa_nemonico='PDEP' and pa_producto='CLI'

		   if @w_sector = @w_ingresoF
		   begin
              if exists (select 1 from cl_trabajo
                        where tr_persona = @i_ente
                          and tr_actividad_ingresof =  @i_secuencial)
              begin
                  exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 107361
                   return 107361
              end
		   end
		end


        -- Validacion Incidencia 62965

        if exists (select 1 from cl_actividad_economica
                   where ae_ente = @i_ente
                   and ae_actividad = @i_actividad
                   and ae_sector = @i_sector
                   and ae_subactividad = @i_subactividad
                   and ae_subsector = @i_subsector
                   and ae_secuencial <> @i_secuencial
                   and ae_estado = 'V')

       begin
            exec sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 107364 -- ERROR AL ACTUALIZAR, ACTIVIDAD ECONOMICA DEL CLIENTE YA EXISTE
            return 107364
       end

		-----

        select @v_ente               = @w_ente,
               @v_actividad          = @w_actividad,
               @v_sector             = @w_sector,
               @v_subactividad       = @w_subactividad,
               @v_subsector          = @w_subsector,
               @v_fuente_ing         = @w_fuente_ing,
               @v_principal          = @w_principal,
               @v_dias_atencion      = @w_dias_atencion,
               @v_horario_atencion   = @w_horario_atencion,
               @v_fecha_ini          = @w_fecha_ini,
               @v_antiguedad         = @w_antiguedad,
               @v_ambiente           = @w_ambiente,
               @v_autorizado         = @w_autorizado,
               @v_afiliado           = @w_afiliado,
               @v_lugar_afiliacion   = @w_lugar_afiliacion,
               @v_num_empleados      = @w_num_empleados,
               @v_desc_actividad     = @w_desc_actividad,
               @v_tipo_propiedad     = @w_tipo_propiedad,
               @v_desc_actividad     = @w_desc_actividad,
               @v_horario_act        = @w_horario_act,
               @v_desc_caedec        = @w_desc_caedec,
               @v_estado             = @w_estado,
               @v_verificado         = @w_verificado,
               @v_fecha_verif        = @w_fecha_verif,
               @v_fuente_verif       = @w_fuente_verif,
			   @v_funcionario		 = @w_funcionario


--        if @w_actividad = @i_actividad
--               select @w_actividad = null, @v_actividad = null
--            else
--               select @w_actividad = @i_actividad
--
--        if @w_sector = @i_sector
--               select @w_sector = null, @v_sector = null
--            else
--               select @w_sector = @i_sector
--
--        if @w_subactividad = @i_subactividad
--               select @w_subactividad = null, @v_subactividad = null
--            else
--               select @w_subactividad = @i_subactividad
--
--        if @w_subsector = @i_subsector
--               select @w_subsector = null, @v_subsector = null
--            else
--               select @w_subsector = @i_subsector

        if @w_fuente_ing = @i_fuente_ingr
               select @w_fuente_ing = null, @v_fuente_ing = null
            else
               select @w_fuente_ing = @i_fuente_ingr

        if @w_principal = @i_principal
               select @w_principal = null, @v_principal = null
            else
               select @w_principal = @i_principal

        if @w_dias_atencion = @i_dias_atencion
               select @w_dias_atencion = null, @v_dias_atencion = null
            else
               select @w_dias_atencion = @i_dias_atencion

        if @w_horario_atencion = @i_horario_atencion
               select @w_horario_atencion = null, @v_horario_atencion = null
            else
               select @w_horario_atencion = @i_horario_atencion

        if @w_fecha_ini = @i_fecha_ini
               select @w_fecha_ini = null, @v_fecha_ini = null
            else
               select @w_fecha_ini = @i_fecha_ini

        if @w_antiguedad = @i_antiguedad
               select @w_antiguedad = null, @v_antiguedad = null
            else
               select @w_antiguedad = @i_antiguedad

       if @w_ambiente = @i_ambiente
               select @w_ambiente = null, @v_ambiente = null
            else
               select @w_ambiente = @i_ambiente

        if @w_autorizado = @i_autorizado
               select @w_autorizado = null, @v_autorizado = null
            else
               select @w_autorizado = @i_autorizado

        if @w_afiliado = @i_afiliado
               select @w_afiliado = null, @v_afiliado = null
            else
               select @w_afiliado = @i_afiliado

        if @w_lugar_afiliacion = @i_lugar_afiliacion
               select @w_lugar_afiliacion = null, @v_lugar_afiliacion = null
            else
               select @w_lugar_afiliacion = @i_lugar_afiliacion

        if @w_num_empleados = @i_num_empleados
               select @w_num_empleados = null, @v_num_empleados = null
            else
               select @w_num_empleados = @i_num_empleados

        if @w_desc_actividad = @i_desc_actividad
               select @w_desc_actividad = null, @v_desc_actividad = null
            else
               select @w_desc_actividad = @i_desc_actividad

        if @w_tipo_propiedad = @i_tipo_propiedad
               select @w_tipo_propiedad = null, @v_tipo_propiedad = null
            else
               select @w_tipo_propiedad = @i_tipo_propiedad

        if @w_horario_act = @i_horario_act
               select @w_horario_act = null, @v_horario_act = null
            else
               select @w_horario_act = @i_horario_act

        if @w_desc_caedec = @i_desc_caedec
               select @w_desc_caedec = null, @v_desc_caedec = null
            else
               select @w_desc_caedec = @i_desc_caedec

        if @w_estado = @i_estado
               select @w_estado = null, @v_estado = null
            else
               select @w_estado = @i_estado

        if @w_verificado = @i_verificado
               select @w_verificado = null, @v_verificado = null
            else
               select @w_verificado = @i_verificado

        if @w_fecha_verif = @i_fecha_verif
               select @w_fecha_verif = null, @v_fecha_verif = null
            else
               select @w_fecha_verif = @i_fecha_verif

        if @w_fuente_verif = @i_fuente_verif
               select @w_fuente_verif = null, @v_fuente_verif = null
            else
               select @w_fuente_verif = @i_fuente_verif

		if @w_funcionario = @s_user
               select @w_funcionario = null, @v_funcionario = null
            else
               select @w_funcionario = @s_user


        begin tran
        update  cl_actividad_economica
           set   ae_actividad           = @i_actividad,
               ae_sector              = @i_sector,
                 ae_subactividad        = @i_subactividad,
                 ae_subsector           = @i_subsector,
                 ae_fuente_ing          = @i_fuente_ingr,
                 ae_principal           = @i_principal,
                 ae_dias_atencion       = @i_dias_atencion,
                 ae_horario_atencion    = @i_horario_atencion,
                 ae_fecha_inicio_act    = @i_fecha_ini,
                 ae_antiguedad          = @i_antiguedad,
                 ae_ambiente            = @i_ambiente,
                 ae_autorizado          = @i_autorizado,
                 ae_afiliado            = @i_afiliado,
                 ae_lugar_afiliacion    = @i_lugar_afiliacion,
                 ae_num_empleados       = @i_num_empleados,
                 ae_desc_actividad      = @i_desc_actividad,
                 ae_ubicacion           = @i_tipo_propiedad,
                 ae_horario_actividad   = @i_horario_act,
                 ae_desc_caedec         = @i_desc_caedec,
                 ae_estado              = @i_estado,
                 ae_verificado          =  isnull(@i_verificado, 'N' ),
                 ae_fecha_verificacion  = case @i_verificado when 'S' then @i_fecha_verif else null end,
                 ae_fuente_verificacion = @i_fuente_verif,
				 ae_funcionario			= @s_user,
				 ae_fecha_modificacion  = @s_date
         where  ae_secuencial    = @i_secuencial

        /*  Error en actualizacion   */
        if @@error <> 0
        begin
          exec cobis..sp_cerror
                @t_debug= @t_debug,
                @t_file = @t_file,
                @t_from = @w_sp_name,
                @i_num  = 105070
           return 1
        end

        insert into ts_actividad_economica (
        secuencia,          tipo_transaccion,       clase,                fecha,               usuario,
        terminal_s,         srv,                    lsrv,                 hora,                ente,
        actividad,          sector,                 subactividad,         subsector,           fuente_ing,
        principal,          dias_atencion,          horario_atencion,     fecha_inicio_act,    antiguedad,
        ambiente,           autorizado,             afiliado,             lugar_afiliacion,    num_empleados,
        desc_actividad,     ubicacion,              horario_actividad,    estado_ae,           desc_caedec,
        verificado,         fecha_verificacion,     fuente_verificacion,	oficina
       )values(
        @s_ssn,             @t_trn,                 'P',                  @s_date,             @s_user,
        @s_term,            @s_srv,                 @s_lsrv,              getdate(),           @i_ente,
        @i_actividad,       @i_sector,              @i_subactividad,      @i_subsector,        @v_fuente_ing,
        @v_principal,       @v_dias_atencion,       @v_horario_atencion,  @v_fecha_ini,        @v_antiguedad,
        @v_ambiente,        @v_autorizado,          @v_afiliado,          @v_lugar_afiliacion, @v_num_empleados,
        @v_desc_actividad,  @v_tipo_propiedad,      @v_horario_act,       @v_estado,           @v_desc_caedec,
        @v_verificado,      @v_fecha_verif,         @v_fuente_verif,	@s_ofi
       )

       if @@error <> 0
       begin
         exec sp_cerror
           @t_debug    = @t_debug,
           @t_file     = @t_file,
           @t_from     = @w_sp_name,
           @i_num      = 103005
            /* 'Error en creacion de transaccion de servicio'*/
         return 103005
       end

       insert into ts_actividad_economica (
        secuencia,          tipo_transaccion,       clase,                fecha,               usuario,
        terminal_s,         srv,                    lsrv,                 hora,                ente,
        actividad,          sector,                 subactividad,         subsector,           fuente_ing,
        principal,          dias_atencion,          horario_atencion,     fecha_inicio_act,    antiguedad,
        ambiente,           autorizado,             afiliado,             lugar_afiliacion,    num_empleados,
        desc_actividad,     ubicacion,              horario_actividad,    estado_ae,           desc_caedec,
        verificado,         fecha_verificacion,     fuente_verificacion,  oficina
       )values(
        @s_ssn,             @t_trn,                 'A',                  @s_date,               @s_user,
        @s_term,            @s_srv,                 @s_lsrv,              getdate(),             @i_ente,
        @i_actividad,       @i_sector,              @i_subactividad,      @i_subsector,          @w_fuente_ing,
        @w_principal,       @w_dias_atencion,       @w_horario_atencion,  @w_fecha_ini,          @w_antiguedad,
        @w_ambiente,        @w_autorizado,          @w_afiliado,          @w_lugar_afiliacion,   @w_num_empleados,
        @w_desc_actividad,  @w_tipo_propiedad,      @w_horario_act,       @w_estado,             @w_desc_caedec,
        @w_verificado,      @w_fecha_verif,         @w_fuente_verif,	  @s_ofi
       )

       if @@error <> 0
       begin
         exec sp_cerror
           @t_debug    = @t_debug,
           @t_file     = @t_file,
           @t_from     = @w_sp_name,
           @i_num      = 103005
            /* 'Error en creacion de transaccion de servicio'*/
         return 103005
       end
        commit tran
        return 0

end  --@i_operacion

if (@i_operacion = 'Q' ) and (@t_trn = 2436)
begin
 DECLARE contActPrin CURSOR
     FOR
        select  distinct ae_actividad
        from cobis..cl_actividad_economica
        where ae_ente = @i_ente

           OPEN contActPrin
           fetch next from contActPrin INTO  @ae_actividad

         while @@FETCH_STATUS = 0--@@sqlstatus != 2
         begin
             if @@FETCH_STATUS = -1--@@sqlstatus = 1
              begin
                close contActPrin
                deallocate contActPrin
                select @w_msg   = 'Error al manejar cursor',
                       @w_error = 710004
                return 710004
              end
          -- SETEO VALORES INICIALES
              select @w_error = 0

         if not exists (select 1 from cl_actividad_economica where ae_ente=@i_ente and ae_actividad=@ae_actividad and ae_principal='S' and ae_estado='V')
              begin
                 exec sp_cerror
                  @t_debug    = @t_debug,
                  @t_file     = @t_file,
                  @t_from     = @w_sp_name,
                  @i_num      = 107289
                  /* Error Toda Actividad Económica deber una como principal*/
                  return 107289
              end
         fetch next from contActPrin INTO  @ae_actividad
        end
        CLOSE contActPrin
        DEALLOCATE contActPrin
end
  --@i_operacion

if (@i_operacion = 'D' ) and (@t_trn =2439)
begin
    if not exists (select
     1 from  cl_actividad_economica
     where  ae_secuencial    = @i_secuencial)
        begin
            /*  Registro a eliminar no existe  */
            exec cobis..sp_cerror
                @t_debug= @t_debug,
                @t_file = @t_file,
                @t_from = @w_sp_name,
                @i_num  = 107285
            return 107285
        end

    if exists (select
     1 from  cl_actividad_economica
     where  ae_secuencial = @i_secuencial
     and ae_principal='S')
        begin
            /*  Error al eliminar una activida principal  */
            exec cobis..sp_cerror
                @t_debug= @t_debug,
                @t_file = @t_file,
                @t_from = @w_sp_name,
                @i_num  = 107287
            return 107287
        end

	--VALIDA SI EL SECTOR ECONOMICO DE LA ACT. ECON. ES INGRESO FIJO Y TIENE ASOCIADO UN EMPLEO

	select @w_sector =  ae_sector,
           @w_actividad         = ae_actividad,	--69161
           @w_sector            = ae_sector,	--69161
           @w_subactividad      = ae_subactividad,	--69161
           @w_subsector         = ae_subsector,	--69161
           @w_fuente_ing        = ae_fuente_ing,
           @w_principal         = ae_principal,
           @w_dias_atencion     = ae_dias_atencion,
           @w_horario_atencion  = ae_horario_atencion,
           @w_fecha_ini         = ae_fecha_inicio_act,
           @w_antiguedad        = ae_antiguedad,
           @w_ambiente          = ae_ambiente,
           @w_autorizado        = ae_autorizado,
           @w_afiliado          = ae_afiliado,
           @w_lugar_afiliacion  = ae_lugar_afiliacion,
           @w_num_empleados     = ae_num_empleados,
           @w_desc_actividad    = ae_desc_actividad,
           @w_horario_act       = ae_horario_actividad,
           @w_tipo_propiedad    = ae_ubicacion,
           @w_desc_caedec       = ae_desc_caedec,
           @w_estado            = ae_estado,
           @w_verificado        = ae_verificado,
           @w_fecha_verif       = ae_fecha_verificacion,
           @w_fuente_verif      = ae_fuente_verificacion
	  from  cl_actividad_economica
     where  ae_secuencial = @i_secuencial

	select @w_ingresoF = pa_char from cobis..cl_parametro where pa_nemonico='PDEP' and pa_producto='CLI'

	if @w_sector = @w_ingresoF
	begin
          if exists (select 1 from cl_trabajo
                    where tr_persona = @i_ente
                      and tr_actividad_ingresof =  @i_secuencial)
          begin
              exec sp_cerror
                 @t_debug    = @t_debug,
                 @t_file     = @t_file,
                 @t_from     = @w_sp_name,
                 @i_num      = 107362
               return 107362
          end
	end
	--

    begin tran
        update  cl_actividad_economica
           set   ae_estado='C'
         where   ae_secuencial    = @i_secuencial

        /*  Error en actualizacion   */
        if @@error <> 0
        begin
          exec cobis..sp_cerror
                @t_debug= @t_debug,
                @t_file = @t_file,
                @t_from = @w_sp_name,
                @i_num  = 107286
           return 107286
        end

        insert into ts_actividad_economica (
        secuencia,          tipo_transaccion,       clase,                fecha,               usuario,
        terminal_s,         srv,                    lsrv,                 hora,                ente,
        actividad,          sector,                 subactividad,         subsector,           fuente_ing,
        principal,          dias_atencion,          horario_atencion,     fecha_inicio_act,    antiguedad,
        ambiente,           autorizado,             afiliado,             lugar_afiliacion,    num_empleados,
        desc_actividad,     ubicacion,              horario_actividad,    estado_ae,           desc_caedec,
        verificado,         fecha_verificacion,     fuente_verificacion,  oficina

       )values(
        @s_ssn,             @t_trn,                 'B',                  @s_date,             @s_user,
        @s_term,            @s_srv,                 @s_lsrv,              getdate(),           @i_ente,
        @w_actividad,       @w_sector,              @w_subactividad,      @w_subsector,        @w_fuente_ing,
        @w_principal,       @w_dias_atencion,       @w_horario_atencion,  @w_fecha_ini,        @w_antiguedad,
        @w_ambiente,        @w_autorizado,          @w_afiliado,          @w_lugar_afiliacion, @w_num_empleados,
        @w_desc_actividad,  @w_tipo_propiedad,      @w_horario_act,       @w_estado,           @w_desc_caedec,
        @w_verificado,      @w_fecha_verif,         @w_fuente_verif,	  @s_ofi
       )

       if @@error <> 0
       begin
         exec sp_cerror
           @t_debug    = @t_debug,
           @t_file     = @t_file,
           @t_from     = @w_sp_name,
    @i_num      = 103005
            /* 'Error en creacion de transaccion de servicio'*/
         return 103005
       end

    commit tran
end

--Consulta de AE cuando el sector es Ingreso Fijo
if (@i_operacion = 'H' ) and (@t_trn = 2436)
begin
   select @w_ingresoF = pa_char from cobis..cl_parametro where pa_nemonico='PDEP' and pa_producto='CLI'
   set rowcount 20
   select 'SECUENCIAL'          = ae_secuencial,
          'CLIENTE'             = ae_ente,
          'COD. SECTOR'         = ae_sector,
		  'SECTOR'              = (select b.valor from cobis..cl_tabla a,cobis..cl_catalogo b
                                   where a.tabla  = 'cl_sector_economico'
                                     and a.codigo = b.tabla
									 and b.codigo = c.ae_sector),
          'SUB SECTOR'          = ae_subsector,
          'ACTIVIDAD'           = ae_actividad,
          'ACTIVIDAD FIE'       = ae_subactividad,
          'HORARIO DE ATENCION' = ae_horario_atencion,
          'PRINCIPAL'           = ae_principal
     from cl_actividad_economica c
   where ae_ente   = @i_ente
     and ae_sector = @w_ingresoF
     and ae_estado = 'V'
	 and (@i_secuencial = null or ae_secuencial > = @i_secuencial )

   set rowcount 0
end

--Consulta de Catalogo con Filtro de Servidor
if (@i_operacion = 'C') and (@t_trn = 2436)
begin
	
	
	
   	if(@i_codigo is null )
   	begin
	   	set rowcount 20
	
		select  
		'OFICIAL' = ac_codigo,
		'NOMBRE'  = substring(ac_descripcion,1,150)
		from cobis..cl_actividad_ec
		where UPPER(ac_descripcion) like UPPER(@i_filtro+'%')
		order by ac_descripcion
		
		set transaction isolation level read uncommitted
	
		set rowcount 0
		return 0
	end
	else
   	begin
	   	
	   	select @i_filtro = substring(ac_descripcion,1,150) from cobis..cl_actividad_ec where ac_codigo = @i_codigo
	   	
	   	set rowcount 20
		
		select  
		'OFICIAL' = ac_codigo,
		'NOMBRE'  = substring(ac_descripcion,1,150)
		from cobis..cl_actividad_ec
		where UPPER(ac_descripcion) like UPPER(@i_filtro+'%')
		order by ac_descripcion
		
		set transaction isolation level read uncommitted
	
		set rowcount 0
		return 0
	end
	
end

return 0
ERROR:
exec cobis..sp_cerror
     @t_debug = @t_debug,
     @t_file  = @t_file,
     @t_from  = @w_sp_name,
     @i_num   = @w_return,
     @i_msg   = @w_msg
return @w_return

--sp_procxmode 'dbo.sp_actividad_economica', 'Unchained'
go
