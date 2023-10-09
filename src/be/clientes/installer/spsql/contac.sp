/************************************************************************/
/*   Archivo:       contac.sp                                           */
/*   Stored procedure:   sp_contacto                                    */
/*   Base de datos:      cobis                                          */
/*   Producto: Clientes                                                 */
/*   Disenado por:  Elio Favio Gomez Munoz                              */
/*   Fecha de escritura: 06-Jul-1996                                    */
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
/*   Este programa procesa las transacciones del stored procedure       */
/*   Insercion de contacto                                              */
/*      Query general y especifico de contactos                         */
/************************************************************************/
/*                  MODIFICACIONES                                      */
/*   FECHA          AUTOR          RAZON                                */
/*   06/Jul/96 E. Gomez M.    Emision Inicial                           */
/*      27/May/97       N.Velasco       Banco Estado                    */
/*                                      Incluir Verificado,fecha verifi.*/
/*                                      y funcionario que verifica      */
/*      24/Sep/98       Ferrinson Fco.  Inclucion campo e-mail. Corfins.*/
/*      15/May/03       Etna Laguna     Se aumenta fec crea y modifica  */
/*      29/MAY/03   Diego Duran    Se cambia Formato de fecha para      */
/*                                      su visualizacion en el FronTend */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
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
           where  name = 'sp_contacto')
  drop proc sp_contacto
go
create proc sp_contacto
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_ente         int = null,
  @i_nombre       varchar(40) = null,
  @i_cargo        varchar(32) = null,
  @i_direccion    direccion = null,
  @i_telefono     char(12) = null,
  @i_contacto     tinyint = null,
  @i_verificado   char(1) = 'N',
  @i_fecha_ver    datetime = null,
  @i_email        descripcion = null,
  @i_fecha_crea   datetime = null,
  @i_fecha_mod    datetime = null,
  @i_resultado    catalogo = null
)
as
  declare
    @w_sp_name     varchar(32),
    @w_codigo      int,
    @w_return      int,
    @o_siguiente   tinyint,
    @w_contacto    tinyint,
    @w_nombre      varchar(40),
    @w_cargo       varchar(32),
    @w_direccion   direccion,
    @w_telefono    char(12),
    @w_verificado  char(1),
    @w_fecha_ver   datetime,
    @w_funcionario login,
    @w_direccioi   direccion,
    @w_registrado  datetime,
    @w_modificado  datetime,
    @w_resultado   catalogo,
    @v_nombre      varchar(40),
    @v_cargo       varchar(32),
    @v_direccion   direccion,
    @v_telefono    char(12),
    @o_ente        int,
    @o_contacto    tinyint,
    @o_nombre      varchar(40),
    @o_cargo       varchar(32),
    @o_direccion   direccion,
    @o_telefono    char(12),
    @o_verificado  char(1),
    @o_fecha_ver   datetime,
    @o_fecha_crea  datetime,
    @o_fecha_mod   datetime,
    @w_email       descripcion,/* Ferrinson F. Corfinsura */
    @o_email       descripcion,/* Ferrinson F. Corfinsura */
    @v_email       descripcion,/* Ferrinson F. Corfinsura */
    @o_funcionario login

  select
    @w_sp_name = 'sp_contacto'

