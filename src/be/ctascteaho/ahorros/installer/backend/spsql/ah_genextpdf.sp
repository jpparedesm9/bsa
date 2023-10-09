/************************************************************************/
/*  Archivo           :     ah_genextpdf.sp                             */
/*  Stored procedure  :     sp_impresion_ref_economicas                 */
/*  Base de datos     :     cobi_ahorros                                */
/*  Producto          :     Ahorros                                     */
/*  Disenado por      :     Luis Carlos Moreno                          */
/*  Fecha de escritura:     11-Abr-2013                                 */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno  de sus            */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp.     */
/*  Este programa esta protegido por la ley de derechos de autor        */
/*  y por las convenciones  internacionales de propiedad inte-          */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para       */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier infraccion.                   */
/************************************************************************/
/*                           PROPOSITO                                  */
/*  Generar el archivo plano para la generecion del extracto de una     */
/*  cuenta de ahorros para posterior envio al correo electronico  del   */
/*  cliente, este proceso de generacion del extracto en pdf se realiza  */
/*  en el servidor de notificaciones                                    */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA         AUTOR             RAZON                               */
/*  11-04-13      L.Moreno          Emision Inicial - Req: 353 Alianzas */
/*  04/May/2016   J. Salazar        Migracion COBIS CLOUD MEXICO        */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_genera_ext_ah_pdf')
  drop proc sp_genera_ext_ah_pdf
go

