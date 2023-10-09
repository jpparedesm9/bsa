/************************************************************************/
/*  Archivo:            relacion.sp                                     */
/*  Stored procedure:   sp_relacion                                     */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Sandra Ortiz                                    */
/*  Fecha de escritura: 23-Jul-1993                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*  Permite realizar operaciones DML en la tabla cl_relacion,           */
/*  que es la tabla que contiene la descripcion de las relaciones       */
/*  genericas que pueden mantener dos instancias de cl_ente.            */
/*      Consultas de relacion                                           */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA       AUTOR       RAZON                                       */
/*  23-Jul-1993 S Ortiz     Emision inicial                             */
/*  30-Ago-1993 S Ortiz     Eliminacion de relacion                     */
/*  29-Nov-93   R Minga V.  Param @s_, Verificacion y  validacion       */
/*                                                                      */
/*  20/Abr/94   C.Rodriguez Todo lo concerniente a la columna           */
/*                          in_instancia                                */
/*  07-May-1994 R. Minga V. Verificacion y validacion,                  */
/*                          atributos de relacion                       */
/*  11-Abr-2003 E.Laguna    Ajustes consultas (siguientes)              */
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
           where  name = 'sp_relacion')
           drop proc sp_relacion
go

create proc sp_relacion
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
  @t_debug        char (1) = 'N',
  @t_file         varchar (14) = null,
  @t_from         varchar (30) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char (1),
  @i_modo         tinyint = null,
  @i_tipo         char (1) = null,
  @i_relacion     int = null,
  @i_descripcion  descripcion = null,
  @i_izquierda    descripcion = null,
  @i_derecha      descripcion = null
)
as
  declare
    @w_sp_name     varchar (30),
    @w_return      int,
    @w_relacion    int,
    @w_descripcion descripcion,
    @w_izquierda   descripcion,
    @w_derecha     descripcion,
    @v_descripcion descripcion,
    @v_izquierda   descripcion,
    @v_derecha     descripcion

  /*  Captura nombre del Stored Procedure  */
  select
    @w_sp_name = 'sp_relacion'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Insert  */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1138
    begin
      begin tran

      /* obtener un secuencial para la nueva relacion */
      exec cobis..sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_relacion',
        @o_siguiente = @w_relacion out

      /* insertar la nueva relacion */
      insert into cl_relacion
                  (re_relacion,re_descripcion,re_izquierda,re_derecha,re_tabla,
                   re_catalogo,re_atributo)
      values      (@w_relacion,@i_descripcion,@i_izquierda,@i_derecha,null,
                   null,0)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        /*  Error en creacion de relacion  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103059
        return 1

      end

      /*  Transaccion de Servicio  */
      insert into ts_relacion
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,relacion,descripcion,
                   izquierda,derecha)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_relacion,@i_descripcion,
                   @i_izquierda,@i_derecha)

      /* si no se puede insertar, error */
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
		
		
      /* retorna el siguiente secuencial para la relacion */
      select
        @w_relacion
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
    if @t_trn = 1139
    begin
      /* Verificar que exista la relacion */
      select
        @w_descripcion = re_descripcion,
        @w_izquierda = re_izquierda,
        @w_derecha = re_derecha
      from   cl_relacion
      where  re_relacion = @i_relacion

      /* si no existe la relacion, error */
      if @@rowcount = 0
      begin
        /*  No existe relacion  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101087
        return 1
      end

      /* guardar los datos anteriores */
      select
        @v_descripcion = @w_descripcion,
        @v_izquierda = @w_izquierda,
        @v_derecha = @w_derecha

      if @w_descripcion = @i_descripcion
        select
          @w_descripcion = null,
          @v_descripcion = null
      else
        select
          @w_descripcion = @i_descripcion

      if @w_izquierda = @i_izquierda
        select
          @w_izquierda = null,
          @v_izquierda = null
      else
        select
          @w_izquierda = @i_izquierda

      if @w_derecha = @i_derecha
        select
          @w_derecha = null,
          @v_derecha = null
      else
        select
          @w_derecha = @i_derecha

      begin tran
      /* modificar los datos */
      update cl_relacion
      set    re_descripcion = @i_descripcion,
             re_izquierda = @i_izquierda,
             re_derecha = @i_derecha
      where  re_relacion = @i_relacion

      /* si no se puede modificar, error */
      if @@rowcount = 0
      begin
        /*  Error en actualizacion de relacion  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 105054
        return 1
      end

      /*  Transaccion de servicio  */
      insert into ts_relacion
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,relacion,descripcion,
                   izquierda,derecha)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_relacion,@v_descripcion,
                   @v_izquierda,@v_derecha)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        /*   Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end

      /*  Transaccion de Servicio  */
      insert into ts_relacion
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,relacion,descripcion,
                   izquierda,derecha)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_relacion,@w_descripcion,
                   @w_izquierda,@w_derecha)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        /*   Error en creacion de transaccion de servicio  */
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
    if @t_trn = 1137
    begin
      /* Verificar que no exista referencia en instancia */
      if exists (select
                   *
                 from   cl_instancia
                 where  in_relacion = @i_relacion)
      begin
        /*  Existe referencia en instancia  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101123
        return 1
      end

      /* guardar los datos anteriores */
      select
        @w_descripcion = re_descripcion,
        @w_izquierda = re_izquierda,
        @w_derecha = re_derecha
      from   cl_relacion
      where  re_relacion = @i_relacion

      /* si no existe datos anteriores, error  */
      if @@rowcount = 0
      begin
        /*  No existe relacion  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101087
        return 1
      end

      begin tran

      /* borrar la relacion */
      delete cl_relacion
      where  re_relacion = @i_relacion

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        /*  No existe relacion  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 107055
        return 1
      end

      /*  Transaccion de Servicio  */
      insert into ts_relacion
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,relacion,descripcion,
                   izquierda,derecha)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_relacion,@w_descripcion,
                   @w_izquierda,@w_derecha)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        /*   Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end

      /* Borrar en cascada los atributos de la relacion */
      delete cl_at_relacion
      where  ar_relacion = @i_relacion

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
  /* Encontrar todas las relaciones definidas */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1194
    begin
      set rowcount 20
      if @i_modo = 0
        select
          'Codigo' = re_relacion,
          'Relacion' = convert(varchar(50), re_descripcion)
        from   cl_relacion
        --where  re_relacion < 200   ELA ABR/2003
        order  by re_relacion
      if @i_modo = 1
        select
          'Codigo' = re_relacion,
          'Relacion' = convert(varchar(50), re_descripcion)
        from   cl_relacion
        where  re_relacion > @i_relacion
        --     and  re_relacion < 200      ELA ABR/2003
        order  by re_relacion
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

