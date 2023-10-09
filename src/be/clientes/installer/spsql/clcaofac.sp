/************************************************************************/
/*  Archivo:                  clcaofac.sp                               */
/*  Stored procedure:         sp_carga_ofac                             */
/*  Base de datos:            cobis                                     */
/*  Producto:                 Clientes                                  */
/*  Disenado por:             John Jairo Parra Perez                    */
/*  Fecha de creación:        04-Mayo-2005                              */
/************************************************************************/
/*                            IMPORTANTE                                */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                             PROPOSITO                                */
/*    Este procedimiento permite ingresar los rangos de montos          */
/*    de cuentas.                                                       */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*    FECHA             AUTOR            RAZON                          */
/*    04-05-2005        J.Parra (JPA)    Emision Inicial                */
/*    18-Ag-2005        R.Calderon G.    Control Segundo apellido       */
/*    18-Ago-2006       G.Alvis          INC8362: Error en cursor refinh*/
/*    08-Nov-2006       Juan Umana       INC9341. Copiar toda lista     */
/*    01/11/2007        RGomezU          inc-9652                       */
/*    02/28/2007        RGomezU          inc-10240                      */
/*    10/09/2007        ACA              Default de documento y tipo    */
/*    29/07/2009        ELA              Inc277 - nombre largo          */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/

use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'cl_ofac_tmp')
  drop table cl_ofac_tmp
go

create table cl_ofac_tmp
(
  ot_column1  varchar(32) null,
  ot_column2  varchar(104) null,
  ot_column3  varchar(104) null,
  ot_column4  varchar(104) null,
  ot_column5  varchar(255) null,
  ot_column6  varchar(104) null,
  ot_column7  varchar(104) null,
  ot_column8  varchar(104) null,
  ot_column9  varchar(104) null,
  ot_column10 varchar(104) null,
  ot_column11 varchar(255) null,
  ot_column12 varchar(2000) null
)
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_carga_ofac')
  drop proc sp_carga_ofac
go