/**************/
/* VERSION    */
  /**************/
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
      t_file = @t_file,
      t_from = @t_from,
      i_operacion = @i_operacion,
      i_ente = @i_ente,
      i_nombre = @i_nombre,
      i_cargo = @i_cargo,
      i_direccion = @i_direccion,
      i_telefono = @i_telefono,
      i_contacto = @i_contacto,
      i_email = @i_email,
      i_verificado = @i_verificado
    exec cobis..sp_end_debug
  end

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 1289
    begin
      /* Verificar que exista el ente */
      select
        @w_codigo = null
      from   cl_ente
      where  en_ente = @i_ente

      /* si no existe, error */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101043
        /* 'No existe persona'*/
        return 1
      end

      begin tran
      /* seleccionar el nuevo secuencial para el contacto */
      select
        @o_siguiente = isnull(max(co_contacto), 0) + 1
      from   cl_contacto
      where  co_ente = @i_ente

      /* Insercion cl_contacto */
      insert into cl_contacto
                  (co_ente,co_contacto,co_nombre,co_cargo,co_telefono,
                   co_direccion,co_email,co_verificado,co_funcionario,
                   co_registrado)
      values      (@i_ente,@o_siguiente,@i_nombre,@i_cargo,@i_telefono,
                   @i_direccion,@i_email,'N',@s_user,getdate())

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103081
        /* 'Error en creacion de contacto */
        return 1
      end

      commit tran

      /* retornar el nuevo secuencial para el contacto */
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

  /** Update **/
  if @i_operacion = 'U'
  begin
    if @t_trn = 1290
        or @t_trn = 1354
    begin
      /*Datos para transaccion de servicio*/
      select
        @w_nombre = co_nombre,
        @w_cargo = co_cargo,
        @w_telefono = co_telefono,
        @w_direccion = co_direccion,
        @w_email = co_email,
        @w_verificado = co_verificado,
        @w_fecha_ver = co_fecha_ver,
        @w_funcionario = co_funcionario,
        @w_direccioi = co_direccioi,
        @w_registrado = co_registrado,
        @w_modificado = co_modificado,
        @w_resultado = co_obs_verificado
      from   cl_contacto
      where  co_ente     = @i_ente
         and co_contacto = @i_contacto
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 1
      end

      begin tran
    /********************************/
      /* modificar, los datos */
      update cl_contacto
      set    co_nombre = @i_nombre,
             co_direccion = @i_direccion,
             co_telefono = @i_telefono,
             co_cargo = @i_cargo,
             co_verificado = @i_verificado,
             co_fecha_ver = getdate(),
             co_funcionario = @s_user,
             co_email = @i_email,
             co_modificado = getdate(),
             co_obs_verificado = @i_resultado
      where  co_ente     = @i_ente
         and co_contacto = @i_contacto

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105072
        /*'Error en actualizacion de contacto'*/
        return 1
      end

      /*  Transaccion de Servicio Registro Posterior */
      insert into ts_contacto
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,contacto,
                   nombre,cargo,telefono,direccioi,verificado,
                   fecha_ver,funcionario,direccion,email,registrado,
                   modificado)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_contacto,
                   @w_nombre,@w_cargo,@w_telefono,@w_direccioi,@w_verificado,
                   @w_fecha_ver,@w_funcionario,@w_direccion,@w_email,
                   @w_registrado
                   ,
                   @w_modificado)

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

      /*  Transaccion de Servicio Registro Actual */
      insert into ts_contacto
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,contacto,
                   nombre,cargo,telefono,direccioi,verificado,
                   fecha_ver,funcionario,direccion,email,registrado,
                   modificado)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_contacto,
                   @i_nombre,@i_cargo,@i_telefono,@w_direccioi,@i_verificado,
                   getdate(),@s_user,@i_direccion,@i_email,@w_registrado,
                   getdate())

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

      /*para verificacion de datos */

      if @i_verificado = 'S'
      begin
        update cl_contacto
        set    co_funcionario = @s_user,
               co_verificado = @i_verificado,
               co_fecha_ver = getdate()
        where  co_ente     = @i_ente
           and co_contacto = @i_contacto
        /* si no se puede modificar, error */
        if @@error <> 0
        begin
          /* 'Error en actualizacion de casilla'*/
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105072
          return 1
        end
      end
      /* termina verificacion*/

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
    if @t_trn = 1291
    begin
      select
        @w_nombre = co_nombre,
        @w_contacto = co_contacto,
        @w_direccion = co_direccion,
        @w_telefono = co_telefono,
        @w_cargo = co_cargo,
        @w_email = co_email
      from   cl_contacto
      where  co_ente     = @i_ente
         and co_contacto = @i_contacto

      /* si no existe contacto */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No dato solicitado' */
        return 1
      end

      begin tran

    /* borrar el contacto */ /*hom*/
      delete from cl_contacto
      where  co_ente     = @i_ente
         and co_contacto = @i_contacto

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107068
        /* 'Error en eliminacion de contacto'*/
        return 1
      end

      /*******************************
         /* modificar en uno la secuencia de contacto */
         update cl_contacto
             set co_contacto = co_contacto - 1
           where co_ente = @i_ente
      
          /* si no se puede modificar, error */
          if @@error <> 0
          begin
           exec sp_cerror
                @t_debug  = @t_debug,
                @t_file        = @t_file,
                @t_from        = @w_sp_name,
                @i_num         = 107048
                 /*'Error en eliminacion de contactos personal'*/
           return 1
          end
      ***********************/
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

/** Search **/
  /* referencias personales de una persona no se controla de 20 en 20
     porque no se espera mas de 20 referencias personales */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1292
    begin
      select
        'NUMERO ' = co_contacto,/*hom*/
        'NOMBRE ' = co_nombre,
        'CARGO ' = co_cargo,
        'DIRECCION' = substring(co_direccion,
                                1,
                                32),
        'TELEFONO' = co_telefono,
        'VERIFICADO' = co_verificado,
        'FECHA VERIF.' = convert(char(10), co_fecha_ver, 101),
        'E-MAIL' = co_email,
        'FECHA CREA' = convert(char(10), co_registrado, 103),
        'FECHA MOD.' = convert(char(10), co_modificado, 103),
        'OBS. VERIFICADO' = co_obs_verificado
      from   cl_contacto
      where  co_ente = @i_ente
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

/** Query **/
  /* Datos especificos de una contacto */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1293
    begin
      select
        @o_ente = co_ente,
        @o_contacto = co_contacto,
        @o_nombre = rtrim(co_nombre),
        @o_cargo = co_cargo,
        @o_direccion = co_direccion,
        @o_telefono = co_telefono,
        @o_verificado = co_verificado,
        @o_fecha_ver = co_fecha_ver,
        @o_funcionario = co_funcionario,
        @o_email = co_email,
        @o_fecha_crea = co_registrado,
        @o_fecha_mod = co_modificado
      from   cl_contacto
      where  co_ente     = @i_ente
         and co_contacto = @i_contacto

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 1
      end

      select
        @o_contacto,
        @o_nombre,
        @o_cargo,
        @o_direccion,
        @o_telefono,
        @o_verificado,
        convert (char(10), @o_fecha_ver, 101),
        @o_funcionario,
        @o_email,
        convert (char(10), @o_fecha_crea, 103),
        convert (char(10), @o_fecha_mod, 103)
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

