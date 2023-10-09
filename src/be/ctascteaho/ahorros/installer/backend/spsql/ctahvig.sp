/********************************************************************/
/*  Archivo:            ctahvig.sp                                  */
/*  Stored procedure:   sp_ctah_vigente                             */
/*  Base de datos:      cob_ahorros                                 */
/*  Producto:           Cuentas de Ahorros                          */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                 */
/*  Fecha de escritura: 24-Feb-1993                                 */
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
/*  Este programa determina si una cuenta corriente esta vigente    */
/*  indicando, ademas, a que filial y oficina pertenece.            */
/********************************************************************/
/*                       MODIFICACIONES                             */
/*  FECHA           AUTOR           RAZON                           */
/*  24/Feb/1993     S Ortiz         Emision inicial                 */
/*                  M Bayas                                         */
/*  12/Mar/1995     J. Bucheli      Personalizacion                 */
/********************************************************************/
/*                       MODIFICACIONES                             */
/*  17/Ago/1995     E. Guerrero A.  Emision inicial Cursores        */
/*  12/12/2006      R. Linares      control cuentas inactivas       */
/*  03/May/2016     J. Salazar      Migracion COBIS CLOUD MEXICO    */
/********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ctah_vigente')
  drop proc sp_ctah_vigente
go

/****** Object:  StoredProcedure [dbo].[sp_ctah_vigente]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ctah_vigente
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(30) = null,
  @t_show_version bit = 0,
  @i_cta_banco    varchar(20),
  @i_moneda       tinyint,
  @i_ing_carta_r  char(1) = 'N',
  @i_val_inac     char(1) = 'S',--PARA VALIDAR O NO LA INACTIVIDAD
  @i_is_batch     char(1) = 'N',
  @o_cuenta       int = null out,
  @o_filial       tinyint = null out,
  @o_oficina      smallint = null out,
  @o_tpromedio    char(1) = null out,
  @o_oficial      smallint = null out
)
as
  declare
    @w_estado_cta char(1),
    @w_sp_name    varchar(30),
    @w_mensaje    mensaje,
    @w_error      int,
    @w_sev        tinyint

  /*  Captura nombre de stored procedure  */
  select
    @w_sp_name = 'sp_ctah_vigente'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  select
    @w_mensaje = null

  /*  Modo de debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/**  Stored Procedure  **/' = @w_sp_name,
      t_from = @t_from,
      i_cta_banco = @i_cta_banco,
      i_moneda = @i_moneda
    exec cobis..sp_end_debug
  end

  /*  Validacion de la cuenta de ahorro  */

  select
    @w_estado_cta = ah_estado,
    @o_cuenta = ah_cuenta,
    @o_filial = ah_filial,
    @o_oficina = ah_oficina,
    @o_tpromedio = ah_tipo_promedio,
    @o_oficial = ah_oficial
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta_banco
     and ah_moneda    = @i_moneda

  if @@rowcount = 0
  begin
    /*  No existe cuenta de ahorro  */
    select
      @w_error = 251001,
      @w_sev = 0
    goto ERROR
  end

  if @w_estado_cta = 'C'
  begin
    /*  Cuenta de ahorros cerrada */
    select
      @w_error = 251057,
      @w_sev = 0
    goto ERROR
  end

  if @w_estado_cta = 'I'
     and @i_val_inac = 'S'
  begin
    select
      @w_error = 251058,
      @w_sev = 0
    goto ERROR
  end

  /*  Modo de debug, parametros de output  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file
    select
      '/**  Stored Procedure  **/' = @w_sp_name,
      o_cuenta = @o_cuenta,
      o_filial = @o_filial,
      o_oficina = @o_oficina,
      o_tpromedio = @o_tpromedio,
      o_oficial = @o_oficial
    exec cobis..sp_end_debug
  end

  return 0

  ERROR:
  if @i_is_batch = 'N'
  begin
    exec cobis..sp_cerror
      @t_debug = null,
      @t_file  = null,
      @t_from  = @w_sp_name,
      @i_num   = @w_error,
      @i_sev   = @w_sev,
      @i_msg   = @w_mensaje

    if @w_sev = 1
      rollback tran
  end

  return @w_error

go

