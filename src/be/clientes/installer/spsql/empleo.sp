/************************************************************************/
/*  Archivo           :  empleo.sp                                      */
/*  Stored procedure  :  sp_empleo                                      */
/*  Base de datos     :  cobis                                          */
/*  Producto          :  Clientes                                       */
/*  Disenado por      :  Mauricio Bayas/Sandra Ortiz                    */
/*  Fecha de escritura:  06-Nov-1992                                    */
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
/*      Insercion, Borrado, Modificacion de empleo                      */
/*  Query de empleo generico y especifico                               */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR           RAZON                                   */
/*  06/Nov/92   M. Davila       Emision Inicial                         */
/*  05/Abr/2010 Raul Altamirano Control de vigencia de datos del Ente   */
/*  04/May/2016 T. Baidal       Migracion a CEN                         */
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
           where  name = 'sp_empleo')
           drop proc sp_empleo
go

create proc sp_empleo
(
  @s_ssn           int = null,
  @s_user          login = null,
  @s_term          varchar(30) = null,
  @s_date          datetime = null,
  @s_srv           varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @s_ofi           smallint = null,
  @s_rol           smallint = null,
  @s_org_err       char(1) = null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           descripcion = null,
  @s_org           char(1) = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(10) = null,
  @t_from          varchar(32) = null,
  @t_trn           smallint = null,
  @t_show_version  bit = 0,
  @i_operacion     char(1),
  @i_ente          int = null,
  @i_trabajo       tinyint = null,
  @i_empresa       descripcion = null,
  @i_cargo         descripcion = null,
  @i_moneda        tinyint = null,
  @i_sueldo        money = null,
  @i_fecha_ingreso datetime = null,
  @i_fecha_salida  datetime = null,
  @i_fecha_verifi  datetime = null,
  @i_verificado    char(1) = null,
  @i_tipo          catalogo = null,
  @i_tipoempleo    catalogo = null,
  @i_formato_fecha int = null,
  @i_recpublicos   char(1) = null,
  @i_resultado     catalogo = null
)
as
  declare
    @w_sp_name            varchar(32),
    @w_return             int,
    @w_codigo             int,
    @o_siguiente          int,
    @w_empresa            descripcion,
    @w_cargo              descripcion,
    @w_moneda             tinyint,
    @w_sueldo             money,
    @w_verificado         char(1),
    @w_vigencia           char(1),
    @w_fecha_ingreso      datetime,
    @w_fecha_nac          datetime,
    @w_fecha_salida       datetime,
    @w_fecha_registro     datetime,
    @w_fecha_modificacion datetime,
    @w_fecha_verificacion datetime,
    @w_tipo               catalogo,
    @w_tipoempleo         catalogo,
    @w_resultado          catalogo,
    @w_today              datetime,
    @v_empresa            descripcion,
    @v_cargo              descripcion,
    @v_moneda             tinyint,
    @v_sueldo             money,
    @v_verificado         char(1),
    @v_vigencia           char(1),
    @v_fecha_ingreso      datetime,
    @v_fecha_salida       datetime,
    @v_fecha_registro     datetime,
    @v_fecha_modificacion datetime,
    @v_fecha_verificacion datetime,
    @v_tipo               catalogo,
    @v_tipoempleo         catalogo,
    @v_resultado          catalogo,
    @o_ente               int,
    @o_trabajo            tinyint,
    @o_ennombre           descripcion,
    @o_cedula             numero,
    @o_empresa            descripcion,
    @o_cargo              descripcion,
    @o_moneda             tinyint,
    @o_mon_desc           descripcion,
    @o_sueldo             money,
    @o_verificado         char(1),
    @o_vigencia           char(1),
    @o_fecha_ingreso      datetime,
    @o_fecha_salida       datetime,
    @o_fecha_registro     datetime,
    @o_fecha_modificacion datetime,
    @o_fecha_verificacion datetime,
    @o_tipo               catalogo,
    @o_tipoempleo         catalogo,
    @o_tinombre           descripcion,
    @o_no_empresa         descripcion,
    @o_funcionario        login,
    @o_recpublicos        char(1),
    @w_bloqueado          char(1),
    @w_num_empleos        tinyint,
    @o_parOC              varchar(10),
    @o_ocupa              varchar(10),
    @o_traba              tinyint

  select
    @w_sp_name = 'sp_empleo'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = getdate()

  if @i_operacion in('I', 'U')
  begin
    select
      @w_fecha_nac = p_fecha_nac
    from   cobis..cl_ente
    where  en_ente = @i_ente

    /* si no existe el ente, error */
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
    if @w_fecha_nac > @i_fecha_ingreso
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107085
      /* 'Fecha nacimiento menor a fecha ingreso'*/
      return 1
    end
  end

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 181
    begin
      /* Verificar que exista el ente */
      select
        @w_codigo = null
      from   cl_persona
      where  persona = @i_ente

      /* si no existe el ente, error */
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

      /*Verificar que exista la compania
      select @w_codigo = null
        from cl_compania
       where nombre = @i_empresa
      
      /* si no existe la compania, error */
      if @@rowcount = 0
      begin
         exec sp_cerror
            @t_debug  = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 151030
            /*'No existe compania'*/
         return 1
      end*/

      if @i_tipo is not null
      begin
        /* Verificar que exista el rol de empresa */
        exec @w_return = cobis..sp_catalogo
          @t_debug    = @t_debug,
          @t_file     = @t_file,
          @t_from     = @w_sp_name,
          @i_tabla    = 'cl_rol_empresa',
          @i_operacion= 'E',
          @i_codigo   = @i_tipo

        /* si no existe el rol de empresa, error */
        if @w_return <> 0
        begin
          /*'No existe rol de empresa'*/
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101017
          return 1
        end
      end

      /* Valida la verificacion */

      if @i_verificado <> 'S'
         and @i_verificado <> 'N'
      begin
        /* 'Parametro no valido'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101114
        return 1
      end

      /* Se verifica que exista la moneda indicada  */
      if not exists (select
                       *
                     from   cl_moneda
                     where  mo_moneda = @i_moneda
                        and mo_estado = 'V')
         and @i_sueldo is not null
      begin
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101045 /* No existe la moneda indicada */
        return 1
      end

      /* si las fechas no son correctas*/
      if @i_fecha_ingreso > @i_fecha_salida
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101140
        /* 'Fechas incorrectas'*/
        return 1
      end

      if @i_fecha_ingreso = ''
        select
          @i_fecha_ingreso = null

      if @i_fecha_salida = ''
        select
          @i_fecha_salida = null

      begin tran

      /* establecer el numero de trabajos del ente */

      select
        @w_num_empleos = isnull(count(0),
                                0)
      from   cobis..cl_trabajo
      where  tr_persona = @i_ente

      /* seleccionar el siguiente numero de trabajo para el ente */
      select
        @o_siguiente = @w_num_empleos + 1

      /* insertar los datos del trabajo*/
      insert into cl_trabajo
                  (tr_persona,tr_trabajo,tr_empresa,tr_cargo,tr_moneda,
                   tr_sueldo,tr_tipo,tr_fecha_ingreso,tr_fecha_registro,
                   tr_fecha_modificacion,
                   tr_vigencia,tr_verificado,tr_fecha_salida,tr_recpublicos,
                   tr_tipo_empleo)
      values      (@i_ente,@o_siguiente,@i_empresa,@i_cargo,@i_moneda,
                   @i_sueldo,@i_tipo,@i_fecha_ingreso,@w_today,@w_today,
                   'S','N',@i_fecha_salida,@i_recpublicos,@i_tipoempleo)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103045
        /* 'Error en creacion de empleo'*/
        return 1
      end

      /* Transaccion servicios - cl_trabajo */
      insert into ts_trabajo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,trabajo,
                   nom_empresa,cargo,moneda,sueldo,tipo,
                   verificado,vigencia,fecha_ingreso,fecha_salida,
                   fecha_verificacion
      )
      values      (@s_ssn,@t_trn,'N',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@o_siguiente,
                   @i_empresa,@i_cargo,@i_moneda,@i_sueldo,@i_tipo,
                   'N','S',@i_fecha_ingreso,@i_fecha_salida,@i_fecha_verifi)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /*'Error en creacion de transaccion de servicios'*/
        return 1
      end

      /* aumentar en uno el numero de trabajos del ente */
      update cl_ente
      set    p_trabajo = @w_num_empleos + 1
      where  en_ente = @i_ente

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103045
        /* 'Error en creacion de empleo'*/
        return 1
      end

      commit tran

      /* retornar el nuevo secuencial del trabajo */
      select
        @o_siguiente
      /*MGV Buscar estado de bloqueo del ente por informacion incompleta       */
      exec sp_ente_bloqueado
        @s_ssn       = @s_ssn,
        @s_user      = @s_user,
        @s_term      = @s_term,
        @s_date      = @s_date,
        @s_srv       = @s_srv,
        @s_lsrv      = @s_lsrv,
        @s_ofi       = @s_ofi,
        @s_rol       = @s_rol,
        @s_org_err   = @s_org_err,
        @s_error     = @s_error,
        @s_sev       = @s_sev,
        @s_msg       = @s_msg,
        @s_org       = @s_org,
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @t_from,
        @t_trn       = 176,
        @i_operacion = 'U',
        @i_ente      = @i_ente,
        @o_retorno   = @w_bloqueado output

      /* MGV Fin Buscar       */

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
    if @t_trn = 182
    begin
      /* Verificar que exista la compania
      select @w_codigo = null
      from  cl_compania
      where nombre = @i_empresa
      
      /* si no existe la compania, error */
      if @@rowcount = 0
      begin
      exec sp_cerror
         @t_debug  = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 151030
         /*'No existe compania'*/
      return 1
      end */
      if @i_tipo is not null
      begin
        /*'Verificar que exista el rol de empresa'*/
        exec @w_return = cobis..sp_catalogo
          @t_debug    = @t_debug,
          @t_file     = @t_file,
          @t_from     = @w_sp_name,
          @i_tabla    = 'cl_rol_empresa',
          @i_operacion= 'E',
          @i_codigo   = @i_tipo

        /* 'si no existe el rol de empresa, error' */
        if @w_return <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101017
          /* 'No existe rol de empresa'*/
          return 1
        end
      end

      /* Valida la verificacion */
      if @i_verificado <> 'S'
         and @i_verificado <> 'N'
      begin
        /* 'Parametro no valido'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101114
        return 1
      end

      /* Se verifica que exista la moneda indicada  */
      if not exists (select
                       1
                     from   cl_moneda
                     where  mo_moneda = @i_moneda
                        and mo_estado = 'V')
         and @i_sueldo is not null
      begin
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101045 /*No existe la moneda indicada*/
        return 1
      end

      /* si las fechas no son correctas*/
      if @i_fecha_ingreso > @i_fecha_salida
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101140
        /* 'Fechas incorrectas'*/
        return 1
      end

      if @i_fecha_ingreso = ''
        select
          @i_fecha_ingreso = null

      if @i_fecha_salida = ''
        select
          @i_fecha_salida = null

      /* Control de campos a actualizar */
      select
        @w_empresa = tr_empresa,
        @w_cargo = tr_cargo,
        @w_moneda = tr_moneda,
        @w_sueldo = tr_sueldo,
        @w_fecha_modificacion = tr_fecha_modificacion,
        @w_fecha_verificacion = tr_fecha_verificacion,
        @w_fecha_ingreso = tr_fecha_ingreso,
        @w_fecha_salida = tr_fecha_salida,
        @w_verificado = tr_verificado,
        @w_vigencia = tr_vigencia,
        @w_tipo = tr_tipo,
        @w_tipoempleo = tr_tipo_empleo,
        @w_resultado = tr_obs_verificado
      from   cl_trabajo
      where  tr_persona = @i_ente
         and tr_trabajo = @i_trabajo

      if @@rowcount <> 1
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105042
        /* 'No existe empleo' */
        return 1
      end

      select
        @v_empresa = @w_empresa,
        @v_cargo = @w_cargo,
        @v_moneda = @w_moneda,
        @v_sueldo = @w_sueldo,
        @v_fecha_modificacion = @w_fecha_modificacion,
        @v_fecha_verificacion = @w_fecha_verificacion,
        @v_fecha_ingreso = @w_fecha_ingreso,
        @v_fecha_salida = @w_fecha_salida,
        @v_verificado = @w_verificado,
        @v_vigencia = @w_vigencia,
        @v_tipo = @w_tipo,
        @v_tipoempleo = @w_tipoempleo,
        @v_resultado = @w_resultado

      if @w_moneda = @i_moneda
        select
          @w_moneda = null,
          @v_moneda = null
      else
        select
          @w_moneda = @i_moneda

      if @w_fecha_ingreso = @i_fecha_ingreso
        select
          @w_fecha_ingreso = null,
          @v_fecha_ingreso = null
      else
        select
          @w_fecha_ingreso = @i_fecha_ingreso

      if @w_fecha_salida = @i_fecha_salida
        select
          @w_fecha_salida = null,
          @v_fecha_salida = null
      else
        select
          @w_fecha_salida = @i_fecha_salida

      if @w_verificado = @i_verificado
        select
          @w_verificado = null,
          @v_verificado = null
      else
        select
          @w_verificado = @i_verificado

      if @w_fecha_verificacion = @i_fecha_verifi
        select
          @w_fecha_verificacion = null,
          @v_fecha_verificacion = null
      else
        select
          @w_fecha_verificacion = @i_fecha_verifi

      if @w_empresa = @i_empresa
        select
          @w_empresa = null,
          @v_empresa = null
      else
        select
          @w_empresa = @i_empresa

      if @w_cargo = @i_cargo
        select
          @w_cargo = null,
          @v_cargo = null
      else
        select
          @w_cargo = @i_cargo

      if @w_sueldo = @i_sueldo
        select
          @w_sueldo = null,
          @v_sueldo = null
      else
        select
          @w_sueldo = @i_sueldo

      if @w_tipo = @i_tipo
        select
          @w_tipo = null,
          @v_tipo = null
      else
        select
          @w_tipo = @i_tipo

      if @w_tipoempleo = @i_tipoempleo
        select
          @w_tipoempleo = null,
          @v_tipoempleo = null
      else
        select
          @w_tipoempleo = @i_tipoempleo

      select
        @w_vigencia = null,
        @v_vigencia = null --ream 05.abr.2010 control vigencia de datos del ente

      if @w_resultado = @i_resultado
        select
          @w_resultado = null,
          @v_resultado = null
      else
        select
          @w_resultado = @i_resultado

      begin tran
      /* modificar los datos */
      update cl_trabajo
      set    tr_empresa = @i_empresa,
             tr_cargo = @i_cargo,
             tr_moneda = @i_moneda,
             tr_sueldo = @i_sueldo,
             tr_fecha_modificacion = @w_today,
             tr_fecha_verificacion = @i_fecha_verifi,
             tr_fecha_ingreso = @i_fecha_ingreso,
             tr_fecha_salida = @i_fecha_salida,
             tr_vigencia = isnull(@w_vigencia,
                                  tr_vigencia),
             --ream 05.abr.2010 control vigencia de datos del ente
             tr_verificado = 'N',
             tr_tipo = @i_tipo,
             tr_tipo_empleo = @i_tipoempleo,
             tr_recpublicos = @i_recpublicos,
             tr_obs_verificado = @i_resultado
      where  tr_persona = @i_ente
         and tr_trabajo = @i_trabajo
      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105042
        /* 'Error en actualizacion de empleo'*/
        return 1
      end

      if @i_verificado = 'S'
      begin
        update cl_trabajo
        set    tr_funcionario = @s_user,
               tr_verificado = @i_verificado,
               tr_fecha_verificacion = @i_fecha_verifi
        where  tr_persona = @i_ente
           and tr_trabajo = @i_trabajo

        /* si no se puede modificar, error */
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105042
          /* 'Error en actualizacion de empleo'*/
          return 1
        end
      end

      /* Transaccion servicios - cl_trabajo */
      insert into ts_trabajo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,trabajo,
                   nom_empresa,cargo,moneda,sueldo,tipo,
                   verificado,vigencia,fecha_ingreso,fecha_modificacion,
                   fecha_salida
                   ,
                   fecha_verificacion)
      values      (@s_ssn,@t_trn,'P',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_trabajo,
                   @v_empresa,@v_cargo,@v_moneda,@v_sueldo,@v_tipo,
                   @v_verificado,@v_vigencia,@v_fecha_ingreso,
                   @v_fecha_modificacion,
                   @v_fecha_salida,
                   @v_fecha_verificacion)

      /* si no se puede insertar, error */
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

      /* Transaccion servicio - cl_trabajo */
      insert into ts_trabajo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,trabajo,
                   nom_empresa,cargo,moneda,sueldo,tipo,
                   verificado,vigencia,fecha_ingreso,fecha_salida,
                   fecha_verificacion
      )
      values      (@s_ssn,@t_trn,'A',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_trabajo,
                   @w_empresa,@w_cargo,@w_moneda,@w_sueldo,@w_tipo,
                   @w_verificado,@w_vigencia,@w_fecha_ingreso,
                   --ream 05.abr.2010 control vigencia de datos del ente
                   @w_fecha_salida,@i_fecha_verifi)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /*'Error en creacion de transaccion de servicios'*/
        return 1
      end

      /* establecer el numero de trabajos del ente - data errada  */

      select
        @w_num_empleos = isnull(count(0),
                                0)
      from   cobis..cl_trabajo
      where  tr_persona = @i_ente

      update cobis..cl_ente
      set    p_trabajo = @w_num_empleos
      where  en_ente = @i_ente
      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103045
        /* 'Error en creacion de empleo'*/
        return 1
      end

      commit tran
      /*MGV Buscar estado de bloqueo del ente por informacion incompleta       */
      exec sp_ente_bloqueado
        @s_ssn       = @s_ssn,
        @s_user      = @s_user,
        @s_term      = @s_term,
        @s_date      = @s_date,
        @s_srv       = @s_srv,
        @s_lsrv      = @s_lsrv,
        @s_ofi       = @s_ofi,
        @s_rol       = @s_rol,
        @s_org_err   = @s_org_err,
        @s_error     = @s_error,
        @s_sev       = @s_sev,
        @s_msg       = @s_msg,
        @s_org       = @s_org,
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @t_from,
        @t_trn       = 176,
        @i_operacion = 'U',
        @i_ente      = @i_ente,
        @o_retorno   = @w_bloqueado output
      /* MGV Fin Buscar       */
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
    if @t_trn = 1230
    begin
      /* Campos para transaccion de servicios  */
      select
        @w_empresa = tr_empresa,
        @w_cargo = tr_cargo,
        @w_moneda = tr_moneda,
        @w_sueldo = tr_sueldo,
        @w_tipo = tr_tipo,
        @w_fecha_modificacion = tr_fecha_modificacion,
        @w_fecha_verificacion = tr_fecha_verificacion,
        @w_fecha_ingreso = tr_fecha_ingreso,
        @w_fecha_salida = tr_fecha_salida,
        @w_fecha_registro = tr_fecha_registro,
        @w_vigencia = tr_vigencia,
        @w_verificado = tr_verificado
      from   cl_trabajo
      where  tr_persona = @i_ente
         and tr_trabajo = @i_trabajo

      /* si no existe, trabajo para este ente, error */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe  dato solicitado'*/
        return 1
      end

      begin tran

      /* borrar el empleo correspondiente */
      delete from cl_trabajo
      where  tr_persona = @i_ente
         and tr_trabajo = @i_trabajo

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107045
        /*'Error en eliminacion de empleo'*/
        return 1
      end

      /* modificar la secuencia de trabajos */
      update cl_trabajo
      set    tr_trabajo = tr_trabajo - 1
      where  tr_persona = @i_ente
         and tr_trabajo > @i_trabajo

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        /* 'Error en eliminacion de empleo'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107045
        return 1
      end

      /* establecer el numero de trabajos del ente */

      select
        @w_num_empleos = isnull(count(0),
                                0)
      from   cobis..cl_trabajo
      where  tr_persona = @i_ente

      /* reducir en uno el numero de empleos del ente */
      update cl_ente
      set    p_trabajo = @w_num_empleos
      where  en_ente = @i_ente

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107045
        /*'Error en disminucion de empleo'*/
        return 1
      end

      /* Transaccion servicio - cl_trabajo */
      insert into ts_trabajo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,trabajo,
                   nom_empresa,cargo,moneda,sueldo,tipo,
                   vigencia,verificado,fecha_modificacion,fecha_ingreso,
                   fecha_registro
                   ,
                   fecha_salida,fecha_verificacion)
      values      (@s_ssn,@t_trn,'B',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_trabajo,
                   @w_empresa,@w_cargo,@w_moneda,@w_sueldo,@w_tipo,
                   @w_vigencia,@w_verificado,@w_fecha_modificacion,
                   @w_fecha_ingreso,
                   @w_fecha_registro,
                   @w_fecha_salida,@w_fecha_verificacion)

      /* si no se puede insertar, error */
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

