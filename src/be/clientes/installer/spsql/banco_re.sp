/************************************************************************/
/*      Archivo:                banco_re.sp                             */
/*      Stored procedure:       sp_banco_rem                            */
/*      Base de datos:          cobis                                   */
/*      Producto:               MIS                                     */
/*      Disenado por:           Sandra Ortiz                            */
/*      Fecha de escritura:     12-May-94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes  exclusivos  para el  Ecuador  de la   */
/*      'NCR CORPORATION'.                                              */
/*      Su  uso no autorizado  queda expresamente  prohibido asi como   */
/*      cualquier   alteracion  o  agregado  hecho por  alguno de sus   */
/*      usuarios   sin el debido  consentimiento  por  escrito  de la   */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones del store procedure     */
/*      Insercion de bancos                                             */
/*      Modificacion de bancos                                          */
/*      Borrado de bancos                                               */
/*      Busqueda de bancos                                              */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      12/05/94      C.Rodriguez V.      Emision Inicial               */
/*      30/Dic/97     N.Velasco -NVR-     Adicionar Busqueda Alfabetica */
/*      May/02/2016   DFu                 Migracion CEN                 */
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
           where  name = 'sp_banco_rem')
  drop proc sp_banco_rem
go

create proc sp_banco_rem
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
  @i_operacion    char(1),
  @i_modo         tinyint = null,
  @i_tipo         char(1) = null,
  @i_banco        int = null,
  @i_descripcion  descripcion = null,
  @i_ultimo       descripcion = null,
  @i_filial       tinyint = null,
  @i_estado       estado = null,
  @i_valor        descripcion = null
)
as
  declare
    @w_return      int,
    @w_sp_name     varchar(32),
    @w_codigo      int,
    @w_banco       int,
    @w_descripcion descripcion,
    @w_estado      estado,
    @w_filial      tinyint,
    --  @v_banco        smallint,
    @v_banco       int,
    @v_descripcion descripcion,
    @v_estado      estado,
    @v_filial      tinyint

  select
    @w_sp_name = 'sp_banco_rem'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* ** Insert ** */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1206
    begin
      if exists (select
                   ba_banco
                 from   cl_banco_rem
                 where  ba_banco = @i_banco)
      begin
        /* 'Ya existe banco remesas */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101153
        return 1
      end

      if not exists (select
                       fi_filial
                     from   cl_filial
                     where  fi_filial = @i_filial)
         and @i_filial is not null
      begin
        /* 'No existe Filial'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101002
        return 1
      end

      begin tran
      /* Insertar los datos de entrada */
      insert into cl_banco_rem
                  (ba_banco,ba_descripcion,ba_estado,ba_filial)
      values      (@i_banco,@i_descripcion,'V',@i_filial)

      /* Si no se puede insertar error */
      if @@error <> 0
      begin
        /* 'Error en creacion de banco remesas '*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103074
        return 1
      end

      /* transaccion servicio - nuevo */
      insert into ts_banco_rem
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,banco,descripcion,
                   estado,filial)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_banco,@i_descripcion,
                   'V',@i_filial)

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

      /* Retornar el nuevo codigo  */
      select
        @w_banco
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
    if @t_trn = 1207
    begin
      /* Guardar los datos anteriores */
      select
        @w_descripcion = ba_descripcion,
        @w_filial = ba_filial,
        @w_estado = ba_estado
      from   cl_banco_rem
      where  ba_banco = @i_banco

      if @@rowcount = 0
      begin
        /* No existe dato */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101144
        return 1
      end

      /* Guardar en transacciones de servicio solo los datos que han
         cambiado */
      select
        @v_descripcion = @w_descripcion,
        @v_filial = @w_filial,
        @v_estado = @w_estado

      if @w_descripcion = @i_descripcion
        select
          @w_descripcion = null,
          @v_descripcion = null
      else
        select
          @w_descripcion = @i_descripcion

      if @w_filial = @i_filial
        select
          @w_filial = null,
          @v_filial = null
      else
        select
          @w_filial = @i_filial

      if @w_estado = @i_estado
        select
          @w_estado = null,
          @v_estado = null
      else
        select
          @w_estado = @i_estado

      if not exists (select
                       fi_filial
                     from   cl_filial
                     where  fi_filial = @i_filial)
         and @i_filial is not null
      begin
        /* 'No existe Filial'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101002
        return 1
      end

      begin tran

      update cl_banco_rem
      set    ba_descripcion = @i_descripcion,
             ba_filial = @i_filial,
             ba_estado = @i_estado
      where  ba_banco = @i_banco

      if @@error <> 0
      begin
        /* 'Error en actualizacion '*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105068
        return 1
      end

      /* transaccion servicios - previo */
      insert into ts_banco_rem
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,banco,descripcion,
                   estado,filial)
      values      (@s_ssn,207,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_banco,@v_descripcion,
                   @v_estado,@v_filial)

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

      insert into ts_banco_rem
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,banco,descripcion,
                   estado,filial)
      values      (@s_ssn,207,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_banco,@w_descripcion,
                   @w_estado,@w_filial)

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
    if @t_trn = 1208
    begin
      /* Conservar valores para transaccion de servicios */
      select
        @w_banco = ba_banco,
        @w_descripcion = ba_descripcion,
        @w_filial = ba_filial,
        @w_estado = ba_estado
      from   cl_banco_rem
      where  ba_banco = @i_banco

      /* si no existe registro a borrar, error */
      if @@rowcount = 0
      begin
        /* No existe banco */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101144
        return 1
      end

      /* (Verificar si se puede eliminar: si no fue referenciado
       en otra tabla (cl_referencia) , si su codigo lo permite ) */
      if exists (select
                   *
                 from   cl_referencia
                 where  ec_banco = @i_banco
                     or ta_banco = convert (varchar(10), @i_banco))
      begin
        /* Banco esta siendo referenciado desde otra tabla */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101146
        return 1
      end

      begin tran

      /* borrar banco */

      delete cl_banco_rem
      where  ba_banco = @i_banco

      /* si no se puede borrar, error */

      if @@error <> 0
      begin
        /* Error en eliminacion de banco */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107063
        return 1
      end

      /* Transaccion servicios - borrado */
      insert into ts_banco_rem
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,banco,descripcion,
                   estado,filial)
      values      (@s_ssn,208,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_banco,@w_descripcion,
                   @w_estado,@w_filial)

      /* error si no se puede insertar transaccion de servicio */
      if @@error <> 0
      begin
        /* Error en creacion de transaccion de servicio */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
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
    if @t_trn = 1209
    begin
      set rowcount 20
      if @i_modo = 0
        select
          'Banco            ' = ba_banco,
          'Entidad Financiera ' = substring(ba_descripcion,
                                            1,
                                            30),
          'Filial' = ba_filial,
          'Nombre de Filial ' = substring(fi_nombre,
                                          1,
                                          30),
          'Estado ' = ba_estado
        from   cl_banco_rem
               left outer join cl_filial
                            on ba_filial = fi_filial
        order  by ba_descripcion

      if @i_modo = 1
        select
          'Banco            ' = ba_banco,
          'Entidad Financiera ' = substring(ba_descripcion,
                                            1,
                                            30),
          'Filial' = ba_filial,
          'Nombre de Filial ' = substring(fi_nombre,
                                          1,
                                          30),
          'Estado ' = ba_estado
        from   cl_banco_rem
               left outer join cl_filial
                            on ba_filial = fi_filial
        where  ba_descripcion > @i_ultimo
        order  by ba_descripcion

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

  /* ** Query especifico de un banco ** */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1210
    begin
      select
        ba_banco,
        substring(ba_descripcion,
                  1,
                  30),
        ba_filial,
        substring(fi_nombre,
                  1,
                  30),
        ba_estado
      from   cl_banco_rem
             left outer join cl_filial
                          on ba_filial = fi_filial
      where  ba_banco = @i_banco

      if @@rowcount = 0
      begin
        /* No existe dato */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101144
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
    if @t_trn = 1211
    begin
      if @i_tipo = 'A'
      begin
        set rowcount 20
        if @i_modo = 0
          select
            'Cod.'=ba_banco,
            'Nombre'=convert(char(30), ba_descripcion)
          from   cl_banco_rem
          where  ba_estado = 'V'
          order  by ba_descripcion
        else if @i_modo = 1
          select
            'Cod.'=ba_banco,
            'Nombre'=convert(char(30), ba_descripcion)
          from   cl_banco_rem
          where  ba_descripcion > @i_ultimo
             and ba_estado      = 'V'
          order  by ba_descripcion
        set rowcount 0
        return 0
      end

      if @i_tipo = 'B' --NVR 
      begin
        set rowcount 20
        if @i_modo = 0
          select
            'Cod.'=ba_banco,
            'Nombre'=convert(char(30), ba_descripcion)
          from   cl_banco_rem
          where  ba_estado = 'V'
             and ba_descripcion like @i_valor
          order  by ba_descripcion
        else if @i_modo = 1
          select
            'Cod.'=ba_banco,
            'Nombre'=convert(char(30), ba_descripcion)
          from   cl_banco_rem
          where  ba_descripcion > @i_ultimo
             and ba_estado      = 'V'
             and ba_descripcion like @i_valor
          order  by ba_descripcion
        set rowcount 0
        return 0
      end
      if @i_tipo = 'V'
      begin
        select
          convert(char(30), ba_descripcion)
        from   cl_banco_rem
        where  ba_banco  = @i_banco
           and ba_estado = 'V'

        if @@rowcount = 0
        begin
          /* no existe dato solicitado */
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          return 1
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

