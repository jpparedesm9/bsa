/************************************************************************/
/*  Archivo:            ah_retiroemb.sp                                 */
/*  Stored procedure:   sp_ah_retiroemb                                 */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 10-Feb-1993                                     */
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
/*      Este programa procesa la transaccion de Nota de Debito          */
/*      SIN LIBRETA                                                     */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA         AUTOR               RAZON                             */
/*  25/Feb/1993   X Gellibert Coello  Emision Inicial                   */
/*  24/Nov/1993   J Navarrete V.      Modificaciones Generales          */
/*  19/Ene/1996   D Villafuerte       Control Calidad (par rem)         */
/*  21/11/1998    G. George           Creacion del parametro @o_ssn     */
/*  09/Jul/1999   J. Salazar          Concatenacion de la moneda en     */
/*                                    la busqueda del MMS.              */
/*  15/Nov/1999   George F.George     Aumento de parametro @i_serial    */
/*                                    para n. de debito c/serial.       */
/*  12/Sep/2000   Yenny Rivero        Requerimiento de los Totales de   */
/*                                    cajero (optimizacion de los re--  */
/*                                    portes de TOTALES DE OPERADOR     */
/*                                    (ATX) y TOTALES DE OFICINA (TA)   */
/*  2002/11/22    Carlos Cruz D.      Branch III                        */
/*  2010/03/03    Erika A. Alvarez    Oficina Solita -call center       */
/*  02/Mayo/2016  Ignacio Yupa        Migración a CEN                   */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_retiroemb')
  drop proc sp_ah_retiroemb
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_retiroemb
(
  @s_ssn           int,
  @s_ssn_branch    int = null,/*Cambios BRANCHII */
  @s_lsrv          varchar(30),
  @s_srv           varchar(30),
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
  @t_user          varchar(30) = null,
  @t_term          varchar(30) = null,
  @t_srv           varchar(30) = null,
  @t_ofi           smallint = null,
  @t_rol           smallint = null,
  @t_corr          char(1) = 'N',
  @t_ejec          char(1) = 'N',/*Cambios BRANCHII */
  @t_ssn_corr      int = null,/* Trans a ser reversada */
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint,
  @t_show_version  bit = 0,
  @p_lssn          int = null,
  @p_rssn          int = null,
  @p_rssn_corr     int = null,
  @p_envio         char(1) = 'N',
  @p_rpta          char(1) = 'N',
  @p_sus_flag      tinyint = 0,
  @p_val_mon       money = 0,
  @p_val_ser       money = 0,
  @p_nombre        varchar(60) = null,
  @p_cedula        varchar(30) = null,
  @p_sldcont       money = null,
  @p_slddisp       money = null,
  @r_nombre        varchar(60) = null,
  @r_comision      money = null,
  @r_iva           money = null,
  @r_gmf           money = null,
  @x_ofi           smallint = null,
  @i_cod_alterno   int = 0,
  @i_cta           cuenta,
  @i_mon           tinyint,
  @i_val           money,
  @i_valch         money = null,
  @i_ind           tinyint = null,
  @i_cau           char(3) = null,
  @i_dep           smallint = null,
  @i_concep        varchar(30) = null,
  @i_chqrem        int = null,
  @i_dif           char(1) = 'N',
  @i_monto_maximo  char(1) = 'S',
  @i_serial        varchar(30) = null,
  @i_turno         smallint = null,
  @i_sld_caja      money = 0,
  @i_idcierre      int = 0,
  @i_filial        smallint = 1,
  @i_idcaja        int = 0,

  --CCR BRANCH III
  @i_fecha_valor_a datetime = null,
  @i_ape1          varchar(30) = null,-- Primer apellido del Gestor
  @i_ape2          varchar(30) = null,-- Segundo apellido del Gestor
  @i_nom1          varchar(30) = null,-- Primer nombre del Gestor
  @i_nom2          varchar(30) = null,-- Segundo nombre del Gestor
  @i_tipoid        varchar(3) = null,-- Tipo de Identificación del Gestor
  @i_numeroid      varchar(20) = null,-- Numero de identificación del Gestor
  @i_direccion     varchar(80) = null,-- Direccion del Gestor 
  @i_nacionalidad  varchar(10) = null,-- Código del País del Gestor
  @i_trnb          int = null,-- Código de la transacción Branch
  @i_gestor        char(1) = null,
  -- Bandera que indica si el gestor fue encontrado o no cuando el cajero realizó 

  -- la búsqueda mediante en número de identificación. 
  @i_cod_gestor    int = null,-- Codigo del Gestor
  @i_corresponsal  char(1) = 'N',--Req. 381 CB Red Posicionada
  @o_nombre        varchar(60) = null out,
  @o_cedula        varchar(20) = null out,
  @o_ssn           int = null out,
  @o_alerta_cli    varchar(40) = null out,
  @o_val_2x1000    money = 0 out,
  @o_monto_imp     money = 0 out,
  @o_comision      money = 0 out
)
as
  declare
    @w_return             int,
    @w_sp_name            varchar(30),
    @w_cuenta             int,
    @w_filial             tinyint,
    @w_oficina            smallint,
    @w_filial_p           tinyint,
    @w_oficina_p          tinyint,
    @w_producto           tinyint,
    @w_server_rem         descripcion,
    @w_server_local       descripcion,
    @w_tipo               char(1),
    @w_rssn_corr          int,
    @w_factor             int,
    @w_val_mon            money,
    @w_val_ser            money,
    @w_sus_flag           tinyint,
    @w_sldcont            money,
    @w_slddisp            money,
    @w_signo              char(1),
    @w_efe                money,
    @w_loc                money,
    @w_prop               money,
    @w_rem                money,
    @w_ncontrol           int,
    @w_lpend              int,
    @w_prod_banc          smallint,
    @w_ente               int,
    @w_categoria          char(1),
    @w_monto_maximo_deb   money,
    @w_cau                smallint,
    @w_monto_imp          money,
    @w_tipo_exonerado_imp char(2),
    @w_tipocta_super      char(1),
    @w_mombre             char(64),
    @w_cliente            int,
    @w_num_id             char(15),
    @w_siguiente          int,
    @w_alerta_cli         varchar(40),
    @w_val_2x1000         money,
    @w_codigo_pais        catalogo,
    @w_base_gmf           money,
    @w_clase_clte         char(1),
    --ADI REQ 217 AHORRO CONTRACTUAL
    @w_cta_banco          char(16),
    @w_moneda             tinyint,
    @w_tipocta            char(1),
    @w_modulo             char(3),
    @w_pro_final          smallint,
    @w_sucursal           smallint,
    @w_autoriza           char(1),
    @w_prod_bancario      varchar(50),--Req. 381 CB Red Posicionada
    @w_mensaje            varchar(254)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_retiroemb'
  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end
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
  
  select
    @o_ssn = @s_ssn

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

  /*  Modo de debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**  Stored Procedure  **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_lsrv = @s_lsrv,
      s_srv = @s_srv,
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
      i_cod_alterno = @i_cod_alterno,
      i_cta_banco = @i_cta,
      i_moneda = @i_mon,
      i_val = @i_val,
      i_valch = @i_valch,
      i_indicador = @i_ind,
      i_causa = @i_cau,
      i_serial = @i_serial
    exec cobis..sp_end_debug
  end

  select
    @w_codigo_pais = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'ABPAIS'
     and pa_producto = 'ADM'

  if @@rowcount = 0
  begin
    /** No existe parametro de pais local **/
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 101190
    return 101190
  end

  if @x_ofi is not null
    select
      @s_ofi = @x_ofi

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

  /*Verificacion de debitos a ctas. de ahorro: retiro de aho sin libreta */
  if @i_monto_maximo = 'S'
     and @t_corr = 'N'
     and @t_trn = 392
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
        @i_num   = 251072
      return 251072
    end
  end

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
        @s_date   = @s_date,
        @s_user   = @s_user,
        @t_trn    = @t_trn,
        @i_ofi    = @s_ofi,
        @s_srv    = @s_srv,
        @i_filial = @i_filial,
        @i_mon    = @i_mon,
        @i_idcaja = @i_idcaja

      if @w_return <> 0
        return @w_return

    end -- FIN ELI 14/11/2002     
  end

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    /* ADI: REQ 217 AHORRO CONTRACTUAL */
    select
      @w_cta_banco = ah_cta_banco,
      @w_producto = ah_producto,
      @w_tipo = ah_tipo,
      @w_moneda = ah_moneda,
      @w_categoria = ah_categoria,
      @w_tipocta = ah_tipocta,
      @w_prod_banc = ah_prod_banc
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
       and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
  end
  else
  begin
    /* ADI: REQ 217 AHORRO CONTRACTUAL */
    select
      @w_cta_banco = ah_cta_banco,
      @w_producto = ah_producto,
      @w_tipo = ah_tipo,
      @w_moneda = ah_moneda,
      @w_categoria = ah_categoria,
      @w_tipocta = ah_tipocta,
      @w_prod_banc = ah_prod_banc
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
  end

  if @w_producto = 4
    select
      @w_modulo = 'AHO'
  else
    select
      @w_modulo = 'CTE'

  select
    @w_sucursal = isnull(of_sucursal,
                         of_regional)
  from   cobis..cl_oficina
  where  of_oficina = @s_ofi

  select distinct
    @w_pro_final = pf_pro_final
  from   cob_remesas..pe_pro_final,
         cob_remesas..pe_mercado,
         cob_remesas..pe_pro_bancario
  where  pf_filial       = @i_filial
     and pf_sucursal     = @w_sucursal
     and pf_producto     = @w_producto
     and pf_moneda       = @w_moneda
     and me_tipo_ente    = @w_tipocta
     and pf_tipo         = @w_tipo
     and me_mercado      = pf_mercado
     and me_pro_bancario = pb_pro_bancario
     and me_pro_bancario = @w_prod_banc

  exec cob_remesas..sp_autoriza_trn_caja
    @t_trn        = 730,
    @i_operacion  = 'V',
    @i_modulo     = @w_modulo,
    @i_sucursal   = @w_sucursal,
    @i_producto   = @w_pro_final,
    @i_categoria  = @w_categoria,
    @i_tran       = @t_trn,
    @o_autorizada = @w_autoriza out

  select
    @w_producto = null,
    @w_tipo = null,
    @w_categoria = null,
    @w_prod_banc = null

  if @w_autoriza = 'N'
  begin
    exec cobis..sp_cerror -- Transaccion no autorizada para esta cuenta
      @t_from = @w_sp_name,
      @i_num  = 351575,
      @i_sev  = 0
    return 1
  end
