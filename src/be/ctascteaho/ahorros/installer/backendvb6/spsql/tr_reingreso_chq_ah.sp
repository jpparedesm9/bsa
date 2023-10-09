use cob_ahorros
go

/************************************************************************/
/*  Archivo:            tr_reingreso_chq_ah.sp                          */
/*  Stored procedure:   sp_tr_reingreso_chq_ah                          */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:       Cuentas Corrientes                                  */
/*  Disenado por:       Jaime Hidalgo                                   */
/*  Fecha de escritura: 12-Jun-2002                                     */
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
/*  Este programa procesa la transaccion de reingreso de cheques        */
/*  en Cuentas de Ahorros                                               */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA          AUTOR           RAZON                                */
/*  29/Jun/2002 J. Hidalgo  Emision Inicial                             */
/*      02/Mayo/2016    Walther Toledo  Migración a CEN                 */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_reingreso_chq_ah')
  drop proc sp_tr_reingreso_chq_ah
go

create proc sp_tr_reingreso_chq_ah
(
  @s_ssn          int,
  @s_ssn_branch   int,
  @s_srv          varchar(30),
  @s_lsrv         varchar(30),
  @s_user         varchar(30),
  @s_sesn         int=null,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_ofi          smallint,/* Localidad origen transaccion */
  @s_rol          smallint,
  @s_org_err      char(1) = null,/* Origen de ERROR: [A], [S] */
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @s_org          char(1),
  @t_ejec         char(1) = 'N',
  @t_user         varchar(30) = null,
  @t_term         varchar(30) = null,
  @t_srv          varchar(30) = null,
  @t_ofi          smallint = null,
  @t_rol          smallint = null,
  @t_corr         char(1) = 'N',
  @t_ssn_corr     int = null,/* Trans a ser reversada */
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @p_lssn         int = null,
  @p_rssn         int = null,
  @p_rssn_corr    int = null,
  @p_slddisp      money = null,
  @p_sldcont      money = null,
  @p_nombre       varchar(30) = null,
  @p_envio        char(1) = 'N',
  @p_rpta         char(1) = 'N',
  @i_mon          tinyint,
  @i_cta_banco    cuenta,
  @i_banco        smallint,
  @i_cta_chq      cuenta,
  @i_chq          int,
  @i_val          money,
  @i_cau          varchar(3),
  @i_sld_caja     money = 0,
  @i_idcierre     int = 0,
  @i_filial       smallint = 1,
  @i_idcaja       int = 0,
  @i_turno        smallint = null,
  @o_prod_banc    smallint = null out,
  @o_categoria    char(1) = null out,
  @o_ssn          int = null out,
  @o_nombre       varchar(30) = null out
)
as
  declare
    @w_return        int,
    @w_sp_name       varchar(30),
    @w_filial        tinyint,
    @w_oficina       smallint,
    @w_oficina_p     smallint,
    @w_producto      tinyint,
    @w_server_rem    descripcion,
    @w_server_local  descripcion,
    @w_tipo          char(1),
    @w_sldcont       money,
    @w_slddisp       money,
    @w_factor        int,
    @w_estado        varchar(1),
    @w_nombre        varchar(30),
    @w_prod          varchar(80),
    @w_signo         char(1),
    @w_flag          float,
    @w_tipocta_super char(1),
    @w_referencia    varchar(20)

  -- Determinar si la transaccion es ejecutada por el REENTRY del SAIP
  if @t_user is not null
  begin
    select
      @s_user = @t_user,
      @s_term = @t_term,
      @s_srv = @t_srv,
      @s_ofi = @t_ofi,
      @s_rol = @t_rol
  end

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_tr_reingreso_chq_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  select
    @o_ssn = @s_ssn

  /*  Modo de debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**  Stored Procedure  **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_ssn_branch = @s_ssn_branch,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      s_org = @s_org,
      t_ejec = @t_ejec,
      t_user = @t_user,
      t_term = @t_term,
      t_srv = @t_srv,
      t_ofi = @t_ofi,
      t_rol = @t_rol,
      t_corr = @t_corr,
      t_ssn_corr = @t_ssn_corr,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_rty = @t_rty,
      t_trn = @t_trn,
      p_lssn = @p_lssn,
      p_rssn = @p_rssn,
      p_rssn_corr = @p_rssn_corr,
      p_nombre = @p_nombre,
      p_envio = @p_envio,
      p_rpta = @p_rpta,
      i_mon = @i_mon,
      i_cta_banco = @i_cta_banco,
      i_banco = @i_banco,
      i_cta_chq = @i_cta_chq,
      i_chq = @i_chq,
      i_valor = @i_val,
      i_cau = @i_cau,
      i_sld_caja = @i_sld_caja,
      i_idcierre = @i_idcierre,
      i_filial = @i_filial,
      i_idcaja = @i_idcaja
    exec cobis..sp_end_debug
  end

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

  /* Valida si se ha aperturado caja */

  if @s_org = 'U'
  begin
    if @i_idcaja = 0 /*Version ATX*/ -- ELI 14/11/2002
    begin
      if not exists (select
                       1
                     from   cob_remesas..re_caja
                     where  cj_oficina     = @s_ofi
                        and cj_rol         = @s_rol
                        and cj_operador    = @s_user
                        and cj_moneda      = @i_mon
                        and cj_transaccion = 15)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201063
        return 1
      end

    end
    else /*Version Branch Explorer*/
    begin
      exec @w_return= cob_remesas..sp_verifica_caja
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

    end -- FIN ELI 14/11/2002
  end

  select
    @w_prod = 'CUENTA DE AHORROS'
  /*  Captura de parametros de la oficina  */
  exec @w_return = cobis..sp_parametros
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @w_sp_name,
    @s_lsrv         = @s_lsrv,
    @i_nom_producto = @w_prod,
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
    @i_cta       = @i_cta_banco,
    @i_producto  = @w_producto,
    @i_mon       = @i_mon,
    @i_oficina   = @w_oficina,
    @o_tipo      = @w_tipo out,
    @o_srv_local = @w_server_local out,
    @o_srv_rem   = @w_server_rem out
  if @w_return <> 0
    return @w_return

  if @w_tipo = 'L'
    select
      @w_server_local = @s_lsrv

  /*  Modo de correccion  */
  if @t_corr = 'N'
    select
      @w_factor = 1,
      @w_signo = 'C',
      @w_estado = null
  else
    select
      @w_factor = -1,
      @w_signo = 'D',
      @w_estado = 'R'

  if @i_turno is null
    select
      @i_turno = @s_rol

  /*  Transaccion generada por usuario  */
  if @s_org = 'U'
  begin
    if @w_tipo = 'L'
    begin /*  Transaccion local  */
      exec @w_return = cob_ahorros..sp_reingreso_chq_ah
        @s_ssn           = @s_ssn,
        @s_ssn_branch    = @s_ssn_branch,
        @s_srv           = @s_srv,
        @s_lsrv          = @s_lsrv,
        @s_user          = @s_user,
        @s_sesn          = @s_sesn,
        @s_term          = @s_term,
        @s_date          = @s_date,
        @s_ofi           = @s_ofi,
        @s_rol           = @s_rol,
        @t_ejec          = @t_ejec,
        @t_corr          = @t_corr,
        @t_ssn_corr      = @t_ssn_corr,
        @t_debug         = @t_debug,
        @t_from          = @w_sp_name,
        @t_file          = @t_file,
        @t_rty           = @t_rty,
        @t_trn           = @t_trn,
        @p_lssn          = @p_lssn,
        @p_rssn          = @p_rssn,
        @p_rssn_corr     = @p_rssn_corr,
        @s_org           = @s_org,
        @i_fecha         = @s_date,
        @i_cta_banco     = @i_cta_banco,
        @i_banco         = @i_banco,
        @i_val           = @i_val,
        @i_mon           = @i_mon,
        @i_filial        = @i_filial,
        @i_idcaja        = @i_idcaja,
        @i_idcierre      = @i_idcierre,
        @i_sld_caja      = @i_sld_caja,
        @i_cta_chq       = @i_cta_chq,
        @i_chq           = @i_chq,
        @i_cau           = @i_cau,
        @o_slddisp       = @w_slddisp out,
        @o_nombre        = @o_nombre out,
        @o_sldcont       = @w_sldcont out,
        @o_oficina       = @w_oficina_p out,
        @o_flag          = @w_flag out,
        @o_prod_banc     = @o_prod_banc out,
        @o_categoria     = @o_categoria out,
        @o_tipocta_super = @w_tipocta_super out

      if @t_ejec = 'R'
        exec cob_remesas..sp_resultados_branch_caja
          @i_sldcaja  = @i_sld_caja,
          @i_idcierre = @i_idcierre,
          @i_ssn_host = @s_ssn

      select
        @o_ssn = @o_ssn
      select
        @o_nombre = @o_nombre
      return @w_return
    end

    /*  Transaccion remota  */
    if @w_tipo = 'R'
    begin /*  Envio de transaccion remota  */
      exec cobis..sp_begin_secure_submit
        @i_toserver = @w_server_rem
      select
        p_lssn = @s_ssn,
        p_envio = 'S',
        p_rssn_corr = (select
                         remoto_ssn
                       from   cob_ahorros..ah_notcredeb
                       where  secuencial = @t_ssn_corr)
      exec @w_return = cobis..sp_end_secure_submit
        @i_wait = 'S'
      return 0
    end
  end

  /*  Transaccion submitida desde otro regional  */
  if @s_org = 'S'
  begin /*  Transaccion Local  */
    if @w_tipo = 'L'
    begin
      exec @w_return = cob_ahorros..sp_reingreso_chq_ah
        @s_ssn           = @s_ssn,
        @s_ssn_branch    = @s_ssn_branch,
        @s_srv           = @s_srv,
        @s_lsrv          = @s_lsrv,
        @s_user          = @s_user,
        @s_sesn          = @s_sesn,
        @s_term          = @s_term,
        @s_date          = @s_date,
        @s_ofi           = @s_ofi,
        @s_rol           = @s_rol,
        @t_ejec          = @t_ejec,
        @t_corr          = @t_corr,
        @t_ssn_corr      = @t_ssn_corr,
        @t_debug         = @t_debug,
        @t_from          = @t_from,
        @t_file          = @t_file,
        @t_rty           = @t_rty,
        @t_trn           = @t_trn,
        @p_lssn          = @p_lssn,
        @p_rssn          = @p_rssn,
        @p_rssn_corr     = @p_rssn_corr,
        @s_org           = @s_org,
        @i_fecha         = @s_date,
        @i_cta_banco     = @i_cta_banco,
        @i_banco         = @i_banco,
        @i_val           = @i_val,
        @i_mon           = @i_mon,
        @i_filial        = @i_filial,
        @i_idcaja        = @i_idcaja,
        @i_idcierre      = @i_idcierre,
        @i_sld_caja      = @i_sld_caja,
        @i_cta_chq       = @i_cta_chq,
        @i_chq           = @i_chq,
        @i_cau           = @i_cau,
        @o_slddisp       = @w_slddisp out,
        @o_nombre        = @w_nombre out,
        @o_sldcont       = @w_sldcont out,
        @o_oficina       = @w_oficina_p out,
        @o_flag          = @w_flag out,
        @o_prod_banc     = @o_prod_banc out,
        @o_categoria     = @o_categoria out,
        @o_tipocta_super = @w_tipocta_super out

      if @w_return <> 0
        return @w_return

      exec @w_return = cobis..sp_begin_resubmit
        @i_toserver = @s_srv,
        @i_touser   = @s_user,
        @i_tosesion = @s_sesn
      if @w_return <> 0
        return @w_return

      select
        p_rpta = 'S',
        p_rssn = @s_ssn,
        p_sldcont = @w_sldcont,
        p_slddisp = @w_slddisp,
        p_nombre = @w_nombre
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
    @w_referencia = convert(varchar(20), @i_chq)

  /*  Transaccion recibida de regional remoto  */
  if @s_org = 'R'
  begin
    begin tran

    if @w_factor = -1
    begin
      if exists (select
                   1
                 from   cob_ahorros..ah_tran_servicio
                 where  ts_secuencial = @t_ssn_corr
                    and ts_valor      = @i_val
                    and ts_oficina    = @s_ofi
                    and ts_cta_banco  = @i_cta_banco
                    and ts_moneda     = @i_mon
                    and ts_usuario    = @s_user
                    and ts_estado is null)
        select
          @t_debug = 'N'
      else
      begin
        /* No encontro el registro en monetarias */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251067
        return 251067
      end

      update ah_tran_servicio
      set    ts_estado = @w_estado
      where  ts_secuencial = @t_ssn_corr
      if @@rowcount <> 1
      begin
        /* Error en actualizacion de registro en ah_tran_monet */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 255004
        return 255004
      end
    end

    /*  Transaccion de servicio */
    insert into cob_ahorros..ah_tran_servicio
                (ts_secuencial,ts_cod_alterno,ts_tipo_transaccion,ts_oficina,
                 ts_usuario,
                 ts_terminal,ts_correccion,ts_sec_correccion,ts_reentry,
                 ts_origen,
                 ts_nodo,ts_tsfecha,ts_cta_banco,ts_cheque,ts_valor,--tm_signo,
                 ts_remoto_ssn,ts_moneda,ts_saldo,--_contable,
                 --tm_saldo_disponible,
                 ts_oficina_cta,ts_estado,
                 ts_prod_banc,ts_categoria,ts_ssn_branch,ts_tipocta_super,
                 ts_turno
    )
    values      (@p_lssn,0,@t_trn,@s_ofi,@s_user,
                 @s_term,@t_corr,@t_ssn_corr,@t_rty,'R',
                 @w_server_rem,@s_date,@i_cta_banco,@i_chq,@i_val,--@w_signo,
                 @p_rssn,@i_mon,@p_slddisp,--@p_sldcont,
                 @w_oficina,@w_estado,
                 @o_prod_banc,@o_categoria,@s_ssn_branch,@w_tipocta_super,
                 @i_turno
    )

    if @@error <> 0
    begin
      rollback

      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203005

      return 203005
    end

    commit tran
    select
      'Nombre' = @p_nombre
    return 0

  end
  return 0

go

