/************************************************************************/
/*  Archivo:            ahndcind.sp                                     */
/*  Stored procedure:   sp_ahndc_indicador                              */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas Corrientes                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 12-Ene-1993                                     */
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
/*                              PROPOSITO                               */
/************************************************************************/
/*  Este programa procesa las ND y NC con indicador                     */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA           AUTOR           RAZON                               */
/*  18/Feb/2002     M Sanguino      Emision inicial                     */
/*  29/01/2002      G.Rueda         Ignorar la validacion de cuenta     */
/*                                  invÂ lida para cuentas de ahorro     */
/*                                  programado y cuotas alimentarias    */
/*  04/Oct/2003     G. Rueda        Retornar codigos de error           */
/*  02/May/2016     J. Calderon     Migración a CEN                     */
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
           where  name = 'sp_ahndc_indicador')
  drop proc sp_ahndc_indicador
go

create proc sp_ahndc_indicador
(
  @s_srv           varchar(30),
  @s_ofi           smallint,
  @s_ssn           int,
  @s_ssn_branch    int = null,
  @s_user          varchar(30) = 'AHO',
  @s_term          varchar(10) ='consola',
  @t_show_version  bit = 0,
  @t_trn           int,
  @t_from          varchar(32) = null,
  @t_ejec          char(1) = null,
  @t_corr          char(1) = 'N',
  @t_ssn_corr      int = null,
  @i_cta           cuenta,
  @i_val           money = 0,
  @i_cau           char(3),
  @i_mon           tinyint,
  @i_fecha         datetime = null,
  @i_alt           int = 0,
  @i_cobsus        char(1) = 'N',
  @i_cobra_icc     char(1) = 'N',
  @i_inmovi        char(1) = 'N',
  @i_comision      money = null,
  @i_vlr_com       money = null,
  @i_papel         money = null,
  @i_ind           int = 1,
  @i_cobiva        char(1) = 'N',
  @i_corr          char(1) = 'N',
  @i_canal         tinyint = 4,
  @i_afecta_minimo char(1) = 'N',
  @i_accion        char(1) = 'E',
  @i_reverso       char(1) = null,
  @i_impues_trans  smallint = null,
  @i_modulo        smallint = null,
  @i_fid_batch     char(1) = 'N',
  @i_factor        smallint = 1,
  @i_dif           char(1) = 'N',
  @o_valiva        money = null out
)
as
  declare
    @w_return           int,
    @w_cuenta           int,
    @w_sp_name          varchar(30),
    @w_oficial          smallint,
    @w_oficina_p        smallint,
    @w_tipo_promedio    char(1),
    @w_alicuota         numeric(11, 10),
    @w_interes          float,
    @w_sec              int,
    @w_debitos          money,
    @w_mov_deb          money,
    @w_creditos         money,
    @w_mov_cre          money,
    @w_alic             money,
    @w_disponible       money,
    @w_saldo_minimo     money,
    @w_val              money,
    @w_promedio1        money,
    @w_mon              tinyint,
    @w_suspensos        smallint,
    @w_valor            money,
    @w_val_efe          money,
    @w_acum             money,
    @w_numdeci          tinyint,
    @w_contador         smallint,
    @w_mensaje          mensaje,
    @w_tipo_bloqueo     varchar(3),
    @w_saldo_para_girar money,
    @w_saldo_contable   money,
    @w_categoria        char(1),
    @w_factor           float,
    @w_tfactor          smallint,
    @w_trn_sus          smallint,
    @w_signo            char(1),
    @w_tipo1            char(1),
    @w_accion           char(1),
    @w_usadeci          char(1),
    @w_debhoy           money,
    @w_credhoy          money,
    @w_prom_disp        money,
    @w_causa_vs         int,
    @w_estado           char(1),
    @w_signo_icc        char(1),
    @w_tasa_icc         float,
    @w_reg_icc          char(1),
    @w_accion_nc        char(1),
    @w_val_icc          money,
    @w_trn              int,
    @w_concepto_icc     varchar(30),
    @w_cliente          int,
    @w_clase_clte       char(1),
    @w_prod_banc        tinyint,
    @w_marca            char(1),
    @w_ncredmes         int,
    @w_ndebmes          int,
    @w_piva             float,
    @w_val_total        money,
    @w_reg_imp2x1000    char(1),
    @w_imp_2x1000       float,
    @w_val_2x1000       money,
    @w_impuesto         money,
    @w_timpuesto        float,
    @w_sldmin           money,
    @w_comision         char(1),
    @w_valimp           money,
    @w_valemer          money,
    @w_valcom           money,
    @w_debitos_mes      money,
    @w_pensionado       char(1),
    @w_numdeciimp       tinyint,
    @w_hora_hoy         smallint,
    @w_hora_fin         smallint,
    @w_prod_fid         smallint,
    @w_causa_blq        varchar(3),
    @w_12h              money,
    @w_12h_dif          money,
    @w_24h              money,
    @w_24h_dif          money,
    @w_48h              money,
    @w_ciudad           int,
    @w_fecha_efe        smalldatetime,
    @w_fecpro           smalldatetime,
    @w_remesas          money,
    @w_rem_hoy          money,
    @w_cont             tinyint,
    @w_dias_ret         tinyint,
    @w_tipocta_super    char(1),
    @w_ctahabiente      char(2) -- GLRS 29/01/2003

  select
    @w_sp_name = 'sp_ahndc_indicador'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ahndc_indicador'
  select
    @w_fecpro = @i_fecha

  /* Transaccion con Valor cero */
  if @i_val = 0
     and @i_comision = 0
  begin
    exec cobis..sp_cerror
      @t_debug = null,
      @t_file  = null,
      @t_from  = @w_sp_name,
      @i_num   = 251068
    return 251068
  end

  /* Encuentra parametro de decimales */
  select
    @w_usadeci = mo_decimales
  from   cobis..cl_moneda
  where  mo_moneda = @i_mon

  if @w_usadeci = 'S'
  begin
    select
      @w_numdeci = pa_tinyint
    from   cobis..cl_parametro
    where  pa_nemonico = 'DCI'
       and pa_producto = 'AHO'

    select
      @w_numdeciimp = pa_tinyint
    from   cobis..cl_parametro
    where  pa_nemonico = 'DIM'
       and pa_producto = 'AHO'

  end
  else
    select
      @w_numdeci = 0,
      @w_numdeciimp = 0

  if @t_trn = 253
  begin
    if not exists (select
                     1
                   from   cobis..cl_catalogo
                   where  tabla in
                          (select
                             codigo
                           from   cobis..cl_tabla
                           where  tabla in ('ah_causa_nc'))
                          and codigo = @i_cau)
    begin
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 201030
      return 201030
    end
  end
  else
  begin
    if not exists (select
                     1
                   from   cobis..cl_catalogo
                   where  tabla in
                          (select
                             codigo
                           from   cobis..cl_tabla
                           where  tabla in ('ah_causa_nd'))
                          and codigo = @i_cau)
    begin
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 201030
      return 201030
    end
  end

