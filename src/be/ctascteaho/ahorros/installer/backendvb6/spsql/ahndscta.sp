/************************************************************************/
/*      Archivo:                ahndscta.sp                             */
/*      Stored procedure:       sp_ahndscta                             */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Julio Navarrete/Boris Mosquera          */
/*      Fecha de escritura:     12/Ene/1995                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                              PROPOSITO                               */
/*      BATCH:  Cursor que permite emitir las notas de debito por       */
/*              envio de estado de cuenta para cuentas de traslado      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      19/09/2002      PMA             Emision Inicial                 */
/*      17/11/2006      P. COELLO       SOLO COBRAR COMISION A LAS      */
/*                                      CUENTAS ACTIVAS                 */
/*      27/01/2007      P. COELLO       eliminar matching contra tabla  */
/*                                      cabeceras de estas de cuenta, ya*/
/*                                      que las mismas se generan mucho */
/*                                      después del cobro de la comisión*/
/*                                      lo que ocasionaba que no se     */
/*                                      cobre la comisión.              */
/*     02/May/2016     J. Calderon      Migración a CEN                 */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ahndscta')
  drop proc sp_ahndscta
go

create proc sp_ahndscta
(
  @t_show_version bit = 0,
  @i_filial       tinyint = 1,
  @i_param1       datetime,-- fecha de proceso
  @i_fecha        datetime = null,
  @o_procesadas   int = 0 out
)
as
  declare
    @w_ssn             int,
    @w_sp_name         varchar(64),
    @w_srv             varchar(64),
    @w_tipo_dir        char(1),
    @w_cta_banco       cuenta,
    @w_cuenta          int,
    @w_categoria       char(1),
    @w_tipocta         char(1),
    @w_rol_ente        char(1),
    @w_tipo_def        char(1),
    @w_prod_banc       smallint,
    @w_producto        tinyint,
    @w_moneda          smallint,
    @w_tipo            char(1),
    @w_default         int,
    @w_personalizada   char(1),
    @w_oficina         smallint,
    @w_sucursal        smallint,
    @w_contable        money,
    @w_tipo_atributo   char(1),
    @w_monto           money,
    @w_disponible      money,
    @w_promedio1       money,
    @w_prom_disponible money,
    @w_filial          tinyint,
    @w_procesadas      int,
    @w_return          int,
    @w_valor_debitar   money,
    @w_mensaje         mensaje,
    @w_fecha_aux       datetime,
    @w_causa           char(3)

  select
    @w_sp_name = 'sp_ahndscta'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  -- Captura del nombre del Stored Procedure
  select
    @w_sp_name = 'sp_ahndscta'

  if @i_param1 is null
     and @i_fecha is null
  begin
    --Falta parametro obligatorio
    exec cobis..sp_cerror
      @i_num = 101114
    return 101114
  end

  if @i_fecha is null
    select
      @i_fecha = @i_param1

  exec @w_return = cob_remesas..sp_fecha_habil
    @i_fecha     = @i_fecha,
    @i_oficina   = 1,
    @i_efec_dia  = 'S',
    @i_finsemana = 'N',
    @w_dias_ret  = 1,
    @o_fecha_sig = @w_fecha_aux out

  if @w_return <> 0
      or @@error <> 0
  begin
    --Error al determinar ultimo dia habil del mes
    exec cobis..sp_cerror
      @i_num = 201163
    return 201163
  end

  if convert(varchar(2), (datepart(mm,
                                   @w_fecha_aux))) = convert(varchar(2),
                                                     (datepart(mm,
                                                               @i_fecha)))
    return 0 --Solo ejecuta en ultimo dia del mes

  begin tran
  print ' Entra al sp'
  -- Inicializar el SSN para el proceso de notas de debito
  select
    @w_ssn = se_numero
  from   cobis..ba_secuencial

  if @@rowcount <> 1
  begin
    -- Error en lectura de SSN
    exec cobis..sp_cerror
      @i_num = 201163
    return 201163
  end

  update cobis..ba_secuencial
  set    se_numero = @w_ssn + 1000000

  if @@rowcount <> 1
  begin
    -- Error en actualizacion de SSN
    exec cobis..sp_cerror
      @i_num = 205031
    return 205031
  end

  select
    @w_srv = nl_nombre
  from   cobis..ad_nodo_oficina
  where  nl_nodo = 1

  commit tran

  /* Inicializar el contador de cuentas procesadas */
  select
    @w_procesadas = 0

  /* Cursor para ah_cuenta */
  declare cuentas cursor for
    select
      ah_cta_banco,
      ah_cuenta,
      ah_default,
      ah_tipo_def,
      ah_tipo_dir,
      ah_rol_ente,
      ah_categoria,
      ah_personalizada,
      ah_oficina,
      ah_tipocta,
      ah_prod_banc,
      ah_producto,
      ah_moneda,
      ah_tipo,
      ah_filial,
      ah_12h + ah_24h + ah_remesas + ah_disponible + ah_48h,
      ah_disponible,
      ah_promedio1,
      ah_prom_disponible
    from   cob_ahorros..ah_cuenta
    where  ah_filial          = @i_filial
       and ah_estado_cuenta   = 'S'
       and ah_estado          = 'A'
       and ah_fecha_prx_corte = @i_fecha
    for read only

  /* Abrir el cursor para nd por envio estado de cuenta */
  open cuentas
  fetch cuentas into @w_cta_banco,
                     @w_cuenta,
                     @w_default,
                     @w_tipo_def,
                     @w_tipo_dir,
                     @w_rol_ente,
                     @w_categoria,
                     @w_personalizada,
                     @w_oficina,
                     @w_tipocta,
                     @w_prod_banc,
                     @w_producto,
                     @w_moneda,
                     @w_tipo,
                     @w_filial,
                     @w_contable,
                     @w_disponible,
                     @w_promedio1,
                     @w_prom_disponible

  if @@fetch_status = -1
  begin
    print 'No existen Registros a Procesar'
    close cuentas
    deallocate cuentas
    return 0
  end
  else if @@fetch_status = -2
  begin
    print ' Error al abrir el cursor'
    close cuentas
    deallocate cuentas
    select
      @w_procesadas
    return 111111
  end

  /* Barrer todas los registros para las cuentas a emitir nd */
  while @@fetch_status = 0
  begin
    select
      @w_valor_debitar = 0
    print 'La cuenta es ' + @w_cta_banco + ' Tipo direccion ' + cast (
          @w_tipo_dir
          as
                                   varchar)

    select
      @w_ssn = @w_ssn + 1,
      @w_procesadas = @w_procesadas + 1

    select
      @w_sucursal = isnull(of_sucursal,
                           of_oficina)
    from   cobis..cl_oficina
    where  of_oficina = @w_oficina

    if @w_tipo_dir = 'R' -- Retencion en una agencia del banco
    begin
      select
        @w_causa = '2' -- Cargo retencion estado de cuenta

      if @w_personalizada = 'N'
      begin
        select
          @w_tipo_atributo = tipo_atributo
        from   tempdb..pe_tipo_atributo
        where  filial       = @w_filial
           and sucursal     = @w_sucursal
           and producto     = 4
           and moneda       = @w_moneda
           and pro_bancario = @w_prod_banc
           and tipo_cta     = @w_tipocta
           and servicio     = 'EECT'
           and rubro        = '21' -- Costo por retencion de estado de cuenta

        if @@rowcount <> 1
        begin
          /* Grabar en la tabla de errores */
          insert cob_ahorros..re_error_batch
          values (@w_cta_banco,'ERROR AL BUSCAR EL TIPO DE ATRIBUTO 21')

          if @@error <> 0
          begin
            /* Error en grabacion de archivo de errores */
            exec cobis..sp_cerror
              @i_num = 203056

            /* Cerrar y liberar cursor */
            close cuentas
            deallocate cuentas

            select
              @o_procesadas = @w_procesadas
            return 203056
          end
          goto FETCH_REGISTRO
        end

        if @w_tipo_atributo = 'B' /* Saldo promedio */
          select
            @w_monto = @w_promedio1
        else if @w_tipo_atributo = 'C' /* Saldo Contable */
          select
            @w_monto = @w_contable
        else if @w_tipo_atributo = 'A' /* Saldo Disponible */
          select
            @w_monto = @w_disponible
        else if @w_tipo_atributo = 'E' /* Promedio Disponible */
          select
            @w_monto = @w_prom_disponible
        else
          select
            @w_monto = $1

        select
          @w_valor_debitar = valor
        from   tempdb..eect4
        where  tipo_ente     = @w_tipocta
           and pro_bancario  = @w_prod_banc
           and filial        = @w_filial
           and sucursal      = @w_sucursal
           and producto      = 4
           and moneda        = @w_moneda
           and categoria     = @w_categoria
           and servicio_dis  = 'EECT'
           and rubro         = '21'
           and tipo_atributo = @w_tipo_atributo
           and rango_desde   <= @w_monto
           and rango_hasta   > @w_monto

        if @@rowcount <> 1
        begin
          print 'Procesando ...2'
          /* Grabar en la tabla de errores */
          insert cob_ahorros..re_error_batch
          values (@w_cta_banco,'ERROR EN TABLA TMP DE PERSONALIZACION EECT')

          if @@error <> 0
          begin
            /* Error en grabacion de archivo de errores */
            exec cobis..sp_cerror
              @i_num = 203056

            /* Cerrar y liberar cursor */
            close cuentas
            deallocate cuentas

            select
              @o_procesadas = @w_procesadas
            return 203056
          end
          goto FETCH_REGISTRO
        end
      end

      else
      begin
        /* Encuentra valor a debitar por envio de estado de cuenta */
        exec @w_return = cob_remesas..sp_genera_costos
          @t_debug       = 'N',
          @t_file        = null,
          @t_from        = @w_sp_name,
          @i_fecha       = @i_fecha,
          @i_valor       = 1,
          @i_categoria   = @w_categoria,
          @i_tipo_ente   = @w_tipocta,
          @i_rol_ente    = @w_rol_ente,
          @i_tipo_def    = @w_tipo_def,
          @i_prod_banc   = @w_prod_banc,
          @i_producto    = @w_producto,
          @i_moneda      = @w_moneda,
          @i_tipo        = @w_tipo,
          @i_codigo      = @w_default,
          @i_servicio    = 'EECT',
          @i_rubro       = '21',
          @i_disponible  = @w_disponible,
          @i_contable    = @w_contable,
          @i_promedio    = @w_promedio1,
          @i_prom_disp   = @w_prom_disponible,
          @i_personaliza = @w_personalizada,
          @i_filial      = @w_filial,
          @i_oficina     = @w_oficina,
          @o_valor_total = @w_valor_debitar out

        if @w_return <> 0
        begin
          print 'Procesando ...3'
          /* Determinar el mensaje de error */
          select
            @w_mensaje = mensaje
          from   cobis..cl_errores
          where  numero = @w_return

          if @w_mensaje is null
            select
              @w_mensaje = 'NO EXISTE MENSAJE ASOCIADO'

          /* Grabar en la tabla de errores */
          insert cob_ahorros..re_error_batch
          values (@w_cta_banco,@w_mensaje)

          if @@error <> 0
          begin
            /* Error en grabacion de archivo de errores */
            exec cobis..sp_cerror
              @i_num = 203056
            /* Cerrar y liberar cursor */
            close cuentas
            deallocate cuentas
            select
              @o_procesadas = @w_procesadas
            return 203056
          end
          goto FETCH_REGISTRO
        end
      end
    end
    else
    -- El estado de cuenta se entrega al cliente (no se retiene en una agencia)
    begin
      select
        @w_causa = '3' -- Cargo envio estado de cuenta correo

      if @w_personalizada = 'N'
      begin
        select
          @w_tipo_atributo = tipo_atributo
        from   tempdb..pe_tipo_atributo
        where  filial       = @w_filial
           and sucursal     = @w_sucursal
           and producto     = 4
           and moneda       = @w_moneda
           and pro_bancario = @w_prod_banc
           and tipo_cta     = @w_tipocta
           and servicio     = 'EECT'
           and rubro        = '29' -- Costo por emision de estado de cuenta

        if @@rowcount <> 1
        begin
          /* Grabar en la tabla de errores */

          insert cob_ahorros..re_error_batch
          values (@w_cta_banco,'ERROR AL BUSCAR EL TIPO DE ATRIBUTO 29')

          if @@error <> 0
          begin
            /* Error en grabacion de archivo de errores */
            exec cobis..sp_cerror
              @i_num = 203056

            /* Cerrar y liberar cursor */
            close cuentas
            deallocate cuentas

            select
              @o_procesadas = @w_procesadas
            return 203056
          end

          goto FETCH_REGISTRO
        end

        if @w_tipo_atributo = 'B' /* Saldo promedio */
          select
            @w_monto = @w_promedio1
        else if @w_tipo_atributo = 'C' /* Saldo Contable */
          select
            @w_monto = @w_contable
        else if @w_tipo_atributo = 'A' /* Saldo Disponible */
          select
            @w_monto = @w_disponible
        else if @w_tipo_atributo = 'E' /* Promedio Disponible */
          select
            @w_monto = @w_prom_disponible
        else
          select
            @w_monto = $1

        select
          @w_valor_debitar = valor
        from   tempdb..eect4
        where  tipo_ente     = @w_tipocta
           and pro_bancario  = @w_prod_banc
           and filial        = @w_filial
           and sucursal      = @w_sucursal
           and producto      = 4
           and moneda        = @w_moneda
           and categoria     = @w_categoria
           and servicio_dis  = 'EECT'
           and rubro         = '29'
           and tipo_atributo = @w_tipo_atributo
           and rango_desde   <= @w_monto
           and rango_hasta   > @w_monto

        if @@rowcount <> 1
        begin
          print 'Procesando ...2'
          /* Grabar en la tabla de errores */
          insert cob_ahorros..re_error_batch
          values (@w_cta_banco,'ERROR EN TABLA TMP DE PERSONALIZACION EECT')

          if @@error <> 0
          begin
            /* Error en grabacion de archivo de errores */
            exec cobis..sp_cerror
              @i_num = 203056

            /* Cerrar y liberar cursor */
            close cuentas
            deallocate cuentas

            select
              @o_procesadas = @w_procesadas
            return 203056
          end

          goto FETCH_REGISTRO
        end
      end
      else
      begin
        /* Encuentra valor a debitar por envio de estado de cuenta */
        exec @w_return = cob_remesas..sp_genera_costos
          @t_debug       = 'N',
          @t_file        = null,
          @t_from        = @w_sp_name,
          @i_fecha       = @i_fecha,
          @i_valor       = 1,
          @i_categoria   = @w_categoria,
          @i_tipo_ente   = @w_tipocta,
          @i_rol_ente    = @w_rol_ente,
          @i_tipo_def    = @w_tipo_def,
          @i_prod_banc   = @w_prod_banc,
          @i_producto    = @w_producto,
          @i_moneda      = @w_moneda,
          @i_tipo        = @w_tipo,
          @i_codigo      = @w_default,
          @i_servicio    = 'EECT',
          @i_rubro       = '29',
          @i_disponible  = @w_disponible,
          @i_contable    = @w_contable,
          @i_promedio    = @w_promedio1,
          @i_prom_disp   = @w_prom_disponible,
          @i_personaliza = @w_personalizada,
          @i_filial      = @w_filial,
          @i_oficina     = @w_oficina,
          @o_valor_total = @w_valor_debitar out

        if @w_return <> 0
        begin
          print 'Procesando ...3'
          /* Determinar el mensaje de error */
          select
            @w_mensaje = mensaje
          from   cobis..cl_errores
          where  numero = @w_return

          if @w_mensaje is null
            select
              @w_mensaje = 'NO EXISTE MENSAJE ASOCIADO'

          /* Grabar en la tabla de errores */
          insert cob_ahorros..re_error_batch
          values (@w_cta_banco,@w_mensaje)

          if @@error <> 0
          begin
            /* Error en grabacion de archivo de errores */
            exec cobis..sp_cerror
              @i_num = 203056
            /* Cerrar y liberar cursor */
            close cuentas
            deallocate cuentas
            select
              @o_procesadas = @w_procesadas
            return 203056
          end
          goto FETCH_REGISTRO
        end
      end
    end

    print '===> El valor a debitar es : ' + cast (@w_valor_debitar as varchar)
    if @w_valor_debitar > 0
    begin
      begin tran
      /* Generar la nota de debito por envio de estado de cuenta */
      exec @w_return = cob_ahorros..sp_ahndc_automatica
        @s_srv        = @w_srv,
        @s_ofi        = @w_oficina,
        @s_ssn        = @w_ssn,
        @s_ssn_branch = @w_ssn,
        @t_trn        = 264,
        @i_cta        = @w_cta_banco,
        @i_val        = @w_valor_debitar,
        @i_cau        = @w_causa,
        @i_mon        = @w_moneda,
        @i_fecha      = @i_fecha,
        @i_imp        = 'S',
        @i_inmovi     = 'S'
      if @w_return <> 0
      begin
        print 'error en nota automatica'
        rollback tran
        /* Determinar el mensaje de error */
        select
          @w_mensaje = mensaje
        from   cobis..cl_errores
        where  numero = @w_return

        if @w_mensaje is null
          select
            @w_mensaje = 'NO EXISTE MENSAJE ASOCIADO'

        /* Grabar en la tabla de errores */
        insert cob_ahorros..re_error_batch
        values (@w_cta_banco,@w_mensaje)
        if @@error <> 0
        begin
          /* Error en grabacion de archivo de errores */
          exec cobis..sp_cerror
            @i_num = 203056
          /* Cerrar y liberar cursor */
          close cuentas
          deallocate cuentas
          select
            @o_procesadas = @w_procesadas
          return 203056
        end
        goto FETCH_REGISTRO
      end
      commit tran
    end

    FETCH_REGISTRO:
    /* Localizar el siguiente registro a emitir nd por envio est de cuenta */

    fetch cuentas into @w_cta_banco,
                       @w_cuenta,
                       @w_default,
                       @w_tipo_def,
                       @w_tipo_dir,
                       @w_rol_ente,
                       @w_categoria,
                       @w_personalizada,
                       @w_oficina,
                       @w_tipocta,
                       @w_prod_banc,
                       @w_producto,
                       @w_moneda,
                       @w_tipo,
                       @w_filial,
                       @w_contable,
                       @w_disponible,
                       @w_promedio1,
                       @w_prom_disponible

  end

  /* Cerrar y liberar cursor */
  close cuentas
  deallocate cuentas

  /* Retornar el numero de registros procesados */
  select
    @o_procesadas = @w_procesadas
  return 0

go

