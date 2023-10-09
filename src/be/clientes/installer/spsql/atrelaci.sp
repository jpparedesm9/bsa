/************************************************************************/
/*      Archivo:                atrelaci.sp                             */
/*      Stored procedure:       sp_at_relacion                          */
/*      Base de datos:          cobis                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Sandra Ortiz/Mauricio Bayas             */
/*      Fecha de escritura:     06-May-94                               */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*                             PROPOSITO                                */
/*    Este programa procesa las transacciones del stored procedure      */
/*         Insercion de         cl_at_relacion                          */
/*         Modificacion de      cl_at_relacion                          */
/*         Borrado de           cl_at_relacion                          */
/*         Busqueda de          cl_at_relacion                          */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*    FECHA           AUTOR            RAZON                            */
/*    06-May-94       R. Minga V.      Emision Inicial                  */
/*    May/02/2016     DFu              Migracion CEN                    */
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
           where  name = 'sp_at_relacion')
  drop proc sp_at_relacion
go

create proc sp_at_relacion
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char (1),
  @i_tipo         char (1) = null,
  @i_relacion     int = null,
  @i_atributo     tinyint = null,
  @i_descripcion  varchar (64) = null,
  @i_tdato        varchar (30) = null
)
as
  declare
    @w_return      int,
    @w_sp_name     varchar (32),
    @w_seqnos      int,
    @v_relacion    int,
    @w_relacion    int,
    @v_atributo    tinyint,
    @w_atributo    tinyint,
    @v_descripcion varchar (64),
    @w_descripcion varchar (64),
    @v_tdato       varchar (30),
    @w_tdato       varchar (30)

  select
    @w_sp_name = 'sp_at_relacion'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* ** Insert ** */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1164
    begin
      /* Verificar que exista la relacion */
      if not exists (select
                       *
                     from   cl_relacion
                     where  re_relacion = @i_relacion)
      begin
        /* No existe la relacion */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101087
        return 1
      end

      begin tran
      /* Encontrar un nuevo secuencial en atributos */
      select
        @w_atributo = re_atributo + 1
      from   cl_relacion
      where  re_relacion = @i_relacion

      if @@rowcount <> 1
      begin
        /* Error al insertar el secuencial de atributos */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101057
        return 1
      end

      /* Actualizar secuencial de atributos */
      update cl_relacion
      set    re_atributo = re_atributo + 1
      where  re_relacion = @i_relacion

      if @@error <> 0
      begin
        /* Error al actualizar el secuencial de atributos */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101057
        return 1
      end

      /* Insertar los datos de entrada */
      insert into cl_at_relacion
                  (ar_relacion,ar_atributo,ar_descripcion,ar_tdato)
      values      (@i_relacion,@w_atributo,@i_descripcion,@i_tdato)

      /* Si no se puede insertar error */
      if @@error <> 0
      begin
        /* Error al insertar atributo de relacion */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103064
        return 1
      end

      /* transaccion servicio - at_relacion */
      insert into ts_at_relacion
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,relacion,atributo,
                   descripcion,tdato)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_relacion,@w_atributo,
                   @i_descripcion,@i_tdato)

      /* Si no se puede insertar , error */
      if @@error <> 0
      begin
        /* 'Error en creacion de transaccion de servicios'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        return 1
      end
      commit tran
      select
        @w_atributo
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

  /* ** Update ** */
  if @i_operacion = 'U'
  begin
    if @t_trn = 1199
    begin
      /* seleccionar los datos anteriores */
      select
        @w_descripcion = ar_descripcion
      from   cl_at_relacion
      where  ar_relacion = @i_relacion
         and ar_atributo = @i_atributo

      /* Si no existen o existe mas de uno, error */
      if @@rowcount <> 1
      begin
        /* No existe atributo de relacion */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101120
        return 1
      end

      /* Guargar los datos antiguos */
      select
        @v_descripcion = @w_descripcion

      if @w_descripcion = @i_descripcion
        select
          @w_descripcion = null,
          @v_descripcion = null
      else
        select
          @w_descripcion = @i_descripcion

      begin tran

      /* Modificar el atributo con la nueva descripcion */
      update cl_at_relacion
      set    ar_descripcion = @i_descripcion
      where  ar_relacion = @i_relacion
         and ar_atributo = @i_atributo

      if @@error <> 0
      begin
        /* error al actualizar atributo de relacion */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 105057
        return 1
      end

    /* transaccion servicios - at_relacion */
    /*  insert into ts_at_relacion (secuencial, tipo_transaccion, clase, fecha,
                       usuario, terminal, srv, lsrv,
                       relacion, atributo, descripcion, tdato
    )
         values (@s_ssn, @t_trn, 'P', getdate(),
                 @s_user, @s_term, @s_srv, @s_lsrv,
                 @i_relacion, @i_atributo, @v_descripcion, @v_tdato
    )
      if @@error <> 0
      begin  */
    /* 'Error en creacion de transaccion de servicios'*/
    /*     exec sp_cerror
                 @t_debug        = @t_debug,
                 @t_file         = @t_file,
                 @t_from         = @w_sp_name,
                 @i_num          = 103005
         return 1
      end
    
      insert into ts_at_relacion (secuencial, tipo_transaccion, clase, fecha,
                       usuario, terminal, srv, lsrv,
                       relacion, atributo, descripcion, tdato
    )
         values (@s_ssn, @t_trn, 'A', getdate(),
                 @s_user, @s_term, @s_srv, @s_lsrv,
                 @i_relacion, @i_atributo, @w_descripcion, @w_tdato
    )
      if @@error <> 0
      begin */
    /* 'Error en creacion de transaccion de servicios'*/
      /*   exec sp_cerror
                 @t_debug        = @t_debug,
                 @t_file         = @t_file,
                 @t_from         = @w_sp_name,
                 @i_num          = 103005
         return 1
      end */

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

  /* ** Delete ** */
  if @i_operacion = 'D'
  begin
    if @t_trn = 1200
    begin
      /* Verificar que existe el atributo a borrar */
      select
        @w_descripcion = ar_descripcion,
        @w_tdato = ar_tdato
      from   cl_at_relacion
      where  ar_relacion = @i_relacion
         and ar_atributo = @i_atributo

      if @@rowcount <> 1
      begin
        /* no existe atributo a borrar */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101120
        return 1
      end

      /* chequear si existe referencia en atributos de instancia */
      if exists (select
                   *
                 from   cl_at_instancia
                 where  ai_relacion = @i_relacion
                    and ai_atributo = @i_atributo)
      begin
        /* existe referencia en atributo de instancia */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101121
        return 1
      end

      begin tran

      /* Disminuir el numero de atributos de una relacion */
      update cl_relacion
      set    re_atributo = re_atributo - 1
      where  re_relacion = @i_relacion

      if @@error <> 0
      begin
        /* Error al actualizar el secuencial de atributos */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101057
        return 1
      end

      delete cl_at_relacion
      where  ar_relacion = @i_relacion
         and ar_atributo = @i_atributo

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 107056
        return 1
      end

      /* transaccion servicio - at_relacion */
      insert into ts_at_relacion
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,relacion,atributo,
                   descripcion,tdato)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_relacion,@i_atributo,
                   @w_descripcion,@w_tdato)

      /* Si no se puede insertar , error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
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

  /* ** Search** */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1201
    begin
      select
        'ID' = ar_atributo,
        'Atributo' = convert (char(30), ar_descripcion)
      from   cl_at_relacion
      where  ar_relacion = @i_relacion

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

  /* ** Query especifico para cada sp ** */

  if @i_operacion = 'Q'
  begin
    if @t_trn = 1202
    begin
      select
        'Atributo' = ar_descripcion,
        'Tipo' = ar_tdato
      from   cl_at_relacion
      where  ar_relacion = @i_relacion
         and ar_atributo = @i_atributo

      if @@rowcount <> 1
      begin
        /* No existe atributo de relacion */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101120
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

  /* ** Help ** */
  if @i_operacion = 'H'
  begin
    if @t_trn = 1203
    begin
      /* seleccionar todos los atributos */
      if @i_tipo = 'A'
        select
          'ID' = ar_atributo,
          'Atributo' = convert (char(30), ar_descripcion),
          'Tipo' = ar_tdato
        from   cl_at_relacion
        where  ar_relacion = @i_relacion

      /* seleccionar un atributo dado su codigo */
      if @i_tipo = 'V'
      begin
        select
          'Descripcion' = ar_descripcion,
          'Tipo' = ar_tdato
        from   cl_at_relacion
        where  ar_relacion = @i_relacion
           and ar_atributo = @i_atributo

        if @@rowcount <> 1
        begin
          /* No existe atributo de relacion */
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101120
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

go

