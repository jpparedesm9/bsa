use cob_ahorros
go

/************************************************************************/
/*  Archivo:            tr_ahsoestcta.sp                                */
/*  Stored procedure:   sp_tr_ahsoestcta                                */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto: Cuentas de ahorros                                        */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 10-Dic-1993                                     */
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
/*  Consulta de estados de cuenta por fechas (1)                        */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  10/Dic/1993 J Navarrete Emision inicial                             */
/*      23/Oct/2001     C. Vargas       Agregar param. @i_formato_fecha */
/*      05/May/2006     P. Coello       Agregar param. @i_hora          */
/*      02/Mayo/2016    Walther Toledo  Migración a CEN                 */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_ahsoestcta')
  drop proc sp_tr_ahsoestcta
go

create proc sp_tr_ahsoestcta
(
  @s_ssn           int,
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
  @t_show_version  bit = 0,
  @p_lssn          int = null,
  @p_rssn          int = null,
  @p_rssn_corr     int = null,
  @p_envio         char(1) = 'N',
  @p_rpta          char(1) = 'N',
  @i_cta           cuenta,
  @i_fchdsde       datetime,
  @i_fchhsta       datetime,
  @i_sec           int = 0,
  @i_sec_alt       int = 0,
  @i_mon           tinyint,
  @i_diario        tinyint,
  @i_frontn        char(1) = 'N',
  @i_formato_fecha int = null,
  @i_hora          smalldatetime = null,
  @i_paso_impmas   tinyint = 1,
  @i_tipoenvio     char(1) = null,
  @i_escliente     char(1) = 'N',
  @i_envio_mail    char(1) = 'N',
  @i_email         varchar(255) = null,
  @i_concepto      varchar(120) = '',
  @o_hist          tinyint out
)
as
  declare
    @w_return       int,
    @w_sp_name      varchar(30),
    @w_filial       tinyint,
    @w_oficina      smallint,
    @w_producto     tinyint,
    @w_server_rem   descripcion,
    @w_server_local descripcion,
    @w_rpc          descripcion,
    @w_tipo         char(1),
    @w_fchdsde      varchar(10),
    @w_fchhsta      varchar(10)

  -- Captura nombre de Stored Procedure
  select
    @w_sp_name = 'sp_tr_ahsoestcta'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  -- Valida datos de entrada
  if @i_fchdsde > @i_fchhsta
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201065
    return 1
  end

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

  -- Determinacion de condicion de local o remoto
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

  select
    @w_fchdsde = convert(varchar(10), @i_fchdsde, 101)
  select
    @w_fchhsta = convert(varchar(10), @i_fchhsta, 101)

  select
    @w_rpc = 'cob_ahorros.sp_ah_solicitud_estado_cuenta'
  if @w_tipo = 'L'
    select
      @w_rpc = 'cob_ahorros..sp_ah_solicitud_estado_cuenta'
  else if @w_tipo = 'R'
    select
      @w_rpc = @w_server_local + '.' + @w_server_rem + '.' + @w_rpc

  -- Transaccion generada por usuario
  if @s_org = 'U'
  begin
    if @i_envio_mail = 'N'
    begin
      exec @w_return = @w_rpc
        @s_ssn           = @s_ssn,
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
        @t_trn           = @t_trn,
        @p_rssn_corr     = @p_rssn_corr,
        @s_org           = @s_org,
        @i_cta           = @i_cta,
        @i_fchdsde       = @w_fchdsde,
        @i_fchhsta       = @w_fchhsta,
        @i_sec           = @i_sec,
        @i_sec_alt       = @i_sec_alt,
        @i_mon           = @i_mon,
        @i_diario        = @i_diario,
        @i_frontn        = @i_frontn,
        @i_formato_fecha = @i_formato_fecha,
        @i_hora          = @i_hora,
        @i_paso_impmas   = @i_paso_impmas,
        @i_tipoenvio     = @i_tipoenvio,
        @i_escliente     = @i_escliente,
        @i_concepto      = @i_concepto,
        @o_hist          = @o_hist out
      return @w_return
    end
    else
    begin
      exec @w_return = sp_genera_ext_ah_pdf
        @s_ssn           = @s_ssn,
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
        @t_trn           = @t_trn,
        @p_rssn_corr     = @p_rssn_corr,
        @s_org           = @s_org,
        @i_cta           = @i_cta,
        @i_fchdsde       = @w_fchdsde,
        @i_fchhsta       = @w_fchhsta,
        @i_mon           = @i_mon,
        @i_formato_fecha = @i_formato_fecha,
        @i_escliente     = @i_escliente,
        @i_email         = @i_email,
        @i_concepto      = @i_concepto
      return @w_return
    end
  end

go

