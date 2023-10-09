use cob_ahorros
go

/************************************************************************/
/*  Archivo:            tr_tot_ofi_adm_ah.sp                            */
/*  Stored procedure:   sp_tr_tot_ofi_adm_ah                            */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto: Cuentas de Ahorros                                        */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 20-Jun-1993                                     */
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
/*  por oficina. (Transaccion administrativa de cuentas de ahorros).    */
/*  270 = Consulta de totales de oficina(Transaccion administrativa)    */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  20/Jul/1993 P Mena      Emision inicial                             */
/*  12/Dic/1993 P Mena      Personalizacion para el Banco               */
/*                  de Credito                                          */
/*  26/Ene/1995 A Villarreal    Cambio en la presentacion en            */
/*                                      forma de GRID                   */
/*      02/Mayo/2016    Walther Toledo  Migración a CEN                 */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_tot_ofi_adm_ah')
  drop proc sp_tr_tot_ofi_adm_ah
go

create proc sp_tr_tot_ofi_adm_ah
(
  @s_ssn          int,
  @s_srv          varchar(30),
  @s_lsrv         varchar(30),
  @s_user         varchar(30),
  @s_sesn         int = null,
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
  @t_show_version bit = 0,
  @i_mon          tinyint,
  @i_ofi          smallint,
  @i_tran         smallint,

  /*  @i_tipo     char(1), */
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
    @w_sp_name = 'sp_tr_tot_ofi_adm_ah'

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
      i_mon = @i_mon,
      i_ofi = @i_ofi,
      i_tran = @i_tran,
      /*      i_tipo      = @i_tipo, */
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

  if @t_trn <> 270
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
                   of_oficina
                 from   cobis..cl_oficina
                 where  of_oficina = @i_ofi)
  begin
    /* No existe oficina */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101016
    return 1
  end

  /* if @i_tipo not in ('L', 'E', 'R')
  begin
    * No existe tipo de total de cajero *
     exec cobis..sp_cerror
         @t_debug     = @t_debug,
         @t_file      = @t_file,
         @t_from      = @w_sp_name,
         @i_num   = 201069
     return 1
  end */

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
      'NOMBRE DE TRANSACCION' = (select
                                   tn_descripcion
                                 from   cobis..cl_ttransaccion
                                 where  tn_trn_code = x.cj_transaccion),
      'NUMERO' = sum(cj_numero),
      'EFECTIVO' = sum(cj_efectivo),
      'CHEQUES PROPIOS ' = sum(cj_cheque),
      'CHEQUES LOCALES ' = sum(cj_chq_locales),
      'CHEQUES OTRAS PLAZAS' = sum(cj_chq_ot_plaza),
      'OTROS' = sum(cj_otros),
      'INTERESES' = sum(cj_interes),
      'AJUSTE DE INTERESES' = sum(cj_ajuste_int),
      'AJUSTE DE CAPITAL' = sum(cj_ajuste_cap),
      'TOTAL   ' = sum(cj_efectivo) + sum(cj_cheque) + sum(cj_chq_locales) + sum
                   (
                   cj_chq_ot_plaza)
                   + sum(cj_otros) + sum(cj_interes) + sum(cj_ajuste_int) + sum(
                   cj_ajuste_cap)
    from   cob_ahorros..ah_caja x,
           cob_ahorros..ah_trn_grupo
    where  cj_oficina     = @i_ofi
       and cj_moneda      = @i_mon
       and cj_transaccion > @i_tran
       and cj_transaccion = tg_transaccion
       and tg_grupo       = @i_grupo
    group  by cj_transaccion
    /*      and     cj_tipo = @i_tipo  */

    set rowcount 0
  end

  return 0

go

