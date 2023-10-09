/****************************************************************************/
/*     Archivo:     peconval.sp                                             */
/*     Stored procedure: sp_valor_contratado                                */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 01-Ene-1994                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
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
/*                           PROPOSITO                                      */
/*     Este programa inserta y actualiza los valores contratados para un    */
/*     servicio.                                                            */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*       20/05/2003   Julissa Colorado  Personalizacion Banco Agrario       */
/*     30/Sep/2003      Gloria Rueda    Retornar c¢digos de error           */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_valor_contratado')
  drop proc sp_valor_contratado
go
create proc sp_valor_contratado
(
  @s_ssn          int = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_user         varchar(30) = null,
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char(1),
  @s_ofi          smallint,
  @s_rol          smallint,
  @s_org_err      char(1)= null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint= null,
  @t_show_version bit = 0,
  @i_filial       tinyint = null,
  @i_oficina      smallint= null,
  @i_operacion    char(1),
  @i_tipo         char(1) = null,
  @i_producto     tinyint = null,
  @i_cuenta       cuenta = null,
  @i_servicio     smallint = null,
  @i_rubro        catalogo = null,
  @i_modo         tinyint = 0
)
as
  declare
    @w_sp_name        varchar(32),
    @w_today          datetime,
    @w_cuenta         int,
    @w_filial         tinyint,
    @w_oficina        smallint,
    @w_sucursal       smallint,
    @w_subtipo        char(1),
    @w_nombre         descripcion,
    @w_servicio       catalogo,
    @w_categoria      char(1),
    @w_producto       tinyint,
    @w_moneda         tinyint,
    @w_prod_banc      smallint,
    @w_tipo_default   char(1),
    @w_default        int,
    @w_rol_ente       char(1),
    @w_disponible     money,
    @w_contable       money,
    @w_promedio       money,
    @w_pro_disponible money,
    @w_personaliza    char(1),
    @w_tipo_ente      char(1),
    @w_valor_contr    float,
    @w_tipo           char(1),
    @w_girar          money,
    @w_tipo_dato      char(1),
    @w_decimal        char(1),
    @w_no_decimal     tinyint,
    @w_sec_costo      int,
    @w_sec_valor      int,
    @w_return         int,
    @w_cta_banco      varchar(16),
    @w_pro_final      smallint,
    @w_des_pro_final  varchar(35),
    @w_tipo_dat       varchar(20),
    @w_serv_dis       int,
    @w_desc_serv      varchar(40),
    @w_desc_tdat      varchar(20)

  select
    @w_sp_name = 'sp_valor_contratado',
    @w_today = @s_date,
    @w_decimal = 'N',
    @w_no_decimal = 0

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**Store Procedure**/' = @w_sp_name,
      s_ssn = @s_ssn,
      s_user = @s_user,
      s_term = @s_term,
      s_date = @s_date,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_ofi = @s_ofi,
      t_file = @t_file,
      t_from = @t_from
    exec cobis..sp_end_debug
  end

  if @i_operacion = 'C'
  begin
    if @t_trn != 4073
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    if @i_producto = 3
    begin
      select
        @w_cuenta = cc_ctacte
      from   cob_cuentas..cc_ctacte
      where  cc_cta_banco = @i_cuenta

      if @@rowcount = 0
      begin
        /* No existe cuenta corriente */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351522
        return 351522
      end

      exec cob_cuentas..sp_calcula_saldo
        @i_cuenta           = @w_cuenta,
        @i_fecha            = @w_today,
        @o_saldo_para_girar = @w_girar out,
        @o_saldo_contable   = @w_contable out

      select
        @w_tipo_ente = cc_tipocta,
        @w_moneda = cc_moneda,
        @w_categoria = cc_categoria,
        @w_prod_banc = cc_prod_banc,
        @w_tipo = cc_tipo,
        @w_tipo_default = cc_tipo_def,
        @w_default = cc_default,
        @w_rol_ente = cc_rol_ente,
        @w_disponible = cc_disponible,
        @w_promedio = cc_promedio1,
        @w_pro_disponible = cc_prom_disponible,
        @w_personaliza = cc_personalizada,
        @w_filial = cc_filial,
        @w_oficina = cc_oficina
      from   cob_cuentas..cc_ctacte
      where  cc_cta_banco = @i_cuenta
    end
    else if @i_producto = 4
    begin
      select
        @w_cuenta = ah_cuenta
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @i_cuenta

      if @@rowcount = 0
      begin
        /* No existe cuenta de ahorro */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351523
        return 351523
      end

      exec cob_ahorros..sp_ahcalcula_saldo
        @i_cuenta           = @w_cuenta,
        @i_fecha            = @w_today,
        @o_saldo_para_girar = @w_girar out,
        @o_saldo_contable   = @w_contable out

      select
        @w_tipo_ente = ah_tipocta,
        @w_tipo = ah_tipo,
        @w_moneda = ah_moneda,
        @w_categoria = ah_categoria,
        @w_prod_banc = ah_prod_banc,
        @w_tipo_default = ah_tipo_def,
        @w_default = ah_default,
        @w_rol_ente = ah_rol_ente,
        @w_disponible = ah_disponible,
        @w_promedio = ah_promedio1,
        @w_pro_disponible = ah_prom_disponible,
        @w_personaliza = ah_personalizada,
        @w_filial = ah_filial,
        @w_oficina = ah_oficina
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @i_cuenta
    end

    select
      @w_servicio = sd_nemonico
    from   pe_servicio_dis
    where  sd_servicio_dis = @i_servicio

    select
      @w_subtipo = of_subtipo
    from   cobis..cl_oficina
    where  of_oficina = @w_oficina

    if @w_subtipo = 'O'
      select
        @w_sucursal = of_regional /*of_oficina */
      from   cobis..cl_oficina
      where  of_oficina = @w_oficina

    if @w_subtipo = 'R'
      select
        @w_sucursal = @w_oficina

    exec @w_return = cob_remesas..sp_genera_costos
      @i_filial      = @w_filial,
      @i_oficina     = @w_oficina,
      @i_categoria   = @w_categoria,
      @i_tipo_ente   = @w_tipo_ente,
      @i_rol_ente    = @w_rol_ente,
      @i_tipo_def    = @w_tipo_default,
      @i_prod_banc   = @w_prod_banc,
      @i_producto    = @i_producto,
      @i_moneda      = @w_moneda,
      @i_tipo        = @w_tipo,
      @i_codigo      = @w_default,
      @i_servicio    = @w_servicio,
      @i_rubro       = @i_rubro,
      @i_disponible  = @w_disponible,
      @i_contable    = @w_contable,
      @i_promedio    = @w_promedio,
      @i_prom_disp   = @w_pro_disponible,
      @i_personaliza = @w_personaliza,
      @i_fecha       = @w_today,
      @o_valor_total = @w_valor_contr out,
      @o_sec_costo   = @w_sec_costo out,
      @o_sec_valor   = @w_sec_valor out

    if @w_return <> 0
    begin
      print '@w_servicio: ' + @w_servicio + ' @i_rubro: ' + @i_rubro
    end

    select
      @w_tipo_dato = vs_tipo_dato
    from   pe_var_servicio,
           pe_servicio_dis
    where  sd_nemonico     = @w_servicio
       and vs_servicio_dis = sd_servicio_dis
       and vs_rubro        = @i_rubro

    select
      @w_decimal = mo_decimales
    from   cobis..cl_moneda
    where  mo_moneda = @w_moneda

    if @w_decimal = 'S'
    begin
      select
        @w_no_decimal = pa_tinyint
      from   cobis..cl_parametro
      where  pa_nemonico = 'DCI'
    end

    if @w_tipo_dato = 'P'
      select
        @w_valor_contr = @w_valor_contr * 100
    else if @w_tipo_dato = 'M'
      select
        @w_valor_contr = round(@w_valor_contr,
                               @w_no_decimal)

    select
      substring(valor,
                1,
                20),
      @w_valor_contr
    from   cobis..cl_tabla a,
           cobis..cl_catalogo b
    where  a.tabla  = 'pe_tipo_dato'
       and b.tabla  = a.codigo
       and b.codigo = @w_tipo_dato
  end

  if @i_operacion = 'H'
  begin
    if @t_trn != 4074
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    if @i_tipo = 'A'
    begin
      set rowcount 15

      select
        'RUBRO' = vs_rubro,
        'DESCRIPCION' = substring(b.valor,
                                  1,
                                  35)
      from   pe_var_servicio,
             cobis..cl_tabla a,
             cobis..cl_catalogo b
      where  vs_servicio_dis = @i_servicio
         and a.tabla         = 'pe_rubro'
         and b.tabla         = a.codigo
         and b.codigo        = vs_rubro
         and vs_rubro        > @i_rubro
      order  by vs_rubro

      set rowcount 0
    end
    else if @i_tipo = 'I'
    begin
      select
        substring(b.valor,
                  1,
                  35)
      from   pe_var_servicio,
             cobis..cl_tabla a,
             cobis..cl_catalogo b
      where  vs_servicio_dis = @i_servicio
         and vs_rubro        = @i_rubro
         and a.tabla         = 'pe_rubro'
         and b.tabla         = a.codigo
         and b.codigo        = vs_rubro

      if @@rowcount = 0
      begin
        /* No existe rubro */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351531
        return 351531
      end
    end
  end

  if @i_operacion = 'Q'
  begin
    if @t_trn != 4074
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    if @i_producto = 3
    begin
      select
        @w_producto = cc_producto,
        @w_moneda = cc_moneda,
        @w_prod_banc = cc_prod_banc,
        @w_tipo = cc_tipo,
        @w_tipo_ente = cc_tipocta,
        @w_oficina = cc_oficina,
        @w_nombre = cc_nombre
      from   cob_cuentas..cc_ctacte
      where  cc_cta_banco = @i_cuenta
         and cc_filial    = @i_filial

      if @@rowcount = 0
      begin
        /* No existe cuenta corriente */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351522
        return 351522
      end
    end
    else if @i_producto = 4
    begin
      select
        @w_producto = ah_producto,
        @w_moneda = ah_moneda,
        @w_prod_banc = ah_prod_banc,
        @w_tipo = ah_tipo,
        @w_tipo_ente = ah_tipocta,
        @w_oficina = ah_oficina,
        @w_nombre = ah_nombre
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @i_cuenta
         and ah_filial    = @i_filial

      if @@rowcount = 0
      begin
        /* No existe cuenta de ahorro */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351523
        return 351523
      end
    end

    select
      @w_subtipo = of_subtipo
    from   cobis..cl_oficina
    where  of_oficina = @w_oficina

    if @w_subtipo = 'O'
      select
        @w_sucursal = of_regional /*of_oficina */
      from   cobis..cl_oficina
      where  of_oficina = @w_oficina

    if @w_subtipo = 'R'
      select
        @w_sucursal = @w_oficina

    select
      @w_nombre,
      pf_pro_final,
      substring(pf_descripcion,
                1,
                35)
    from   pe_pro_final
    where  pf_mercado in
           (select
              me_mercado
            from   pe_mercado
            where  me_pro_bancario = @w_prod_banc
               and me_tipo_ente    = @w_tipo_ente)
           and pf_producto = @w_producto
           and pf_moneda   = @w_moneda
           and pf_tipo     = @w_tipo
           and pf_filial   = @i_filial
           and pf_sucursal = @w_sucursal

    if @@rowcount = 0
    begin
      /* No existe producto final */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351527
      return 351527
    end
  end

  /*** Inicio Cambio
  fecha: 09/04/2002, Ing. Elkin Pulido (Banco)
  Descripcion: Operacion S y T, optimizacion y creacion de busqueda ****/

  if @i_operacion = 'S'
  begin
    if @t_trn != 4073
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    if object_id('##valores_cont') is not null
      drop table ##valores_cont

    create table ##valores_cont
    (
      vc_cuenta        varchar(16) not null,
      vc_nombre        varchar(60) not null,
      vc_pro_final     smallint null,
      vc_des_pro_final varchar(35) null,
      vc_tipo_dat      varchar(20) null,
      vc_valor         money null
    )

    select
      @w_servicio = sd_nemonico
    from   pe_servicio_dis
    where  sd_servicio_dis = @i_servicio

    select
      @w_tipo_dato = vs_tipo_dato
    from   pe_var_servicio,
           pe_servicio_dis
    where  sd_nemonico     = @w_servicio
       and vs_servicio_dis = sd_servicio_dis
       and vs_rubro        = @i_rubro

    set rowcount 21
    if @i_cuenta != '%'
      if @i_modo = 0
          or @i_modo = 3
        set rowcount 1 else
    set rowcount 21

    if @i_producto = 3
    begin
      if object_id('##cc_ctacte') is not null
        drop table ##cc_ctacte

      select
        *
      into   ##cc_ctacte
      from   cob_cuentas..cc_ctacte
      where  cc_ctacte        >= 0
         and cc_cta_banco     >= @i_cuenta
         and cc_personalizada = 'S'
         and cc_ctacte in
             (select
                vc_codigo
              from   cob_remesas..pe_val_contratado
              where  vc_servicio_per in
                     (select
                        sp_servicio_per
                      from   cob_remesas..pe_servicio_per
                      where  sp_servicio_dis = @i_servicio
                         and sp_rubro        = @i_rubro)
                     and vc_producto = 3)
      order  by cc_cta_banco

      if @i_modo = 3
      begin
        declare cuentas cursor for
          select
            cc_ctacte,
            cc_tipocta,
            cc_tipo,
            cc_moneda,
            cc_categoria,
            cc_prod_banc,
            cc_tipo_def,
            cc_default,
            cc_rol_ente,
            cc_disponible,
            cc_promedio1,
            cc_prom_disponible,
            cc_personalizada,
            cc_filial,
            cc_oficina,
            cc_nombre,
            cc_cta_banco,
            cc_12h + cc_24h + cc_remesas + cc_disponible
          from   ##cc_ctacte
          for read only
      end
      else
      begin
        declare cuentas cursor for
          select
            cc_ctacte,
            cc_tipocta,
            cc_tipo,
            cc_moneda,
            cc_categoria,
            cc_prod_banc,
            cc_tipo_def,
            cc_default,
            cc_rol_ente,
            cc_disponible,
            cc_promedio1,
            cc_prom_disponible,
            cc_personalizada,
            cc_filial,
            cc_oficina,
            cc_nombre,
            cc_cta_banco,
            cc_12h + cc_24h + cc_remesas + cc_disponible
          from   ##cc_ctacte
          where  cc_cta_banco > @i_cuenta
          for read only

      end
    end
    else if @i_producto = 4
    begin
      if object_id('##ah_cuenta') is not null
        drop table ##ah_cuenta

      select
        *
      into   ##ah_cuenta
      from   cob_ahorros..ah_cuenta
      where  ah_cuenta        >= 0
         and ah_cta_banco     >= @i_cuenta
         and ah_personalizada = 'S'
         and ah_cuenta in
             (select
                vc_codigo
              from   cob_remesas..pe_val_contratado
              where  vc_servicio_per in
                     (select
                        sp_servicio_per
                      from   cob_remesas..pe_servicio_per
                      where  sp_servicio_dis = @i_servicio
                         and sp_rubro        = @i_rubro)
                     and vc_producto = 4)
      order  by ah_cta_banco

      if @i_modo = 3
      begin
        declare cuentas cursor for
          select
            ah_cuenta,
            ah_tipocta,
            ah_tipo,
            ah_moneda,
            ah_categoria,
            ah_prod_banc,
            ah_tipo_def,
            ah_default,
            ah_rol_ente,
            ah_disponible,
            ah_promedio1,
            ah_prom_disponible,
            ah_personalizada,
            ah_filial,
            ah_oficina,
            ah_nombre,
            ah_cta_banco,
            ah_12h + ah_24h + ah_remesas + ah_disponible
          from   ##ah_cuenta
          for read only
      end
      else
      begin
        declare cuentas cursor for
          select
            ah_cuenta,
            ah_tipocta,
            ah_tipo,
            ah_moneda,
            ah_categoria,
            ah_prod_banc,
            ah_tipo_def,
            ah_default,
            ah_rol_ente,
            ah_disponible,
            ah_promedio1,
            ah_prom_disponible,
            ah_personalizada,
            ah_filial,
            ah_oficina,
            ah_nombre,
            ah_cta_banco,
            ah_12h + ah_24h + ah_remesas + ah_disponible
          from   ##ah_cuenta
          where  ah_cta_banco > @i_cuenta
          for read only
      end
    end

    open cuentas
    fetch cuentas into @w_cuenta,
                       @w_tipo_ente,
                       @w_tipo,
                       @w_moneda,
                       @w_categoria,
                       @w_prod_banc,
                       @w_tipo_default,
                       @w_default,
                       @w_rol_ente,
                       @w_disponible,
                       @w_promedio,
                       @w_pro_disponible,
                       @w_personaliza,
                       @w_filial,
                       @w_oficina,
                       @w_nombre,
                       @w_cta_banco,
                       @w_contable

    while @@fetch_status <> 0
    begin
      /* Control de error de lectura del cursor */
      if @@fetch_status = -2
      begin
        /* Error en lectura de cuentas */
        exec cobis..sp_cerror
          @i_num = 351037,
          @i_sev = 1

        /* Cerrar y liberar cursor */
        close cuentas
        deallocate cuentas
        return 351037
      end

      select
        @w_subtipo = of_subtipo
      from   cobis..cl_oficina
      where  of_oficina = @w_oficina

      /*if @w_subtipo = 'S'
      select @w_sucursal = @w_oficina
      else if @w_subtipo = 'A'
          select @w_sucursal = of_sucursal from cobis..cl_oficina
           where of_oficina = @w_oficina*/

      if @w_subtipo = 'O'
        select
          @w_sucursal = of_regional /*of_oficina */
        from   cobis..cl_oficina
        where  of_oficina = @w_oficina

      if @w_subtipo = 'R'
        select
          @w_sucursal = @w_oficina

      exec cob_remesas..sp_genera_costos
        @i_filial      = @w_filial,
        @i_oficina     = @w_oficina,
        @i_categoria   = @w_categoria,
        @i_tipo_ente   = @w_tipo_ente,
        @i_rol_ente    = @w_rol_ente,
        @i_tipo_def    = @w_tipo_default,
        @i_prod_banc   = @w_prod_banc,
        @i_producto    = @i_producto,
        @i_moneda      = @w_moneda,
        @i_tipo        = @w_tipo,
        @i_codigo      = @w_default,
        @i_servicio    = @w_servicio,
        @i_rubro       = @i_rubro,
        @i_disponible  = @w_disponible,
        @i_contable    = @w_contable,
        @i_promedio    = @w_promedio,
        @i_prom_disp   = @w_pro_disponible,
        @i_personaliza = @w_personaliza,
        @i_fecha       = @w_today,
        @o_valor_total = @w_valor_contr out,
        @o_sec_costo   = @w_sec_costo out,
        @o_sec_valor   = @w_sec_valor out

      select
        @w_decimal = mo_decimales
      from   cobis..cl_moneda
      where  mo_moneda = @w_moneda

      if @w_decimal = 'S'
        select
          @w_no_decimal = pa_tinyint
        from   cobis..cl_parametro
        where  pa_nemonico = 'DCI'

      if @w_tipo_dato = 'P'
        select
          @w_valor_contr = @w_valor_contr * 100
      else if @w_tipo_dato = 'M'
        select
          @w_valor_contr = round(@w_valor_contr,
                                 @w_no_decimal)

      select
        @w_tipo_dat = substring(valor,
                                1,
                                20)
      from   cobis..cl_tabla a,
             cobis..cl_catalogo b
      where  a.tabla  = 'pe_tipo_dato'
         and b.tabla  = a.codigo
         and b.codigo = @w_tipo_dato

      select
        @w_pro_final = pf_pro_final,
        @w_des_pro_final = substring(pf_descripcion,
                                     1,
                                     35)
      from   pe_pro_final
      where  pf_mercado in
             (select
                me_mercado
              from   pe_mercado
              where  me_pro_bancario = @w_prod_banc
                 and me_tipo_ente    = @w_tipo_ente)
             and pf_producto = @i_producto
             and pf_moneda   = @w_moneda
             and pf_tipo     = @w_tipo
             and pf_filial   = @w_filial
             and pf_sucursal = @w_sucursal

      if @@rowcount != 0
        insert into ##valores_cont
        values      (@w_cta_banco,@w_nombre,@w_pro_final,@w_des_pro_final,
                     @w_tipo_dat,
                     @w_valor_contr)

      fetch cuentas into @w_cuenta,
                         @w_tipo_ente,
                         @w_tipo,
                         @w_moneda,
                         @w_categoria,
                         @w_prod_banc,
                         @w_tipo_default,
                         @w_default,
                         @w_rol_ente,
                         @w_disponible,
                         @w_promedio,
                         @w_pro_disponible,
                         @w_personaliza,
                         @w_filial,
                         @w_oficina,
                         @w_nombre,
                         @w_cta_banco,
                         @w_contable

    end

    close cuentas
    deallocate cuentas

    set rowcount 20
    select
      'CUENTA' = vc_cuenta,
      'NOMBRE CUENTA' = vc_nombre,
      'PRODUCTO FINAL' = vc_pro_final,
      'DESCRIPCION PROD. FINAL' = vc_des_pro_final,
      'TIPO DE DATO' = vc_tipo_dat,
      'VALOR' = vc_valor
    from   ##valores_cont
  end

  if @i_operacion = 'T'
  begin
    if @t_trn != 4073
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    if object_id('##servicio') is not null
      drop table ##servicio

    create table ##servicio
    (
      servicio    smallint not null,
      nservicio   varchar(10) not null,
      rubro       varchar(10) not null,
      desc_serv   varchar(40) null,
      tipo_dato   varchar(1) null,
      desc_tdat   varchar(20) null,
      valor_contr money not null
    )

    if @i_producto = 3
    begin
      select
        @w_cuenta = cc_ctacte,
        @w_tipo_ente = cc_tipocta,
        @w_moneda = cc_moneda,
        @w_categoria = cc_categoria,
        @w_prod_banc = cc_prod_banc,
        @w_tipo = cc_tipo,
        @w_tipo_default = cc_tipo_def,
        @w_default = cc_default,
        @w_rol_ente = cc_rol_ente,
        @w_disponible = cc_disponible,
        @w_promedio = cc_promedio1,
        @w_pro_disponible = cc_prom_disponible,
        @w_personaliza = cc_personalizada,
        @w_filial = cc_filial,
        @w_oficina = cc_oficina,
        @w_contable = cc_12h + cc_24h + cc_remesas + cc_disponible
      from   cob_cuentas..cc_ctacte
      where  cc_cta_banco = @i_cuenta
    end
    else if @i_producto = 4
    begin
      select
        @w_cuenta = ah_cuenta,
        @w_tipo_ente = ah_tipocta,
        @w_tipo = ah_tipo,
        @w_moneda = ah_moneda,
        @w_categoria = ah_categoria,
        @w_prod_banc = ah_prod_banc,
        @w_tipo_default = ah_tipo_def,
        @w_default = ah_default,
        @w_rol_ente = ah_rol_ente,
        @w_disponible = ah_disponible,
        @w_promedio = ah_promedio1,
        @w_pro_disponible = ah_prom_disponible,
        @w_personaliza = ah_personalizada,
        @w_filial = ah_filial,
        @w_oficina = ah_oficina,
        @w_contable = ah_12h + ah_24h + ah_remesas + ah_disponible
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @i_cuenta
    end

    select
      @w_subtipo = of_subtipo
    from   cobis..cl_oficina
    where  of_oficina = @w_oficina

    if @w_subtipo = 'O'
      select
        @w_sucursal = of_regional /*of_oficina */
      from   cobis..cl_oficina
      where  of_oficina = @w_oficina

    if @w_subtipo = 'R'
      select
        @w_sucursal = @w_oficina

    select
      @w_decimal = mo_decimales
    from   cobis..cl_moneda
    where  mo_moneda = @w_moneda

    if @w_decimal = 'S'
    begin
      select
        @w_no_decimal = pa_tinyint
      from   cobis..cl_parametro
      where  pa_nemonico = 'DCI'
    end

    declare servicios cursor for
      select distinct
        vc_servicio_per,
        sp_rubro
      from   cob_remesas..pe_val_contratado,
             cob_remesas..pe_servicio_per
      where  sp_servicio_per = vc_servicio_per
         and vc_tipo_default = @w_tipo_default
         and vc_rol          = @w_tipo_ente
         and vc_codigo       = @w_cuenta
         and vc_producto     = @i_producto
         and vc_categoria    = @w_categoria
      for read only

    open servicios
    fetch servicios into @i_servicio, @i_rubro

    while @@fetch_status <> 0
    begin
      /* Control de error de lectura del cursor */
      if @@fetch_status = -2
      begin
        /* Error en lectura de cuentas */
        exec cobis..sp_cerror
          @i_num = 351037,
          @i_sev = 1

        /* Cerrar y liberar cursor */
        close cuentas
        deallocate cuentas
        return 351037
      end

      select
        @w_servicio = sd_nemonico,
        @w_serv_dis = sd_servicio_dis
      from   pe_servicio_dis,
             pe_servicio_per
      where  sd_servicio_dis = sp_servicio_dis
         and sp_servicio_per = @i_servicio
         and sp_rubro        = @i_rubro

      exec cob_remesas..sp_genera_costos
        @i_filial      = @w_filial,
        @i_oficina     = @w_oficina,
        @i_categoria   = @w_categoria,
        @i_tipo_ente   = @w_tipo_ente,
        @i_rol_ente    = @w_rol_ente,
        @i_tipo_def    = @w_tipo_default,
        @i_prod_banc   = @w_prod_banc,
        @i_producto    = @i_producto,
        @i_moneda      = @w_moneda,
        @i_tipo        = @w_tipo,
        @i_codigo      = @w_default,
        @i_servicio    = @w_servicio,
        @i_rubro       = @i_rubro,
        @i_disponible  = @w_disponible,
        @i_contable    = @w_contable,
        @i_promedio    = @w_promedio,
        @i_prom_disp   = @w_pro_disponible,
        @i_personaliza = @w_personaliza,
        @i_fecha       = @w_today,
        @o_valor_total = @w_valor_contr out,
        @o_sec_costo   = @w_sec_costo out,
        @o_sec_valor   = @w_sec_valor out

      select
        @w_tipo_dato = vs_tipo_dato,
        @w_desc_serv = vs_descripcion
      from   pe_var_servicio,
             pe_servicio_dis
      where  sd_nemonico     = @w_servicio
         and vs_servicio_dis = sd_servicio_dis
         and vs_rubro        = @i_rubro

      if @w_tipo_dato = 'P'
        select
          @w_valor_contr = @w_valor_contr * 100
      else if @w_tipo_dato = 'M'
        select
          @w_valor_contr = round(@w_valor_contr,
                                 @w_no_decimal)

      select
        @w_desc_tdat = substring(valor,
                                 1,
                                 20)
      from   cobis..cl_tabla a,
             cobis..cl_catalogo b
      where  a.tabla  = 'pe_tipo_dato'
         and b.tabla  = a.codigo
         and b.codigo = @w_tipo_dato

      insert into ##servicio
      values      (@w_serv_dis,@w_servicio,@i_rubro,@w_desc_serv,@w_tipo_dato,
                   @w_desc_tdat,@w_valor_contr)

      fetch servicios into @i_servicio, @i_rubro
    end
    close servicios
    deallocate servicios

    select
      'SERVICIO' = servicio,
      'NEMONICO' = nservicio,
      'RUBRO' = rubro,
      'DESCRIPCION DEL SERVICIO' = desc_serv,
      'TIPO DE DATO' = tipo_dato,
      'DESC. TIPO DATO' = desc_tdat,
      'VALOR' = valor_contr
    from   ##servicio
  end
  /** Fin Cambio **/

  return 0

GO 
