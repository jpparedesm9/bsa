/************************************************************************/
/*      Archivo:                atinstan.sp                             */
/*      Stored procedure:       sp_at_instancia                         */
/*      Base de datos:          cobis                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Sandra Ortiz/Mauricio Bayas             */
/*      Fecha de escritura:     07-May-94                               */
/************************************************************************/
/*                             IMPORTANTE                               */
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
/*         Insercion de         cl_at_instancia                         */
/*         Modificacion de      cl_at_instancia                         */
/*         Borrado de           cl_at_instancia                         */
/*         Busqueda de          cl_at_instancia                         */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*    FECHA           AUTOR            RAZON                            */
/*    07-May-94       R. Minga V.      Emision Inicial                  */
/*    28/Oct/98       Ferrinson Franco CORFINSURA. Cambio texto Valor   */
/*                                     por Descripcion Atributo         */
/*    01/Mar/2001     E. Laguna        Validacion suma de porcentajes   */
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
           where  name = 'sp_at_instancia')
  drop proc sp_at_instancia
go

create proc sp_at_instancia
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
  @i_ente_i       int = null,
  @i_ente_d       int = null,
  @i_atributo     tinyint = null,
  @i_valor        varchar (255) = null
)
as
  declare
    @w_return       int,
    @w_sp_name      varchar (32),
    @w_seqnos       int,
    @v_valor        varchar (255),
    @w_valor        varchar (255),
    @w_valorp       int,
    @w_descripcion  descripcion,
    @w_tdato        varchar(30),
    @w_relacion_per int,
    @w_relacion_jur int

  select
    @w_sp_name = 'sp_at_instancia'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Parametros Generales */

  select
    @w_relacion_per = pa_smallint
  from   cl_parametro
  where  pa_nemonico = 'RL1'
     and pa_producto = 'MIS'
  if @@rowcount = 0
  begin
    /* No existe parametro */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101077
    return 1
  end

  select
    @w_relacion_jur = pa_smallint
  from   cl_parametro
  where  pa_nemonico = 'RL2'
     and pa_producto = 'MIS'
  if @@rowcount = 0
  begin
    /* No existe parametro */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101077
    return 1
  end
  /* ** Insert ** */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1161
    begin
      /* Verificar que exista el atributo para la relacion dada */
      if not exists (select
                       *
                     from   cl_at_relacion
                     where  ar_relacion = @i_relacion
                        and ar_atributo = @i_atributo)
      begin
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101120
        return 1
      end

      /* Verificar que existan los entes en la relacion dada */
      if not exists (select
                       *
                     from   cl_instancia
                     where  in_relacion = @i_relacion
                        and in_ente_i   = @i_ente_i
                        and in_ente_d   = @i_ente_d)
      begin
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101098
        return 1
      end

      /* comprobar que no existan datos duplicados */
      if exists (select
                   *
                 from   cl_at_instancia
                 where  ai_relacion = @i_relacion
                    and ai_ente_i   = @i_ente_i
                    and ai_ente_d   = @i_ente_d
                    and ai_atributo = @i_atributo)
      begin
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101122
        return 1
      end

      if (@i_relacion = @w_relacion_per
           or @i_relacion = @w_relacion_jur)
         and @i_atributo = 2
      begin
        select
          @w_valorp = sum(convert(int, ai_valor))
        from   cl_at_instancia
        where  ai_relacion = @i_relacion
           and ai_ente_i   = @i_ente_i
           and ai_atributo = @i_atributo

        if datalength(@i_valor) > 3
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107102
          /*  'No corresponde codigo de transaccion' */
          return 1
        end
        else
        begin
          if convert(int, @i_valor) > 100
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 107102
            /*  'No corresponde codigo de transaccion' */
            return 1
          end
        end
        if (@w_valorp + (convert(int, @i_valor))) > 100
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107102
          /*  'No corresponde codigo de transaccion' */
          return 1
        end
      end

      begin tran

      /* Insertar los datos de entrada */
      insert into cl_at_instancia
                  (ai_relacion,ai_ente_i,ai_ente_d,ai_atributo,ai_valor)
      values      ( @i_relacion,@i_ente_i,@i_ente_d,@i_atributo,@i_valor)

      /* Si no se puede insertar error */
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103064
        return 1
      end

      /* transaccion servicio */
      insert into ts_at_instancia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,relacion,ente_i,
                   ente_d,atributo,valor)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_relacion,@i_ente_i,
                   @i_ente_d,@i_atributo,@i_valor)

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

      /* Insertar los datos de entrada (Resiproco) */
      insert into cl_at_instancia
                  (ai_relacion,ai_ente_i,ai_ente_d,ai_atributo,ai_valor)
      values      ( @i_relacion,@i_ente_d,@i_ente_i,@i_atributo,@i_valor)

      /* Si no se puede insertar error */
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103064
        return 1
      end

      /* transaccion servicio (Reciproco) */
      select
        @s_ssn = @s_ssn + 1
      insert into ts_at_instancia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,relacion,ente_i,
                   ente_d,atributo,valor)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_relacion,@i_ente_d,
                   @i_ente_i,@i_atributo,@i_valor)

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

  /* ** Update ** */
  if @i_operacion = 'U'
  begin
    if @t_trn = 1163
    begin
      /* Verificar que exista el dato a modificar y que no este duplicado */
      select
        @w_valor = ai_valor
      from   cl_at_instancia
      where  ai_relacion = @i_relacion
         and ai_ente_i   = @i_ente_i
         and ai_ente_d   = @i_ente_d
         and ai_atributo = @i_atributo

      if @@rowcount <> 1
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107102
        return 1
      end

    /* Guargar los datos antiguos */
      /*  select @v_valor = @w_valor
        if @w_valor = @i_valor
           select @w_valor = null, @v_valor = null
        else
           select @w_valor= @i_valor
      */
      if (@i_relacion = @w_relacion_per
           or @i_relacion = @w_relacion_jur)
         and @i_atributo = 2
      begin
        select
          @w_valorp = sum(convert(int, ai_valor))
        from   cl_at_instancia
        where  ai_relacion = @i_relacion
           and ai_ente_i   = @i_ente_i
           and ai_atributo = @i_atributo

        if datalength(@i_valor) > 3
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107102
          /*  'No corresponde codigo de transaccion' */
          return 1
        end
        else
        begin
          if convert(int, @i_valor) > 100
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 107102
            /*  'No corresponde codigo de transaccion' */
            return 1
          end
        end
        if (@w_valorp + (convert(int, @i_valor))) - (convert(int, @v_valor)) >
           100
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107102
          /*  'Sumatoria excede 100%' */
          return 1
        end
      end

      begin tran

      /* Modificar datos antiguos */
      update cl_at_instancia
      set    ai_valor = @i_valor
      where  ai_relacion = @i_relacion
         and ai_ente_i   = @i_ente_i
         and ai_ente_d   = @i_ente_d
         and ai_atributo = @i_atributo

      /* Error en actualizacion de atributos */
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 105057
        return 1
      end

      /* Modificar datos antiguos (Reciproco) */
      update cl_at_instancia
      set    ai_valor = @i_valor
      where  ai_relacion = @i_relacion
         and ai_ente_i   = @i_ente_d
         and ai_ente_d   = @i_ente_i
         and ai_atributo = @i_atributo

      /* Error en actualizacion de atributos */
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 105057
        return 1
      end

      /* transaccion servicios - pais */
      insert into ts_at_instancia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,relacion,ente_i,
                   ente_d,atributo,valor)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_relacion,@i_ente_i,
                   @i_ente_d,@i_atributo,@w_valor)

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

      insert into ts_at_instancia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,relacion,ente_i,
                   ente_d,atributo,valor)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_relacion,@i_ente_i,
                   @i_ente_d,@i_atributo,@i_valor)
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

  /* ** Delete ** */
  if @i_operacion = 'D'
  begin
    if @t_trn = 1162
    begin
      /* Verificar que exista el dato a borrar */
      select
        @w_valor = ai_valor
      from   cl_at_instancia
      where  ai_relacion = @i_relacion
         and ai_ente_i   = @i_ente_i
         and ai_ente_d   = @i_ente_d
         and ai_atributo = @i_atributo

      if @@rowcount <> 1
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101120
        return 1
      end

      begin tran
      /* borrar el registro correspondiente */
      delete cl_at_instancia
      where  ai_relacion = @i_relacion
         and ai_ente_i   = @i_ente_i
         and ai_ente_d   = @i_ente_d
         and ai_atributo = @i_atributo

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

      /* borrar el registro correspondiente (Reciproco) */
      delete cl_at_instancia
      where  ai_relacion = @i_relacion
         and ai_ente_i   = @i_ente_d
         and ai_ente_d   = @i_ente_i
         and ai_atributo = @i_atributo

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

      /* transaccion servicio */
      insert into ts_at_instancia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,relacion,ente_i,
                   ente_d,atributo,valor)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_relacion,@i_ente_i,
                   @i_ente_d,@i_atributo,@w_valor)

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
    if @t_trn = 1197
    begin
      select
        'ID' = ai_atributo,
        'Atributo' = convert(char(30), ar_descripcion),
        /*'Valor' = convert(char(30),ai_valor),*/
        'Descripcion Atributo' = convert(char(30), ai_valor),
        'Tipo de Dato' = ar_tdato
      from   cl_at_instancia,
             cl_at_relacion
      where  ai_relacion = ar_relacion
         and ai_atributo = ar_atributo
         and ai_relacion = @i_relacion
         and ar_relacion = @i_relacion --JAN ENE/01 OPT
         and ai_ente_i   = @i_ente_i
         and ai_ente_d   = @i_ente_d
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

  /* ** Query especifico ** */

  if @i_operacion = 'Q'
  begin
    if @t_trn = 1198
    begin
      select
        @w_descripcion = ar_descripcion,
        @w_valor = ltrim(rtrim(ai_valor)),
        @w_tdato = ar_tdato
      from   cl_at_instancia,
             cl_at_relacion
      where  ai_relacion = ar_relacion
         and ai_atributo = ar_atributo
         and ai_relacion = @i_relacion
         and ar_relacion = @i_relacion --JAN ENE/01
         and ai_ente_i   = @i_ente_i
         and ai_ente_d   = @i_ente_d
         and ai_atributo = @i_atributo

      if @@rowcount <> 1
      begin
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101120
        return 1
      end

      /* if convert(char(8),@w_tdato) = 'DATETIME'
         select @w_valor = convert(char(10),convert(datetime,@w_valor),103) */

      select
        @w_descripcion,
        @w_valor,
        @w_tdato

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

