/************************************************************************/
/*    Archivo:              ahtanuli.sp                                 */
/*    Stored procedure:     sp_anula_lib_ah                             */
/*    Base de datos:        cob_ahorros                                 */
/*    Producto: Cuentas de Ahorros                                      */
/*    Disenado por:  Mauricio Bayas/Sandra Ortiz                        */
/*    Fecha de escritura: 19-Feb-1993                                   */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                              PROPOSITO                               */
/*    Este programa realiza la transaccion de Anulacion libreta         */
/*    280 = Anulacion de libreta                                        */
/************************************************************************/
/*              PERSONALIZACION BANCO DE PRESTAMOS                      */
/*----------------------------------------------------------------------*/
/*      FECHA           AUTOR           RAZON                           */
/*    03/Jul/1995    E. Guerrero A.  Emision inicial                    */
/*    05/Ene/1996    D. Villafuerte  Control de Calidad                 */
/*    04/Oct/2000    X Gellibert     Optimizacion                       */
/*    02/May/2016    J. Calderon     Migración a CEN                    */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_anula_lib_ah')
  drop proc sp_anula_lib_ah
go

create proc sp_anula_lib_ah
(
  @s_ssn           int,
  @s_ssn_branch    int,
  @s_srv           varchar(30),
  @s_lsrv          varchar(30),
  @s_user          varchar(30),
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_org           char(1),
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint = 1,
  @s_org_err       char(1) = null,/* Origen de error:[A], [S] */
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint,
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_mon           tinyint,
  @i_tbloq         char(3) = null,
  @i_aut           descripcion,
  @i_causa         char(3),
  @i_filial        tinyint,
  @i_turno         smallint = null,
  @o_oficina_cta   smallint out,
  @o_prod_banc     smallint = null out,
  @o_categoria     char(1) = null out,
  @o_tipocta_super char(1) = null out
)
as
  declare
    @w_return             int,
    @w_sp_name            varchar(30),
    @w_cuenta             int,
    @w_est                char(1),
    @w_filial             tinyint,
    @w_num_bloqueos       smallint,
    @w_secuencial         int,
    @w_sec                int,
    @w_saldo_contable     money,
    @w_saldo_para_girar   money,
    @w_t1                 char(1),
    @w_t2                 char(1),
    @w_t3                 char(1),
    @w_tipo_ente          char(1),
    @w_rol_ente           char(1),
    @w_tipo_def           char(1),
    @w_personalizada      char(1),
    @w_numpubli           tinyint,
    @w_producto           tinyint,
    @w_default            int,
    @w_numlib             int,
    @w_valor_publicacion  money,
    @w_valor_comision     money,
    @w_valor_total        money,
    @w_disponible         money,
    @w_prom_disp          money,
    @w_promedio1          money,
    @w_reentry            descripcion,
    @w_clave1             int,
    @w_clave2             int,
    @w_oficina_cta        smallint,
    @w_sus_flag           tinyint,
    @w_val_mon            money,
    @w_val_ser            money,
    @w_sldcont            money,
    @w_slddisp            money,
    @w_nombre             varchar(30),
    @w_ncontrol           int,
    @w_lpend              int,
    @w_monto_imp          money,
    @w_tipo_exonerado_imp char(2)

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_anula_lib_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  if @i_turno is null
    select
      @i_turno = @s_rol

  if @t_trn not in (280)
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  select
    @w_cuenta = ah_cuenta,
    @w_est = ah_estado,
    @o_categoria = ah_categoria,
    @w_tipo_ente = ah_tipocta,
    @w_tipo_def = ah_tipo_def,
    @o_prod_banc = ah_prod_banc,
    @w_producto = ah_producto,
    @w_default = ah_default,
    @w_disponible = ah_disponible,
    @w_prom_disp = ah_prom_disponible,
    @w_promedio1 = ah_promedio1,
    @w_personalizada = ah_personalizada,
    @w_rol_ente = ah_rol_ente,
    @w_numlib = ah_numlib,
    @w_oficina_cta = ah_oficina,
    @o_tipocta_super = ah_tipocta_super
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta
     and ah_moneda    = @i_mon
  /* Chequeo de existencias */
  if @@rowcount <> 1
  begin
    /* No existe cuenta de ahorros */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251001
    return 1
  end

  select
    @o_oficina_cta = @w_oficina_cta

  /* Validaciones */
  if @w_est <> 'A'
  begin
    /* Cuenta no activa o cancelada */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251002
    return 1
  end