/*  Query  */
  /* encontrar los datos de una relacion especifica */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1369
    begin
      select
        re_relacion,
        convert(char(64), re_descripcion),
        convert(char(64), re_izquierda),
        convert(char(64), re_derecha)
      from   cl_relacion
      where  re_relacion = @i_relacion

      /* si no existen datos, error */
      if @@rowcount = 0
      begin
        /*  No existe relacion  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101087
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
  /* Query de relacion, especifica y generica, por [A]ll y [V]alue */
  if @i_operacion = 'H'
  begin
    if @t_trn = 1370
    begin
      if @i_tipo = 'A'
        if @i_modo = 0
          select
            'Cod.'=re_relacion,
            'Descripcion'=convert(char(64), re_descripcion)
          from   cl_relacion
          order  by re_relacion
      if @i_modo = 1
        select
          'Cod.'=re_relacion,
          'Descripcion'=convert(char(64), re_descripcion)
        from   cl_relacion
        where  re_relacion > @i_relacion
        order  by re_relacion
      if @i_tipo = 'V'
      begin
        select
          re_relacion,
          convert(char(64), re_derecha),
          convert(char(64), re_izquierda)
        from   cl_relacion
        where  re_relacion = @i_relacion
        if @@rowcount = 0
        begin
          /*  No existe relacion  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 101087
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

