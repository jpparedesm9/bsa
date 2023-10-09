use cob_ahorros
go

/************************************************************************/
/*  Archivo:            tr_ndchqdev_aho_ot_bancos.sp                    */
/*  Stored procedure:   sp_tr_ndchqdev_aho_ot_bancos                    */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       N/N                                             */
/*  Fecha de escritura:                                                 */
/************************************************************************/
/*                          IMPORTANTE                                  */
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
/*                               PROPOSITO                              */
/*  Nota de Debito de cheque devueltos en ahorros de otros bancos       */
/*                                                                      */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*   FECHA           AUTOR           RAZON                              */
/*  02/Mayo/2016    Walther Toledo  Migración a CEN                     */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_ndchqdev_aho_ot_bancos')
  drop proc sp_tr_ndchqdev_aho_ot_bancos
go

create proc sp_tr_ndchqdev_aho_ot_bancos
(
  @s_ssn          int,
  @s_ssn_branch   int = null,/* Cambios para BRANCHII */
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
  @t_corr         char(1) = 'N',
  @t_ssn_corr     int = null,/* Trans a ser reversada */
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_ejec         char(1) = null,/* Cambios BRANCHII */
  @t_show_version bit = 0,
  @p_lssn         int = null,
  @p_rssn         int = null,
  @p_rssn_corr    int = null,
  @p_envio        char(1) = 'N',
  @p_rpta         char(1) = 'N',
  @p_sldcont      money = null,
  @p_slddisp      money = null,
  @p_nombre       varchar(30) = null,
  @p_val_deb      money = null,
  @i_ctadb        cuenta,
  @i_codbanco     varchar(12),
  @i_ctachq       cuenta,
  @i_nchq         int,
  @i_val          money,
  @i_tipchq       varchar(1) = 'L',
  @i_dpto         tinyint = 1,/* ojo cambiar por departamento de cc */
  @i_mon          tinyint,
  @i_cau          varchar(3),/* causa de la devolucion */
  @i_turno        smallint = null,
  @i_sld_caja     money = 0,
  @i_idcierre     int = 0,
  @i_filial       smallint = 1,
  @i_idcaja       int = 0,
  @x_ofi          smallint = null,
  @i_canal        smallint = 4,
  @o_nombre       varchar(30) out,
  @o_ssn          int = null out
)
as
  declare
    @w_return        int,
    @w_sp_name       varchar(30),
    @w_cuenta        int,
    @w_filial        tinyint,
    @w_oficina       smallint,
    @w_producto      tinyint,
    @w_val_mon       money,
    @w_server_rem    descripcion,
    @w_server_local  descripcion,
    @w_tipo          char(1),
    @w_signo         char(1),
    @w_rssn_corr     int,
    @w_val_deb       money,
    @w_comision      money,
    @w_sldcont       money,
    @w_slddisp       money,
    @w_prod          varchar(30),
    @w_bco           smallint,
    @w_ofi           smallint,
    @w_par           int,
    @w_factor        int,
    @w_clave1        int,
    @w_clave2        int,
    @w_oficina_cta   smallint,
    @w_prod_banc     smallint,
    @w_categoria     char(1),
    @w_tipocta_super char(1)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_tr_ndchqdev_aho_ot_bancos'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  select
    @o_ssn = @s_ssn

  if @i_turno is null
    select
      @i_turno = @s_rol

  /*  Modo de debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**  Stored Procedure  **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
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
      s_ori = @s_org,
      t_corr = @t_corr,
      t_ssn_corr = @t_ssn_corr,
      t_from = @t_from,
      t_file = @t_file,
      t_rty = @t_rty,
      t_trn = @t_trn,
      p_lssn = @p_lssn,
      p_rssn = @p_rssn,
      p_rssn_corr = @p_rssn_corr,
      p_envio = @p_envio,
      p_rpta = @p_rpta,
      i_ctadb = @i_ctadb,
      i_codbanco = @i_codbanco,
      i_ctachq = @i_ctachq,
      i_nchq = @i_nchq,
      i_val = @i_val,
      i_tipchq = @i_tipchq,
      i_dpto = @i_dpto,
      i_mon = @i_mon,
      i_cau = @i_cau
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
    return 1
  end

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

  /* Chequeo de la Causa */
  if not exists (select
                   1
                 from   cobis..cl_catalogo
                 where  tabla in
                        (select
                           codigo
                         from   cobis..cl_tabla
                         where  tabla in ('cc_causa_dev'))
                        and codigo = @i_cau)
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201030
    return 201030
  end

  /* Validacion de existencia del departamento que hace la nota de debito */
  if not exists (select
                   de_departamento
                 from   cobis..cl_departamento /* EGA */
                 where  de_departamento = @i_dpto)
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101010
    return 1
  end

  /* Desglose del Codigo de banco */
  select
    @w_bco = convert (smallint, substring (@i_codbanco,
                                           1,
                                           3))
  select
    @w_ofi = convert (smallint, substring (@i_codbanco,
                                           4,
                                           3))
  select
    @w_par = convert (int, substring (@i_codbanco,
                                      7,
                                      6))

  if @x_ofi is not null
    select
      @s_ofi = @x_ofi

  /*  Captura de parametros de la oficina  */
  exec @w_return = cobis..sp_parametros
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @w_sp_name,
    @s_lsrv         = @s_lsrv,
    @i_nom_producto = 'CUENTA DE AHORROS',
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
    @i_cta       = @i_ctadb,
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
      @w_signo = 'D'
  else
    select
      @w_factor = -1,
      @w_signo = 'C'

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/**  Stored Procedure  **/ ' = @w_sp_name,
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
      exec @w_return = cob_ahorros..sp_tr_ndchqdevob_loc_rem_aho
        @s_ssn           = @s_ssn,
        @s_ssn_branch    = @s_ssn_branch,/*Modif para BRANCHII */
        @s_srv           = @s_srv,
        @s_lsrv          = @s_lsrv,
        @s_user          = @s_user,
        @s_sesn          = @s_sesn,
        @s_term          = @s_term,
        @s_date          = @s_date,
        @s_ofi           = @s_ofi,
        @s_rol           = @s_rol,
        @s_org_err       = @s_org_err,
        @s_error         = @s_error,
        @s_sev           = @s_sev,
        @s_msg           = @s_msg,
        @s_org           = @s_org,
        @t_ejec          = @t_ejec,/*Modif. BRANCHII BBO */
        @t_corr          = @t_corr,
        @t_ssn_corr      = @t_ssn_corr,
        @t_debug         = @t_debug,
        @t_from          = @w_sp_name,
        @t_file          = @t_file,
        @t_rty           = @t_rty,
        @t_trn           = @t_trn,
        @p_lssn          = @p_lssn,
        @p_rssn_corr     = @p_rssn_corr,
        @i_ctadb         = @i_ctadb,
        @i_producto      = @w_producto,
        @i_oficina       = @w_oficina,
        @i_bco           = @w_bco,
        @i_ofi           = @w_ofi,
        @i_par           = @w_par,
        @i_ctachq        = @i_ctachq,
        @i_nchq          = @i_nchq,
        @i_valch         = @i_val,
        @i_tipchq        = @i_tipchq,
        @i_dpto          = @i_dpto,
        @i_mon           = @i_mon,
        @i_cau           = @i_cau,
        @i_turno         = @i_turno,
        @i_filial        = @i_filial,
        @i_idcaja        = @i_idcaja,
        @i_idcierre      = @i_idcierre,
        @i_sld_caja      = @i_sld_caja,
        @i_canal         = @i_canal,
        @o_sldcont       = @w_sldcont out,
        @o_slddisp       = @w_slddisp out,
        @o_nombre        = @o_nombre out,
        @o_val_deb       = @w_val_deb out,
        @o_comision      = @w_comision out,
        @o_clave1        = @w_clave1 out,
        @o_clave2        = @w_clave2 out,
        @o_oficina_cta   = @w_oficina_cta out,
        @o_prod_banc     = @w_prod_banc out,
        @o_categoria     = @w_categoria out,
        @o_tipocta_super = @w_tipocta_super out

      if @w_return <> 0
        return @w_return

      if @w_clave1 <> 0
      begin
        exec @w_return = cobis..sp_reentry
          @i_key  = @w_clave1,
          @i_tipo = 'I'
        if @w_return <> 0
          return @w_return
      end
      if @w_clave2 <> 0
      begin
        exec @w_return = cobis..sp_reentry
          @i_key  = @w_clave2,
          @i_tipo = 'I'
        if @w_return <> 0
          return @w_return
      end

      /* Modificaciones para BRANCHII RAN 03-MAR99 */
      if @t_ejec = 'R'
        select
          'results_submit_rpc',
          r_ssn_host = @s_ssn

      return 0
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
      exec @w_return = cob_ahorros..sp_tr_ndchqdevob_loc_rem_aho
        @s_ssn           = @s_ssn,
        @s_srv           = @s_srv,
        @s_lsrv          = @s_lsrv,
        @s_user          = @s_user,
        @s_sesn          = @s_sesn,
        @s_term          = @s_term,
        @s_date          = @s_date,
        @s_ofi           = @s_ofi,
        @s_rol           = @s_rol,
        @s_org_err       = @s_org_err,
        @s_error         = @s_error,
        @s_sev           = @s_sev,
        @s_msg           = @s_msg,
        @s_org           = @s_org,
        @t_corr          = @t_corr,
        @t_ssn_corr      = @t_ssn_corr,
        @t_debug         = @t_debug,
        @t_file          = @t_file,
        @t_from          = @t_from,
        @t_rty           = @t_rty,
        @t_trn           = @t_trn,
        @p_lssn          = @p_lssn,
        @p_rssn_corr     = @p_rssn_corr,
        @i_ctadb         = @i_ctadb,
        @i_producto      = @w_producto,
        @i_oficina       = @w_oficina,
        @i_bco           = @w_bco,
        @i_ofi           = @w_ofi,
        @i_par           = @w_par,
        @i_ctachq        = @i_ctachq,
        @i_nchq          = @i_nchq,
        @i_valch         = @i_val,
        @i_tipchq        = @i_tipchq,
        @i_dpto          = @i_dpto,
        @i_mon           = @i_mon,
        @i_cau           = @i_cau,
        @i_turno         = @i_turno,
        @i_filial        = @i_filial,
        @i_idcaja        = @i_idcaja,
        @i_idcierre      = @i_idcierre,
        @i_sld_caja      = @i_sld_caja,
        @i_canal         = @i_canal,
        @o_sldcont       = @w_sldcont out,
        @o_slddisp       = @w_slddisp out,
        @o_nombre        = @o_nombre out,
        @o_val_deb       = @w_val_deb out,
        @o_comision      = @w_comision out,
        @o_clave1        = @w_clave1 out,
        @o_clave2        = @w_clave2 out,
        @o_oficina_cta   = @w_oficina_cta out,
        @o_prod_banc     = @w_prod_banc out,
        @o_categoria     = @w_categoria out,
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
          i_touser = @s_user,
          p_val_deb = @w_val_deb,
          i_tosesion = @s_sesn
        exec cobis..sp_end_debug
      end

      exec @w_return = cobis..sp_begin_resubmit
        @i_toserver = @s_srv,
        @i_touser   = @s_user,
        @i_tosesion = @s_sesn

      select
        p_val_deb = @w_val_deb,
        p_sldcont = @w_sldcont,
        p_slddisp = @w_slddisp,
        p_nombre = @o_nombre,
        p_rssn = @s_ssn,
        p_rpta = 'S'
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
      return 1
    end
  end

  /*  Transaccion recibida de regional remoto  */
  if @s_org = 'R'
  begin
    begin tran
    /*  Transaccion monetaria */
    insert into cob_ahorros..ah_notcredeb
                (secuencial,ssn_branch,tipo_tran,oficina,usuario,
                 terminal,correccion,sec_correccion,reentry,origen,
                 /* nro_cheque,*/
                 nodo,fecha,cta_banco,signo,causa,
                 val_cheque,valor,remoto_ssn,moneda,saldocont,
                 saldodisp,departamento,banco,oficina_cta,interes,
                 prod_banc,categoria,tipocta_super,turno,hora,
                 canal)
    values      (@p_lssn,@s_ssn_branch,@t_trn,@s_ofi,@s_user,
                 @s_term,@t_corr,@t_ssn_corr,@t_rty,'L',/* @i_nchq,*/
                 @w_server_rem,@s_date,@i_ctadb,@w_signo,@i_cau,
                 @i_val,@p_val_deb,@p_rssn,@i_mon,@p_sldcont,
                 @p_slddisp,@i_dpto,@w_bco,@w_oficina_cta,@w_comision,
                 @w_prod_banc,@w_categoria,@w_tipocta_super,@i_turno,getdate(),
                 @i_canal)
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203000
      return 1
    end
    /* Actualizacion de totales de cajero */
    exec @w_return = cob_remesas..sp_upd_totales
      @i_ofi        = @s_ofi,
      @i_rol        = @i_turno,
      @i_user       = @s_user,
      @i_mon        = @i_mon,
      @i_trn        = @t_trn,
      @i_nodo       = @s_srv,
      @i_tipo       = 'L',
      @i_corr       = @t_corr,
      @i_efectivo   = @i_val,
      @i_ssn        = @s_ssn,
      @i_filial     = @i_filial,
      @i_idcaja     = @i_idcaja,
      @i_idcierre   = @i_idcierre,
      @i_saldo_caja = @i_sld_caja,
      @i_cta_banco  = @i_ctadb
    if @w_return = 0
    begin
      /*  Actualizacion de totales de servidor enviado (remoto) */
      exec @w_return = cob_remesas..sp_upd_totales
        @i_ofi        = @w_oficina,
        @i_rol        = @i_turno,
        @i_user       = @s_srv,
        @i_mon        = @i_mon,
        @i_trn        = @t_trn,
        @i_nodo       = @w_server_rem,
        @i_tipo       = 'E',
        @i_corr       = @t_corr,
        @i_efectivo   = @i_val,
        @i_ssn        = @s_ssn,
        @i_filial     = @i_filial,
        @i_idcaja     = @i_idcaja,
        @i_idcierre   = @i_idcierre,
        @i_saldo_caja = @i_sld_caja,
        @i_cta_banco  = @i_ctadb
      if @w_return = 0
      begin
        commit tran
        if @w_clave1 <> 0
        begin
          exec @w_return = cobis..sp_reentry
            @i_key  = @w_clave1,
            @i_tipo = 'I'
          if @w_return <> 0
            return @w_return
        end
        if @w_clave2 <> 0
        begin
          exec @w_return = cobis..sp_reentry
            @i_key  = @w_clave2,
            @i_tipo = 'I'
          if @w_return <> 0
            return @w_return
        end
        return 0
      end
    end
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 255003 /* Error Actualizar Caja */
    return 1
  end

go