create proc sp_carga_ofac
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_sesn         int = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_rol          smallint = null,
  @s_ofi          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_trn          int = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_corr         char(1) = 'N',
  @t_ssn_corr     int = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_modo         tinyint = null,
  @i_archivo_ofac varchar(30) = null
)
as
  declare
    @w_sp_name         varchar(30),
    @w_return          int,
    @w_today           datetime,
    @w_column2         varchar(104),
    @w_column12        varchar(500),-- RGU - inc-10240 - 02/28/2007
    @w_nit             varchar(13),
    @w_cc              varchar(20),--
    @w_aux             varchar(13),
    @w_count           int,
    @w_init            int,
    @w_end             int,
    @w_pnatural        varchar(15),
    @w_pjuridica       varchar(15),
    -- Variables para el ingreso de los datos a cobis..cl_refinh --
    @w_in_codigo       int,
    @w_in_documento    int,
    @w_in_ced_ruc      char(13),
    @w_in_nombre       char(64),
    @w_in_fecha_ref    char(10),
    @w_in_origen       catalogo,
    @w_in_observacion  varchar(255),
    @w_in_fecha_mod    char(10),
    @w_in_subtipo      char(1),
    @w_in_p_p_apellido varchar(16),
    @w_in_p_s_apellido varchar(16),
    @w_in_tipo_ced     char(2),
    @w_in_usuario      login,
    @w_s_apellido      varchar(1),
    @w_num_documento   varchar(30),
    @w_debug           char(1),
    @w_nomlar          char(64)

  --version /*    09/10/2009  11:49am      ELA              */
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  -- Asignando nombre al Store Procedure
  select
    @w_sp_name = 'sp_carga_ofac',
    @w_today = @s_date,
    @w_debug = 'S'

  /* VALIDANDO LA TRANSACCION */

  if (@t_trn <> 5240
      and @i_operacion = 'C')
      or (@t_trn <> 5240
          and @i_operacion = 'I')
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 2307504 -- El numero de transaccion no corresponde
    return 1
  end

  if @i_operacion = 'C'
  begin
    -- Creando Temporal para el ingreso de registros ofac de solo colombia
    select
      *
    into   #ofac_colombia
    from   cobis..cl_ofac_tmp

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107213 /* Error en insercion de tabla temporal */
      return 1
    end

    truncate table cobis..cl_ofac_tmp

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107222
      return 1
    end

    -- Insertando registr ofac para Colombia en la tabla cl_ofac_tmp
    insert into cobis..cl_ofac_tmp
      select
        *
      from   #ofac_colombia

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107213 /* Error en insercion de tabla temporal */
      return 1
    end

    delete from cobis..cl_refinh
    where  in_origen      = '007'
       and in_observacion = 'INGRESO POR LISTA OFAC'

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107214 /* Error en eliminacion de referencia inhibitoria */
      return 1
    end

    drop table #ofac_colombia -- Eliminando Temporal

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107223 /* Error en eliminacion de referencia inhibitoria */
      return 1
    end
  end -- Fin Operacion 'C'

  if @i_operacion = 'I'
  begin
    select
      @w_num_documento = pa_char
    from   cobis..cl_parametro
    where  pa_nemonico = 'NDRI'
       and pa_producto = 'MIS'

    select
      @w_in_origen = codigo
    from   cobis..cl_catalogo
    where  tabla = (select
                      codigo
                    from   cobis..cl_tabla
                    where  tabla = 'cl_refinh')
       and valor = 'LISTA OFAC'

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101077 /* No existe parametro */
      --insert into log (mensaje) values ('No existe lista')
      return 1
    end

    declare @tmp_inhibitorias table
    (
       t_in_subtipo      char(1) null,
       t_in_tipo_ced     char(2) null,
       t_in_ced_ruc      char(13) null,
       t_in_nombre       char(64) null,
       t_in_origen       catalogo null,
       t_in_p_p_apellido varchar(16) null,
       t_in_p_s_apellido varchar(16) null
    )

    print 'Ingreso de datos a la tabla de referencias inhibitorias'
    declare ofac cursor for
      select
        substring(ot_column2,
                  2,
                  datalength(ot_column2) - 2),
        substring(convert(varchar(2000), ot_column12),
                  2,
                  500) -- RGU - inc-10240 - 02/28/2007
      from   cobis..cl_ofac_tmp
      order  by ot_column1
      for read only

    open ofac

    fetch ofac into @w_column2, @w_column12

    if @@fetch_status <> 0
    begin
      close ofac
      deallocate ofac
      return 1
    end
    while @@fetch_status = 0
    begin
      select
        @w_count = 0,
        @w_in_documento = 0,
        @w_in_fecha_ref = convert(varchar(10), @s_date, 101),
        @w_in_observacion = 'INGRESO POR LISTA OFAC',
        @w_in_fecha_mod = convert(varchar(10), @s_date, 101),
        @w_in_usuario = @s_user

      select
        @w_in_nombre = '',
        @w_in_subtipo = 'P'

      select
        @w_s_apellido = 'S'

      select
        @w_init = charindex(' ', @w_column2) + 1
      select
        @w_end = charindex(',',
                           @w_column2)

      if @w_end < @w_init
        select
          @w_s_apellido = 'N'

      select
        @w_end = @w_end - @w_init

      if @w_end > 16
        select
          @w_end = 16

      select
        @w_in_nombre = upper(substring(@w_column2,
                                       charindex(', ', @w_column2) + 2,
                                       datalength(@w_column2)))
      select
        @w_in_nombre = substring(@w_in_nombre,
                                 1,
                                 64)

      if @w_s_apellido = 'S'
        select
          @w_in_p_s_apellido = substring(@w_column2,
                                         @w_init,
                                         @w_end),
          @w_in_p_p_apellido = upper(substring(@w_column2,
                                               1,
                                               charindex(' ',
                                                         @w_column2)))

      else
      begin
        select
          @w_in_p_s_apellido = null,
          @w_in_p_p_apellido = upper(substring(@w_column2,
                                               1,
                                               charindex(', ',
                                                         @w_column2)))

        select
          @w_count = charindex(',',
                               @w_in_p_p_apellido)
        --substring(@w_in_p_p_apellido, 1, charindex(',', @w_in_p_p_apellido - 1))
        if @w_count > 1
          select
            @w_count = @w_count - 1
        select
          @w_in_p_p_apellido = substring(@w_in_p_p_apellido,
                                         1,
                                         @w_count)
      end

      if charindex('Cedula No. ',
                   @w_column12) > 0
      begin
        while 1 = 1
        begin
          select
            @w_count = charindex('Cedula No. ', @w_column12) + datalength(
                       'Cedula No. '
                       )
          select
            @w_cc = substring(@w_column12,
                              @w_count,
                              19)--13)
          select
            @w_in_subtipo = 'P'
          if charindex(' (Colombia)',
                       @w_cc) > 0
          begin
            select
              @w_cc = substring(@w_cc,
                                1,
                                charindex(' (Colombia)',
                                          @w_cc))
            select
              @w_in_ced_ruc = @w_cc,
              @w_in_tipo_ced = 'CC'
          end
          else
            select
              @w_aux = ' ',
              @w_in_ced_ruc = @w_num_documento,
              @w_in_tipo_ced = 'CC'

          if @w_debug = 'S'
            print '1. --> ' + @w_in_subtipo + '-' + @w_in_tipo_ced + '-' +
                  @w_in_ced_ruc
                  +
                                                                '-' +
                                                                @w_in_nombre +
                  '-'
                  + @w_in_p_p_apellido + '-' + @w_in_p_s_apellido + '-' +
                  @w_in_origen

          insert @tmp_inhibitorias
            select
              @w_in_subtipo,@w_in_tipo_ced,@w_in_ced_ruc,substring(@w_in_nombre,
                        1,
                        64),@w_in_p_p_apellido,
              @w_in_p_s_apellido,@w_in_origen

          -- Insertando informacion en la tabla cl_refinh (Un registro por cada cedula encontrada)
          if not exists(select
                          1
                        from   cobis..cl_refinh
                        -- INC8362: VALIDA QUE NO SE INSERTEN REGISTROS DUPLICADOS
                        where  in_subtipo      = @w_in_subtipo
                           and in_tipo_ced     = @w_in_tipo_ced
                           and in_ced_ruc      = @w_in_ced_ruc
                           and in_nombre       = @w_in_nombre
                           and in_p_p_apellido = @w_in_p_p_apellido
                           and in_p_s_apellido = @w_in_p_s_apellido
                           and in_origen       = @w_in_origen)
          begin
            exec @w_return = sp_cseqnos
              @t_debug     = @t_debug,
              @t_file      = @t_file,
              @t_from      = @w_sp_name,
              @i_tabla     = 'cl_refinh',
              @o_siguiente = @w_in_codigo out

            if @w_return <> 0
            begin
              --insert into log (mensaje) values ('Error seqnos')
              close ofac
              deallocate ofac
              return @w_return
            end

            if @w_in_subtipo is null
                or @w_in_subtipo = ''
              select
                @w_in_subtipo = 'P'

            if @w_in_p_p_apellido = ''
              select
                @w_in_p_p_apellido = null

            if @w_in_p_s_apellido = ''
              select
                @w_in_p_s_apellido = null

            select
              @w_nomlar = ltrim(isnull(ltrim(rtrim(@w_in_p_p_apellido)), '') +
                                ' '
                                + isnull(ltrim(rtrim(@w_in_p_s_apellido)), '') +
                                ' '
                                + isnull(ltrim(rtrim(@w_in_nombre)), ''))
            print
            'FIN1. --> ' + @w_nomlar + '-' + @w_in_subtipo + '-' +
            @w_in_tipo_ced
            +
            '-'
            +
            @w_in_ced_ruc + '-'
                  + @w_in_nombre + '-' + @w_in_p_p_apellido + '-' +
            @w_in_p_s_apellido
            +
            '-'
            + @w_in_origen
            insert into cobis..cl_refinh
                        (in_codigo,in_documento,in_ced_ruc,in_nombre,
                         in_fecha_ref,
                         in_origen,in_observacion,in_fecha_mod,in_subtipo,
                         in_p_p_apellido,
                         in_p_s_apellido,in_tipo_ced,in_usuario,in_nomlar)
            values      ( @w_in_codigo,@w_in_documento,@w_in_ced_ruc,
                          @w_in_nombre,
                          @w_in_fecha_ref,
                          @w_in_origen,@w_in_observacion,@w_in_fecha_mod,
                          @w_in_subtipo
                          ,
                          @w_in_p_p_apellido,
                          @w_in_p_s_apellido,@w_in_tipo_ced,@w_in_usuario,
                          @w_nomlar)

            if @@rowcount = 0
            begin
              print 'Error insert cl_refinh CC'
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107173
            /* Error al ingresar el registro a la lista OFAC */
            end
          end

          select
            @w_column12 = substring(@w_column12,
                                    charindex('(Colombia)', @w_column12) + 11,
                                    datalength(@w_column12))
          if charindex('Cedula No. ',
                       @w_column12) = 0
            break
        end -- Fin de while 1=1
      end
      else
      begin
        if charindex('NIT # ',
                     @w_column12) > 0
        begin
          select
            @w_count = charindex('NIT # ', @w_column12) + datalength('NIT # ')
          select
            @w_nit = substring(@w_column12,
                               @w_count,
                               13)
          select
            @w_nit = substring(@w_nit,
                               1,
                               charindex(' ',
                                         @w_nit))
          if charindex('-',
                       @w_nit) > 0
          begin
            select
              @w_aux = substring(@w_nit,
                                 charindex('-', @w_nit) + 1,
                                 1)
            select
              @w_nit = substring(@w_nit,
                                 1,
                                 charindex('-',
                                           @w_nit))
            select
              @w_nit = stuff(@w_nit,
                             charindex('-',
                                       @w_nit),
                             1,
                             @w_aux)
          end

          select
            @w_in_ced_ruc = @w_nit,
            @w_in_nombre = upper(substring(@w_column2,
                                           1,
                                           datalength(@w_column2))),
            @w_in_subtipo = 'C',
            @w_in_p_p_apellido = null,
            @w_in_p_s_apellido = null,
            @w_in_tipo_ced = 'NIT'

          select
            @w_in_nombre = substring(@w_in_nombre,
                                     1,
                                     64)
          select
            @w_nomlar = ltrim(isnull(ltrim(rtrim(@w_in_p_p_apellido)), '') + ' '
                              + isnull(ltrim(rtrim(@w_in_p_s_apellido)), '') +
                              ' '
                              + isnull(ltrim(rtrim(@w_in_nombre)), ''))

        end
        else
        begin
          select
            @w_aux = ' ',
            @w_in_ced_ruc = @w_num_documento,
            @w_in_nombre = upper(substring(@w_column2,
                                           1,
                                           64)),
            @w_in_subtipo = 'P',
            @w_in_p_p_apellido = null,
            @w_in_p_s_apellido = null,
            @w_in_tipo_ced = 'CC'

          select
            @w_in_nombre = substring(@w_in_nombre,
                                     1,
                                     64)
          select
            @w_nomlar = @w_in_nombre
        end

        if @w_debug = 'S'
          print '2. --> ' + @w_in_subtipo + '-' + @w_in_tipo_ced + '-' +
                @w_in_ced_ruc
                +
                                        '-' +
                                        @w_in_nombre + '-'
                + @w_in_p_p_apellido + '-' + @w_in_p_s_apellido + '-' +
                @w_in_origen

        -- Insertando informacion en la tabla cl_refinh
        if not exists(select
                        1
                      from   cobis..cl_refinh
                      -- INC8362: VALIDA QUE NO SE INSERTEN REGISTROS DUPLICADOS
                      where  in_subtipo      = @w_in_subtipo
                         and in_tipo_ced     = @w_in_tipo_ced
                         and in_ced_ruc      = @w_in_ced_ruc
                         and in_nombre       = @w_in_nombre
                         and in_p_p_apellido = @w_in_p_p_apellido
                         and in_p_s_apellido = @w_in_p_s_apellido)
        begin
          exec @w_return = sp_cseqnos
            @t_debug     = @t_debug,
            @t_file      = @t_file,
            @t_from      = @w_sp_name,
            @i_tabla     = 'cl_refinh',
            @o_siguiente = @w_in_codigo out

          if @w_return <> 0
          begin
            close ofac
            deallocate ofac
            return @w_return
          end

          if @w_in_p_p_apellido = ''
            select
              @w_in_p_p_apellido = null
          if @w_in_p_s_apellido = ''
            select
              @w_in_p_s_apellido = null

          select
            @w_nomlar = ltrim(isnull(ltrim(rtrim(@w_in_p_p_apellido)), '') + ' '
                              + isnull(ltrim(rtrim(@w_in_p_s_apellido)), '') +
                              ' '
                              + isnull(ltrim(rtrim(@w_in_nombre)), ''))
          print
          'FIN2. --> ' + @w_nomlar + '-' + @w_in_subtipo + '-' + @w_in_tipo_ced
          +
          '-'
          +
          @w_in_ced_ruc + '-'
                + @w_in_nombre + '-' + @w_in_p_p_apellido + '-' +
          @w_in_p_s_apellido
          +
          '-'
          + @w_in_origen
          insert into cobis..cl_refinh
                      (in_codigo,in_documento,in_ced_ruc,in_nombre,in_fecha_ref,
                       in_origen,in_observacion,in_fecha_mod,in_subtipo,
                       in_p_p_apellido,
                       in_p_s_apellido,in_tipo_ced,in_nomlar,in_usuario)
          values      ( @w_in_codigo,@w_in_documento,@w_in_ced_ruc,@w_in_nombre,
                        @w_in_fecha_ref,
                        @w_in_origen,@w_in_observacion,@w_in_fecha_mod,
                        @w_in_subtipo
                        ,
                        @w_in_p_p_apellido,
                        @w_in_p_s_apellido,@w_in_tipo_ced,@w_nomlar,
                        @w_in_usuario)

          if @@rowcount = 0
          begin
            print 'Error insert cl_refinh NIT'
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 107173
          /* Error al ingresar el registro a la lista OFAC */
          --insert into log (mensaje) values ('Error insert cl_refinh NIT')
          end
        end
      end

      -- SIGUIENTE REGISTRO --
      fetch ofac into @w_column2, @w_column12

      if @@fetch_status <> 0
      begin
        close ofac
        deallocate ofac
        --insert into log (mensaje) values ('Error en fetch2')

        insert cl_refinh_hist
          select
            in_codigo,in_documento,in_ced_ruc,in_nombre,in_fecha_ref,
            in_origen,'NO EXISTE EN NUEVA LISTA',in_fecha_mod,in_subtipo,
            in_p_p_apellido
            ,
            in_p_s_apellido,in_tipo_ced,in_nomlar,in_estado,in_sexo,
            in_usuario,getdate()
          from   cobis..cl_refinh
                 left join @tmp_inhibitorias
                        on (in_subtipo = t_in_subtipo
                            and in_tipo_ced = t_in_tipo_ced
                            and in_ced_ruc = t_in_ced_ruc)
          where  in_origen = @w_in_origen
             and t_in_ced_ruc is null

        return 1
      end
    end -- Fin While Cursor

    close ofac
    deallocate ofac

    insert cl_refinh_hist
      select
        in_codigo,in_documento,in_ced_ruc,in_nombre,in_fecha_ref,
        in_origen,'NO EXISTE EN NUEVA LISTA',in_fecha_mod,in_subtipo,
        in_p_p_apellido
        ,
        in_p_s_apellido,in_tipo_ced,in_nomlar,in_estado,in_sexo,
        in_usuario,getdate()
      from   cobis..cl_refinh
             left join @tmp_inhibitorias
                    on (in_subtipo = t_in_subtipo
                        and in_tipo_ced = t_in_tipo_ced
                        and in_ced_ruc = t_in_ced_ruc)
      where  in_origen = @w_in_origen
         and t_in_ced_ruc is null

  --RLO 10-11-2005

  --ACTUALIZACION DE REFERENCIAS INHIBITORIAS EN LA TABLA MAESTRA DE CLIENTES
  /*
     exec @w_return = cobis..sp_act_refinh
          @t_debug  = @t_debug,
          @t_file   = @t_file,
          @i_filial = 1
  
     if @w_return <> 0
        return @w_return
  */
  end -- Fin Operacion
  return 0

go

