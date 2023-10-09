/************************************************************************/
/*  Archivo:       dep_ncre_dif.sp                                      */
/*  Stored procedure:   sp_dep_ncre_dif                                 */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto: Cuentas de Ahorros                                        */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 25-Feb-1993                                     */
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
/*                          PROPOSITO                                   */
/*  Este programa procesa las transacciones de depositos con libreta    */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA         AUTOR       RAZON                                     */
/*  25/Feb/1993   J Navarrete     Emision inicial                       */
/*  16/Ene/1996   Juan F. Cadena  Personalizacion B. de Prestamos       */
/*  30/Mar/1999   Juan F. Cadena  Personalizacion B. del Caribe         */
/*  24/Sep/1999   V.Molina E.     Calculo de fecha de efectiviza        */
/*  2003/07/01    Carlos Cruz D.  Cambios Branch III                    */
/*  04/Feb/2010   J.Loyo          Validacion de Saldo Maximo            */
/*                                para la cuenta                        */
/*  17/Feb/2010   J. Loyo         Manejo de la fecha de efectivizacion  */
/*                                teniendo el sabado como habil         */
/*  03/May/2016   J. Salazar      Migracion COBIS CLOUD MEXICO          */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_dep_ncre_dif')
  drop proc sp_dep_ncre_dif
go

