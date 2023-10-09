/************************************************************************/
/*  Archivo:        servicio.sp                                         */
/*  Stored procedure:   sp_servicio_cl                                  */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 06-Nov-1992                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa procesa las siguientes transacciones                  */
/*      Insercion en cl_servicio                                        */
/*      modificacion en cl_servicio                                     */
/*      busqueda en cl_servicio, global, por filial y especifico        */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  06/Nov/92   M. Davila   Emision Inicial                             */
/*  15/Ene/93   L. Carvajal Tabla de errores, variables                 */
/*                  de debug                                            */
/*      30/Nov/93       R. Minga V.     Verificacion y validacion       */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_servicio_cl')
           drop proc sp_servicio_cl
go

create proc sp_servicio_cl
(
  @s_ssn          int = null,
  @s_user         login = null,
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
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = 23,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_modo         tinyint = null,
  @i_tipo         char(1) = null,
  @i_filial       tinyint = null,
  @i_servicio     smallint = null,
  @i_descripcion  descripcion = null
)
as
  declare
    @w_servicio tinyint,
    @w_sp_name  varchar(32),
    @o_filial   tinyint,
    @o_finombre descripcion,
    @o_servicio smallint,
    @o_senombre descripcion

  select
    @w_sp_name = 'sp_servicio_cl'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Insercion  */
  if @i_operacion = 'I'
  begin
    begin tran

    /* obtener un nuevo secuencial para servicio */
    exec sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'cl_servicio',
      @o_siguiente = @w_servicio out

    /* insertar los datos de entrada */
    insert into cl_servicio
                (se_filial,se_servicio,se_descripcion,se_estado)
    values      (@i_filial,@w_servicio,@i_descripcion,'V')

    /* si no se puede insertar, error */
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105050
      /* 'Error en insercion de servicio'*/
      return 1
    end
    commit tran

    /* retornar el nuevo secuencial para el servicio */
    select
      @w_servicio
    return 0
  end

  /*  Actualizacion  */
  if @i_operacion = 'U'
  begin
    /* verificar que exista el servicio a modificar */
    if not exists (select
                     *
                   from   cl_servicio
                   where  se_filial   = @i_filial
                      and se_servicio = @i_servicio)
    begin
      /* si no existe el servicio, error */
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101001
      /* 'No existe dato solicitado'*/
      return 1
    end

    begin tran

    /* modificar los datos de servicio */
    update cl_servicio
    set    se_descripcion = @i_descripcion
    where  se_filial   = @i_filial
       and se_servicio = @i_servicio

    /* si no se puede insertar, error */
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103050
      /* 'Error en actualizacion de servicio'*/
      return 1
    end
    commit tran
  end

  /*  Consulta  */
  if @i_operacion = 'S'
  /* Descripcion de los servicios para todas las filiales */
  begin
    if @i_modo = 0
      select
        'Filial' = se_filial,
        'Servicio' = se_servicio,
        'Descripcion' = rtrim(se_descripcion)
      from   cl_servicio,
             cl_filial
      where  se_estado = 'V'
         and fi_filial = se_filial
    if @i_modo = 1
      select
        'Filial' = se_filial,
        'Servicio' = se_servicio,
        'Descripcion' = rtrim(se_descripcion)
      from   cl_servicio,
             cl_filial
      where  se_estado   = 'V'
         and fi_filial   = se_filial
         and se_servicio > @i_servicio
    return 0
  end

  /*  Help  */
  if @i_operacion = 'H'
  begin
    if @i_tipo = 'A'
    begin
      if @i_modo = 0
        select
          se_servicio,
          se_descripcion
        from   cl_servicio
        where  se_filial = @i_filial
        order  by se_filial,
                  se_servicio
      if @i_modo = 1
        select
          se_servicio,
          se_descripcion
        from   cl_servicio
        where  se_filial   = @i_filial
           and se_servicio > @i_servicio
        order  by se_filial,
                  se_servicio
    end
    if @i_tipo = 'V'
    begin
      select
        se_descripcion
      from   cl_servicio
      where  se_filial   = @i_filial
         and se_servicio = @i_servicio
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101059
        /* 'No existe perfil'*/
        return 1
      end
    end
    return 0
  end

  if @i_operacion = 'Q'
  begin
    select
      @o_filial = se_filial,
      @o_finombre = fi_nombre,
      @o_servicio = se_servicio,
      @o_senombre = se_descripcion
    from   cl_servicio,
           cl_filial
    where  se_filial   = @i_filial
       and se_servicio = @i_servicio
       and se_estado   = 'V'
    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101059
      /* 'No existe perfil'*/
      return 1
    end
    select
      @o_filial,
      @o_finombre,
      @o_servicio,
      @o_senombre
  end

go

