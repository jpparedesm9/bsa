/************************************************************************/
/*  Archivo:                  clcarterr.sp                              */
/*  Stored procedure:         sp_carga_terr                             */
/*  Base de datos:            cobis                                     */
/*  Producto:                 Clientes                                  */
/*  Disenado por:             ACA                                       */
/*  Fecha de creacion:        27-Junio-2007                             */
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
/*    27-06-2007        ACA            Emision Inicial                  */
/*    12-10-2007        ACA            llave duplicada                  */
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
           where  name = 'tmp_terro')
  drop table tmp_terro
go

create table tmp_terro
(
  te_ced_ruc      numero,
  te_tipo_ced     varchar(10),
  te_nombre       varchar(255),
  te_p_p_apellido varchar(50) null,
  te_subtipo      char(1) null
)
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_carga_terr')
  drop proc sp_carga_terr
go

create proc sp_carga_terr
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
  @i_archivo_ofac varchar(30) = null
)
as
  declare
    @w_sp_name         varchar(30),
    @w_return          int,
    @w_today           datetime,
    @w_count           int,
    @w_init            int,
    @w_end             int,
    @w_pnatural        varchar(15),
    @w_pjuridica       varchar(15),
    -- Variables para el ingreso de los datos a cobis..cl_refinh --
    @w_in_codigo       int,
    @w_in_documento    int,
    @w_in_ced_ruc      varchar(30),
    @w_in_nombre       char(255),
    @w_in_fecha_ref    char(10),
    @w_in_origen       catalogo,
    @w_in_observacion  varchar(255),
    @w_in_fecha_mod    char(10),
    @w_in_subtipo      char(1),
    @w_in_p_p_apellido varchar(50),
    @w_in_tipo_ced     char(2),
    @w_in_usuario      login,
    @w_s_apellido      varchar(1),
    @w_debug           char(1)

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  -- Asignando nombre al Store Procedure
  select
    @w_sp_name = 'sp_carga_terr',
    @w_today = @s_date,
    @w_debug = 'N'

  if @i_operacion = 'I'
  begin
    select
      @w_in_origen = codigo
    from   cobis..cl_catalogo
    where  tabla = (select
                      codigo
                    from   cobis..cl_tabla
                    where  tabla = 'cl_refinh')
       and valor = 'LISTA ANTITERRORISTA ONU'

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101077 /* No existe parametro */
      return 1
    end

    delete from cobis..cl_refinh
    where  in_origen      = @w_in_origen
       and in_observacion = 'LISTA ANTITERRORISTA ONU'

    if @@rowcount = 0
    begin
      delete from cobis..cl_refinh
      where  in_origen = @w_in_origen
    end

    print 'Ingreso de datos a la tabla de referencias inhibitorias'
    declare @tmp_onu table
    (
       te_numero       int identity (1, 1),
       te_ced_ruc      numero,
       te_tipo_ced     varchar(10),
       te_nombre       varchar(255),
       te_p_p_apellido varchar(50) null,
       te_subtipo      char(1) null
    )

    insert into @tmp_onu
      select
        isnull(te_ced_ruc,
               '9991'),te_tipo_ced,te_nombre,te_p_p_apellido,te_subtipo
      from   cobis..tmp_terro
      order  by te_ced_ruc

    select
      *
    from   @tmp_onu

    declare ofac cursor for
      select
        te_ced_ruc,
        te_tipo_ced,
        te_nombre,
        te_p_p_apellido,
        te_subtipo
      from   cobis..tmp_terro
      order  by te_ced_ruc
      for read only

    open ofac

    fetch ofac into @w_in_ced_ruc,
                    @w_in_tipo_ced,
                    @w_in_nombre,
                    @w_in_p_p_apellido,
                    @w_in_subtipo

    if @@fetch_status <> 0
    begin
      if @w_debug = 'S'
        print '@@fetch_status: ' + cast(@@fetch_status as varchar)

      close ofac
      deallocate ofac
      return 1
    end
    while @@fetch_status = 0
    begin
      select
        @w_in_documento = 0,
        @w_in_fecha_ref = convert(varchar(10), @s_date, 101),
        @w_in_observacion = 'LISTA ANTITERRORISTA ONU',
        @w_in_fecha_mod = convert(varchar(10), @s_date, 101),
        @w_in_usuario = @s_user

      if @w_debug = 'S'
        print @w_in_tipo_ced + '-' + @w_in_ced_ruc

      if @w_in_ced_ruc is null
        select
          @w_in_ced_ruc = '9991'

      -- Insertando informacion en la tabla cl_refinh (Un registro por cada cedula encontrada)
      if not exists(select
                      1
                    from   cobis..cl_refinh
                    where  in_subtipo      = @w_in_subtipo
                       and in_tipo_ced     = @w_in_tipo_ced
                       and in_ced_ruc      = @w_in_ced_ruc
                       and in_nombre       = @w_in_nombre
                       and in_p_p_apellido = @w_in_p_p_apellido
                       and in_p_s_apellido = null)
      begin
        exec @w_return = sp_cseqnos
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_refinh',
          @o_siguiente = @w_in_codigo out

        if @w_return <> 0
          return @w_return

        insert into cobis..cl_refinh
                    (in_codigo,in_documento,in_ced_ruc,in_nombre,in_fecha_ref,
                     in_origen,in_observacion,in_fecha_mod,in_subtipo,
                     in_p_p_apellido,
                     in_p_s_apellido,in_tipo_ced,in_usuario)
        values      ( @w_in_codigo,@w_in_documento,@w_in_ced_ruc,@w_in_nombre,
                      @w_in_fecha_ref,
                      @w_in_origen,@w_in_observacion,@w_in_fecha_mod,
                      @w_in_subtipo
                      ,
                      @w_in_p_p_apellido,
                      null,@w_in_tipo_ced,@w_in_usuario)

        if @@rowcount = 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107173
        /* Error al ingresar el registro a la lista OFAC */
        end
      end

      -- SIGUIENTE REGISTRO --
      fetch ofac into @w_in_ced_ruc,
                      @w_in_tipo_ced,
                      @w_in_nombre,
                      @w_in_p_p_apellido,
                      @w_in_subtipo
    end -- Fin While Cursor

    close ofac
    deallocate ofac

  /*
     print 'ACTUALIZACION DE REFERENCIAS INHIBITORIAS EN LA TABLA MAESTRA DE CLIENTES'
     exec @w_return = cobis..sp_act_refinh
          @t_debug  = @t_debug,
          @t_file   = @t_file,
          @i_filial = 1
  
     if @w_return <> 0
        return @w_return
  */
  end -- Fin Operacion
  if @w_debug = 'S'
    print 'Saliendo sp'
  return 0

go

