use cob_ahorros
go

/****************************************************************************/
/*  Archivo:            tr_query_nom_ctahorro.sp                            */
/*  Stored procedure:   sp_tr_query_nom_ctahorro                            */
/*  Base de datos:          cob_ahorros                                     */
/*  Producto: Cuentas de Ahorros                                            */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                              */
/*  Fecha de escritura: 24-Nov-1993                                         */
/****************************************************************************/
/*                              IMPORTANTE                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad            */
/*  de COBISCorp.                                                           */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como        */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus        */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.       */
/*  Este programa esta protegido por la ley de   derechos de autor          */
/*  y por las    convenciones  internacionales   de  propiedad inte-        */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para     */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir            */
/*  penalmente a los autores de cualquier   infraccion.                     */
/****************************************************************************/
/*              PROPOSITO                                                   */
/*  Este programa realiza la transaccion de consulta del nombre             */
/*  de la cuenta de ahorros.                                                */
/****************************************************************************/
/*              MODIFICACIONES                                              */
/*      FECHA           AUTOR           RAZON                               */
/*  24/Nov/1993 P Mena      Emision inicial                                 */
/*  15/Jun/2006 P Coello    Añadir parametro para validacion de inactividad */
/*  26/Jun/2006 P Coello    Devolver el codigo de la patente                */
/*  28/Dic/2009 C. Munoz    Req FRC-AHO-003 BPT                             */
/*  21/Nov/2013     C. Avendaño Agregar var @i_corresponsal Req 381         */
/*  02/Mayo/2016     Walther Toledo      Migración a CEN                    */
/****************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_query_nom_ctahorro')
  drop proc sp_tr_query_nom_ctahorro
go

create proc sp_tr_query_nom_ctahorro
(
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_show_version bit = 0,
  @i_cta          cuenta,
  @i_mon          tinyint,
  @i_cerrada      char(1) = 'A',
  @i_libreta      char(1) = null,
  @i_cedruc       char(1) = null,
  @i_cliente      char(1) = 'N',
  @i_val_inac     char(1) = 'S',
  @i_operacion    char(1) = 'Q',
  @i_codcliente   int = null,
  @i_estado       char(1) = 'A',
  @i_ctaint       int = 0,
  @i_trn          varchar(10) = null,
  @s_ofi          smallint = null,

  /***************  REQ-381    ********************/
  @i_corresponsal char(1) = 'N',
  @o_fecha_aper   smalldatetime = null out,
  @o_titularidad  varchar(30) = null out,
  @o_nombre_cta   varchar(64) = null out,
  @o_patente_cta  varchar(40) = null out,
  @o_oficina      smallint = null out,
  @o_estado       char(1) = null out
)
as
  declare
    @w_return    int,
    @w_sp_name   varchar(30),
    @w_rpc       descripcion,
    @w_filial    tinyint,
    @w_oficina   smallint,
    @w_producto  tinyint,
    @w_srv_rem   descripcion,
    @w_srv_local descripcion,
    @w_tipo      char(1)

  -- Ver VSS 10 NR208

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_tr_query_nom_ctahorro'

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
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      i_cta = @i_cta,
      i_mon = @i_mon,
      i_libreta = @i_libreta,
      i_cedruc = @i_cedruc,
      i_cliente = @i_cliente,
      o_fecha_aper = @o_fecha_aper,
      o_titularidad = @o_titularidad,
      o_nombre_cta = @o_nombre_cta
    exec cobis..sp_end_debug
  end

  /* Valida el producto para la oficina */
  if isnull(@s_ofi,
            0) <> 0
  begin
    exec @w_return = cobis..sp_val_prodofi
      @i_modulo  = 4,
      @i_oficina = @s_ofi
    if @w_return <> 0
      return @w_return
  end

  /*  Captura de parametros de la oficina  */
  exec @w_return = cobis..sp_parametros
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @w_sp_name,
    @s_lsrv         = @s_lsrv,
    @i_nom_producto = 'CUENTA%AHORROS',
    --@o_filial     = @w_filial out,
    @o_oficina      = @w_oficina out,
    @o_producto     = @w_producto out
  --@o_server_local   = @w_srv_local
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
      tipo = @w_tipo,
      srv_loc = @w_srv_local,
      srv_rem = @w_srv_rem
    exec cobis..sp_end_debug
  end

  select
    @w_srv_local = @s_lsrv

  select
    @w_rpc = 'sp_query_nom_ctahorro'
  if @w_tipo = 'L'
    select
      @w_rpc = 'cob_ahorros..' + @w_rpc
  else
    select
      @w_rpc = @w_srv_local + '.' + @w_srv_rem + '.' + 'cob_ahorros.' + @w_rpc

  exec @w_return = @w_rpc
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @t_from,
    @i_cta          = @i_cta,
    @i_mon          = @i_mon,
    @i_cerrada      = @i_cerrada,
    @i_libreta      = @i_libreta,
    @i_cedruc       = @i_cedruc,
    @i_cliente      = @i_cliente,
    @i_operacion    = @i_operacion,
    @i_codcliente   = @i_codcliente,
    @i_estado       = @i_estado,
    @i_ctaint       = @i_ctaint,
    @i_trn          = @i_trn,
    @s_ofi          = @s_ofi,
    @i_val_inac     = @i_val_inac,
    @i_corresponsal = @i_corresponsal,
    @o_fecha_aper   = @o_fecha_aper out,
    @o_titularidad  = @o_titularidad out,
    @o_nombre_cta   = @o_nombre_cta out,
    @o_patente_cta  = @o_patente_cta out,
    @o_oficina      = @o_oficina out,
    @o_estado       = @o_estado out
  if @w_return <> 0
  begin
    rollback tran
    return @w_return
  end
  return 0

go

