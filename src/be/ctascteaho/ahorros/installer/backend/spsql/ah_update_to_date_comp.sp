/*************************************************************************/
/*      Archivo:                ah_update_to_date_comp.sp                */
/*      Stored procedure:       sp_ah_update_to_date_comp                */
/*      Base de datos:          cob_ahorros                              */
/*      Producto:               Cuentas de Ahorros                       */
/*      Disenado por:           Jaime Hidalgo                            */
/*      Fecha de escritura:     10-Jul-2002                              */
/*************************************************************************/
/*                              IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de COBISCorp.                                                        */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/*************************************************************************/
/*                              PROPOSITO                                */
/*      BATCH:  Cursor que permite la efectivizacion de los cheques de   */
/*      bancos locales depositados en cuentas de ahorros                 */
/*************************************************************************/
/*                              MODIFICACIONES                           */
/*  FECHA       AUTOR           RAZON                                    */
/*  10/Jul/2002 Jaime Hidalgo   Emision Inicial                          */
/*                              Espec. Tec. ET-02-CR00011                */
/*                              Bco. Agromercantil                       */
/*  24/Mar/2005 M.Gaona         Tomar ssn de ba_secuencial               */
/*  27/Ene/2010 C. Munoz        FRC-AHO-017-CobroComisiones              */
/*  02/May/2016 Ignacio Yupa    Migración a CEN                          */
/*************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_update_to_date_comp')
  drop proc sp_ah_update_to_date_comp

go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_update_to_date_comp
(
  @t_show_version bit = 0,
  @s_rol          smallint = null,
  @i_filial       tinyint,
  @i_fecha        smalldatetime,
  @i_turno        smallint = null,
  @s_srv          varchar(16)
)
as
  declare
    @w_sp_name              varchar(64),
    @w_moneda               tinyint,
    @w_cta_banco            cuenta,
    @w_valor_dep            money,
    @w_acum                 money,
    @w_sld_girar            money,
    @w_saldo_ayer           money,
    @w_contable             money,
    @w_disponible           money,
    @w_12h                  money,
    @w_12h_dif              money,
    @w_12h_neto             money,
    @w_24h                  money,
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
    @w_min_dispmes          money,
    @w_estado               char(1),
    @w_creditos_hoy         money,
    @w_debitos_hoy          money,
    @w_tasa_hoy             real,
    @w_monto_imp            money,
    @w_ssn                  int,
    @w_filial               tinyint,
    @w_mensaje              descripcion,
    @w_prod_banc            smallint,
    @w_oficina_ini          smallint,
    @w_oficina_fin          smallint,
    @w_categoria            char(1),
    @w_decimales            char(1),
    @w_numdeci              tinyint,
    @w_alicuota             float,
    @w_cod_alterno          int,
    @w_lote                 int,
    @w_error                int,
    @w_oficina_cd           smallint,
    @w_valor_cd             money,
    @w_tipocta_super        char(1),
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
    @w_new_cre2             money,
    @w_new_cre3             money,
    @w_new_cre4             money,
    @w_new_cre5             money,
    @w_new_cre6             money,
    @w_new_deb2             money,
    @w_new_deb3             money,
    @w_new_deb4             money,
    @w_new_deb5             money,
    @w_new_deb6             money,
    /* FRC-AHO-017-CobroComisiones CMU 01/12/09*/
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
    @w_new_cred_mes_ant     money,
    @w_login_ope            varchar(10)

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_ah_update_to_date_comp',
    @w_lote = 1000
  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end
  /* Lectura para login operador batch*/
  select
    @w_login_ope = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'LOB'
     and pa_producto = 'ADM'

  /* Obtener Alicuota para el Promedio */
  select
    @w_tipo_promedio = 'M'
  select
    @w_alicuota = fp_alicuota
  from   cob_ahorros..ah_fecha_promedio
  where  fp_tipo_promedio = @w_tipo_promedio
     and fp_fecha_inicio  = @i_fecha
  if @@rowcount = 0
  begin
    select
      @w_mensaje = mensaje
    from   cobis..cl_errores
    where  numero = 251013
    if @w_mensaje is null
      select
        @w_mensaje = 'NO HAY MENSAJE ASOCIADO'

    insert into cob_ahorros..re_error_batch
    values      (@w_cta_banco,@w_mensaje)
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @i_num = 203035
      close ah_update_to_date_comp
      deallocate ah_update_to_date_comp
      return 203035
    end
    return 203035
  end

  /*** Obtener Decimales de la Moneda ***/
  select
    @w_moneda = 0
  select
    @w_decimales = mo_decimales
  from   cobis..cl_moneda
  where  mo_moneda = @w_moneda
  if @w_decimales = 'S'
    select
      @w_numdeci = isnull(pa_tinyint,
                          0)
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'DCI'
  else
    select
      @w_numdeci = 0

  --MGA 24-MAR-05
  --/* Inicializar el SSN */
  --select @w_ssn = max(ts_secuencial)
  --from cob_ahorros..ah_tran_servicio
  --where ts_secuencial < 0
  --if @w_ssn is null
  --  select @w_ssn = -10000000
  --select @w_ssn = @w_ssn + (@i_rango * 1000000)

  begin tran

  /* Encuentra el SSN inicial */

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
    /* Error en actualizacion de SSN */
    exec cobis..sp_cerror
      @i_num = 205031
    return 205031
  end

  commit tran

  select
    @w_procesadas = 0

  if @i_turno is null
    select
      @i_turno = @s_rol

  /* Cursor para ah_cuenta */
  declare ah_update_to_date_comp cursor for
    select
      ah_cta_banco,
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
      ah_min_dispmes,
      ah_estado,
      ah_creditos_hoy,
      ah_debitos_hoy,
      ah_tasa_hoy,
      ah_monto_imp,
      ah_moneda,
      ah_categoria,
      ah_prod_banc,
      ah_filial,
      ah_tipocta_super,
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
    for read only

  open ah_update_to_date_comp
  fetch ah_update_to_date_comp into @w_cta_banco,
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
                                    @w_min_dispmes,
                                    @w_estado,
                                    @w_creditos_hoy,
                                    @w_debitos_hoy,
                                    @w_tasa_hoy,
                                    @w_monto_imp,
                                    @w_moneda,
                                    @w_categoria,
                                    @w_prod_banc,
                                    @w_filial,
                                    @w_tipocta_super,
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

  if @@fetch_status = -1
  begin
    close ah_update_to_date_comp
    deallocate ah_update_to_date_comp
    return 111111 --FES 10/06/2003 notificaciÃ³n por E:SP-GEN-05
  end
  else if @@fetch_status = -2
  begin
    close ah_update_to_date_comp
    deallocate ah_update_to_date_comp
    return 0
  end

  while @@fetch_status = 0
  begin
    /* SE DEBE ENCERAR LOS ACUMULADORES PARA LAS CUENTAS CERRADAS */
    if @w_estado <> 'C'
        or (@w_estado = 'C'
            and (@w_creditos_hoy > 0
                  or @w_debitos_hoy > 0))
    begin
      /* Efectivizacion 12h */
      select
        @w_valor_dep = sum(cd_valor_efe)
      from   cob_ahorros..ah_ciudad_deposito
      where  cd_cuenta       = @w_cuenta
         and cd_fecha_efe    = @i_fecha
         and (cd_efectivizado = 'N'
               or cd_efectivizado is null)

      if @w_valor_dep is null
        select
          @w_valor_dep = 0

      if @w_valor_dep > @w_12h
      begin
        select
          @w_mensaje =
          'NO SE PUEDE EFECTIVIZAR. VALOR EN CIUDAD_DEPOSITO ES MAYOR A 12H'
        insert cob_ahorros..re_error_batch
        values (@w_cta_banco,@w_mensaje)

        if @@error <> 0
        begin
          close ah_update_to_date_comp
          deallocate ah_update_to_date_comp
          select
            @w_procesadas
          return 205055
        end
        goto LEER
      end
      --          else
      --      select @w_valor_dep = @w_12h

      /* Respaldar promedios anteriores */
      select
        @w_new_prom1 = @w_promedio1,
        @w_new_prom2 = @w_promedio2,
        @w_new_prom3 = @w_promedio3,
        @w_new_prom4 = @w_promedio4,
        @w_new_prom5 = @w_promedio5,
        @w_new_prom6 = @w_promedio6,
        @w_new_cre2 = @w_credito2,
        @w_new_cre3 = @w_credito3,
        @w_new_cre4 = @w_credito4,
        @w_new_cre5 = @w_credito5,
        @w_new_cre6 = @w_credito6,
        @w_new_deb2 = @w_debito2,
        @w_new_deb3 = @w_debito3,
        @w_new_deb4 = @w_debito4,
        @w_new_deb5 = @w_debito5,
        @w_new_deb6 = @w_debito6,
        /* FRC-AHO-017-CobroComisiones CMU 01/12/09*/
        @w_new_num_deb_mes = @w_num_deb_mes,
        @w_new_num_cred_mes = @w_num_cred_mes,
        @w_new_num_con_mes = @w_num_con_mes

      /* Calculo del contable */
      select
        @w_contable = @w_disponible + @w_12h + @w_24h + @w_48h + @w_remesas
      select
        @w_saldo_ayer = @w_contable

      /* Actualizacion de los saldos promedios */
      if @w_fecha_ult_upd < (select
                               fp_fecha_inicio
                             from   cob_ahorros..ah_fecha_periodo
                             where  fp_numero_promedio = 1
                                and fp_tipo_promedio   = @w_tipo_promedio)
      begin
        select
          @w_new_prom1 = @w_prom_disponible,--@w_contable,
          @w_new_prom2 = @w_promedio1,
          @w_new_prom3 = @w_promedio2,
          @w_new_prom4 = @w_promedio3,
          @w_new_prom5 = @w_promedio4,
          @w_new_prom6 = @w_promedio5,
          @w_new_cre2 = @w_creditos,
          @w_new_cre3 = @w_credito2,
          @w_new_cre4 = @w_credito3,
          @w_new_cre5 = @w_credito3,
          @w_new_cre6 = @w_credito4,
          @w_new_deb2 = @w_debitos,
          @w_new_deb3 = @w_debito2,
          @w_new_deb4 = @w_debito3,
          @w_new_deb5 = @w_debito4,
          @w_new_deb6 = @w_debito5,
          @w_creditos = 0,
          @w_debitos = 0,
          @w_contador_trx = 0,
          @w_prom_disponible = @w_disponible,
          @w_saldo_ult_corte = @w_contable,
          @w_monto_imp = 0,
          /* FRC-AHO-017-CobroComisiones CMU 01/12/09*/
          @w_new_deb_mes_ant = @w_debitos,
          @w_new_cred_mes_ant = @w_creditos,
          @w_new_num_deb_mes_ant = @w_num_deb_mes,
          @w_new_num_cred_mes_ant = @w_num_cred_mes,
          @w_new_num_con_mes_ant = @w_num_con_mes

        if @w_min_dispmes <> -1
          select
            @w_min_dispmes = @w_disponible
      end

      if @w_procesadas % @w_lote = 0
        begin tran

      update cob_ahorros..ah_cuenta
      set    ah_fecha_ult_upd = @i_fecha,
             ah_12h = @w_12h - @w_valor_dep,
             ah_12h_dif = @w_12h_dif,
             ah_24h = @w_24h,
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
             ah_contador_trx = @w_contador_trx,
             ah_prom_disponible = @w_prom_disponible,
             ah_saldo_ult_corte = @w_saldo_ult_corte,
             ah_min_dispmes = @w_min_dispmes,
             ah_tasa_hoy = 0,
             ah_monto_imp = @w_monto_imp,
             ah_disponible = @w_disponible + @w_valor_dep,
             ah_creditos2 = @w_new_cre2,
             ah_creditos3 = @w_new_cre3,
             ah_creditos4 = @w_new_cre4,
             ah_creditos5 = @w_new_cre5,
             ah_creditos6 = @w_new_cre6,
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
      begin
        rollback tran
        select
          @w_mensaje = 'ERROR EN ACTUALIZACION DE CUENTA'
        insert cob_ahorros..re_error_batch
        values (@w_cta_banco,@w_mensaje)
        if @@error <> 0
        begin
          close update_to_date_comp
          deallocate update_to_date_comp
          select
            @w_procesadas
          return 205001
        end
        goto LEER
      end

      /* Actualizacion de ah_ciudad_deposito */
      update cob_ahorros..ah_ciudad_deposito
      set    cd_efectivizado = 'S',
             cd_valor_efe = 0
      where  cd_cuenta    = @w_cuenta
         and cd_fecha_efe = @i_fecha

      if @@error <> 0
      begin
        rollback tran
        select
          @w_mensaje = 'ERROR EN ACTUALIZACION DE CIUDAD DEPOSITO'
        insert cob_ahorros..re_error_batch
        values (@w_cta_banco,@w_mensaje)
        if @@error <> 0
        begin
          close update_to_date_comp
          deallocate update_to_date_comp
          select
            @w_procesadas
          return 205052
        end
        goto LEER
      end

      declare ciu_dep cursor for
        select
          cd_valor_efe,
          isnull ((select
                     min(of_oficina)
                   from   cobis..cl_oficina
                   where  of_oficina >= 100
                      and of_ciudad  = X.cd_ciudad),
                  1)
        from   cob_ahorros..ah_ciudad_deposito X
        where  cd_cuenta    = @w_cuenta
           and cd_fecha_efe = @i_fecha
           and cd_valor_efe > 0
        for read only

      open ciu_dep

      fetch ciu_dep into @w_valor_cd, @w_oficina_cd

      if @@fetch_status = -1
      begin
        rollback tran
        close ciu_dep
        deallocate ciu_dep
        select
          @w_mensaje = 'ERROR EN LECTURA DE CIUDAD DEPOSITO'
        insert into cob_ahorros..re_error_batch
        values      (@w_cta_banco,@w_mensaje)
        if @@error <> 0
        begin
          exec cobis..sp_cerror
            @i_num = 203035

          /* Cerrar y liberar cursor */
          close ah_update_to_date_comp
          deallocate ah_update_to_date_comp
          return 203035
        end
        goto LEER
      end

      select
        @w_cod_alterno = 1

      while @@fetch_status = 0
      begin
        select
          @w_ssn = @w_ssn + 1

        insert into cob_ahorros..ah_tran_servicio
                    (ts_secuencial,ts_ssn_branch,ts_cod_alterno,
                     ts_tipo_transaccion,
                     ts_tsfecha,
                     ts_usuario,ts_terminal,ts_filial,ts_hora,ts_nodo,
                     ts_oficina,ts_reentry,ts_origen,ts_cta_banco,ts_valor,
                     ts_moneda,ts_oficina_cta,ts_prod_banc,ts_categoria,
                     ts_tipocta_super
                     ,
                     ts_turno)
        values      (@w_ssn,@w_ssn,@w_cod_alterno,219,@i_fecha,
                     @w_login_ope,'consola',@w_filial,getdate(),@s_srv,
                     @w_oficina_cd,'N','U',@w_cta_banco,@w_valor_cd,
                     @w_moneda,@w_oficina,@w_prod_banc,@w_categoria,
                     @w_tipocta_super
                     ,
                     @i_turno)

        if @@error <> 0
        begin
          rollback tran
          select
            @w_mensaje = 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO'
          insert into cob_ahorros..re_error_batch
          values      (@w_cta_banco,@w_mensaje)
          if @@error <> 0
          begin
            exec cobis..sp_cerror
              @i_num = 203035

            /* Cerrar y liberar cursor */
            close ah_update_to_date_comp
            deallocate ah_update_to_date_comp
            return 203035
          end
          goto LEER
        end

        select
          @w_cod_alterno = @w_cod_alterno + 1

        fetch ciu_dep into @w_valor_cd, @w_oficina_cd

        if @@fetch_status = -1
        begin
          rollback tran
          close ciu_dep
          deallocate ciu_dep
          select
            @w_mensaje = 'ERROR EN LECTURA DE CIUDAD DEPOSITO'
          insert into cob_ahorros..re_error_batch
          values      (@w_cta_banco,@w_mensaje)
          if @@error <> 0
          begin
            exec cobis..sp_cerror
              @i_num = 203035

            /* Cerrar y liberar cursor */
            close ah_update_to_date_comp
            deallocate ah_update_to_date_comp
            return 203035
          end
          goto LEER
        end
      end -- FIN DEL CURSOR

      /* Cerrar y liberar cursor */
      close ciu_dep
      deallocate ciu_dep

      select
        @w_procesadas = @w_procesadas + 1
      if @w_procesadas % @w_lote = 0
        commit tran

    end -- FIN: IF PARA ENCERAR ACUMULADORES

    LEER:

    /* Localizar el siguiente registro de cuenta sobregirada ocasionalmente */
    fetch ah_update_to_date_comp into @w_cta_banco,
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
                                      @w_min_dispmes,
                                      @w_estado,
                                      @w_creditos_hoy,
                                      @w_debitos_hoy,
                                      @w_tasa_hoy,
                                      @w_monto_imp,
                                      @w_moneda,
                                      @w_categoria,
                                      @w_prod_banc,
                                      @w_filial,
                                      @w_tipocta_super,
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

    /* Validar el Status del Cursor */
    if @@fetch_status = -1
    begin
      print 'ERROR EN LECTURA DE CUENTAS DE AHORROS'
      rollback tran

      insert into cob_ahorros..re_error_batch
      values      ('0','ERROR EN LECTURA DE CUENTAS DE AHORROS')

      close ah_update_to_date_comp
      deallocate ah_update_to_date_comp
      select
        @w_procesadas
      return 251061
    end

  end

  commit tran

  /* Cerrar y liberar cursor */
  close ah_update_to_date_comp
  deallocate ah_update_to_date_comp

  select
    @w_procesadas
  return 0

go