/* Transaccion de anulacion de libretas (280) */
/* Verificacion de que el tipo de bloqueo ingresado no se encuentre */
  /* vigente */

  if exists (select
               cb_tipo_bloqueo
             from   cob_ahorros..ah_ctabloqueada
             where  cb_cuenta       = @w_cuenta
                and cb_tipo_bloqueo = '3'
                and cb_estado       = 'V')
  begin
    if @i_tbloq = '3'
    begin
      /* Tipo de bloqueo no ha sido levantado previamente */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201054
      return 1
    end
    select
      @w_t3 = 'S'
  end
  else
    select
      @w_t3 = 'N'

  if exists (select
               cb_tipo_bloqueo
             from   cob_ahorros..ah_ctabloqueada
             where  cb_cuenta       = @w_cuenta
                and cb_tipo_bloqueo = '2'
                and cb_estado       = 'V')
  begin
    if @i_tbloq = '2'
    begin
      /* Tipo de bloqueo no ha sido levantado previamente */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201054
      return 1
    end
    select
      @w_t2 = 'S'
  end
  else
    select
      @w_t2 = 'N'

  if exists (select
               cb_tipo_bloqueo
             from   cob_ahorros..ah_ctabloqueada
             where  cb_cuenta       = @w_cuenta
                and cb_tipo_bloqueo = '1'
                and cb_estado       = 'V')
  begin
    if @i_tbloq = '1'
    begin
      /* Tipo de bloqueo no ha sido levantado previamente */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201054
      return 1
    end
    select
      @w_t1 = 'S'
  end
  else
    select
      @w_t1 = 'N'

  if @w_t3 = 'S'
  begin
    /* Cuenta esta bloqueada contra deposito y retiro */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201085
    return 1
  end

  if @w_t1 = 'S'
     and @w_t2 = 'S'
  begin
    /* Cuenta esta bloqueada contra deposito y retiro */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201085
    return 1
  end

  /* Calculo de los valores de seqnos */
  begin tran
  update cobis..cl_seqnos
  set    siguiente = siguiente + 4
  where  tabla = 'ah_lpendiente'

  select
    @w_lpend = siguiente - 3
  from   cobis..cl_seqnos
  where  tabla = 'ah_lpendiente'

  if @w_lpend >= 2147483637
  begin
    update cobis..cl_seqnos
    set    siguiente = 3
    where  tabla = 'ah_lpendiente'
    select
      @w_lpend = 0
  end
  commit tran

  /* Calcular N/D por comision y publicaciones si tiene fondos o no */
  select
    @w_numpubli = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'NPA'

  if @@rowcount <> 1
  begin
    -- PARAMETRO NO ENCONTRADO
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201196
    return 201196
  end

  begin tran
  update cobis..cl_seqnos
  set    siguiente = siguiente + 4
  where  tabla = 'ah_control'

  select
    @w_ncontrol = siguiente - 3
  from   cobis..cl_seqnos
  where  tabla = 'ah_control'

  if @w_ncontrol >= 9997
  begin
    update cobis..cl_seqnos
    set    siguiente = 3
    where  tabla = 'ah_control'
    select
      @w_ncontrol = 0
  end
  commit tran

  begin tran
  /* Encuentra el costo publicacion por anulacion de libreta  lgr
  exec @w_return = cob_remesas..sp_genera_costos
       @i_categoria            = @o_categoria,
    @i_tipo_ente            = @w_tipo_ente,
    @i_rol_ente             = @w_rol_ente,
    @i_tipo_def             = @w_tipo_def,
    @i_prod_banc            = @o_prod_banc,
    @i_producto             = @w_producto,
    @i_moneda               = @i_mon,
    @i_tipo                 = 'R',
    @i_codigo               = @w_default,
    @i_servicio             = 'ANUL',
    @i_rubro                = '26',
    @i_disponible           = @w_disponible,
    @i_prom_disp            = @w_prom_disp,
    @i_contable             = @w_saldo_contable,
    @i_promedio             = @w_promedio1,
    @i_valor                = 1,
    @i_personaliza          = @w_personalizada,
        @i_fecha                = @s_date, 
    @i_filial            = @i_filial,
        @i_oficina              = @w_oficina_cta,
    @o_valor_total          = @w_valor_publicacion out
    if @w_return <> 0
     return @w_return    */

  select
    @w_valor_publicacion = 0

  select
    @w_valor_publicacion = @w_valor_publicacion * @w_numpubli

  /* Nota de Debito por publicacion anulacion de libreta */
  if @w_valor_publicacion > 0
  begin
    exec @w_return = cob_ahorros..sp_ah_retndsl_locrem
      @s_ssn                = @s_ssn,
      @s_ssn_branch         = @s_ssn_branch,
      @s_lsrv               = @s_lsrv,
      @s_srv                = @s_srv,
      @s_user               = @s_user,
      @s_sesn               = @s_sesn,
      @s_term               = @s_term,
      @s_date               = @s_date,
      @s_ofi                = @s_ofi,
      @s_rol                = @s_rol,
      @s_sev                = @s_sev,
      @p_lssn               = 0,
      @t_corr               = 'N',
      @t_ssn_corr           = 0,
      @p_rssn_corr          = 0,
      @t_debug              = @t_debug,
      @t_file               = @t_file,
      @t_from               = @w_sp_name,
      @t_rty                = 'N',
      @s_org                = @s_org,
      @t_trn                = 264,
      @i_cod_alterno        = 1,
      @i_cta                = @i_cta,
      @i_mon                = @i_mon,
      @i_val                = @w_valor_publicacion,
      @i_ind                = 1,
      @i_cau                = '5',
      @i_dep                = null,
      @i_oficina            = @s_ofi,
      @i_lpend              = @w_lpend,
      @i_ncontrol           = @w_ncontrol,
      @i_ActTot             = 'N',
      @i_turno              = @i_turno,
      @o_sldcont            = @w_sldcont out,
      @o_slddisp            = @w_slddisp out,
      @o_val_ser            = @w_val_ser out,
      @o_val_mon            = @w_val_mon out,
      @o_sus_flag           = @w_sus_flag out,
      @o_nombre             = @w_nombre out,
      @o_monto_imp          = @w_monto_imp out,
      @o_tipo_exonerado_imp = @w_tipo_exonerado_imp out
    if @w_return <> 0
      return @w_return
  end

  /* Encuentra el costo comision por anulacion de libreta  */
  exec @w_return = cob_remesas..sp_genera_costos
    @i_categoria   = @o_categoria,
    @i_tipo_ente   = @w_tipo_ente,
    @i_rol_ente    = @w_rol_ente,
    @i_tipo_def    = @w_tipo_def,
    @i_prod_banc   = @o_prod_banc,
    @i_producto    = @w_producto,
    @i_moneda      = @i_mon,
    @i_tipo        = 'R',
    @i_codigo      = @w_default,
    @i_servicio    = 'ANUL',
    @i_rubro       = '25',
    @i_disponible  = @w_disponible,
    @i_prom_disp   = @w_prom_disp,
    @i_contable    = @w_saldo_contable,
    @i_promedio    = @w_promedio1,
    @i_valor       = 1,
    @i_personaliza = @w_personalizada,
    @i_fecha       = @s_date,
    @i_filial      = @i_filial,
    @i_oficina     = @w_oficina_cta,
    @o_valor_total = @w_valor_comision out
  if @w_return <> 0
    return @w_return

  /*  Generacion Nota de Debito por comision anulacion de libreta */
  if @w_valor_comision > 0
  begin
    select
      @w_lpend = @w_lpend + 2,
      @w_ncontrol = @w_ncontrol + 2

    exec @w_return = cob_ahorros..sp_ah_retndsl_locrem
      @s_ssn                = @s_ssn,
      @s_ssn_branch         = @s_ssn_branch,
      @s_lsrv               = @s_lsrv,
      @s_srv                = @s_srv,
      @s_user               = @s_user,
      @s_sesn               = @s_sesn,
      @s_term               = @s_term,
      @s_date               = @s_date,
      @s_ofi                = @s_ofi,
      @s_rol                = @s_rol,
      @s_sev                = @s_sev,
      @p_lssn               = 0,
      @t_corr               = 'N',
      @t_ssn_corr           = 0,
      @p_rssn_corr          = 0,
      @t_debug              = @t_debug,
      @t_file               = @t_file,
      @t_from               = @w_sp_name,
      @t_rty                = 'N',
      @s_org                = @s_org,
      @t_trn                = 264,
      @i_cod_alterno        = 2,
      @i_cta                = @i_cta,
      @i_mon                = @i_mon,
      @i_val                = @w_valor_comision,
      @i_ind                = 1,
      @i_cau                = '6',
      @i_dep                = null,
      @i_oficina            = @s_ofi,
      @i_lpend              = @w_lpend,
      @i_ncontrol           = @w_ncontrol,
      @i_ActTot             = 'N',
      @i_turno              = @i_turno,
      @o_sldcont            = @w_sldcont out,
      @o_slddisp            = @w_slddisp out,
      @o_val_ser            = @w_val_ser out,
      @o_val_mon            = @w_val_mon out,
      @o_sus_flag           = @w_sus_flag out,
      @o_nombre             = @w_nombre out,
      @o_monto_imp          = @w_monto_imp out,
      @o_tipo_exonerado_imp = @w_tipo_exonerado_imp out
    if @w_return <> 0
      return @w_return
  end

  /* Generacion del secuencial del bloqueo */
  exec @w_return = cobis..sp_cseqnos
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_tabla     = 'ah_ctabloqueada',
    @o_siguiente = @w_sec out
  if @w_return <> 0
    return @w_return

  select
    @w_num_bloqueos = ah_bloqueos + 1
  from   cob_ahorros..ah_cuenta
  where  ah_cuenta = @w_cuenta

