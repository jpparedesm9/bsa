/************************************************************************/
/*   Archivo:        dep_ncre_dif_sl.sp                                 */
/*   Stored procedure:   sp_dep_ncre_dif_sl                             */
/*   Base de datos:      cob_ahorros                                    */
/*   Producto: Cuentas de Ahorros                                       */
/*   Disenado por:  Mauricio Bayas/Sandra Ortiz                         */
/*   Fecha de escritura: 25-Feb-1993                                    */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno  de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales de propiedad inte-         */
/*   lectual. Su uso no  autorizado dara  derecho a COBISCorp para      */
/*   obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                           PROPOSITO                                  */
/*   Este programa procesa las transacciones de depositos y notas de    */
/*   credito sin libreta                                                */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*   FECHA         AUTOR         RAZON                                  */
/*   25/Feb/1993   J Navarrete   Emision inicial                        */
/*   12/Oct/1994   Pablo Mena    Inclusion del contador de              */
/*                               transacciones                          */
/*   19/Ene/1996   D Villafuerte Control de Calidad (param rem)         */
/*   09/Feb/1999   J. Salazar    Cobro de comision por la transac       */
/*   23/Jun/199    J.C. Gordillo IDB (Comision)                         */
/*   24/Sep/199    V.Molina E.   Calculo de fecha de efectiviza         */
/*   2003/07/01    Carlos Cruz   Cambios Branch III                     */
/*   04/Feb/2010   J.Loyo        Valida el Saldo Minimo de la           */
/*                               Cuenta y envia el saldo maximo         */
/*                               que puede tener una cuenta             */
/*   17/Feb/2010   J. Loyo       Manejo de la fecha de efectivizacion   */
/*                               teniendo el sabado como habil          */
/*   03/May/2016   J. Salazar    Migracion COBIS CLOUD MEXICO           */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_dep_ncre_dif_sl')
  drop proc sp_dep_ncre_dif_sl
go