/****** Object:  StoredProcedure [dbo].[sp_genera_ext_ah_pdf]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_genera_ext_ah_pdf
(
  @s_ssn           int,
  @s_srv           varchar(30),
  @s_user          varchar(30),
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint,
  @s_sev           tinyint = null,
  @p_lssn          int = null,
  @t_corr          char(1) = 'N',
  @t_ssn_corr      int = null,
  @p_rssn_corr     int = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_show_version  bit = 0,
  @s_org           char(1),
  @t_trn           int,
  @i_cta           cuenta,
  @i_fchdsde       datetime,
  @i_fchhsta       datetime,
  @i_mon           tinyint,
  @i_formato_fecha int = 101,
  @i_escliente     char(1) = 'N',
  @i_email         varchar(255) = null,
  @i_concepto      varchar(120) = '',
  @i_corresponsal  char(1) = 'N' --Req. 381 CB Red Posicionada     
)
as
  declare
    @w_return             int,
    @w_sp_name            varchar(30),
    @w_oficina            smallint,
    @w_ttran              smallint,
    @w_cuenta             int,
    @w_rcount             tinyint,
    @w_fchtmp             varchar(8),
    @w_fecha              datetime,
    @w_fecha_ini          datetime,
    @w_signo              char(1),
    @w_descripcion        descripcion,
    @w_ciudes             descripcion,
    @w_moneda             varchar(20),
    @w_nombre             mensaje,
    @w_direccion          mensaje,
    @w_valor              money,
    @w_saldodis           money,
    @w_interes            money,
    @w_saldo_para_girar   money,
    @w_saldo_contable     money,
    @w_ret_canje          money,
    @w_ret_chq_ext        money,
    @w_disponible         money,
    @w_cheque             int,
    @w_sec                int,
    @w_ssn                int,
    @w_sec_alt            int,
    @w_ssn_alt            int,
    @w_contador           tinyint,
    @w_lineas             tinyint,
    @w_corr               char(1),
    @w_funcionario        char(1),
    @w_producto           tinyint,
    @w_det_producto       int,
    @w_tabla_nc           smallint,
    @w_tabla_nd           smallint,
    @w_max_fecha          datetime,
    @w_min_fecha          datetime,
    @w_monto_blq          money,
    @w_tipo_dir           char(1),
    @w_descripcion_ec     varchar(255),
    @w_prod_banc          int,
    @w_desc_prod_banc     varchar(64),
    @w_saldo_prom_comf    money,
    @w_saldo_prom_conta   money,
    @w_cliente            int,
    @w_no_apartado        smallint,
    @w_nombre_titulares   varchar (255),
    @w_nombre_conca       varchar (255),
    @w_maximo_titulares   smallint,
    @w_cantidad_titulares smallint,
    @w_tasa_hoy           float,
    @w_me_mensaje         varchar(180),
    @w_sldini             money,
    @w_fecha_tmp          varchar(10),
    @w_of_nombre          varchar(25),
    @w_fecha_aper         datetime,
    @w_fecha_ing          varchar(10),
    @w_existe             char(1),
    @w_ente               int,
    @w_cedula             numero,
    @w_saldo              money,
    @w_secuencia          int,
    @w_credito            money,
    @w_debito             money,
    @w_tipo_tran          int,
    @w_tot_int            money,
    @w_tot_nc             money,
    @w_tot_nd             money,
    @w_tot_iva            money,
    @w_tot_gmf            money,
    @w_tot_iva_rev        money,
    @w_tot_gmf_rev        money,
    @w_nombre_arch_txt    varchar(255),
    @w_nombre_arch_err    varchar(255),
    @w_nombre_arch_pdf    varchar(255),
    @w_s_app              varchar(255),
    @w_path_plano         varchar(255),
    @w_cmd                varchar(255),
    @w_comando            varchar(500),
    @w_errores            varchar(255),
    @w_error              int,
    @w_passcryp           varchar(255),
    @w_login              varchar(255),
    @w_password           varchar(255),
    @w_FtpServer          varchar(50),
    @w_tmpfile            varchar(100),
    @w_prod_bancario      varchar(50) --Req. 381 CB Red Posicionada

  create table #extracto_ahorros
  (
    ext_cliente       int null,
    ext_cedula        varchar(30) null,
    ext_cuenta_ah_H   varchar(20) null,
    ext_cuenta_H      int null,
    ext_nombre_H      varchar (255) null,
    ext_tipo_dir_H    char(1) null,
    ext_direccion_H   varchar(255) null,
    ext_fec_cierre_H  varchar(10) null,
    ext_tel_oficial_H varchar(180) null,
    ext_fec_mes_ant_H varchar(10) null,
    ext_fec_impr_H    varchar(10) null,--,
    ext_oficina_H     varchar(25) null,
    ext_secuencial    int null,
    ext_alterno       int null,
    ext_consecutivo   int null,
    ext_fecha_D       varchar(10) null,
    ext_lugar_D       varchar(64) null,
    ext_signo_D       char(1) null,
    ext_saldo_cont_D  money null,--
    ext_valor_D       money null,
    ext_debito_D      money null,
    ext_credito_D     money null,
    ext_comision_D    money null,
    ext_impuesto_D    money null,
    ext_tipo_tran_D   int null,
    ext_ind_corr_D    char(1) null,
    ext_descripcion_D varchar(200) null,
    ext_numdep_F      float null,
    ext_saldo_prom_F  money null,
    ext_saldo_cont_F  money null,
    ext_mail          varchar(254) null,
    ext_archivo       varchar(254) null
  )

  if exists(select
              1
            from   sysobjects
            where  name = 'extracto_ahorros_tmp')
    drop table extracto_ahorros_tmp

  create table extracto_ahorros_tmp
  (
    ext_cliente       int null,
    ext_cedula        varchar(30) null,
    ext_cuenta_ah_H   varchar(20) null,
    ext_nombre_H      varchar (255) null,
    ext_direccion_H   varchar(255) null,
    ext_fec_cierre_H  varchar(10) null,
    ext_tel_oficial_H varchar(180) null,
    ext_fec_mes_ant_H varchar(10) null,
    ext_fec_impr_H    varchar(10) null,
    ext_oficina_H     varchar(25) null,
    ext_fecha_D       varchar(10) null,
    ext_lugar_D       varchar(64) null,
    ext_saldo_cont_D  varchar(20) null,
    ext_debito_D      varchar(20) null,
    ext_credito_D     varchar(20) null,
    ext_descripcion_D varchar(200) null,
    ext_numdep_F      varchar(20) null,
    ext_depositos_F   varchar(20) null,
    ext_nc_F          varchar(20) null,
    ext_saldo_prom_F  varchar(20) null,
    ext_nd_F          varchar(20) null,
    ext_saldo_cont_F  varchar(20) null,
    ext_mail          varchar(254) null,
    ext_archivo       varchar(254) null
  )

  -- Captura nombre de Stored Procedure
  select
    @w_sp_name = 'sp_genera_ext_ah_pdf'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  --Maximo de filas de la cabecera del titular
  select
    @w_maximo_titulares = 4,
    @w_nombre_conca = ''

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    -- Determinacion de los datos de la cuenta
    select
      @w_cuenta = ah_cuenta,
      @w_funcionario = ah_cta_funcionario,
      @w_producto = ah_producto,
      @w_ret_canje = isnull(ah_12h, 0) + isnull(ah_24h, 0) + isnull(ah_48h, 0),
      @w_ret_chq_ext = isnull(ah_remesas,
                              0),
      @w_disponible = isnull(ah_disponible,
                             0),
      @w_tipo_dir = ah_tipo_dir,
      @w_descripcion_ec = rtrim(ah_descripcion_ec) + '-'
                          + (select
                               ci_descripcion
                             from   cobis..cl_ciudad
                             where  ci_ciudad = a.ah_parroquia),
      @w_prod_banc = ah_prod_banc,
      @w_saldo_prom_comf = ah_prom_disponible,
      @w_saldo_prom_conta = ah_promedio1,
      @w_oficina = ah_oficina,
      @w_tasa_hoy = round(ah_tasa_hoy / 100,
                          2),
      @w_fecha_aper = ah_fecha_aper,
      @w_ente = ah_cliente
    from   cob_ahorros..ah_cuenta a
    where  ah_cta_banco = @i_cta
       and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
  end
  else
  begin
    -- Determinacion de los datos de la cuenta
    select
      @w_cuenta = ah_cuenta,
      @w_funcionario = ah_cta_funcionario,
      @w_producto = ah_producto,
      @w_ret_canje = isnull(ah_12h, 0) + isnull(ah_24h, 0) + isnull(ah_48h, 0),
      @w_ret_chq_ext = isnull(ah_remesas,
                              0),
      @w_disponible = isnull(ah_disponible,
                             0),
      @w_tipo_dir = ah_tipo_dir,
      @w_descripcion_ec = rtrim(ah_descripcion_ec) + '-'
                          + (select
                               ci_descripcion
                             from   cobis..cl_ciudad
                             where  ci_ciudad = a.ah_parroquia),
      @w_prod_banc = ah_prod_banc,
      @w_saldo_prom_comf = ah_prom_disponible,
      @w_saldo_prom_conta = ah_promedio1,
      @w_oficina = ah_oficina,
      @w_tasa_hoy = round(ah_tasa_hoy / 100,
                          2),
      @w_fecha_aper = ah_fecha_aper,
      @w_ente = ah_cliente
    from   cob_ahorros..ah_cuenta a
    where  ah_cta_banco = @i_cta
  end

  if (@w_fecha_aper between @i_fchdsde and @i_fchhsta)
  begin
    select
      @w_existe = 'S'
  end
  else if @w_fecha_aper >= @i_fchdsde
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141127,
      @i_msg   = 'Cuenta no Aperturada en ese Rango de fechas.'
    return 141127
  end

  if @w_fecha_aper > @i_fchdsde
    select
      @i_fchdsde = @w_fecha_aper

  select
    @w_desc_prod_banc = pb_descripcion
  from   cob_remesas..pe_pro_bancario
  where  pb_pro_bancario = @w_prod_banc

  if not exists (select
                   1
                 from   cob_ahorros_his..ah_his_movimiento
                 where  hm_cta_banco = @i_cta
                    and hm_fecha     >= @i_fchdsde
                    and hm_fecha     <= @i_fchhsta)
  begin
    -- error en la insercion de la transaccion de servicio
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 141195
    return 141195
  end

  /**********Busqueda de mensaje*************/

  select
    @w_me_mensaje = me_linea1 + ' ' + me_linea2 + ' ' + me_linea3 + ' ' +
                    me_linea4
                           + ' ' +
                           me_linea5 + ' ' + me_linea6
  from   cob_remesas..cc_mensaje_estcta
  where  me_fecha     <= @i_fchdsde
     and me_fecha_fin >= @i_fchhsta
     and me_prodban   = @w_prod_banc
     and me_oficina   = @w_oficina

  -- Verificacion de cuentas de funcionarios para oficiales autorizados
  if (@w_funcionario = 'S')
     and (@t_trn <> 370)
  begin
    if not exists (select
                     1
                   from   cob_remesas..re_ofi_personal,
                          cobis..cc_oficial,
                          cobis..cl_funcionario
                   where  fu_login       = @s_user
                      and fu_funcionario = oc_funcionario
                      and op_oficial     = oc_oficial)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201123
      return 201123
    end
  end

  -- Calcular el saldo
  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_debug            = @t_debug,
    @t_file             = @t_file,
    @t_from             = @w_sp_name,
    @i_cuenta           = @w_cuenta,
    @i_fecha            = @s_date,
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_saldo_contable out

  if @w_return <> 0
    return @w_return

  -- Determinacion de las tablas de NC y ND
  select
    @w_tabla_nc = codigo
  from   cobis..cl_tabla
  where  tabla = 'ah_causa_nc'

  select
    @w_tabla_nd = codigo
  from   cobis..cl_tabla
  where  tabla = 'ah_causa_nd'

  --Cantidad total de titular/cotitulares J. Artola   
  select
    @w_cantidad_titulares = count(1)
  from   cobis..cl_det_producto,
         cobis..cl_cliente
  where  dp_cuenta       = @i_cta
     and cl_det_producto = dp_det_producto
     and cl_rol in ('T', 'C')

  --Nombre del titular/cotitulares J. Artola
  declare titulares cursor for
    select
      en_nomlar
    from   cobis..cl_det_producto,
           cobis..cl_cliente,
           cobis..cl_ente
    where  dp_cuenta       = @i_cta
       and cl_det_producto = dp_det_producto
       and cl_rol in ('T', 'C')
       and cl_cliente      = en_ente
    order  by cl_rol desc
    for read only

  open titulares
  select
    @w_contador = 1

  --Concatena Nombre de Titular/Cotitulares J. Artola
  while @w_contador <= @w_maximo_titulares
  begin
    if @w_contador <= @w_cantidad_titulares
    begin
      fetch titulares into @w_nombre_titulares

      select
        @w_nombre_conca = rtrim(@w_nombre_conca) + rtrim(@w_nombre_titulares)
      if @w_contador < @w_maximo_titulares
         and @w_contador < @w_cantidad_titulares
      begin
        select
          @w_nombre_conca = @w_nombre_conca + ' (O)' + char(13)
      end
    end
    select
      @w_contador = @w_contador + 1
  end

  close titulares
  deallocate titulares

  if @w_tipo_dir = 'C'
  begin
    select
      @w_cliente = ah_cliente_ec,
      @w_no_apartado = ah_direccion_ec
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta

    --Concatena apartado J. Artola   
    select
      @w_descripcion_ec = cs_emp_postal + ' - ' + cs_valor + char(13) +
                          pv_descripcion
                                 + ' REP. ' +
                                 pa_descripcion
    from   cobis..cl_casilla,
           cobis..cl_provincia,
           cobis..cl_pais
    where  cs_ente      = @w_cliente
       and cs_casilla   = @w_no_apartado
       and cs_provincia = pv_provincia
       and pv_pais      = pa_pais
  end

  select
    @w_of_nombre = of_nombre
  from   cobis..cl_oficina
  where  of_oficina = @w_oficina

  select
    @w_fecha_ing = convert(varchar(10), @i_fchdsde, 103)

  --Obtiene Cedula del Cliente
  select
    @w_cedula = en_ced_ruc
  from   cobis..cl_ente
  where  en_ente = @w_ente

  -- Nombres de Cotitulares

  select
    @w_det_producto = dp_det_producto
  from   cobis..cl_det_producto
  where  dp_producto = @w_producto
     and dp_moneda   = @i_mon
     and dp_cuenta   = @i_cta

  set rowcount 0
  insert into cob_ahorros..ah_tran_servicio
              (ts_secuencial,ts_tipo_transaccion,ts_tsfecha,ts_usuario,
               ts_terminal,
               ts_oficina,ts_reentry,ts_origen,ts_cta_banco,ts_moneda,
               ts_oficina_cta,ts_hora,ts_saldo,ts_interes,ts_valor,
               ts_prod_banc,ts_rol_ente,ts_tipo,ts_descripcion_ec,ts_observacion
  )
  values      ( @s_ssn,@t_trn,@s_date,@s_user,@s_term,
                @s_ofi,@t_rty,@s_org,@i_cta,@i_mon,
                @w_oficina,getdate(),@w_disponible,@w_saldo_contable,
                @w_saldo_para_girar,
                @w_prod_banc,@i_escliente,'M',@i_email,@i_concepto)

  if @@error <> 0
  begin
    /* error en la insercion de la transaccion de servicio */
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 203005
    return 203005
  end

  if @i_fchhsta = @s_date
  begin
    select
      @w_min_fecha = max(sd_fecha)
    from   cob_ahorros_his..ah_saldo_diario
    where  sd_cuenta = @w_cuenta
       and sd_fecha  < @i_fchdsde

    if @w_min_fecha = @i_fchdsde
        or @w_min_fecha is null
    begin
      select
        @w_sldini = 0
      select
        @w_min_fecha = isnull(min(sd_fecha),
                              @s_date)
      from   cob_ahorros_his..ah_saldo_diario
      where  sd_cuenta = @w_cuenta
         and sd_fecha between @i_fchdsde and @i_fchhsta

      select
        @w_min_fecha = dateadd(dd,
                               -1,
                               @w_min_fecha)
    end
    else
      select
        @w_sldini = isnull(sd_saldo_contable,
                           0)
      from   cob_ahorros_his..ah_saldo_diario
      where  sd_cuenta = @w_cuenta
         and sd_fecha  = @w_min_fecha

    select
      @w_fecha_tmp = convert(varchar(10), @w_min_fecha, @i_formato_fecha)

    select
      @w_cuenta,
      @w_tasa_hoy,--NUMDEP
      @w_sldini,--SALDO PROMEDIO
      @w_saldo_contable --SALDO CONTABLE

  end
  else
  begin
    select
      @w_max_fecha = max(sd_fecha)
    from   cob_ahorros_his..ah_saldo_diario
    where  sd_cuenta = @w_cuenta
       and sd_fecha  <= @i_fchhsta

    select
      @w_min_fecha = max(sd_fecha)
    from   cob_ahorros_his..ah_saldo_diario
    where  sd_cuenta = @w_cuenta
       and sd_fecha  < @i_fchdsde

    if @w_min_fecha = @i_fchdsde
        or @w_min_fecha is null
      select
        @w_sldini = 0,
        @w_min_fecha = @i_fchdsde,
        @w_min_fecha = dateadd(dd,
                               -1,
                               @w_min_fecha)
    else
      select
        @w_sldini = sd_saldo_contable
      from   cob_ahorros_his..ah_saldo_diario
      where  sd_cuenta = @w_cuenta
         and sd_fecha  = @w_min_fecha

    select
      @w_monto_blq = 0

    select
      @w_monto_blq = sum(isnull(hb_valor,
                                0))
    from   cob_ahorros..ah_his_bloqueo
    where  hb_cuenta    = @w_cuenta
       and hb_fecha     <= @w_max_fecha
       and hb_accion    = 'B'
       and hb_levantado = 'NO'

    select
      @w_fecha_tmp = convert(varchar(10), @w_min_fecha, @i_formato_fecha)

    --PIE
    select
      @w_tasa_hoy = round(sd_tasa_disponible / 100,
                          2),--NUMDEP
      @w_saldo_contable = sd_saldo_contable --SALDO CONTABLE
    from   cob_ahorros_his..ah_saldo_diario
    where  sd_cuenta = @w_cuenta
       and sd_fecha  = @w_max_fecha

  end

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    --DETALLE
    insert into #extracto_ahorros
                (ext_cliente,ext_cedula,ext_cuenta_ah_H,ext_cuenta_H,
                 ext_nombre_H,
                 ext_tipo_dir_H,ext_direccion_H,ext_fec_cierre_H,
                 ext_tel_oficial_H
                 ,
                 ext_fec_mes_ant_H,
                 ext_fec_impr_H,ext_oficina_H,ext_secuencial,ext_alterno,
                 ext_consecutivo,
                 ext_fecha_D,ext_lugar_D,ext_signo_D,ext_valor_D,ext_debito_D,
                 ext_credito_D,ext_comision_D,ext_impuesto_D,ext_tipo_tran_D,
                 ext_ind_corr_D,
                 ext_descripcion_D,ext_numdep_F,ext_saldo_prom_F,
                 ext_saldo_cont_F)
      select
        @w_ente,--CLIENTE
        @w_cedula,--CEDULA
        @i_cta,--CUENTA BANCO
        @w_cuenta,--CUENTA
        @w_nombre_conca,--NOMBRE
        @w_tipo_dir,--TIPO DIRECCION
        case
          when @w_tipo_dir = 'C' then 'APARTADO:' + @w_descripcion_ec
          --DIRECCION
          else @w_descripcion_ec
        end,convert(varchar(10), @i_fchhsta, 103),--FECHA CIERRE
        isnull(@w_me_mensaje,
               ' '),--TELEFONO OFICIAL
        @w_fecha_ing,--FECHA MES ANTERIOR
        @w_fecha_tmp,--FECHA IMPRESION
        @w_of_nombre,--OFICINA
        hm_secuencial,--SECUENCIAL
        hm_cod_alterno,--ALTERNO
        0,--CONSECUTIVO
        convert(varchar(12), hm_fecha, @i_formato_fecha),--FECHA
        substring (of_nombre,
                   1,
                   15),--LUGAR
        hm_signo,(hm_valor + isnull(hm_chq_propios, $0) + isnull(hm_chq_locales,
                  $0)
         + isnull(hm_chq_ot_plazas, $0)),--VALOR
        case
          when hm_signo = 'D' then --DEBITO
        (hm_valor + isnull(hm_chq_propios, $0) + isnull(hm_chq_locales, $0)
         + isnull(hm_chq_ot_plazas, $0))
          else 0
        end,
        case
          when hm_signo = 'C'
                or isnull(hm_chq_ot_plazas,
                          $0) <> 0 then --CREDITO
        (hm_valor + isnull(hm_chq_propios, $0) + isnull(hm_chq_locales, $0)
         + isnull(hm_chq_ot_plazas, $0))
          else 0
        end,isnull(hm_valor_comision,
               0),--IVA
        isnull(hm_monto_imp,
               0),--GMF
        hm_tipo_tran,--TIPO TRANSACCION
        hm_correccion,--INDICADOR DE CORRECCION
        case --DESCRIPCION
          when (X.hm_tipo_tran = 253) then 'N/C: '
                                           + (select
                                                valor
                                              from   cobis..cl_catalogo A,
                                                     cobis..cl_tabla B
                                              where  B.codigo = A.tabla
                                                 and B.tabla  = 'ah_causa_nc'
                                                 and A.codigo = X.hm_causa)
                                           + isnull('-' + hm_concepto, '')
          when (X.hm_tipo_tran = 264) then 'N/D: '
                                           + (select
                                                valor
                                              from   cobis..cl_catalogo A,
                                                     cobis..cl_tabla B
                                              where  B.codigo = A.tabla
                                                 and B.tabla  = 'ah_causa_nd'
                                                 and A.codigo = X.hm_causa)
                                           + isnull('-' + hm_concepto, '')
          when (X.hm_tipo_tran in (240)) then
          tn_descripcion + ' (No. ' + ltrim(rtrim(
          convert(varchar(255), isnull(hm_cheque,
          0)))) + ')'
          else tn_descripcion + isnull('-' + hm_concepto, '')
        end,isnull(@w_tasa_hoy,
               0),--NUMERO DE DEPOSITOS
        isnull(@w_sldini,
               0),--SALDO PROMEDIO
        isnull(@w_saldo_contable,
               0) --SALDO CONTABLE
      from   cob_ahorros_his..ah_his_movimiento X
             inner join cobis..cl_oficina
                     on hm_oficina = of_oficina
                        and of_filial = 1
             inner join cobis..cl_ttransaccion
                     on hm_tipo_tran = tn_trn_code
      where  hm_cta_banco = @i_cta
         and hm_fecha     >= @i_fchdsde
         and hm_fecha     <= @i_fchhsta
         and hm_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
         and hm_estado is null
      order  by hm_fecha,
                hm_hora,
                hm_secuencial,
                hm_cod_alterno
  end
  else
  begin
    --DETALLE
    insert into #extracto_ahorros
                (ext_cliente,ext_cedula,ext_cuenta_ah_H,ext_cuenta_H,
                 ext_nombre_H,
                 ext_tipo_dir_H,ext_direccion_H,ext_fec_cierre_H,
                 ext_tel_oficial_H
                 ,
                 ext_fec_mes_ant_H,
                 ext_fec_impr_H,ext_oficina_H,ext_secuencial,ext_alterno,
                 ext_consecutivo,
                 ext_fecha_D,ext_lugar_D,ext_signo_D,ext_valor_D,ext_debito_D,
                 ext_credito_D,ext_comision_D,ext_impuesto_D,ext_tipo_tran_D,
                 ext_ind_corr_D,
                 ext_descripcion_D,ext_numdep_F,ext_saldo_prom_F,
                 ext_saldo_cont_F)
      select
        @w_ente,--CLIENTE
        @w_cedula,--CEDULA
        @i_cta,--CUENTA BANCO
        @w_cuenta,--CUENTA
        @w_nombre_conca,--NOMBRE
        @w_tipo_dir,--TIPO DIRECCION
        case
          when @w_tipo_dir = 'C' then 'APARTADO:' + @w_descripcion_ec
          --DIRECCION
          else @w_descripcion_ec
        end,convert(varchar(10), @i_fchhsta, 103),--FECHA CIERRE
        isnull(@w_me_mensaje,
               ' '),--TELEFONO OFICIAL
        @w_fecha_ing,--FECHA MES ANTERIOR
        @w_fecha_tmp,--FECHA IMPRESION
        @w_of_nombre,--OFICINA
        hm_secuencial,--SECUENCIAL
        hm_cod_alterno,--ALTERNO
        0,--CONSECUTIVO
        convert(varchar(12), hm_fecha, @i_formato_fecha),--FECHA
        substring (of_nombre,
                   1,
                   15),--LUGAR
        hm_signo,(hm_valor + isnull(hm_chq_propios, $0) + isnull(hm_chq_locales,
                  $0)
         + isnull(hm_chq_ot_plazas, $0)),--VALOR
        case
          when hm_signo = 'D' then --DEBITO
        (hm_valor + isnull(hm_chq_propios, $0) + isnull(hm_chq_locales, $0)
         + isnull(hm_chq_ot_plazas, $0))
          else 0
        end,
        case
          when hm_signo = 'C'
                or isnull(hm_chq_ot_plazas,
                          $0) <> 0 then --CREDITO
        (hm_valor + isnull(hm_chq_propios, $0) + isnull(hm_chq_locales, $0)
         + isnull(hm_chq_ot_plazas, $0))
          else 0
        end,isnull(hm_valor_comision,
               0),--IVA
        isnull(hm_monto_imp,
               0),--GMF
        hm_tipo_tran,--TIPO TRANSACCION
        hm_correccion,--INDICADOR DE CORRECCION
        case --DESCRIPCION
          when (X.hm_tipo_tran = 253) then 'N/C: '
                                           + (select
                                                valor
                                              from   cobis..cl_catalogo A,
                                                     cobis..cl_tabla B
                                              where  B.codigo = A.tabla
                                                 and B.tabla  = 'ah_causa_nc'
                                                 and A.codigo = X.hm_causa)
                                           + isnull('-' + hm_concepto, '')
          when (X.hm_tipo_tran = 264) then 'N/D: '
                                           + (select
                                                valor
                                              from   cobis..cl_catalogo A,
                                                     cobis..cl_tabla B
                                              where  B.codigo = A.tabla
                                                 and B.tabla  = 'ah_causa_nd'
                                                 and A.codigo = X.hm_causa)
                                           + isnull('-' + hm_concepto, '')
          when (X.hm_tipo_tran in (240)) then
          tn_descripcion + ' (No. ' + ltrim(rtrim(
          convert(varchar(255), isnull(hm_cheque,
          0)))) + ')'
          else tn_descripcion + isnull('-' + hm_concepto, '')
        end,isnull(@w_tasa_hoy,
               0),--NUMERO DE DEPOSITOS
        isnull(@w_sldini,
               0),--SALDO PROMEDIO
        isnull(@w_saldo_contable,
               0) --SALDO CONTABLE
      from   cob_ahorros_his..ah_his_movimiento X
             inner join cobis..cl_oficina
                     on hm_oficina = of_oficina
                        and of_filial = 1
             inner join cobis..cl_ttransaccion
                     on hm_tipo_tran = tn_trn_code
      where  hm_cta_banco = @i_cta
         and hm_fecha     >= @i_fchdsde
         and hm_fecha     <= @i_fchhsta
         and hm_estado is null
      order  by hm_fecha,
                hm_hora,
                hm_secuencial,
                hm_cod_alterno
  end

  /* INSERTA REGISTROS DE IVA Y GMF */
  insert into #extracto_ahorros
              (ext_cliente,ext_cedula,ext_cuenta_ah_H,ext_cuenta_H,
               ext_secuencial,
               ext_alterno,ext_consecutivo,ext_fecha_D,ext_lugar_D,
               ext_descripcion_D,
               ext_signo_D,ext_credito_D,ext_debito_D)
    select
      @w_ente,--CLIENTE
      @w_cedula,--CEDULA
      @i_cta,--CUENTA BANCO
      @w_cuenta,--CUENTA
      ext_secuencial,
      ext_alterno,1,ext_fecha_D,--FECHA
      ext_lugar_D,--LUGAR
      case
        when ext_ind_corr_D = 'S' then --DESCRIPCION
      'IMPUESTO IVA - REVERSO'
        else 'IMPUESTO IVA'
      end,
      case
        when ext_ind_corr_D = 'S' then '+'
        else '-'
      end,--SIGNO
      case
        when ext_ind_corr_D = 'S' then ext_comision_D
        else 0
      end,--CREDITO
      case
        when ext_ind_corr_D = 'S' then 0
        else ext_comision_D
      end --DEBITO
    from   #extracto_ahorros
    where  isnull(ext_comision_D,
                  0) > 0
  --end

  insert into #extracto_ahorros
              (ext_cliente,ext_cedula,ext_cuenta_ah_H,ext_cuenta_H,
               ext_secuencial,
               ext_alterno,ext_consecutivo,ext_fecha_D,ext_lugar_D,
               ext_descripcion_D,
               ext_signo_D,ext_credito_D,ext_debito_D)
    select
      @w_ente,--CLIENTE
      @w_cedula,--CEDULA
      @i_cta,--CUENTA BANCO
      @w_cuenta,--CUENTA
      ext_secuencial,
      ext_alterno,2,ext_fecha_D,--FECHA
      ext_lugar_D,--LUGAR
      case
        when ext_ind_corr_D = 'S' then --DESCRIPCION
      'IMPUESTO GMF - REVERSO'
        else 'IMPUESTO GMF'
      end,
      case
        when ext_ind_corr_D = 'S' then '+'
        else '-'
      end,--SIGNO
      case
        when ext_ind_corr_D = 'S' then ext_impuesto_D
        else 0
      end,--CREDITO
      case
        when ext_ind_corr_D = 'S' then 0
        else ext_impuesto_D
      end --DEBITO
    from   #extracto_ahorros
    where  isnull(ext_impuesto_D,
                  0) > 0

  select
    *
  into   #extracto_ahorros_tmp
  from   #extracto_ahorros
  order  by ext_fecha_D,
            ext_secuencial,
            ext_alterno,
            ext_consecutivo

  alter table #extracto_ahorros_tmp
    add Secuencia int identity (1, 1)

  select
    @w_secuencia = 0,
    @w_saldo = @w_sldini,
    @w_tot_nd = 0,
    @w_tot_nc = 0,
    @w_tot_iva = 0,
    @w_tot_iva_rev = 0,
    @w_tot_gmf = 0,
    @w_tot_gmf_rev = 0,
    @w_tot_int = 0

  while 1 = 1
  begin
    select top 1
      @w_debito = isnull(ext_debito_D,
                         0),
      @w_credito = isnull(ext_credito_D,
                          0),
      @w_valor = isnull(ext_valor_D,
                        0),
      @w_tipo_tran = isnull(ext_tipo_tran_D,
                            0)
    from   #extracto_ahorros_tmp
    where  Secuencia > @w_secuencia

    if @@rowcount = 0
      break

    select
      @w_saldo = @w_saldo + @w_credito - @w_debito
    if @w_tipo_tran = 221
      select
        @w_tot_int = @w_tot_int + @w_valor

    if @w_tipo_tran in (229, 253, 255, 257,
                        2503, 221, 294, 300,
                        304, 315, 207, 246,
                        248, 251, 252, 254)
      select
        @w_tot_nc = @w_tot_nc + @w_valor
    if @w_tipo_tran in (228, 240, 262, 264,
                        266, 2502, 237, 239,
                        263, 371, 213, 308,
                        309, 316, 392)
      select
        @w_tot_nd = @w_tot_nd + @w_valor

    select
      @w_secuencia = @w_secuencia + 1

    update #extracto_ahorros_tmp
    set    ext_saldo_cont_D = isnull(@w_saldo,
                                     0)
    where  Secuencia = @w_secuencia
  end

  select
    @w_tot_iva = isnull(sum(ext_debito_D),
                        0),
    @w_tot_iva_rev = isnull(sum(ext_credito_D),
                            0)
  from   #extracto_ahorros_tmp
  where  ext_consecutivo = 1

  select
    @w_tot_gmf = isnull(sum(ext_debito_D),
                        0),
    @w_tot_gmf_rev = isnull(sum(ext_credito_D),
                            0)
  from   #extracto_ahorros_tmp
  where  ext_consecutivo = 2

  select
    @w_tot_nd = @w_tot_nd + @w_tot_iva - @w_tot_iva_rev + @w_tot_gmf
                                                    - @w_tot_gmf_rev

  select
    @w_nombre_arch_txt = @i_cta + '_' + convert(varchar(10), @i_fchdsde, 112) +
                         '_'
                         + convert(varchar(10), @i_fchhsta, 112) + '.txt'
  select
    @w_nombre_arch_err = @i_cta + '_' + convert(varchar(10), @i_fchdsde, 112) +
                         '_'
                         + convert(varchar(10), @i_fchhsta, 112) + '.err'
  select
    @w_nombre_arch_pdf = @i_cta + '_' + convert(varchar(10), @i_fchdsde, 112) +
                         '_'
                         + convert(varchar(10), @i_fchhsta, 112) + '.pdf'

  insert into extracto_ahorros_tmp
              (ext_cliente,ext_cedula,ext_cuenta_ah_H,ext_nombre_H,
               ext_direccion_H,
               ext_fec_cierre_H,ext_tel_oficial_H,ext_fec_mes_ant_H,
               ext_fec_impr_H
               ,ext_oficina_H,
               ext_fecha_D,ext_lugar_D,ext_saldo_cont_D,ext_debito_D,
               ext_credito_D
               ,
               ext_descripcion_D,ext_numdep_F,ext_depositos_F,
               ext_nc_F,ext_saldo_prom_F,
               ext_nd_F,ext_saldo_cont_F,ext_mail,ext_archivo)
    select
      isnull(ext_cliente,
             0),isnull(ext_cedula,
             ' '),isnull(ext_cuenta_ah_H,
             ' '),isnull(ext_nombre_H,
             ' '),isnull(ext_direccion_H,
             ' '),
      isnull(ext_fec_cierre_H,
             ' '),isnull(ext_tel_oficial_H,
             ' '),isnull(ext_fec_mes_ant_H,
             ' '),isnull(ext_fec_impr_H,
             ' '),isnull(ext_oficina_H,
             ' '),
      isnull(ext_fecha_D,
             ' '),isnull(ext_lugar_D,
             ' '),isnull(cast(ext_saldo_cont_D as varchar),
             '0.00'),isnull(cast(ext_debito_D as varchar),
             '0.00'),isnull(cast(ext_credito_D as varchar),
             '0.00'),
      isnull(ext_descripcion_D,
             ' '),isnull(ext_numdep_F,
             '0.00'),isnull(cast(@w_tot_int as varchar),
             '0.00'),isnull(cast(@w_tot_nc as varchar),
             '0.00'),isnull(cast(ext_saldo_prom_F as varchar),
             '0.00'),
      isnull(cast(@w_tot_nd as varchar),
             '0.00'),isnull(cast(ext_saldo_cont_F as varchar),
             '0.00'),isnull(@i_email,
             ' '),isnull(@w_nombre_arch_pdf,
             ' ')
    from   #extracto_ahorros_tmp

