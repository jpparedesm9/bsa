/************************************************************************/
/*  Archivo:            ah_cototdev.sp                                  */
/*  Stored procedure:   sp_ah_cototdev                                  */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 11-Jun-1993                                     */
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
/*  Este programa realiza la transaccion de consulta de totales         */
/*  por cajero. (Transaccion administrativa de cuentas de ahorros).     */
/*  291 = Consulta de totales de cajero (Transaccion administrativa)    */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR         RAZON                                     */
/*  11/Jun/1993 P Mena        Emision inicial                           */
/*  12/Dic/1993 P Mena        Personalizacion para el Banco             */
/*                            de Credito                                */
/*  26/Ene/1995 A Villarreal  Despliegue mediante GRID                  */
/*  02/May/2016 Ignacio Yupa  Migración a CEN                           */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_cototdev')
  drop proc sp_ah_cototdev
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_cototdev
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
  @t_corr         char(1) = 'N',
  @t_ssn_corr     int = null,/* Trans a ser reversada */
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_show_version bit= 0,
  @i_mon          tinyint,
  @i_caj          descripcion,
  @i_rol          smallint,
  @i_ofi          smallint,
  @i_tran         smallint,
  @i_proc         char(1),
  @i_grupo        tinyint
)
as
  declare
    @w_return       int,
    @w_sp_name      varchar(30),
    @w_filial       tinyint,
    @w_oficina      smallint,
    @w_oficial      tinyint,
    @w_producto     tinyint,
    @w_server_rem   descripcion,
    @w_server_local descripcion,
    @w_tipo         char(1)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_cototdev'

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
      t_corr = @t_corr,
      t_ssn_corr = @t_ssn_corr,
      t_from = @t_from,
      t_file = @t_file,
      t_rty = @t_rty,
      t_trn = @t_trn,
      i_mon = @i_mon,
      i_caj = @i_caj,
      i_ofi = @i_ofi,
      i_rol = @i_rol,
      i_tran = @i_tran,
      i_proc = @i_proc,
      i_grupo = @i_grupo
    exec cobis..sp_end_debug
  end

  exec @w_return = cobis..sp_parametros
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @w_sp_name,
    @s_lsrv         = @s_lsrv,
    @i_nom_producto = 'CUENTA%AHORROS',
    @o_filial       = @w_filial out,
    @o_oficina      = @w_oficina out,
    @o_producto     = @w_producto out,
    @o_server_local = @w_server_local
  if @w_return <> 0
    return @w_return

  select
    @w_server_local = @s_lsrv

  /* Inicia el proceso para obtencion de la consulta */

  if @t_trn <> 291
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  if not exists (select
                   cj_operador
                 from   cob_ahorros..ah_caja
                 where  cj_oficina  = @i_ofi
                    and cj_operador = @i_caj
                    and cj_rol      = @i_rol)
  begin
    /* Cajero no registrado en esta oficina */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201063
    return 1
  end

  if @i_proc = 'G'
      or @i_proc = 'P'
  begin
    set rowcount 1

    select
      tg_grupo,
      gr_descripcion
    from   cob_ahorros..ah_trn_grupo,
           cob_ahorros..ah_grupo
    where  tg_grupo > @i_grupo
       and tg_grupo = gr_grupo

    if @i_proc = 'P'
      select
        'Trans' = cj_transaccion,
        'NOMBRE DE TRANSACCION' = cj_transaccion,
        'No.' = cj_numero,
        'EFECTIVO        ' = cj_efectivo,
        'CHEQUES PROPIOS ' = cj_cheque,
        'CHEQUES LOCALES ' = cj_chq_locales,
        'CHEQUES PLAZAS  ' = cj_chq_ot_plaza,
        'OTROS           ' = cj_otros,
        'INTERESES       ' = cj_interes,
        'AJUSTE INTERESES' = cj_ajuste_int,
        'AJUSTE CAPITAL  ' = cj_ajuste_cap,
        'TOTAL           ' = cj_efectivo
      from   cob_ahorros..ah_caja

    set rowcount 0
  end
  else
  begin
    set rowcount 20

    /* Envio de resultados al Front End */
    select
      'TRANS ' = cj_transaccion,
      'NOMBRE DE TRANSACCION' = tn_descripcion,
      'NUMERO' = cj_numero,
      'EFECTIVO' = cj_efectivo,
      'CHEQUES PROPIOS ' = cj_cheque,
      'CHEQUES LOCALES ' = cj_chq_locales,
      'CHEQUES OTRAS PLAZAS' = cj_chq_ot_plaza,
      'OTROS' = cj_otros,
      'INTERESES' = cj_interes,
      'AJUSTE DE INTERESES' = cj_ajuste_int,
      'AJUSTE DE CAPITAL' = cj_ajuste_cap,
      'TOTAL   ' = cj_efectivo + cj_cheque + cj_chq_locales + cj_chq_ot_plaza +
                   cj_otros +
                   cj_interes + cj_ajuste_int
                   + cj_ajuste_cap
    from   cob_ahorros..ah_caja,
           cobis..cl_ttransaccion,
           cob_ahorros..ah_trn_grupo
    where  cj_oficina     = @i_ofi
       and cj_moneda      = @i_mon
       and cj_rol         = @i_rol
       and cj_operador    = @i_caj
       and cj_transaccion > @i_tran
       and cj_transaccion = tg_transaccion
       and tg_grupo       = @i_grupo
       and tn_trn_code    = cj_transaccion

    set rowcount 0
  end

  return 0

go

