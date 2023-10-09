/************************************************************************/
/*  Archivo:            ah_depdifsl.sp                                  */
/*  Stored procedure:   sp_ah_depdifsl                                  */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Julio Navarrete/Javier Bucheli                  */
/*  Fecha de escritura: 25-Feb-1993                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Este programa procesa la transaccion de deposito diferido sin       */
/*      libreta                                                         */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA        AUTOR            RAZON                                 */
/*  25/Feb/1993  J Navarrete      Emision inicial                       */
/*  19/Ene/1996  D Villafuerte    Control Calidad (param remesas)       */
/*  21/Nov/1998  A Machado        Adicion del parametro @o_ssn          */
/*  09/Feb/1999  J. Salazar       Cobro de comision por la transac      */
/*  24/Feb/1999  M. Sanguino      Personalizacion B Caribe              */
/*  23/Jun/1999  J.C. Gordillo    IDB (Comision)                        */
/*  09/Jul/1999  George F. George Concatenacion de la moneda en         */
/*                                la busqueda del MMI.                  */
/*  2003/07/01   Carlos Cruz D.   Cambios Branch III                    */
/*  2004/04/22   Carlos Cruz D.   Manejo del modo masivo en BDF         */
/*  02/Mayo/2016 Ignacio Yupa     Migración a CEN                       */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_depdifsl')
  drop proc sp_ah_depdifsl
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_depdifsl
(
  @s_ssn           int,
  @s_srv           varchar(30),
  @s_lsrv          varchar(30),
  @s_user          varchar(30),
  @s_sesn          int = null,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint,
  @s_org_err       char(1) = null,/* Origen de ERROR: [A], [S] */
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @s_org           char(1),
  @s_ssn_branch    int,
  @t_corr          char(1) = 'N',  
  @t_ssn_corr      int = null,/* Trans a ser reversada */
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint,
  @t_ejec          char(1) = 'N',--CCR
  @t_show_version  bit = 0,
  @p_lssn          int = null,
  @p_rssn          int = null,
  @p_rssn_corr     int = null,
  @p_envio         char(1) = 'N',
  @p_rpta          char(1) = 'N',
  @p_nombre        varchar(30) = null,
  @p_sldcont       money = null,
  @p_slddisp       money = null,
  @i_cta           cuenta,
  @i_total         money = null,
  @i_prop          money = null,
  @i_loc           money = null,
  @i_plaz          money = null,
  @i_val           money = null,
  @i_mon           tinyint,
  @i_sp            char(1) = 'N',
  @i_monto_maximo  char(1),
  @i_batch         char(1) = 'N',
  @i_turno         smallint = null,
  @i_sld_caja      money = 0,
  @i_idcierre      int = 0,
  @i_filial        smallint = 1,
  @i_idcaja        int = 0,
  @i_fecha_valor_a datetime = null,-- CCR
  @i_estado_masivo int = 0,--CCR MODO MASIVO
  @i_prop_masivo   money = 0,--CCR MODO MASIVO
  @i_val_masivo    money = 0,--CCR MODO MASIVO
  @i_ape1          varchar(30) = null,-- Primer apellido del Gestor
  @i_ape2          varchar(30) = null,-- Segundo apellido del Gestor
  @i_nom1          varchar(30) = null,-- Primer nombre del Gestor
  @i_nom2          varchar(30) = null,-- Segundo nombre del Gestor
  @i_tipoid        varchar(3) = null,-- Tipo de Identificacion del Gestor
  @i_numeroid      varchar(20) = null,-- Numero de identificacion del Gestor
  @i_direccion     varchar(80) = null,-- Direccion del Gestor 
  @i_nacionalidad  varchar(10) = null,-- Codigo del Pais del Gestor
  @i_trnb          int = null,-- Codigo de la transaccion Branch
  @i_gestor        char(1) = null,
  -- Bandera que indica si el gestor fue encontrado o no cuando el cajero realizo 

  -- la busqueda mediante el numero de identificacion. 
  @i_cod_gestor    int = null,-- Codigo del Gestor
  @i_canal         smallint = 4,
  @o_nombre        varchar(30) = null out,
  @o_ssn           int = null out
)
as
  declare
    @w_return            int,
    @w_sp_name           varchar(30),
    @w_cuenta            int,
    @w_filial            tinyint,
    @w_oficina           smallint,
    @w_filial_p          tinyint,
    @w_oficina_p         smallint,
    @w_producto          tinyint,
    @w_sldcont           money,
    @w_slddisp           money,
    @w_rssn_corr         int,
    @w_server_rem        descripcion,
    @w_server_local      descripcion,
    @w_tipo              char(1),
    @w_factor            int,
    @w_signo             char(1),
    @w_efe               money,
    @w_loc               money,
    @w_prop              money,
    @w_rem               money,
    @w_oficina_cta       smallint,
    @w_ncontrol          int,
    @w_lpend             int,
    @w_prod_banc         smallint,
    @w_monto_maximo_cred money,
    @w_categoria         char(1),
    @w_tipocta_super     char(1),
    @w_clase_clte        char(1),
    @w_siguiente         int,
    @w_num_id            char(15),
    @w_mombre            char(64),
    @w_cod_cliente       int

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_depdifsl'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end
  select
    @o_ssn = @s_ssn

  if @i_turno is null
    select
      @i_turno = @s_rol

  /* Chequeo de errores generados remotamente */
  if @s_org_err is not null /*  Error del Sistema  */
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @s_error,
      @i_sev   = @s_sev,
      @i_msg   = @s_msg
    return @s_error
  end

  /* verifica la apertura de caja  */
  if @s_org = 'U'
  begin
    /** Verificar que la caja se encuentre aperturada **/
    exec @w_return = cob_remesas..sp_verifica_caja
      @t_trn    = @t_trn,
      @i_user   = @s_user,
      @i_ofi    = @s_ofi,
      @i_srv    = @s_srv,
      @i_date   = @s_date,
      @i_filial = @i_filial,
      @i_mon    = @i_mon,
      @i_idcaja = @i_idcaja

    if @w_return <> 0
      return @w_return

  end
  /*verificacion de creditos a cta. de ahorro  */
  if @i_monto_maximo = 'S'
     and @t_corr = 'N'
  begin
    select
      @w_monto_maximo_cred = pa_money
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'MMI' + convert(varchar(3), @i_mon)

    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201196
      return 201196
    end
    if @i_val + @i_prop + @i_loc > @w_monto_maximo_cred
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251072
      return 251072
    end
  end

  /*  lgr   */

  if @t_trn = 253
      or @t_trn = 255
    goto Salta_Gestor

  Salta_Gestor:

  /*  Captura de parametros de la oficina  */
  exec @w_return = cobis..sp_parametros
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @w_sp_name,
    @s_lsrv         = @s_lsrv,
    @i_nom_producto = 'CUENTA%AHORRO%',
    @o_filial       = @w_filial out,
    @o_oficina      = @w_oficina out,
    @o_producto     = @w_producto out,
    @o_server_local = @w_server_local
  if @w_return <> 0
    return @w_return

  /*  Determinacion de condicion de local o remoto  */
  exec @w_return = cob_ahorros..sp_cta_origen
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_cta       = @i_cta,
    @i_producto  = @w_producto,
    @i_mon       = @i_mon,
    @i_oficina   = @w_oficina,
    @o_tipo      = @w_tipo out,
    @o_srv_local = @w_server_local out,
    @o_srv_rem   = @w_server_rem out

  if @w_return <> 0
    return @w_return

  select
    @w_server_local = @s_lsrv

  /*  Modo de correccion  */
  if @t_corr = 'N'
    select
      @w_factor = 1,
      @w_signo = 'C'
  else
    select
      @w_factor = -1,
      @w_signo = 'D'

  begin tran

  /* Encontrar el seqnos para el numero de control y para la linea pendiente */

  update cobis..cl_seqnos
  set    siguiente = siguiente + 3
  where  tabla = 'ah_control'

  select
    @w_ncontrol = siguiente - 2
  from   cobis..cl_seqnos
  where  tabla = 'ah_control'

  if @w_ncontrol >= 9998
  begin
    select
      @w_ncontrol = 0

    update cobis..cl_seqnos
    set    siguiente = 2
    where  tabla = 'ah_control'
  end

  update cobis..cl_seqnos
  set    siguiente = siguiente + 3
  where  tabla = 'ah_lpendiente'

  select
    @w_lpend = siguiente - 2
  from   cobis..cl_seqnos
  where  tabla = 'ah_lpendiente'

  if @w_lpend >= 2147483639
  begin
    select
      @w_lpend = 0

    update cobis..cl_seqnos
    set    siguiente = 2
    where  tabla = 'ah_lpendiente'
  end

  commit tran

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      origen = @s_org,
      tipo = @w_tipo,
      serverloc = @w_server_local,
      serverrem = @w_server_rem
    exec cobis..sp_end_debug
  end
  /*  Transaccion generada por usuario  */
  if @s_org = 'U'
  begin
    /*  Transaccion local  */
    if @w_tipo = 'L'
    begin
      begin tran
      exec @w_return = cob_ahorros..sp_ah_depdi_locrem_sl
        @s_ssn           = @s_ssn,
        @s_srv           = @s_srv,
        @s_lsrv          = @s_lsrv,
        @s_user          = @s_user,
        @s_sesn          = @s_sesn,
        @s_term          = @s_term,
        @s_date          = @s_date,
        @s_ofi           = @s_ofi,
        @s_rol           = @s_rol,
        @s_ssn_branch    = @s_ssn_branch,
        @t_corr          = @t_corr,
        @t_ssn_corr      = @t_ssn_corr,
        @t_debug         = @t_debug,
        @t_from          = @w_sp_name,
        @t_file          = @t_file,
        @t_rty           = @t_rty,
        @t_trn           = @t_trn,
        @t_ejec          = @t_ejec,--CCR
        @p_rssn          = @p_rssn,
        @p_rssn_corr     = @p_rssn_corr,
        @s_org           = @s_org,
        @i_cta           = @i_cta,
        @i_efe           = @i_val,
        @i_prop          = @i_prop,
        @i_loc           = @i_loc,
        @i_plaz          = @i_plaz,
        @i_credit        = @i_val,
        @i_oficina       = @w_oficina,
        @i_mon           = @i_mon,
        @i_sp            = @i_sp,
        @i_ncontrol      = @w_ncontrol,
        @i_lpend         = @w_lpend,
        @i_batch         = @i_batch,
        @i_turno         = @i_turno,
        @i_filial        = @i_filial,
        @i_idcaja        = @i_idcaja,
        @i_idcierre      = @i_idcierre,
        @i_sld_caja      = @i_sld_caja,
        @i_fecha_valor_a = @i_fecha_valor_a,--CCR
        @i_estado_masivo = @i_estado_masivo,--CCR MODO MASIVO
        @i_prop_masivo   = @i_prop_masivo,--CCR MODO MASIVO
        @i_val_masivo    = @i_val_masivo,--CCR MODO MASIVO
        @i_canal         = @i_canal,
        @o_sldcont       = @w_sldcont out,
        @o_slddisp       = @w_slddisp out,
        @o_nombre        = @o_nombre out,
        @o_oficina_cta   = @w_oficina_cta out,
        @o_prod_banc     = @w_prod_banc out,
        @o_categoria     = @w_categoria out,
        @o_clase_clte    = @w_clase_clte out,
        @o_tipocta_super = @w_tipocta_super out
      if @w_return <> 0
        rollback tran
      else
        commit tran

      /* Devolucion de s_ssn del Central para Branch II */
      if @t_ejec = 'R'
      begin
        select
          'results_submit_rpc',
          r_control = @w_ncontrol
        --CCR BRANCH III
        exec cob_remesas..sp_resultados_branch_caja
          @i_sldcaja  = @i_sld_caja,
          @i_idcierre = @i_idcierre,
          @i_ssn_host = @s_ssn
      end

      return @w_return
    end

    /*  Transaccion remota  */
    if @w_tipo = 'R'
    begin
      /*  Envio de transaccion remota  */
      if @t_debug = 'S'
      begin
        exec cobis..sp_begin_debug
          @t_file=@t_file
        select
          '/**  Stored Procedure  **/ ' = @w_sp_name,
          'Inicio secure submit server=' = @w_server_rem
        exec cobis..sp_end_debug
      end

      if @t_corr = 'S'
      begin
        if @t_trn = 246
          select
            @w_rssn_corr = remoto_ssn
          from   cob_ahorros..ah_deposito
          where  secuencial = @t_ssn_corr
        else
          select
            @w_rssn_corr = remoto_ssn
          from   cob_ahorros..ah_notcredeb
          where  secuencial = @t_ssn_corr
      end
      exec cobis..sp_begin_secure_submit
        @i_toserver = @w_server_rem
      select
        p_lssn = @s_ssn,
        p_envio = 'S',
        p_rssn_corr = @w_rssn_corr
      exec @w_return = cobis..sp_end_secure_submit
        @i_wait = 'S'
      return 0
    end
  end

  /*  Transaccion submitida desde otro regional  */

  if @s_org = 'S'
  begin
    /*  Transaccion Local  */
    if @w_tipo = 'L'
    begin
      exec @w_return = cob_ahorros..sp_ah_depdi_locrem_sl
        @s_ssn           = @s_ssn,
        @s_srv           = @s_srv,
        @s_lsrv          = @s_lsrv,
        @s_user          = @s_user,
        @s_sesn          = @s_sesn,
        @s_term          = @s_term,
        @s_date          = @s_date,
        @s_ofi           = @s_ofi,
        @s_rol           = @s_rol,
        @t_corr          = @t_corr,
        @t_ssn_corr      = @t_ssn_corr,
        @t_debug         = @t_debug,
        @t_from          = @t_from,
        @t_file          = @t_file,
        @t_rty           = @t_rty,
        @t_trn           = @t_trn,
        @t_ejec          = @t_ejec,--CCR
        @p_lssn          = @p_lssn,
        @p_rssn          = @p_rssn,
        @p_rssn_corr     = @p_rssn_corr,
        @s_org           = @s_org,
        @i_cta           = @i_cta,
        @i_efe           = @i_val,
        @i_prop          = @i_prop,
        @i_loc           = @i_loc,
        @i_plaz          = @i_plaz,
        @i_credit        = @i_val,
        @i_oficina       = @w_oficina,
        @i_mon           = @i_mon,
        @i_sp            = @i_sp,
        @i_batch         = @i_batch,
        @i_turno         = @i_turno,
        @i_filial        = @i_filial,
        @i_idcaja        = @i_idcaja,
        @i_idcierre      = @i_idcierre,
        @i_sld_caja      = @i_sld_caja,
        @i_fecha_valor_a = @i_fecha_valor_a,
        @i_estado_masivo = @i_estado_masivo,--CCR MODO MASIVO
        @i_prop_masivo   = @i_prop_masivo,--CCR MODO MASIVO
        @i_val_masivo    = @i_val_masivo,--CCR MODO MASIVO
        @i_canal         = @i_canal,
        @o_sldcont       = @w_sldcont out,
        @o_slddisp       = @w_slddisp out,
        @o_nombre        = @o_nombre out,
        @o_oficina_cta   = @w_oficina_cta out,
        @o_prod_banc     = @w_prod_banc out,
        @o_categoria     = @w_categoria out,
        @o_clase_clte    = @w_clase_clte out,
        @o_tipocta_super = @w_tipocta_super out
      if @w_return <> 0
        return @w_return

      /*  Envio de Resultados  */
      if @t_debug = 'S'
      begin
        exec cobis..sp_begin_debug
          @t_file=@t_file
        select
          '/**  Stored Procedure  **/ ' = @w_sp_name,
          'Inicio resubmit server=' = @s_srv,
          i_toserver = @s_srv,
          i_touser = @s_user,
          i_tosesion = @s_sesn,
          p_sldcont = @w_sldcont,
          p_slddisp = @w_slddisp,
          p_nombre = @o_nombre
        exec cobis..sp_end_debug
      end

      exec @w_return = cobis..sp_begin_resubmit
        @i_toserver = @s_srv,
        @i_touser   = @s_user,
        @i_tosesion = @s_sesn
      if @w_return <> 0
        return @w_return

      select
        p_rpta = 'S',
        p_sldcont = @w_sldcont,
        p_slddisp = @w_slddisp,
        p_nombre = @o_nombre,
        p_rssn = @s_ssn
      exec @w_return = cobis..sp_end_resubmit
    end

    /*  Transaccion remota:  Error */
    if @w_tipo = 'R'
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201002
      return 201002
    end
  end

  select
    @w_efe = 0,
    @w_prop = 0,
    @w_loc = 0,
    @w_rem = 0
  /*  Transaccion recibida de regional remoto  */
  if @s_org = 'R'
  begin
    begin tran
    /*  Transaccion monetaria */
    insert into cob_ahorros..ah_deposito
                (secuencial,ssn_branch,tipo_tran,oficina,usuario,
                 terminal,correccion,sec_correccion,reentry,origen,
                 nodo,fecha,cta_banco,efectivo,propios,
                 locales,signo,ot_plazas,remoto_ssn,moneda,
                 saldo_lib,control,fecha_efec,saldocont,saldodisp,
                 oficina_cta,prod_banc,categoria,tipocta_super,turno,
                 hora,canal,clase_clte)
    values      (@p_lssn,@s_ssn_branch,@t_trn,@s_ofi,@s_user,
                 @s_term,@t_corr,@t_ssn_corr,@t_rty,'L',
                 @w_server_rem,@s_date,@i_cta,@i_val,@i_prop,
                 @i_loc,@w_signo,@i_plaz,@p_rssn,@i_mon,
                 null,null,null,@p_sldcont,@p_slddisp,
                 @w_oficina_cta,@w_prod_banc,@w_categoria,@w_tipocta_super,
                 @i_turno,
                 getdate(),@i_canal,@w_clase_clte)

    /* Actualizacion de totales de cajero */
    exec @w_return = cob_remesas..sp_upd_totales
      @i_ofi         = @s_ofi,
      @i_rol         = @i_turno,
      @i_user        = @s_user,
      @i_mon         = @i_mon,
      @i_trn         = @t_trn,
      @i_nodo        = @s_srv,
      @i_tipo        = 'L',
      @i_corr        = @t_corr,
      @i_efectivo    = @i_val,
      @i_cheque      = @i_prop,
      @i_chq_locales = @i_loc,
      @i_chq_ot_plaz = @i_plaz,
      @i_ssn         = @s_ssn,
      @i_filial      = @i_filial,
      @i_idcaja      = @i_idcaja,
      @i_idcierre    = @i_idcierre,
      @i_saldo_caja  = @i_sld_caja,
      @i_cta_banco   = @i_cta
    if @w_return = 0
    begin
      /*  Actualizacion de totales de servidor enviado (remoto) */
      exec @w_return = cob_remesas..sp_upd_totales
        @i_ofi         = @w_oficina,
        @i_rol         = @i_turno,
        @i_user        = @s_srv,
        @i_mon         = @i_mon,
        @i_trn         = @t_trn,
        @i_nodo        = @w_server_rem,
        @i_tipo        = 'E',
        @i_corr        = @t_corr,
        @i_efectivo    = @i_val,
        @i_cheque      = @i_prop,
        @i_chq_locales = @i_loc,
        @i_chq_ot_plaz = @i_plaz,
        @i_ssn         = @s_ssn,
        @i_filial      = @i_filial,
        @i_idcaja      = @i_idcaja,
        @i_idcierre    = @i_idcierre,
        @i_saldo_caja  = @i_sld_caja,
        @i_cta_banco   = @i_cta
      if @w_return = 0
      begin
        commit tran
        select
          'Nombre' = @p_nombre
        return 0
      end
      else
        return @w_return

    end
  end

go

