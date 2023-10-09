/************************************************************************/
/*  Archivo:            ah_depositosl.sp                                */
/*  Stored procedure:   sp_ah_depositosl                                */
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
/*  FECHA         AUTOR            RAZON                                */
/*  25/Feb/1993   J Navarrete      Emision inicial                      */
/*  19/Ene/1996   D Villafuerte    Control Calidad (param remesas)      */
/*  21/Nov/1998   A Machado        Adicion del parametro @o_ssn         */
/*  30/Nov/1998   J Salazar        Cobro de comision por la transac     */
/*  23/Jun/1999   J.C. Gordillo    IDB (Comision)                       */
/*  09/Jul/1999   George F. George Concatenacion de la moneda en        */
/*                                 la busqueda del MMI.                 */
/*  11/Nov/1999   George F. George Aumento de parametro @i_serial       */
/*                                 para n. de credito c/serial.         */
/*  12/Sep/2000   Yenny Rivero     Requerimiento de los Totales de      */
/*                                 cajero (optimizacion de los re--     */
/*                                 portes de TOTALES DE OPERADOR        */
/*                                 (ATX) y TOTALES DE OFICINA (TA)      */
/*  2002/11/25    Carlos Cruz D.   BRANCH III                           */
/*  2004/04/22    Carlos Cruz D.   Manejo del modo masivo en BDF        */
/*  2005/05/23    Juan F. Cadena   Deposito chq conv. Visa              */
/*  02/May/2016   Ignacio Yupa     Migracion a CEN                      */
/*  15/Jul/2016   Eduardo Williams AHO-H77223 Deposito de ahorros       */
/*  04/Ago/2016   Eduardo Williams AHO-H79808 Reverso de transacciones  */
/*  16/Ago/2016   T. Baidal        H80489 Parametro salida ssn branch   */
/*  06/Sep/2016   D. Fu            H83160 Parametro origen del efectivo */
/*                                 proviene de una remesa (local, exter)*/
/*  22/Sep/2016   T. Baidal        validacion si es batch y se inicio   */
/*                                 una transaccion se hace commit para  */
/*                                 no inconsistencia de num de transac. */                                  
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_depositosl')
  drop proc sp_ah_depositosl
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_depositosl
(
  @s_ssn           int,
  @s_ssn_branch    int = null,/* Inicio cambios BRANCHII */
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
  @t_user          varchar(30) = null,
  @t_term          varchar(30) = null,
  @t_srv           varchar(30) = null,
  @t_ofi           smallint = null,
  @t_rol           smallint = null,
  @t_corr          char(1) = 'N',
  @t_ssn_corr      int = null,/* Trans a ser reversada */
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_ejec          char(1) = 'N',/* Inicio cambios BRANCHII */
  @t_rty           char(1) = 'N',
  @t_trn           smallint,
  @t_show_version  bit = 0,
  @p_lssn          int = null,
  @p_rssn          int = null,
  @p_rssn_corr     int = null,
  @p_envio         char(1) = 'N',
  @p_rpta          char(1) = 'N',
  @p_nombre        varchar(60) = null,
  @p_cedula        varchar(30) = null,
  @p_sldcont       money = null,
  @p_slddisp       money = null,
  @i_cta           cuenta,
  @i_total         money = null,
  @i_prop          money = null,
  @i_loc           money = null,
  @i_plaz          money = null,
  @i_val           money = null,
  @i_ind           tinyint = null,
  @i_cau           varchar(3) = null,
  @i_mon           tinyint,
  @i_dep           smallint = null,
  @i_sp            char(1) = 'N',
  @i_ope           char(2) = 'SL',
  @i_concep        varchar(40) = null,
  @i_chqrem        int = null,
  @i_dif           char(1) = 'N',
  @i_serial        varchar(30) = null,
  @i_sld_caja      money = 0,
  @i_idcierre      int = 0,
  @i_filial        smallint = 1,
  @i_idcaja        int = 0,
  @i_turno         smallint = null,

  --CCR BRANCH III
  @i_fecha_valor_a datetime = null,
  @i_estado_masivo int = 0,--CCR MODO MASIVO
  @i_prop_masivo   money = 0,--CCR MODO MASIVO
  @i_val_masivo    money = 0,--CCR MODO MASIVO
  @i_boleta        varchar(20) = null,
  @i_nombreusr1    varchar(35) = null,
  @i_nombreusr2    varchar(35) = null,
  @i_apellidousr1  varchar(35) = null,
  @i_apellidousr2  varchar(35) = null,
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

  -- la busqueda mediante en numero de identificacion. 
  @i_cod_gestor    int = null,-- Codigo del Gestor
  @i_ActTot        char(1) = 'S',
  @i_canal         tinyint = 4,--4 CAJAS
  @i_comision      money = 0,--REQ 203
  @i_causal        char(3) = '',--REQ 203
  @i_verifica_caja char(1) = 'N', --EWI AHO-H77223
  @i_remesas       char(1) = null,  --Origen del efectivo (L = Local, E = Exterior)
  @i_batch         char(1) = 'N',
  @o_nombre        varchar(60) = null out,
  @o_cedula        varchar(12) = null out,
  @o_alerta        char(1) = null out,
  @o_alerta_cli    varchar(40) = null out,
  @o_ssn           int = null out,
  @o_comision      money = 0 out,
  @o_valiva        money = 0 out,
  @o_ssn_branch    int = null out
)
as
  declare
    @w_return            int,
    @w_sp_name           varchar(30),
    @w_cuenta            int,
    @w_oficina           smallint,
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
    @w_efectivo          money,
    @w_credito           money,
    @w_prod_banc         smallint,
    @w_monto_maximo_cred money,
    @w_categoria         char(1),
    @w_cau               smallint,
    @w_estado            char(1),
    @w_tran_especial     int,
    @w_tipocta_super     char(1),
    @w_clase_clte        char(1),
    @w_mombre            char(64),
    @w_cod_cliente       int,
    @w_num_id            char(15),
    @w_siguiente         int,
    @w_cta_serv          cuenta,
    @w_tipo_comision     char(1),
    @w_valor_tasa        float,
    @w_cliente           int,
	@w_mensaje           varchar(132),
    @w_error             int,
	@w_sev               tinyint

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_depositosl'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.1'
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

  if @t_trn = 341 --SI ES PAGO DE SERVICIO INGRESOS NO TRIBUTARIOS
  begin
    select
      @t_trn = 2677,
      @i_ind = 1
    select
      @w_cta_serv = ltrim(rtrim(ti_cta_banco)),
      @w_tipo_comision = ti_tipo_comision,
      @w_valor_tasa = ti_tasa
    from   cob_remesas..re_mant_ingresos
    where  ti_transaccion = @t_trn
       and ti_tipo        = '7'
       and ti_canal       = @i_canal
       and ti_moneda      = @i_mon

    if @@rowcount = 0
    begin
	    select @w_error = 205064
		goto ERROR
    end

    if @w_cta_serv <> @i_cta
    begin
	    select @w_error = 201299
		goto ERROR
    end
  end

  if @t_trn = 252
    select
      @w_efectivo = @i_val,
      @w_credito = $0
  else
    select
      @w_efectivo = $0,
      @w_credito = @i_val

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_depositosl'
  select
    @o_ssn       = @s_ssn,
	@o_ssn_branch = @s_ssn_branch

  if @i_turno is null
    select
      @i_turno = @s_rol

  if @i_remesas = '' select @i_remesas = null
  
  
  if @i_remesas is not null
  begin
    --Valida existencia de origen remesa en catalogo
    if not exists (select 1 from cobis..cl_tabla t, cobis..cl_catalogo c where t.codigo = c.tabla and t.tabla = 'ah_ori_remesas' and c.codigo = @i_remesas)
    begin
        /* Origen de remesas no es valido. Validar catalogo de origen de remesas */
		select @w_error = 357041
		goto ERROR
    end
    --Valida origen de remesas solo para depositos en efectivo
    if isnull(@i_loc, 0) + isnull(@i_prop, 0) + isnull(@i_plaz, 0) > 0
    begin
        /* Origen de remesas es valido solo para transacciones en efectivo */
		select @w_error = 357042
		goto ERROR
    end
  end 

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
      p_nombre = @p_nombre,
      p_cedula = @p_cedula,
      p_envio = @p_envio,
      p_rpta = @p_rpta,
      p_sldcont = @p_sldcont,
      i_cta_banco = @i_cta,
      i_efectivo = @w_efectivo,
      i_chq_propios = @i_prop,
      i_chq_locales = @i_loc,
      i_chq_ot_plazas = @i_plaz,
      i_indicador = @i_ind,
      i_causa = @i_cau,
      i_credito = @w_credito,
      i_moneda = @i_mon,
      i_filial = @i_filial,
      i_serial = @i_serial
    exec cobis..sp_end_debug
  end

  /* Chequeo de errores generados remotamente */
  if @s_org_err is not null /*  Error del Sistema  */
  begin
      select @w_error   = @s_error,
	         @w_mensaje = @s_msg,
			 @w_sev     = @s_sev
			 
      goto ERROR
  end

