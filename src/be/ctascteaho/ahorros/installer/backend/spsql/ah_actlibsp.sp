/************************************************************************/
/*  Archivo:            ah_aclisp.sp                                    */
/*  Stored procedure:   sp_ah_actlibsp                                  */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 19-Feb-1993                                     */
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
/*      Actualizacion de Lineas Pendientes.                             */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA         AUTOR         RAZON                                   */
/*  19/Feb/1993   J Navarrete   Emision inicial                         */
/*  02/Mayo/2016  Ignacio Yupa  Migración a CEN                         */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_actlibsp')
  drop proc sp_ah_actlibsp
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_actlibsp
(
  @s_ssn          int,
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
  @p_sp           char(1) = 'N',  
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_cta          cuenta,
  @i_sld_lib      money,
  @i_nctrl        int,
  @i_mon          tinyint,
  @i_usateller    char(1)='N',
  @o_sldlib       money=null out,
  @o_num          int= null out,
  @o_nctrl        smallint= null out
)
as
  declare
    @w_return       int,
    @w_sp_name      varchar(30),
    @w_cuenta       int,
    @w_error        int,
    @w_filial       tinyint,
    @w_oficina      smallint,
    @w_oficial      tinyint,
    @w_filial_p     tinyint,
    @w_oficina_p    smallint,
    @w_producto     tinyint,
    @w_server_rem   descripcion,
    @w_server_local descripcion,
    @w_rpc          descripcion,
    @w_tipo         char(1),
    @w_nodo         varchar(30),
    @w_msg          varchar(30),
    @w_num          int,
    @w_origen       char(1),
    @w_remoto_ssn   int,
    @w_rssn_corr    int,
    @w_secuencial   int,
    @w_ssn_corr     int,
    @w_factor       int

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_actlibsp'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
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
      t_from = @t_from,
      t_file = @t_file,
      t_trn = @t_trn,
      i_cta_banco = @i_cta,
      i_sld_lib = @i_sld_lib,
      i_nctrl = @i_nctrl,
      i_mon = @i_mon
    exec cobis..sp_end_debug
  end

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
    @w_rpc = 'cob_ahorros.sp_actualizacion_libreta'
  if @w_tipo = 'L'
    select
      @w_rpc = 'cob_ahorros..sp_actualizacion_libreta'
  else if @w_tipo = 'R'
    select
      @w_rpc = @w_server_local + '.' + @w_server_rem + '.' + @w_rpc

  /*  Transaccion generada por usuario  */
  if @s_org = 'U'
  begin
    exec @w_return = @w_rpc
      @s_ssn       = @s_ssn,
      @s_srv       = @s_srv,
      @s_user      = @s_user,
      @s_sesn      = @s_sesn,
      @s_term      = @s_term,
      @s_date      = @s_date,
      @s_sev       = @s_sev,
      @s_org       = @s_org,
      @s_ofi       = @s_ofi,
      @s_rol       = @s_rol,
      @p_sp        = @p_sp,
      @t_debug     = @t_debug,
      @t_from      = @w_sp_name,
      @t_file      = @t_file,
      @t_trn       = @t_trn,
      @i_cta       = @i_cta,
      @i_sld_lib   = @i_sld_lib,
      @i_nctrl     = @i_nctrl,
      @i_mon       = @i_mon,
      @i_usateller = @i_usateller,
      @o_sldlib    = @o_sldlib out,
      @o_num       = @o_num out,
      @o_nctrl     = @o_nctrl out
    return @w_return
  end

go

