use cob_ahorros
go

/************************************************************************/
/*      Archivo:                ahupdtod.sp                             */
/*      Stored procedure:       sp_update_to_date_batch                 */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Julio Navarrete                         */
/*      Fecha de escritura:     29-Dic-1992                             */
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
/*      BATCH:  Cursor que permite la actualizacion de saldos para      */
/*              cuentas de ahorros                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      02/Ago/1995     J. Bucheli      Personalizacion Banco de la     */
/*                                      Produccion                      */
/*      13/May/1996     J. Bucheli      Optimizacion de cursores        */
/*                                      Feriados locales                */
/*      05/Feb/2004     G. White        Trimestres Ahorro Trad y Prog   */
/*      27/Mar/2004     G. White        Mensual para Ahorro Trad Juridi */
/*      09/Mar/2006     O. Velez        Round al disponible             */
/*      02/Mayo/2016    Walther Toledo  Migración a CEN                 */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_update_to_date_batch')
  drop proc sp_update_to_date_batch
go

create proc sp_update_to_date_batch
(
  @t_show_version bit = 0,
  @i_filial       tinyint = 1,
  @i_fecha        smalldatetime= null,
  @i_param1       datetime = null,-- Fecha de proceso
  @o_procesadas   int = null out
)
as
  declare
    @w_sp_name              varchar(64),
    @w_moneda               smallint,
    @w_cta_banco            cuenta,
    @w_valor_dep            money,
    @w_acum                 money,
    @w_sld_girar            money,
    @w_saldo_ayer           money,
    @w_contable             money,
    @w_disponible           money,
    @w_12h                  money,
    @w_12h_dif              money,
    @w_24h                  money,
    @w_mensaje              descripcion,
    @w_48h                  money,
    @w_remesas              money,
    @w_promedio1            money,
    @w_promedio2            money,
    @w_promedio3            money,
    @w_promedio4            money,
    @w_promedio5            money,
    @w_promedio6            money,
    @w_new_prom1            money,
    @w_new_prom2            money,
    @w_new_prom3            money,
    @w_new_prom4            money,
    @w_new_prom5            money,
    @w_new_prom6            money,
    @w_tipo_promedio        varchar(3),
    @w_fecha_ult_upd        datetime,
    @w_procesadas           int,
    @w_cuenta               int,
    @w_ciudad               int,
    @w_oficina              smallint,
    @w_creditos             money,
    @w_debitos              money,
    @w_contador_trx         int,
    @w_prom_disponible      money,
    @w_saldo_ult_corte      money,
    @w_aux_fecha            datetime,
    @w_estado               char(1),
    @w_creditos_hoy         money,
    @w_debitos_hoy          money,
    @w_ctaini               int,
    @w_ctafin               int,
    @w_error                int,
    @w_decimales            char(1),
    @w_numdeci              tinyint,
    @w_alicuota             float,
    @w_srv                  varchar(30),
    @w_msg_error            descripcion,
    @w_prod_banc            smallint,
    @w_tipocta              char(1),
    @w_interes              money,
    @w_mm                   char(2),
    @w_sql                  varchar(800),
    @w_columna              varchar(16),
    @w_min_dispmes          money,
    @w_monto_imp            money,
    @w_credito2             money,
    @w_credito3             money,
    @w_credito4             money,
    @w_credito5             money,
    @w_credito6             money,
    @w_debito2              money,
    @w_debito3              money,
    @w_debito4              money,
    @w_debito5              money,
    @w_debito6              money,
    @w_new_cred2            money,
    @w_new_cred3            money,
    @w_new_cred4            money,
    @w_new_cred5            money,
    @w_new_cred6            money,
    @w_new_deb2             money,
    @w_new_deb3             money,
    @w_new_deb4             money,
    @w_new_deb5             money,
    @w_new_deb6             money,
    @w_num_deb_mes          int,
    @w_num_cred_mes         int,
    @w_num_con_mes          int,
    @w_new_num_deb_mes      int,
    @w_new_num_cred_mes     int,
    @w_new_num_con_mes      int,
    @w_new_num_deb_mes_ant  int,
    @w_new_num_cred_mes_ant int,
    @w_new_num_con_mes_ant  int,
    @w_new_deb_mes_ant      money,
    @w_new_cred_mes_ant     money

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_update_to_date_batch'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  print ' Empieza el proceso'
  if @i_param1 is null
     and @i_fecha is null
  begin
    select
      @w_error = 101114,
      @w_msg_error = 'PARAMETRO FECHA ES OBLIGATORIO'
    goto ERROR
  end
  if @i_fecha is null
    select
      @i_fecha = @i_param1

  select
    @w_srv = nl_nombre
  from   cobis..ad_nodo_oficina
  where  nl_nodo = 1

  /* Inicializar el contador de cuentas procesadas */
  select
    @w_procesadas = 0

  /* Cursor para ah_cuenta */
  declare update_to_date_batch cursor for
    select
      ah_cta_banco,
      ah_prod_banc,
      ah_disponible,
      ah_12h,
      ah_12h_dif,
      ah_24h,
      ah_48h,
      ah_remesas,
      ah_tipo_promedio,
      ah_promedio1,
      ah_promedio2,
      ah_promedio3,
      ah_promedio4,
      ah_promedio5,
      ah_promedio6,
      ah_fecha_ult_upd,
      ah_cuenta,
      ah_oficina,
      ah_creditos,
      ah_debitos,
      ah_contador_trx,
      ah_prom_disponible,
      ah_saldo_ult_corte,
      ah_estado,
      ah_creditos_hoy,
      ah_debitos_hoy,
      ah_tipocta,
      ah_saldo_interes,
      ah_min_dispmes,
      ah_monto_imp,
      ah_creditos2,
      ah_creditos3,
      ah_creditos4,
      ah_creditos5,
      ah_creditos6,
      ah_debitos2,
      ah_debitos3,
      ah_debitos4,
      ah_debitos5,
      ah_debitos6,
      /* FRC-AHO-017-CobroComisiones CMU 01/12/09*/
      ah_num_deb_mes,
      ah_num_cred_mes,
      ah_num_con_mes
    from   cob_ahorros..ah_cuenta
    where  ah_filial = @i_filial
       and ah_cuenta > 0
