use cob_ahorros
go

/************************************************************************/
/*      Archivo:                update_to_date_inicio_ah.sp             */
/*      Stored procedure:       sp_update_to_date_inicio_ah             */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:                                                   */
/*      Fecha de escritura:     10-Jul-2002                             */
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
/*      BATCH:  Cursor que permite inicializar los campos de cuentas    */
/*                de ahorros diariamente                                */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR                   RAZON                   */
/*   08/Dic/2005                          Emision Inicial               */
/*   27/Abr/2006      D.Vasquez           Cambio en Promedio1           */
/*   27/Ene/2010      C. Munoz           FRC-AHO-017-CobroComisiones    */
/*   02/Mayo/2016     Walther Toledo      Migración a CEN               */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_update_to_date_inicio_ah')
  drop proc sp_update_to_date_inicio_ah
go

create proc sp_update_to_date_inicio_ah
(
  @t_show_version bit = 0,
  @s_rol          smallint = null,
  @i_filial       tinyint,
  @i_fecha        smalldatetime,
  @i_turno        smallint = null,
  @s_srv          varchar(16),
  @o_procesadas   int out
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
    @w_rem_hoy              money,
    @w_valdp_tot            money,
    @w_actualiza            char(1),
    @w_rem_ayer             money,
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
    @w_new_cred_mes_ant     money

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_update_to_date_inicio_ah',
    @w_lote = 1000,
    @w_cta_banco = '0'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  select
    @o_procesadas = 0

  /* Cursor para ah_cuenta */
  declare update_to_date_batch cursor for
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
      ah_rem_hoy,
      ah_rem_ayer,
      /* FRC-AHO-017-CobroComisiones CMU 01/12/09*/
      ah_num_deb_mes,
      ah_num_cred_mes,
      ah_num_con_mes
    from   cob_ahorros..ah_cuenta
    where  ah_filial  = @i_filial
       and ah_oficina >= 0
    for read only

  open update_to_date_batch
  fetch update_to_date_batch into @w_cta_banco,
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
                                  @w_rem_hoy,
                                  @w_rem_ayer,
                                  /* FRC-AHO-017-CobroComisiones CMU 01/12/09*/
                                  @w_num_deb_mes,
                                  @w_num_cred_mes,
                                  @w_num_con_mes

  if @@fetch_status = -1
  begin
    close update_to_date_batch
    deallocate update_to_date_batch
    return 111111
  end
  else if @@fetch_status = -2
  begin
    close update_to_date_batch
    deallocate update_to_date_batch
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
      /* Respaldar promedios y contador de transaccines anteriores */
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
          @w_new_prom1 = @w_contable,
          @w_new_prom2 = @w_promedio1,
          @w_new_prom3 = @w_promedio2,
          @w_new_prom4 = @w_promedio3,
          @w_new_prom5 = @w_promedio4,
          @w_new_prom6 = @w_promedio5,
          @w_new_cred2 = @w_creditos,
          @w_new_cred3 = @w_credito2,
          @w_new_cred4 = @w_credito3,
          @w_new_cred5 = @w_credito4,
          @w_new_cred6 = @w_credito5,
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
             ah_12h = @w_12h,
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
             ah_monto_imp = @w_monto_imp,
             ah_disponible = @w_disponible,
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
             ah_rem_ayer = @w_rem_ayer + @w_rem_hoy,
             ah_rem_hoy = 0,
             /* FRC-AHO-017-CobroComisiones CMU 01/12/09*/
             ah_deb_mes_ant = @w_new_deb_mes_ant,
             ah_cred_mes_ant = @w_new_cred_mes_ant,
             ah_num_deb_mes_ant = @w_new_num_deb_mes_ant,
             ah_num_cred_mes_ant = @w_new_num_cred_mes_ant,
             ah_num_con_mes_ant = @w_new_num_con_mes_ant
      where  ah_cuenta = @w_cuenta

      select
        @w_procesadas = @w_procesadas + 1
      if @w_procesadas % @w_lote = 0
        commit tran

    end -- FIN: IF PARA ENCERAR ACUMULADORES

    LEER:

    /* Localizar el siguiente registro de cuenta sobregirada ocasionalmente */
    fetch update_to_date_batch into @w_cta_banco,
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
                                    @w_rem_hoy,
                                    @w_rem_ayer,
                                    /* FRC-AHO-017-CobroComisiones CMU 01/12/09*/
                                    @w_num_deb_mes,
                                    @w_num_cred_mes,
                                    @w_num_con_mes

    /* Validar el Status del Cursor */
    if @@fetch_status = -1
    begin
      print 'ERROR EN LECTURA DE CUENTAS DE AHORROS'
      rollback tran

      insert into re_error_batch
      values      ('0','ERROR EN LECTURA DE CUENTAS DE AHORROS')

      close update_to_date_batch
      deallocate update_to_date_batch
      select
        @w_procesadas
      return 251061
    end

  end

  commit tran

  /* Cerrar y liberar cursor */
  close update_to_date_batch
  deallocate update_to_date_batch

  select
    @o_procesadas = @w_procesadas
  return 0

go

