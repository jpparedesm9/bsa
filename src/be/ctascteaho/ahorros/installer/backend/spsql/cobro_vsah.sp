/************************************************************************/
/*  Archivo:                cobro_vsah.sp                                 */
/*  Stored procedure:       sp_cobro_vsah                               */
/*  Base de datos:          cob_cuentas                                 */
/*  Producto:               Cuentas de Ahorros                          */
/*  Disenado por:           Veronica Molina                             */
/*  Fecha de escritura:     01-Oct-1998                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*  Este programa procesa la transaccion de:                            */
/*      Cobro de Valores en Suspenso para las Cuentas de Ahorro         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  01/Oct/1998 V.Molina    Emision Inicial                             */
/*  20/Oct/1999 V.Molina    Cobro o no de idb                           */
/*  06/jun/2002 A.Pazmino   Personalizacion Agro Mercantil              */
/*  02/May/2016 J. Calderon Migración a CEN                             */
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
           where  name = 'sp_cobro_vsah')
  drop proc sp_cobro_vsah
go

create proc sp_cobro_vsah
(
  @s_ssn           int = null,
  @s_ssn_branch    int = null,
  @s_srv           varchar(30) = null,
  @s_user          login = null,
  @s_sesn          int = null,
  @s_term          varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @s_date          datetime = null,
  @s_ofi           smallint = null,/* Localidad origen transaccion */
  @s_rol           smallint = null,
  @s_sev           tinyint = null,
  @s_org_err       char(1) = null,
  @s_org           char(1) = null,
  @s_error         int = null,
  @s_msg           descripcion = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_trn           int= null,
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_operacion     char(1),
  @i_secuencial    int,
  @i_linea         char(1),
  @i_oficina       smallint = null,
  @i_formato_fecha int =101,
  @i_corresponsal  char(1) = 'N'
)
as
  declare
    @w_return  int,
    @w_sp_name varchar(30),
    @w_cuenta  int,
    @w_valor   money,
    @w_causa   char(3),
    @w_imp     char(1)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_cobro_vsah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  select
    @s_ssn_branch = isnull(@s_ssn_branch,
                           @s_ssn)

  /*  Modo de debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**  Stored Procedure  **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_sev = @s_sev,
      t_debug = @t_debug,
      t_from = @t_from,
      t_file = @t_file,
      s_ori = @s_org,
      t_trn = @t_trn,
      i_cta = @i_cta,
      i_operacion = @i_operacion,
      i_secuencial= @i_secuencial,
      i_linea = @i_linea
    exec cobis..sp_end_debug
  end

  if @t_trn <> 303
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  select
    @w_cuenta = ah_cuenta
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta

  if @@rowcount <> 1
  begin
    /* No existe cuenta_banco */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251001
    return 1
  end

  /* Query que entrega los resultados */

  if @i_operacion = 'S'
  begin
    set rowcount 20

    select
      'SECUENCIAL' = convert(varchar(12), vs_secuencial),
      'OFICINA' = vs_oficina,
      'CAUSA' = vs_servicio,
      'DESCRIPCION' = a.valor,
      'VALOR' = convert(varchar(20), vs_valor),
      'FECHA' = convert(varchar(10), vs_fecha, @i_formato_fecha)
    from   cob_ahorros..ah_val_suspenso,
           cobis..cl_catalogo a,
           cobis..cl_tabla b
    where  vs_cuenta     = @w_cuenta
       and vs_procesada  = 'N'
       and b.tabla       = 'ah_causa_nd'
       and a.tabla       = b.codigo
       and vs_secuencial > @i_secuencial
       and ((vs_servicio = a.codigo)
             or (a.codigo = convert(varchar(5), vs_servicio)))
    order  by vs_secuencial
  end

  if @i_operacion = 'C'
  begin
    select
      @w_valor = vs_valor,
      @w_causa = vs_servicio,
      @w_imp = vs_impuesto
    from   cob_ahorros..ah_val_suspenso
    where  vs_cuenta     = @w_cuenta
       and vs_secuencial = @i_secuencial
       and vs_procesada  = 'N'

    if @@rowcount <> 1
    begin
      /* No existe cuenta_banco */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251071
      return 1
    end

    exec @w_return = cob_ahorros..sp_ahcobsus
      @s_srv          = @s_lsrv,
      @s_ssn          = @s_ssn,
      @s_ofi          = @i_oficina,
      @s_date         = @s_date,
      @s_user         = @s_user,
      @s_term         = @s_term,
      @i_cuenta       = @w_cuenta,
      @i_sec          = @i_secuencial,
      @i_linea        = @i_linea,
      @i_valor        = @w_valor,
      @i_cau          = @w_causa,
      @i_imp          = @w_imp,
      @i_corresponsal = @i_corresponsal

    if @w_return <> 0
      return @w_return
  end

  return 0

go

