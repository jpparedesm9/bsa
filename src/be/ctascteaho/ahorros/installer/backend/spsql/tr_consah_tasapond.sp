use cob_ahorros
go

/************************************************************************/
/*  Archivo:            tr_consah_tasapond.sp                           */
/*  Stored procedure:   sp_tr_consah_tasapond                           */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:               Cuentas de Ahorros                          */
/*  Disenado por:           Pedro Marroquin                             */
/*  Fecha de escritura:     27-Sept-2002                                */
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
/*  Consulta de información historica de totales por tasa de interes    */
/*                                                                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*      30/09/2002      PMA             Emision Inicial                 */
/*      02/Mayo/2016    Walther Toledo  Migración a CEN                 */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_consah_tasapond')
  drop proc sp_tr_consah_tasapond
go

create proc sp_tr_consah_tasapond
(
  @s_ssn          int,
  @s_srv          varchar(30) = null,
  @s_user         varchar(30) = null,
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char(1),
  @s_ofi          smallint,/* Localidad origen transaccion */
  @s_rol          smallint = 1,
  @s_org_err      char(1) = null,/* Origen de error:[A], [S] */
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_show_version bit = 0,
  @t_trn          smallint,
  @i_fecha_desde  smalldatetime,
  @i_fecha_hasta  smalldatetime,
  @i_prod_banc    smallint,
  @i_moneda       tinyint,
  @i_ult_fecha    smalldatetime,
  @i_ult_tasa     float,
  @i_modo         tinyint = 0
)
as
  declare
    @w_return  int,
    @w_sp_name varchar(30)

  /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_tr_consah_tasapond'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  if @t_trn <> 330
  begin
    -- Error en codigo de transaccion
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  if @i_modo = 0
  begin
    set rowcount 20

    select
      'FECHA'= convert(varchar(10), co_fecha, 103),
      'TASA' = co_tasa,
      'No CUENTAS' = sum(co_acreedoras),
      'MONTO' = sum(co_total_acreedoras),
      'VARIACION DIARIA' = '',
      'VARIACION ACUMULADA' = ''
    from   ah_consolidado
    where  co_fecha between @i_fecha_desde and @i_fecha_hasta
       and co_estado    <> 'C'
       and co_moneda    = @i_moneda
       and co_prod_banc = @i_prod_banc
    group  by co_fecha,
              co_tasa
    order  by co_fecha,
              co_tasa

    set rowcount 0
  end

  if @i_modo = 1
  begin
    set rowcount 20
    select
      'FECHA'= convert(varchar(10), co_fecha, 103),
      'TASA' = co_tasa,
      'No CUENTAS' = sum(co_acreedoras),
      'MONTO' = sum(co_total_acreedoras),
      'VARIACION DIARIA' = '',
      'VARIACION ACUMULADA' = ''
    from   ah_consolidado
    where  co_fecha between @i_fecha_desde and @i_fecha_hasta
       and co_estado    <> 'C'
       and co_moneda    = @i_moneda
       and co_prod_banc = @i_prod_banc
       and (co_fecha     > @i_ult_fecha
             or (co_fecha     = @i_ult_fecha
                 and co_tasa      > @i_ult_tasa))
    group  by co_fecha,
              co_tasa
    order  by co_fecha,
              co_tasa

    set rowcount 0
  end

  return 0

go

