/************************************************************************/
/*      Archivo:                ah_solicitud_estado_cuenta.sp           */
/*      Stored procedure:       sp_ah_solicitud_estado_cuenta           */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Mauricio Bayas/Sandra Ortiz             */
/*      Fecha de escritura:     10-Dic-1993                             */
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
/*      Este programa procesa la transaccion de:                        */
/*      Consulta de estado de cuenta por fechas                         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      05/ago/2008     J. Artola       correccion de nombre de         */
/*                                      titulares y apartado            */
/*      26/02/2010      C. Munoz        Req 09 Extracto Consulta        */
/*      02/05/2016      Ignacio Yupa    Migración a CEN                 */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_solicitud_estado_cuenta')
  drop proc sp_ah_solicitud_estado_cuenta
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_solicitud_estado_cuenta
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
  @s_org           char(1),
  @t_trn           int,
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_fchdsde       datetime,
  @i_fchhsta       datetime,
  @i_sec           int,
  @i_sec_alt       int,
  @i_mon           tinyint,
  @i_diario        tinyint,
  @i_frontn        char(1) = 'N',
  @i_formato_fecha int = 101,
  @i_hora          smalldatetime = null,
  @i_paso_impmas   tinyint = 1,
  @i_tipoenvio     char(1) = null,
  @o_hist          tinyint out,
  @i_escliente     char(1) = 'N',
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
    @w_saldo              money,
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
    --cmunoz req 09 
    @w_tasa_hoy           float,
    @w_me_mensaje         varchar(180),
    @w_sldini             money,
    @w_fecha_tmp          varchar(10),
    @w_of_nombre          varchar(25),
    @w_fecha_aper         datetime,
    @w_fecha_ing          varchar(10),
    @w_existe             char(1),
    @w_prod_bancario      varchar(1) --Req. 381 CB Red Posicionada    

  -- Captura nombre de Stored Procedure
  select
    @w_sp_name = 'sp_ah_solicitud_estado_cuenta'
  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end
  --Maximo de filas de la cabecera del titular
  select
    @w_maximo_titulares = 4

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

  -- Entrega de cuentas para la impresion masiva
  if (@t_trn = 370)
     and (@i_paso_impmas = 0)
  begin
    select
      @w_fecha = dateadd(dd,
                         -1,
                         convert(datetime, convert(varchar(2), datepart(mm,
                                           @s_date)
                                           )
                                           + '/01/'
                                           + convert(varchar(4), datepart(yy,
                                           @s_date)
                                           )))
    select
      @w_fecha_ini = convert(datetime, convert(varchar(2), datepart(mm, @w_fecha
                                       ))
                                       +
                                                                         '/01/'
                                       + convert(varchar(4), datepart(yy,
                                       @w_fecha
                                       ))
                     )

    if (@i_cta is null)
        or (@i_cta = '')
    begin
      -- Enviar al front end la fecha inicial y la fecha final
      select
        convert(varchar(10), @w_fecha_ini, 101)
      select
        convert(varchar(10), @w_fecha, 101)

      set rowcount 200

      if @i_tipoenvio in ('C', 'R', 'D')
      --Apartado Postal, Retencion en Oficina, Direccion Cliente
      begin
        if @i_corresponsal = 'N'
        -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
        begin
          select
            'CUENTA' = ah_cta_banco
          from   cob_ahorros..ah_cuenta nolock
          where  ah_moneda        = @i_mon
             and (ah_estado not in ('G', 'C')
                   or (ah_estado        = 'C'
                       and ah_fecha_ult_mov >= @w_fecha_ini))
             and ah_estado_cuenta = 'S'
             and ah_fecha_aper    <= @w_fecha
             and ah_tipo_dir      = @i_tipoenvio
             and ah_prod_banc     <> @w_prod_bancario
          -- Req. 381 CB Red Posicionada
          order  by ah_cta_banco
          return 0
        end
        else
        begin
          select
            'CUENTA' = ah_cta_banco
          from   cob_ahorros..ah_cuenta nolock
          where  ah_moneda        = @i_mon
             and (ah_estado not in ('G', 'C')
                   or (ah_estado        = 'C'
                       and ah_fecha_ult_mov >= @w_fecha_ini))
             and ah_estado_cuenta = 'S'
             and ah_fecha_aper    <= @w_fecha
             and ah_tipo_dir      = @i_tipoenvio
          order  by ah_cta_banco
          return 0
        end
      end
      else if @i_corresponsal = 'N'
      -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
      begin
        select
          'CUENTA' = ah_cta_banco
        from   cob_ahorros..ah_cuenta nolock
        where  ah_cta_banco     >= @i_cta
           and ah_moneda        = @i_mon
           and (ah_estado not in ('G', 'C')
                 or (ah_estado        = 'C'
                     and ah_fecha_ult_mov >= @w_fecha_ini))
           and ah_estado_cuenta = 'S'
           and ah_prod_banc     <> @w_prod_bancario
           -- Req. 381 CB Red Posicionada
           and ah_fecha_aper    <= @w_fecha
        order  by ah_cta_banco
        set rowcount 0
      end
      else
      begin
        select
          'CUENTA' = ah_cta_banco
        from   cob_ahorros..ah_cuenta nolock
        where  ah_cta_banco     >= @i_cta
           and ah_moneda        = @i_mon
           and (ah_estado not in ('G', 'C')
                 or (ah_estado        = 'C'
                     and ah_fecha_ult_mov >= @w_fecha_ini))
           and ah_estado_cuenta = 'S'
           and ah_fecha_aper    <= @w_fecha
        order  by ah_cta_banco
        set rowcount 0
      end
      return 0
    end
  end

  if @i_diario <> 0
     and @i_sec = 0
    select
      @i_sec = -10000000

  if @i_corresponsal = 'N'
  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
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
      @w_descripcion_ec = ah_descripcion_ec + '-'
                          + (select
                               ci_descripcion
                             from   cobis..cl_ciudad
                             where  ci_ciudad = a.ah_parroquia),
      @w_prod_banc = ah_prod_banc,
      @w_saldo_prom_comf = ah_prom_disponible,
      @w_saldo_prom_conta = ah_promedio1,
      --cmunoz req 09
      @w_oficina = ah_oficina,
      @w_tasa_hoy = round(ah_tasa_hoy,
                          2) / 100,
      @w_fecha_aper = ah_fecha_aper
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
      @w_descripcion_ec = ah_descripcion_ec + '-'
                          + (select
                               ci_descripcion
                             from   cobis..cl_ciudad
                             where  ci_ciudad = a.ah_parroquia),
      @w_prod_banc = ah_prod_banc,
      @w_saldo_prom_comf = ah_prom_disponible,
      @w_saldo_prom_conta = ah_promedio1,
      --cmunoz req 09
      @w_oficina = ah_oficina,
      @w_tasa_hoy = round(ah_tasa_hoy,
                          2) / 100,
      @w_fecha_aper = ah_fecha_aper
    from   cob_ahorros..ah_cuenta a
    where  ah_cta_banco = @i_cta
  end

  select
    @w_tasa_hoy = power((1 + (@w_tasa_hoy / 12)),
                        12) - 1
  select
    @w_tasa_hoy = round(@w_tasa_hoy,
                        4)

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

  --CMUNOZ REQ 09

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

  if @i_sec = 0
  begin
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
      if @i_corresponsal = 'N'
      -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
      begin
        select
          @w_cliente = ah_cliente_ec,
          @w_no_apartado = ah_direccion_ec
        from   cob_ahorros..ah_cuenta
        where  ah_cta_banco = @i_cta
           and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
      end
      else
      begin
        select
          @w_cliente = ah_cliente_ec,
          @w_no_apartado = ah_direccion_ec
        from   cob_ahorros..ah_cuenta
        where  ah_cta_banco = @i_cta
      end
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

    -- Datos de la cabecera
    if @i_corresponsal = 'N'
    -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
    begin
      select
        @w_nombre_conca,
        convert(varchar(12), ah_fecha_ult_mov, @i_formato_fecha),
        convert(varchar(12), ah_fecha_ult_corte, @i_formato_fecha),
        mo_descripcion,
        @w_descripcion_ec,
        convert (varchar(12), ah_fecha_prx_corte, @i_formato_fecha),
        ah_oficial,
        ah_parroquia,
        ah_zona,
        ah_saldo_ult_corte,
        fu_nombre,
        fu_telefono,
        @w_saldo_para_girar,
        ah_12h + ah_24h,
        ah_remesas,
        ah_disponible,
        @w_saldo_contable,
        ah_nombre1,
        ah_fideicomiso,
        @w_tipo_dir,
        @w_desc_prod_banc,
        @w_me_mensaje,
        @w_of_nombre,
        @w_fecha_ing
      from   cob_ahorros..ah_cuenta,
             cobis..cl_moneda,
             cobis..cl_funcionario,
             cobis..cc_oficial
      where  ah_cuenta      = @w_cuenta
         and ah_prod_banc   <> @w_prod_bancario -- Req. 381 CB Red Posicionada
         and mo_moneda      = ah_moneda
         and oc_oficial     = ah_oficial
         and fu_funcionario = oc_funcionario
    end
    else
    begin
      select
        @w_nombre_conca,
        convert(varchar(12), ah_fecha_ult_mov, @i_formato_fecha),
        convert(varchar(12), ah_fecha_ult_corte, @i_formato_fecha),
        mo_descripcion,
        @w_descripcion_ec,
        convert (varchar(12), ah_fecha_prx_corte, @i_formato_fecha),
        ah_oficial,
        ah_parroquia,
        ah_zona,
        ah_saldo_ult_corte,
        fu_nombre,
        fu_telefono,
        @w_saldo_para_girar,
        ah_12h + ah_24h,
        ah_remesas,
        ah_disponible,
        @w_saldo_contable,
        ah_nombre1,
        ah_fideicomiso,
        @w_tipo_dir,
        @w_desc_prod_banc,
        @w_me_mensaje,
        @w_of_nombre,
        @w_fecha_ing
      from   cob_ahorros..ah_cuenta,
             cobis..cl_moneda,
             cobis..cl_funcionario,
             cobis..cc_oficial
      where  ah_cuenta      = @w_cuenta
         and mo_moneda      = ah_moneda
         and oc_oficial     = ah_oficial
         and fu_funcionario = oc_funcionario
    end

    if (@@rowcount <> 1)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141127,
        @i_msg   = 'El oficial de la cuenta no existe definido como tal'
      return 141127
    end

    if @i_corresponsal = 'N'
    -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
    begin
      select
        te_valor
      from   cob_ahorros..ah_cuenta,
             cobis..cl_direccion,
             cobis..cl_telefono
      where  ah_cuenta     = @w_cuenta
         and ah_prod_banc  <> @w_prod_bancario -- Req. 381 CB Red Posicionada
         and di_ente       = ah_cliente
         and di_direccion  = ah_direccion_ec
         and te_ente       = di_ente
         and te_direccion  = di_direccion
         and te_secuencial = di_telefono
    end
    else
    begin
      select
        te_valor
      from   cob_ahorros..ah_cuenta,
             cobis..cl_direccion,
             cobis..cl_telefono
      where  ah_cuenta     = @w_cuenta
         and di_ente       = ah_cliente
         and di_direccion  = ah_direccion_ec
         and te_ente       = di_ente
         and te_direccion  = di_direccion
         and te_secuencial = di_telefono
    end

    if @i_fchhsta = @s_date
    begin
      if @i_corresponsal = 'N'
      begin
        select
          @w_min_fecha = max(sd_fecha)
        from   cob_ahorros_his..ah_saldo_diario
        where  sd_cuenta    = @w_cuenta
           and sd_prod_banc <> @w_prod_bancario
           -- Req. 381 CB Red Posicionada   
           and sd_fecha     < @i_fchdsde

        if @w_min_fecha = @i_fchdsde
            or @w_min_fecha is null
        begin
          select
            @w_sldini = 0
          select
            @w_min_fecha = isnull(min(sd_fecha),
                                  @s_date)
          from   cob_ahorros_his..ah_saldo_diario
          where  sd_cuenta    = @w_cuenta
             and sd_prod_banc <> @w_prod_bancario
             -- Req. 381 CB Red Posicionada   
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
          where  sd_cuenta    = @w_cuenta
             and sd_prod_banc <> @w_prod_bancario
             -- Req. 381 CB Red Posicionada   
             and sd_fecha     = @w_min_fecha
      end
      else
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
      end

      select
        @w_fecha_tmp = convert(varchar(10), @w_min_fecha, @i_formato_fecha)
      select
        @w_saldo_para_girar,--SaldoPromedio            
        @w_ret_canje,--RetBancosLoc             
        @w_ret_chq_ext,--RetOtrasPlazas           
        @w_saldo_contable,--SaldoContable            
        @w_disponible,--SaldoDisponible          
        @w_saldo_prom_comf,--Saldo Promedio Confirmado
        @w_saldo_prom_conta,--Saldo Promedio contable  
        --cmunoz req 09
        @w_tasa_hoy,
        @w_sldini,
        @w_fecha_tmp
    end
    else
    begin
      if @i_corresponsal = 'N'
      begin
        select
          @w_max_fecha = max(sd_fecha)
        from   cob_ahorros_his..ah_saldo_diario
        where  sd_cuenta    = @w_cuenta
           and sd_prod_banc <> @w_prod_bancario
           -- Req. 381 CB Red Posicionada   
           and sd_fecha     <= @i_fchhsta

        select
          @w_min_fecha = max(sd_fecha)
        from   cob_ahorros_his..ah_saldo_diario
        where  sd_cuenta    = @w_cuenta
           and sd_prod_banc <> @w_prod_bancario
           -- Req. 381 CB Red Posicionada   
           and sd_fecha     < @i_fchdsde

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
          where  sd_cuenta    = @w_cuenta
             and sd_prod_banc <> @w_prod_bancario
             -- Req. 381 CB Red Posicionada   
             and sd_fecha     = @w_min_fecha
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
      end

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

      if @i_corresponsal = 'N'
      begin
        select
          sd_saldo_disponible - @w_monto_blq,--SaldoPromedio
          sd_12h + sd_24h + sd_48h,--RetBancosLoc              
          sd_remesas,--RetOtrasPlazas            
          sd_saldo_contable,--SaldoContable             
          sd_saldo_disponible,--SaldoDisponible           
          sd_prom_disponible,--Saldo Promedio Confirmado 
          sd_promedio1,--Saldo Promedio contable   
          round(power((1 + ((round(sd_tasa_disponible,
                                   2) / 100) / 12)),
                      12) - 1,
                4),--tasa cmunoz req 09
          @w_sldini,
          @w_fecha_tmp
        from   cob_ahorros_his..ah_saldo_diario
        where  sd_cuenta    = @w_cuenta
           and sd_fecha     = @w_max_fecha
           and sd_prod_banc <> @w_prod_bancario
      -- Req. 381 CB Red Posicionada   
      end
      else
      begin
        select
          sd_saldo_disponible - @w_monto_blq,--SaldoPromedio
          sd_12h + sd_24h + sd_48h,--RetBancosLoc              
          sd_remesas,--RetOtrasPlazas            
          sd_saldo_contable,--SaldoContable             
          sd_saldo_disponible,--SaldoDisponible           
          sd_prom_disponible,--Saldo Promedio Confirmado 
          sd_promedio1,--Saldo Promedio contable   
          round(power((1 + ((round(sd_tasa_disponible,
                                   2) / 100) / 12)),
                      12) - 1,
                4),--tasa cmunoz req 09
          @w_sldini,
          @w_fecha_tmp
        from   cob_ahorros_his..ah_saldo_diario
        where  sd_cuenta = @w_cuenta
           and sd_fecha  = @w_max_fecha
      end
    end

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
                 ts_prod_banc,ts_rol_ente,ts_observacion)
    values      ( @s_ssn,@t_trn,@s_date,@s_user,@s_term,
                  @s_ofi,@t_rty,@s_org,@i_cta,@i_mon,
                  @w_oficina,getdate(),@w_disponible,@w_saldo_contable,
                  @w_saldo_para_girar,
                  @w_prod_banc,@i_escliente,@i_concepto)

    if @@error <> 0
    begin
      /* error en la insercion de la transaccion de servicio */
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 203005
      return 203005
    end
  end

  -- Datos del historico de movimientos
  set rowcount 15
  if @i_diario = 0
  begin
    if @i_sec = 0
      select
        @i_sec = -2147483648
    if @i_corresponsal = 'N'
    begin
      select
        convert(varchar(12), hm_fecha, @i_formato_fecha),
        hm_oficina,
        substring (of_nombre,
                   1,
                   15),
        hm_correccion,
        case
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
        end,
        case isnull(hm_chq_ot_plazas,
                    $0)
          when 0 then hm_signo
          else '*'
        end,
        (hm_valor + isnull(hm_chq_propios, $0) + isnull(hm_chq_locales, $0)
         + isnull(hm_chq_ot_plazas, $0)),
        hm_saldo_contable,
        hm_monto_imp,
        isnull(hm_interes,
               0),
        hm_secuencial,--hm_transaccion,  --pcoello cambia el campo
        hm_cod_alterno,
        hm_tipo_tran,
        hm_serial,
        isnull((select
                  X.hm_serial
                where  X.hm_tipo_tran in (253, 264)),
               isnull((select
                         right (replicate ('0', 8) +
                         convert(varchar(20), X.hm_concepto), 8)
                         + right (replicate ('0', 3) +
                         convert(varchar(5), X.hm_banco),
                         3)
                         + right (replicate ('0', 2) + X.hm_causa, 2)
                       where  X.hm_tipo_tran in (240, 313, 311)),
                      isnull((select
                                X.hm_ctadestino
                              where  X.hm_tipo_tran in (237, 239, 294, 300)),
                             convert(varchar(20), hm_secuencial)))),
        isnull((select
                  X.hm_causa
                where  X.hm_tipo_tran in (253, 264)),
               '000'),
        hm_estado,
        hm_ssn_branch,
        hm_hora,
        --cmunoz req 09
        hm_valor_comision
      from   cob_ahorros_his..ah_his_movimiento X
             inner join cobis..cl_oficina
                     on hm_oficina = of_oficina
                        and of_filial = 1
             inner join cobis..cl_ttransaccion
                     on hm_tipo_tran = tn_trn_code
      where  hm_cta_banco   = @i_cta
         and hm_fecha       >= @i_fchdsde
         and hm_fecha       <= @i_fchhsta
         and ((hm_hora        = @i_hora
               and hm_secuencial  = @i_sec
               and hm_cod_alterno > @i_sec_alt)
               or (hm_hora        = @i_hora
                   and hm_secuencial  > @i_sec)
               or (hm_hora > @i_hora))
         and hm_estado is null
         and hm_prod_banc   <> @w_prod_bancario
      -- Req. 381 CB Red Posicionada   
      order  by hm_fecha,
                hm_hora,
                hm_secuencial,
                hm_cod_alterno
    end
    else
    begin
      select
        convert(varchar(12), hm_fecha, @i_formato_fecha),
        hm_oficina,
        substring (of_nombre,
                   1,
                   15),
        hm_correccion,
        case
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
        end,
        case isnull(hm_chq_ot_plazas,
                    $0)
          when 0 then hm_signo
          else '*'
        end,
        (hm_valor + isnull(hm_chq_propios, $0) + isnull(hm_chq_locales, $0)
         + isnull(hm_chq_ot_plazas, $0)),
        hm_saldo_contable,
        hm_monto_imp,
        isnull(hm_interes,
               0),
        hm_secuencial,--hm_transaccion,  --pcoello cambia el campo
        hm_cod_alterno,
        hm_tipo_tran,
        hm_serial,
        isnull((select
                  X.hm_serial
                where  X.hm_tipo_tran in (253, 264)),
               isnull((select
                         right (replicate ('0', 8) +
                         convert(varchar(20), X.hm_concepto), 8)
                         + right (replicate ('0', 3) +
                         convert(varchar(5), X.hm_banco),
                         3)
                         + right (replicate ('0', 2) + X.hm_causa, 2)
                       where  X.hm_tipo_tran in (240, 313, 311)),
                      isnull((select
                                X.hm_ctadestino
                              where  X.hm_tipo_tran in (237, 239, 294, 300)),
                             convert(varchar(20), hm_secuencial)))),
        isnull((select
                  X.hm_causa
                where  X.hm_tipo_tran in (253, 264)),
               '000'),
        hm_estado,
        hm_ssn_branch,
        hm_hora,
        --cmunoz req 09
        hm_valor_comision
      from   cob_ahorros_his..ah_his_movimiento X
             inner join cobis..cl_oficina
                     on hm_oficina = of_oficina
                        and of_filial = 1
             inner join cobis..cl_ttransaccion
                     on hm_tipo_tran = tn_trn_code
      where  hm_cta_banco   = @i_cta
         and hm_fecha       >= @i_fchdsde
         and hm_fecha       <= @i_fchhsta
         and ((hm_hora        = @i_hora
               and hm_secuencial  = @i_sec
               and hm_cod_alterno > @i_sec_alt)
               or (hm_hora        = @i_hora
                   and hm_secuencial  > @i_sec)
               or (hm_hora > @i_hora))
         and hm_estado is null
      order  by hm_fecha,
                hm_hora,
                hm_secuencial,
                hm_cod_alterno
    end

    if @@rowcount = 15
      select
        @o_hist = 0
    else
      select
        @o_hist = 1

    return 0
  end
  if @i_corresponsal = 'N'
  begin
    -- Datos de la tabla del diario
    select
      convert(varchar(12), tm_fecha, @i_formato_fecha),
      tm_oficina,
      substring (of_nombre,
                 1,
                 15),
      tm_correccion,
      case
        when (X.tm_tipo_tran = 253) then 'N/C: '
                                         + (select
                                              valor
                                            from   cobis..cl_catalogo A,
                                                   cobis..cl_tabla B
                                            where  B.codigo = A.tabla
                                               and B.tabla  = 'ah_causa_nc'
                                               and A.codigo = X.tm_causa)
                                         + isnull('-' + tm_concepto, '')
        when (X.tm_tipo_tran = 264) then 'N/D: '
                                         + (select
                                              valor
                                            from   cobis..cl_catalogo A,
                                                   cobis..cl_tabla B
                                            where  B.codigo = A.tabla
                                               and B.tabla  = 'ah_causa_nd'
                                               and A.codigo = X.tm_causa)
                                         + isnull('-' + tm_concepto, '')
        when (X.tm_tipo_tran in (240)) then
        tn_descripcion + ' (No. ' + ltrim(rtrim(
        convert(varchar(255), isnull(tm_cheque,
        0)))) + ')'
        else tn_descripcion + isnull('-' + tm_concepto, '')
      end,
      case isnull(tm_chq_ot_plazas,
                  $0)
        when 0 then tm_signo
        else '*'
      end,
      (tm_valor + isnull(tm_chq_propios, $0) + isnull(tm_chq_locales, $0)
       + isnull(tm_chq_ot_plazas, $0)),
      tm_saldo_contable,
      tm_monto_imp,
      isnull(tm_interes,
             0),
      convert(varchar(20), tm_secuencial),
      --tm_ssn_branch,  --pcoello cambia el campo
      tm_cod_alterno,
      tm_tipo_tran,
      tm_serial,
      isnull((select
                X.tm_serial
              where  X.tm_tipo_tran in (253, 264)),
             isnull((select
                       right (replicate ('0', 8) +
                       convert(varchar(20), X.tm_concepto), 8)
                       + right (replicate ('0', 3) +
                       convert(varchar(5), X.tm_banco),
                       3)
                       + right (replicate ('0', 2) + X.tm_causa, 2)
                     where  X.tm_tipo_tran in (240, 313, 311)),
                    isnull((select
                              X.tm_ctadestino
                            where  X.tm_tipo_tran in (237, 239, 294, 300)),
                           convert(varchar(20), tm_secuencial)))),
      isnull((select
                X.tm_causa
              where  X.tm_tipo_tran in (253, 264)),
             '000'),
      tm_estado,
      tm_secuencial,
      tm_hora,
      tm_valor_comision --cmunoz req 09
    from   cob_ahorros..ah_tran_monet X,
           cobis..cl_ttransaccion,
           cobis..cl_oficina
    where  tm_cta_banco   = @i_cta
       and ((tm_hora        = @i_hora
             and tm_secuencial  = @i_sec
             and tm_cod_alterno > @i_sec_alt)
             or (tm_hora        = @i_hora
                 and tm_secuencial  > @i_sec)
             or (tm_hora > @i_hora))
       and tm_estado is null
       and tm_fecha       <= @i_fchhsta
       and tm_fecha       >= @i_fchdsde
       and tn_trn_code    = tm_tipo_tran
       and of_filial      = 1
       and of_oficina     = tm_oficina
       and tm_prod_banc   <> @w_prod_bancario -- Req. 381 CB Red Posicionada   
    order  by tm_fecha,
              tm_hora,
              tm_secuencial,
              tm_cod_alterno
  end
  else
  begin
    -- Datos de la tabla del diario
    select
      convert(varchar(12), tm_fecha, @i_formato_fecha),
      tm_oficina,
      substring (of_nombre,
                 1,
                 15),
      tm_correccion,
      case
        when (X.tm_tipo_tran = 253) then 'N/C: '
                                         + (select
                                              valor
                                            from   cobis..cl_catalogo A,
                                                   cobis..cl_tabla B
                                            where  B.codigo = A.tabla
                                               and B.tabla  = 'ah_causa_nc'
                                               and A.codigo = X.tm_causa)
                                         + isnull('-' + tm_concepto, '')
        when (X.tm_tipo_tran = 264) then 'N/D: '
                                         + (select
                                              valor
                                            from   cobis..cl_catalogo A,
                                                   cobis..cl_tabla B
                                            where  B.codigo = A.tabla
                                               and B.tabla  = 'ah_causa_nd'
                                               and A.codigo = X.tm_causa)
                                         + isnull('-' + tm_concepto, '')
        when (X.tm_tipo_tran in (240)) then
        tn_descripcion + ' (No. ' + ltrim(rtrim(
        convert(varchar(255), isnull(tm_cheque,
        0)))) + ')'
        else tn_descripcion + isnull('-' + tm_concepto, '')
      end,
      case isnull(tm_chq_ot_plazas,
                  $0)
        when 0 then tm_signo
        else '*'
      end,
      (tm_valor + isnull(tm_chq_propios, $0) + isnull(tm_chq_locales, $0)
       + isnull(tm_chq_ot_plazas, $0)),
      tm_saldo_contable,
      tm_monto_imp,
      isnull(tm_interes,
             0),
      convert(varchar(20), tm_secuencial),
      --tm_ssn_branch,  --pcoello cambia el campo
      tm_cod_alterno,
      tm_tipo_tran,
      tm_serial,
      isnull((select
                X.tm_serial
              where  X.tm_tipo_tran in (253, 264)),
             isnull((select
                       right (replicate ('0', 8) +
                       convert(varchar(20), X.tm_concepto), 8)
                       + right (replicate ('0', 3) +
                       convert(varchar(5), X.tm_banco),
                       3)
                       + right (replicate ('0', 2) + X.tm_causa, 2)
                     where  X.tm_tipo_tran in (240, 313, 311)),
                    isnull((select
                              X.tm_ctadestino
                            where  X.tm_tipo_tran in (237, 239, 294, 300)),
                           convert(varchar(20), tm_secuencial)))),
      isnull((select
                X.tm_causa
              where  X.tm_tipo_tran in (253, 264)),
             '000'),
      tm_estado,
      tm_secuencial,
      tm_hora,
      tm_valor_comision --cmunoz req 09
    from   cob_ahorros..ah_tran_monet X,
           cobis..cl_ttransaccion,
           cobis..cl_oficina
    where  tm_cta_banco   = @i_cta
       and ((tm_hora        = @i_hora
             and tm_secuencial  = @i_sec
             and tm_cod_alterno > @i_sec_alt)
             or (tm_hora        = @i_hora
                 and tm_secuencial  > @i_sec)
             or (tm_hora > @i_hora))
       and tm_estado is null
       and tm_fecha       <= @i_fchhsta
       and tm_fecha       >= @i_fchdsde
       and tn_trn_code    = tm_tipo_tran
       and of_filial      = 1
       and of_oficina     = tm_oficina
    order  by tm_fecha,
              tm_hora,
              tm_secuencial,
              tm_cod_alterno
  end

  if @@rowcount = 15
    select
      @o_hist = 2
  else
    select
      @o_hist = 3

  set rowcount 0

  return 0

go

