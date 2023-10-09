use cob_ahorros
go

/************************************************************************/
/*      Archivo:                ahvaltrhis.sp                           */
/*      Stored procedure:       sp_val_trnhis                           */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           ACorrea                                 */
/*      Fecha de escritura:     21-May-2010                             */
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
/*                                                                      */
/*      Este programa procesa notas de ajuste para reversos de ND/NC    */
/*      automaticas(interfaz)                                           */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA            AUTOR         RAZON                            */
/*      02/Mayo/2016   Walther Toledo  Migración a CEN                  */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_val_trnhis')
  drop proc sp_val_trnhis
go

create proc sp_val_trnhis
(
  @t_show_version bit = 0,
  @i_trn          int,
  @i_ssn_corr     int,
  @i_cta          cuenta,
  @i_val          money,
  @i_cau          char(3),
  @i_mon          tinyint,
  @i_alt          int = 0,
  @i_atm_server   char(1) = 'N',
  @o_trn          int = null out,
  @o_fecha_trn    datetime = null out,
  @o_monto_imp    money = null out,
  @o_iva          money = null out,
  @o_valor        money = null out,
  @o_base_gmf     money = null out,
  @o_signo        char(1) = 'N' out,
  @o_his          char(1) = 'N' out,
  @o_cau          char(3) = 'N' out,
  @o_tabla        char(30) = null out,
  @o_concepto     varchar(40) = null out,
  @o_corr         char(1) = 'N' out,
  @o_factor       smallint = null out
)
as
  declare
    @w_sp_name varchar(30),
    @w_error   int,
    @w_val     money,
    @w_debug   char(1)

  select
    @w_sp_name = 'sp_val_trnhis'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  select
    @w_error = 0
  select
    @o_his = 'N',
    @w_debug = 'N'

  if @i_atm_server = 'S'
    return 0

  select
    @o_fecha_trn = hm_fecha,
    @o_monto_imp = isnull(hm_monto_imp,
                          0),
    @o_iva = isnull(hm_valor_comision,
                    0),
    @o_valor = isnull(hm_valor,
                      0),
    @o_signo = hm_signo,
    @o_concepto = 'AJU-' + hm_concepto,
    @o_base_gmf = isnull(hm_base_gmf,
                         0)
  from   cob_ahorros_his..ah_his_movimiento
  where  isnull(hm_ssn_branch,
                hm_secuencial) = @i_ssn_corr
     and hm_cod_alterno                      = @i_alt
     and hm_tipo_tran                        = @i_trn
     and hm_cta_banco                        = @i_cta
     and hm_causa                            = @i_cau
     and hm_moneda                           = @i_mon
     and hm_estado is null

  if @@rowcount = 1
  begin
    select
      @o_his = 'S'

    if @o_valor <> @i_val
       and @o_signo = 'D'
    begin
      --VALOR EN SUSPENSO
      select
        @w_val = isnull(hs_valor,
                        0)
      from   cob_ahorros_his..ah_his_servicio
      where  hs_secuencial       = @i_ssn_corr
         and hs_cod_alterno      = @i_alt
         and hs_tipo_transaccion = 258
         and hs_cta_banco        = @i_cta
         and hs_causa            = @i_cau
         and hs_moneda           = @i_mon

      if @w_val is null
        select
          @w_val = $0
    end
    else
      select
        @w_val = $0

    if (@o_valor + @w_val) <> @i_val
      select
        @w_error = 251067
  end
  else
  begin
    select
      @o_valor = isnull(hs_valor,
                        0),
      @o_fecha_trn = hs_tsfecha,
      @o_monto_imp = 0,
      @o_iva = 0,
      @o_signo = 'D',
      @o_concepto = 'AJU-' + hs_observacion,
      @o_base_gmf = 0
    from   cob_ahorros_his..ah_his_servicio
    where  hs_secuencial       = @i_ssn_corr
       and hs_cod_alterno      = @i_alt
       and hs_tipo_transaccion = 258
       and hs_cta_banco        = @i_cta
       and hs_causa            = @i_cau
       and hs_moneda           = @i_mon

    if @o_valor is null
      select
        @o_valor = $0
    else
      select
        @o_his = 'S'

    if @w_debug = 'S'
      print '2 ===> @o_his: ' + @o_his

    if @o_his = 'S'
      if @o_valor <> @i_val
        select
          @w_error = 251067
      else
        select
          @o_signo = 'D'
  end

  if @w_debug = 'S'
    print '===> @o_his: ' + @o_his
  if @w_error = 0
  begin
    if @o_his = 'S'
    begin
      select
        @o_cau = pr_cau_aju
      from   cob_remesas..re_propiedad_ndc
      where  pr_producto = 4
         and pr_causa    = @i_cau
         and pr_signo    = @o_signo

      if @o_cau is null
      begin
        --select @w_error = 999999
        select
          @o_his = 'N'
      end
      else
      begin
        select
          @o_corr = 'N',
          @o_factor = 1
        if @i_trn = 253
          select
            @o_trn = 264,
            @o_signo = 'D',
            @o_tabla = 'ah_causa_nd'
        else
          select
            @o_trn = 253,
            @o_signo = 'C',
            @o_tabla = 'ah_causa_nc'
      end
    end
    else
      return 0
  end
  if @w_debug = 'S'
  begin
    print '===> @o_his: ' + @o_his
    print '===> @w_error : ' + cast(@w_error as varchar)
  end
  return @w_error

go

