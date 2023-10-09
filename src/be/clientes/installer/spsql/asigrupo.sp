/************************************************************************/
/*    Archivo:              asigrupo.sp                                 */
/*    Stored procedure:     sp_desasignar_grupo                         */
/*    Base de datos:        cobis                                       */
/*    Producto:             Clientes                                    */
/*    Disenado por:         Sandra Ortiz                                */
/*    Fecha de escritura:   01/Dic/1993                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este stored procedure realiza:                                  */
/*      Desasigna un ente de grupo                                      */
/*      Nota: la asignacion se hace en creacion o por update de         */
/*            persona o compania                                        */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA        AUTOR           RAZON                                */
/*    01/Dic/93    R. Minga V.     Emision Inicial                      */
/*    28/Ene/97    J. Loyo  H.     Se cambia la forma de asignacion     */
/*                                 ya que  un ente puede estar en       */
/*                                 varios grupos      VARGRU            */
/*    02/May/16    DFu             Migracion CEN                        */
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
           where  name = 'sp_desasignar_grupo')
  drop proc sp_desasignar_grupo
go

create proc sp_desasignar_grupo
(
  @s_ssn          int = null,
  @s_ofi          smallint = null,
  @s_date         datetime = null,
  @s_user         login = null,
  @s_term         varchar (14) = null,
  @s_srv          varchar (30) = null,
  @s_lsrv         varchar (30) = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char (1) = 'N',
  @t_file         varchar (14) = null,
  @t_from         varchar (30) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_oficial      smallint = null,
  @i_grupo        int,
  @i_ente         int,
  @i_operacion    char(1) = null
)
as
  declare
    @w_sp_name   varchar (30),
    @w_fecha_reg datetime,
    @w_compania  int,
    @w_oficial   smallint,
    @w_tipo      char(1),
    @o_fecha_reg datetime,
    @o_user      login

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_desasignar_grupo'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1160
  begin
    /* verificar que exista el grupo */
    if not exists (select
                     *
                   from   cl_grupo
                   where  gr_grupo = @i_grupo)
    begin
      /* no existe el grupo */
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151029
      return 1
    end

  /* verificar que el ente pertenezca al grupo */
    /*****if not exists (select * 
               from cl_ente
             where en_ente = @i_ente
                and en_grupo = @i_grupo )  *** VARGRU ****/
    select
      @w_fecha_reg = cg_fecha_reg
    from   cl_cliente_grupo
    where  cg_ente  = @i_ente
       and cg_grupo = @i_grupo
    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101107
      /* no existe el ente o no pertenece al grupo */
      return 1
    end
  /********************* VARGRU *******************/
    /* si el ente es el grupo, no se puede desasignar */
    select
      @w_compania = gr_compania
    from   cl_grupo
    where  gr_grupo = @i_grupo

    if @w_compania = @i_ente
    begin
      /* no se puede desasignar un grupo de si mismo */
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101108
      return 1
    end
    /*********************************************/
    begin tran
    /***********************************VARGRU ***/
    update cl_ente
    set    en_grupo = null,
           c_es_grupo = 'N'
    where  en_ente  = @i_ente
       and en_grupo = @i_grupo
  /************************************************/
    /* desasignar en ente del grupo */
    delete from cl_cliente_grupo
    where  cg_ente  = @i_ente
       and cg_grupo = @i_grupo
    /* si no se puede desasignar, error */
    if @@rowcount <> 1
    begin
      /* error en desasignacion de grupo */
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101109
      return 1
    end

    insert into ts_cliente_grupo
                (secuencial,tipo_transaccion,clase,fecha_reg,usuario,
                 terminal,srv,lsrv,grupo,ente
                 )
    values      (@s_ssn,1160,'B',@w_fecha_reg,@s_user,
                 @s_term,@s_srv,@s_lsrv,@i_grupo,@i_ente
                 )
    /* si no se puede desasignar, error */
    if @@rowcount <> 1
    begin
      /* error en desasignacion de grupo */
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101109
      return 1
    end

    commit tran
    return 0
  end
  else if @t_trn = 1317 /***  asignar miembro a grupo economico ****/
  begin
    /* verificar que exista el grupo */
    if not exists (select
                     *
                   from   cl_grupo
                   where  gr_grupo = @i_grupo)
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151029
      /* no existe el grupo */
      return 1
    end

    /* verificar que el ente exista */
    select
      @w_oficial = en_oficial
    --  en_ente 
    from   cl_ente
    where  en_ente = @i_ente
    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101043
      /* No existe el Ente **/
      return 1
    end
    /* verificar que no este asignado miemb. a grupo*/
    select
      cg_ente
    from   cl_cliente_grupo
    where  cg_ente  = @i_ente
       and cg_grupo = @i_grupo

    if @@rowcount <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101189
      /* Miembro ya esta asignado a Grupo Economico **/
      return 1
    end
    /* NVR*/
    select
      @w_fecha_reg = @s_date /* getdate() */
    if @i_oficial is not null
      select
        @w_oficial = @i_oficial

    insert into cl_cliente_grupo
                (cg_ente,cg_grupo,cg_usuario,cg_terminal,cg_oficial,
                 cg_fecha_reg)
    values      (@i_ente,@i_grupo,@s_user,@s_term,@w_oficial,
                 @w_fecha_reg)
    if @@rowcount <> 1
    begin
      /* error en Insercion de Grupo Economico*/
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103085
      return 1
    end
    /*actualizar en_grupo */
    select
      @w_tipo = en_subtipo
    from   cl_ente
    where  en_ente = @i_ente

    if @w_tipo = 'C'
    begin
      update cl_ente
      set    en_grupo = @i_grupo
      /* c_es_grupo = 'S' REC053*/
      where  en_ente = @i_ente
    end
    else
    begin
      update cl_ente
      set    en_grupo = @i_grupo
      where  en_ente = @i_ente
    end

    insert into ts_cliente_grupo
                (secuencial,tipo_transaccion,clase,fecha_reg,usuario,
                 terminal,srv,lsrv,grupo,ente
                 )
    values      (@s_ssn,1317,'N',@w_fecha_reg,@s_user,
                 @s_term,@s_srv,@s_lsrv,@i_grupo,@i_ente
                 )
    /* si no se puede desasignar, error */
    if @@rowcount <> 1
    begin
      /* error en Insercion de Grupo Economico*/
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103085
      return 1
    end
  end
  else if @t_trn = 1344
  begin
    if @i_operacion = 'Q'
    begin
      select
        @o_fecha_reg = cg_fecha_reg,
        @o_user = cg_usuario
      from   cl_cliente_grupo
      where  cg_ente  = @i_ente
         and cg_grupo = @i_grupo

      select
        @o_fecha_reg,
        @o_user

    end

  end
  else
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    /*  'No corresponde codigo de transaccion' */
    return 1
  end

go

