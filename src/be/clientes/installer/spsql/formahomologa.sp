/************************************************************************/
/*  Archivo:        formahomologa.sp                                    */
/*  Stored procedure:   sp_forma_homologa                               */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Cristhian Herrera                                    */
/*  Fecha de escritura: 18-Abri-2001                                    */
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
/*  Este programa procesa permite especificar las formas de pagos       */
/*      que aplicarán al proceso SIPLA, para cada módulo                */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  18/Abr/2001 C. Herrera  Emision Inicial                             */
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
           where  name = 'sp_forma_homologa')
     drop proc sp_forma_homologa
go

create proc sp_forma_homologa
(
  @s_ssn                int = null,
  @s_user               login = null,
  @s_term               varchar(30) = null,
  @s_date               datetime = null,
  @s_srv                varchar(30) = null,
  @s_lsrv               varchar(30) = null,
  @s_ofi                smallint = null,
  @s_rol                smallint = null,
  @t_debug              char(1) = 'N',
  @t_file               varchar(10) = null,
  @t_from               varchar(32) = null,
  @t_trn                smallint = null,
  @t_show_version       bit = 0,
  @i_operacion          char(1),
  @i_codproducto        tinyint = null,
  @i_abreviatura        char(3) = null,
  @i_producto           descripcion = null,
  @i_forma_homologa     catalogo = null,
  @i_descripcion        descripcion = null,
  @i_estado             char(1) = null,
  @i_estado_ant         char(1) = null,
  @i_fecha_registro     datetime = null,
  @i_fecha_modificacion datetime = null,
  @i_formato_fecha      int = null
)
as
  declare
    @w_sp_name            varchar(32),
    @w_return             int,
    @w_codigo             int,
    @o_siguiente          int,
    @w_today              datetime,
    /*sipla*/
    @w_codproducto        tinyint,
    @w_abreviatura        char(3),
    @w_producto           descripcion,
    @w_forma_homologa     catalogo,
    @w_descripcion        descripcion,
    @w_estado             char(1),
    @w_estado_ant         char(1),
    @w_funcionario        login,
    @w_fecha_registro     datetime,
    @w_fecha_modificacion datetime,
    /*sipla*/
    @v_codproducto        tinyint,
    @v_abreviatura        char(3),
    @v_producto           descripcion,
    @v_forma_homologa     catalogo,
    @v_descripcion        descripcion,
    @v_estado             char(1),
    @v_estado_ant         char(1),
    @v_fecha_registro     datetime,
    @v_fecha_modificacion datetime,
    @v_funcionario        login,
    @v_today              datetime,
    @o_fecha_registro     datetime,
    @o_fecha_modificacion datetime,
    @o_funcionario        login,
    /*sipla*/
    @o_codproducto        tinyint,
    @o_abreviatura        char(3),
    @o_producto           descripcion,
    @o_forma_homologa     catalogo,
    @o_descripcion        descripcion,
    @o_estado             char(1),
    @o_fecha_creado       datetime,
    @o_fecha_modificado   datetime

  select
    @w_sp_name = 'sp_forma_homologa'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = getdate()

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 1464
    begin
      /* Verificar que exista el producto */

      select
        @w_codproducto = null
      from   cl_producto
      where  pd_producto = @i_codproducto

      /* si no existe el producto, error */

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105123
        /*'No existe Producto'*/
        return 1
      end

      /*Obtener la abreviatura del producto*/

      if @i_abreviatura is null
        select
          @w_abreviatura = pd_abreviatura
        from   cl_producto
        where  pd_producto = @i_codproducto
      else
        select
          @w_abreviatura = @i_abreviatura

      /*'Verificar que exista la forma Homologa'*/

      if @i_forma_homologa is not null
      begin
        exec @w_return = cobis..sp_catalogo
          @t_debug    = @t_debug,
          @t_file     = @t_file,
          @t_from     = @w_sp_name,
          @i_tabla    = 'cl_cforma',
          @i_operacion= 'E',
          @i_codigo   = @i_forma_homologa

        /* 'si no existe forma Homologa, error' */
        if @w_return <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105124
          /* 'No existe forma Homologa'*/
          return 1
        end
      end

      begin tran
      /*insertar datos de Forma Homologa*/
      insert into cl_forma_homologa
                  (fh_codproducto,fh_abreviatura,fh_producto,fh_forma_hom,
                   fh_descripcion,
                   fh_estado,fh_fecha_registro,fh_fecha_modificacion,
                   fh_funcionario)
      values      (@i_codproducto,@w_abreviatura,@i_producto,@i_forma_homologa,
                   @i_descripcion,
                   @i_estado,@w_today,@i_fecha_modificacion,@s_user)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105125
        /* 'Error en creacion de Forma Homologa'*/
        return 1
      end

      /*Transacciones de servicio*/

      insert into ts_forma_homologa
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,producto,forma_homologa,
                   estado,fecha_registro,fecha_modificacion)
      values      (@s_ssn,@t_trn,'N',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_abreviatura,@i_forma_homologa,
                   @i_estado,@w_today,@i_fecha_modificacion)

      /* si no se puede insertar, error */

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105129
        /* 'Error en creacion de transaccion de servicios'*/

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

  /** Update **/
  if @i_operacion = 'U'
  begin
    if @t_trn = 1465
    begin
      /*Verificar que exista el producto*/

      select
        @w_codproducto = null
      from   cl_producto
      where  pd_producto = @i_codproducto

      /* si no existe el producto, error */

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105123
        /*'No existe Producto'*/
        return 1
      end

      /*Obtener la abreviatura del producto*/

      if @i_abreviatura is null
        select
          @w_abreviatura = pd_abreviatura
        from   cl_producto
        where  pd_producto = @i_codproducto
      else
        select
          @w_abreviatura = @i_abreviatura

      /*'Verificar que exista la forma Homologa'*/

      if @i_forma_homologa is not null
      begin
        exec @w_return = cobis..sp_catalogo
          @t_debug    = @t_debug,
          @t_file     = @t_file,
          @t_from     = @w_sp_name,
          @i_tabla    = 'cl_cforma',
          @i_operacion= 'E',
          @i_codigo   = @i_forma_homologa

        /* 'si no existe forma Homologa, error' */
        if @w_return <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105124
          /* 'No existe forma Homologa'*/
          return 1
        end
      end

      /* Control de campos a actualizar */
      select
        @w_forma_homologa = fh_forma_hom,
        @w_descripcion = fh_descripcion,
        @w_estado = fh_estado,
        @w_fecha_registro = fh_fecha_registro,
        @w_fecha_modificacion = fh_fecha_modificacion,
        @w_funcionario = fh_funcionario
      from   cl_forma_homologa
      where  fh_abreviatura = @w_abreviatura
         and fh_forma_hom   = @i_forma_homologa
         and fh_estado      = @i_estado_ant

      if @@rowcount <> 1
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105102

        return 1
      end

      select
        @v_forma_homologa = @w_forma_homologa,
        @v_descripcion = @w_descripcion,
        @v_estado = @w_estado,
        @v_fecha_registro = @w_fecha_registro,
        @v_fecha_modificacion = @w_fecha_modificacion,
        @v_funcionario = @w_funcionario

      if @w_forma_homologa = @i_forma_homologa
        select
          @w_forma_homologa = null,
          @v_forma_homologa = null
      else
        select
          @w_forma_homologa = @i_forma_homologa

      if @w_descripcion = @i_descripcion
        select
          @w_descripcion = null,
          @v_descripcion = null
      else
        select
          @w_descripcion = @i_descripcion

      if @w_estado = @i_estado
        select
          @w_estado = null,
          @v_estado = null
      else
        select
          @w_estado = @i_estado

      if @w_fecha_registro = @i_fecha_registro
        select
          @w_fecha_registro = null,
          @v_fecha_registro = null
      else
        select
          @w_fecha_registro = @i_fecha_registro

      if @w_fecha_modificacion = @i_fecha_modificacion
        select
          @w_fecha_modificacion = null,
          @v_fecha_modificacion = null
      else
        select
          @w_fecha_modificacion = @i_fecha_modificacion

      if @w_funcionario = @s_user
        select
          @w_funcionario = null,
          @v_funcionario = null
      else
        select
          @w_funcionario = @s_user

      begin tran
      update cl_forma_homologa
      set    /*fh_abreviatura      = @i_abreviatura,*/
      fh_forma_hom = @i_forma_homologa,
      fh_descripcion = @i_descripcion,
      fh_estado = @i_estado,
      fh_fecha_modificacion = @w_today,
      fh_funcionario = @s_user
      where  fh_codproducto = @i_codproducto
         and fh_abreviatura = @w_abreviatura
         and fh_forma_hom   = @i_forma_homologa
         and fh_estado      = @i_estado_ant

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105126
        /* 'Error en actualizacion de forma Homologa'*/
        return 1
      end

      /* Transaccion servicios - cl_forma_homologa */

      insert into ts_forma_homologa
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,producto,forma_homologa,
                   estado,fecha_registro,fecha_modificacion)
      values      (@s_ssn,@t_trn,'P',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_abreviatura,@v_forma_homologa,
                   @v_estado,@v_today,@v_fecha_modificacion)

      /* si no se puede insertar, error */

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105129
        /* 'Error en creacion de transaccion de servicios'*/

        return 1
      end

      insert into ts_forma_homologa
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,producto,forma_homologa,
                   estado,fecha_registro,fecha_modificacion)
      values      (@s_ssn,@t_trn,'A',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_abreviatura,@w_forma_homologa,
                   @w_estado,@w_today,@w_fecha_modificacion)

      /* si no se puede insertar, error */

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105129
        /*'Error en creacion de transaccion de servicios'*/
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

  /** Delete **/
  if @i_operacion = 'D'
  begin
    if @t_trn = 1466
    begin
      /*Verificar que exista el producto*/

      select
        @w_codproducto = null
      from   cl_producto
      where  pd_producto = @i_codproducto

      /* si no existe el producto, error */

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105123
        /*'No existe Producto'*/
        return 1
      end

      /*Obtener la abreviatura del producto*/
      if @i_abreviatura is null
        select
          @w_abreviatura = pd_abreviatura
        from   cl_producto
        where  pd_producto = @i_codproducto
      else
        select
          @w_abreviatura = @i_abreviatura

      /*Campos para la transaccion de Servicios*/
      select
        @w_forma_homologa = fh_forma_hom,
        @w_descripcion = fh_descripcion,
        @w_estado = fh_estado,
        @w_fecha_registro = fh_fecha_registro,
        @w_fecha_modificacion = fh_fecha_modificacion,
        @w_funcionario = fh_funcionario
      from   cl_forma_homologa
      where  fh_codproducto = @i_codproducto
         and fh_abreviatura = @w_abreviatura
         and fh_forma_hom   = @i_forma_homologa
         and fh_estado      = @i_estado

      if @@rowcount <> 1
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105124
        /* 'No existe producto' */
        return 1
      end

      begin tran

      /*Borrar la forma Homologa*/

      delete from cl_forma_homologa
      where  fh_codproducto = @i_codproducto
         and fh_abreviatura = @w_abreviatura
         and fh_forma_hom   = @i_forma_homologa
         and fh_estado      = @i_estado

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105127
        /*'Error en eliminacion de Forma Homologa'*/
        return 1
      end

      insert into ts_forma_homologa
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,producto,forma_homologa,
                   estado,fecha_registro,fecha_modificacion)
      values      (@s_ssn,@t_trn,'B',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_abreviatura,@w_forma_homologa,
                   @w_estado,@w_fecha_registro,@i_fecha_modificacion)

      /* si no se puede insertar, error */

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105129

        /*'Error en creacion de transaccion de servicios'*/

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
        @i_num   = 151051 /*Se debe cambiar*/
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

  /** Search **/

  if @i_operacion = 'S'
  begin
    if @t_trn = 1467
    begin
      select
        'Codigo' = fh_codproducto,
        'Abreviatura' = fh_abreviatura,
        'Producto' = fh_producto,
        'Forma Homologa' = fh_forma_hom,
        'Descripcion' = fh_descripcion,
        'Estado' = fh_estado,
        'Fecha Registro' = convert(char(10), fh_fecha_registro, @i_formato_fecha
                           ),
        'Fecha ult Mofic.'= convert(char(10), fh_fecha_modificacion,
                            @i_formato_fecha)
        ,
        'Funcionario' = fh_funcionario
      from   cl_forma_homologa,
             cl_catalogo x,
             cl_tabla y
      where  fh_forma_hom = x.codigo
         and x.tabla      = y.codigo
         and y.tabla      = 'cl_cforma'
      order  by fh_abreviatura

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

