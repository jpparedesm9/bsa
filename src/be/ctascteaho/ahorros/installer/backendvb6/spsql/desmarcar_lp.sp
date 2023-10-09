/********************************************************************/
/*  Archivo:            desmarcar_lp.sp                             */
/*  Stored procedure:   sp_desmarcar_lp                             */
/*  Base de datos:      cob_ahorros                                 */
/*  Producto:           Cuentas de Ahorros                          */
/*  Disenado por:                                                   */
/*  Fecha de escritura: 18-Feb-1993                                 */
/********************************************************************/
/*                         IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*  de COBISCorp.                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno  de sus        */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*  Este programa esta protegido por la ley de derechos de autor    */
/*  y por las convenciones  internacionales de propiedad inte-      */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*  penalmente a los autores de cualquier infraccion.               */
/********************************************************************/
/*                          PROPOSITO                               */
/*  Este programa realiza la transaccion de consulta de bloqueos    */
/*  contra valores de cuentas de ahorros.                           */
/*  241 = Consulta de lineas pendientes de cuentas de ahorros.      */
/********************************************************************/
/*                         MODIFICACIONES                           */
/*  FECHA           AUTOR           RAZON                           */
/*  22/Nov/1994     V Alvarez       Emision inicial                 */
/*  17/May/2006     P. Coello       Aumentar Fecha de la linea      */
/*  03/May/2016     J. Salazar      Migracion COBIS CLOUD MEXICO    */
/********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_desmarcar_lp')
  drop proc sp_desmarcar_lp
go

/****** Object:  StoredProcedure [dbo].[sp_desmarcar_lp]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_desmarcar_lp
(
  @s_ssn          int,
  @s_srv          varchar(30),
  @s_lsrv         varchar(30),
  @s_user         varchar(30),
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_ofi          smallint,/* Localidad origen transaccion */
  @s_rol          smallint = 1,
  @s_org_err      char(1) = null,/* Origen de ERROR: [A], [S] */
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @s_org          char(1),
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_cta          cuenta,
  @i_mon          tinyint,
  @i_linea        int,
  @i_sldlib       money,
  @i_nctrl        smallint,
  @i_numlin       smallint,
  @i_fecha        datetime --PCOELLO CONSIDERAR FECHA
)
as
  declare
    @w_return    int,
    @w_sp_name   varchar(30),
    @w_rpc       descripcion,
    @w_cuenta    int,
    @w_filial    tinyint,
    @w_oficina   smallint,
    @w_producto  tinyint,
    @w_srv_rem   descripcion,
    @w_srv_local descripcion,
    @w_tipo      char(1)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_desmarcar_lp'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
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
      t_rty = @t_rty,
      t_trn = @t_trn,
      i_cta = @i_cta,
      i_mon = @i_mon,
      i_linea = @i_linea,
      i_sldlib = @i_sldlib,
      i_nctrl = @i_nctrl,
      i_numlin = @i_numlin
    exec cobis..sp_end_debug
  end

  /* Chequeo de errores generados remotamente */
  if @s_org_err is not null /* Error del Sistema */
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

  /*  Captura de parametros de la oficina  */
  exec @w_return = cobis..sp_parametros
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @w_sp_name,
    @s_lsrv         = @s_lsrv,
    @i_nom_producto = 'CUENTA%AHORROS',
    @o_filial       = @w_filial out,
    @o_oficina      = @w_oficina out,
    @o_producto     = @w_producto out,
    @o_server_local = @w_srv_local
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
    @o_srv_local = @w_srv_local out,
    @o_srv_rem   = @w_srv_rem out

  if @w_return <> 0
    return @w_return

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      origen = @s_org,
      tipo = @w_tipo,
      srv_loc = @w_srv_local,
      srv_rem = @w_srv_rem
    exec cobis..sp_end_debug
  end

  select
    @w_srv_local = @s_lsrv

  select
    @w_rpc = 'sp_desmarcar_linea'
  if @w_tipo = 'L'
    select
      @w_rpc = 'cob_ahorros..' + @w_rpc
  else
    select
      @w_rpc = @w_srv_local + '.' + @w_srv_rem + '.' + 'cob_ahorros.' + @w_rpc

  exec @w_return = @w_rpc
    @s_ssn     = @s_ssn,
    @s_date    = @s_date,
    @s_sesn    = @s_sesn,
    @s_org     = @s_org,
    @s_srv     = @s_srv,
    @s_user    = @s_user,
    @s_term    = @s_term,
    @s_ofi     = @s_ofi,
    @s_rol     = @s_rol,
    @s_org_err = @s_org_err,
    @s_error   = @s_error,
    @s_sev     = @s_sev,
    @s_msg     = @s_msg,
    @t_debug   = @t_debug,
    @t_file    = @t_file,
    @t_from    = @t_from,
    @t_rty     = @t_rty,
    @t_trn     = @t_trn,
    @i_cta     = @i_cta,
    @i_mon     = @i_mon,
    @i_linea   = @i_linea,
    @i_sldlib  = @i_sldlib,
    @i_nctrl   = @i_nctrl,
    @i_numlin  = @i_numlin,
    @i_fecha   = @i_fecha --PCOELLO CONSIDERAR FECHA

  if @w_return <> 0
  begin
    rollback tran
    return @w_return
  end

  return 0

go

