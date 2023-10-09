use cob_ahorros
go

/************************************************************************/
/*  Archivo:            transf_cta_traslado.sp                          */
/*  Stored procedure:   sp_transf_cta_traslado                          */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:               Cuentas Ahorros                             */
/*  Disenado por:           David Vasquez                               */
/*  Fecha de escritura:     28-May-2002                                 */
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
/*  Este programa realiza el levantamiento de bloqueo de la             */
/*      cuenta de traslado y la transferencia                           */
/*                                                                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  28/Jun/2002 D. Vasquez      Emision Inicial                         */
/*      02/Mayo/2016    Walther Toledo  Migración a CEN                 */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_transf_cta_traslado')
  drop proc sp_transf_cta_traslado
go

create proc sp_transf_cta_traslado
(
  @s_ssn          int,
  @s_srv          varchar(30),
  @s_date         datetime,
  @t_show_version bit = 0,
  @i_cta_banco    cuenta,
  @i_monto        money,
  @i_observacion  varchar(120) = null,
  @i_sec_bloq     int = null,
  @i_moneda       tinyint,
  @i_cta_banco_cc cuenta,
  @i_opcion       tinyint,
  @o_procesado    char(1) = 'S' out
)
as
  declare
    @w_return      int,
    @w_sp_name     varchar(30),
    @w_mensaje     varchar(254),
    @w_observacion varchar(30),
    @w_login_ope   varchar(10)

  /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_transf_cta_traslado'
  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  /* Lectura para login operador batch*/
  select
    @w_login_ope = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'LOB'
     and pa_producto = 'ADM'

  begin tran
  select
    @o_procesado = 'S'

  if @i_opcion = 1
  begin
    exec @w_return = cob_ahorros..sp_bloq_val_ah
      @s_srv         = @s_srv,
      @s_lsrv        = @s_srv,
      @s_ssn         = @s_ssn,
      @s_ssn_branch  = @s_ssn,
      @s_ofi         = 1,
      @s_date        = @s_date,
      @s_sesn        = 1,
      @s_term        = 'CONSOLA',
      @s_org         = 'U',
      @s_user        = @w_login_ope,
      @t_trn         = 218,
      @i_accion      = 'L',
      @i_cta         = @i_cta_banco,
      @i_mon         = @i_moneda,
      @i_causa       = '15',
      @i_valor       = @i_monto,
      @i_aut         = @w_login_ope,
      @i_solicit     = @w_login_ope,
      @i_observacion = @i_observacion,
      @i_automatico  = 'S',
      @i_sec         = @i_sec_bloq

    if @w_return <> 0
    begin
      rollback tran
      print 'Cuenta con error en levantamiento de bloqueo: ' + @i_cta_banco
      select
        @w_mensaje = mensaje
      from   cobis..cl_errores
      where  numero = @w_return

      if @w_mensaje is null
        select
          @w_mensaje = 'Error en el levantamiento de Bloqueo Automatico'

      select
        @w_mensaje = @w_mensaje + ' ' + convert(varchar(10), @w_return)

      insert into cob_ahorros..re_error_batch
      values      (@i_cta_banco,@w_mensaje)
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @i_num = 203035
        rollback tran
        return 1
      end

      select
        @o_procesado = 'N'
    end

    --  Realiza la transferencia correspondiente al bloqueo

    exec @w_return = cob_interfase..sp_icte_tr_transferencias
      @s_ssn          = @s_ssn,
      @s_ssn_branch   = @s_ssn,
      @s_srv          = @s_srv,
      @s_lsrv         = @s_srv,
      @s_user         = @w_login_ope,
      @s_sesn         = 1,
      @s_term         = 'CONSOLA',
      @s_date         = @s_date,
      @s_ofi          = 1,
      @s_org          = 'N',--CVA Mar-01-04 'U'
      @t_trn          = 239,
      @i_prodeb       = 'AHO',
      @i_ctadb        = @i_cta_banco,
      @i_prodep       = 'CTE',
      @i_cta_dep      = @i_cta_banco_cc,
      @i_mon          = @i_moneda,
      @i_val          = @i_monto,
      @i_nocaja       = 'S',
      @i_verifica_blq = 'N',
      @i_monto_maximo = 'N',
      @i_referencia   = @i_observacion,
      @i_por_traslado = 'S'

    if @w_return <> 0
    begin
      rollback tran

      print 'Cuenta con error en transferencia: ' + @i_cta_banco + ' error '
            + convert(varchar(10), @w_return)

      select
        @w_mensaje = mensaje
      from   cobis..cl_errores
      where  numero = @w_return

      if @w_mensaje is null
        select
          @w_mensaje = 'Error en la ejecucion de Transferencia'

      select
        @w_mensaje = @w_mensaje + ' ' + convert(varchar(10), @w_return)

      insert into cob_ahorros..re_error_batch
      values      (@i_cta_banco,@w_mensaje)
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @i_num = 203035
        rollback tran
        return 1
      end

      select
        @o_procesado = 'N'
    end
  end
  if @i_opcion = 2
  begin
    select
      @w_observacion = convert(varchar(30), @s_ssn)

    exec @w_return = cob_interfase..sp_icte_tr_transferencias
      @s_ssn          = @s_ssn,
      @s_ssn_branch   = @s_ssn,
      @s_srv          = @s_srv,
      @s_lsrv         = @s_srv,
      @s_user         = @w_login_ope,
      @s_sesn         = 1,
      @s_term         = 'CONSOLA',
      @s_date         = @s_date,
      @s_ofi          = 1,
      @s_org          = 'N',--CVA Mar-01-04 'U'
      @t_trn          = 2520,
      @i_prodeb       = 'CTE',
      @i_ctadb        = @i_cta_banco_cc,
      @i_prodep       = 'AHO',
      @i_cta_dep      = @i_cta_banco,
      @i_mon          = @i_moneda,
      @i_val          = @i_monto,
      @i_nocaja       = 'S',
      @i_verifica_blq = 'N',
      @i_monto_maximo = 'N',
      @i_referencia   = @w_observacion

    if @w_return <> 0
    begin
      rollback tran

      print 'Cuenta con error en transferencia: ' + @i_cta_banco + ' error '
            + convert(varchar(10), @w_return)

      select
        @w_mensaje = mensaje
      from   cobis..cl_errores
      where  numero = @w_return

      if @w_mensaje is null
        select
          @w_mensaje = 'Error en la ejecucion de Transferencia'

      select
        @w_mensaje = @w_mensaje + ' ' + convert(varchar(10), @w_return)

      insert into cob_ahorros..re_error_batch
      values      (@i_cta_banco,@w_mensaje)
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @i_num = 203035
        rollback tran
        return 1
      end

      select
        @o_procesado = 'N'
    end

  end

  if @i_opcion = 3
  begin
    select
      @w_observacion = convert(varchar(30), @s_ssn)

    exec @w_return = cob_interfase..sp_icte_tr_transferencias
      @s_ssn          = @s_ssn,
      @s_ssn_branch   = @s_ssn,
      @s_srv          = @s_srv,
      @s_lsrv         = @s_srv,
      @s_user         = @w_login_ope,
      @s_sesn         = 1,
      @s_term         = 'CONSOLA',
      @s_date         = @s_date,
      @s_ofi          = 1,
      @s_org          = 'U',
      @t_trn          = 239,
      @i_prodeb       = 'AHO',
      @i_ctadb        = @i_cta_banco,
      @i_prodep       = 'CTE',
      @i_cta_dep      = @i_cta_banco_cc,
      @i_mon          = @i_moneda,
      @i_val          = @i_monto,
      @i_nocaja       = 'S',
      @i_verifica_blq = 'N',
      @i_monto_maximo = 'N',
      @i_referencia   = @w_observacion

    if @w_return <> 0
    begin
      rollback tran

      print 'Cuenta con error en transferencia: ' + @i_cta_banco

      select
        @w_mensaje = mensaje
      from   cobis..cl_errores
      where  numero = @w_return

      if @w_mensaje is null
        select
          @w_mensaje = 'Error en la ejecucion de Transferencia'

      select
        @w_mensaje = @w_mensaje + ' ' + convert(varchar(10), @w_return)

      insert into cob_ahorros..re_error_batch
      values      (@i_cta_banco,@w_mensaje)
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @i_num = 203035
        rollback tran
        return 1
      end

      select
        @o_procesado = 'N'
    end

  end

  select
    @o_procesado
  commit tran
  return 0

go