/** Search **/
  /* datos de empleos de una persona no se controla de 20 en 20
     se espera menos de 20 empleos por persona  */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1231
    begin
      select
        'Numero' = tr_trabajo,
        'Empresa' = substring(tr_empresa,
                              1,
                              20),
        'Cargo' = substring(tr_cargo,
                            1,
                            20),
        'Tipo Empleo'= tr_tipo_empleo,
        'Moneda' = substring(mo_descripcion,
                             1,
                             15),
        'Sueldo' = tr_sueldo,
        'Verif.' = tr_verificado,
        'Vig.' = tr_vigencia,
        'Fecha Ing.' = convert (char(12), tr_fecha_ingreso, @i_formato_fecha),
        'Fecha Sal.' = convert (char(12), tr_fecha_salida, @i_formato_fecha),
        'Fecha Mod.' = convert (char(12), tr_fecha_modificacion,
                       @i_formato_fecha)
        ,
        'Maneja Rec Pub' = tr_recpublicos,
        'Obs Verificado'= tr_obs_verificado
      from   cl_trabajo
             left outer join cl_moneda
                          on tr_moneda = mo_moneda
      where  tr_persona = @i_ente
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
  /* Busqueda de trabajos especificos de un ente */

  if @i_operacion = 'Q'
  begin
    if @t_trn = 1232
    begin
      select
        @o_ennombre = rtrim(X.p_p_apellido) + ' ' + rtrim(X.p_s_apellido) + ' '
                      +
                      rtrim(
                             X.en_nombre),
        @o_ente = tr_persona,
        @o_cedula = X.en_ced_ruc,
        @o_trabajo = tr_trabajo,
        @o_empresa = tr_empresa,
        @o_no_empresa = tr_empresa,
        @o_cargo = tr_cargo,
        @o_sueldo = tr_sueldo,
        @o_moneda = tr_moneda,
        @o_mon_desc = mo_descripcion,
        @o_fecha_ingreso = tr_fecha_ingreso,
        @o_fecha_salida = tr_fecha_salida,
        @o_fecha_modificacion = tr_fecha_modificacion,
        @o_fecha_verificacion = tr_fecha_verificacion,
        @o_fecha_registro = tr_fecha_registro,
        @o_tipo = tr_tipo,
        @o_tipoempleo = tr_tipo_empleo,
        @o_vigencia = tr_vigencia,
        @o_verificado = tr_verificado,
        @o_funcionario = tr_funcionario,
        @o_recpublicos = tr_recpublicos
      from   cl_trabajo
             left outer join cl_moneda
                          on tr_moneda = mo_moneda
             inner join cl_ente X
                     on X.en_ente = tr_persona
      where  tr_persona = @i_ente
         and tr_trabajo = @i_trabajo

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /*'No existe dato solicitado'*/
        return 1
      end

      select
        @o_trabajo,
        @o_empresa,
        @o_no_empresa,
        @o_cargo,
        @o_sueldo,
        @o_tipo,
        @o_tipoempleo,
        @o_tinombre,
        @o_moneda,
        @o_mon_desc,
        convert(char(10), @o_fecha_ingreso, @i_formato_fecha),
        convert(char(10), @o_fecha_salida, @i_formato_fecha),
        convert(char(10), @o_fecha_registro, @i_formato_fecha),
        convert(char(10), @o_fecha_modificacion, @i_formato_fecha),
        @o_vigencia,
        @o_verificado,
        @o_funcionario,
        convert(char(10), @o_fecha_verificacion, @i_formato_fecha),
        @o_recpublicos
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

  if @i_operacion = 'X'
  begin
    if @t_trn = 1232
    begin
      select
        @o_parOC = isnull(pa_char,
                          'N')
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'OCE'

      if @@rowcount <> 1
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001,
          @i_msg   = 'NO EXISTE PARAMETRO DE MONTO '
        return 101001
      end

      select
        @o_ocupa = en_concordato
      from   cobis..cl_ente
      where  en_ente = @i_ente

      /*if @@rowcount = 0
      begin
         exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 101001
              /* 'No existe dato solicitado'*/
         return 1
      end*/

      select
        @o_traba = isnull(count(0),
                          0)
      from   cobis..cl_trabajo
      where  tr_persona = @i_ente

      select
        'parametro ' = @o_parOC,
        'ocuapacion' = @o_ocupa,
        'traba' = @o_traba

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

  return 0

go