/* Trae porcentaje de IVA y calcula el valor sobre la comision  + IVA*/
  -- ARV ABRIL/05/2001

  select
    @w_comision = 'N'
  select
    @w_impuesto = 0,
    @w_timpuesto = 0,
    @o_valiva = 0

  if @t_trn = 264
      or (@t_trn = 253
          and @i_corr = 'S'
          and @i_cobiva = 'S')
  begin
    select
      @w_comision = an_comision
    from   cob_remesas..re_accion_nd
    where  an_producto = 4
       and an_causa    = @i_cau

    if @@rowcount = 0
    begin
      select
        @w_impuesto = 0,
        @w_timpuesto = 0,
        @o_valiva = 0
    end

    if @w_comision = 'N'
      select
        @w_trn_sus = 329
  end

  /* Determina factor para hacer credito o debito */
  select
    @w_trn = @t_trn
  select
    @w_concepto_icc = convert(varchar(20), @t_trn) + '|' + @i_cau
  if @t_trn = 253
    select
      @w_tfactor = 1,
      @w_tipo1 = 'C',
      @w_signo_icc = 'D',
      @w_factor = 1
  if @t_trn = 264
    select
      @w_tfactor = -1,
      @w_tipo1 = '2',
      @w_signo = 'D',
      @w_signo_icc = 'C',
      @w_factor = -1

  select
    @w_estado = ah_estado,
    @w_cuenta = ah_cuenta,
    @w_oficina_p = ah_oficina,
    @w_tipo_promedio = ah_tipo_promedio,
    @w_oficial = ah_oficial,
    @w_prod_banc = ah_prod_banc,
    @w_cliente = ah_cliente,
    @w_mon = ah_moneda,
    @w_disponible = ah_disponible,
    @w_suspensos = ah_suspensos,
    @w_categoria = ah_categoria,
    @w_promedio1 = ah_promedio1,
    @w_debitos = ah_debitos,
    @w_creditos = ah_creditos,
    @w_debhoy = ah_debitos_hoy,
    @w_credhoy = ah_creditos_hoy,
    @w_prom_disp = ah_prom_disponible,
    @w_tipo_promedio = ah_tipo_promedio,
    @w_ncredmes = ah_num_cred_mes,
    @w_ndebmes = ah_num_deb_mes,
    @w_clase_clte = ah_clase_clte,
    @w_reg_imp2x1000 = ah_nxmil,-- EAA 19/Abr/01 CC00179
    @w_prod_banc = ah_prod_banc,
    @w_12h = ah_12h,
    @w_12h_dif = ah_12h_dif,
    @w_24h = ah_24h,
    @w_48h = ah_48h,
    @w_remesas = ah_remesas,
    @w_rem_hoy = ah_rem_hoy,
    @w_tipocta_super = ah_tipocta_super
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta
     and ah_moneda    = @i_mon

  if @@rowcount = 0
  begin
    /* No existe cuenta de ahorro */
    exec cobis..sp_cerror
      @t_debug= null,
      @t_file = null,
      @t_from = @w_sp_name,
      @i_num  = 251001
    return 251001
  end

  if @w_estado = 'C'
  begin
    /*  Cuenta de ahorros cerrada */

    exec cobis..sp_cerror
      @t_debug= null,
      @t_file = null,
      @t_from = @w_sp_name,
      @i_num  = 251057
    return 251057
  end

  if @i_inmovi = 'N'
     and @w_estado = 'I'
  begin
    /*  Cuenta de ahorros inmovilizada */
    exec cobis..sp_cerror
      @t_debug= null,
      @t_file = null,
      @t_from = @w_sp_name,
      @i_num  = 251058
    return 251058

  end
  /*  Determinacion de bloqueo de cuenta  */
  select
    @w_tipo_bloqueo = cb_tipo_bloqueo,
    @w_causa_blq = cb_causa
  from   cob_ahorros..ah_ctabloqueada
  where  cb_cuenta = @w_cuenta
     and cb_estado = 'V'

  -- Solamente para los modulos que necesiten la validacion de cliente fallecido
  if @w_causa_blq = '9'
     and @i_modulo is not null
  begin
    /*  Cuenta de ahorros bloqueada por cliente fallecido */
    exec cobis..sp_cerror
      @t_debug= null,
      @t_file = null,
      @t_from = @w_sp_name,
      @i_num  = 251081
    return 251081
  end

  if @w_tipo_bloqueo = @w_tipo1
      or @w_tipo_bloqueo = '3'
  begin
    select
      @w_mensaje = rtrim(valor)
    from   cobis..cl_catalogo
    where  tabla  = (select
                       codigo
                     from   cobis..cl_tabla
                     where  tabla = 'ah_tbloqueo')
       and codigo = @w_tipo_bloqueo
    select
      @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje
    exec cobis..sp_cerror
      @t_debug = null,
      @t_file  = null,
      @t_from  = @w_sp_name,
      @i_num   = 251025,
      @i_sev   = 1,
      @i_msg   = @w_mensaje
    return 251025
  end

  /* Calcular el saldo */
  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_from             = @w_sp_name,
    @i_cuenta           = @w_cuenta,
    @i_fecha            = @i_fecha,
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_saldo_contable out

  if @w_return <> 0
    return @w_return

  /*  Validacion de la moneda */
  if @i_mon <> @w_mon
  begin
    exec cobis..sp_cerror
      @t_debug = null,
      @t_file  = null,
      @t_from  = @w_sp_name,
      @i_num   = 251050
    return 251050
  end

  /* Encuentra alicuota del promedio */
  select
    @w_alicuota = fp_alicuota
  from   cob_cuentas..cc_fecha_promedio
  where  fp_tipo_promedio = @w_tipo_promedio
     and fp_fecha_inicio  = @w_fecpro
  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
      @t_debug = null,
      @t_file  = null,
      @t_from  = @w_sp_name,
      @i_num   = 251012
    return 251012
  end

  /* Asigna variables de origen de la transaccion */
  if @t_trn = 253
    if @i_corr = 'S'
      select
        @w_val_efe = isnull(@i_val,
                            0) + (isnull(@i_comision, 0) + isnull(@w_impuesto, 0
                                  )
                                 )
    else
      select
        @w_val_efe = isnull(@i_val,
                            0) - (isnull(@i_comision, 0) + isnull(@w_impuesto, 0
                                  )
                                 )

  if @t_trn = 264
    if @i_corr = 'S'
      select
        @w_val_efe = isnull(@i_val,
                            0) - (isnull(@i_comision, 0) + isnull(@w_impuesto, 0
                                  )
                                 )
    else
      select
        @w_val_efe = isnull(@i_val,
                            0) + (isnull(@i_comision, 0) + isnull(@w_impuesto, 0
                                  )
                                 )

  select
    @w_val = $0,
    @w_val_total = @w_val_efe

  select
    @w_val_2x1000 = $0

  select
    @w_val_total = @w_val_total + @w_val_2x1000

  begin tran
  /* Validar Fondos para Notas de Debito */
  if @t_trn = 264
  begin
    if @i_ind = 2
       and @i_val > @w_12h
       and @i_factor = 1 -- CHEQUES PROPIOS
    begin
      exec cobis..sp_cerror
        @t_debug = null,
        @t_from  = @w_sp_name,
        @i_num   = 201026
      return 201026
    end
    if @i_ind = 3
       and @i_val > @w_24h
       and @i_factor = 1 --CHEQUES LOCALES
    begin
      exec cobis..sp_cerror
        @t_debug = null,
        @t_from  = @w_sp_name,
        @i_num   = 201229
      return 201229
    end
    if @i_ind = 4
       and @i_val > @w_remesas
       and @i_factor = 1 --CHEQUES REMESAS
    begin
      exec cobis..sp_cerror
        @t_debug = null,
        @t_from  = @w_sp_name,
        @i_num   = 201027
      return 201027
    end

  end
  else if @t_trn not in(264, 253, 229)
     and (@i_val + isnull(@i_comision, 0)) > @w_saldo_para_girar
    return 201115

  -- EMO ICC Enero 2000
  if @i_cobra_icc = 'S'
  begin
    select
      @w_reg_icc = en_retencion
    from   cobis..cl_ente
    where  en_ente = @w_cliente

    if @w_reg_icc = 'S'
    begin
      select
        @w_tasa_icc = pa_float
      from   cobis..cl_parametro
      where  pa_nemonico = 'ICC'
         and pa_producto = 'AHO'

      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
          /*@t_debug = @t_debug,
          @t_file  = @t_file,*/
          @t_from = @t_from,
          @i_num  = 201196
        return 201196
      end
    end
    else
      select
        @w_tasa_icc = 0,
        @w_val_icc = 0

    -- Causa de nota de credito
    select
      @w_accion_nc = an_accion
    from   cob_remesas..re_accion_nc
    where  an_producto = 4
       and an_causa    = @i_cau

    if @@rowcount = 0
      select
        @w_accion_nc = 'S'

    if (@w_reg_icc = 'S'
        and @w_accion_nc = 'S')
    begin
      select
        @w_val_icc = round((@w_val_total * isnull(@w_tasa_icc,
                                                  0)) / 100,
                           @w_numdeci)
      select
        @w_val_total = @w_val_total - isnull(@w_val_icc,
                                             0)
    end

  end
  else
    select
      @w_val_icc = 0
  -- II ARV Ago 06/2001 POR ATM

  /* Actualizacion de tabla de cuentas corrientes */
  select
    @w_alic = @w_val_total * @w_alicuota

  if @w_signo = 'D'
    select
      @w_debitos = @w_debitos + @w_val_total,
      @w_debhoy = @w_debhoy + @w_val_total,
      @w_ndebmes = @w_ndebmes + 1
  -- @w_sldmin = @w_sldmin  - @w_val_total

  else
    select
      @w_creditos = @w_creditos + @w_val_total,
      @w_credhoy = @w_credhoy + @w_val_total,
      @w_ncredmes = @w_ncredmes + 1

  if @i_ind = 1
  begin
    select
      @w_promedio1 = @w_promedio1 + round(@w_alic,
                                          @w_numdeci) * @w_tfactor
    select
      @w_prom_disp = @w_prom_disp + round(@w_alic,
                                          @w_numdeci) * @w_tfactor
    select
      @w_disponible = @w_disponible + @w_val_total * @w_tfactor

  end

  select
    @w_saldo_contable = @w_saldo_contable + @w_val_total * @w_tfactor
  select
    @w_saldo_para_girar = @w_saldo_para_girar + @w_val_total * @w_tfactor

  if @i_ind = 2
  begin
    select
      @w_12h = @w_12h + (@i_val * @i_factor * @w_factor)

    if @i_dif = 'S'
      select
        @w_12h_dif = @w_12h_dif + (@i_val * @i_factor * @w_factor)
  end
  else if @i_ind = 3
  begin
    /* Determinar la ciudad de deposito */

    select
      @w_ciudad = of_ciudad
    from   cobis..cl_oficina
    where  of_filial  = 1
       and of_oficina = @s_ofi

    select
      @w_24h = @w_24h + @i_val * @i_factor * @w_factor

    /* Determinar el numero de dias de retencion para la ciudad */

    select
      @w_dias_ret = cr_dias
    from   cob_remesas..re_ciudad_retencion
    where  cr_ciudad = @w_ciudad

    if @@rowcount = 0
    begin
      /* Determinar el parametro general */

      select
        @w_dias_ret = pa_tinyint
      from   cobis..cl_parametro
      where  pa_producto = 'AHO'
         and pa_nemonico = 'DIRE'

      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
          @t_debug = null,
          @t_from  = @w_sp_name,
          @i_num   = 205001
        return 205001
      end

    end

  /* Determinar la fecha de efectivizacion del deposito */
    -- if @i_dif = 'S'
    --select @w_dias_ret = @w_dias_ret + 1
    --    select @w_fecha_efe = dateadd(dd,1,@i_fecha),
    --           @w_cont = 1
    --
    --while @w_cont < @w_dias_ret
    --begin
    --   if exists (select df_fecha from cobis..cl_dias_feriados
    --               where df_ciudad = @w_ciudad
    --                 and df_fecha  = @w_fecha_efe)
    --     select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
    --   else
    --   begin
    --      select @w_cont = @w_cont + 1
    --      if @w_cont < @w_dias_ret
    --         select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
    --   end
    --end

    exec @w_return = cob_remesas..sp_fecha_habil
      @i_val_dif   = 'N',
      @i_efec_dia  = 'S',
      @i_fecha     = @i_fecha,
      @i_oficina   = @s_ofi,
      @i_dif       = @i_dif,/**** Ingreso en  horario normal  ***/
      @w_dias_ret  = @w_dias_ret,/*** Dias siguientes habil ***/
      @o_ciudad    = @w_ciudad out,
      @o_fecha_sig = @w_fecha_efe out

    if @w_return <> 0
      return @w_return

    /* Corregir el deposito en la tabla de depositos */

    if not exists (select
                     cd_cuenta
                   from   cob_ahorros..ah_ciudad_deposito
                   where  cd_cuenta     = @w_cuenta
                      and cd_ciudad     = @w_ciudad
                      and cd_fecha_depo = @i_fecha
                      and cd_fecha_efe  = @w_fecha_efe)
    begin
      insert into cob_ahorros..ah_ciudad_deposito
                  (cd_cuenta,cd_ciudad,cd_fecha_depo,cd_fecha_efe,cd_valor,
                   cd_valor_efe)
      values      (@w_cuenta,@w_ciudad,@i_fecha,@w_fecha_efe,@i_val,
                   @i_val)

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = null,
          @t_from  = @w_sp_name,
          @i_num   = 205001
        return 205001
      end

    end
    else
    begin
      if @t_trn = 253
      begin
        update cob_ahorros..ah_ciudad_deposito
        set    cd_valor = cd_valor + (@i_val * @i_factor * @w_factor),
               cd_valor_efe = cd_valor_efe + (@i_val * @i_factor * @w_factor)
        where  cd_cuenta     = @w_cuenta
           and cd_ciudad     = @w_ciudad
           and cd_fecha_depo = @i_fecha
           and cd_fecha_efe  = @w_fecha_efe

        if @@rowcount <> 1
        begin
          exec cobis..sp_cerror
            @t_debug = null,
            @t_from  = @w_sp_name,
            @i_num   = 205001
          return 205001
        end
      end
      if @t_trn = 264
      begin
        update cob_ahorros..ah_ciudad_deposito
        set    cd_valor = cd_valor + (@i_val * @i_factor * @w_factor),
               cd_valor_efe = cd_valor_efe + (@i_val * @i_factor * @w_factor)
        where  cd_cuenta     = @w_cuenta
           and cd_ciudad     = @w_ciudad
           and cd_fecha_depo = @i_fecha
           and cd_fecha_efe  = @w_fecha_efe
           and cd_valor      >= @i_val

        if @@rowcount <> 1
        begin
          exec cobis..sp_cerror
            @t_debug = null,
            @t_from  = @w_sp_name,
            @i_num   = 205001
          return 205001
        end
      end
    end
  end
  else
    select
      @w_remesas = @w_remesas + @i_val * @i_factor * @w_factor,
      @w_rem_hoy = @w_rem_hoy + @i_val * @i_factor * @w_factor

  if @w_val_total <> 0
  begin
    update cob_ahorros..ah_cuenta
    set    ah_promedio1 = @w_promedio1,
           ah_12h = @w_12h,
           ah_12h_dif = @w_12h_dif,
           ah_24h = @w_24h,
           ah_remesas = @w_remesas,
           ah_rem_hoy = @w_rem_hoy,
           ah_contador_trx = ah_contador_trx + 1,
           ah_debitos_hoy = @w_debhoy,
           ah_creditos_hoy = @w_credhoy,
           ah_prom_disponible = @w_prom_disp,
           ah_num_cred_mes = @w_ncredmes,
           ah_num_deb_mes = @w_ndebmes,
           ah_fecha_ult_mov = @i_fecha
    where  ah_cuenta = @w_cuenta
    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @t_debug = null,
        @t_file  = null,
        @t_from  = @w_sp_name,
        @i_num   = 205001
      return 205001
    end

    /* Transaccion Monetaria */
    insert into cob_ahorros..ah_notcredeb
                (secuencial,alterno,tipo_tran,oficina,usuario,
                 terminal,correccion,sec_correccion,reentry,origen,
                 nodo,fecha,cta_banco,signo,indicador,
                 remoto_ssn,moneda,causa,fecha_efec,valor,
                 control,interes,saldocont,saldodisp,saldoint,
                 departamento,oficina_cta,prod_banc,clase_clte,canal,
                 oficial,val_cheque,ssn_branch,estado,cliente,
                 categoria,tipocta_super)
    values      ( @s_ssn,@i_alt,@t_trn,@s_ofi,@s_user,
                  'consola',@t_corr,@t_ssn_corr,@t_corr,'L',
                  @s_srv,@i_fecha,@i_cta,@w_signo,@i_ind,
                  null,@i_mon,@i_cau,null,@w_val_total + isnull(@w_val_icc,
                                        0) * @w_tfactor,
                  null,@w_interes,@w_saldo_contable + @w_val_icc * @w_tfactor,
                  @w_disponible + @w_val_icc * @w_tfactor,null,
                  null,@w_oficina_p,@w_prod_banc,@w_clase_clte,@i_canal,
                  @w_oficial,@i_val,@s_ssn_branch,@i_reverso,@w_cliente,
                  @w_categoria,@w_tipocta_super)

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = null,
        @t_file  = null,
        @t_from  = @w_sp_name,
        @i_num   = 253000
      return 253000
    end

  end

  if @w_val <> 0
  begin
    if @t_trn = 264
       and @i_reverso <> 'R'
      if @i_cobsus = 'N'
      begin
        if @w_comision = 'S'
        begin
          select
            @w_valimp = @w_val - @w_val_2x1000 - @i_val
          if @w_valimp > 0
          begin
            select
              @w_valemer = @w_val - @w_impuesto - @i_val
            if @w_valemer > 0
              select
                @w_valcom = @w_val - @w_impuesto - @w_val_2x1000
            else
              select
                @w_valemer = @w_val
          end
          else
            select
              @w_valimp = @w_val
        end
        else
        begin
          select
            @w_valimp = 0
          select
            @w_valemer = @w_val - @i_val
          if @w_valemer > 0
            select
              @w_valcom = @w_val - @w_val_2x1000
          else
            select
              @w_valemer = @w_val
        end
      end
      else
        select
          @w_valcom = @w_val,
          @w_valimp = 0,
          @w_valemer = 0

  end

  select
    @o_valiva = @w_impuesto

  if @t_ejec = 'R'
  begin
    exec @w_return = cob_cuentas..sp_resultados_branch_cc
      @i_cuenta      = @w_cuenta,
      @i_fecha       = @i_fecha,
      @i_ofi         = @s_ofi,
      @i_tipo_cuenta = 'O'
    if @w_return <> 0
      return @w_return
  end

  commit tran
  return 0

go

