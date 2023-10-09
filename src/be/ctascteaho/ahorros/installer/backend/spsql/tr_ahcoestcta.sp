use cob_ahorros
go

/************************************************************************/
/*  Archivo:            tr_ahcoestcta.sp                                */
/*  Stored procedure:   sp_tr_ahcoestcta                                */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto: Cuentas de Ahorros                                        */
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
/*  Este programa procesa la transaccion de:                            */
/*      Consulta de estado de cuenta por fechas                         */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  10/Dic/1993 J Navarrete     emision inicial                         */
/*      20/Dic/1994     J. Bucheli      Personalizacion para Banco de   */
/*                                      la Produccion                   */
/*      08/Nov/1995     A. Villarreal   Correccion de errores           */
/*      26/Oct/2001     C. Vargas       Agregar param. @i_formato_fecha */
/*      06/May/2006     P. Coello       Agregar param. @i_hora          */
/*      31/ENE/2007     P. Coello       Agregar operacion para consulta */
/*                                      especifica de movimiento        */
/*      02/Mayo/2016    Walther Toledo  Migración a CEN                 */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_ahcoestcta')
  drop proc sp_tr_ahcoestcta
go

create proc sp_tr_ahcoestcta
(
  @s_ssn           int,
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
  @i_inforcuenta   char(1) = 'N',
  @i_frontn        char(1) = 'N',
  @i_formato_fecha int = null,
  @i_escliente     char(1) = 'N',
  @i_operacion     char(1) = 'C',

  --PCOELLO SE A-ADE LA OPERAION POR QUE SE VA A CONSULTAR EN ESTE MISMO SP EL DETALLE DE UN MOVIMIENTO ESPECIFICO
  @o_hist          tinyint out,
  @o_sec           int =null out,
  @o_secalt        int =null out,
  @o_hora          smalldatetime =null out,
  @i_hora          smalldatetime= null
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
    @w_fchhsta      varchar(10),
	@w_estado       varchar(10)
    
  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_tr_ahcoestcta'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
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
      p_envio = @p_envio,
      p_rpta = @p_rpta,
      i_cta_banco = @i_cta,
      i_fchdsde = @i_fchdsde,
      i_fchhsta = @i_fchhsta,
      i_sec = @i_sec,
      i_mon = @i_mon,
      i_diario = @i_diario,
      i_inforcuenta = @i_inforcuenta,
      i_frontn = @i_frontn,
      o_hist = @o_hist
    exec cobis..sp_end_debug
  end

  /* VALIDA CUENTA */
  select @w_producto = C.codigo
from   cobis..cl_tabla T, cobis..cl_catalogo C
where  T.tabla = 're_pro_banc_cb'
and    T.codigo = C.tabla
and    C.estado = 'V'

  if @i_cta is not null
  begin
	if not exists( select 1 from cob_ahorros..ah_cuenta
                         where ah_cta_banco = @i_cta
                         and   ah_prod_banc <> @w_producto)
           begin
               /* No existe cuenta_banco */
               exec cobis..sp_cerror
               @t_debug     = @t_debug,
               @t_file      = @t_file,
               @t_from      = @w_sp_name,
               @i_num       = 251001,
               @i_sev       = 0,
               @i_msg       = 'No existe cuenta de ahorros'
               return 251001
           end
  end

  select @w_estado = upper(ah_estado)
         from cob_ahorros..ah_cuenta
         where ah_cta_banco = @i_cta
  
  if @w_estado = 'I'
  begin
	 exec cobis..sp_cerror
               @t_debug     = @t_debug,
               @t_file      = @t_file,
               @t_from      = @w_sp_name,
               @i_num       = 50000,
               @i_sev       = 0,
               @i_msg       = 'CUENTA DE AHORROS INACTIVA'
     return 50000
  end
  /* Valida datos de entrada */
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
  select
    @w_fchdsde = convert(varchar(10), @i_fchdsde, 101)
  select
    @w_fchhsta = convert(varchar(10), @i_fchhsta, 101)

  select
    @w_rpc = 'cob_ahorros.sp_ah_consulta_estado_cuenta'
  if @w_tipo = 'L'
    select
      @w_rpc = 'cob_ahorros..sp_ah_consulta_estado_cuenta'
  else if @w_tipo = 'R'
    select
      @w_rpc = @w_server_local + '.' + @w_server_rem + '.' + @w_rpc
  /*  Transaccion generada por usuario  */
  if @s_org = 'U'
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
      @i_inforcuenta   = @i_inforcuenta,
      @i_frontn        = @i_frontn,
      @i_formato_fecha = @i_formato_fecha,
      @i_escliente     = @i_escliente,
      @i_operacion     = @i_operacion,
      --PCOELLO SE A-ADE LA OPERAION POR QUE SE VA A CONSULTAR EN ESTE MISMO SP EL DETALLE DE UN MOVIMIENTO ESPECIFICO
      @o_hist          = @o_hist out,
      @o_sec           =@o_sec out,  
      @o_hora         =@o_hora out,
      @i_hora          = @i_hora --PCOELLO MODIFICACION DE ORDENAMIENTO
    return @w_return
  end

  return 0

go