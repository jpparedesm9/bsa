/************************************************************************/
/*  Archivo:            ah_inmoviliza.sp                                */
/*  Stored procedure:   sp_ah_inmoviliza                                */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas Corrientes y Ahorros                    */
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
/*      Inmovilizar cuentas que no se han movido en 6 mm o mas          */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA           AUTOR             RAZON                             */
/*  01/Jul/1998     J.R.Pineda        Modificar a 12 meses o +          */
/*  14/Nov/1998     D Villafuerte     Revision General                  */
/*  02/Mayo/2016    Ignacio Yupa      Migración a CEN                   */
/*  28/Jul/2016     J.Tagle           No inmovilizar Prod Aporte Social */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_inmoviliza')
  drop proc sp_ah_inmoviliza
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_inmoviliza
(
  @t_show_version bit = 0,
  @i_filial       tinyint = 1,
  @i_fecha        smalldatetime = null,
  @i_param1       datetime = null,
  @i_corresponsal char(1) = 'N',--Req. 381 CB Red Posicionada        
  @o_contador     int = null out
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_ctacte           int,
    @w_cuenta           cuenta,
    @w_contable         money,
    @w_mensaje          varchar(132),
    @w_ssn              int,
    @w_estado           char(1),
    @w_oficina          smallint,
    @w_sector_cta       char(3),
    @w_saldo_interes    money,
    @w_fecha_proceso    datetime,
    @w_prod_banc        smallint,
    @w_banca_cont       char(3),
    @w_tiempo           smallint,
    @w_numrg            int,
    @w_ofi_matriz       smallint,
    @w_abpais           varchar(10),
    @w_clase_clte       char(1),
    @w_mon              tinyint,
    @w_cliente          int,
    @w_tipocta_super    char(1),
    @w_categoria        char(1),
    @w_ciudad           int,
    @w_primerdia        datetime,
    @w_dia1mes          datetime,
    @w_envio_int        varchar(1),
    @w_saldo_ayer       money,
    @w_reactiva_sin_mov char(1),
    @w_prod_bancario    varchar(50), --Req. 381 CB Red Posicionada
    @w_cta_asa          smallint,
    @w_cta_aso          smallint
	
  -- Nombre del sp
  select
    @w_sp_name = 'sp_ah_inmoviliza'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @o_contador = 0,
    @w_envio_int = 'S',
    @w_reactiva_sin_mov = 'N'

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

  if (@i_fecha is null)
     and (@i_param1 is null)
    return 1

  if (@i_fecha is null)
    select
      @i_fecha = @i_param1

  ------------------------------------------------------------------------------------------
  -- Prod Banc Aporte Social - Verificación que Deposito NO sea mayor a Monto Aporte Social
  ------------------------------------------------------------------------------------------  
  -- Producto Final Aporte Social Ordinario
  select @w_cta_aso  = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
  and    pa_nemonico = 'PCAASO'
  -- Producto Final Aporte Social Adicional
  select @w_cta_asa = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
  and    pa_nemonico = 'PCAASA'
    
  /* DETERMINAR LA CIUDAD DE LOS FERIADOS NACIONALES */
  select
    @w_ciudad = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'CMA'

  if @@rowcount <> 1
  begin
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 205031
    return 205031
  end

/********************************************************/
/** Este bleoque es para cuando el dia a procesar es  
    el primer dia habil del mes y adicionalmente hay 
    dias anteriores festivos, no enviar el valor del  
    interes en la tranasccion                        ***/
  /********************************************************/
  select
    @w_primerdia = dateadd(dd,
                           1 - datepart(dd,
                                        @i_fecha),
                           @i_fecha)
  select
    @w_dia1mes = @w_primerdia

  print 'Fecha para el primer dia del mes ' + cast (@w_primerdia as varchar)

  if @w_primerdia <> @i_fecha
  begin
    /** Busco el primer dia laborable del mes  *****/
    while exists(select
                   1
                 from   cobis..cl_dias_feriados
                 where  df_ciudad = 99999
                        -- @w_ciudad                                                   
                        and df_fecha  = @w_primerdia)
    begin
      select
        @w_primerdia = dateadd(dd,
                               1,
                               @w_primerdia)
    end
  end

  print 'Primer dia laborable ' + cast (@w_primerdia as varchar)
  /*** Si el primer dia habil del mes es igual a la fecha que se esta procesando  no debo enviar intereses en el registro de tran_servicio  ***/
  if @w_primerdia = @i_fecha
  begin
    /** NO Debo Enviar a contabilidad los intereses calculados en la inactivacion***/
    print ' Los intereses calculados de las cuentas se enviaran en cero '
    select
      @w_envio_int = 'N'
  end
  else
  -- Si las fechas no son iguales signifia que estoy procesando un dia diferente al primer dia habil 
  begin
    select
      @w_envio_int = 'S'
    print 'Se esta procesando un dia diferente al primer dia habil'
  end
/**************************************************************/
  /* Inicializar el SSN para el proceso de notas de debito */
  begin tran

  select
    @w_ssn = se_numero
  from   cobis..ba_secuencial

  if @@rowcount <> 1
  begin
    /* Error en lectura de SSN */
    exec cobis..sp_cerror
      @i_num = 201163
    return 201163
  end

  update cobis..ba_secuencial
  set    se_numero = @w_ssn + 1000000

  if @@rowcount <> 1
  begin
    /* Error en lectura de SSN */
    rollback tran
    exec cobis..sp_cerror
      @i_num = 201163
    return 201163
  end

  commit tran

  /* Carga de Parametro del Pais */

  select
    @w_abpais = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'ABPAIS'
     and pa_producto = 'ADM'

  if @w_abpais is null
    select
      @w_abpais = 'PA'

  /* Captura de Parametro para inactivacion de cuentas por no movimiento */
  if @w_abpais = 'CO'
  begin
    /* Tiempo para pasar a inactividad en dias */
    select
      @w_tiempo = pa_int
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'DPINA'

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 201196
      return 201196
    end
  end
  else
  begin
    /* Tiempo para pasar a inactividad en meses */
    select
      @w_tiempo = pa_smallint
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'INAA'

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 201196
      return 201196
    end
  end

  select
    @w_ofi_matriz = pa_smallint
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'OMAT'

  if @@rowcount <> 1
  begin
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 201196
    return 201196
  end

  select
    @w_tiempo = @w_tiempo * (-1)

  if @w_abpais = 'CO'
    select
      @w_fecha_proceso = dateadd(dd,
                                 @w_tiempo,
                                 @i_fecha)
  else
    select
      @w_fecha_proceso = dateadd(mm,
                                 @w_tiempo,
                                 @i_fecha)

  select
    @w_fecha_proceso = dateadd(dd,
                               1,
                               @w_fecha_proceso)

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    print '************ ' + cast (@w_fecha_proceso as varchar)
    -- Cursor para ctas por inmovilizar
    declare inmovil cursor for
      select
        ah_cuenta,
        ah_cta_banco,
        ah_disponible + ah_12h + ah_24h,
        ah_estado,
        ah_oficina,
        ah_prod_banc,
        ah_saldo_interes,
        ah_clase_clte,
        ah_moneda,
        ah_cliente,
        ah_tipocta_super,
        ah_categoria,
        ah_saldo_ayer
      from   ah_cuenta
      where  ah_estado        = 'A'
         and ah_filial        = @i_filial
         and ah_prod_banc     <> @w_prod_bancario -- Req. 381 CB Red Posicionada
         and ah_prod_banc     <> @w_cta_aso -- Aporte Social Ordinario
         and ah_prod_banc     <> @w_cta_asa -- Aporte Social Adicional
         and ah_fecha_ult_mov < @w_fecha_proceso
      for update of ah_estado
  end
  else
  begin
    print '************ ' + cast (@w_fecha_proceso as varchar)
    -- Cursor para ctas por inmovilizar
    declare inmovil cursor for
      select
        ah_cuenta,
        ah_cta_banco,
        ah_disponible + ah_12h + ah_24h,
        ah_estado,
        ah_oficina,
        ah_prod_banc,
        ah_saldo_interes,
        ah_clase_clte,
        ah_moneda,
        ah_cliente,
        ah_tipocta_super,
        ah_categoria,
        ah_saldo_ayer
      from   ah_cuenta
      where  ah_estado        = 'A'
         and ah_filial        = @i_filial
         and ah_fecha_ult_mov < @w_fecha_proceso
         and ah_prod_banc     <> @w_cta_aso -- Aporte Social Ordinario
         and ah_prod_banc     <> @w_cta_asa -- Aporte Social Adicional
      for update of ah_estado
  end
  -- Abre cursor
  open inmovil
  fetch inmovil into @w_ctacte,
                     @w_cuenta,
                     @w_contable,
                     @w_estado,
                     @w_oficina,
                     @w_prod_banc,
                     @w_saldo_interes,
                     @w_clase_clte,
                     @w_mon,
                     @w_cliente,
                     @w_tipocta_super,
                     @w_categoria,
                     @w_saldo_ayer

  -- Valida Estado
  if @@fetch_status = -2
  begin
    close inmovil
    deallocate inmovil

    select
      @w_mensaje = mensaje
    from   cobis..cl_errores
    where  numero = 201157

    select
      @w_return = 201157

    goto ERRORFIN
  end

  if @@fetch_status = -1
  begin
    print ' No hay'
    close inmovil
    deallocate inmovil
    return 0
  end

  while @@fetch_status = 0
  begin
    begin tran
    print ' cuenta : ' + @w_cuenta

    if not exists(select
                    1
                  from   cob_ahorros..ah_tran_servicio
                  where  ts_cta_banco = @w_cuenta
                     and ts_tipo_transaccion in (203, 376)
                     and ts_tsfecha   = @i_fecha)
    begin
      insert into ah_his_inmovilizadas
                  (hi_cuenta,hi_saldo,hi_fecha)
      values      (@w_cuenta,@w_contable,@i_fecha)

      if @@error <> 0
      begin
        rollback tran
        print 'Procesando ...1'

        select
          @w_mensaje = mensaje
        from   cobis..cl_errores
        where  numero = 203011

        -- Error en la insercion de historico de inmovilizadas 
        if @w_mensaje is null
          select
            @w_mensaje = 'ERROR EN INSERCION DE HISTORICO DE INMOVILIZADAS'

        goto ERROR
      end
    end
    else
    begin
      print 'CUENTA: ' + @w_cuenta
            + ' TIENE UNA REACTIVACION REGISTRADA SIN MOVIMIENTO DE RESPALDO'
      select
        @w_reactiva_sin_mov = 'S'
    end

    if @w_contable > 0
    begin
      if @w_envio_int = 'N'
        select
          @w_saldo_interes = 0

      insert into ah_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_tsfecha,ts_usuario,
                   ts_terminal,
                   ts_ctacte,ts_filial,ts_valor,ts_interes,ts_oficina,
                   ts_oficina_cta,ts_prod_banc,ts_causa,ts_cod_alterno,ts_moneda
                   ,
                   ts_clase_clte,ts_cliente,ts_tipocta_super
                   ,ts_cta_banco,
                   ts_categoria
                   ,
                   ts_saldo)
      values      (@w_ssn,367,@i_fecha,'op_batch','consola',
                   @w_ctacte,@i_filial,@w_saldo_ayer,@w_saldo_interes,@w_oficina
                   ,
                   @w_oficina,@w_prod_banc,'A',1,@w_mon,
                   @w_clase_clte,@w_cliente,@w_tipocta_super,@w_cuenta,
                   @w_categoria,
                   @w_contable)

      if @@error <> 0
      begin
        rollback tran
        print 'Procesando ...1'

        select
          @w_mensaje = mensaje
        from   cobis..cl_errores
        where  numero = 203005

        -- Error en la insercion de historico de inmovilizadas 
        if @w_mensaje is null
          select
            @w_mensaje = 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO - TS1'

        goto ERROR
      end

      if exists (select
                   1
                 from   cob_remesas..re_tesoro_nacional
                 where  tn_cuenta = @w_cuenta
                    and tn_estado = 'S')
      begin
        insert into ah_tran_servicio
                    (ts_secuencial,ts_tipo_transaccion,ts_tsfecha,ts_usuario,
                     ts_terminal,
                     ts_ctacte,ts_filial,ts_valor,ts_interes,ts_oficina,
                     ts_oficina_cta,ts_prod_banc,ts_causa,ts_cod_alterno,
                     ts_moneda
                     ,
                     ts_clase_clte,ts_cliente,ts_tipocta_super
                     ,ts_cta_banco,
                     ts_categoria
                     ,
                     ts_saldo)
        values      (@w_ssn,367,@i_fecha,'op_batch','consola',
                     @w_ctacte,@i_filial,@w_saldo_ayer * -1,
                     @w_saldo_interes * -1,
        /*** Se cambia el signo de la transaccion para contabilidad ***/
                     @w_oficina,
                     @w_oficina,@w_prod_banc,'T',2,@w_mon,
                     @w_clase_clte,@w_cliente,@w_tipocta_super,@w_cuenta,
                     @w_categoria,
                     @w_contable * -1)

        if @@error <> 0
        begin
          rollback tran

          select
            @w_mensaje = mensaje
          from   cobis..cl_errores
          where  numero = 203005

          -- Error en la insercion de historico de inmovilizadas 
          if @w_mensaje is null
            select
              @w_mensaje = 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO - TS2'

          goto ERROR
        end
      end
      else
      begin
        insert into ah_tran_servicio
                    (ts_secuencial,ts_tipo_transaccion,ts_tsfecha,ts_usuario,
                     ts_terminal,
                     ts_ctacte,ts_filial,ts_valor,ts_interes,ts_oficina,
                     ts_oficina_cta,ts_prod_banc,ts_causa,ts_cod_alterno,
                     ts_moneda
                     ,
                     ts_clase_clte,ts_cliente,ts_tipocta_super
                     ,ts_cta_banco,
                     ts_categoria
                     ,
                     ts_saldo)
        values      (@w_ssn,367,@i_fecha,'op_batch','consola',
                     @w_ctacte,@i_filial,@w_saldo_ayer * -1,
                     @w_saldo_interes * -1,
        /*** Se cambia el signo de la transaccion para contabilidad ***/
                     @w_oficina,
                     @w_oficina,@w_prod_banc,'I',2,@w_mon,
                     @w_clase_clte,@w_cliente,@w_tipocta_super,@w_cuenta,
                     @w_categoria,
                     @w_contable * -1)

        if @@error <> 0
        begin
          rollback tran

          select
            @w_mensaje = mensaje
          from   cobis..cl_errores
          where  numero = 203005

          -- Error en la insercion de historico de inmovilizadas 
          if @w_mensaje is null
            select
              @w_mensaje = 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO - TS3'

          goto ERROR
        end
      end

      update cob_ahorros..ah_cuenta
      set    ah_estado = 'I'
      where  current of inmovil

      if @@error <> 0
      begin
        rollback tran

        select
          @w_mensaje = mensaje
        from   cobis..cl_errores
        where  numero = 276001

        if @w_mensaje is null
          select
            @w_mensaje = 'ERROR AL ACTUALIZAR ESTADO DE LA CUENTA DE AHORROS'

        goto ERROR
      end

      if @w_reactiva_sin_mov = 'S'
      begin
        update cob_remesas..re_tesoro_nacional
        set    tn_estado = 'P'
        where  tn_cuenta = @w_cuenta
           and tn_estado = 'S'

        if @@error <> 0
        begin
          rollback tran

          select
            @w_mensaje = mensaje
          from   cobis..cl_errores
          where  numero = 276002

          if @w_mensaje is null
            select
              @w_mensaje =
              'ERROR AL ACTUALIZAR ESTADO DE LA CUENTA EN re_tesoro_nacional'

          goto ERROR
        end
      end
    end
    else --Saldo Cero. Cierre de Cuenta
    begin
      print '----------------------------'

      --verificar embargos
      if exists (select
                   1
                 from   cobis..cl_cab_embargo,
                        cobis..cl_det_embargo
                 where  ca_ente                 = @w_cliente
                    and ca_ente                 = de_ente
                    and ca_secuencial           = de_secuencial
                    and ca_tipo_proceso         = 'B'
                    and de_estado_levantamiento = 'N'
                    and ca_nro_cta_especifica   = de_num_cuenta
                    and ca_nro_cta_especifica   = @w_cuenta)
      begin
        goto SIGUIENTE
      end
      -- Secuencial Historico de Cierre
      select
        @w_numrg = siguiente + 1
      from   cobis..cl_seqnos
      where  tabla = 'ah_his_cierre'

      if @@rowcount <> 1
      begin
        /* No existe tabla de secuenciales */
        rollback tran
        print 'Procesando...Error en Busqueda de Secuencial'

        select
          @w_mensaje = mensaje
        from   cobis..cl_errores
        where  numero = 190059

        goto ERROR
      end

      update cobis..cl_seqnos
      set    siguiente = @w_numrg
      where  tabla = 'ah_his_cierre'

      if @@error <> 0
      begin
        /* Error en actualizacion de secuencial */
        rollback tran
        print 'Procesando...Error en Actualizacion de Seqnos'

        select
          @w_mensaje = mensaje
        from   cobis..cl_errores
        where  numero = 190059

        -- ERROR EN ACTUALIZACION DE SEQNOS 
        if @w_mensaje is null
          select
            @w_mensaje = 'ERROR EN ACTUALIZACION DE TABLA DE SEQNOS'
        goto ERROR
      end

      insert into cob_ahorros..ah_his_cierre
                  (hc_secuencial,hc_cuenta,hc_orden,hc_causa,hc_saldo,
                   hc_fecha,hc_filial,hc_oficina,hc_autorizante,hc_estado)
      values      (@w_numrg,@w_ctacte,'A','2',0,
                   @i_fecha,@i_filial,@w_ofi_matriz,'op_batch','C')

      if @@error <> 0
      begin
        rollback tran
        print 'Procesando...Error en Historico de Cierre'

        select
          @w_mensaje = mensaje
        from   cobis..cl_errores
        where  numero = 203010

        -- ERROR EN ACTUALIZACION DE SEQNOS 
        if @w_mensaje is null
          select
            @w_mensaje = 'ERROR AL GRABAR HISTORICO DE CIERRE'
        goto ERROR
      end

      update cob_ahorros..ah_cuenta
      set    ah_estado = 'C'
      where  ah_cuenta = @w_ctacte

      if @@rowcount <> 1
          or @@error <> 0
      begin
        rollback tran
        print 'Procesando...Error en Cierre de Cuenta'

        select
          @w_mensaje = mensaje
        from   cobis..cl_errores
        where  numero = 255001

        if @w_mensaje is null
          select
            @w_mensaje = 'ERROR AL ACTUALIZAR CUENTA A CANCELADA'
        goto ERROR
      end

      update cobis..cl_det_producto
      set    dp_estado_ser = 'C'
      where  dp_cuenta   = @w_cuenta
         and dp_producto = 4

      --if @@rowcount <> 1 or @@error <> 0
      --begin
      --   rollback tran 
      --   print 'Procesando...Error en Actualizacion de Producto'

      --   select @w_mensaje = mensaje
      --   from cobis..cl_errores
      --   where numero = 105050

      --   if @w_mensaje is null
      --      select @w_mensaje = 'ERROR AL ACTUALIZAR DET PRODUCTO'
      --   goto ERROR
      --end        

      -- Creacion de transaccion de servicio 
      insert into cob_ahorros..ah_tscierre_cta
                  (secuencial,tipo_transaccion,tsfecha,usuario,terminal,
                   oficina,reentry,origen,secuencia,cta_banco,
                   causa,saldo,fecha,autorizante,oficina_cta,
                   moneda,cliente,categoria,prod_banc)
      values      ( @w_ssn,213,@i_fecha,'op_batch','consola',
                    @w_ofi_matriz,'N','L',@w_numrg,@w_cuenta,
                    '2',0.00,@i_fecha,'op_batch',@w_oficina,
                    @w_mon,@w_cliente,@w_categoria,@w_prod_banc)

      if @@error <> 0
      begin
        -- Error en creacion de transaccion de servicio 
        rollback tran
        print 'Procesando...Error en Transaccion de Servicio'

        select
          @w_mensaje = mensaje
        from   cobis..cl_errores
        where  numero = 203005

        if @w_mensaje is null
          select
            @w_mensaje = 'ERROR AL CREAR TRANSACCION DE SERVICIO DE CIERRE'

        goto ERROR
      end
    end --Cierre de Cuenta

    select
      @w_ssn = @w_ssn + 1,
      @o_contador = @o_contador + 1

    goto SIGUIENTE

    ERROR:
    exec sp_errorlog
      @i_fecha       = @i_fecha,
      @i_error       = 0,
      @i_usuario     = 'batch',
      @i_tran        = 367,
      @i_cuenta      = @w_cuenta,
      @i_descripcion = @w_mensaje,
      @i_programa    = @w_sp_name

    SIGUIENTE:
    commit tran

    LEER:
    fetch inmovil into @w_ctacte,
                       @w_cuenta,
                       @w_contable,
                       @w_estado,
                       @w_oficina,
                       @w_prod_banc,
                       @w_saldo_interes,
                       @w_clase_clte,
                       @w_mon,
                       @w_cliente,
                       @w_tipocta_super,
                       @w_categoria,
                       @w_saldo_ayer

    if @@fetch_status = -2
    begin
      close inmovil
      deallocate inmovil

      select
        @w_mensaje = mensaje
      from   cobis..cl_errores
      where  numero = 201157

      select
        @w_return = 201157

      goto ERRORFIN
    end
  end

  close inmovil
  deallocate inmovil
  return 0

  ERRORFIN:
  exec sp_errorlog
    @i_fecha       = @i_fecha,
    @i_error       = 0,
    @i_usuario     = 'batch',
    @i_tran        = 367,
    @i_cuenta      = @w_cuenta,
    @i_descripcion = @w_mensaje,
    @i_programa    = @w_sp_name
  return @w_return

go