/* GENERACION ARCHIVO EXTRACTOS */
  -- Generar plano fisico para PDF'S y notificador
  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  select
    @w_path_plano = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'PATHEA'

  select
    @w_errores = @w_path_plano + @w_nombre_arch_err
  select
    @w_cmd = @w_s_app + 's_app bcp  cob_ahorros..extracto_ahorros_tmp out '
  select
       @w_comando = @w_cmd + @w_path_plano + @w_nombre_arch_txt +
                    ' -b5000  -w -e'
                    +
                    @w_errores
                 + ' -t"|" -auto -login -config ' + @w_s_app + 's_app.ini'

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    print 'ERROR GENERANDO ARCHIVO PLANO: '
    print @w_comando
    return 1
  end

  /* OBTIENE USUARIO PARA FTP EL CUAL SE INGRESA DESDE EL MODULO DE SEGURIDAD */
  select
    @w_passcryp = up_password,
    @w_login = up_login
  from   cobis..ad_usuario_xp
  where  up_equipo = 'F'

  if @@rowcount = 0
  begin
    print 'Error lectura Usuario Notificador de Correos '
    return 1
  end

  /* DESCIFRA PASSWORD */
  exec @w_return = CIFRAR...xp_decifrar
    @i_data = @w_passcryp,
    @o_data = @w_password out

  if @w_return <> 0
  begin
    print 'Error lectura Usuario Notificador de Correos '
    return 1
  end

  /* OBTIENE DIRECCION DEL SERVIDOR FTP */
  select
    @w_FtpServer = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'FTPSRV'
  if @@rowcount = 0
  begin
    print 'Error lectura Servidor de Notificacion de Correos '
    return 1
  end

  /* ELIMINA ARCHIVO INSTRUCCIONES FTP */
  select
    @w_tmpfile = @w_path_plano + @s_user + '_' + 'fuente_ftp'

  select
    @w_cmd = 'del ' + @w_tmpfile
  exec xp_cmdshell
    @w_cmd

  /* CREA ARCHIVO INSTRUCCIONES FTP */
  select
    @w_cmd = 'echo ' + @w_login + '>> ' + @w_tmpfile
  exec xp_cmdshell
    @w_cmd

  select
    @w_cmd = 'echo ' + @w_password + '>> ' + @w_tmpfile
  exec xp_cmdshell
    @w_cmd

  select
    @w_cmd = 'echo ' + 'cd cuenta_ahorros\a_procesar ' + ' >> ' + @w_tmpfile
  exec xp_cmdshell
    @w_cmd

  select
    @w_cmd = 'echo ' + 'put  ' + @w_path_plano + @w_nombre_arch_txt + ' >> ' +
                               @w_tmpfile

  exec xp_cmdshell
    @w_cmd

  if @w_error <> 0
  begin
    print 'ERROR Realizando Transferencia de Correo '
    return -1
  end

  select
    @w_cmd = 'echo ' + 'quit ' + '>> ' + @w_tmpfile
  exec xp_cmdshell
    @w_cmd

  /* EJECUTA FTP */
  select
    @w_cmd = 'ftp -s:' + @w_tmpfile + ' ' + @w_FtpServer
  exec xp_cmdshell
    @w_cmd

  if @@error <> 0
  begin
    print 'Error Transfiriendo Extracto a Notificador de Correos'
    return 1
  end

  select
    @w_cmd = 'del ' + @w_tmpfile
  exec xp_cmdshell
    @w_cmd

  return 0

go

