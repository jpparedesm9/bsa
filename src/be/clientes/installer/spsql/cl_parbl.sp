/************************************************************************/
/*  Archivo:                cl_parbl.sp                                 */
/*  Stored procedure:       sp_param_bloqueado                          */
/*  Base de datos:          cobis                                       */
/*  Producto:               Clientes                                    */
/*  Disenado por:           Edna Laguna.                                */
/*  Fecha de documentacion: 27/Junio/2006                               */
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
/*      Mantenimiento y consulta de la tabla cl_tran_bloquea            */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*     FECHA       AUTOR        RAZON                                   */
/*       2006-06-27    Martha Gil V.        Emision Inicial             */
/*       2006-07-14    Martha Gil V.        Adición de Operacion M      */
/*       2016-05-02    DFu                  Migracion CEN               */
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
           where  name = 'sp_param_bloqueado')
  drop proc sp_param_bloqueado
go

create proc sp_param_bloqueado
(
  @s_ssn                int,
  @s_user               login,
  @s_term               varchar(30),
  @s_date               datetime,
  @s_srv                varchar(30),
  @s_lsrv               varchar(30) = null,
  @s_ofi                smallint = null,
  @t_debug              char(1) = 'N',
  @t_file               varchar(14) = null,
  @t_from               descripcion = null,
  @t_trn                smallint = null,
  @t_show_version       bit = 0,
  @i_operacion          char (1),
  @i_modo               tinyint = null,
  @i_codproducto        tinyint = null,
  @i_abreviatura        char(3) = null,
  @i_descripcion        descripcion = null,
  @i_transaccion        int = null,
  @i_des_tran           descripcion = null,
  @i_estado             estado = null,
  @i_supervisor         char(1) = null,
  @i_tipo_evento        char(1) = null,
  @i_fecha_registro     datetime = null,
  @i_fecha_modificacion datetime = null,
  @o_estado             estado = null output,
  @o_supervisor         char(1) = null output,
  @o_tipo_evento        char(1) = null output
)
as
  declare
    @w_sp_name descripcion,
    @w_return  int

  /*  Inicializar nombre del stored procedure  */
  select
    @w_sp_name = 'sp_param_bloqueado'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* ** Insercion ** */
  if @i_operacion = 'I'
  begin
    if @t_trn <> 1131
    begin
      /* Codigo de transaccion invalido */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      return 1
    end

    if exists (select
                 *
               from   cobis..cl_tran_bloqueada
               where  tr_codproducto = @i_codproducto
                  and tr_transaccion = @i_transaccion)
    begin
      /****** YA existe ese Registro  ********/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @t_from,
        @i_num   = 101186,
        @i_msg   = 'Ya existe Registro de transacción bloqueada '
      return 1
    end

    begin tran

    insert cobis..cl_tran_bloqueada
           (tr_codproducto,tr_abreviatura,tr_descripcion,tr_transaccion,
            tr_des_tran,
            tr_estado,tr_supervisor,tr_tipo_evento,tr_fecha_registro,
            tr_fecha_modificacion,
            tr_funcionario)
    values ( @i_codproducto,@i_abreviatura,@i_descripcion,@i_transaccion,
             @i_des_tran,
             @i_estado,@i_supervisor,@i_tipo_evento,@i_fecha_registro,
             @i_fecha_modificacion,
             @s_user)

    if @@rowcount = 0
        or @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @t_from,
        @i_num   = 103058,
        @i_msg   = 'Error en inserción de transacción bloqueada '

      rollback tran
    end

    commit tran

  end

  /* ** Modificacion ** */
  if @i_operacion = 'U'
  begin
    if @t_trn <> 1132
    begin
      /* Codigo de transaccion invalido */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      return 1
    end

    if not exists (select
                     *
                   from   cobis..cl_tran_bloqueada
                   where  tr_codproducto = @i_codproducto
                      and tr_transaccion = @i_transaccion)
    begin
      /****** No existe registro a Modificar ********/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @t_from,
        @i_num   = 101001,
        @i_msg   = 'NO existe Registro de transacción bloqueada a Modificar'

      return 1
    end

    begin tran

    update cobis..cl_tran_bloqueada
    set    tr_estado = @i_estado,
           tr_supervisor = @i_supervisor,
           tr_tipo_evento = @i_tipo_evento,
           tr_fecha_registro = @i_fecha_registro,
           tr_fecha_modificacion = @i_fecha_modificacion,
           tr_funcionario = @s_user
    where  tr_codproducto = @i_codproducto
       and tr_transaccion = @i_transaccion

    if @@rowcount = 0
        or @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @t_from,
        @i_num   = 103058,
        @i_msg   = 'Error en inserción de transacción bloqueada '

      rollback tran
    end

    commit tran
  end

  /* ** Eliminacion ** */
  if @i_operacion = 'D'
  begin
    if @t_trn <> 1134
    begin
      /* Codigo de transaccion invalido */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      return 1
    end

    if not exists (select
                     *
                   from   cobis..cl_tran_bloqueada
                   where  tr_codproducto = @i_codproducto
                      and tr_transaccion = @i_transaccion)
    begin
      /****** No existe registro a Modificar ********/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @t_from,
        @i_num   = 101001,
        @i_msg   = 'NO existe Registro de transacción bloqueada a Eliminar'

      return 1
    end

    begin tran

    delete cobis..cl_tran_bloqueada
    where  tr_codproducto = @i_codproducto
       and tr_transaccion = @i_transaccion

    if @@rowcount = 0
        or @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @t_from,
        @i_num   = 107052,
        @i_msg   = 'Error en eliminación de transacción bloqueada '

      rollback tran
    end

    commit tran

  end

  /* ** Consulta ** */
  if @i_operacion = 'S'
  begin
    if @t_trn <> 1133
    begin
      /* Codigo de transaccion invalido */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      return 1
    end

    set rowcount 20

    if @i_modo = 0
    begin
      select
        PRODUCTO=tr_codproducto,
        ABREVIATURA=tr_abreviatura,
        DESCRIPCION=tr_descripcion,
        TRANSACCION=tr_transaccion,
        DESC_TRANSACCION=tr_des_tran
      from   cobis..cl_tran_bloqueada
    end
    if @i_modo = 1
    begin
      select
        PRODUCTO=tr_codproducto,
        ABREVIATURA=tr_abreviatura,
        DESCRIPCION=tr_descripcion,
        TRANSACCION=tr_transaccion,
        DESC_TRANSACCION=tr_des_tran
      from   cobis..cl_tran_bloqueada
      where  tr_codproducto > @i_codproducto
          or (tr_codproducto = @i_codproducto
              and tr_transaccion > @i_transaccion)
    end

  end

  /* ** Busqueda de Transacciones ** */
  if @i_operacion = 'Q'
  begin
    set rowcount 20

    if @i_modo = 0
    begin
      select distinct
        TRANSACCION= ta_transaccion,
        DESC_TRANSACCION=tn_descripcion
      from   cobis..ad_tr_autorizada,
             cobis..cl_ttransaccion
      where  ta_transaccion = tn_trn_code
         and ta_producto    = @i_codproducto
    end
    if @i_modo = 1
    begin
      select distinct
        TRANSACCION= ta_transaccion,
        DESC_TRANSACCION=tn_descripcion
      from   cobis..ad_tr_autorizada,
             cobis..cl_ttransaccion
      where  ta_transaccion = tn_trn_code
         and ta_producto    = @i_codproducto
         and ta_transaccion > @i_transaccion
    end
    if @i_modo = 2
    begin
      select
        DESC_TRANSACCION=tn_descripcion
      from   cobis..ad_tr_autorizada,
             cobis..cl_ttransaccion
      where  ta_transaccion = tn_trn_code
         and ta_producto    = @i_codproducto
         and ta_transaccion = @i_transaccion
    end
  end

  /* ** Busqueda de Transacciones Bloqueadas** */
  if @i_operacion = 'F'
  begin
    select
      tr_codproducto,
      tr_abreviatura,
      tr_descripcion,
      tr_transaccion,
      tr_des_tran,
      tr_estado,
      tr_supervisor,
      tr_tipo_evento,
      convert(varchar(10), tr_fecha_registro, 103),
      convert(varchar(10), tr_fecha_modificacion, 103),
      tr_funcionario
    from   cobis..cl_tran_bloqueada
    where  tr_codproducto = @i_codproducto
       and tr_transaccion = @i_transaccion

    if @@rowcount = 0
    begin
      /****** No existe registro buscado ********/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @t_from,
        @i_num   = 105506,
        @i_msg   = 'NO existe Registro de transacción bloqueada '

      return 1
    end

  end

  /* ** Retorna Transacciones Bloqueadas a los modulos ** */
  if @i_operacion = 'M'
  begin
    select
      @o_estado = tr_estado,
      @o_supervisor = tr_supervisor,
      @o_tipo_evento = tr_tipo_evento
    from   cobis..cl_tran_bloqueada
    where  tr_codproducto = @i_codproducto
       and tr_transaccion = @i_transaccion

    if @@rowcount = 0
    begin
      /****** No existe registro buscado ********/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @t_from,
        @i_num   = 105506,
        @i_msg   = 'NO existe Registro de transacción bloqueada '

      return 1
    end

  end

  return 0

go