/* ADI: FIN - REQ 217 AHORRO CONTRACTUAL */
  /*  Captura de parametros de la oficina  */
  exec @w_return = cobis..sp_parametros
    @t_debug       = @t_debug,
    @t_file        = @t_file,
    @t_from        = @w_sp_name,
    @s_lsrv        = @s_lsrv,
    @i_nom_producto= 'CUENTA DE AHORROS',
    @o_oficina     = @w_oficina out,
    @o_producto    = @w_producto out
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

  if @i_turno is null
    select
      @i_turno = @s_rol

  /* REQ  EXTRAER TOPES PARA EL TIPO DE PRODUCTO REQ 412*/
  if @t_corr = 'N'
  begin
    /* [DS 29-05-2014] Req 412 CB. Limites transaccionales */
    exec @w_return = cob_remesas..sp_valida_limites_canal
      @s_ofi       = @s_ofi,
      @i_cta       = @i_cta,
      @i_tipo_prod = @w_producto,
      @i_fecha     = @s_date,
      @i_trn       = @t_trn,
      @i_val       = @i_val,
      @i_causal    = @i_cau,
      @o_msg       = @w_mensaje out

    if @w_return <> 0
    begin
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_msg  = @w_mensaje,
        @i_num  = @w_return,
        @i_sev  = 0

      return @w_return
    end
  end
  /* FIN - REQ 412 EXTRAER TOPES PARA EL TIPO DE PRODUCTO */

  begin tran

  /* Encontrar el seqnos para el numero de control y para la linea pendiente */

  update cobis..cl_seqnos
  set    siguiente = siguiente + 2
  where  tabla = 'ah_control'

  select
    @w_ncontrol = siguiente - 1
  from   cobis..cl_seqnos
  where  tabla = 'ah_control'

  if @w_ncontrol > = 9999
  begin
    update cobis..cl_seqnos
    set    siguiente = 1
    where  tabla = 'ah_control'
    select
      @w_ncontrol = 0
  end

  update cobis..cl_seqnos
  set    siguiente = siguiente + 2
  where  tabla = 'ah_lpendiente'

  select
    @w_lpend = siguiente - 1
  from   cobis..cl_seqnos
  where  tabla = 'ah_lpendiente'

  if @w_lpend >= 2147483639
  begin
    update cobis..cl_seqnos
    set    siguiente = 1
    where  tabla = 'ah_lpendiente'
    select
      @w_lpend = 0
  end

  commit tran

  /*  Transaccion generada por usuario  */
  if @s_org = 'U'
  begin
    /* Transaccion local */
    if @w_tipo = 'L'
    begin
      exec @w_return = cob_ahorros..sp_ah_retemb_locrem
        @s_ssn               = @s_ssn,
        @s_ssn_branch        = @s_ssn_branch,/*Cambios BRANCHII */
        @s_lsrv              = @s_lsrv,
        @s_srv               = @s_srv,
        @s_user              = @s_user,
        @s_sesn              = @s_sesn,
        @s_term              = @s_term,
        @s_date              = @s_date,
        @s_ofi               = @s_ofi,
        @s_rol               = @s_rol,
        @s_sev               = @s_sev,
        @t_corr              = @t_corr,
        @t_ejec              = @t_ejec,/*Cambios BRANCHII */
        @t_ssn_corr          = @t_ssn_corr,
        @t_debug             = @t_debug,
        @t_from              = @w_sp_name,
        @t_file              = @t_file,
        @t_rty               = @t_rty,
        @t_trn               = @t_trn,
        @p_lssn              = @p_lssn,
        @p_rssn_corr         = @p_rssn_corr,
        @s_org               = @s_org,
        @i_cod_alterno       = @i_cod_alterno,
        @i_cta               = @i_cta,
        @i_mon               = @i_mon,
        @i_val               = @i_val,
        @i_valch             = @i_valch,
        @i_ind               = @i_ind,
        @i_cau               = @i_cau,
        @i_dep               = @i_dep,
        @i_oficina           = @w_oficina,
        @i_concep            = @i_concep,
        @i_chqrem            = @i_chqrem,
        @i_ncontrol          = @w_ncontrol,
        @i_lpend             = @w_lpend,
        @i_dif               = @i_dif,
        @i_serial            = @i_serial,
        @i_turno             = @i_turno,
        @i_filial            = @i_filial,
        @i_idcaja            = @i_idcaja,
        @i_idcierre          = @i_idcierre,
        @i_sld_caja          = @i_sld_caja,
        --CCR BRANCH III
        @i_fecha_valor_a     = @i_fecha_valor_a,
        @o_sus_flag          = @w_sus_flag out,
        @o_val_mon           = @w_val_mon out,
        @o_val_ser           = @w_val_ser out,
        @o_sldcont           = @w_sldcont out,
        @o_slddisp           = @w_slddisp out,
        @o_nombre            = @o_nombre out,
        @o_cedula            = @o_cedula out,
        @o_cliente           = @w_cliente out,
        @o_prod_banc         = @w_prod_banc out,
        @o_categoria         = @w_categoria out,
        @o_monto_imp         = @w_monto_imp out,
        @o_val_2x1000        = @w_val_2x1000 out,
        @o_comision          = @o_comision out,
        @o_tipo_exonerado_imp= @w_tipo_exonerado_imp out,
        @o_alerta_cli        = @o_alerta_cli out,
        @o_base_gmf          = @w_base_gmf out,
        @o_clase_clte        = @w_clase_clte out

      select
        @o_val_2x1000 = @w_val_2x1000,
        @o_monto_imp = @w_monto_imp,
        @o_comision = @o_comision

      select
        @o_nombre = @o_nombre,
        @o_cedula = @o_cedula
      select
        'rssn' = @s_ssn

    /*Inicio cambios BRANCHII */
      --CCR BRANCH III
      if @t_ejec = 'R'
      begin
        select
          'results_submit_rpc',
          r_ssn_host = @s_ssn

        exec cob_remesas..sp_resultados_branch_caja
          @i_sldcaja  = @i_sld_caja,
          @i_idcierre = @i_idcierre,
          @i_ssn_host = @s_ssn

        select
          'results_submit_rpc',
          r_cedula = @o_cedula,
          r_nombre = @o_nombre

      end

      /*Fin cambios BRANCHII */

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

      /*  Localizar ssn de la transaccion remota en modo de corr */
      if @w_factor = -1
      begin
        if exists (select
                     *
                   from   ah_tran_monet
                   --where tm_secuencial = @t_ssn_corr)
                   where  tm_ssn_branch = @t_ssn_corr
                      and tm_oficina    = @s_ofi) -- EAL RETCALL. 
          select
            @w_rssn_corr = (select
                              tm_remoto_ssn
                            from   ah_tran_monet
                            --where tm_secuencial = @t_ssn_corr)
                            where  tm_ssn_branch = @t_ssn_corr
                               and tm_oficina    = @s_ofi) -- EAL RETCALL. 
        else
          select
            @w_rssn_corr = (select
                              remoto_ssn
                            from   ah_tsval_suspenso
                            --where secuencial = @t_ssn_corr)
                            where  ssn_branch = @t_ssn_corr
                               and oficina    = @s_ofi) -- EAL RETCALL. 
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
      exec @w_return = cob_ahorros..sp_ah_retemb_locrem
        @s_ssn               = @s_ssn,
        @s_lsrv              = @s_lsrv,
        @s_srv               = @s_srv,
        @s_user              = @s_user,
        @s_sesn              = @s_sesn,
        @s_term              = @s_term,
        @s_date              = @s_date,
        @s_ofi               = @s_ofi,
        @s_rol               = @s_rol,
        @s_sev               = @s_sev,
        @s_ssn_branch        = @s_ssn_branch,
        @t_corr              = @t_corr,
        @t_ssn_corr          = @t_ssn_corr,
        @t_debug             = @t_debug,
        @t_from              = @t_from,
        @t_file              = @t_file,
        @t_rty               = @t_rty,
        @t_trn               = @t_trn,
        @p_lssn              = @p_lssn,
        @p_rssn              = @p_rssn,
        @p_rssn_corr         = @p_rssn_corr,
        @s_org               = @s_org,
        @i_cod_alterno       = @i_cod_alterno,
        @i_cta               = @i_cta,
        @i_mon               = @i_mon,
        @i_val               = @i_val,
        @i_valch             = @i_valch,
        @i_ind               = @i_ind,
        @i_cau               = @i_cau,
        @i_dep               = @i_dep,
        @i_oficina           = @w_oficina,
        @i_concep            = @i_concep,
        @i_chqrem            = @i_chqrem,
        @i_dif               = @i_dif,
        @i_serial            = @i_serial,
        @i_turno             = @i_turno,
        @i_filial            = @i_filial,
        @i_idcaja            = @i_idcaja,
        @i_idcierre          = @i_idcierre,
        @i_sld_caja          = @i_sld_caja,
        --CCR BRANCH III
        @i_fecha_valor_a     = @i_fecha_valor_a,
        @o_sldcont           = @w_sldcont out,
        @o_slddisp           = @w_slddisp out,
        @o_val_mon           = @w_val_mon out,
        @o_val_ser           = @w_val_ser out,
        @o_sus_flag          = @w_sus_flag out,
        @o_nombre            = @o_nombre out,
        @o_cedula            = @o_cedula out,
        @o_cliente           = @w_cliente out,
        @o_prod_banc         = @w_prod_banc out,
        @o_categoria         = @w_categoria out,
        @o_monto_imp         = @w_monto_imp out,
        @o_val_2x1000        = @w_val_2x1000 out,
        @o_comision          = @o_comision out,
        @o_tipo_exonerado_imp= @w_tipo_exonerado_imp out,
        @o_alerta_cli        = @o_alerta_cli out,
        @o_base_gmf          = @w_base_gmf out,
        @o_clase_clte        = @w_clase_clte out
      if @w_return <> 0
        return @w_return

      select
        @o_val_2x1000 = @w_val_2x1000,
        @o_monto_imp = @w_monto_imp,
        @o_comision = @o_comision

    /*Inicio cambios BRANCHII */
      --CCR BRANCH III
      if @t_ejec = 'R'
      begin
        select
          'results_submit_rpc',
          r_ssn_host = @s_ssn

        exec cob_remesas..sp_resultados_branch_caja
          @i_sldcaja  = @i_sld_caja,
          @i_idcierre = @i_idcierre,
          @i_ssn_host = @s_ssn

        select
          'results_submit_rpc',
          r_cedula = @o_cedula,
          r_nombre = @o_nombre

      end

      /* Envio de Resultados  */
      if @t_debug = 'S'
      begin
        exec cobis..sp_begin_debug
          @t_file=@t_file
        select
          '/**  Stored Procedure  **/ ' = @w_sp_name,
          'Inicio resubmit server=' = @s_srv,
          i_touser = @s_user,
          p_sus_flag = @w_sus_flag,
          p_val_mon = @w_val_mon,
          p_val_ser = @w_val_ser,
          p_nombre = @o_nombre,
          p_cedula = @o_cedula,
          p_sldcont = @w_sldcont,
          p_slddisp = @w_slddisp,
          i_tosesion = @s_sesn
        exec cobis..sp_end_debug
      end
      exec @w_return = cobis..sp_begin_resubmit
        @i_toserver = @s_srv,
        @i_touser   = @s_user,
        @i_tosesion = @s_sesn
      select
        p_sus_flag = @w_sus_flag,
        p_val_mon = @w_val_mon,
        p_val_ser = @w_val_ser,
        p_sldcont = @w_sldcont,
        p_slddisp = @w_slddisp,
        p_nombre = @o_nombre,
        p_cedula = @o_cedula
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

    -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
    if @i_corresponsal = 'N'
    begin
      select
        @w_oficina_p = ah_oficina,
        @w_tipocta_super = ah_tipocta_super
      from   ah_cuenta
      where  ah_cta_banco = @i_cta
         and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
    end
    else
    begin
      select
        @w_oficina_p = ah_oficina,
        @w_tipocta_super = ah_tipocta_super
      from   ah_cuenta
      where  ah_cta_banco = @i_cta
    end

    /* Inserta transaccion monetaria */
    if @t_trn = 392
       and @p_sus_flag < 2
    begin
      insert into cob_ahorros..ah_tran_monet
                  (tm_secuencial,tm_ssn_branch,tm_tipo_tran,tm_oficina,
                   tm_usuario,
                   tm_terminal,tm_correccion,tm_sec_correccion,tm_reentry,
                   tm_origen,
                   tm_nodo,tm_fecha,tm_cta_banco,tm_valor,tm_indicador,
                   tm_causa,tm_saldo_lib,tm_remoto_ssn,tm_moneda,tm_signo,
                   tm_control,tm_saldo_contable,tm_saldo_disponible,
                   tm_departamento,
                   tm_oficina_cta,
                   tm_concepto,tm_prod_banc,tm_categoria,tm_monto_imp,
                   tm_tipo_exonerado_imp,
                   tm_serial,tm_tipocta_super,tm_turno,tm_hora,tm_cliente,
                   tm_base_gmf,tm_clase_clte)
      values      (@p_lssn,@s_ssn_branch,@t_trn,@s_ofi,-- EAL RETCALL. 
                   @s_user,
                   @s_term,@t_corr,@t_ssn_corr,@t_rty,'L',
                   @w_server_rem,@s_date,@i_cta,@p_val_mon,@i_ind,
                   @i_cau,null,@p_rssn,@i_mon,@w_signo,
                   @i_chqrem,@p_sldcont,@p_slddisp,@i_dep,@w_oficina_p,
                   @i_concep,@w_prod_banc,@w_categoria,@w_val_2x1000,
                   @w_tipo_exonerado_imp,
                   @i_serial,@w_tipocta_super,@i_turno,getdate(),@w_cliente,
                   @w_base_gmf,@w_clase_clte)
      if @@error <> 0
      begin /** Error Insertar Transaccion Monetaria **/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 253000
        return 253000
      end
    end

    if @t_trn = 392
    begin
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
        @i_saldo_caja = @i_sld_caja

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
          @i_saldo_caja = @i_sld_caja
        if @w_return = 0
        begin
          commit tran
          select
            'Nombre' = @p_nombre
          select
            'Cedula' = @p_cedula
          return 0
        end
      end
    end
    else
    begin
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

      /* Actualizacion de totales de cajero */
      exec @w_return = cob_remesas..sp_upd_totales
        @i_ofi          = @s_ofi,
        @i_term         = @s_term,
        @i_user         = @s_user,
        @i_mon          = @i_mon,
        @i_trn          = @t_trn,
        @i_nodo         = @s_srv,
        @i_tipo         = 'L',
        @i_corr         = @t_corr,
        @i_efectivo     = @w_efe,
        @i_cheque       = @w_prop,
        @i_chq_locales  = @w_loc,
        @i_chq_ot_plaza = @w_rem,
        @i_ssn          = @s_ssn,
        @i_filial       = @i_filial,
        @i_idcaja       = @i_idcaja,
        @i_idcierre     = @i_idcierre,
        @i_saldo_caja   = @i_sld_caja
      if @w_return = 0
      begin
        /*  Actualizacion de totales de servidor enviado (remoto) */
        exec @w_return = cob_remesas..sp_upd_totales
          @i_ofi          = @w_oficina,
          @i_term         = @s_srv,
          @i_user         = @s_srv,
          @i_mon          = @i_mon,
          @i_trn          = @t_trn,
          @i_nodo         = @w_server_rem,
          @i_tipo         = 'E',
          @i_corr         = @t_corr,
          @i_efectivo     = @w_efe,
          @i_cheque       = @w_prop,
          @i_chq_locales  = @w_loc,
          @i_chq_ot_plaza = @w_rem,
          @i_ssn          = @s_ssn,
          @i_filial       = @i_filial,
          @i_idcaja       = @i_idcaja,
          @i_idcierre     = @i_idcierre,
          @i_saldo_caja   = @i_sld_caja
        if @w_return = 0
        begin
          commit tran
          select
            'Nombre' = @p_nombre
          select
            'Cedula' = @p_cedula
          return 0
        end
      end
    end
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 255003 /* Error Actualizar Caja */
    return 255003

  end

go