if @i_verifica_caja = 'S' --EWI AHO-H77223
begin
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
	      select @w_error   = 201063
		  goto ERROR
      end

    end
    else /*Version Branch Explorer*/
    begin
      exec @w_return= cob_remesas..sp_verifica_caja
        @t_trn    = @t_trn,
        @s_user   = @s_user,
        @i_ofi    = @s_ofi,
        @s_srv    = @s_srv,
        @s_date   = @s_date,
        @i_filial = @i_filial,
        @i_mon    = @i_mon,
        @i_idcaja = @i_idcaja

      if @w_return <> 0
        return @w_return

    end -- FIN ELI 14/11/2002     
  end
end --@i_verifica_caja = 'S'

  /* Valida datos */
  if @t_trn in (253)
     and @i_ind not in (1, 2, 3, 4)
  begin
      select @w_error   = 251022
	  goto ERROR
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
	    select @w_error   = 201030
        goto ERROR
    end
    else
    begin
      select
        @w_cau = convert(smallint, @i_cau)
    /*if @w_cau < 200
      begin
        exec cobis..sp_cerror
             @t_debug  = @t_debug,
             @t_file   = @t_file,
             @t_from   = @w_sp_name,
             @i_num    = 201199
        return 201199
      end*/
    end
  end

  /*  Captura de parametros de la oficina  */
  exec @w_return = cobis..sp_parametros
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @w_sp_name,
    @s_lsrv         = @s_lsrv,
    @i_nom_producto = 'CUENTA DE AHORROS',
    @o_oficina      = @w_oficina out,
    @o_producto     = @w_producto out
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
      @w_signo = 'C',
      @w_estado = null
  else
    select
      @w_factor = -1,
      @w_signo = 'D',
      @w_estado = 'R'
	  
  if @i_batch = 'N'
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

  if @i_batch = 'N'
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
	
	  if @i_batch = 'N'
      begin tran
	  
      exec @w_return = cob_ahorros..sp_ah_depo2_locrem_sl
        @s_ssn           = @s_ssn,
        @s_ssn_branch    = @s_ssn_branch,/* Inicio cambios BRANCHII */
        @s_srv           = @s_srv,
        @s_user          = @s_user,
        @s_sesn          = @s_sesn,
        @s_term          = @s_term,
        @s_date          = @s_date,
        @s_ofi           = @s_ofi,
        @s_rol           = @s_rol,
        @t_corr          = @t_corr,
        @t_ssn_corr      = @t_ssn_corr,
        @t_ejec          = @t_ejec,/* Inicio cambios BRANCHII */
        @t_debug         = @t_debug,
        @t_from          = @w_sp_name,
        @t_file          = @t_file,
        @t_rty           = @t_rty,
        @t_trn           = @t_trn,
        @p_lssn          = @p_lssn,
        @p_rssn_corr     = @p_rssn_corr,
        @s_org           = @s_org,
        @i_cta           = @i_cta,
        @i_efe           = @w_efectivo,
        @i_prop          = @i_prop,
        @i_loc           = @i_loc,
        @i_plaz          = @i_plaz,
        @i_credit        = @w_credito,
        @i_cau           = @i_cau,
        @i_ind           = @i_ind,
        @i_mon           = @i_mon,
        @i_dep           = @i_dep,
        @i_sp            = @i_sp,
        @i_ope           = @i_ope,
        @i_concep        = @i_concep,
        @i_boleta        = @i_boleta,
        @i_nombreusr1    = @i_nombreusr1,
        @i_nombreusr2    = @i_nombreusr2,
        @i_apellidousr1  = @i_apellidousr1,
        @i_apellidousr2  = @i_apellidousr2,
        @i_chqrem        = @i_chqrem,
        @i_ncontrol      = @w_ncontrol,
        @i_lpend         = @w_lpend,
        @i_dif           = @i_dif,
        @i_filial        = @i_filial,
        @i_serial        = @i_serial,
        @i_idcaja        = @i_idcaja,
        @i_idcierre      = @i_idcierre,
        @i_sld_caja      = @i_sld_caja,
        @i_turno         = @i_turno,
        --CCR BRANCH III
        @i_fecha_valor_a = @i_fecha_valor_a,
        @i_estado_masivo = @i_estado_masivo,--CCR MODO MASIVO
        @i_prop_masivo   = @i_prop_masivo,--CCR MODO MASIVO
        @i_val_masivo    = @i_val_masivo,--CCR MODO MASIVO
        @i_ActTot        = @i_ActTot,
        @i_canal         = @i_canal,
        @i_comision      = @i_comision,--REQ 203
        @i_causal        = @i_causal,--REQ 203
        @i_remesas       = @i_remesas,
		@i_batch         = @i_batch,
        @o_sldcont       = @w_sldcont out,
        @o_slddisp       = @w_slddisp out,
        @o_nombre        = @o_nombre out,
        @o_alerta_cli    = @o_alerta_cli out,
        @o_cedula        = @o_cedula out,
        @o_cliente       = @w_cliente out,
        @o_oficina_cta   = @w_oficina_cta out,
        @o_prod_banc     = @w_prod_banc out,
        @o_categoria     = @w_categoria out,
        @o_tipocta_super = @w_tipocta_super out,
        @o_clase_clte    = @w_clase_clte out,
        @o_comision      = @o_comision out,
        @o_valiva        = @o_valiva out
			  
      if @w_return = 0
      begin
        if @t_ejec = 'R' -- ELI 11/14/2002
        begin
          select
            'results_submit_rpc',
            r_ssn_host = @s_ssn

          exec cob_remesas..sp_resultados_branch_caja
            @i_sldcaja  = @i_sld_caja,
            @i_idcierre = @i_idcierre,
            @i_ssn_host = @s_ssn -- FIN ELI 11/14/2002
        end
		if @i_batch = 'N'
        commit tran
      end
      else
      begin
	  
	    if @i_batch = 'N'
		rollback tran
		
		
        -- print '@w_error :'+cast(@w_error as varchar)
        /* Si se presenta error por fondos insuficientes, cuenta cancelada o cuenta inactiva se registra rechazo */
        if @i_comision <> 0
           and (@w_return in (251007, 251033, 251057, 251058))
        begin
          exec cob_remesas..sp_re_rechazos
            @s_ofi      = @s_ofi,
            @t_trn      = @t_trn,
            @i_cta      = @i_cta,
            @i_modulo   = 4,
            @i_vlr_comi = @i_comision,
            @i_vlr_iva  = @o_valiva,
            @i_causal   = @w_return
        end		
        return @w_return
      end
      select
        @o_alerta_cli

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
        if @t_trn = 252
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
      exec @w_return = cob_ahorros..sp_ah_depo2_locrem_sl
        @s_ssn           = @s_ssn,
        @s_srv           = @s_srv,
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
        @i_efe           = @w_efectivo,
        @i_prop          = @i_prop,
        @i_loc           = @i_loc,
        @i_plaz          = @i_plaz,
        @i_credit        = @w_credito,
        @i_ind           = @i_ind,
        @i_cau           = @i_cau,
        @i_mon           = @i_mon,
        @i_dep           = @i_dep,
        @i_sp            = @i_sp,
        @i_ope           = @i_ope,
        @i_concep        = @i_concep,
        @i_chqrem        = @i_chqrem,
        @i_dif           = @i_dif,
        @i_filial        = @i_filial,
        @i_serial        = @i_serial,
        @i_idcaja        = @i_idcaja,
        @i_idcierre      = @i_idcierre,
        @i_sld_caja      = @i_sld_caja,
        @i_turno         = @i_turno,
        --CCR BRANCH III
        @i_fecha_valor_a = @i_fecha_valor_a,
        @i_estado_masivo = @i_estado_masivo,--CCR MODO MASIVO
        @i_prop_masivo   = @i_prop_masivo,--CCR MODO MASIVO
        @i_val_masivo    = @i_val_masivo,--CCR MODO MASIVO
        @i_ActTot        = @i_ActTot,
        @i_canal         = @i_canal,
        @i_comision      = @i_comision,--REQ 203
        @i_causal        = @i_causal,--REQ 203,
        @i_remesas       = @i_remesas,
        @o_sldcont       = @w_sldcont out,
        @o_slddisp       = @w_slddisp out,
        @o_nombre        = @o_nombre out,
        @o_alerta_cli    = @o_alerta_cli out,
        @o_cedula        = @o_cedula out,
        @o_cliente       = @w_cliente out,
        @o_oficina_cta   = @w_oficina_cta out,
        @o_prod_banc     = @w_prod_banc out,
        @o_categoria     = @w_categoria out,
        @o_tipocta_super = @w_tipocta_super out,
        @o_clase_clte    = @w_clase_clte out,
        @o_comision      = @o_comision out,
        @o_valiva        = @o_valiva out

      if @w_return <> 0
        /* Si se presenta error por fondos insuficientes, cuenta cancelada o cuenta inactiva se registra rechazo */
        if @i_comision <> 0
           and (@w_return in (251007, 251033, 251057, 251058))
        begin
          exec cob_remesas..sp_re_rechazos
            @s_ofi      = @s_ofi,
            @t_trn      = @t_trn,
            @i_cta      = @i_cta,
            @i_modulo   = 4,
            @i_vlr_comi = @i_comision,
            @i_vlr_iva  = @o_valiva,
            @i_causal   = @w_return
        end
      return @w_return

      select
        @o_alerta_cli

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
          p_nombre = @o_nombre,
          p_cedula = @o_cedula
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
        p_cedula = @o_cedula,
        p_rssn = @s_ssn
      exec @w_return = cobis..sp_end_resubmit
    end

    /*  Transaccion remota:  Error */
    if @w_tipo = 'R'
    begin
	    select @w_error   = 201002
        goto ERROR
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
  
    if @i_batch = 'N'
    begin tran
  
    if @t_trn = 252
    begin
      /*  Transaccion monetaria */
      insert into cob_ahorros..ah_deposito
                  (secuencial,tipo_tran,oficina,usuario,terminal,
                   correccion,sec_correccion,reentry,origen,nodo,
                   fecha,cta_banco,efectivo,propios,locales,
                   signo,ot_plazas,remoto_ssn,moneda,saldo_lib,
                   control,fecha_efec,saldocont,saldodisp,oficina_cta,
                   prod_banc,categoria,ssn_branch,tipocta_super,turno,
                   hora,canal,cliente,clase_clte, origen_efectivo)
      values      (@p_lssn,@t_trn,@s_ofi,@s_user,@s_term,
                   @t_corr,@t_ssn_corr,@t_rty,'L',@w_server_rem,
                   @s_date,@i_cta,@i_val,@i_prop,@i_loc,
                   @w_signo,@i_plaz,@p_rssn,@i_mon,null,
                   null,null,@p_sldcont,@p_slddisp,@w_oficina_cta,
                   @w_prod_banc,@w_categoria,@s_ssn_branch,@w_tipocta_super,
                   @i_turno,getdate(),@i_canal,@w_cliente,@w_clase_clte, @i_remesas)

      if (@i_ActTot = 'S')
      begin
        -- Actualizacion de totales de cajero
        exec @w_return = cob_remesas..sp_upd_totales
          @i_ofi          = @s_ofi,
          @i_rol          = @i_turno,
          @i_user         = @s_user,
          @i_mon          = @i_mon,
          @i_trn          = @t_trn,
          @i_nodo         = @s_srv,
          @i_tipo         = 'L',
          @i_corr         = @t_corr,
          @i_efectivo     = @i_val,
          @i_cheque       = @i_prop,
          @i_chq_locales  = @i_loc,
          @i_chq_ot_plaza = @i_plaz,
          @i_ssn          = @s_ssn,
          @i_filial       = @i_filial,
          @i_idcaja       = @i_idcaja,
          @i_idcierre     = @i_idcierre,
          @i_saldo_caja   = @i_sld_caja
        if @w_return = 0
        begin
          -- Actualizacion de totales de servidor enviado (remoto)
          exec @w_return = cob_remesas..sp_upd_totales
            @i_ofi          = @w_oficina,
            @i_rol          = @i_turno,
            @i_user         = @s_srv,
            @i_mon          = @i_mon,
            @i_trn          = @t_trn,
            @i_nodo         = @w_server_rem,
            @i_tipo         = 'E',
            @i_corr         = @t_corr,
            @i_efectivo     = @i_val,
            @i_cheque       = @i_prop,
            @i_chq_locales  = @i_loc,
            @i_chq_ot_plaza = @i_plaz,
            @i_ssn          = @s_ssn,
            @i_filial       = @i_filial,
            @i_idcaja       = @i_idcaja,
            @i_idcierre     = @i_idcierre,
            @i_saldo_caja   = @i_sld_caja
          if @w_return = 0
          begin
		    if @i_batch = 'N'
            commit tran
            select
              'Nombre' = @p_nombre
            select
              'Cedula' = @p_cedula
            return 0
          end
          else
             return @w_return
        end
        else
          return @w_return
      end
      else
      begin
	    if @i_batch = 'N'
        commit tran
        return 0
      end
    end
    else if @t_trn = 253
        or @t_trn = 229
        or @t_trn = 2677
    begin
      /*  Transaccion monetaria */
      insert into cob_ahorros..ah_notcredeb
                  (secuencial,tipo_tran,oficina,usuario,terminal,
                   correccion,sec_correccion,reentry,origen,nodo,
                   fecha,cta_banco,indicador,remoto_ssn,moneda,
                   causa,saldo_lib,valor,control,fecha_efec,
                   signo,saldocont,saldodisp,departamento,oficina_cta,
                   concepto,estado,prod_banc,categoria,serial,
                   ssn_branch,tipocta_super,turno,ctabanco_dep,hora,
                   canal,cliente,clase_clte)
      values      (@p_lssn,@t_trn,@s_ofi,@s_user,@s_term,
                   @t_corr,@t_ssn_corr,@t_rty,'L',@w_server_rem,
                   @s_date,@i_cta,@i_ind,@p_rssn,@i_mon,
                   @i_cau,null,@i_val,@i_chqrem,null,
                   @w_signo,@p_sldcont,@p_slddisp,@i_dep,@w_oficina_cta,
                   @i_concep,@w_estado,@w_prod_banc,@w_categoria,@i_serial,
                   @s_ssn_branch,@w_tipocta_super,@i_turno,@i_boleta,getdate(),
                   @i_canal,@w_cliente,@w_clase_clte)

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

      if (@i_ActTot = 'S')
      begin
        -- Actualizacion de totales de cajero */
        exec @w_return = cob_remesas..sp_upd_totales
          @i_ofi          = @s_ofi,
          @i_rol          = @i_turno,
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
          @i_filial       = @i_filial,
          @i_idcaja       = @i_idcaja,
          @i_causa        = @i_cau,
          @i_idcierre     = @i_idcierre,
          @i_saldo_caja   = @i_sld_caja
        if @w_return = 0
        begin
          -- Actualizacion de totales de servidor enviado (remoto)
          exec @w_return = cob_remesas..sp_upd_totales
            @i_ofi          = @w_oficina,
            @i_rol          = @i_turno,
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
            @i_filial       = @i_filial,
            @i_idcaja       = @i_idcaja,
            @i_idcierre     = @i_idcierre,
            @i_causa        = @i_cau,
            @i_saldo_caja   = @i_sld_caja

          if @w_return = 0
          begin
		    if @i_batch = 'N'
            commit tran
            select
              'Nombre' = @p_nombre
            select
              'Cedula' = @p_cedula
            return 0
          end
          else
             return @w_return
        end
        else
          return @w_return
      end
      else
      begin
	    if @i_batch = 'N'
        commit tran
        return 0
      end
    end
  end

  return 0

ERROR:
if @i_batch = 'N'
begin
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = @w_error,
    @i_msg   = @w_mensaje,
	@i_sev   = @w_sev
end
return @w_error

go