/****** Object:  StoredProcedure [dbo].[sp_dep_ncre_dif_sl]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_dep_ncre_dif_sl
(
  @s_rol           smallint,
  @s_ssn           int,
  @s_srv           varchar(30),
  @s_lsrv          varchar(16),
  @s_user          varchar(30),
  @s_term          varchar(10),
  @s_ofi           smallint,
  @s_date          datetime = null,
  @s_ssn_branch    int = null,
  @t_ssn_corr      int,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(30) = null,
  @t_trn           int,
  @t_ejec          char(1) = 'N',--CCR
  @t_show_version  bit = 0,
  @i_ofi           smallint,
  @i_cuenta        int,
  @i_efe           money,
  @i_prop          money,
  @i_loc           money,
  @i_plaz          money,
  @i_mon           tinyint,
  @i_factor        smallint,
  @i_fecha         smalldatetime,
  @i_ncontrol      int,
  @i_lpend         int,
  @i_batch         char(1) = 'N',
  @i_turno         smallint = null,
  @i_sld_caja      money = 0,
  @i_idcierre      int = 0,
  @i_filial        smallint = 1,
  @i_idcaja        int = 0,
  @i_fecha_valor_a datetime = null,--CCR
  @i_canal         smallint = 4,
  @o_sldcont       money out,
  @o_slddisp       money out,
  @o_nombre        varchar(30) out,
  @o_cliente       int = null out,
  @o_prod_banc     smallint out,
  @o_categoria     char(1) out,
  @o_clase_clte    char(1) = null out,
  @o_tipocta_super char(1) = null out
)
as
  declare
    @w_return             int,
    @w_sp_name            varchar(30),
    @w_alicuota           float,
    @w_fecha              datetime,
    @w_contador           smallint,
    @w_numdeci            tinyint,
    @w_tot_alic           float,
    @w_tot                money,
    @w_disponible         money,
    @w_promedio1          money,
    @w_24h                money,
    @w_12h                money,
    @w_12h_dif            money,
    @w_48h                money,
    @w_saldo_para_girar   money,
    @w_saldo_contable     money,
    @w_remesas            money,
    @w_valor              money,
    @w_creditos           money,
    @w_aux_contable       money,
    @w_control            int,
    @w_nctrl              int,
    @w_linea              smallint,
    @w_nemo               char(4),
    @w_rem_hoy            money,
    @w_mensaje            mensaje,
    @w_tipo_bloqueo       char(3),
    @w_tipo_prom          char(1),
    @w_usadeci            char(1),
    @w_prom_disp          money,
    @w_contador_trx       int,
    @w_dep_ini            tinyint,
    @w_creditos_hoy       money,
    @w_debitos            money,
    @w_debitos_hoy        money,
    @w_cta_banco          varchar(16),
    @w_dias_ret           tinyint,
    @w_cont               tinyint,
    @w_ciudad             int,
    @w_fecha_efe          smalldatetime,
    @w_tipo_ente          char(1),
    @w_rol_ente           char(1),
    @w_tipo_def           char(1),
    @w_default            int,
    @w_personalizada      char(1),
    @w_nemo2              char(4),
    @w_comision           money,
    @w_oficina            smallint,
    @w_mivar              money,
    @w_tasa_imp           float,
    @w_monto_imp          money,
    @w_tipo_exonerado_imp char(2),
    @w_moneda_local       tinyint,
    /** Validacion saldo Maximo ***/
    @w_saldo_max          money,
    @w_aux_disponible     money,
    @w_hora_ejecucion     smalldatetime,
    @w_codigo_pais        char(3)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_dep_ncre_dif_sl'
  select
    @w_hora_ejecucion = convert(varchar(5), getdate(), 108)

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  if @i_turno is null
    select
      @i_turno = @s_rol

  /* Determinar si el proceso es batch */

  select
    @i_efe = isnull (@i_efe,
                     0),
    @i_loc = isnull (@i_loc,
                     0),
    @i_prop = isnull (@i_prop,
                      0),
    @i_plaz = isnull (@i_plaz,
                      0)

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
      i_factor = @i_factor,
      i_fecha = @i_fecha
    exec cobis..sp_end_debug
  end

  if @i_factor = 1
  begin
    /* Busqueda de la tasa del impuesto */
    select
      @w_tasa_imp = pa_float
    from   cobis..cl_parametro
    where  pa_producto = 'ADM'
       and pa_nemonico = 'TIDB'

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @t_from,
        @i_num   = 201196
      return 201196
    end
  end
  else
    select
      @w_tasa_imp = 0.0

  /* Encuentra parametro de decimales */

  select
    @w_usadeci = mo_decimales
  from   cobis..cl_moneda
  where  mo_moneda = @i_mon

  if @w_usadeci = 'S'
    select
      @w_numdeci = pa_tinyint
    from   cobis..cl_parametro
    where  pa_nemonico = 'DCI'
       and pa_producto = 'AHO'
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
    return 251007
  end

  /*  Actualizacion de saldos  */
  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_debug            = @t_debug,
    @t_file             = @t_file,
    @t_from             = @w_sp_name,
    @i_cuenta           = @i_cuenta,
    @i_fecha            = @i_fecha,
    @i_ofi              = @i_ofi,
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
    @o_nombre = substring (ah_nombre,
                           1,
                           30),
    @o_cliente = ah_cliente,
    @w_12h = ah_12h,
    @w_12h_dif = ah_12h_dif,
    @w_24h = ah_24h,
    @w_48h = ah_48h,
    @w_disponible = ah_disponible,
    @w_linea = ah_linea,
    @w_creditos = ah_creditos,
    @w_creditos_hoy = ah_creditos_hoy,
    @w_debitos = ah_debitos,
    @w_debitos_hoy = ah_debitos_hoy,
    @w_promedio1 = ah_promedio1,
    @w_prom_disp = ah_prom_disponible,
    @w_contador_trx = ah_contador_trx,
    @w_dep_ini = ah_dep_ini,
    @w_cta_banco = ah_cta_banco,
    @w_tipo_ente = ah_tipocta,
    @w_rol_ente = ah_rol_ente,
    @w_tipo_def = ah_tipo_def,
    @w_default = ah_default,
    @w_personalizada = ah_personalizada,
    @w_oficina = ah_oficina,
    @o_prod_banc = ah_prod_banc,
    @o_categoria = ah_categoria,
    @o_clase_clte = ah_clase_clte,
    @o_tipocta_super = ah_tipocta_super
  from   cob_ahorros..ah_cuenta
  where  ah_cuenta = @i_cuenta

  if @w_tipo_ente = 'I'
  begin
    select
      1
    from   cob_ahorros..ah_oficina_ctas_cifradas
    where  oc_oficina = @s_ofi
       and oc_estado  = 'V'
    if @@rowcount = 0
    begin
      -- Oficina no autorizada para cuentas cifradas
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251081
      return 1
    end
  end

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
    @w_moneda_local = pa_tinyint -- lgr
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'CMNAC'

  if @i_mon = @w_moneda_local
     and @i_plaz <> 0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 205062
    return 205062
  end

  if (@w_tasa_imp > 0
      and @i_factor = 1)
  begin
    /* Verificar que la cuenta este exonerada */
    select
      @w_tipo_exonerado_imp = ei_tipo_exonerado_imp
    from   cob_remesas..re_exoneracion_impuesto
    where  ei_producto = 'AHO'
       and ei_cuenta   = @i_cuenta
    if @@rowcount = 1
      select
        @w_tasa_imp = 0.0
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
    return 251013
  end

  if @t_trn = 246
  begin
    if @i_factor = 1
    begin
    /* BUSCAR LA COMISION POR DEPOSITO DIFERIDO SIN LIBRETA */
      /*  porque no se cobra en BDF lgr 
          exec @w_return = cob_remesas..sp_genera_costos
               @i_filial      = @i_filial,
               @i_oficina     = @w_oficina,
               @i_categoria   = @o_categoria,
               @i_tipo_ente   = @w_tipo_ente,
               @i_rol_ente    = @w_rol_ente,
               @i_tipo_def    = @w_tipo_def,
               @i_prod_banc   = @o_prod_banc,
               @i_producto    = 4,
               @i_moneda      = @i_mon,
               @i_tipo        = 'R',
               @i_codigo      = @w_default,
               @i_servicio    = 'DPSL',
               @i_rubro       = '3',
               @i_disponible  = @w_disponible,
               @i_contable    = @w_saldo_contable,
               @i_promedio    = @w_promedio1,
               @i_prom_dis    = @w_prom_disp,
               @i_valor       = 1,
               @i_personaliza = @w_personalizada,
               @i_fecha       = @i_fecha,
               @o_valor_total = @w_comision out
      
          if @w_return <>0
               return @w_return    */

      select
        @w_comision = 0 -- lgra por que no se cobra

      /* Calculo del monto del IDB */
      if @w_tasa_imp > 0
        select
          @w_monto_imp = round((@w_comision * @w_tasa_imp),
                               @w_numdeci)
      else
        select
          @w_monto_imp = 0

      if (@w_comision + @w_monto_imp) > (@w_disponible + @i_efe)
      begin
        /* VALOR DE LA COMISION EXCEDE AL DISPONIBLE */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251051
        return 251051
      end
    end
    else /********* @i_factor <> 1 *********/
    begin
      select
        @w_comision = tm_valor,
        @w_monto_imp = isnull(tm_monto_imp,
                              0)
      from   cob_ahorros..ah_tran_monet
      where  --tm_secuencial  = @t_ssn_corr
        tm_ssn_branch  = @t_ssn_corr --CCR
      and tm_cod_alterno = 10
      and tm_tipo_tran   = 264 /* ND por Comision */
      and tm_causa       = '15'
      and tm_cta_banco   = @w_cta_banco
      and tm_moneda      = @i_mon
      and tm_usuario     = @s_user
      and tm_estado is null

      if @@rowcount > 1
      begin
        /* NO EXISTE REGISTRO DE REVERSO */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251067
        return 251075
      end

      select
        @w_comision = isnull(@w_comision,
                             0),
        @w_monto_imp = isnull(@w_monto_imp,
                              0)

    end
  end
  else /****** @t_trn <> 246 *****/
    select
      @w_comision = 0,
      @w_monto_imp = 0

  if @w_codigo_pais = 'CO'
    select
      @w_tot = @i_efe + @i_prop + @i_loc - (@w_comision + @w_monto_imp)
  else
    select
      @w_tot = @i_efe + @i_prop + @i_loc + @i_plaz -
               (@w_comision + @w_monto_imp)

  select
    @w_tot_alic = @w_tot * @w_alicuota
  select
    @w_prom_disp =
       @w_prom_disp
                   + round((( @i_efe - (@w_comision + @w_monto_imp)) *
       @w_alicuota
       *
                                                                 @i_factor),
       @w_numdeci)

  /* Analiza cajero en horario extendido */

  if @i_factor = -1
     and ((@i_efe - (@w_comision + @w_monto_imp)) > @w_disponible
           or @i_prop > @w_12h
           or @i_loc > @w_24h
           or @i_plaz > @w_rem_hoy)
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 258001
    return 258001
  end

  begin tran

  /* Genera numero de control */

  select
    @w_control = @i_ncontrol

  /* Inserta linea pendiente */

  select
    @w_linea = @w_linea + 1

  select
    @w_nemo = tn_nemonico
  from   cobis..cl_ttransaccion
  where  tn_trn_code = @t_trn

  select
    @w_nemo2 = tn_nemonico
  from   cobis..cl_ttransaccion
  where  tn_trn_code = 264

  if @i_factor = -1
    select
      @w_nemo2 = 'CORR'

  if @i_factor = 1
  begin
    insert into cob_ahorros..ah_linea_pendiente
                (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                 lp_control,lp_signo,lp_enviada)
    values      (@i_cuenta,@i_lpend,@w_nemo,@w_tot +
                 (@w_comision + @w_monto_imp),
                 @i_fecha,
                 @w_control,'C','N')

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253002
      return 253002
    end

    if @t_trn = 246
       and @w_comision > 0
    begin
      select
        @w_linea = @w_linea + 1
      insert into cob_ahorros..ah_linea_pendiente
                  (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                   lp_control,lp_signo,lp_enviada)
      values      (@i_cuenta,@i_lpend + 1,@w_nemo2,@w_comision,@i_fecha,
                   @i_ncontrol + 1,'D','N')

      if @@error <> 0
      begin
        /* ERROR EN INSERCION DE LINEA PENDIENTE */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 253002
        return 253002
      end

      if @w_monto_imp > 0
      begin
        select
          @w_linea = @w_linea + 1
        insert into cob_ahorros..ah_linea_pendiente
                    (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                     lp_control,lp_signo,lp_enviada)
        values      (@i_cuenta,@i_lpend + 2,'IDB',@w_monto_imp,@i_fecha,
                     @i_ncontrol + 2,'D','N')

        if @@error <> 0
        begin
          /* ERROR EN INSERCION DE LINEA PENDIENTE */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 253002
          return 253002
        end
      end
    end
  end
  else
  begin
    insert into cob_ahorros..ah_linea_pendiente
                (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                 lp_control,lp_signo,lp_enviada)
    values      (@i_cuenta,@i_lpend,'CORR',@w_tot + (@w_comision + @w_monto_imp)
                 ,
                 @i_fecha,
                 @w_control,'D','N')

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253002
      return 253002
    end

    if @t_trn = 246
       and @w_comision > 0
    begin
      select
        @w_linea = @w_linea + 1

      insert into cob_ahorros..ah_linea_pendiente
                  (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                   lp_control,lp_signo,lp_enviada)
      values      (@i_cuenta,@i_lpend + 1,@w_nemo2,@w_comision,@i_fecha,
                   @i_ncontrol + 1,'C','N')

      if @@error <> 0
      begin
        /* ERROR EN INSERCION DE LINEA PENDIENTE */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 253002
        return 253002
      end

      if @w_monto_imp > 0
      begin
        select
          @w_linea = @w_linea + 1

        insert into cob_ahorros..ah_linea_pendiente
                    (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                     lp_control,lp_signo,lp_enviada)
        values      (@i_cuenta,@i_lpend + 2,'CORR',@w_monto_imp,@i_fecha,
                     @i_ncontrol + 2,'C','N')

        if @@error <> 0
        begin
          /* ERROR EN INSERCION DE LINEA PENDIENTE */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 253002
          return 253002
        end

      end
    end
  end

  /*** Validamos el saldo maximo de la cuenta JLOYO *****/

  select
    @w_aux_contable = @w_saldo_contable + (@w_tot + (@w_comision + @w_monto_imp)
                                          )
                                          *
                                                 @i_factor
  select
    @w_aux_disponible = @w_disponible + ((@i_efe - (@w_comision + @w_monto_imp))
                                         *
    @i_factor
    )

  if @w_saldo_max > 0
     and @w_aux_contable > @w_saldo_max
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
  set
  /** ah_disponible  = @w_disponible + ((@i_efe - (@w_comision + @w_monto_imp)) * @i_factor), **/
  ah_disponible = @w_aux_disponible,
  ah_promedio1 = @w_promedio1 + @i_factor * round(@w_tot_alic,
                                                  @w_numdeci),
  ah_prom_disponible = @w_prom_disp,
  ah_12h = @w_12h + (@i_prop * @i_factor),
  ah_12h_dif = @w_12h_dif + (@i_prop * @i_factor),
  ah_24h = @w_24h + (@i_loc * @i_factor),
  ah_linea = @w_linea,
  ah_creditos = @w_creditos + ((@w_tot + (@w_comision + @w_monto_imp)) *
                               @i_factor
                              ),
  ah_creditos_hoy = @w_creditos_hoy + ((@w_tot + (@w_comision + @w_monto_imp)) *
                                       @i_factor),
  ah_debitos = @w_debitos + ((@w_comision + @w_monto_imp) * @i_factor),
  ah_debitos_hoy = @w_debitos_hoy + ((@w_comision + @w_monto_imp) * @i_factor),
  ah_rem_hoy = @w_rem_hoy + (@i_factor * @i_plaz),
  ah_remesas = @w_remesas + (@i_factor * @i_plaz),
  ah_fecha_ult_mov = @i_fecha,
  ah_contador_trx = ah_contador_trx + @i_factor,
  ah_monto_imp = ah_monto_imp + @w_monto_imp * @i_factor
  where  @i_cuenta = ah_cuenta

  if @@rowcount <> 1
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 255001
    return 255001
  end

  /* Regitrar los depositos por ciudad de cheques locales */

  if @i_loc > 0
     and @t_trn = 246
  begin
    --Determinar el codigo de la ciudad de la compensacion
    select
      @w_ciudad = of_ciudad
    from   cobis..cl_oficina
    where  of_oficina = @s_ofi

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351095
      return 351095

    end

    /* Determinar el numero de dias de retencion para la ciudad */

    select
      @w_dias_ret = rl_dias
    from   cob_ahorros..ah_retencion_locales
    where  rl_agencia = @i_ofi
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
    --       select @w_fecha_efe = dateadd(dd, 1, @i_fecha),
    --              @w_cont = 1

    --       while @w_cont <= @w_dias_ret
    --           if exists (select 1
    --                        from cobis..cl_dias_feriados
    --                     where df_ciudad = @w_ciudad
    --                        and df_fecha  = @w_fecha_efe)
    --              select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
    --            else 
    --            begin
    --                 select @w_cont = @w_cont + 1
    --           if @w_cont <= @w_dias_ret
    --                    select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
    --            end 

  /*** La determinacion del siguiente dia laboral  se              ****/
    /*** hace mediante el llamado al siguiente sp  - JLOYO           ****/
    exec @w_return = cob_remesas..sp_fecha_habil
      @i_val_dif   = 'N',
      @i_efec_dia  = 'S',
      @i_fecha     = @w_fecha_efe,
      @i_oficina   = @i_ofi,
      @i_dif       = 'N',/**** Ingreso en  horario normal  ***/
      @w_dias_ret  = @w_dias_ret,/***  Dia siguiente habil         ***/
      @o_ciudad    = @w_ciudad out,
      @o_fecha_sig = @w_fecha_efe out

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

  if @t_trn = 246
     and @w_comision > 0
  begin
    if @i_factor = 1
    begin
    /*  Transaccion monetaria */
      /* Inicio Cambios BRANCHII 03-jul-01*/
      if exists (select
                   1
                 from   cob_ahorros..ah_tran_monet
                 where  tm_ssn_branch = @s_ssn_branch
                    and tm_oficina    = @i_ofi)
      begin
        /* Error en creacion de registro en ah_tran_monet */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251079
        return 1
      end
      /* Fin Cambios BRANCHII */

      insert into cob_ahorros..ah_notcredeb
                  (secuencial,tipo_tran,oficina,filial,usuario,
                   terminal,correccion,reentry,origen,fecha,
                   cta_banco,nodo,valor,moneda,causa,
                   signo,alterno,saldocont,saldodisp,oficina_cta,
                   prod_banc,categoria,monto_imp,tipo_exonerado,ssn_branch,
                   tipocta_super,turno,hora,canal,cliente,
                   clase_clte)
      values      (@s_ssn,264,@i_ofi,@i_filial,@s_user,
                   @s_term,'N','N','L',@i_fecha,
                   @w_cta_banco,@s_srv,@w_comision,@i_mon,'15',
                   'D',10,(@w_saldo_contable + @w_tot),(
                   @w_disponible + @i_efe - (@w_comision + @w_monto_imp)),
                   @w_oficina
                   ,
                   @o_prod_banc,@o_categoria,@w_monto_imp,
                   @w_tipo_exonerado_imp,
                   @s_ssn_branch,
                   @o_tipocta_super,@i_turno,getdate(),@i_canal,@o_cliente,
                   @o_clase_clte)

      if @@error <> 0
      begin
        /* ERROR EN INSERCION DE TRANSACCION MONETARIA */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 253000
        return 1
      end

      /* INSERTAR EL REGISTRO DE REGULARIZACION */
      insert into cob_ahorros..ah_fecha_valor
                  (fv_transaccion,fv_cuenta,fv_referencia,fv_rubro,fv_costo)
      values      (@t_trn,@i_cuenta,convert (varchar(24), @s_ssn),'3',
                   @w_comision)

      if @@error <> 0
      begin
        /* ERROR EN INSERCION DE REGISTRO DE REGULARIZACION */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 253012
        return 1
      end

    end
    else /***** @i_factor <> 1 *****/
    begin
    /*  Transaccion monetaria */
      /* Inicio Cambios BRANCHII 03-jul-01*/
      if exists (select
                   1
                 from   cob_ahorros..ah_tran_monet
                 where  tm_ssn_branch = @s_ssn_branch
                    and tm_oficina    = @i_ofi)
      begin
        /* Error en creacion de registro en ah_notcredeb */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251079
        return 1
      end
      /* Fin Cambios BRANCHII */

      insert into cob_ahorros..ah_notcredeb
                  (secuencial,tipo_tran,oficina,filial,usuario,
                   terminal,correccion,sec_correccion,reentry,origen,
                   fecha,cta_banco,nodo,valor,moneda,
                   causa,signo,alterno,saldocont,saldodisp,
                   oficina_cta,estado,prod_banc,categoria,monto_imp,
                   tipo_exonerado,ssn_branch,tipocta_super,turno,hora,
                   canal,cliente,clase_clte)
      values      (@s_ssn,264,@i_ofi,@i_filial,@s_user,
                   @s_term,'S',@t_ssn_corr,'N','L',
                   @i_fecha,@w_cta_banco,@s_srv,@w_comision,@i_mon,
                   '15','C',10,(@w_saldo_contable - @w_tot),(
                   @w_disponible - @i_efe + (@w_comision + @w_monto_imp)),
                   @w_oficina,'R',@o_prod_banc,@o_categoria,@w_monto_imp,
                   @w_tipo_exonerado_imp,@s_ssn_branch,@o_tipocta_super,@i_turno
                   ,
                   getdate(),
                   @i_canal,@o_cliente,@o_clase_clte)

      if @@error <> 0
      begin
        /* ERROR EN INSERCION DE TRANSACCION MONETARIA */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 253000
        return 1
      end

      /* ACTUALIZAR LA TRANSACCION MONET. ORIGINAL */
      update cob_ahorros..ah_tran_monet
      set    tm_estado = 'R'
      where  --tm_secuencial = @t_ssn_corr
        tm_ssn_branch  = @t_ssn_corr
      and tm_cta_banco   = @w_cta_banco
      and tm_cod_alterno = 10
      and tm_valor       = @w_comision
      and tm_causa       = '15'
      and tm_moneda      = @i_mon
      and tm_estado is null

      if @@rowcount <> 1
      begin
        /* DATOS DEL REVERSO NO COINCIDEN CON EL ORIGINAL */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251067
        return 1
      end

      /* ELIMINAR EL REGISTRO DE REGULARIZACION */
      delete cob_ahorros..ah_fecha_valor
      where  fv_transaccion = @t_trn
         and fv_cuenta      = @i_cuenta
         and fv_referencia  = convert (varchar(24), @t_ssn_corr)
         and fv_rubro       = '3'

      if @@error <> 0
      begin
        /* ERROR EN ELIMINACION REGISTRO DE REGULARIZACION */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 257003
        return 1
      end
    end
  end

  commit tran

  select
    @o_sldcont = @w_saldo_contable + (@w_tot + (@w_comision + @w_monto_imp)) *
                                                          @i_factor,
    @w_disponible = @w_disponible + @i_efe * @i_factor,
    @o_slddisp = @w_disponible,
    @w_saldo_para_girar = @w_saldo_para_girar + (@i_efe) * @i_factor

/*Modificaciones Branch II */
  /* Sp que retorna resultados para Branch II */

  if @t_ejec = 'R'
  begin
    exec @w_return = cob_ahorros..sp_resultados_branch_ah
      @s_ssn_host    = @s_ssn,
      @i_cuenta      = @i_cuenta,
      @i_fecha       = @s_date,
      @i_ofi         = @s_ofi,
      @i_tipo_cuenta = 'O'

    if @w_return <> 0
      return @w_return

  end

  return 0

go