/*****
and ah_cuenta >= @w_ctaini
and ah_cuenta <= @w_ctafin    Se quita el tema del paralelismo ****/
  /* Abrir el cursor para liquidacion de sobregiros */
  open update_to_date_batch

  /* Ubicar el primer registro para el cursor */
  fetch update_to_date_batch into @w_cta_banco,
                                  @w_prod_banc,
                                  @w_disponible,
                                  @w_12h,
                                  @w_12h_dif,
                                  @w_24h,
                                  @w_48h,
                                  @w_remesas,
                                  @w_tipo_promedio,
                                  @w_promedio1,
                                  @w_promedio2,
                                  @w_promedio3,
                                  @w_promedio4,
                                  @w_promedio5,
                                  @w_promedio6,
                                  @w_fecha_ult_upd,
                                  @w_cuenta,
                                  @w_oficina,
                                  @w_creditos,
                                  @w_debitos,
                                  @w_contador_trx,
                                  @w_prom_disponible,
                                  @w_saldo_ult_corte,
                                  @w_estado,
                                  @w_creditos_hoy,
                                  @w_debitos_hoy,
                                  @w_tipocta,
                                  @w_interes,
                                  @w_min_dispmes,
                                  @w_monto_imp,
                                  @w_credito2,
                                  @w_credito3,
                                  @w_credito4,
                                  @w_credito5,
                                  @w_credito6,
                                  @w_debito2,
                                  @w_debito3,
                                  @w_debito4,
                                  @w_debito5,
                                  @w_debito6,
                                  /* FRC-AHO-017-CobroComisiones CMU 01/12/09*/
                                  @w_num_deb_mes,
                                  @w_num_cred_mes,
                                  @w_num_con_mes

  /* Barrer todas las cuentas para actualizacion de saldos */
  if @@fetch_status = -1
  begin
    print 'No existen cuentas para procesar'
    close update_to_date_batch
    deallocate update_to_date_batch
    return 0
  end
  else if @@fetch_status = -2
  begin
    print 'Error fetch satatus  =-2 '
    close update_to_date_batch
    deallocate update_to_date_batch
    select
      @w_procesadas
    return 111111
  end

  while @@fetch_status = 0
  begin
    if @w_procesadas % 500 = 0
      begin tran

    /****************************/
    save tran TRN_POR_CUENTA
    /****************************/

    if @w_estado <> 'C'
        or (@w_estado = 'C'
            and (@w_creditos_hoy > 0
                  or @w_debitos_hoy > 0))
    begin
      /* Respaldar promedios anteriores */
      select
        @w_new_prom1 = @w_promedio1,
        @w_new_prom2 = @w_promedio2,
        @w_new_prom3 = @w_promedio3,
        @w_new_prom4 = @w_promedio4,
        @w_new_prom5 = @w_promedio5,
        @w_new_prom6 = @w_promedio6,
        @w_new_cred2 = @w_credito2,
        @w_new_cred3 = @w_credito3,
        @w_new_cred4 = @w_credito4,
        @w_new_cred5 = @w_credito5,
        @w_new_cred6 = @w_credito6,
        @w_new_deb2 = @w_debito2,
        @w_new_deb3 = @w_debito3,
        @w_new_deb4 = @w_debito4,
        @w_new_deb5 = @w_debito5,
        @w_new_deb6 = @w_debito6,
        @w_new_num_deb_mes = @w_num_deb_mes,
        @w_new_num_cred_mes = @w_num_cred_mes,
        @w_new_num_con_mes = @w_num_con_mes

      /* Calculo del contable */
      select
        @w_contable = @w_disponible + @w_12h + @w_24h
      select
        @w_saldo_ayer = @w_contable

      /* Actualizacion de los saldos promedios */
      select
        @w_aux_fecha = fp_fecha_inicio
      from   cob_ahorros..ah_fecha_periodo
      where  fp_numero_promedio = 1
         and fp_tipo_promedio   = @w_tipo_promedio

      if @w_fecha_ult_upd < @w_aux_fecha
      begin
        select
          @w_new_prom1 = @w_contable,
          @w_new_prom2 = @w_promedio1,
          @w_new_prom3 = @w_promedio2,
          @w_new_prom4 = @w_promedio3,
          @w_new_prom5 = @w_promedio4,
          @w_new_prom6 = @w_promedio5,
          @w_creditos = 0,
          @w_debitos = 0,
          @w_contador_trx = 0,
          @w_prom_disponible = @w_disponible,
          @w_monto_imp = 0,
          /* FRC-AHO-017-CobroComisiones CMU 01/12/09*/
          @w_num_deb_mes = 0,
          @w_num_cred_mes = 0,
          @w_num_con_mes = 0,
          @w_new_deb_mes_ant = @w_debitos,
          @w_new_cred_mes_ant = @w_creditos,
          @w_new_num_deb_mes_ant = @w_num_deb_mes,
          @w_new_num_cred_mes_ant = @w_num_cred_mes,
          @w_new_num_con_mes_ant = @w_num_con_mes

        if @w_min_dispmes <> -1
          select
            @w_min_dispmes = @w_disponible

        if exists (select
                     1
                   from   cob_ahorros..ah_exenta_gmf
                   where  eg_cuenta = @w_cuenta)
        begin
          select
            @w_mm = convert(varchar(2), substring(convert(varchar(12),
                                                  @w_aux_fecha,
                                                  101
                                                  ),
                                                  1,
                                                  2))
          select
            @w_columna = 'eg_mes_' + @w_mm

          select
            @w_sql = 'UPDATE cob_ahorros..ah_exenta_gmf SET ' + @w_columna +
                     ' = '
                     +
                     convert
                                                               (varchar
                                                               ( 20), 0.00)
                     + ' WHERE eg_cuenta = ' + convert(varchar(12), @w_cuenta)

          exec (@w_sql)

          if @@rowcount <> 1
              or @@error <> 0
          begin
            rollback tran TRN_POR_CUENTA
            print '1.Cuenta  : ' + convert(varchar(12), @w_cuenta)
            begin tran
            insert into cob_ahorros..re_error_batch
            values      (@w_cta_banco,'ERROR EN ACTUALIZACION DE CUENTA')
            if @@error <> 0
            begin
              /* Cerrar y liberar cursor */
              close update_to_date_batch
              deallocate update_to_date_batch
              select
                @o_procesadas = @w_procesadas,
                @w_error = 203035
              print 'Error 1.1 '
              goto ERROR
            end
            goto LEER
          end
        end

      end

    /* Determinar el valor en cheques locales a pasar a 12h de la */
      /* tabla ah_ciudad_deposito                                   */
      select
        @w_valor_dep = 0

      if @w_24h > 0
      begin
        select
          @w_valor_dep = isnull(sum(cd_valor_efe),
                                0)
        from   cob_ahorros..ah_ciudad_deposito
        where  cd_cuenta                   = @w_cuenta
           and cd_fecha_efe                = @i_fecha
           and isnull(cd_efectivizado,
                      'N') = 'N'

        print 'Cuenta ' + cast (@w_cuenta as varchar) + ' Deposito :' + cast (
              @w_valor_dep as
                                         varchar)

        if @w_valor_dep = 0
          select
            @w_valor_dep = 0
        else
        begin
          print 'Cuenta ' + cast ( @w_cuenta as varchar)
          print '                 Valor canje ' + cast ( @w_valor_dep as varchar
                )

          update cob_ahorros..ah_ciudad_deposito
          set    cd_efectivizado = 'S'
          where  cd_cuenta                   = @w_cuenta
             and cd_fecha_efe                = @i_fecha
             and isnull(cd_efectivizado,
                        'N') = 'N'

          if @@error <> 0
          begin
            rollback tran TRN_POR_CUENTA
            print '2.Cuenta  : ' + convert(varchar(12), @w_cuenta)
            begin tran
            insert into cob_ahorros..re_error_batch
            values      (@w_cta_banco,'ERROR EN ACTUALIZACION DE CUENTA')

            if @@error <> 0
            begin
              /* Cerrar y liberar cursor */
              close update_to_date_batch
              deallocate update_to_date_batch
              select
                @o_procesadas = @w_procesadas,
                @w_error = 203035
              print 'Error 1.2 '
              goto ERROR
            end
          end
        end
      end

      /* Actualizacion de los valores en retencion diaria */
      update cob_ahorros..ah_cuenta
      set    ah_fecha_ult_upd = @i_fecha,
             ah_12h = @w_12h + @w_valor_dep,
             ah_24h = @w_24h - @w_valor_dep,
             ah_saldo_ayer = @w_saldo_ayer,
             ah_promedio1 = @w_new_prom1,
             ah_promedio2 = @w_new_prom2,
             ah_promedio3 = @w_new_prom3,
             ah_promedio4 = @w_new_prom4,
             ah_promedio5 = @w_new_prom5,
             ah_promedio6 = @w_new_prom6,
             ah_creditos_hoy = 0,
             ah_debitos_hoy = 0,
             ah_creditos = @w_creditos,
             ah_debitos = @w_debitos,
             ah_num_deb_mes = @w_num_deb_mes,
             ah_num_cred_mes = @w_num_cred_mes,
             ah_num_con_mes = @w_num_con_mes,
             ah_contador_trx = @w_contador_trx,
             ah_prom_disponible = @w_prom_disponible,
             ah_saldo_ult_corte = @w_saldo_ult_corte,
             ah_saldo_interes = @w_interes,
             ah_min_dispmes = @w_min_dispmes,
             ah_disponible = round(ah_disponible,
                                   2),
             ah_monto_imp = @w_monto_imp,
             ah_creditos2 = @w_new_cred2,
             ah_creditos3 = @w_new_cred3,
             ah_creditos4 = @w_new_cred4,
             ah_creditos5 = @w_new_cred5,
             ah_creditos6 = @w_new_cred6,
             ah_debitos2 = @w_new_deb2,
             ah_debitos3 = @w_new_deb3,
             ah_debitos4 = @w_new_deb4,
             ah_debitos5 = @w_new_deb5,
             ah_debitos6 = @w_new_deb6,
             /* FRC-AHO-017-CobroComisiones CMU 01/12/09*/
             ah_deb_mes_ant = @w_new_deb_mes_ant,
             ah_cred_mes_ant = @w_new_cred_mes_ant,
             ah_num_deb_mes_ant = @w_new_num_deb_mes_ant,
             ah_num_cred_mes_ant = @w_new_num_cred_mes_ant,
             ah_num_con_mes_ant = @w_new_num_con_mes_ant
      where  ah_cuenta = @w_cuenta
      if @@rowcount <> 1
          or @@error <> 0
      begin
        rollback tran TRN_POR_CUENTA
        print '3.Cuenta  : ' + convert(varchar(12), @w_cuenta)
        begin tran
        insert into cob_ahorros..re_error_batch
        values      (@w_cta_banco,'ERROR EN ACTUALIZACION DE CUENTA')
        if @@error <> 0
        begin
          /* Cerrar y liberar cursor */
          close update_to_date_batch
          deallocate update_to_date_batch
          select
            @o_procesadas = @w_procesadas,
            @w_error = 203035
          print 'Error 1.3 '
          goto ERROR
        end
        goto LEER
      end /* Fin Error actualizacion*/

    end

    LEER:
    select
      @w_procesadas = @w_procesadas + 1
    if @w_procesadas % 500 = 0
       and @@trancount >= 1
      commit tran

    /* Localizar el siguiente registro de cuenta sobregirada ocasionalmente */
    fetch update_to_date_batch into @w_cta_banco,
                                    @w_prod_banc,
                                    @w_disponible,
                                    @w_12h,
                                    @w_12h_dif,
                                    @w_24h,
                                    @w_48h,
                                    @w_remesas,
                                    @w_tipo_promedio,
                                    @w_promedio1,
                                    @w_promedio2,
                                    @w_promedio3,
                                    @w_promedio4,
                                    @w_promedio5,
                                    @w_promedio6,
                                    @w_fecha_ult_upd,
                                    @w_cuenta,
                                    @w_oficina,
                                    @w_creditos,
                                    @w_debitos,
                                    @w_contador_trx,
                                    @w_prom_disponible,
                                    @w_saldo_ult_corte,
                                    @w_estado,
                                    @w_creditos_hoy,
                                    @w_debitos_hoy,
                                    @w_tipocta,
                                    @w_interes,
                                    @w_min_dispmes,
                                    @w_monto_imp,
                                    @w_credito2,
                                    @w_credito3,
                                    @w_credito4,
                                    @w_credito5,
                                    @w_credito6,
                                    @w_debito2,
                                    @w_debito3,
                                    @w_debito4,
                                    @w_debito5,
                                    @w_debito6,
                                    /* FRC-AHO-017-CobroComisiones CMU 01/12/09*/
                                    @w_num_deb_mes,
                                    @w_num_cred_mes,
                                    @w_num_con_mes

  /* Incrementar el numero de cuentas procesadas */
  end

  if @@trancount >= 1
    commit tran

  /* Cerrar y liberar cursor */
  close update_to_date_batch
  deallocate update_to_date_batch

  /* Retornar el numero de registros procesados */
  select
    @o_procesadas = @w_procesadas
  return 0

  ERROR:
  exec cobis..sp_cerror
    @i_num = @w_error,
    @i_msg = @w_msg_error
  return @w_error

go

