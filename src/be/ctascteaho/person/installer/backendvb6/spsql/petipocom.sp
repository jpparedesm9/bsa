/****************************************************************************/
/*  Archivo:            petipocom.sp                                        */
/*  Stored procedure:   sp_tipo_comision                                    */
/*  Base de datos:      cob_remesas                                         */
/*  Producto:           Personalizacion                                     */
/***************************************************************************/
/*                                 IMPORTANTE                               */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                               PROPOSITO                                  */
/*  Este programa devuelve el tipo de comision de transacciones en ofici    */
/*  na                                                                      */
/****************************************************************************/
/*                          MODIFICACIONES                                  */
/*  FECHA       AUTOR       RAZON                                           */
/* 2012-04-18   LMoreno     Calculo comision dependiendo las caract.        */
/*                          de la cuenta                                    */
/* 2014-08-05   Andres Diab Nueva operacion para consulta de comisiones     */
/*                          para producto con tarjeta debito                */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go
if exists (select
             1
           from   sysobjects
           where  name = 'sp_tipo_comision')
  drop proc sp_tipo_comision
go
create proc sp_tipo_comision
(
  @s_date         datetime,
  @s_ofi          smallint,
  @t_corr         char(1) = 'N',
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_show_version bit = 0,
  @i_cta          cuenta,
  @i_mon          tinyint,
  @i_operacion    varchar(1) = 'Q',
  @i_filial       tinyint = 1,
  @i_trn_accion   int = null,
  @i_ofiord       smallint = null,
  @o_comision     money = 0 out,
  @o_causal       char(3) = '' out
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_sucursal         int,
    @w_rol_ente         char(1),
    @w_tipo_def         char(1),
    @w_saldo_contable   money,
    @w_saldo_para_girar money,
    @w_promedio1        money,
    @w_categoria        char(1),
    @w_prod_banc        smallint,
    @w_producto         tinyint,
    @w_tipo             char(1),
    @w_codigo           int,
    @w_disponible       money,
    @w_prom_disponible  money,
    @w_personalizada    char(1),
    @w_oficina_cta      smallint,
    @w_ofi              smallint,
    @w_numtrn_max       int,
    @w_error            int,
    @w_nconmes          int,
    @w_ncremes          int,
    @w_ndebmes          int,
    @w_ntotmes          int,
    @w_ciudad_cta       int,
    @w_ciudad_loc       int,
    @w_busca_costo      char(1),
    @w_numero           int,
    @w_numtotcta        int,
    @w_trn_acum         int,
    @w_ano              char(4),
    @w_mes              char(2),
    @w_cuenta           int,
    @w_servicio         catalogo,
    @w_rubro            catalogo,
    @w_tipocta          char(1),
    @w_nat_trn          varchar(10),
    @w_numcre           int,
    @w_numtot           int,
    @w_numco            int,
    @w_numdeb           int,
    @w_tipocobro        char(1),
    @w_prodbanc         int

  select
    @w_sp_name = 'sp_tipo_comision'
  select
    @o_comision = 0,
    @o_causal = ''

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_cuenta = ah_cuenta,
    @w_oficina_cta = ah_oficina,
    @w_categoria = ah_categoria,
    @w_rol_ente = ah_rol_ente,
    @w_tipo_def = ah_tipo_def,
    @w_prod_banc = ah_prod_banc,
    @w_producto = ah_producto,
    @w_tipocta = ah_tipocta,
    @w_tipo = ah_tipo,
    @w_codigo = ah_default,
    @w_disponible = ah_disponible,
    @w_promedio1 = ah_promedio1,
    @w_prom_disponible = ah_prom_disponible,
    @w_personalizada = ah_personalizada,
    @w_oficina_cta = ah_oficina,
    @w_rol_ente = ah_rol_ente,
    @w_nconmes = isnull(ah_num_con_mes,
                        0),
    @w_ncremes = isnull(ah_num_cred_mes,
                        0),
    @w_ndebmes = isnull(ah_num_deb_mes,
                        0),
    @w_numtotcta = isnull(ah_num_con_mes, 0) + isnull(ah_num_cred_mes, 0) +
                   isnull
                   (
                   ah_num_deb_mes
                   , 0)
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta
     and ah_moneda    = @i_mon
  if @@rowcount = 0
  begin
    select
      @w_error = 251001
    goto ERROR
  end

  select
    @w_prodbanc = C.codigo
  from   cobis..cl_tabla T,
         cobis..cl_catalogo C
  where  T.tabla  = 're_pro_banc_cb'
     and T.codigo = C.tabla
     and C.estado = 'V'

  if @w_prod_banc = @w_prodbanc
  --Si el producto pertenece a una cuenta de corresponsalia no debe generar
  begin
    select
      @o_comision = 0,
      @o_causal = ''
    return 0
  end

  /* Obtiene ciudad de la oficina de radicacion de la cuenta */
  select
    @w_ciudad_cta = oc_centro
  from   cob_cuentas..cc_ofi_centro
  where  oc_oficina = @w_oficina_cta
  if @@rowcount <> 1
  begin
    select
      @w_error = 201094
    goto ERROR
  end

  if @i_ofiord is not null
    select
      @w_ofi = @i_ofiord
  else
    select
      @w_ofi = @s_ofi

  /* Obtiene ciudad de la oficina de recaudo de la cuenta */
  select
    @w_ciudad_loc = oc_centro
  from   cob_cuentas..cc_ofi_centro
  where  oc_oficina = @w_ofi
  if @@rowcount <> 1
  begin
    select
      @w_error = 201094
    goto ERROR
  end

  if @t_corr = 'S'
  begin
    if @w_ciudad_cta = @w_ciudad_loc
      /* No es Transaccion Nacional */
      select
        @w_servicio = 'COCO',
        @o_causal = '90'
    else
      /* Transaccion Nacional */
      select
        @w_servicio = 'TRNA',
        @o_causal = '30',
        @w_rubro = eq_val_interfaz
      from   cob_remesas..re_equivalencias
      where  eq_tabla     = 'COMTRNA'
         and eq_modulo    = 4
         and eq_mod_int   = 26
         and eq_val_cfijo = @i_trn_accion

    if @@rowcount = 0
    begin
      select
        @w_error = 351580
      goto ERROR
    end

    return 0
  end

  /* Obtiene sucursal de radicacion de la cuenta */
  select
    @w_sucursal = isnull(of_regional,
                         of_oficina)
  from   cobis..cl_oficina
  where  of_oficina = @w_oficina_cta
  if @@rowcount = 0
  begin
    select
      @w_error = 251001
    goto ERROR
  end

  if @i_operacion = 'Q'
  begin
    /* CONSULTA TIPO DE COBRO DEL PRODUCTO */
    select
      @w_numtot = isnull(pc_numtot,
                         0),
      @w_numcre = isnull(pc_numcre,
                         0),
      @w_numdeb = isnull(pc_numdeb,
                         0),
      @w_numco = isnull(pc_numco,
                        0),
      @w_tipocobro = pc_tipo
    from   cob_remesas..pe_pro_final,
           cob_remesas..pe_mercado,
           cob_remesas..pe_par_comision
    where  pf_mercado      = me_mercado
       and pc_profinal     = pf_pro_final
       and me_pro_bancario = @w_prod_banc
       and me_tipo_ente    = @w_tipocta
       and pf_moneda       = @i_mon
       and me_estado       = 'V'
       and pf_tipo         = @w_tipo
       and pf_filial       = @i_filial
       and pf_sucursal     = @w_sucursal--
       and pc_categoria    = @w_categoria
       and pc_estado       = 'V'

    if @@rowcount = 0
        or @w_tipocobro = 'M'
    begin
      return 0
    end

    --CONSULTA
    if @w_tipocobro = 'W'
    begin
      select
        @w_numtrn_max = isnull(pct_numtrn,
                               0)
      from   cob_remesas..pe_pro_final,
             cob_remesas..pe_mercado,
             cob_remesas..pe_par_comision,
             cob_remesas..pe_par_com_trn,
             cobis..cl_oficina
      where  pf_mercado      = me_mercado
         and pc_profinal     = pf_pro_final
         and me_pro_bancario = @w_prod_banc
         and me_tipo_ente    = @w_tipocta
         and pf_moneda       = @i_mon
         and me_estado       = 'V'
         and pf_tipo         = @w_tipo
         and pf_filial       = @i_filial
         and pf_sucursal     = @w_sucursal--
         and pc_categoria    = @w_categoria
         and pc_estado       = 'V'
         and pc_profinal     = pct_profinal
         and pc_categoria    = pct_categoria
         and pct_transaccion = @i_trn_accion
         and pc_tipo         = @w_tipocobro

      if @@rowcount = 0
      begin
        return 0
      end

    end

    select
      @w_busca_costo = 'S'

    /* Valida si es una transaccion desde otra ciudad */
    if @w_ciudad_cta = @w_ciudad_loc
    begin
      /* No es Transaccion Nacional */
      select
        @w_servicio = 'COCO',
        @o_causal = '90'

      --Compara parametros del tipo de cobro contra la cuenta
      if @w_tipocobro = 'C'
          or @w_tipocobro = 'T'
      begin
        /* TIPO DE COBRO CONSULTAS, DEBITOS Y CREDITOS */
        if @w_tipocobro = 'C'
        begin
          /* ASIGNA RUBRO IGUAL AL TIPO DE COBRO + CODIGO DE LA TRANSACCION */
          select
            @w_rubro = @w_tipocobro + cast(@i_trn_accion as varchar)

          /* OBTIENE LA NATURALEZA DE LA TRANSACCION */
          select
            @w_nat_trn = valor
          from   cobis..cl_tabla t with (nolock),
                 cobis..cl_catalogo c with (nolock)
          where  t.tabla  = 'pe_nat_trn'
             and c.tabla  = t.codigo
             and c.codigo = 'N' + cast(@i_trn_accion as varchar)

          if @@rowcount = 0
          begin
            select
              @w_error = 201094
            goto ERROR
          end

          if @w_nat_trn = 'CON' --Consulta
          begin
            select
              @w_numero = @w_numco
            select
              @w_ntotmes = @w_nconmes
          end
          if @w_nat_trn = 'CRE' --Depositos, Notas Credito
          begin
            select
              @w_numero = @w_numcre
            select
              @w_ntotmes = @w_ncremes
          end
          if @w_nat_trn = 'DEB' --Retiros, Notas Debitos
          begin
            select
              @w_numero = @w_numdeb
            select
              @w_ntotmes = @w_ndebmes
          end
        end
        if @w_tipocobro = 'T'
        begin
          /* ASIGNA RUBRO IGUAL AL TIPO DE COBRO */
          select
            @w_rubro = @w_tipocobro
          select
            @w_numero = @w_numtot
          select
            @w_ntotmes = @w_numtotcta
        end
        if @w_ntotmes < @w_numero
        begin
          select
            @w_busca_costo = 'N'
          select
            @o_causal = ''
        end
      end

      if @w_tipocobro = 'W'
      begin
        /* ASIGNA RUBRO IGUAL AL TIPO DE COBRO + CODIGO DE LA TRANSACCION */
        select
          @w_rubro = @w_tipocobro + cast(@i_trn_accion as varchar)

        /* Obtiene mes y dia de la fecha */
        select
          @w_mes = substring(convert(varchar(10), @s_date, 103),
                             4,
                             2)
        select
          @w_ano = substring(convert(varchar(10), @s_date, 103),
                             7,
                             4)

        /* Obtiene cantidad transacciones mensuales de la cuenta por tipo de transaccion */
        select
          @w_trn_acum = isnull(tm_cantidad,
                               0)
        from   cob_ahorros..ah_tran_mensual with (nolock)
        where  tm_ano     = @w_ano
           and tm_mes     = @w_mes
           and tm_cuenta  = @i_cta
           and tm_cod_trn = @i_trn_accion

        if @@rowcount = 0
          select
            @w_trn_acum = 0

        if @w_trn_acum < @w_numtrn_max
        begin
          select
            @w_busca_costo = 'N'
          select
            @o_causal = ''
        end
      end
    end
    else
    begin
      /* Transaccion Nacional */
      select
        @w_servicio = 'TRNA',
        @o_causal = '30',
        @w_rubro = eq_val_interfaz
      from   cob_remesas..re_equivalencias
      where  eq_tabla     = 'COMTRNA'
         and eq_modulo    = 4
         and eq_mod_int   = 26
         and eq_val_cfijo = @i_trn_accion

      if @@rowcount = 0
      begin
        select
          @w_error = 351580
        goto ERROR
      end
    end

    if @w_busca_costo = 'S'
    begin
      exec @w_return = cob_ahorros..sp_ahcalcula_saldo
        @t_debug            = @t_debug,
        @t_file             = @t_file,
        @t_from             = @w_sp_name,
        @i_cuenta           = @w_cuenta,
        @i_fecha            = @s_date,
        @o_saldo_para_girar = @w_saldo_para_girar out,
        @o_saldo_contable   = @w_saldo_contable out

      if @w_return <> 0
      begin
        select
          @w_error = @w_return
        goto ERROR
      end

      exec @w_return = cob_remesas..sp_genera_costos
        @t_debug       = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_fecha       = @s_date,
        @i_valor       = 1,
        @i_categoria   = @w_categoria,
        @i_tipo_ente   = @w_tipocta,
        @i_rol_ente    = @w_rol_ente,
        @i_tipo_def    = @w_tipo_def,
        @i_prod_banc   = @w_prod_banc,
        @i_producto    = @w_producto,
        @i_moneda      = @i_mon,
        @i_tipo        = @w_tipo,
        @i_codigo      = @w_codigo,
        @i_servicio    = @w_servicio,
        @i_rubro       = @w_rubro,
        @i_disponible  = @w_disponible,
        @i_contable    = @w_saldo_contable,
        @i_promedio    = @w_promedio1,
        @i_prom_disp   = @w_prom_disponible,
        @i_personaliza = @w_personalizada,
        @i_filial      = @i_filial,
        @i_oficina     = @w_oficina_cta,
        @o_valor_total = @o_comision out

      if @w_return <> 0
      begin
        print ' Comision = ' + cast (@o_comision as varchar)
        return @w_return
      end

      if @o_comision = 0
        select
          @o_causal = ''

    end

  end -- OPERACION Q

  if @i_operacion = 'T'
  --REQ 451 OPERACION PARA COMISIONES POR TRANSACCION DESDE OFICINA CON CUENTA QUE TENGA TARJETA DEBITO
  begin
    if exists (select
                 1
               from   cob_remesas..re_relacion_cta_canal
               where  rc_cuenta = @i_cta
                  and rc_canal  = 'TAR'
                  and rc_estado = 'V')
    begin
      select
        @w_servicio = c.valor,
        @w_rubro = '3'
      from   cobis..cl_tabla t,
             cobis..cl_catalogo c
      where  t.tabla  = 'pe_comision_td'
         and t.codigo = c.tabla
         and c.codigo = convert(char, @i_trn_accion)
         and c.estado = 'V'

      if @w_servicio is null
      begin
        print
' NO EXISTE SERVICIO DISPONIBLE DE COMISION POR TARJETA DEBITO PARA LA TRANSACCION '
+ cast (@i_trn_accion as varchar)
  return 351501
end

  exec @w_return = cob_remesas..sp_genera_costos
    @t_debug       = @t_debug,
    @t_file        = @t_file,
    @t_from        = @w_sp_name,
    @i_fecha       = @s_date,
    @i_valor       = 1,
    @i_categoria   = @w_categoria,
    @i_tipo_ente   = @w_tipocta,
    @i_rol_ente    = @w_rol_ente,
    @i_tipo_def    = @w_tipo_def,
    @i_prod_banc   = @w_prod_banc,
    @i_producto    = @w_producto,
    @i_moneda      = @i_mon,
    @i_tipo        = @w_tipo,
    @i_codigo      = @w_codigo,
    @i_servicio    = @w_servicio,
    @i_rubro       = @w_rubro,
    @i_disponible  = @w_disponible,
    @i_contable    = @w_saldo_contable,
    @i_promedio    = @w_promedio1,
    @i_prom_disp   = @w_prom_disponible,
    @i_personaliza = @w_personalizada,
    @i_filial      = @i_filial,
    @i_oficina     = @w_oficina_cta,
    @o_valor_total = @o_comision out --Valor comision Tarjeta Debito

  if @w_return <> 0
  begin
    print ' Comision = ' + cast (@o_comision as varchar)
    return @w_return
  end

  select
    @o_comision = isnull(@o_comision,
                         0)
end
end -- OPERACION T

  return 0
  ERROR:
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = @w_error
  return @w_error

GO 
