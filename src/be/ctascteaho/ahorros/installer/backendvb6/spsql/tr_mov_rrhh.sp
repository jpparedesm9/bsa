use cob_ahorros
go

/************************************************************************/
/*  Archivo:            tr_mov_rrhh.sp                                  */
/*  Stored procedure:   sp_tr_mov_rrhh                                  */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:       Cuentas de Ahorros                                  */
/*  Disenado por:           Humberto Ayarza                             */
/*  Fecha de escritura:     03-Sep-2006                                 */
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
/*  Este programa devuelve la consulta de transacciones realizadas      */
/*  por RRHH.                                                           */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA     AUTOR       RAZON                                         */
/*  03/Sep/2006   H.Ayarza    Emision Inicial                           */
/*  13/Nov/2006   H.Ayarza        Adicion de Cod. Cliente.              */
/*  02/Mayo/2016  Walther Toledo  Migración a CEN                       */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_mov_rrhh')
  drop proc sp_tr_mov_rrhh
go

create proc sp_tr_mov_rrhh
(
  @t_show_version bit = 0,
  @i_sec          int = 0,
  @i_periodo      smallint = 0,
  @i_fchdsde      datetime = null
)
as
  declare
    @w_fecha   datetime,
    @w_sp_name varchar(30),
    @w_fchdsde datetime,
    @w_fchhsta datetime

  select
    @w_sp_name = 'sp_tr_mov_rrhh'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  select
    @w_fecha = fp_fecha
  from   cobis..ba_fecha_proceso

  --print "Sec %1! Periodo %2! ",@i_sec, @i_periodo
  --print "Desde %1!", @i_fchdsde

  if @i_periodo = 1 --RANGO DE FECHA DEL MES ANTERIOR
  begin
    if @i_sec > 0
      select
        @w_fchdsde = @i_fchdsde
    else
    begin
      select
        @w_fchdsde = dateadd(mm,
                             -1,
                             dateadd(dd,
                                     -datepart(dd,
                                               @w_fecha) + 1,
                                     @w_fecha))
    --print "INICIA PROCESAMIENTO MES ANTERIOR"
    end

    select
      @w_fchhsta = dateadd(mm,
                           1,
                           dateadd(dd,
                                   -datepart(dd,
                                             @w_fchdsde),
                                   @w_fchdsde))
  end
  else
  begin
    if @i_sec > 0
      select
        @w_fchdsde = @i_fchdsde
    else
    begin
      select
        @w_fchdsde = dateadd(dd,
                             -datepart(dd,
                                       @w_fecha) + 1,
                             @w_fecha)
    --print "INICIA PROCESAMIENTO MES ACTUAL"
    end

    select
      @w_fchhsta = @w_fecha
  end

  --print "Desde  %1!  Hasta  %2!",@w_fchdsde, @w_fchhsta
  set rowcount 20
  if @i_sec = 0
  begin
    select
      hm_cta_banco,
      ah_cliente,
      Nombre=ah_nombre,
      (select
         z.valor
       from   cobis..cl_catalogo z,
              cobis..cl_tabla y
       where  z.tabla  = y.codigo
          and y.tabla  = case x.hm_tipo_tran
                           when 48 then 'cc_causa_nc'
                           when 50 then 'cc_causa_nd'
                           when 253 then 'ah_causa_nc'
                           when 255 then 'ah_causa_nc'
                           when 262 then 'ah_causa_nd'
                           when 264 then 'ah_causa_nd'
                         end
          and z.codigo = x.hm_causa),
      hm_signo,
      convert(money, hm_valor),
      substring(convert(char, hm_fecha, 103),
                1,
                12),
      hm_usuario,
      hm_secuencial
    from   cob_ahorros_his..ah_his_movimiento x,
           cob_ahorros..ah_cuenta
    where  hm_fecha     >= @w_fchdsde
       and hm_fecha     <= @w_fchhsta
       and hm_oficina   >= 0
       and hm_moneda    = 0
       and (hm_tipo_tran = 253
             or hm_tipo_tran = 264)
       and ah_cta_banco = hm_cta_banco
       and (hm_causa     = '254'
             or hm_causa     = '266')
    set transaction isolation level repeatable read
  --order by hm_fecha, hm_secuencial
  end

  else if @w_fchhsta <> @w_fecha
    select
      hm_cta_banco,
      ah_cliente,
      Nombre=ah_nombre,
      (select
         z.valor
       from   cobis..cl_catalogo z,
              cobis..cl_tabla y
       where  z.tabla  = y.codigo
          and y.tabla  = case x.hm_tipo_tran
                           when 48 then 'cc_causa_nc'
                           when 50 then 'cc_causa_nd'
                           when 253 then 'ah_causa_nc'
                           when 255 then 'ah_causa_nc'
                           when 262 then 'ah_causa_nd'
                           when 264 then 'ah_causa_nd'
                         end
          and z.codigo = x.hm_causa),
      hm_signo,
      convert(money, hm_valor),
      substring(convert(char, hm_fecha, 103),
                1,
                12),
      hm_usuario,
      hm_secuencial
    from   cob_ahorros_his..ah_his_movimiento x,
           cob_ahorros..ah_cuenta
    where  hm_fecha       >= @w_fchdsde
       and hm_fecha       <= @w_fchhsta
       and hm_oficina     >= 0
       and hm_moneda      = 0
       and (hm_tipo_tran   = 253
             or hm_tipo_tran   = 264)
       and hm_transaccion > 0
       and ah_cta_banco   = hm_cta_banco
       and (hm_causa       = '254'
             or hm_causa       = '266')
       and hm_secuencial  > @i_sec
  set transaction isolation level repeatable read

  if @w_fchhsta = @w_fecha
    select
      ah_cta_banco,
      ah_cliente,
      Nombre=ah_nombre,
      (select
         z.valor
       from   cobis..cl_catalogo z,
              cobis..cl_tabla y
       where  z.tabla  = y.codigo
          and y.tabla  = case x.tm_tipo_tran
                           when 48 then 'cc_causa_nc'
                           when 50 then 'cc_causa_nd'
                           when 253 then 'ah_causa_nc'
                           when 255 then 'ah_causa_nc'
                           when 262 then 'ah_causa_nd'
                           when 264 then 'ah_causa_nd'
                         end
          and z.codigo = x.tm_causa),
      tm_signo,
      convert(money, tm_valor),
      substring(convert(char, tm_fecha, 103),
                1,
                12),
      tm_usuario,
      tm_secuencial
    from   cob_ahorros..ah_tran_monet x,--(index ah_tran_monet_tran),
           cob_ahorros..ah_cuenta
    where  tm_oficina     >= 0
       and tm_moneda      = 0
       and (tm_tipo_tran   = 253
             or tm_tipo_tran   = 264)
       and tm_secuencial  > @i_sec
       and tm_cod_alterno >= 0
       and ah_cta_banco   = tm_cta_banco
       and tm_causa in ('254', '266')
  --order by tm_secuencial
  set transaction isolation level repeatable read

  return 0

go