/****** Object:  StoredProcedure [dbo].[sp_dep_ncre_dif]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_dep_ncre_dif
(
  @s_ssn           int,
  @s_srv           varchar(30),
  @s_lsrv          varchar(30),
  @s_user          varchar(30),
  @s_sesn          int = null,
  @s_term          varchar(10),
  @s_ofi           smallint,
  @s_rol           smallint,
  @s_org           char(1),
  @t_ssn_corr      int = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(30) = null,
  @t_trn           int,
  @t_ejec          char(1) = 'N',--CCR
  @t_show_version  bit = 0,
  @s_date          datetime = null,
  @i_cuenta        int,
  @i_efe           money,
  @i_prop          money,
  @i_loc           money,
  @i_plaz          money,
  @i_mon           tinyint,
  @i_sldlib        money,
  @i_nctrl         int,
  @i_ind           tinyint,
  @i_factor        smallint,
  @i_fecha         smalldatetime,
  @i_ncontrol      int,
  @i_lpend         int,
  @i_sld_caja      money = 0,
  @i_idcierre      int = 0,
  @i_filial        smallint = 1,
  @i_idcaja        int = 0,
  @i_fecha_valor_a datetime = null,
  @o_sldcont       money out,
  @o_slddisp       money out,
  @o_control       int out,
  @o_nombre        varchar(30) out,
  @o_int_cap       money out,
  @o_lineas        int out,
  @o_usa           char(1) out,
  @o_sldlib        money out,
  @o_nctrl         smallint out,
  @o_prod_banc     smallint out,
  @o_categoria     char(1) out,
  @o_clase_clte    char(1) = null out,
  @o_tipocta_super char(1) = null out
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_alicuota         float,
    @w_fecha            datetime,
    @w_numdeci          tinyint,
    @w_periodo          tinyint,
    @w_cta_banco        cuenta,
    @w_saldo_libreta    money,
    @w_tot_alic         float,
    @w_tot              money,
    @w_disponible       money,
    @w_suspensos        smallint,
    @w_contador         smallint,
    @w_secuencial       int,
    @w_acum             money,
    @w_clave            int,
    @w_saldo_para_girar money,
    @w_saldo_contable   money,
    @w_promedio1        money,
    @w_24h              money,
    @w_12h              money,
    @w_12h_dif          money,
    @w_48h              money,
    @w_valor            money,
    @w_creditos         money,
    @w_control          int,
    @w_sec              int,
    @w_linea            smallint,
    @w_nemo             char(4),
    @w_capita           char(1),
    @w_rem_hoy          money,
    @w_remesas          money,
    @w_mensaje          mensaje,
    @w_tipo_bloqueo     char(3),
    @w_tipo_prom        char(1),
    @w_usadeci          char(1),
    @w_prom_disp        money,
    @w_nctrl            smallint,
    @w_debitos          money,
    @w_contador_trx     int,
    @w_fapert           smalldatetime,
    @w_fultmv           smalldatetime,
    @w_dep_ini          tinyint,
    @w_cont             tinyint,
    @w_dias_ret         tinyint,
    @w_fecha_efe        smalldatetime,
    @w_ciudad           int,
    /** Validacion saldo Maximo ***/
    @w_saldo_max        money,
    @w_hora_ejecucion   smalldatetime,
    @w_codigo_pais      char(3)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_dep_ncre_dif'
  select
    @w_hora_ejecucion = convert(varchar(5), getdate(), 108)

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  /*  Modo de debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**  Stored Procedure  **/ ' = @w_sp_name,
      t_file = @t_file,
      t_from = @t_from,
      i_cuenta = @i_cuenta,
      i_mon = @i_mon,
      i_efe = @i_efe,
      i_prop = @i_prop,
      i_loc = @i_loc,
      i_plaz = @i_plaz,
      i_sldlib = @i_sldlib,
      i_nctrl = @i_nctrl,
      i_ind = @i_ind,
      i_factor = @i_factor,
      i_fecha = @i_fecha
    exec cobis..sp_end_debug
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
  end
  else
    select
      @w_numdeci = 0

  select
    @w_codigo_pais = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'ABPAIS'
     and pa_producto = 'ADM'

  if @w_codigo_pais is null
    select
      @w_codigo_pais = 'PA'

  /*  Determinacion de bloqueo de cuenta  */
  select
    @w_tipo_bloqueo = cb_tipo_bloqueo
  from   cob_ahorros..ah_ctabloqueada
  where  cb_cuenta = @i_cuenta
     and cb_estado = 'V'
     and cb_tipo_bloqueo in ('1', '3')
  if @@rowcount <> 0
  begin
    select
      @w_mensaje = rtrim(valor)
    from   cobis..cl_catalogo
    where  cobis..cl_catalogo.tabla  = (select
                                          cobis..cl_tabla.codigo
                                        from   cobis..cl_tabla
                                        where  tabla = 'cc_tbloqueo')
       and cobis..cl_catalogo.codigo = @w_tipo_bloqueo
    select
      @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251007,
      @i_sev   = 1,
      @i_msg   = @w_mensaje
    return 1
  end

  /*  Calcula los Saldos  */
  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_debug            = @t_debug,
    @t_file             = @t_file,
    @t_from             = @w_sp_name,
    @i_cuenta           = @i_cuenta,
    @i_fecha            = @i_fecha,
    @i_ofi              = @s_ofi,
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_saldo_contable out,
    @o_saldo_max        = @w_saldo_max out
  /* Recibimos  el saldo Maximo para la cuenta */
  if @w_return <> 0
    return @w_return

  /* lee tabla de ctas de ahorros */
  select
    @w_rem_hoy = ah_rem_hoy,
    @w_remesas = ah_remesas,
    @w_tipo_prom = ah_tipo_promedio,
    @o_nombre = substring(ah_nombre,
                          1,
                          30),
    @w_12h = ah_12h,
    @w_12h_dif = ah_12h_dif,
    @w_24h = ah_24h,
    @w_48h = ah_48h,
    @w_cta_banco = ah_cta_banco,
    @w_disponible = ah_disponible,
    @w_linea = ah_linea,
    @w_control = ah_control,
    @w_creditos = ah_creditos,
    @w_capita = ah_capitalizacion,
    @w_saldo_libreta = ah_saldo_libreta,
    @w_promedio1 = ah_promedio1,
    @w_prom_disp = ah_prom_disponible,
    @w_contador_trx = ah_contador_trx,
    @w_fapert = ah_fecha_aper,
    @w_fultmv = ah_fecha_ult_mov,
    @w_debitos = ah_debitos,
    @w_dep_ini = ah_dep_ini,
    @o_prod_banc = ah_prod_banc,
    @o_categoria = ah_categoria,
    @o_clase_clte = ah_clase_clte,
    @o_tipocta_super = ah_tipocta_super
  from   cob_ahorros..ah_cuenta
  where  ah_cuenta = @i_cuenta

  if @w_dep_ini <> 0
  begin
    /* Error cuenta sin depositos */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201158
    return 1
  end

  select
    @o_lineas = 0,
    @o_sldlib = 0

  /* Valida datos de entrada */

  if @t_trn = 207
  begin
    if @w_control <> @i_nctrl
       and @i_factor = 1
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251004
      return 1
    end
    if convert(char(30), @w_saldo_libreta) <> convert(char(30), @i_sldlib)
       and @i_factor = 1
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251005
      return 1
    end
    if @w_linea > 0
       and @i_factor = 1
    begin
      exec @w_return = cob_ahorros..sp_ah_actlibsp
        @s_ssn     = @s_ssn,
        @s_srv     = @s_srv,
        @s_lsrv    = @s_lsrv,
        @s_user    = @s_user,
        @s_sesn    = @s_sesn,
        @s_term    = @s_term,
        @s_date    = @i_fecha,
        @s_ofi     = @s_ofi,
        @s_rol     = @s_rol,
        @s_org     = @s_org,
        @p_sp      = 'S',
        @t_trn     = @t_trn,
        @i_cta     = @w_cta_banco,
        @i_sld_lib = @w_saldo_libreta,
        @i_nctrl   = @w_control,
        @i_mon     = @i_mon,
        @o_sldlib  = @w_saldo_libreta out,
        @o_num     = @o_lineas out,
        @o_nctrl   = @o_nctrl out

      select
        @o_sldlib = @w_saldo_libreta

      if @w_return <> 2
          or @o_lineas > 0
      begin
        return @w_return
      end
      select
        @w_linea = 0,
        @w_return = 0
    end
    else
      select
        '',
        '',
        '',
        '',
        '',
        ''
  end

  /* Encuentra la alicuota para el promedio */
  select
    @w_alicuota = fp_alicuota
  from   cob_ahorros..ah_fecha_promedio
  where  fp_tipo_promedio = @w_tipo_prom
     and fp_fecha_inicio  = @i_fecha
  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251013
    return 1
  end

  select
    @i_efe = isnull (@i_efe,
                     0),
    @i_loc = isnull (@i_loc,
                     0),
    @i_prop = isnull (@i_prop,
                      0),
    @i_plaz = isnull (@i_plaz,
                      0)

  if @w_codigo_pais = 'CO'
    select
      @w_tot = @i_efe + @i_prop + @i_loc
  else
    select
      @w_tot = @i_efe + @i_prop + @i_loc + @i_plaz

  select
    @w_tot_alic = @w_tot * @w_alicuota

  if @i_factor = -1
     and (@i_efe > @w_disponible
           or @i_prop > @w_12h
           or @i_loc > @w_24h
           or @i_plaz > @w_rem_hoy)
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 258001
    return 1
  end

  select
    @w_creditos = @w_creditos + @w_tot * @i_factor

  begin tran
  if @i_factor = 1
    select
      @w_control = @i_ncontrol

  if @i_factor = -1
  begin
    select
      @w_sec = @i_lpend,
      @w_linea = @w_linea + 1

    insert into cob_ahorros..ah_linea_pendiente
                (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                 lp_control,lp_signo,lp_enviada)
    values      (@i_cuenta,@w_sec,'CORR',@w_tot,@i_fecha,
                 @i_nctrl,'D','N')
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253002
      return 1
    end

  end

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**  Stored Procedure  **/ ' = @w_sp_name,
      w_alicuota = @w_alicuota,
      w_tot_alic = @w_tot_alic,
      w_promedio1 = @w_promedio1,
      i_efe = @i_efe,
      i_factor = @i_factor,
      i_plaz = @i_plaz
    exec cobis..sp_end_debug
  end

  select
    @o_control = @w_control
  select
    @w_disponible = @w_disponible + @i_efe * @i_factor
  select
    @w_saldo_para_girar = @w_saldo_para_girar + (@i_efe * @i_factor)

  select
    @o_sldcont = @w_saldo_contable + @w_tot * @i_factor
  select
    @o_slddisp = @w_disponible

  if @i_factor = 1
    select
      @w_saldo_libreta = @w_saldo_libreta + @w_tot

  if (@t_trn = 207
      and @i_efe > $0)
  begin
    select
      @w_prom_disp = @w_prom_disp + @i_factor * round(@i_efe * @w_alicuota,
                                                      @w_numdeci)
  end

  /*** Validamos el saldo maximo de la cuenta JLOYO *****/
  if @w_saldo_max > 0
     and @o_sldcont > @w_saldo_max
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 252077
    /**** EL CREDITO ALA CUENTA EXCEDE EL SALDO MAXIMO PERMITIDO ***/
    return 1
  end

  update cob_ahorros..ah_cuenta
  set    ah_disponible = @w_disponible,
         ah_promedio1 = @w_promedio1 + @i_factor * round(@w_tot_alic,
                                                         @w_numdeci),
         ah_prom_disponible = @w_prom_disp,
         ah_saldo_libreta = @w_saldo_libreta,
         ah_12h = @w_12h + (@i_prop * @i_factor),
         ah_12h_dif = @w_12h_dif + (@i_prop * @i_factor),
         ah_24h = @w_24h + (@i_loc * @i_factor),
         ah_remesas = @w_remesas + (@i_plaz * @i_factor),
         ah_rem_hoy = @w_rem_hoy + (@i_plaz * @i_factor),
         ah_control = @w_control,
         ah_linea = @w_linea,
         ah_creditos = @w_creditos,
         ah_creditos_hoy = ah_creditos_hoy + @w_tot * @i_factor,
         ah_fecha_ult_mov = @i_fecha,
         ah_contador_trx = ah_contador_trx + @i_factor
  where  @i_cuenta = ah_cuenta
  if @@rowcount <> 1
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 255001
    return 1
  end

  /* Regitrar los depositos por ciudad de cheques locales */

  if @i_loc > 0
     and @t_trn = 207
  begin
  /*** Este valor se devuelve en el sp_fecha_habil   ***/
    --Determinar el codigo de la ciudad de la compensacion
    --     select @w_ciudad = of_ciudad
    --     from cobis..cl_oficina
    --     where of_oficina = @s_ofi
    --     
    --  if @@rowcount <> 1
    --  begin 
    --           exec cobis..sp_cerror
    --            @t_debug        = @t_debug,
    --                @t_file         = @t_file,
    --                @t_from         = @w_sp_name,
    --                 @i_num          = 351095
    --       return 351095
    --
    --  end

    /* Determinar el numero de dias de retencion para la ciudad */

    select
      @w_dias_ret = rl_dias
    from   cob_ahorros..ah_retencion_locales
    where  rl_agencia = @s_ofi
       and @w_hora_ejecucion between rl_hora_inicio and rl_hora_fin

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
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205001
        return 1
      end

    end

  /****PEDRO COELLO MODIFICA EL CALCULO DE DIAS DE HOLD ****/
    --       select @w_fecha_efe = dateadd(dd, 2, @i_fecha),
    --              @w_cont = 1

    --       while @w_cont <= @w_dias_ret
    --           if exists (select 1
    --                        from cobis..cl_dias_feriados
    --                     where df_ciudad = @w_ciudad
    --                         and df_fecha  = @w_fecha_efe)
    --              select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
    --            else 
    --            begin
    --                 select @w_cont = @w_cont + 1
    --           if @w_cont <= @w_dias_ret
    --                    select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
    --            end 

  /*** La determinacion de la fecha de efectivizacion del deposito se     ****/
    /*** hace mediante el llamado al siguiente sp  - JLOYO          ****/
    exec @w_return = cob_remesas..sp_fecha_habil
      @i_val_dif  = 'N',
      @i_efec_dia = 'S',
      @i_fecha    = @i_fecha,
      @i_oficina  = @s_ofi,
      @i_dif      = 'S',/**** Ingreso en  horario diferido  ***/
      @w_dias_ret = @w_dias_ret,
      @o_ciudad   = @w_ciudad out,
      @o_fecha_sig= @w_fecha_efe out

    if @w_return <> 0
      return @w_return

    if not exists (select
                     cd_cuenta
                   from   cob_ahorros..ah_ciudad_deposito
                   where  cd_cuenta     = @i_cuenta
                      and cd_ciudad     = @w_ciudad
                      and cd_fecha_depo = @i_fecha
                      and cd_fecha_efe  = @w_fecha_efe)
    begin
      insert into cob_ahorros..ah_ciudad_deposito
                  (cd_cuenta,cd_ciudad,cd_fecha_depo,cd_fecha_efe,cd_valor,
                   cd_valor_efe)
      values      (@i_cuenta,@w_ciudad,@i_fecha,@w_fecha_efe,@i_loc,
                   @i_loc)

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205001
        return 1
      end

    end
    else
    begin
      update cob_ahorros..ah_ciudad_deposito
      set    cd_valor_efe = cd_valor_efe + (@i_loc * @i_factor),
             cd_valor = cd_valor + (@i_loc * @i_factor)
      where  cd_cuenta     = @i_cuenta
         and cd_ciudad     = @w_ciudad
         and cd_fecha_depo = @i_fecha
         and cd_fecha_efe  = @w_fecha_efe

      if @@rowcount <> 1
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205001
        return 1
      end

    end
  end

  commit tran

  /*CCR Devuelve resultados para Branch III*/
  if @t_ejec = 'R'
  begin
    exec @w_return = cob_ahorros..sp_resultados_branch_ah
      @s_ssn_host    = @s_ssn,
      @i_cuenta      = @i_cuenta,
      @i_fecha       = @i_fecha,
      @i_ofi         = @s_ofi,
      @i_tipo_cuenta = 'O'
    if @w_return <> 0
      return @w_return
  end

  return 0

go

