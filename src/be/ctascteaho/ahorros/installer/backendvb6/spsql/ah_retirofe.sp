/************************************************************************/
/*      Archivo:            ah_retirofe.sp                              */
/*      Stored procedure:   sp_ah_retirofe                              */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:       Julio Navarrete/Javier Bucheli              */
/*      Fecha de escritura: 10-Feb-1993                                 */
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
/*      Este programa procesa la transaccion de Nota de Debito con      */
/*      FECHA EFECTIVA                                                  */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA           AUTOR                RAZON                          */
/*  25/Feb/1993     X Gellibert Coello   Emision Inicial                */
/*  02/May/2016     Ignacio Yupa         Migración a CEN                */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_retirofe')
  drop proc sp_ah_retirofe
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_retirofe
(
  @s_ssn           int,
  @s_ssn_branch    int,
  @s_lsrv          varchar(30),
  @s_srv           varchar(30),
  @s_user          varchar(30),
  @s_sesn          int=null,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint,
  @s_org_err       char(1) = null,/* Origen de ERROR: [A], [S] */
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @s_org           char(1),
  @t_user          varchar(30) = null,/* SAIP */
  @t_term          varchar(30) = null,/* SAIP */
  @t_srv           varchar(30) = null,/* SAIP */
  @t_ofi           smallint = null,/* SAIP */
  @t_rol           smallint = null,/* SAIP */
  @t_corr          char(1) = 'N',
  @t_ssn_corr      int = null,/* Trans a ser reversada */
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_ejec          char(1) = null,
  @t_trn           smallint,
  @t_show_version  bit = 0,
  @p_lssn          int = null,
  @p_rssn          int = null,
  @p_rssn_corr     int = null,
  @p_envio         char(1) = 'N',
  @p_rpta          char(1) = 'N',
  @p_sldcont       money = null,
  @p_slddisp       money = null,
  @p_aj_cap        money = null,
  @p_aj_int        money = null,
  @p_aj_ret        money = null,
  @p_nombre        varchar(60) = null,
  @p_cedula        varchar(20) = null,
  @p_fecha         datetime = null,
  @p_ofi_cta       smallint = null,
  @r_comision      money = null,
  @r_iva           money = null,
  @r_gmf           money = null,
  @i_mon           tinyint,
  @i_cta           cuenta,
  @i_cau           char(3) = null,
  @i_dep           smallint = null,
  @i_val           money,
  @i_fecha_efec    datetime,
  @i_ind           tinyint = 1,
  @i_sld_caja      money = 0,--RAN: migracion COBIS Explorer
  @i_idcaja        int = 0,--RAN: migracion COBIS Explorer
  @i_idcierre      int = 0,--RAN: migracion COBIS Explorer  
  @i_fecha_valor_a datetime = null,--RAN: migracion COBIS Explorer  
  @i_filial        tinyint = 0,--RAN: migracion COBIS Explorer  
  @i_canal         tinyint = 4,--4 CAJAS    
  @o_nombre        varchar(60) = null out,
  @o_fecha         datetime = null out,
  @o_sldcont       money = null out,
  @o_hora          char(8) = null out,
  @o_prod_banc     smallint = null out,--MVE AH00007 lo pide el s_org S
  @o_categoria     char(1) = null out,
  @o_tipocta_super char(1) = null out,
  @o_cedula        varchar(30) = null out,
  @o_alerta_cli    varchar(40) = null out,
  @o_alerta        char(1) = null out,
  @o_val_nx1000    money = null out,
  @o_valiva        money = null out
)
as
  declare
    @w_return        int,
    @w_sp_name       varchar(30),
    @w_nombre        varchar(60),
    @w_cedula        varchar(20),
    @w_filial        tinyint,
    @w_oficina       smallint,
    @w_producto      tinyint,
    @w_server_rem    descripcion,
    @w_server_local  descripcion,
    @w_oficial       smallint,-- ARV FEB/12/2001
    @w_tipo          char(1),
    @w_rssn_corr     int,
    @w_factor        int,
    @w_valor         money,
    @w_sldcont       money,
    @w_slddisp       money,
    @w_aj_cap        float,
    @w_aj_int        float,
    @w_aj_ret        float,
    @w_signo         char(1),
    @w_efe           money,
    @w_fecha         datetime,
    @w_ofi_cta       smallint,
    /* II EAA 06/Abr/2001  AH000294 */
    @w_fecha_hoy     smalldatetime,
    @w_fecha_fid     smalldatetime,
    @w_hora_hoy      smallint,
    @w_hora_fid      smallint,
    @w_minuto_hoy    smallint,
    @w_minuto_fid    smallint,
    @w_hora          char(5),
    @w_prod_banc     smallint,
    @w_prod_fid      smallint,
    @w_categoria     char(1),--MVE AH00007 lo pide el s_org S
    @w_tipocta_super char(1),
    @w_clase_clte    char(1),
    @w_cliente       int,
    @w_base_gmf      money