/* Actualizacion de las tablas: ah_ctabloqueada y ah_cuenta */
  /* causa de bloqueo 9 anulacion de libreta / i_causa original EGA */
  insert into ah_ctabloqueada
              (cb_cuenta,cb_secuencial,cb_tipo_bloqueo,cb_fecha,cb_autorizante,
               cb_estado,cb_oficina,cb_causa,cb_hora,cb_solicitante)
  values      (@w_cuenta,@w_sec,@i_tbloq,@s_date,@i_aut,
               'V',@s_ofi,'9',getdate(),'ORDEN DEL CLIENTE')
  if @@error <> 0
  begin
    /* Error en creacion de registro en ah_ctabloqueada */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 203009
    return 1
  end

  update cob_ahorros..ah_cuenta
  set    ah_bloqueos = @w_num_bloqueos
  where  ah_cuenta = @w_cuenta
  if @@rowcount <> 1
  begin
    /* Error en actualizacion de registro en ah_cuenta */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 255001
    return 1
  end

  /* Creacion de transaccion de servicio */
  select
    @w_valor_total = @w_valor_publicacion + @w_valor_comision
  insert into cob_ahorros..ah_tsanulalib
              (secuencial,ssn_branch,tipo_transaccion,tsfecha,usuario,
               terminal,oficina,reentry,origen,cta_banco,
               tipo_bloqueo,fecha,moneda,autorizante,estado,
               causa,numlib,filial,valor,saldo,
               oficina_cta,prod_banc,categoria,tipocta_super,turno)
  values      (@s_ssn,@s_ssn_branch,@t_trn,@s_date,@s_user,
               @s_term,@s_ofi,@t_rty,@s_org,@i_cta,
               @i_tbloq,@s_date,@i_mon,@i_aut,'V',
               @i_causa,@w_numlib,@i_filial,@w_valor_total,@w_disponible,
               @w_oficina_cta,@o_prod_banc,@o_categoria,@o_tipocta_super,
               @i_turno)
  if @@error <> 0
  begin
    /* Error en creacion de transaccion de servicio */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 203005
    return 1
  end

  commit tran

  return 0

go

