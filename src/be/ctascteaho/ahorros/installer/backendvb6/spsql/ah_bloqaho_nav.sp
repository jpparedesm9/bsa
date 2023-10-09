/************************************************************************/
/*      Archivo:                ah_bloqaho_nav.sp                       */
/*      Stored procedure:       sp_ah_bloqaho_nav                       */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Fecha de escritura:     23-Mar-2005                             */
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
/*                              PROPOSITO                               */
/*      Consulta las cuentas de Navidad que han completado un porcentaje*/
/*      dado y permite el bloqueo de los pagos de las cuotas y levantm  */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      23/Mar/2005     D. Alvarez      Emision inicial                 */
/*      02/Mayo/2016    Ignacio Yupa    Migración a CEN                 */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_bloqaho_nav')
  drop proc sp_ah_bloqaho_nav
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_bloqaho_nav
(
  @s_ssn          int,
  @s_srv          varchar(30),
  @s_user         varchar(30),
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char(1),
  @s_ofi          smallint,/* Localidad origen transaccion */
  @s_rol          smallint,
  @s_org_err      char(1) = null,/* Origen de error:[A], [S] */
  @s_error        int = null,
  @s_sev          tinyint = null,  
  @t_trn          smallint,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_show_version bit = 0,
  @i_cuota        tinyint,
  @i_ach          char(1) = null,
  @i_suc          smallint = null,
  @i_relacion     smallint = null,
  @i_cuenta       char(20) = null,
  @i_cta          char(20) = null,
  @i_tipo         char(1)
)
as
  declare
    @w_return      int,
    @w_sp_name     varchar(30),
    @w_msg         char(60),
    @w_relacion    smallint,
    @w_semanas     tinyint,
    @w_week_year   tinyint,
    @w_per_inicial datetime,
    @w_estado      char(1),
    @w_cuenta_int  int

  /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_ah_bloqaho_nav'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_tipo = 'U'
      or @i_tipo = 'D'
  begin
    select
      @w_cuenta_int = ah_cuenta
    from   ah_cuenta
    where  ah_cta_banco = @i_cuenta

    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251001,
        @i_sev   = 0,
        @i_msg   = 'No existe cuenta de ahorros navidad'
      return 251001
    end
  end

  select
    @w_per_inicial = dateadd(yy,
                             datediff(yy,
                                      pa_datetime,
                                      @s_date) - 1,
                             pa_datetime)
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'FEIACN'
  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 253070,
      @i_msg   = 'PARAMETRO DE INICIO DE APERTURA DE CTA DE NAVIDAD, NO EXISTE'
    return 253070
  end

  select
    @w_semanas = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'SECOCN'
  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 253070,
      @i_msg   = 'PARAMETRO DE SEMANAS COMPLETAS DE NAVIDAD, NO EXISTE'
    return 253070
  end

  select
    @w_week_year = datepart(wk,
                            @s_date)

  if @i_tipo = '%'
    select
      convert(float, @w_week_year) / @w_semanas,
      @w_week_year

  /* Envio de resultados al Front End */

  if @i_tipo = 'Q'
  begin
    set rowcount 25
    select
      'Sucursal' = ah_oficina,
      'Cuenta' = ah_cta_banco,
      'Nombre' = ah_nombre,
      '% Completo' = 100 * (floor((ah_disponible + ah_12h + ah_24h + ah_remesas)
                                  /
                                                 convert(int, cn_cuota))) /
                     @w_semanas,
      'Saldo' = ah_disponible + ah_12h + ah_24h + ah_remesas,
      'Cuota' = convert(money, cn_cuota),
      '# Cuotas' = convert(int, floor((ah_disponible + ah_12h + ah_24h +
                                       ah_remesas)
                                      /
                                                   convert(int, cn_cuota))),
      'C. Retraso' = case
                       when @w_week_year - convert(int, floor((
                                           ah_disponible + ah_12h
                                           + ah_24h +
                                           ah_remesas)
                                                 /
                                           convert(int, cn_cuota)
                                                        ))
                            > 0 then
                       @w_week_year - convert(int, floor((ah_disponible + ah_12h
                                                          +
                                                          ah_24h +
                                                          ah_remesas)
                                                         /
                     convert(int, cn_cuota
                     )))
                       else 0
                     end,
      'X Completar' = convert(int, cn_cuota) * @w_semanas - (
                      ah_disponible + ah_12h + ah_24h + ah_remesas),
      'Cuota G.' = isnull(cn_cuota_gratis,
                          'N'),
      'Fecha Pago' = convert(char(11), cn_fecha_cuota, 106) -- Columna 11
    from   cob_ahorros..ah_cuenta_navidad,
           cob_ahorros..ah_cuenta
    where  cn_fecha_cierre is null
       and cn_cuenta
           = ah_cuenta
       and cn_fecha_apertura
           > @w_per_inicial
       and 100 * (floor((ah_disponible + ah_12h + ah_24h + ah_remesas) /
                            convert(int, cn_cuota))) / @w_semanas <= @i_cuota
       and ah_cta_banco
           > @i_cuenta
    order  by ah_cta_banco

    if @@rowcount = 0
      return 1
  end

  if @i_tipo = 'U'
  begin
    if exists(select
                1
              from   ah_cuenta_navidad
              where  cn_cuenta       = @w_cuenta_int
                 and cn_cuota_gratis = 'N')
      goto Salir
    else
    begin
      update ah_cuenta_navidad
      set    cn_cuota_gratis = 'N'
      where  cn_cuenta = @w_cuenta_int

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 255070
        return 255070
      end
    end
  end

  if @i_tipo = 'D'
  begin
    if exists(select
                1
              from   ah_cuenta_navidad
              where  cn_cuenta       = @w_cuenta_int
                 and cn_cuota_gratis = 'S')
      goto Salir
    else
    begin
      update ah_cuenta_navidad
      set    cn_cuota_gratis = 'S'
      where  cn_cuenta = @w_cuenta_int

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 255070
        return 255070
      end
    end
  end
  Salir:
  return 0

go