/* FI EAA 06/Abr/2001  AH000294 */
  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_retirofe'
  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Inicia SAIP  */
  if @t_user is not null
  begin
    select
      @s_user = @t_user,
      @s_term = @t_term,
      @s_srv = @t_srv,
      @s_ofi = @t_ofi,
      @s_rol = @t_rol
  end
/*  Finaliza SAIP  */
  /* Chequeo de errores generados remotamente */
  if @s_org_err is not null /*  Error del Sistema  */
  begin
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = @s_error,
      @i_sev  = @s_sev,
      @i_msg  = @s_msg
    return @s_error
  end

  if @s_org = 'U'
  begin
    exec @w_return = cob_remesas..sp_verifica_caja
      @t_trn    = @t_trn,
      @s_user   = @s_user,
      @s_ofi    = @s_ofi,
      @s_srv    = @s_srv,
      @s_date   = @s_date,
      @i_filial = @i_filial,
      @i_ofi    = @s_ofi,
      @i_mon    = @i_mon,
      @i_idcaja = @i_idcaja

    if @w_return <> 0
      return @w_return

    if exists (select
                 1
               from   cob_remesas..re_caja
               where  cj_oficina     = @s_ofi
                  and cj_rol         = @s_rol
                  and cj_operador    = @s_user
                  and cj_moneda      = @i_mon
                  and cj_transaccion = 346
                  and cj_filial      = @i_filial
                  and cj_id_cierre   = @i_idcierre
                  and cj_id_caja     = @i_idcaja)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201248
      return 201248
    end
  end

  /* Valida de la Transaccion */
  if @t_trn = 316
     and @i_ind not in (1)
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251022
    return 251022
  end

  /*  Captura de parametros de la oficina  */
  exec @w_return = cobis..sp_parametros
    @t_from         = @w_sp_name,
    @s_lsrv         = @s_lsrv,
    @i_nom_producto = 'CUENTA%AHORRO%',
    @o_filial       = @w_filial out,
    @o_oficina      = @w_oficina out,
    @o_producto     = @w_producto out
  if @w_return <> 0
    return @w_return

  /*  Determinacion de condicion de local o remoto  */
  exec @w_return = cob_ahorros..sp_cta_origen
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
      @w_signo = 'D'
  else
    select
      @w_factor = -1,
      @w_signo = 'C'

  /*  Transaccion generada por usuario  */
  if @s_org = 'U'
  begin
    /* Transaccion local */
    if @w_tipo = 'L'
    begin
      exec @w_return = cob_ahorros..sp_ah_retnd_locrem_fe
        @s_ssn           = @s_ssn,
        @s_ssn_branch    = @s_ssn_branch,
        @s_lsrv          = @s_lsrv,
        @s_srv           = @s_srv,
        @s_user          = @s_user,
        @s_sesn          = @s_sesn,
        @s_term          = @s_term,
        @s_date          = @s_date,
        @s_ofi           = @s_ofi,
        @s_rol           = @s_rol,
        @s_sev           = @s_sev,
        @t_corr          = @t_corr,
        @t_ssn_corr      = @t_ssn_corr,
        @t_debug         = @t_debug,
        @t_from          = @w_sp_name,
        @t_file          = @t_file,
        @t_rty           = @t_rty,
        @t_ejec          = @t_ejec,
        @t_trn           = @t_trn,
        @p_rssn_corr     = @p_rssn_corr,
        @s_org           = @s_org,
        @i_cta           = @i_cta,
        @i_mon           = @i_mon,
        @i_val           = @i_val,
        @i_ind           = @i_ind,
        @i_cau           = @i_cau,
        @i_dep           = @i_dep,
        @i_fec_efe       = @i_fecha_efec,
        @i_oficina       = @w_oficina,
        @i_sld_caja      = @i_sld_caja,
        @i_idcaja        = @i_idcaja,
        @i_idcierre      = @i_idcierre,
        @i_fecha_valor_a = @i_fecha_valor_a,
        @i_filial        = @i_filial,
        @i_canal         = @i_canal,
        @o_sldcont       = @w_sldcont out,
        @o_slddisp       = @w_slddisp out,
        @o_aj_cap        = @w_aj_cap out,
        @o_aj_int        = @w_aj_int out,
        @o_aj_ret        = @w_aj_ret out,
        @o_nombre        = @w_nombre out,
        @o_cedula        = @w_cedula out,
        @o_fecha         = @w_fecha out,
        @o_ofi_cta       = @w_ofi_cta out,
        @o_oficial       = @w_oficial out,
        @o_prod_banc     = @w_prod_banc out,
        @o_categoria     = @w_categoria out,
        @o_tipocta_super = @w_tipocta_super out,
        @o_clase_clte    = @w_clase_clte out,
        @o_cliente       = @w_cliente,
        @o_val_nx1000    = @o_val_nx1000 out,
        @o_valiva        = @o_valiva out,
        @o_base_gmf      = @w_base_gmf out

      select
        @o_nombre = @w_nombre,
        @o_cedula = @w_cedula
      select
        'rssn' = @s_ssn

      if @t_ejec = 'R'
      begin
        exec cob_remesas..sp_resultados_branch_caja
          @i_sldcaja  = @i_sld_caja,
          @i_idcierre = @i_idcierre,
          @i_ssn_host = @s_ssn

        select
          'results_submit_rpc',
          r_cedula = @o_cedula,
          r_nombre = @o_nombre

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
      /* Localizar ssn de la transaccion remota en modo de corr */
      if @w_factor = -1
      begin
        if exists (select
                     1
                   from   ah_tran_monet
                   where  tm_secuencial = @t_ssn_corr)
          select
            @w_rssn_corr = (select
                              tm_remoto_ssn
                            from   ah_tran_monet
                            where  tm_secuencial = @t_ssn_corr)
        else
          select
            @w_rssn_corr = (select
                              remoto_ssn
                            from   ah_tsval_suspenso
                            where  secuencial = @t_ssn_corr)
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
      exec @w_return = cob_ahorros..sp_ah_retnd_locrem_fe
        @s_ssn           = @s_ssn,
        @s_ssn_branch    = @s_ssn_branch,
        @s_lsrv          = @s_lsrv,
        @s_srv           = @s_srv,
        @s_user          = @s_user,
        @s_sesn          = @s_sesn,
        @s_term          = @s_term,
        @s_date          = @s_date,
        @s_ofi           = @s_ofi,
        @s_rol           = @s_rol,
        @s_sev           = @s_sev,
        @t_corr          = @t_corr,
        @t_ssn_corr      = @t_ssn_corr,
        @t_debug         = @t_debug,
        @t_from          = @t_from,
        @t_file          = @t_file,
        @t_rty           = @t_rty,
        @t_ejec          = @t_ejec,
        @t_trn           = @t_trn,
        @p_lssn          = @p_lssn,
        @p_rssn          = @p_rssn,
        @p_rssn_corr     = @p_rssn_corr,
        @s_org           = @s_org,
        @i_cta           = @i_cta,
        @i_mon           = @i_mon,
        @i_val           = @i_val,
        @i_ind           = @i_ind,
        @i_cau           = @i_cau,
        @i_dep           = @i_dep,
        @i_fec_efe       = @i_fecha_efec,
        @i_oficina       = @w_oficina,
        @i_canal         = @i_canal,
        @o_aj_cap        = @w_aj_cap out,
        @o_aj_int        = @w_aj_int out,
        @o_aj_ret        = @w_aj_ret out,
        @o_sldcont       = @w_sldcont out,
        @o_slddisp       = @w_slddisp out,
        @o_nombre        = @w_nombre out,
        @o_cedula        = @w_cedula out,
        @o_fecha         = @w_fecha out,
        @o_ofi_cta       = @w_ofi_cta out,
        @o_oficial       = @w_oficial out,
        @o_prod_banc     = @w_prod_banc out,
        @o_categoria     = @w_categoria out,
        @o_tipocta_super = @w_tipocta_super out,
        @o_clase_clte    = @w_clase_clte out,
        @o_cliente       = @w_cliente,
        @o_val_nx1000    = @o_val_nx1000 out,
        @o_valiva        = @o_valiva out,
        @o_base_gmf      = @w_base_gmf out

      if @w_return <> 0
        return @w_return

      /* Envio de Resultados  */
      if @t_debug = 'S'
      begin
        exec cobis..sp_begin_debug
          @t_file=@t_file
        select
          '/**  Stored Procedure  **/ ' = @w_sp_name,
          'Inicio resubmit server=' = @s_srv,
          i_touser = @s_user,
          i_tosesion = @s_sesn
        exec cobis..sp_end_debug
      end
      exec @w_return = cobis..sp_begin_resubmit
        @i_toserver = @s_srv,
        @i_touser   = @s_user,
        @i_tosesion = @s_sesn

      select
        @p_aj_cap = @w_aj_cap,
        @p_aj_int = @w_aj_int,
        @p_aj_ret = @w_aj_ret,
        @p_nombre = @w_nombre,
        @p_cedula = @w_cedula,
        @p_sldcont = @w_sldcont,
        @p_slddisp = @w_slddisp,
        @p_fecha = @w_fecha,
        @p_ofi_cta = @w_ofi_cta
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
    @w_efe = 0

  /*  Transaccion recibida de regional remoto  */
  select
    @w_valor = @i_val + @p_aj_cap
  if @s_org = 'R'
  begin
    begin tran
    /******  Transaccion Monetaria  ******/
    insert into cob_ahorros..ah_tran_monet
                (tm_secuencial,tm_tipo_tran,tm_oficina,tm_usuario,tm_terminal,
                 tm_correccion,tm_sec_correccion,tm_reentry,tm_origen,tm_nodo,
                 tm_fecha,tm_cta_banco,tm_valor,tm_indicador,tm_causa,
                 tm_remoto_ssn,tm_moneda,tm_signo,tm_saldo_contable,
                 tm_saldo_disponible,
                 tm_departamento,tm_saldo_interes,tm_interes,tm_oficial,tm_canal
                 ,
                 tm_prod_banc,tm_categoria,tm_tipocta_super,
                 tm_ssn_branch,
                 tm_cliente
                 ,
                 tm_base_gmf,tm_clase_clte)
    values      (@p_lssn,@t_trn,@s_ofi,@s_user,@s_term,
                 @t_corr,@t_ssn_corr,@t_rty,'L',@w_server_rem,
                 @s_date,@i_cta,@i_val,@i_ind,@i_cau,
                 @p_rssn,@i_mon,@w_signo,@p_sldcont,@p_slddisp,
                 @i_dep,@p_aj_int,@p_aj_cap,@w_oficial,4,
                 @w_prod_banc,@w_categoria,@w_tipocta_super,@s_ssn_branch,
                 @w_cliente
                 ,
                 @w_base_gmf,@w_clase_clte)
    if @@error <> 0
    begin /** Error al Insertar Transaccion Monetaria **/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253000
      return 253000
    end

    if @t_trn = 316
    begin
      /* Actualizacion de totales de cajero */
      exec @w_return = cob_remesas..sp_upd_totales
        @i_ofi      = @s_ofi,
        @i_rol      = @s_rol,
        @i_user     = @s_user,
        @i_mon      = @i_mon,
        @i_trn      = @t_trn,
        @i_nodo     = @s_srv,
        @i_tipo     = 'L',
        @i_corr     = @t_corr,
        @i_efectivo = @i_val,
        @i_adj_int  = @p_aj_int,
        @i_adj_cap  = @p_aj_cap,
        @i_ofi_cta  = @w_ofi_cta,
        @i_cau      = @i_cau
      if @w_return = 0
      begin
        /*  Actualizacion de totales de servidor enviado (remoto) */
        exec @w_return = cob_remesas..sp_upd_totales
          @i_ofi      = @s_ofi,
          @i_rol      = @s_rol,
          @i_user     = @s_user,
          @i_mon      = @i_mon,
          @i_trn      = @t_trn,
          @i_nodo     = @w_server_rem,
          @i_tipo     = 'E',
          @i_corr     = @t_corr,
          @i_efectivo = @i_val,
          @i_adj_int  = @p_aj_int,
          @i_adj_cap  = @p_aj_cap,
          @i_ofi_cta  = @w_ofi_cta,
          @i_cau      = @i_cau
        if @w_return = 0
        begin
          commit tran
          select
            @o_nombre = @p_nombre,
            @o_cedula = @p_cedula,
            @o_fecha = @p_fecha,
            @o_sldcont = @p_sldcont
          return 0
        end
      end
    end
  end

  return 0

go

