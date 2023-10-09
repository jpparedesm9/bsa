/************************************************************************/
/*   Archivo:       cuenta.sp                                           */
/*   Stored procedure:   sp_cuenta                                      */
/*   Base de datos:      cobis                                          */
/*   Producto:           Clientes                                       */
/*   Disenado por:            Sandra Ortiz                              */
/*   Fecha de escritura:      01-Sep-1993                               */
/************************************************************************/
/*                  IMPORTANTE                                          */
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
/*                  PROPOSITO                                           */
/*   Permite el mantenimiento:  insert, update, delete de regis-        */
/*   tros en la tabla cl_cuenta.  Esta tabla es utilizada para          */
/*   crear los balances anuales de los clientes tipo compania           */
/*   cuya situacion financiera interesa al banco.                       */
/************************************************************************/
/*                  MODIFICACIONES                                      */
/*   FECHA          AUTOR          RAZON                                */
/*   01/Sep/1993    S Ortiz        Emision inicial                      */
/*      12/Mar/2003     E Laguna        Ajustes cuenta int              */
/*      26/Nov/2003     D Duran         Ajuste Longitud Descripcion     */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/

use cobis
go

if exists (select
             *
           from   sysobjects
           where  name like 'sp_cuenta')
  drop proc sp_cuenta
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_cuenta
(
  @s_ssn          int,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
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
  @i_operacion    char (1),
  @i_modo         tinyint = null,
  @i_tipo         char (1) = null,
  @i_cuenta       int = null,
  @i_descripcion  descripcion = null,
  @i_categoria    char (1) = null,
  @i_estado       estado = null
)
as
  declare
    @w_sp_name     char (10),
    @w_return      int,
    @w_siguiente   int,
    @w_cuenta      int,
    @w_descripcion descripcion,
    @w_estado      estado,
    @w_categoria   char (1),
    @v_descripcion descripcion,
    @v_categoria   char (1),
    @v_estado      estado

  /*  Inicializacion de Variables  */
  select
    @w_sp_name = 'sp_cuenta'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Insert  */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1180
    begin
      /* verificar que es validad la categoria */
      if @i_categoria not in ('A', 'I', 'S', 'C',
                              'P', 'T', 'E', 'O') /* RIA01 */
      begin
        /*  Categoria de Cuenta incorrecta  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101166
        return 1
      end

      if exists (select
                   ct_cuenta
                 from   cl_cuenta
                 where  ct_cuenta = @i_cuenta)
      begin
        /*  Ya existe cuenta  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101167
        return 1
      end

      begin tran

    /* encontrar un nuevo secuencial para la nueva cuenta */
    /*   exec @w_return = cobis..sp_cseqnos
              @t_debug  = @t_debug,
              @t_file        = @t_file,
              @t_from        = @w_sp_name,
              @i_tabla  = 'cl_cuenta',
              @o_siguiente   = @w_siguiente out */
    /*   if @w_return <> 0
              return @w_return   */
      /* insertar los datos de entrada */
      insert into cl_cuenta
                  (ct_cuenta,ct_descripcion,ct_categoria,ct_estado)
      values      (@i_cuenta,@i_descripcion,@i_categoria,'V')
      if @@error <> 0
      begin
        /*  Error en creacion de cuenta de balance  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103077
        return 1
      end

      /*  Transaccion de Servicio  */
      insert into ts_cuenta
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,cuenta,descripcion,
                   categoria,estado)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_cuenta,@i_descripcion,
                   @i_categoria,'V')
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
      commit tran

    /* retornar el codigo generado para la nueva cuenta */
      /*select @i_siguiente */

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

  /*  Update  */
  if @i_operacion = 'U'
  begin
    if @t_trn = 1220
    begin
      /* verificar que es validad la categoria */
      if @i_categoria not in ('P', 'T', 'E', 'O',
                              'A', 'I', 'S', 'C')
      begin
        /*  Categoria de Cuenta incorrecta  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101166
        return 1
      end

      select
        @w_descripcion = ct_descripcion,
        @w_categoria = ct_categoria,
        @w_estado = ct_estado
      from   cl_cuenta
      where  ct_cuenta = @i_cuenta

      if @@rowcount <> 1
      begin
        /*  Cuenta de balance no existe  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101161
        return 1
      end
      select
        @v_descripcion = @w_descripcion,
        @v_categoria = @w_categoria,
        @v_estado = @v_estado

      if @w_descripcion = @i_descripcion
        select
          @w_descripcion = null,
          @v_descripcion = null
      else
        select
          @w_descripcion = @i_descripcion

      if @w_categoria = @i_categoria
        select
          @w_categoria = null,
          @v_categoria = null
      else
        select
          @w_categoria = @i_categoria

      if @w_estado = @i_estado
        select
          @w_estado = null,
          @v_estado = null
      else
      begin
        if @i_estado = 'C'
        begin
          if exists (select
                       *
                     from   cl_plan
                     where  pl_cuenta = @i_cuenta)
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101114
            /* Existe referencia en plan */
            return 1
          end
        end
        select
          @w_estado = @i_estado
      end

      begin tran
      update cl_cuenta
      set    ct_descripcion = @i_descripcion,
             ct_categoria = @i_categoria,
             ct_estado = @i_estado
      where  ct_cuenta = @i_cuenta

      if @@rowcount <> 1
      begin
        /*  Error en actualizacion de cuenta de balance  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  =105070
        return 1
      end

      /*  Transaccion de Servicio - Previo */
      insert into ts_cuenta
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,cuenta,descripcion,
                   categoria,estado)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_cuenta,@v_descripcion,
                   @v_categoria,@v_estado)
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

      /*  Transaccion de Servicio - Actual */
      insert into ts_cuenta
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,cuenta,descripcion,
                   categoria,estado)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_cuenta,@w_descripcion,
                   @w_categoria,@w_estado)
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

  /*  Delete  */
  if @i_operacion = 'D'
  begin
    if @t_trn = 1221
    begin
      select
        @w_categoria = ct_categoria,
        @w_descripcion = ct_descripcion,
        @w_estado = ct_estado
      from   cl_cuenta
      where  ct_cuenta = @i_cuenta
      if @@rowcount = 0
      begin
        /*  Cuenta de balance no existe  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101162
        return 1
      end

      /* no se puede borrar si existe referencia en un plan */
      if exists (select
                   *
                 from   cl_plan
                 where  pl_cuenta = @i_cuenta)
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101114
        /* Existe referencia en plan */
        return 1
      end

      begin tran
      delete cl_cuenta
      where  ct_cuenta = @i_cuenta
      if @@error <> 0
      begin
        /*  Error en eliminacion de Cuenta de Balance  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 107066
        return 1
      end

      /*  Transaccion de Servicio  */
      insert into ts_cuenta
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,cuenta,descripcion,
                   categoria,estado)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_cuenta,@w_descripcion,
                   @w_categoria,@w_estado)
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

  /*  Search  */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1222
    begin
      set rowcount 20
      if @i_modo = 0
        select
          'Cuenta' = ct_cuenta,
          'Descripcion' = ct_descripcion,
          'Categoria' = ct_categoria,
          'Estado' = ct_estado
        from   cl_cuenta
        order  by ct_cuenta
      else if @i_modo = 1
        select
          'Cuenta' = ct_cuenta,
          'Descripcion' = ct_descripcion,
          'Categoria' = ct_categoria,
          'Estado' = ct_estado
        from   cl_cuenta
        where  ct_cuenta > @i_cuenta
        order  by ct_cuenta
      set rowcount 0
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

  /* ** Query ** */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1223
    begin
      set rowcount 20
      if @i_modo = 0
        select
          'Cuenta' = ct_cuenta,
          'Descripcion' = convert(char(30), ct_descripcion),
          'Categoria' = ct_categoria,
          'Estado' = ct_estado
        from   cl_cuenta
        where  ct_estado    = 'V'
           and ct_categoria = @i_categoria
      else if @i_modo = 1
        select
          'Cuenta' = ct_cuenta,
          'Descripcion' = convert(char(30), ct_descripcion),
          'Categoria' = ct_categoria,
          'Estado' = ct_estado
        from   cl_cuenta
        where  ct_estado    = 'V'
           and ct_cuenta    > @i_cuenta
           and ct_categoria = @i_categoria
      set rowcount 0
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

  /* ** Help ** */
  if @i_operacion = 'H'
  begin
    if @t_trn = 1224
    begin
      if @i_tipo = 'A'
      begin
        set rowcount 20
        if @i_modo = 0
        begin
          if @i_categoria = 'A'
            select
              ct_cuenta,
              convert(char(30), ct_descripcion)
            from   cl_cuenta
            where  ct_estado = 'V'
               and ct_categoria in ('A', 'I', 'S', 'C')
          --= @i_categoria GCastaneda 25/03/2003
          else
            select
              ct_cuenta,
              convert(char(30), ct_descripcion)
            from   cl_cuenta
            where  ct_estado = 'V'
               and ct_categoria in ('P', 'T', 'E', 'O')
        --= @i_categoria 'ELA JUL/2001

        end

        if @i_modo = 1
        begin
          if @i_categoria = 'A'
            select
              ct_cuenta,
              convert(char(30), ct_descripcion)
            from   cl_cuenta
            where  ct_cuenta > @i_cuenta
               and ct_estado = 'V'
               and ct_categoria in ('A', 'I', 'S', 'C')
            --= @i_categoria GCastaneda 25/03/2003
            order  by ct_cuenta
          else
            select
              ct_cuenta,
              convert(char(30), ct_descripcion)
            from   cl_cuenta
            where  ct_cuenta > @i_cuenta
               and ct_estado = 'V'
               and ct_categoria in ('P', 'T', 'E', 'O')
            --= @i_categoria 'ELA JUL/2001
            order  by ct_cuenta
        end
        set rowcount 0
        return 0

      end
      if @i_tipo = 'V'
      begin
        /* Desarrollo modificado para validar categoria de cuenta 25/03/2003 GCastaneda */
        if @i_categoria = 'A'
        begin
          select
            convert(char(30), ct_descripcion)
          from   cl_cuenta
          where  ct_cuenta = @i_cuenta
             and ct_estado = 'V'
             and ct_categoria in ('A', 'I', 'S', 'C')

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101113
            return 1
          end
        end
        else
        begin
          select
            convert(char(30), ct_descripcion)
          from   cl_cuenta
          where  ct_cuenta = @i_cuenta
             and ct_estado = 'V'
             and ct_categoria in ('P', 'T', 'E', 'O')

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101113
            return 1
          end
        end
        return 0

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

  end

go

