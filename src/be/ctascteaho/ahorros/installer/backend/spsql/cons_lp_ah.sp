/************************************************************************/
/*    Archivo:              ahtcolp.sp                                  */
/*    Stored procedure:     sp_cons_lp_ah                               */
/*    Base de datos:        cob_ahorros                                 */
/*    Producto:             Cuentas de Ahorros                          */
/*      Disenado por:       Mauricio Bayas/Sandra Ortiz                 */
/*    Fecha de escritura:   18-Feb-1993                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*    Este programa realiza la transaccion de consulta de bloqueos      */
/*    contra valores de cuentas de ahorros.                             */
/*    233 = Consulta de lineas pendientes de cuentas de ahorros.        */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*      FECHA           AUTOR           RAZON                           */
/*    01/Mar/1993    P. Mena           Emision inicial                  */
/*    10/Nov/1994    J. Bucheli        Personalizacion para Banco de    */
/*                                     la Produccion                    */
/*    01/25/96       A. Mencias        Revision Final                   */
/*    05/05/2006     pedro coello   Ordenar por fecha y numero de linea */
/*    02/May/2016    J. Calderon       Migración a CEN                  */
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
           where  name = 'sp_cons_lp_ah')
  drop proc sp_cons_lp_ah
go

create proc sp_cons_lp_ah
(
  @s_ssn           int,
  @s_srv           varchar(30),
  @s_user          varchar(30),
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_org           char(1),
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint = 1,
  @s_org_err       char(1) = null,/* Origen de error:[A], [S] */
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint,
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_mon           tinyint,
  @i_modo          tinyint,
  @i_linea         int = null,
  @i_fecha         datetime = null,--PCOELLO A-ADIR PARA EL SIGUIENTES
  @i_imp           char(1),
  @i_formato_fecha int=101
)
as
  declare
    @w_return        int,
    @w_sp_name       varchar(30),
    @w_cuenta        int,
    @w_filial        tinyint,
    @w_estado        char(1),
    @w_moneda        tinyint,
    @w_saldo_libreta money

  /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_cons_lp_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  /* Modo de debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
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
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_rty = @t_rty,
      t_trn = @t_trn,
      i_cta = @i_cta,
      i_mon = @i_mon,
      i_modo = @i_modo,
      i_linea = @i_linea,
      i_imp = @i_imp
    exec cobis..sp_end_debug
  end

  if @t_trn <> 233
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  /* Se obtiene la filial */
  select
    @w_filial = of_filial
  from   cobis..cl_oficina
  where  of_oficina = @s_ofi

  select
    @w_cuenta = ah_cuenta,
    @w_estado = ah_estado,
    @w_saldo_libreta = ah_saldo_libreta
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta
     and ah_moneda    = @i_mon

  /* Chequeo de existencias */
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

  /* Validaciones */
  if @w_estado <> 'A'
  begin
    /* Cuenta no activa o cancelada */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251002
    return 1
  end

  /* Envio de resultados al Front End */
  set rowcount 20
  if @i_modo = 0
  begin
    select
      'FECHA ' = convert(char(10), lp_fecha, @i_formato_fecha),
      'LINEA' = lp_linea,
      'NEMONICO' = lp_nemonico,
      'VALOR     ' = lp_valor,
      'No. CONTROL' = lp_control,
      'DEBITO/CREDITO' = lp_signo,
      'ESTADO' = lp_enviada
    from   cob_ahorros..ah_linea_pendiente
    where  lp_cuenta  = @w_cuenta
       and lp_enviada = @i_imp
    order  by lp_fecha,
              lp_linea --PCOELLO A-ADIR FECHA EN EL ORDENAMIENTO

    select
      @w_saldo_libreta
  --PCOELLO SE RETORNA EL SALDO DE LIBRETA ACTUAL PARA CALCULAR EN BASE A LAS LINEAS QUE SE VAN A ACTUALIZAR
  end
  else if @i_modo = 1
    select
      'FECHA ' = convert(char(10), lp_fecha, @i_formato_fecha),
      'LINEA' = lp_linea,
      'NEMONICO' = lp_nemonico,
      'VALOR     ' = lp_valor,
      'No. CONTROL' = lp_control,
      'DEBITO/CREDITO' = lp_signo,
      'ESTADO' = lp_enviada
    from   cob_ahorros..ah_linea_pendiente
    where  lp_cuenta  = @w_cuenta
       and ((lp_fecha   = @i_fecha
             and lp_linea   > @i_linea)
             or lp_fecha   > @i_fecha) --PCOELLO A-ADIR FECHA EN EL ORDENAMIENTO
       and lp_enviada = @i_imp
    order  by lp_fecha,
              lp_linea --PCOELLO A-ADIR FECHA EN EL ORDENAMIENTO
  set rowcount 0
  return 0

go

