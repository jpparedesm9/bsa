/*************************************************************************/
/*  Archivo:            ah_cierre.sp                                     */
/*  Stored procedure:   sp_ah_cierre                                     */
/*  Base de datos:      cob_ahorros                                      */
/*  Producto:           Cuentas de Ahorros                               */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                      */
/*  Fecha de escritura: 07-Jun-1994                                      */
/*************************************************************************/
/*              IMPORTANTE                                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de COBISCorp.                                                        */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/*************************************************************************/
/*              PROPOSITO                                                */
/*  Este programa procesa la transaccion de cierre de cuentas de         */
/*  ahorros                                                              */
/*************************************************************************/
/*              MODIFICACIONES                                           */
/*  FECHA       AUTOR          RAZON                                     */
/*  07/Jun/1994 J Navarrete    Emision inicial                           */
/*  21/Nov/1998 A Machado      Adicion del parametro @o_ssn              */
/*  24/Feb/1999 M. Sanguino    Cambiar validacion sobre cc_caja          */
/*  2004/03/10  Carlos Cruz D. Se aumenta la variable @i_minuta          */
/*  12/12/2006  R.Linares      Se Agrego Campo @i_val_inac               */
/*  19/MAR/2007 P. Coello      ENVIO DE PARAMETRO PARA INCIDAR           */
/*                             SI SE COBRA O NO LA MULTA POR CIE         */
/*                             RRE ANTICIPADO                            */
/*  24/Mar/2010 C. Munoz       Se agrega codigo beneficiario Bancamia 016*/
/*  02/May/2016 I. Yupa        Migración a CEN                           */
/*************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_cierre')
  drop proc sp_ah_cierre
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_cierre
(
  @s_ssn             int,
  @s_srv             varchar(30),
  @s_lsrv            varchar(30),
  @s_user            varchar(30),
  @s_sesn            int=null,
  @s_term            varchar(10),
  @s_date            datetime,
  @s_ofi             smallint,/* Localidad origen transaccion */
  @s_rol             smallint,
  @s_org_err         char(1) = null,/* Origen de ERROR: [A], [S] */
  @s_error           int = null,
  @s_sev             tinyint = null,
  @s_msg             mensaje = null,
  @s_org             char(1),
  @s_ssn_branch      int = null,  
  @t_ejec            char(1) = null,
  @t_corr            char(1) = 'N',
  @t_ssn_corr        int = null,/* Trans a ser reversada */
  @t_debug           char(1) = 'N',
  @t_file            varchar(14) = null,
  @t_from            varchar(32) = null,
  @t_rty             char(1) = 'N',
  @t_trn             smallint,
  @t_show_version    bit = 0,
  @p_sldcont         money = null,
  @p_slddisp         money = null,
  @p_sldint          money = null,
  @p_lssn            int = null,
  @p_rssn            int = null,
  @p_rssn_corr       int = null,
  @p_control         int = null,
  @p_nom             varchar(30) = null,
  @p_int_cap         money = null,
  @p_impuesto        money = null,
  @p_multa           money = null,
  @i_cta             cuenta,
  @i_val             money,
  @i_sldlib          money,
  @i_nctrl           smallint,
  @i_cau             varchar(3),
  @i_ord             char(1) = 'M',
  @i_aut             login,
  @i_mon             tinyint,
  @i_monto_maximo    char(1),
  @i_turno           smallint = null,
  @i_sld_caja        money = 0,
  @i_idcierre        int = 0,
  @i_filial          smallint = 1,
  @i_idcaja          int = 0,
  @i_ctatrn          cuenta = null,-- Nro de cuenta para la transf de cierre
  @i_producto        varchar(3) = null,
  -- Tipo de cuenta para la transf de cierre
  @i_tadmin          tinyint = 0,
  -- Diferencia el cierre desde caja o term adminis
  @i_fcancel         char(1) = null,
  -- Forma de cancelaci贸n T=transferencia C=cheque
  @i_cobra           tinyint = 0,-- lgr
  @i_ape1            varchar(30) = null,-- Primer apellido del Gestor
  @i_ape2            varchar(30) = null,-- Segundo apellido del Gestor
  @i_nom1            varchar(30) = null,-- Primer nombre del Gestor
  @i_nom2            varchar(30) = null,-- Segundo nombre del Gestor
  @i_tipoid          varchar(3) = null,-- Tipo de Identificaci贸n del Gestor
  @i_numeroid        varchar(20) = null,-- Numero de identificaci贸n del Gestor
  @i_direccion       varchar(80) = null,-- Direccion del Gestor 
  @i_nacionalidad    varchar(10) = null,-- C贸digo del Pa铆s del Gestor
  @i_trnb            int = null,-- C贸digo de la transacci贸n Branch
  @i_gestor          char(1) = null,
  -- Bandera que indica si el gestor fue encontrado o no cuando el cajero realiz贸 

  -- la b煤squeda mediante en n煤mero de identificaci贸n. 
  @i_cod_gestor      int = null,-- Codigo del Gestor
  @i_minuta          varchar(30) = null,-- Numero de la minuta
  @i_observacion     varchar(120)= null,
  @i_observacion1    varchar(120)= null,
  @i_val_inac        char(1) = 'S',
  -- PARA VALIDAR O NO LA INACTIVIDAD ROL 12122006
  @i_cobra_multa_ant char(1) = 'S',
  --  PCO COBRAR MULTA POR CIERRE ANTICIPADO O NO
  @i_canal           smallint = 4,
  @i_ejec_marca      char(1) = 'S',
  -- Parametro para saber si ejecuta o no el llamado desmarcacion GMF 
  @i_codbene         int = null,
  @i_gmf_reintegro   money = 0,
  @o_multa           money = null out,
  @o_ssn             int = null out,
  @o_nombre          varchar(30) = null out,
  @o_valir           money = null out
)
as
  declare
    @w_return               int,
    @w_sp_name              varchar(30),
    @w_cuenta               int,
    @w_filial               tinyint,
    @w_oficina              smallint,
    @w_filial_p             tinyint,
    @w_oficina_p            smallint,
    @w_producto             tinyint,
    @w_control              int,
    @w_sldcont              money,
    @w_slddisp              money,
    @w_sldint               money,
    @w_interes              money,
    @w_int_cap              money,
    @w_impuesto             money,
    @w_multa                money,
    @w_lineas               tinyint,
    @w_rssn_corr            int,
    @w_nombre               varchar(30),
    @w_server_rem           descripcion,
    @w_server_local         descripcion,
    @w_tipo                 char(1),
    @w_factor               int,
    @w_signo                char(1),
    @w_prod_banc            smallint,
    @w_categoria            char(1),
    @w_monto_imp_ret        money,
    @w_tipo_exoneracion_imp char(2),
    @w_monto_maximo_deb     money,
    @w_tipocta_super        char(1),
    @w_clase_clte           char(1),
    @w_mombre               char(64),
    @w_cliente              int,
    @w_num_id               char(15),
    @w_siguiente            int,
    @w_gmf_valcie           money

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_cierre'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @o_ssn = @s_ssn
  select
    @s_ssn_branch = isnull(@s_ssn_branch,
                           @s_ssn)

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
      p_sldcont = @p_sldcont,
      p_lssn = @p_lssn,
      p_rssn = @p_rssn,
      p_rssn_corr = @p_rssn_corr,
      p_control = @p_control,
      p_int_cap = @p_int_cap,
      i_cta_banco = @i_cta,
      i_val = @i_val,
      i_saldo_libreta = @i_sldlib,
      i_nro_control = @i_nctrl,
      i_causa = @i_cau,
      i_orden = @i_ord,
      i_aut = @i_aut,
      i_moneda = @i_mon
    exec cobis..sp_end_debug
  end

  select
    @i_monto_maximo = 'N' --lgra
  /* Validacion de Retiros */
  if @i_monto_maximo = 'S'
     and @t_corr = 'N'
  begin
    select
      @w_monto_maximo_deb = pa_money
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'MMS' + convert (varchar(3), @i_mon)

    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201196
      return 201196
    end
    if @i_val > @w_monto_maximo_deb
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201208
      return 201208
    end
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

  /* Valida si se ha aperturado caja */
  if @s_org = 'U'
     and @i_tadmin = 0
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

  /*  Captura de parametros de la oficina  */
  exec @w_return = cobis..sp_parametros
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @w_sp_name,
    @s_lsrv         = @s_lsrv,
    @i_nom_producto = 'CUENTA DE AHORROS',
    --@o_filial       = @w_filial out, 
    @o_oficina      = @w_oficina out,
    @o_producto     = @w_producto out
  --@o_server_local = @w_server_local
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

  /* NO SE PERMITE REVERSO DEL CIERRE DE CUENTA  */
  if @t_corr <> 'N'
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201192
    return 201192
  end

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
      exec @w_return = cob_ahorros..sp_ah_cierre_loc_rem
        @s_ssn                  = @s_ssn,
        @s_srv                  = @s_srv,
        @s_lsrv                 = @s_lsrv,
        @s_user                 = @s_user,
        @s_sesn                 = @s_sesn,
        @s_term                 = @s_term,
        @s_date                 = @s_date,
        @s_ofi                  = @s_ofi,
        @s_rol                  = @s_rol,
        @s_org                  = @s_org,
        @s_ssn_branch           = @s_ssn_branch,
        @t_corr                 = @t_corr,
        @t_ssn_corr             = @t_ssn_corr,
        @t_debug                = @t_debug,
        @t_from                 = @w_sp_name,
        @t_file                 = @t_file,
        @t_rty                  = @t_rty,
        @t_trn                  = @t_trn,
        @t_ejec                 = @t_ejec,-- ELI 28/11/2002 
        @p_lssn                 = @p_lssn,
        @p_rssn_corr            = @p_rssn_corr,
        @i_cta                  = @i_cta,
        @i_val                  = @i_val,
        @i_sldlib               = @i_sldlib,
        @i_oficina              = @w_oficina,
        @i_nctrl                = @i_nctrl,
        @i_cau                  = @i_cau,
        @i_ord                  = @i_ord,
        @i_aut                  = @i_aut,
        @i_mon                  = @i_mon,
        @i_turno                = @i_turno,
        @i_filial               = @i_filial,
        @i_idcaja               = @i_idcaja,
        @i_idcierre             = @i_idcierre,
        @i_sld_caja             = @i_sld_caja,
        @i_ctatrn               = @i_ctatrn,
        @i_producto             = @i_producto,
        @i_tadmin               = @i_tadmin,
        @i_fcancel              = @i_fcancel,
        @i_cobra                = @i_cobra,
        @i_minuta               = @i_minuta,
        @i_observacion          = @i_observacion,
        @i_observacion1         = @i_observacion1,
        @i_val_inac             = @i_val_inac,-- ROL 12122006
        @i_cobra_multa_ant      = @i_cobra_multa_ant,--PCOELLO MARZO DEL 2007
        @i_canal                = @i_canal,
        @i_ejec_marca           = @i_ejec_marca,
        -- Parametro para saber si ejecuta o no el llamado desmarcacion GMF 
        @i_codbene              = @i_codbene,
        @i_gmf_reintegro        = @i_gmf_reintegro,
        @o_sldcont              = @w_sldcont out,
        @o_slddisp              = @w_slddisp out,
        @o_sldint               = @w_sldint out,
        @o_control              = @w_control out,
        @o_nombre               = @o_nombre out,
        @o_cliente              = @w_cliente out,
        @o_int_cap              = @w_int_cap out,
        @o_impuesto             = @w_impuesto out,
        @o_multa                = @w_multa out,
        @o_oficina_p            = @w_oficina_p out,
        @o_prod_banc            = @w_prod_banc out,
        @o_categoria            = @w_categoria out,
        @o_monto_imp_ret        = @w_monto_imp_ret out,
        @o_tipo_exoneracion_imp = @w_tipo_exoneracion_imp out,
        @o_tipocta_super        = @w_tipocta_super out,
        @o_clase_clte           = @w_clase_clte out,
        @o_valir                = @o_valir out,
        @o_gmf_valcie           = @w_gmf_valcie out
      if @w_return <> 0
        return @w_return
      select
        @o_multa = @w_multa

      if @t_ejec = 'R'
      begin -- ELI 28/11/2002
        /* Devolucion de s_ssn del Central para Branch II */
        select
          'results_submit_rpc',
          r_ssn_host = @s_ssn

        exec cob_remesas..sp_resultados_branch_caja
          @i_sldcaja  = @i_sld_caja,
          @i_idcierre = @i_idcierre,
          @i_ssn_host = @s_ssn

      end -- FIN ELI 28/11/2002
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
        if @t_trn = 251
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
      exec @w_return = cob_ahorros..sp_ah_cierre_loc_rem
        @s_ssn                  = @s_ssn,
        @s_srv                  = @s_srv,
        @s_lsrv                 = @s_lsrv,
        @s_user                 = @s_user,
        @s_sesn                 = @s_sesn,
        @s_term                 = @s_term,
        @s_date                 = @s_date,
        @s_ofi                  = @s_ofi,
        @s_rol                  = @s_rol,
        @s_ssn_branch           = @s_ssn_branch,
        @t_corr                 = @t_corr,
        @t_ssn_corr             = @t_ssn_corr,
        @t_debug                = @t_debug,
        @t_from                 = @t_from,
        @t_file                 = @t_file,
        @t_rty                  = @t_rty,
        @t_trn                  = @t_trn,
        @p_lssn                 = @p_lssn,
        @p_rssn_corr            = @p_rssn_corr,
        @s_org                  = @s_org,
        @i_cta                  = @i_cta,
        @i_val                  = @i_val,
        @i_sldlib               = @i_sldlib,
        @i_oficina              = @w_oficina,
        @i_nctrl                = @i_nctrl,
        @i_aut                  = @i_aut,
        @i_cau                  = @i_cau,
        @i_ord                  = @i_ord,
        @i_mon                  = @i_mon,
        @i_filial               = @i_filial,
        @i_idcaja               = @i_idcaja,
        @i_idcierre             = @i_idcierre,
        @i_sld_caja             = @i_sld_caja,
        @i_ctatrn               = @i_ctatrn,
        @i_producto             = @i_producto,
        @i_tadmin               = @i_tadmin,
        @i_fcancel              = @i_fcancel,
        @i_minuta               = @i_minuta,
        @i_observacion          = @i_observacion,
        @i_observacion1         = @i_observacion1,
        @i_cobra_multa_ant      = @i_cobra_multa_ant,--PCOELLO MARZO DEL 2007
        @i_canal                = @i_canal,
        @i_ejec_marca           = @i_ejec_marca,
        -- Parametro para saber si ejecuta o no el llamado desmarcacion GMF 
        @i_gmf_reintegro        = @i_gmf_reintegro,
        @o_sldcont              = @w_sldcont out,
        @o_slddisp              = @w_slddisp out,
        @o_sldint               = @w_sldint out,
        @o_control              = @w_control out,
        @o_nombre               = @w_nombre out,
        @o_cliente              = @w_cliente out,
        @o_int_cap              = @w_int_cap out,
        @o_impuesto             = @w_impuesto out,
        @o_multa                = @w_multa out,
        @o_oficina_p            = @w_oficina_p out,
        @o_prod_banc            = @w_prod_banc out,
        @o_categoria            = @w_categoria out,
        @o_monto_imp_ret        = @w_monto_imp_ret out,
        @o_tipo_exoneracion_imp = @w_tipo_exoneracion_imp out,
        @o_tipocta_super        = @w_tipocta_super out,
        @o_clase_clte           = @w_clase_clte out,
        @o_valir                = @o_valir out,
        @o_gmf_valcie           = @w_gmf_valcie out
      if @w_return <> 0
        return @w_return
      select
        @o_multa = @w_multa
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
          p_control = @w_control,
          p_impuesto = @w_impuesto,
          p_multa = @w_multa
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
        p_sldint = @w_sldint,
        p_control = @w_control,
        p_int_cap = @w_int_cap,
        p_impuesto = @w_impuesto,
        p_multa = @w_multa,
        p_nom = @w_nombre,
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

  /*  Transaccion recibida de regional remoto  */
  if @s_org = 'R'
  begin
    begin tran
    /*  Transaccion monetaria  */
    insert into cob_ahorros..ah_cierre
                (secuencial,tipo_tran,oficina,usuario,terminal,
                 correccion,sec_correccion,reentry,origen,nodo,
                 fecha,cta_banco,ret_efe,ret_chq,remoto_ssn,
                 moneda,saldo_lib,control,signo,saldocont,
                 saldodisp,saldoint,impuesto,oficina_cta,prod_banc,
                 categoria,monto_imp,tipo_exoneracion,ssn_branch,tipocta_super,
                 turno,serial,hora,canal,cliente,
                 base_gmf,clase_clte,causa)
    values      ( @p_lssn,@t_trn,@s_ofi,@s_user,@s_term,
                  @t_corr,@t_ssn_corr,@t_rty,'L',@w_server_rem,
                  @s_date,@i_cta,@i_val,null,@p_rssn,
                  @i_mon,@i_sldlib,@p_control,@w_signo,@p_sldcont,
                  @p_slddisp,@p_sldint,@p_impuesto,@w_oficina_p,@w_prod_banc,
                  @w_categoria,@w_monto_imp_ret,@w_tipo_exoneracion_imp,
                  @s_ssn_branch,@w_tipocta_super,
                  @i_turno,@i_minuta,getdate(),@i_canal,@w_cliente,
                  @w_gmf_valcie,@w_clase_clte,@i_cau)
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 255004
      return 255004
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
      @i_cta_banco  = @i_cta,
      @i_cau        = @i_cau --EES    
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
        @i_cta_banco  = @i_cta,
        @i_cau        = @i_cau
      if @w_return = 0
      begin
        commit tran
        select
          'nro control' = @p_control,
          'Nombre' = @p_nom
        select
          'interes' = @p_int_cap,
          'impuesto' = @p_impuesto,
          'multa' = @p_multa
        return 0
      end
    end
  end

go

