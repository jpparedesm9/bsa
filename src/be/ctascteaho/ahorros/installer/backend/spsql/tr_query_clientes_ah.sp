use cob_ahorros
go

/************************************************************************/
/*  Archivo:            tr_query_clientes_ah.sp                         */
/*  Stored procedure:   sp_tr_query_clientes_ah                         */
/*      Base de datos:          cob_ahorros                             */
/*      Producto: Cuentas Corrientes                                    */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
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
/*              PROPOSITO                                               */
/*  Este programa realiza la transaccion de consulta de clientes        */
/*  para un numero de cuenta dado.                                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*      FECHA           AUTOR           RAZON                           */
/*  10/Feb/1993 P Mena         Emision inicial                          */
/*      12/12/2006      R Linares      PARA VALIDAR O NO LA INACTIVIDAD */
/*      02/Mayo/2016    Walther Toledo Migración a CEN                  */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_query_clientes_ah')
  drop proc sp_tr_query_clientes_ah
go

create proc sp_tr_query_clientes_ah
(
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_show_version bit = 0,
  @t_from         varchar(32) = null,
  @i_cta          cuenta,
  @i_mon          tinyint,
  @i_cerrada      char(1) = 'A',
  @i_val_inac     char(1) = 'S',--PARA VALIDAR O NO LA INACTIVIDAD
  @i_corresponsal char(1) = 'N' --Req. 381 CB Red Posicionada

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

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_tr_query_clientes_ah'

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
      i_mon = @i_mon
    exec cobis..sp_end_debug
  end

  /*  Captura de parametros de la oficina  */
  exec @w_return = cobis..sp_parametros
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @w_sp_name,
    @s_lsrv         = @s_lsrv,
    @i_nom_producto = 'CUENTA%AHORROS',
    --@o_filial       = @w_filial out,
    @o_oficina      = @w_oficina out,
    @o_producto     = @w_producto out
  --@o_server_local = @w_srv_local
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
    @w_rpc = 'sp_query_clientes_ah'
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
    @i_val_inac     = @i_val_inac,
    @i_corresponsal = @i_corresponsal

  if @w_return <> 0
  begin
    rollback tran
    return @w_return
  end
  return 0

go

