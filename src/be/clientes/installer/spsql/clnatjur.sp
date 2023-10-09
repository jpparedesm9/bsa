/************************************************************************/
/*   Archivo:       clnatjur.sp                                         */
/*   Stored procedure:   sp_natjur                                      */
/*   Base de datos:      cobis                                          */
/*   Producto:           Clientes                                       */
/*   Disenado por:            Jenniffer Anaguano                        */
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
/*   tros en la tabla cl_nat_jur.  Esta tabla es utilizada para         */
/*   crear la naturaleza juridica de los entes tipo compania.           */
/************************************************************************/
/*                  MODIFICACIONES                                      */
/*   FECHA          AUTOR          RAZON                                */
/*   11-Dic-2000    J Anaguano     Emision inicial                      */
/*      10-Abr-2003     E Laguna        Ajustes actualizacion estado    */
/*      09-Ago-2004     E. Laguna  Tunning                              */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/

use cobis
go

if exists (select
             *
           from   sysobjects
           where  name like 'sp_natjur')
  drop proc sp_natjur
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_natjur
(
  @s_ssn          int,
  @s_sesn         int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime,
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
  @i_codigo       catalogo = null,
  @i_descripcion  descripcion = null,
  @i_tnatjur      char (1) = null,
  @i_estado       estado = null
)
as
  declare
    @w_sp_name     char (10),
    @w_return      int,
    @w_siguiente   int,
    @w_bandera     varchar(1),
    @w_codigo      catalogo,
    @w_descripcion descripcion,
    @w_estado      estado,
    @w_tnatjur     char (1),
    @v_codigo      catalogo,
    @v_descripcion descripcion,
    @v_tnatjur     char (1),
    @v_estado      estado

  /*  Inicializacion de Variables  */
  select
    @w_sp_name = 'sp_natjur'

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
    if @t_trn = 1386
    begin
      /* verificar que es validad la categoria */
      if @i_tnatjur not in ('P', 'O')
      begin
        /*  Tipo de Naturaleza Jurídica  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101166
        return 1
      end

      if exists (select
                   nj_codigo
                 from   cl_nat_jur
                 where  nj_codigo = @i_codigo)
      begin
        /*  Ya existe codigo  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101186
        return 1
      end

      begin tran

      /* insertar los datos de entrada */
      insert into cl_nat_jur
                  (nj_codigo,nj_descripcion,nj_tipo,nj_estado)
      values      (@i_codigo,@i_descripcion,@i_tnatjur,'V')
      if @@error <> 0
      begin
        /*  Error en creacion de naturaleza juridica  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103077
        return 1
      end

      /*  Transaccion de Servicio  */
      insert into ts_natjur
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,codigo,descripcion,
                   tnatjur,estado)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_codigo,@i_descripcion,
                   @i_tnatjur,'V')
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
      select
        @w_bandera = 'S'
      commit tran

      if @w_bandera = 'S'
      begin
        /* Actualizacion de la los datos en el catalogo */
        exec @w_return = sp_catalogo
          @s_ssn         = @s_ssn,
          @s_user        = @s_user,
          @s_sesn        = @s_sesn,
          @s_term        = @s_term,
          @s_date        = @s_date,
          @s_srv         = @s_srv,
          @s_lsrv        = @s_lsrv,
          @s_rol         = @s_rol,
          @s_ofi         = @s_ofi,
          @s_org_err     = @s_org_err,
          @s_error       = @s_error,
          @s_sev         = @s_sev,
          @s_msg         = @s_msg,
          @s_org         = @s_org,
          @t_debug       = @t_debug,
          @t_file        = @t_file,
          @t_from        = @w_sp_name,
          @t_trn         = 584,
          @i_operacion   = 'I',
          @i_tabla       = 'cl_nat_jur',
          @i_codigo      = @i_codigo,
          @i_descripcion = @i_descripcion,
          @i_estado      = 'V'
        if @w_return <> 0
          return @w_return
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

  /*  Update  */
  if @i_operacion = 'U'
  begin
    if @t_trn = 1387
    begin
      /* verificar que es validad la categoria */
      if @i_tnatjur not in ('P', 'O')
      begin
        /*  Tipo de Naturaleza Jurídica incorrecta  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101166
        return 1
      end

      select
        @w_descripcion = nj_descripcion,
        @w_tnatjur = nj_tipo,
        @w_estado = nj_estado
      from   cl_nat_jur
      where  nj_codigo = @i_codigo

      if @@rowcount <> 1
      begin
        /*  Codigo de Naturaleza Jurídica no existe  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101161
        return 1
      end
      select
        @v_descripcion = @w_descripcion,
        @v_tnatjur = @w_tnatjur,
        @v_estado = @v_estado

      if @w_descripcion = @i_descripcion
        select
          @w_descripcion = null,
          @v_descripcion = null
      else
        select
          @w_descripcion = @i_descripcion

      if @w_tnatjur = @i_tnatjur
        select
          @w_tnatjur = null,
          @v_tnatjur = null
      else
        select
          @w_tnatjur = @i_tnatjur

      if @w_estado = @i_estado
        select
          @w_estado = null,
          @v_estado = null
      else
      begin
        if @i_estado = 'C'
        begin
          if not exists (select
                           *
                         from   cl_nat_jur
                         where  nj_codigo = @i_codigo)
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 105000
            /* Existe referencia en plan */
            return 1
          end
        end
        select
          @w_estado = @i_estado
      end

      begin tran
      update cl_nat_jur
      set    nj_descripcion = @i_descripcion,
             nj_tipo = @i_tnatjur,
             nj_estado = @i_estado
      where  nj_codigo = @i_codigo

      if @@rowcount <> 1
      begin
        /*  Error en actualizacion de naturaleza juridica  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  =105000
        return 1
      end

      /*  Transaccion de Servicio - Previo */
      insert into ts_natjur
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,codigo,descripcion,
                   tnatjur,estado)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_codigo,@v_descripcion,
                   @v_tnatjur,@v_estado)
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
      insert into ts_natjur
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,codigo,descripcion,
                   tnatjur,estado)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_codigo,@w_descripcion,
                   @w_tnatjur,@w_estado)
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
      select
        @w_bandera = 'S'
      commit tran

      if @w_bandera = 'S'
      begin
        exec @w_return = sp_catalogo
          @s_ssn         = @s_ssn,
          @s_user        = @s_user,
          @s_sesn        = @s_sesn,
          @s_term        = @s_term,
          @s_date        = @s_date,
          @s_srv         = @s_srv,
          @s_lsrv        = @s_lsrv,
          @s_rol         = @s_rol,
          @s_ofi         = @s_ofi,
          @s_org_err     = @s_org_err,
          @s_error       = @s_error,
          @s_sev         = @s_sev,
          @s_msg         = @s_msg,
          @s_org         = @s_org,
          @t_debug       = @t_debug,
          @t_file        = @t_file,
          @t_from        = @w_sp_name,
          @t_trn         = 585,
          @i_operacion   = 'U',
          @i_tabla       = 'cl_nat_jur',
          @i_codigo      = @i_codigo,
          @i_descripcion = @i_descripcion,
          @i_estado      = @i_estado

        if @w_return <> 0
          return @w_return

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

  /*  Delete  */
  if @i_operacion = 'D'
  begin
    if @t_trn = 1388
    begin
      select
        @w_tnatjur = nj_tipo,
        @w_descripcion = nj_descripcion,
        @w_estado = nj_estado
      from   cl_nat_jur
      where  nj_codigo = @i_codigo
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
                 from   cl_nat_jur
                 where  nj_codigo = @i_codigo)
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
      delete cl_nat_jur
      where  nj_codigo = @i_codigo
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
      insert into ts_natjur
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,codigo,descripcion,
                   tnatjur,estado)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_codigo,@w_descripcion,
                   @w_tnatjur,@w_estado)
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
    if @t_trn = 1389
    begin
      set rowcount 20
      if @i_modo = 0
        select
          'Codigo' = nj_codigo,
          'Descripcion' = convert(char(30), nj_descripcion),
          'Tipo' = nj_tipo,
          'Estado' = nj_estado
        from   cl_nat_jur
        where  nj_codigo > '  '
           and nj_estado > ''
      else if @i_modo = 1
        select
          'Codigo' = nj_codigo,
          'Descripcion' = convert(char(30), nj_descripcion),
          'Tipo' = nj_tipo,
          'Estado' = nj_estado
        from   cl_nat_jur
        where  nj_codigo > @i_codigo
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
    if @t_trn = 1390
    begin
      if @i_tipo = 'A'
      begin
        set rowcount 20
        if @i_modo = 0
          select
            'Codigo ' = nj_codigo,
            'Descripcion ' = convert(char(30), nj_descripcion),
            'Tipo ' = nj_tipo
          from   cl_nat_jur
          where  nj_codigo > ''
             and nj_estado = 'V'
        --    and  nj_tipo = @i_cotnatjur

        else if @i_modo = 1
          select
            'Codigo ' = nj_codigo,
            'Descripcion ' = convert(char(30), nj_descripcion),
            'Tipo ' = nj_tipo
          from   cl_nat_jur
          where  nj_codigo > @i_codigo
             and nj_estado = 'V'
        --   and  nj_tipo = @i_tnatjur
        set rowcount 0
        return 0
      end

      if @i_tipo = 'V'
      begin
        select
          convert(char(30), nj_descripcion),
          nj_tipo
        from   cl_nat_jur
        where  nj_codigo = @i_codigo
           and nj_estado = 'V'
        if @@rowcount = 0
        begin
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

