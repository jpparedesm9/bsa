/************************************************************************/
/*    Archivo:              ahapemas.sp                                 */
/*    Stored procedure:     sp_apertura_masiva_ah                       */
/*    Base de datos:        cob_ahorros                                 */
/*    Producto:         Cuentas de Ahorros                              */
/*    Disenado por:          Johnmer Salazar                            */
/*    Fecha de escritura:     30-Ene-2000                               */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                            PROPOSITO                                 */
/*    Este programa procesa la apertura masiva de cuentas de ahorro     */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*    FECHA        AUTOR            RAZON                               */
/*  30/Ene/2000    Johnmer Salazar      Emision inicial                 */
/*  02/May/2016    Javier Calderon      Migración a CEN                 */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_apertura_masiva_ah')
  drop proc sp_apertura_masiva_ah
go

create proc sp_apertura_masiva_ah
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
  @s_org_err      char(1) = null,/* Origen de error:[A], [S] */
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_sec          int,
  @i_ofl          smallint = null,
  @i_cli          int,
  @i_nombre       descripcion = null,
  @i_nombre1      descripcion = null,
  @i_cedruc1      char(13)= null,
  @i_cedruc       varchar(20),
  @i_cli_ec       int = null,
  @i_direc        tinyint = null,
  @i_tprom        char(1) = null,
  @i_categ        char(1) = null,
  @i_mon          tinyint = null,
  @i_tdef         char(1) = null,
  @i_def          int = null,
  @i_rolcli       char(1),
  @i_rolente      char(1) = '1',
  @i_dprod        int = null,
  @i_ciclo        char(1) = null,
  @i_capit        char(1) = null,
  @i_pers         char(1) = 'N',
  @i_tipodir      char(1) = null,
  @i_casillero    varchar(10) = null,
  @i_agencia      smallint = 11,
  @i_prodbanc     smallint = null,
  @i_origen       varchar(3) = null,
  @i_numlib       int = null,
  @i_valor        money = null,
  @i_cli1         int,
  @o_funcio       tinyint = null out,
  @o_error        int = null out
)
as
  declare
    @w_mensaje varchar(64),
    @w_cuenta  cuenta,
    @w_sp_name varchar(30)

  select
    @w_sp_name = 'sp_apertura_masiva_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  begin tran

  exec @o_error = cob_ahorros..sp_apertura_ah
    @s_ssn      = @s_ssn,
    @s_srv      = @s_srv,
    @s_lsrv     = @s_lsrv,
    @s_user     = @s_user,
    @s_sesn     = @s_sesn,
    @s_term     = @s_term,
    @s_date     = @s_date,
    @s_ofi      = @s_ofi,
    @t_trn      = @t_trn,
    @i_ofl      = @i_ofl,
    @i_cli      = @i_cli,
    @i_nombre   = @i_nombre,
    @i_nombre1  = @i_nombre1,
    @i_cedruc1  = @i_cedruc1,
    @i_cedruc   = @i_cedruc,
    @i_cli_ec   = @i_cli_ec,
    @i_direc    = @i_direc,
    @i_tprom    = @i_tprom,
    @i_categ    = @i_categ,
    @i_mon      = @i_mon,
    @i_tdef     = @i_tdef,
    @i_def      = @i_def,
    @i_rolcli   = @i_rolcli,
    @i_rolente  = @i_rolente,
    @i_ciclo    = @i_ciclo,
    @i_capit    = @i_capit,
    @i_tipodir  = @i_tipodir,
    @i_agencia  = @i_agencia,
    @i_prodbanc = @i_prodbanc,
    @i_origen   = @i_origen,
    @i_numlib   = @i_numlib,
    @i_valor    = @i_valor,
    @i_cli1     = @i_cli1,
    @i_dep_ini  = 0,
    @o_cta      = @w_cuenta out

  if @o_error <> 0
  begin
    rollback
    print 'ERROR EN APERTURA DE CUENTA DE AHORROS'

    select
      @w_mensaje = mensaje
    from   cobis..cl_errores
    where  numero = @o_error

    if @w_mensaje is null
      select
        @w_mensaje = 'ERROR EN APERTURA DE CUENTA DE AHORRO'

    update cob_remesas..re_apertura_masiva_cta
    set    am_estado = 'E',
           am_mensaje = @w_mensaje
    where  am_fecha = @s_date
       and am_sec   = @i_sec

    if @@rowcount <> 1
    begin
      print 'ERROR EN ACTUALIZACION DE TABLA DE APERTURA MASIVA'

      select
        @o_error = 355029
      return 355029
    end
  end
  else
  begin
    update cob_remesas..re_apertura_masiva_cta
    set    am_estado = 'P',
           am_cuenta = @w_cuenta,
           am_mensaje = 'CUENTA DE AHORROS APERTURADA SATISFACTORIAMENTE'
    where  am_fecha = @s_date
       and am_sec   = @i_sec

    if @@rowcount <> 1
    begin
      print 'ERROR EN ACTUALIZACION DE TABLA DE APERTURA MASIVA'

      select
        @o_error = 355029
      return 355029
    end
  end

  commit tran
  return 0

go

