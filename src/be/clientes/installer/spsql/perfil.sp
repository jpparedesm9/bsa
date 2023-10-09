/************************************************************************/
/*  Archivo:        perfil.sp                                           */
/*  Stored procedure:   sp_perfil                                       */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 20-Nov-1992                                     */
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
/*  Este programa procesa las transacciones del stored procedure        */
/*  Busqueda de perfil                                                  */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  20/Nov/92   M. Davila   Emision Inicial                             */
/*  14/Ene/93   L. Carvajal Tabla de errores, variables                 */
/*                  de debug                                            */
/*  05/May/2016 T. Baidal      Migracion a CEN                          */
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
           where  name = 'sp_perfil')
    drop proc sp_perfil
go

create proc sp_perfil
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
  @i_tipo         char(1) = null,
  @i_filial       tinyint = null,
  @i_servicio     smallint = null,
  @i_perfil       smallint = null,
  @i_descripcion  descripcion = null,
  @o_siguiente    int = nul out
)
as
  declare
    @w_today    datetime,
    @w_sp_name  varchar(32),
    @o_filial   tinyint,
    @o_finombre descripcion,
    @o_servicio smallint,
    @o_senombre descripcion,
    @o_perfil   smallint,
    @o_pfnombre descripcion

  select
    @w_sp_name = 'sp_perfil'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = getdate()

  /*  Insercion  */
  if @i_operacion = 'I'
  begin
    if @t_trn = 123
    begin
      begin tran
      exec sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_perfil',
        @o_siguiente = @o_siguiente out
      insert into cl_perfil
                  (pf_filial,pf_servicio,pf_perfil,pf_descripcion,pf_atributos,
                   pf_estado)
      values      (@i_filial,@i_servicio,@o_siguiente,@i_descripcion,0,
                   'V')
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103051
        /* 'Error en insercion de perfil'*/
        return 1
      end
      commit tran
      select
        @o_siguiente
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

  /*  Actualizacion  */
  if @i_operacion = 'U'
  begin
    if @t_trn = 124
    begin
      begin tran
      update cl_perfil
      set    pf_descripcion = @i_descripcion
      where  pf_filial   = @i_filial
         and pf_servicio = @i_servicio
         and pf_perfil   = @i_perfil
      if @@error = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105051
        /*'Error en actualizacion de perfil'*/
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

  end

  /*  Consulta  */
  if @i_operacion = 'S'
  begin
    if @t_trn = 125
    begin
      select
        'Filial' = pf_filial,
        'Servicio' = pf_servicio,
        'Perfil' = pf_perfil,
        'Descripcion' = rtrim(pf_descripcion)
      from   cl_perfil
      where  pf_estado = 'V'
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101059
        /*'No existe perfil'*/
        return 1
      end
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

  /*  Help  */
  if @i_operacion = 'H'
  begin
    if @t_trn = 126
    begin
      if @i_tipo = 'A'
      begin
        select
          pf_perfil,
          pf_descripcion
        from   cl_perfil
        where  pf_filial   = @i_filial
           and pf_servicio = @i_servicio
           and pf_estado   = 'V'
        order  by pf_filial,
                  pf_servicio,
                  pf_perfil
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101059
          /*'No existe perfil'*/
          return 1
        end
      end
      if @i_tipo = 'V'
      begin
        select
          pf_descripcion
        from   cl_perfil
        where  pf_filial   = @i_filial
           and pf_servicio = @i_servicio
           and pf_perfil   = @i_perfil
           and pf_estado   = 'V'
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101059
          /*'No existe perfil'*/
          return 1
        end
      end
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

  if @i_operacion = 'Q'
  begin
    if @t_trn = 127
    begin
      select
        @o_filial = pf_filial,
        @o_finombre = fi_nombre,
        @o_servicio = pf_servicio,
        @o_senombre = se_descripcion,
        @o_perfil = pf_perfil,
        @o_pfnombre = pf_descripcion
      from   cl_perfil,
             cl_filial,
             cl_servicio
      where  pf_filial   = @i_filial
         and pf_servicio = @i_servicio
         and pf_perfil   = @i_perfil
         and pf_estado   = 'V'
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
        @o_senombre,
        @o_perfil,
        @o_pfnombre
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

go

