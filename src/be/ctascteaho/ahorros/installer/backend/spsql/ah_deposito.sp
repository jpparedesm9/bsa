/************************************************************************/
/*  Archivo:            ah_deposito.sp                                  */
/*  Stored procedure:   sp_ah_deposito                                  */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
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
/*  Este programa procesa la transaccion de deposito completo           */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA         AUTOR       RAZON                                     */
/*  25/Feb/1993   J. Navarrete    Emision inicial                       */
/*  21/Nov/1998   G. George       Creacion del parametro @o_ssn         */
/*  24/Feb/1999   M. Sanguino     Cambios cc_caja                       */
/*  09/Jul/1999   G. George       Concatenacion de la moneda en         */
/*                                      la busqueda del MMI.            */
/*  12/Sep/2000   Y. Rivero       Requerimiento de los Totales de       */
/*                                cajero (optimizacion de los re--      */
/*                                portes de TOTALES DE OPERADOR         */
/*                                (ATX) y TOTALES DE OFICINA (TA)       */
/*  20/Jun/2001   R. Penarreta    Branch II                             */
/*  14/Nov/2002   E. Lincango     Branch Explorer                       */
/*  2004/03/03    Carlos Cruz D.  Devoluci de nero de control       */
/*                                para leas pendientes                */
/*  2004/04/22    Carlos Cruz D.  Manejo del modo masivo en BDF         */
/*  02/Mayo/2016  Ignacio Yupa    Migraci髇 a CEN                       */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_deposito')
  drop proc sp_ah_deposito
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_deposito
(
  @s_ssn           int,
  @s_ssn_branch    int,
  @s_srv           varchar(30),
  @s_lsrv          varchar(30),
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
  @t_corr          char(1) = 'N',
  @t_ssn_corr      int = null,/* Trans a ser reversada */
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint,
  @t_ejec          char(1) = null,
  @t_show_version  bit = 0,
  @p_sldcont       money = null,
  @p_slddisp       money = null,
  @p_lssn          int = null,
  @p_rssn          int = null,
  @p_rssn_corr     int = null,
  @p_envio         char(1) = 'N',
  @p_rpta          char(1) = 'N',
  @p_control       int = null,
  @p_nom           varchar(30) = null,
  @p_lineas        int = null,
  @p_int_cap       money = null,
  @p_usa           char(1) = null,
  @i_cta           cuenta,
  @i_total         money = null,
  @i_prop          money = null,
  @i_loc           money = null,
  @i_plaz          money = null,
  @i_sldlib        money = null,
  @i_val           money = null,
  @i_nctrl         int = null,
  @i_ind           tinyint = null,
  @i_cau           char(3) = null,
  @i_dep           smallint = null,
  @i_mon           tinyint,
  @i_monto_maximo  char(1),
  @i_concep        varchar(30) = null,
  @i_turno         smallint = null,
  @i_sld_caja      money = 0,-- ELI 14/11/2002  
  @i_idcierre      int = 0,
  @i_filial        smallint = 1,
  @i_idcaja        int = 0,-- FIN ELI 14/11/2002

  --CCR BRANCH III
  @i_fecha_valor_a datetime = null,
  @i_estado_masivo int = 0,--CCR MODO MASIVO
  @i_prop_masivo   money = 0,--CCR MODO MASIVO
  @i_val_masivo    money = 0,--CCR MODO MASIVO
  @i_usateller     char(1) = 'N',
  @i_ape1          varchar(30) = null,-- Primer apellido del Gestor
  @i_ape2          varchar(30) = null,-- Segundo apellido del Gestor
  @i_nom1          varchar(30) = null,-- Primer nombre del Gestor
  @i_nom2          varchar(30) = null,-- Segundo nombre del Gestor
  @i_tipoid        varchar(3) = null,-- Tipo de Identificaci贸n del Gestor
  @i_numeroid      varchar(20) = null,-- Numero de identificaci贸n del Gestor
  @i_direccion     varchar(80) = null,-- Direccion del Gestor 
  @i_nacionalidad  varchar(10) = null,-- C贸digo del Pa铆s del Gestor
  @i_trnb          int = null,-- C贸digo de la transacci贸n Branch
  @i_gestor        char(1) = null,
  -- Bandera que indica si el gestor fue encontrado o no cuando el cajero realiz贸 

  -- la b煤squeda mediante en n煤mero de identificaci贸n. 
  @i_cod_gestor    int = null,-- Codigo del Gestor
  @i_canal         smallint = 4,
  @o_lineas        int = null out,
  @o_sldlib        money = null out,
  @o_nctrl         smallint = null out,
  @o_control       smallint = null out,
  @o_nombre        varchar(50) = null out,
  @o_int_cap       money = null out,
  @o_ssn           int = null out,
  @o_patente       varchar(40) = null out
)
as
  declare
    @w_return            int,
    @w_sp_name           varchar(30),
    @w_cuenta            int,
    @w_cliente           int,
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
    @w_usa               char(1),
    @w_efe               money,
    @w_sldlib            money,
    @w_loc               money,
    @w_prop              money,
    @w_rem               money,
    @w_oficina_cta       smallint,
    @w_ncontrol          int,
    @w_lpend             int,
    @w_monto_maximo_cred money,
    @w_prod_banc         smallint,
    @w_categoria         char(1),
    @w_cau               smallint,
    @w_tran_especial     int,
    @w_tipocta_super     char(1),
    @w_clase_clte        char(1),
    @w_mombre            char(64),
    @w_cod_cliente       int,
    @w_num_id            char(15),
    @w_siguiente         int

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_deposito'
  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @o_ssn = @s_ssn

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
        return 201063
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

  /*verificar creditos a ctas de ahorro  */
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
    if @i_val + isnull(@i_prop, 0) + isnull(@i_loc, 0) > @w_monto_maximo_cred
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251072
      return 251072
    end
  end

  /* Valida datos */
  if @t_trn = 255
     and @i_ind not in (1, 2, 3, 4)
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251022
    return 251022
  end

  /* Chequeo de la Causa */
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
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201030
      return 201030
    end
    else
    begin
      select
        @w_cau = convert(smallint, @i_cau)
      if @w_cau < 200 -- CAUSAS PROGRAMADAS
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201199
        return 201199
      end
    end
  end

  /* Valida Departamento */
  if @i_dep is not null
  begin
    if not exists (select
                     1
                   from   cobis..cl_departamento
                   where  de_departamento = @i_dep)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101010
      return 101010
    end
  end

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
    @i_nom_producto = 'CUENTA DE AHORROS',
    @o_filial       = @w_filial out,
    @o_oficina      = @w_oficina out,
    @o_producto     = @w_producto out,
    @o_server_local = @w_server_local out
  if @w_return <> 0
    return @w_return

  /*  Determinacion de condicion de local o remoto  */
  exec @w_return = cob_ahorros..sp_cta_origen
    @t_debug    = @t_debug,
    @t_file     = @t_file,
    @t_from     = @w_sp_name,
    @i_cta      = @i_cta,
    @i_producto = @w_producto,
    @i_mon      = @i_mon,
    @i_oficina  = @w_oficina,
    @o_tipo     = @w_tipo out,
    @o_srv_local= @w_server_local out,
    @o_srv_rem  = @w_server_rem out

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

  update cobis..cl_seqnos
  set    siguiente = siguiente + 1
  where  tabla = 'ah_lpendiente'

  select
    @w_lpend = siguiente
  from   cobis..cl_seqnos
  where  tabla = 'ah_lpendiente'

  if @w_lpend > 2147483640
  begin
    update cobis..cl_seqnos
    set    siguiente = 0
    where  tabla = 'ah_lpendiente'
  end

  commit tran

  if @i_turno is null
    select
      @i_turno = @s_rol

  /* Esta tabla temporal es para las lineas pendientes si las hay */
  if @i_usateller = 'N'
  begin
    create table #lpendiente
    (
      fecha    varchar(10),
      valor    money,
      saldo    money,
      control  smallint,
      nemonico char(4),
      signo    char(1),
      lp_linea int
    )

    create table #lpendiente_5ult
    (
      fecha    smalldatetime,
      valor    money,
      saldo    money,
      control  smallint,
      nemonico char(4),
      signo    char(1),
      lp_linea int
    )

    create table #lpendiente_def
    (
      fecha    smalldatetime,
      valor    money,
      saldo    money,
      control  smallint,
      nemonico char(4),
      signo    char(1)
    )
  end

  begin tran

  /* Encontrar el seqnos para el numero de control y para la linea pendiente */
  update cobis..cl_seqnos
  set    siguiente = siguiente + 1
  where  tabla = 'ah_control'

  select
    @w_ncontrol = siguiente
  from   cobis..cl_seqnos
  where  tabla = 'ah_control'

  if @w_ncontrol >= 9999
  begin
    update cobis..cl_seqnos
    set    siguiente = 1
    where  tabla = 'ah_control'

    select
      @w_ncontrol = 0
  end

  commit tran

  /*  Transaccion generada por usuario  */

  if @s_org = 'U'
  begin
    /*  Transaccion local  */
    if @w_tipo = 'L'
    begin
      exec @w_return = cob_ahorros..sp_ah_depo2_local_remoto
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
        @t_corr          = @t_corr,
        @t_ssn_corr      = @t_ssn_corr,
        @t_debug         = @t_debug,
        @t_from          = @w_sp_name,
        @t_file          = @t_file,
        @t_rty           = @t_rty,
        @t_trn           = @t_trn,
        @t_ejec          = @t_ejec,
        @p_rssn          = @p_rssn,
        @p_rssn_corr     = @p_rssn_corr,
        @s_org           = @s_org,
        @i_cta           = @i_cta,
        @i_efe           = @i_val,
        @i_prop          = @i_prop,
        @i_loc           = @i_loc,
        @i_plaz          = @i_plaz,
        @i_sldlib        = @i_sldlib,
        @i_credit        = @i_val,
        @i_nctrl         = @i_nctrl,
        @i_cau           = @i_cau,
        @i_ind           = @i_ind,
        @i_dep           = @i_dep,
        @i_mon           = @i_mon,
        @i_oficina       = @w_oficina,
        @i_concep        = @i_concep,
        @i_ncontrol      = @w_ncontrol,
        @i_lpend         = @w_lpend,
        @i_turno         = @i_turno,
        @i_filial        = @i_filial,-- ELI 14/11/2002
        @i_sld_caja      = @i_sld_caja,
        @i_idcierre      = @i_idcierre,
        @i_idcaja        = @i_idcaja,-- FIN ELI 14/11/2002
        --CCR BRANCH III
        @i_fecha_valor_a = @i_fecha_valor_a,
        @i_estado_masivo = @i_estado_masivo,--CCR MODO MASIVO
        @i_prop_masivo   = @i_prop_masivo,--CCR MODO MASIVO
        @i_val_masivo    = @i_val_masivo,--CCR MODO MASIVO
        @i_usateller     = @i_usateller,
        @i_canal         = @i_canal,
        @o_sldcont       = @w_sldcont out,
        @o_slddisp       = @w_slddisp out,
        @o_control       = @o_control out,
        @o_nombre        = @o_nombre out,
        @o_cliente       = @w_cliente out,
        @o_patente       = @o_patente out,
        @o_int_cap       = @o_int_cap out,
        @o_lineas        = @o_lineas out,
        @o_usa           = @w_usa out,
        @o_sldlib        = @w_sldlib out,
        @o_nctrl         = @o_nctrl out,
        @o_oficina_cta   = @w_oficina_cta out,
        @o_prod_banc     = @w_prod_banc out,
        @o_categoria     = @w_categoria out,
        @o_clase_clte    = @w_clase_clte out,
        @o_tipocta_super = @w_tipocta_super out

      --CCR BRANCH III    
      if @t_ejec = 'R'
      begin
        select
          'results_submit_rpc',
          r_control = @o_control,
          r_nctrl = @o_nctrl,
          r_sldlib = @w_sldlib,
          r_lineas = @o_lineas

        exec cob_remesas..sp_resultados_branch_caja
          @i_sldcaja  = @i_sld_caja,
          @i_idcierre = @i_idcierre,
          @i_ssn_host = @s_ssn
      end

      if @i_usateller = 'N'
      begin
        if @w_return = 2
          select
            @w_return = 0
      end
      return @w_return
    end

    /*  Transaccion remota  */
    if @w_tipo = 'R'
    begin
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
      exec @w_return = cob_ahorros..sp_ah_depo2_local_remoto
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
        @p_lssn          = @p_lssn,
        @p_rssn          = @p_rssn,
        @p_rssn_corr     = @p_rssn_corr,
        @s_org           = @s_org,
        @i_cta           = @i_cta,
        @i_efe           = @i_val,
        @i_prop          = @i_prop,
        @i_loc           = @i_loc,
        @i_plaz          = @i_plaz,
        @i_sldlib        = @i_sldlib,
        @i_nctrl         = @i_nctrl,
        @i_credit        = @i_val,
        @i_ind           = @i_ind,
        @i_cau           = @i_cau,
        @i_dep           = @i_dep,
        @i_mon           = @i_mon,
        @i_filial        = @i_filial,-- ELI 14/11/2002
        @i_sld_caja      = @i_sld_caja,
        @i_idcierre      = @i_idcierre,
        @i_idcaja        = @i_idcaja,-- ELI 14/11/2002
        @i_oficina       = @w_oficina,
        @i_concep        = @i_concep,
        @i_ncontrol      = @w_ncontrol,
        @i_lpend         = @w_lpend,
        @i_turno         = @i_turno,
        @i_usateller     = @i_usateller,
        @i_estado_masivo = @i_estado_masivo,--CCR MODO MASIVO
        @i_prop_masivo   = @i_prop_masivo,--CCR MODO MASIVO
        @i_val_masivo    = @i_val_masivo,--CCR MODO MASIVO
        @i_canal         = @i_canal,
        @o_sldcont       = @w_sldcont out,
        @o_slddisp       = @w_slddisp out,
        @o_control       = @o_control out,
        @o_nombre        = @o_nombre out,
        @o_cliente       = @w_cliente out,
        @o_patente       = @o_patente out,
        @o_int_cap       = @o_int_cap out,
        @o_lineas        = @o_lineas out,
        @o_usa           = @w_usa out,
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
          p_control = @o_control,
          p_lineas = @o_lineas
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
        p_control = @o_control,
        p_int_cap = @o_int_cap,
        p_lineas = @o_lineas,
        p_usa = @w_usa,
        p_nom = @o_nombre,
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
    select
      @o_lineas = @p_lineas
    if @t_trn = 251
    begin
      /*  Transaccion monetaria */
      insert into cob_ahorros..ah_deposito
                  (secuencial,ssn_branch,tipo_tran,oficina,usuario,
                   terminal,correccion,sec_correccion,reentry,origen,
                   nodo,fecha,cta_banco,efectivo,propios,
                   locales,signo,ot_plazas,remoto_ssn,moneda,
                   interes,saldo_lib,control,fecha_efec,saldocont,
                   saldodisp,saldoint,oficina_cta,prod_banc,categoria,
                   tipocta_super,turno,hora,canal,cliente,
                   clase_clte)
      values      (@p_lssn,@s_ssn_branch,@t_trn,@s_ofi,@s_user,
                   @s_term,@t_corr,@t_ssn_corr,@t_rty,'L',
                   @w_server_rem,@s_date,@i_cta,@i_val,@i_prop,
                   @i_loc,@w_signo,@i_plaz,@p_rssn,@i_mon,
                   null,@i_sldlib,@p_control,null,@p_sldcont,
                   @p_slddisp,null,@w_oficina_cta,@w_prod_banc,@w_categoria,
                   @w_tipocta_super,@i_turno,getdate(),@i_canal,@w_cliente,
                   @w_clase_clte)

      /* Actualizacion de totales de cajero */
      exec @w_return = cob_remesas..sp_upd_totales -- ELI 14/11/2002
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
        @i_cta_banco   = @i_cta,
        @i_filial      = @i_filial,-- ELI 14/11/2002
        @i_idcaja      = @i_idcaja,
        @i_idcierre    = @i_idcierre,
        @i_saldo_caja  = @i_sld_caja -- FIN ELI 14/11/2002
      if @w_return = 0
      begin
        /*  Actualizacion de totales de servidor enviado (remoto) */
        exec @w_return = cob_remesas..sp_upd_totales -- ELI 14/11/2002
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
          @i_cta_banco   = @i_cta,
          @i_filial      = @i_filial,-- ELI 14/11/2002
          @i_idcaja      = @i_idcaja,
          @i_idcierre    = @i_idcierre,
          @i_saldo_caja  = @i_sld_caja -- FIN ELI 14/11/2002

        if @w_return = 0
        begin
          commit tran
          return 0
        end
      end
    end
    else if @t_trn = 255
    begin
      /*  Transaccion monetaria */
      insert into cob_ahorros..ah_notcredeb
                  (secuencial,ssn_branch,tipo_tran,oficina,usuario,
                   terminal,correccion,sec_correccion,reentry,origen,
                   nodo,fecha,cta_banco,indicador,remoto_ssn,
                   moneda,causa,interes,saldo_lib,valor,
                   control,fecha_efec,signo,saldocont,saldodisp,
                   saldoint,departamento,oficina_cta,concepto,prod_banc,
                   categoria,tipocta_super,turno,hora,canal,
                   cliente,clase_clte)
      values      (@p_lssn,@s_ssn_branch,@t_trn,@s_ofi,@s_user,
                   @s_term,@t_corr,@t_ssn_corr,@t_rty,'L',
                   @w_server_rem,@s_date,@i_cta,@i_ind,@p_rssn,
                   @i_mon,@i_cau,null,@i_sldlib,@i_val,
                   @p_control,null,@w_signo,@p_sldcont,@p_slddisp,
                   null,@i_dep,@w_oficina_cta,@i_concep,@w_prod_banc,
                   @w_categoria,@w_tipocta_super,@i_turno,getdate(),@i_canal,
                   @w_cliente,@w_clase_clte)

      if @i_ind = 1
        select
          @w_efe = @i_val
      else if @i_ind = 2
        select
          @w_prop = @i_val
      else if @i_ind = 3
        select
          @w_loc = @i_val
      else if @i_ind = 4
        select
          @w_rem = @i_val

      /* Buscar si existe transaccion especial */
      select
        @w_tran_especial = te_tran_final
      from   cob_remesas..re_tran_especiales
      where  te_tran_original = @t_trn
         and te_causas        = @i_cau

      if @@rowcount = 0
        select
          @w_tran_especial = @t_trn

      /* Actualizacion de totales de cajero */
      exec @w_return = cob_remesas..sp_upd_totales -- ELI 14/11/2002
        @i_ofi          = @s_ofi,
        @i_term         = @s_term,
        @i_user         = @s_user,
        @i_mon          = @i_mon,
        @i_trn          = @w_tran_especial,--@t_trn,
        @i_nodo         = @s_srv,
        @i_tipo         = 'L',
        @i_corr         = @t_corr,
        @i_efectivo     = @w_efe,
        @i_cheque       = @w_prop,
        @i_chq_locales  = @w_loc,
        @i_chq_ot_plaza = @w_rem,
        @i_ssn          = @s_ssn,
        @i_cta_banco    = @i_cta,
        @i_filial       = @i_filial,-- ELI 14/11/2002
        @i_idcaja       = @i_idcaja,
        @i_idcierre     = @i_idcierre,
        @i_saldo_caja   = @i_sld_caja -- FIN ELI 14/11/2002

      if @w_return = 0
      begin
        /*  Actualizacion de totales de servidor enviado (remoto) */
        exec @w_return = cob_remesas..sp_upd_totales-- ELI 14/11/2002
          @i_ofi          = @w_oficina,
          @i_term         = @s_srv,
          @i_user         = @s_srv,
          @i_mon          = @i_mon,
          @i_trn          = @w_tran_especial,--@t_trn,
          @i_nodo         = @w_server_rem,
          @i_tipo         = 'E',
          @i_corr         = @t_corr,
          @i_efectivo     = @w_efe,
          @i_cheque       = @w_prop,
          @i_chq_locales  = @w_loc,
          @i_chq_ot_plaza = @w_rem,
          @i_ssn          = @s_ssn,
          @i_cta_banco    = @i_cta,
          @i_filial       = @i_filial,-- ELI 14/11/2002
          @i_idcaja       = @i_idcaja,
          @i_idcierre     = @i_idcierre,
          @i_saldo_caja   = @i_sld_caja -- FIN ELI 14/11/2002
        if @w_return = 0
        begin
          commit tran
          return 0
        end
      end
    end
  end

go

