/************************************************************************/
/*  Archivo:        obje_tmp.sp                                         */
/*  Stored procedure:   sp_obj_social_tmp                               */
/*  Base de datos:      cobis                                           */
/*  Producto:       Clientes                                            */
/*  Disenado por:       Carlos Rodriguez                                */
/*  Fecha de escritura: 10-May-1994                                     */
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
/*  Este programa procesa las transacciones de:                         */
/*  Insercion del objeto social de una compania en la tabla tmpral.     */
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  04/May/2016 T. Baidal   Migracion a CEN                             */
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
           where  name = 'sp_obj_social_tmp')
    drop proc sp_obj_social_tmp
go

create proc sp_obj_social_tmp
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
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_compania     int,
  @i_linea        varchar(255) = null
)
as
  declare
    @w_return      int,
    @w_codigo      int,
    @w_siguiente   int,
    @w_sp_name     varchar(32),
    @w_compania    int,
    @w_cod_alterno tinyint,
    @w_observacion varchar(255),
    @w_login       login,
    @w_descripcion varchar(32)

  select
    @w_sp_name = 'sp_obj_social_tmp'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/** Stored Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_user = @s_user,
      s_term = @s_term,
      s_date = @s_date,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      s_org = @s_org,
      t_trn = @t_trn,
      t_file = @t_file,
      t_from = @t_from,
      i_compania = @i_compania,
      i_linea = @i_linea
    exec cobis..sp_end_debug
  end

  if @i_operacion = 'D'
  begin
    if @t_trn = 121
    begin
      begin tran
      if exists (select
                   *
                 from   cl_objeto_tmp
                 where  ot_usuario  = @s_user
                    and ot_terminal = @s_term)
      begin
        select
          @w_compania = ot_compania,
          @w_cod_alterno = ot_secuencial,
          @w_observacion = ot_linea,
          @w_login = ot_usuario,
          @w_descripcion = ot_terminal
        from   cl_objeto_tmp
        where  ot_usuario  = @s_user
           and ot_terminal = @s_term

        delete cl_objeto_tmp
        where  ot_usuario  = @s_user
           and ot_terminal = @s_term

        if @@error <> 0
        begin
          /*  Error en la eliminacion del estatuto de la compania */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 107062
          return 1
        end

        /*  Transaccion de Servicio  */
        insert into ts_objeto_tmp
                    (secuencial,tipo_transaccion,clase,fecha,usuario,
                     terminal,srv,lsrv,compania,secuencial2,
                     linea,usuario2,terminal2)
        values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                     @s_term,@s_srv,@s_lsrv,@w_compania,@w_cod_alterno,
                     @w_observacion,@w_login,@w_descripcion)

        if @@error <> 0
        begin
          /*  Error en creacion de transaccion de servicio  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 103005
          return 1
        end

      end
      commit tran
      return 0

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

  end

  if @t_trn = 1187
  begin
    /*  Verificacion de existencias  */

    select
      @w_codigo = en_ente
    from   cl_ente
    where  en_ente    = @i_compania
       and en_subtipo = 'C'

    if @@rowcount = 0
    begin
      /*  No existe compania */
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 101136
      return 1
    end

    begin tran

    select
      @w_siguiente = count(*) + 1
    from   cl_objeto_tmp
    where  ot_compania = @i_compania
       and ot_usuario  = @s_user
       and ot_terminal = @s_term

    if @@error <> 0
    begin
      /*  'Error en insercion en Tabla Temporal'  */
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103067
      return 1
    end

    /*  Insercion en la Tabla Temporal  */
    insert into cl_objeto_tmp
                (ot_compania,ot_secuencial,ot_linea,ot_usuario,ot_terminal)
    values      (@i_compania,@w_siguiente,@i_linea,@s_user,@s_term)
    if @@error <> 0
    begin
      /*  'Error en insercion en Tabla Temporal'  */
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103067
      return 1
    end
    commit tran
    return 0

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

