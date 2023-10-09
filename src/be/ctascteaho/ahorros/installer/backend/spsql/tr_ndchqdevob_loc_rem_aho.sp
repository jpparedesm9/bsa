use cob_ahorros
go

/************************************************************************/
/*  Archivo:            tr_ndchqdevob_loc_rem_aho.sp                    */
/*  Stored procedure:   sp_tr_ndchqdevob_loc_rem_aho                    */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:       Cuentas de Ahorros                                  */
/*  Disenado por:       Juan Carlos Gordillo                            */
/*  Fecha de escritura:     20-Mar-2000                                 */
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
/*  Este programa procesa la transaccion de nota de debito por          */
/*  cheque devuelto en ahorros.(Principal)                              */
/*  313 = Nota de debito por cheque devuelto en ahorros.                */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  20/Mar/2000 J.C. Gordillo   Emision inicial                         */
/*      02/Mayo/2016    Walther Toledo  Migración a CEN                 */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_ndchqdevob_loc_rem_aho')
  drop proc sp_tr_ndchqdevob_loc_rem_aho
go

create proc sp_tr_ndchqdevob_loc_rem_aho
(
  @s_ssn           int,
  @s_ssn_branch    int = null,-- BRANCHII
  @s_srv           varchar(30),
  @s_lsrv          varchar(30),
  @s_user          varchar(30),
  @s_sesn          int=null,
  @s_term          varchar(10),
  @s_date          smalldatetime,
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint,
  @s_org_err       char(1) = null,/* Origen de ERROR: [A], [S] */
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @s_org           char(1),
  @t_corr          char(1) = 'N',
  @t_ssn_corr      int = null,/* Trans a ser reversada */
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           int,
  @t_ejec          char(1) = null,-- Cambios BRANCHII
  @t_show_version  bit = 0,
  @p_lssn          int = null,
  @p_rssn_corr     int = null,
  @i_ctadb         cuenta,
  @i_producto      tinyint,
  @i_oficina       smallint,
  @i_bco           smallint,
  @i_ofi           smallint,
  @i_par           int,
  @i_ctachq        cuenta,
  @i_nchq          int,
  @i_valch         money,
  @i_tipchq        varchar(1),
  @i_dpto          tinyint = 1,
  @i_mon           tinyint,
  @i_cau           varchar(3),
  @i_turno         smallint = null,
  @i_sld_caja      money = 0,
  @i_idcierre      int = 0,
  @i_filial        smallint = 1,
  @i_idcaja        int = 0,
  @i_canal         smallint = 4,
  @o_sldcont       money out,
  @o_slddisp       money out,
  @o_nombre        varchar(30) out,
  @o_comision      money out,
  @o_val_deb       money out,
  @o_clave1        int out,
  @o_clave2        int out,
  @o_oficina_cta   smallint out,
  @o_prod_banc     smallint = null out,
  @o_categoria     char(1) = null out,
  @o_tipocta_super char(1) = null out
)
as
  declare
    @w_return       int,
    @w_sp_name      varchar(30),
    @w_cuenta       int,
    @w_filial       tinyint,
    @w_oficina      smallint,
    @w_producto     tinyint,
    @w_val_mon      money,
    @w_server_local descripcion,
    @w_tipo         char(1),
    @w_signo        char(1),
    @w_val_deb      money,
    @w_sldcont      money,
    @w_slddisp      money,
    @w_nombre       varchar(30),
    @w_prod         varchar(30),
    @w_factor       int,
    @w_tip_prom     char(1),
    @w_estado       char(1),
    @w_bco          smallint

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_tr_ndchqdevob_loc_rem_aho'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

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
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_sev = @s_sev,
      s_ori = @s_org,
      t_corr = @t_corr,
      t_ssn_corr = @t_ssn_corr,
      t_from = @t_from,
      t_file = @t_file,
      t_rty = @t_rty,
      t_trn = @t_trn,
      p_lssn = @p_lssn,
      i_producto = @i_producto,
      i_ctadb = @i_ctadb,
      i_bco = @i_bco,
      i_ofi = @i_ofi,
      i_par = @i_par,
      i_ctachq = @i_ctachq,
      i_nchq = @i_nchq,
      i_valch = @i_valch,
      i_tipchq = @i_tipchq,
      i_dpto = @i_dpto,
      i_mon = @i_mon,
      i_cau = @i_cau
    exec cobis..sp_end_debug
  end

  /* Determinar el codigo de banco */
  select
    @w_bco = pa_smallint
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'CBCO'
  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
      @i_num = 201196
    return 1
  end

  if @i_bco = @w_bco
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201253
    return 1
  end

  /* Modo de correccion */
  if @t_corr = 'N'
    select
      @w_factor = 1,
      @w_signo = 'D'
  else
    select
      @w_factor = -1,
      @w_signo = 'C'

  /* Determinacion de vigencia de la cuenta  */
  exec @w_return = cob_ahorros..sp_ctah_vigente
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @w_sp_name,
    @i_cta_banco    = @i_ctadb,
    @i_moneda       = @i_mon,
    @o_filial       = @w_filial out,
    @o_oficina      = @w_oficina out,
    @o_cuenta       = @w_cuenta out,
    @o_tipo_promedio= @w_tip_prom out

  if @w_return <> 0
    return @w_return

  select
    @o_oficina_cta = @w_oficina

  /*  Nota de Debito por Cheque Devuelto  */
  begin tran
  if @w_factor = -1
  begin
    if not exists (select
                     1
                   from   cob_ahorros..ah_tran_monet
                   where  tm_ssn_branch   = @t_ssn_corr -- Branch II
                      and tm_cod_alterno  = 0
                      and tm_tipo_tran    = @t_trn
                      and tm_oficina      = @s_ofi -- Branch II
                      and tm_cta_banco    = @i_ctadb
                      and tm_banco        = @i_bco
                      and tm_efectivo     = @i_valch
                      and tm_departamento = @i_dpto
                      and tm_moneda       = @i_mon
                      and tm_causa        = @i_cau
                      and tm_usuario      = @s_user
                      and tm_estado is null)
    begin
      /* Error en actualizacion de registro en cc_tran_mo */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251067
      return 1
    end

    /* Valida la existencia del cheque devuelto */
    if not exists (select
                     1
                   from   cob_remesas..re_cheque_rec
                   where  cr_cta_depositada = @w_cuenta
                      and cr_fecha_ing      = @s_date
                      and cr_banco_p        = @i_bco
                      and cr_cta_girada     = @i_ctachq
                      and cr_num_cheque     = @i_nchq
                      and cr_valor          = @i_valch
                      and cr_status         = 'D'
                      and cr_cau_devolucion = @i_cau
                      and cr_producto       = @i_producto
                      and cr_moneda         = @i_mon
                      and cr_oficina        = @s_ofi
                      and cr_num_papeleta   = @t_ssn_corr)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201080
      return 1
    end
  end

  exec @w_return = cob_ahorros..sp_nd_chq_dev_aho_ot_bancos
    @t_debug         = @t_debug,
    @t_from          = @w_sp_name,
    @t_file          = @t_file,
    @t_trn           = @t_trn,
    @t_corr          = @t_corr,
    @p_lssn          = @p_lssn,
    @p_rssn_corr     = @p_rssn_corr,
    @t_rty           = @t_rty,
    @s_ssn           = @s_ssn,
    @s_ssn_branch    = @s_ssn_branch,-- BRANCHII
    @s_ofi           = @s_ofi,
    @s_srv           = @s_srv,
    @s_rol           = @s_rol,
    @s_lsrv          = @s_lsrv,
    @s_user          = @s_user,
    @s_term          = @s_term,
    @s_org           = @s_org,
    @s_date          = @s_date,-- BRANCHII
    @t_ssn_corr      = @t_ssn_corr,
    @i_producto      = @i_producto,
    @i_ctadb         = @i_ctadb,
    @i_cta_int       = @w_cuenta,
    @i_bco           = @i_bco,
    @i_ofi           = @i_ofi,
    @i_filial        = @w_filial,
    @i_par           = @i_par,
    @i_ctachq        = @i_ctachq,
    @i_nchq          = @i_nchq,
    @i_valch         = @i_valch,
    @i_tipchq        = @i_tipchq,
    @i_mon           = @i_mon,
    @i_cau           = @i_cau,
    @i_dpto          = @i_dpto,
    @i_factor        = @w_factor,
    @i_fecha         = @s_date,
    @i_filial        = @i_filial,
    @i_idcaja        = @i_idcaja,
    @i_idcierre      = @i_idcierre,
    @i_sld_caja      = @i_sld_caja,
    @o_sldcont       = @o_sldcont out,
    @o_slddisp       = @o_slddisp out,
    @o_nombre        = @o_nombre out,
    @o_val_deb       = @o_val_deb out,
    @o_comision      = @o_comision out,
    @o_clave1        = @o_clave1 out,
    @o_clave2        = @o_clave2 out,
    @o_prod_banc     = @o_prod_banc out,
    @o_categoria     = @o_categoria out,
    @o_tipocta_super = @o_tipocta_super out

  if @w_return <> 0
    return @w_return
  if @w_factor = -1
    select
      @w_estado = 'R'

  if @s_org = 'S'
  begin
    /* Actualizacion de Totales de cajero */
    exec @w_return = cob_remesas..sp_upd_totales
      @i_ofi        = @i_oficina,
      @i_rol        = @i_turno,
      @i_user       = @s_srv,
      @i_mon        = @i_mon,
      @i_trn        = @t_trn,
      @i_nodo       = @s_srv,
      @i_tipo       = 'R',
      @i_corr       = @t_corr,
      @i_efectivo   = @o_val_deb,
      @i_ssn        = @s_ssn,
      @i_filial     = @i_filial,
      @i_idcaja     = @i_idcaja,
      @i_idcierre   = @i_idcierre,
      @i_saldo_caja = @i_sld_caja,
      @i_cta_banco  = @i_ctadb
    if @w_return <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 205000
      return 1
    end

    /*  Transaccion monetaria */
    insert into cob_ahorros..ah_notcredeb
                (secuencial,ssn_branch,alterno,tipo_tran,oficina,
                 usuario,terminal,correccion,sec_correccion,reentry,
                 origen,nodo,fecha,cta_banco,signo,
                 causa,val_cheque,valor,remoto_ssn,moneda,
                 saldocont,concepto,saldodisp,departamento,banco,
                 oficina_cta,interes,estado,prod_banc,categoria,
                 tipocta_super,turno,ctabanco_dep,cheque,hora,
                 canal)
    values      (@s_ssn,@s_ssn_branch,0,@t_trn,@s_ofi,
                 @s_user,@s_term,@t_corr,@p_rssn_corr,@t_rty,
                 'R',@s_srv,@s_date,@i_ctadb,@w_signo,
                 @i_cau,@i_valch,@o_val_deb,@p_lssn,@i_mon,
                 @o_sldcont,convert(varchar(30), @i_nchq),@o_slddisp,@i_dpto,
                 @i_bco,
                 @w_oficina,@o_comision,@w_estado,@o_prod_banc,@o_categoria,
                 @o_tipocta_super,@i_turno,@i_ctachq,@i_nchq,getdate(),
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
  end
  else if @s_org = 'U'
  begin
    /* Actualizacion de Totales de cajero */
    exec @w_return = cob_remesas..sp_upd_totales
      @i_ofi        = @s_ofi,
      @i_rol        = @i_turno,
      @i_user       = @s_user,
      @i_mon        = @i_mon,
      @i_trn        = @t_trn,
      @i_nodo       = @s_srv,
      @i_tipo       = 'L',
      @i_corr       = @t_corr,
      @i_efectivo   = @o_val_deb,
      @i_ssn        = @s_ssn,
      @i_filial     = @i_filial,
      @i_cau        = @i_cau,
      @i_idcaja     = @i_idcaja,
      @i_idcierre   = @i_idcierre,
      @i_saldo_caja = @i_sld_caja,
      @i_cta_banco  = @i_ctadb
    if @w_return <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 205000
      return 1
    end

    if @o_val_deb > 0
    begin
      /*  Transaccion monetaria */
      if not exists (select
                       1
                     from   cob_ahorros..ah_tran_monet
                     -- Inicio Cambios BRANCHII
                     where  tm_ssn_branch  = @s_ssn_branch
                        and tm_oficina     = @s_ofi
                        and tm_cod_alterno = 0)
      -- Fin Cambios BRANCHII
      begin
        insert into cob_ahorros..ah_notcredeb
                    (secuencial,alterno,tipo_tran,oficina,usuario,
                     terminal,correccion,sec_correccion,reentry,origen,
                     nodo,fecha,cta_banco,signo,causa,
                     val_cheque,valor,remoto_ssn,moneda,saldocont,
                     concepto,saldodisp,departamento,banco,oficina_cta,
                     estado,prod_banc,categoria,ssn_branch,tipocta_super,
                     turno,ctabanco_dep,cheque,hora,canal) /* Branch II */
        values      (@s_ssn,0,@t_trn,@s_ofi,@s_user,
                     @s_term,@t_corr,@t_ssn_corr,@t_rty,'L',
                     @s_srv,@s_date,@i_ctadb,@w_signo,@i_cau,
                     @i_valch,@o_val_deb,@p_lssn,@i_mon,@o_sldcont,
                     convert(varchar(30), @i_nchq),@o_slddisp,@i_dpto,@i_bco,
                     @w_oficina,
                     @w_estado,@o_prod_banc,@o_categoria,@s_ssn_branch,
                     @o_tipocta_super,
                     @i_turno,@i_ctachq,@i_nchq,getdate(),@i_canal)
        /* Branch II */
        if @@error <> 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 203000
          return 1
        end
      end
      else
      begin
        exec cobis..sp_cerror /* Cambios BRANCHII */
          @t_from = @w_sp_name,/* Transaccion monetaria ya existe */
          @i_num  = 251079
        return 1
      end
    end
    select
      'Nombre' = @o_nombre
  end
  if @w_factor = -1
  begin
    /* Transaccion de devolucion de cheques */
    update cob_ahorros..ah_tran_monet
    set    tm_estado = @w_estado
    where  tm_ssn_branch   = @t_ssn_corr -- Branch II
       and tm_cod_alterno  = 0
       and tm_tipo_tran    = @t_trn
       and tm_oficina      = @s_ofi -- Branch II
       and tm_cta_banco    = @i_ctadb
       and tm_banco        = @i_bco
       and tm_efectivo     = @i_valch
       and tm_departamento = @i_dpto
       and tm_moneda       = @i_mon
       and tm_causa        = @i_cau
       and tm_usuario      = @s_user
       and tm_estado is null
    if @@rowcount <> 1
    begin
      /* Error en actualizacion de registro en cc_tran_mo */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251067
      return 1
    end
  end

  commit tran
  return 0

go

