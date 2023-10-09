/**************************************************************************/
/*   Archivo:             ah_conso_td.sp                                  */
/*   Stored procedure:    sp_consolida_dato_td                            */
/*   Base de datos:       cob_ahorros                                     */
/*   Producto:            ahorros                                         */
/*   Disenado por:                                                        */
/*   Fecha de escritura:  ENE/2015                                        */
--/************************************************************************/
/*                              IMPORTANTE                                */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*   de COBISCorp.                                                        */
/*   Su uso no autorizado queda expresamente prohibido asi como           */
/*   cualquier alteracion o agregado  hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.      */
/*   Este programa esta protegido por la ley de derechos de autor         */
/*   y por las convenciones  internacionales   de  propiedad inte-        */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para     */
/*   obtener ordenes  de secuestro o retencion y para  perseguir          */
/*   penalmente a los autores de cualquier infraccion.                    */
/**************************************************************************/
/*                              PROPOSITO                                 */
/*   Consolida información para posterior paso a repositorio              */
/**************************************************************************/
/*                               MODIFICACIONES                           */
/*  FECHA              AUTOR          CAMBIO                              */
/*  01/ENE/2015      LIANA COTO  EMISION INICIAL                          */
/*                               REQ486-PASO A REPOSITOSIO TARJETA DEBITO */
/*  02/May/2016      J. Calderon Migración a CEN                          */
/**************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_consolida_dato_td')
  drop proc sp_consolida_dato_td
go

create proc sp_consolida_dato_td
(
  @t_show_version bit = 0,
  @i_param1       datetime --Fecha de Proceso
)
as
  declare
    @w_fecha_proc        datetime,
    @w_mtv_can           int,
    @w_tabla_est_aho     int,
    @w_sp_name           varchar(30),
    @w_error             int,
    @w_mensaje           varchar(250),
    @w_msg               varchar(250),
    @w_fecha_maestro_tar datetime

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_consolida_dato_td'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  --OBTENIENDO FECHA DE PROCESO
  select
    @w_fecha_proc = @i_param1
  --FAVOR INGRESAR LA FECHA DE PROCESO A TOMAR EN CUENTA

  if @w_fecha_proc is null
  begin
    select
      @w_fecha_proc = fp_fecha
    from   cobis..ba_fecha_proceso

    if @@error <> 0
    begin
      select
        @w_msg = 'ERROR AL OBTENER FECHA DE PROCESO',
        @w_error = 103118
      goto ERRORFIN
    end
  end

  --LIMPIANDO TABLA
  delete from cob_externos..ex_datcon_tarjdeb

  --OBTENIENDO CODIGO DE CATALOGO DE ESTADO DE LA CUENTA DE AHORRO
  select
    @w_tabla_est_aho = codigo
  from   cobis..cl_tabla
  where  tabla = 'ah_estado_cta'

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL OBTENER CODIGO DE CATALOGO ',
      @w_error = 103118
    goto ERRORFIN
  end

  --OBTENIENDO UNIVERSO A VALIDAR
  select distinct
    dt_fecha_corte = convert(varchar(10), @w_fecha_proc, 101),
    dt_ente = rc_cliente,
    dt_banco = rc_cuenta,
    dt_ofi_asoc = ts_oficina,
    dt_funcionario = (select
                        fu_funcionario
                      from   cobis..cl_funcionario
                      where  fu_login = rc_usuario),
    dt_tipo_cta = (select
                     pb_descripcion
                   from   cob_remesas..pe_pro_bancario
                   where  pb_pro_bancario = ah.ah_prod_banc),
    dt_num_tarjdeb = rc_tarj_debito,
    dt_estado_tarjdeb = (case rc_estado
                           when 'V' then 'VIGENTE'
                           else 'ELIMINADA'
                         end),
    dt_est_cta = (select
                    valor
                  from   cobis..cl_catalogo
                  where  tabla  = @w_tabla_est_aho
                     and codigo = ah.ah_estado),
    dt_fecha_asigna = convert(datetime, rc_fecha, 101),
    dt_fecha_ini_pos = convert(datetime, null, 101),
    dt_fecha_ini_atm = convert(datetime, null, 101),
    dt_fecha_fin_pos = convert(datetime, null, 101),
    dt_fecha_fin_atm = convert(datetime, null, 101),
    dt_fecha_fin_ofi = convert(datetime, null, 101),
    dt_fecha_ven_tarjdeb = convert(datetime, null, 101),
    dt_fin_monto_pos = convert(money, 0),
    dt_fin_monto_atm = convert(money, 0),
    dt_motivo_canc_tarjdeb = convert(varchar(50), null)
  into   #datcon_td
  from   cob_remesas..re_relacion_cta_canal as rc,
         cob_ahorros..ah_cuenta_tmp as ah,
         cob_remesas..re_tran_servicio as ts
  where  rc_cuenta           = ah_cta_banco
     and rc_canal            = 'TAR'
     and rc_tarj_debito      = ts_varchar5
     and ts_tipo_transaccion <> 746

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL OBTENER UNIVERSO A VALIDAR',
      @w_error = 103118
    goto ERRORFIN
  end

  --SELECCIONANDO ESTRUCTURA
  select
    *
  into   #ws_tran_servicio
  from   cobis..ws_tran_servicio
  where  1 = 2

  --LIMPIANDO TABLA
  delete from #ws_tran_servicio

  if @@error <> 0
  begin
    print 'ERROR AL ELIMINAR INFORMACION DE TABLA TEMPORAL'
    goto ERRORFIN
  end

  --OBTENIENDO INFROMACIÓN BASE PARA UNIVERSO
  insert into #ws_tran_servicio
              (ts_ssn,ts_usuario,ts_terminal,ts_oficina,ts_fecha,
               ts_hora,ts_tipo_tran,ts_estado,ts_correccion,ts_sec_corr,
               ts_sec_ext,ts_hora_est,ts_codcorr,ts_monto,ts_num_tarjeta,
               ts_prod_orig,ts_banco_orig,ts_prod_dest,ts_banco_dest,ts_convenio
               ,
               ts_banco,ts_gcomision,ts_comision,ts_campo1,
               ts_campo2,
               ts_campo3,ts_campo4,ts_campo5,ts_campo6,ts_campo7,
               ts_campo8,ts_campo9,ts_campo10,ts_valor1,ts_valor2,
               ts_valor3,ts_valor4,ts_valor5,ts_valor6,ts_valor7,
               ts_valor8,ts_valor9,ts_valor10,ts_retorno,ts_conciliado,
               ts_fecha_conc,ts_adquiriente,ts_cod_alterno,ts_login_ext,ts_canal
               ,
               ts_autorizacion,ts_ref_numerica1,ts_ref_numerica2
               ,ts_ref_numerica3,
               ts_ref_numerica4,
               ts_ref_numerica5,ts_ref_texto1,ts_ref_texto2,ts_ref_texto3,
               ts_ref_texto4,
               ts_ref_texto5,ts_ref_monetaria1,ts_ref_monetaria2,
               ts_ref_monetaria3
               ,ts_ref_monetaria4,
               ts_ref_monetaria5)
    select
      ts_ssn,ts_usuario,ts_terminal,ts_oficina,ts_fecha,
      ts_hora,ts_tipo_tran,ts_estado,ts_correccion,ts_sec_corr,
      ts_sec_ext,ts_hora_est,ts_codcorr,ts_monto,ts_num_tarjeta,
      ts_prod_orig,ts_banco_orig,ts_prod_dest,ts_banco_dest,ts_convenio,
      ts_banco,ts_gcomision,ts_comision,ts_campo1,ts_campo2,
      ts_campo3,ts_campo4,ts_campo5,ts_campo6,ts_campo7,
      ts_campo8,ts_campo9,ts_campo10,ts_valor1,ts_valor2,
      ts_valor3,ts_valor4,ts_valor5,ts_valor6,ts_valor7,
      ts_valor8,ts_valor9,ts_valor10,ts_retorno,ts_conciliado,
      ts_fecha_conc,ts_adquiriente,ts_cod_alterno,ts_login_ext,ts_canal,
      ts_autorizacion,ts_ref_numerica1,ts_ref_numerica2,ts_ref_numerica3,
      ts_ref_numerica4,
      ts_ref_numerica5,ts_ref_texto1,ts_ref_texto2,ts_ref_texto3,ts_ref_texto4,
      ts_ref_texto5,ts_ref_monetaria1,ts_ref_monetaria2,ts_ref_monetaria3,
      ts_ref_monetaria4,
      ts_ref_monetaria5
    from   cobis..ws_tran_servicio,
           #datcon_td
    where  ts_banco_orig = dt_banco
       and ts_tipo_tran not in (744, 749, 26500, 26518)
       and ts_canal in (3, 8)

  if @@error <> 0
  begin
    print 'ERROR AL INSERTAR DESDE WS_TRAN_SERVICIO'
    goto ERRORFIN
  end

  insert into #ws_tran_servicio
              (ts_ssn,ts_usuario,ts_terminal,ts_oficina,ts_fecha,
               ts_hora,ts_tipo_tran,ts_estado,ts_correccion,ts_sec_corr,
               ts_sec_ext,ts_hora_est,ts_codcorr,ts_monto,ts_num_tarjeta,
               ts_prod_orig,ts_banco_orig,ts_prod_dest,ts_banco_dest,ts_convenio
               ,
               ts_banco,ts_gcomision,ts_comision,ts_campo1,
               ts_campo2,
               ts_campo3,ts_campo4,ts_campo5,ts_campo6,ts_campo7,
               ts_campo8,ts_campo9,ts_campo10,ts_valor1,ts_valor2,
               ts_valor3,ts_valor4,ts_valor5,ts_valor6,ts_valor7,
               ts_valor8,ts_valor9,ts_valor10,ts_retorno,ts_conciliado,
               ts_fecha_conc,ts_adquiriente,ts_cod_alterno,ts_login_ext,ts_canal
               ,
               ts_autorizacion,ts_ref_numerica1,ts_ref_numerica2
               ,ts_ref_numerica3,
               ts_ref_numerica4,
               ts_ref_numerica5,ts_ref_texto1,ts_ref_texto2,ts_ref_texto3,
               ts_ref_texto4,
               ts_ref_texto5,ts_ref_monetaria1,ts_ref_monetaria2,
               ts_ref_monetaria3
               ,ts_ref_monetaria4,
               ts_ref_monetaria5)
    select
      tsh_ssn,tsh_usuario,tsh_terminal,tsh_oficina,tsh_fecha,
      tsh_hora,tsh_tipo_tran,tsh_estado,tsh_correccion,tsh_sec_corr,
      tsh_sec_ext,tsh_hora_est,tsh_codcorr,tsh_monto,tsh_num_tarjeta,
      tsh_prod_orig,tsh_banco_orig,tsh_prod_dest,tsh_banco_dest,tsh_convenio,
      tsh_banco,tsh_gcomision,tsh_comision,tsh_campo1,tsh_campo2,
      tsh_campo3,tsh_campo4,tsh_campo5,tsh_campo6,tsh_campo7,
      tsh_campo8,tsh_campo9,tsh_campo10,tsh_valor1,tsh_valor2,
      tsh_valor3,tsh_valor4,tsh_valor5,tsh_valor6,tsh_valor7,
      tsh_valor8,tsh_valor9,tsh_valor10,tsh_retorno,tsh_conciliado,
      tsh_fecha_conc,tsh_adquiriente,tsh_cod_alterno,tsh_login_ext,tsh_canal,
      tsh_autorizacion,tsh_ref_numerica1,tsh_ref_numerica2,tsh_ref_numerica3,
      tsh_ref_numerica4,
      tsh_ref_numerica5,tsh_ref_texto1,tsh_ref_texto2,tsh_ref_texto3,
      tsh_ref_texto4,
      tsh_ref_texto5,tsh_ref_monetaria1,tsh_ref_monetaria2,tsh_ref_monetaria3,
      tsh_ref_monetaria4,
      tsh_ref_monetaria5
    from   cobis..ws_tran_servicio_his,
           #datcon_td
    where  tsh_banco_orig = dt_banco
       and tsh_tipo_tran not in (744, 749, 26500, 26518)
       and tsh_canal in (3, 8)

  if @@error <> 0
  begin
    print 'ERROR AL INSERTAR DESDE WS_TRAN_SERVICIO_HIS'
    goto ERRORFIN
  end

  --OBTENIENDO DATOS PARA FECHAS DE POS Y ATM
  --MOVIMIENTOS DE TRES MESES HACIA ACA
  select distinct
    ps_cta_banco = ts_banco_orig,
    ps_canal = ts_canal,
    pc_hora = ts_hora,
    pc_fecha = ts_fecha,
    pc_estado = ts_estado,
    pc_sec_corr = ts_sec_ext,
    ts_tipo_tran = ts_tipo_tran
  into   #PrimerCanales
  from   #ws_tran_servicio,
         #datcon_td
  where  ts_banco_orig = dt_banco
     and ts_estado     = 'A'

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR EN TABLA #PRIMERCANALES',
      @w_error = 103118
    goto ERRORFIN
  end

  select distinct
    ps_cta_banco = ts_banco_orig,
    ps_canal = ts_canal,
    pc_hora = ts_hora,
    pc_fecha = ts_fecha,
    pc_estado = ts_estado,
    pc_sec_corr = ts_sec_ext
  into   #PrimerCanales1
  from   #ws_tran_servicio,
         #datcon_td
  where  ts_banco_orig = dt_banco
     and ts_estado     = 'R'

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR EN TABLA #PRIMERCANALES1',
      @w_error = 103118
    goto ERRORFIN
  end

  --OBTENIENDO DATOS A EXCLUIR
  select
    a.*
  into   #repetidos
  from   #PrimerCanales b,
         #PrimerCanales1 a
  where  b.pc_sec_corr  = a.pc_sec_corr
     and b.ps_cta_banco = b.ps_cta_banco

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR TRANSACCIONES REVERSADAS',
      @w_error = 103118
    goto ERRORFIN
  end

  --EXCLUYENDO TRANSACCIONES QUE HAN SUFIRDO REVERSOS
  delete from #PrimerCanales
  where  ps_cta_banco in
         (select
            a.ps_cta_banco
          from   #repetidos a)
         and pc_sec_corr in
             (select
                a.pc_sec_corr
              from   #repetidos a)
         and pc_hora in
             (select
                a.pc_hora
              from   #repetidos a)

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL ELIMINAR TRANSACCIONES REVERSADAS',
      @w_error = 103118
    goto ERRORFIN
  end

  --OBTENIENDO DATOS A VALIDAR
  select distinct
    ps_cta_banco = ps_cta_banco,
    ps_canal = ps_canal,
    pc_fecha = min(pc_hora)
  into   #min_fech
  from   #PrimerCanales
  group  by ps_cta_banco,
            ps_canal

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR EN TABLA #MIN_FECH',
      @w_error = 103118
    goto ERRORFIN
  end

  --ACTUALIZANDO PRIMERA FECHA POS
  update #datcon_td
  set    dt_fecha_ini_pos = pc_fecha
  from   #min_fech,
         #datcon_td a
  where  ps_cta_banco = a.dt_banco
     and ps_canal     = 8

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL ACTUALIZAR #DATCON_TD PARA POS',
      @w_error = 103118
    goto ERRORFIN
  end

  --ACTUALIZANDO PRIMERA FECHA ATM
  update #datcon_td
  set    dt_fecha_ini_atm = pc_fecha
  from   #min_fech,
         #datcon_td a
  where  ps_cta_banco = a.dt_banco
     and ps_canal     = 3

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL ACTUALIZAR #DATCON_TD PARA ATM',
      @w_error = 103118
    goto ERRORFIN
  end

  --OBTENIENDO ULTIMA FECHA POS Y ATM
  select distinct
    ps_cta_banco = ps_cta_banco,
    ps_canal = ps_canal,
    pc_fecha = max(pc_hora),
    pc_sec_corr = pc_sec_corr
  into   #max_fech
  from   #PrimerCanales
  group  by ps_cta_banco,
            ps_canal,
            pc_sec_corr

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR EN TABLA #MAX_FECH',
      @w_error = 103118
    goto ERRORFIN
  end

  --ACTUALIZANDO ULTIMA FECHA POS
  update #datcon_td
  set    dt_fecha_fin_pos = pc_fecha
  from   #max_fech,
         #datcon_td a
  where  ps_cta_banco = a.dt_banco
     and ps_canal     = 8

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL ACTUALIZAR #DATCON_TD PARA POS',
      @w_error = 103118
    goto ERRORFIN
  end

  --ACTUALIZANDO ULTIMA FECHA ATM
  update #datcon_td
  set    dt_fecha_fin_atm = pc_fecha
  from   #max_fech,
         #datcon_td a
  where  ps_cta_banco = a.dt_banco
     and ps_canal     = 3

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL ACTUALIZAR #DATCON_TD PARA ATM',
      @w_error = 103118
    goto ERRORFIN
  end

  --OBTENIENDO DATOS PARA MONTOS DE POS Y ATM
  select distinct
    cta_banco = ts_banco_orig,
    canal = ts_canal,
    monto = isnull(ts_monto,
                   0),
    hora = ts_hora,
    fecha = ts_fecha,
    estado = ts_estado,
    sec_corr = ts_sec_ext
  into   #monto
  from   #datcon_td,
         #ws_tran_servicio
  where  ts_banco_orig = dt_banco
     and ts_estado     = 'A'

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR EN #MONTO',
      @w_error = 103118
    goto ERRORFIN
  end

  select distinct
    cta_banco = ts_banco_orig,
    canal = ts_canal,
    monto = isnull(ts_monto,
                   0),
    hora = ts_hora,
    fecha = ts_fecha,
    estado = ts_estado,
    sec_corr = ts_sec_ext
  into   #monto1
  from   #datcon_td,
         #ws_tran_servicio
  where  ts_banco_orig = dt_banco
     and ts_estado     = 'R'

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR EN #MONTO1',
      @w_error = 103118
    goto ERRORFIN
  end

  --OBTENIENDO DATOS A EXCLUIR
  select
    a.*
  into   #repetidos2
  from   #monto b,
         #monto1 a
  where  b.cta_banco = a.cta_banco
     and b.sec_corr  = a.sec_corr
     and a.estado    = 'R'

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR TRANSACCIONES REVERSADAS',
      @w_error = 103118
    goto ERRORFIN
  end

  --EXCLUYENDO TRANSACCIONES QUE HAN SUFIRDO REVERSOS
  delete from #monto
  where  cta_banco in
         (select
            a.cta_banco
          from   #repetidos2 a)
         and sec_corr in
             (select
                a.sec_corr
              from   #repetidos2 a)
         and hora in
             (select
                a.hora
              from   #repetidos2 a)

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL ELIMINAR TRANSACCIONES REVERSADAS',
      @w_error = 103118
    goto ERRORFIN
  end

  --OBTENIENDO DATOS A VALIDAR
  select distinct
    cta_banco = cta_banco,
    canal = canal,
    monto = isnull(monto,
                   0),
    hora = hora,
    estado = estado,
    sec_corr = sec_corr
  into   #monto2
  from   #datcon_td,
         #monto
  where  cta_banco = dt_banco
     and canal in (3, 8)
     and estado    = 'A'

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR MONTO',
      @w_error = 103118
    goto ERRORFIN
  end

  --OBTENIENDO ULTIMO MOVIMIENTO POS
  update #datcon_td
  set    dt_fin_monto_pos = isnull(monto,
                                   0)
  from   #datcon_td a,
         #monto2
  where  cta_banco = dt_banco
     and canal     = 8
     and estado    = 'A'

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL ACTUALIZAR #DATCON_TD PARA POS',
      @w_error = 103118
    goto ERRORFIN
  end

  --OBTENIENDO ULTIMO MOVIMIENTO ATM
  update #datcon_td
  set    dt_fin_monto_atm = isnull(monto,
                                   0)
  from   #datcon_td,
         #monto
  where  cta_banco = dt_banco
     and canal     = 3
     and estado    = 'A'

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL ACTUALIZAR #DATCON_TD PARA ATM',
      @w_error = 103118
    goto ERRORFIN
  end

  --OBTENIENDO CODIGO DE CATALOGO DE MOTIVO DE CANCELACIÓN
  select
    @w_mtv_can = codigo
  from   cobis..cl_tabla
  where  tabla = 're_novedades_enroll'

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL OBTENER CATALOGO MOTIVO DE CANCELACION',
      @w_error = 103118
    goto ERRORFIN
  end

  --OBTENIENDO MOTIVO DE CANCELACIÓN
  update #datcon_td
  set    dt_motivo_canc_tarjdeb = (select
                                     upper(valor)
                                   from   cobis..cl_catalogo
                                   where  tabla  = @w_mtv_can
                                      and codigo = rc_motivo)
  from   cob_remesas..re_relacion_cta_canal,
         #datcon_td a
  where  rc_tarj_debito = a.dt_num_tarjdeb
     and rc_estado      = 'E'

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL ACTUALIZAR MOTIVO DE CANCELACION',
      @w_error = 103118
    goto ERRORFIN
  end

  --ACTUALIZANDO FECHA DE VENCIMIENTO
  --SE OBTIENE LA INFORMACION DIRECTAMENTE DE LA TABLA sb_dato_tarjetas YA QUE ESTA MAESTRA SE ESTA CARGANDO DIRECTAMENTE A ESTA TABLA
  select
    @w_fecha_maestro_tar = max(dt_fecha_proceso)
  from   cob_conta_super..sb_dato_tarjetas

  update #datcon_td
  set    dt_fecha_ven_tarjdeb = dt_fec_ven
  from   cob_conta_super..sb_dato_tarjetas,
         #datcon_td a
  where  dt_num_tarjeta   = a.dt_num_tarjdeb
     and dt_fecha_proceso = @w_fecha_maestro_tar

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL ACTUALIZAR FECHA DE VENCIMIENTO',
      @w_error = 103118
    goto ERRORFIN
  end

  --OBTENIENDO ULTIMA FECHA DE TRANSACCION EN CAJA
  select
    hm_cta_banco  cuenta,
    max(hm_fecha) fecha
  into   #cta_fecha
  from   cob_ahorros_his..ah_his_movimiento,
         #datcon_td a
  where  hm_cta_banco = a.dt_banco
     and hm_tipo_tran in (252, 253, 263, 264, 392)
  group  by hm_cta_banco

  if @@error <> 0
  begin
    print 'ERROR AL INSERTAR EN #CTA_FECHA'
    goto ERRORFIN
  end

  update #datcon_td
  set    dt_fecha_fin_ofi = fecha
  from   #cta_fecha
  where  cuenta = dt_banco

  if @@error <> 0
  begin
    print 'ERROR AL ACTUALIZAR FECHA OFICINA'
    goto ERRORFIN
  end

  --GRABANDO EN TABLA DEFINITIVA
  insert into cob_externos..ex_datcon_tarjdeb
              (dt_fecha_corte,dt_ente,dt_banco,dt_ofi_asoc,dt_funcionario,
               dt_tipo_cta,dt_num_tarjdeb,dt_estado_tarjdeb,dt_est_cta,
               dt_fecha_asigna,
               dt_fecha_ini_pos,dt_fecha_ini_atm,dt_fecha_fin_pos,
               dt_fecha_fin_atm
               ,dt_fecha_fin_ofi,
               dt_fecha_ven_tarjdeb,dt_fin_monto_pos,dt_fin_monto_atm,
               dt_motivo_canc_tarjdeb)
    select
      ltrim(rtrim(dt_fecha_corte)),ltrim(rtrim(dt_ente)),ltrim(rtrim(dt_banco)),
      ltrim(rtrim(dt_ofi_asoc)),ltrim(rtrim(dt_funcionario)),
      ltrim(rtrim(dt_tipo_cta)),ltrim(rtrim(dt_num_tarjdeb)),
      ltrim(rtrim(dt_estado_tarjdeb)),ltrim(rtrim(dt_est_cta)),
      ltrim(rtrim(dt_fecha_asigna)),
      ltrim(rtrim(dt_fecha_ini_pos)),ltrim(rtrim(dt_fecha_ini_atm)),
      ltrim(rtrim(dt_fecha_fin_pos)),ltrim(rtrim(dt_fecha_fin_atm)),
      ltrim(rtrim(dt_fecha_fin_ofi)),
      ltrim(rtrim(dt_fecha_ven_tarjdeb)),ltrim(rtrim(dt_fin_monto_pos)),
      ltrim(rtrim(dt_fin_monto_atm)),ltrim(rtrim(dt_motivo_canc_tarjdeb))
    from   #datcon_td
    order  by dt_banco

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR EN TABLA EX_DATCON_TARJDEB',
      @w_error = 103118
    goto ERRORFIN
  end

  ERRORFIN:
  exec sp_errorlog
    @i_fecha       = @w_fecha_proc,
    @i_error       = @w_error,
    @i_usuario     = 'batch',
    @i_tran        = 0,
    @i_descripcion = @w_msg,
    @i_programa    = @w_sp_name

go

