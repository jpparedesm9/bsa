/************************************************************************/
/*      Archivo:                ah_abono_cta_inc_86065.sp               */
/*      Stored procedure:       sp_abono_cuentas                        */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               clientes                                */
/*      Disenado por:           Edwin Jimenez                           */
/*      Fecha de escritura:     16/10/2012                              */
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
/*      Abona a cuentas por nota credito INC 86065                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*         FECHA                AUTOR                  RAZÓN            */
/*        16/10/2012         Edwin Jimenez      Emision Inicial         */
/*         02/Mayo/2016      Ignacio Yupa       Migración a CEN         */
/************************************************************************/

use cob_ahorros
go

if exists(select
            1
          from   sysobjects
          where  name = 'sp_abono_cuentas')
  drop proc sp_abono_cuentas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_abono_cuentas
  @t_show_version bit = 0
as
  declare
    @w_spname   varchar(60),
    @w_fproc    datetime,
    @w_estado   char(1),
    @w_sec      int,
    @w_ofi      smallint,
    @w_trn_prod int,
    @w_moneda   money,
    @w_cuenta   varchar(20),
    @w_valor    money,
    @w_causa    char(3),
    @w_ssn      int,
    @w_error    int,
    @w_mensaje  varchar(60)

  select
    @w_spname = 'sp_abono_cuentas'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_spname + ' Version= ' + '4.0.0.0'
    return 0
  end
  select
    @w_fproc = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    *
  into   #registros
  from   cob_ahorros..ah_abono_cuentas_inc
  where  ac_estado = 'V'

  while 1 = 1
  begin
    set rowcount 1

    select
      @w_ofi = ac_oficina,
      @w_cuenta = ac_cuenta,
      @w_valor = ac_valor,
      @w_sec = ac_secuencial,
      @w_estado = ac_estado
    from   #registros
    where  ac_estado = 'V'
    order  by ac_cuenta

    if @@rowcount = 0
    begin
      set rowcount 0
      print 'salida'
      break
    end

    select
      @w_trn_prod = 253,--Nota credito
      @w_causa = 21 --causal

    print 'CTA'
    print @w_cuenta

    select
      @w_moneda = ah_moneda
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @w_cuenta

    exec @w_ssn = ADMIN...rp_ssn

    exec @w_error = cob_ahorros..sp_ahndc_automatica
      @s_srv         = 1001,
      @s_ssn         = @w_ssn,
      @s_ofi         = @w_ofi,
      @t_trn         = @w_trn_prod,
      @i_cta         = @w_cuenta,
      @i_val         = @w_valor,
      @i_cau         = @w_causa,
      @i_mon         = @w_moneda,
      @i_fecha       = @w_fproc,
      @i_inmovi      = 'S',
      @i_activar_cta = 'N',
      @i_is_batch    = 'S',
      @i_cobiva      = 'N'

    if @w_error <> 0
    begin
      print 'ERROR NOTA AUTOMATICA'
      select
        @w_mensaje = mensaje
      from   cobis..cl_errores
      where  numero = @w_error
      update cob_ahorros..ah_abono_cuentas_inc
      set    ac_estado = 'X',
             ac_error = 'ERROR DATA: NC ERROR: ' + @w_mensaje
      where  ac_cuenta = @w_cuenta
    end
    else
    begin
      update cob_ahorros..ah_abono_cuentas_inc
      set    ac_estado = 'OK',
             ac_error = 'OK: PROCESADA' --+ @w_registro
      where  ac_cuenta = @w_cuenta

      update cob_ahorros..ah_cuenta
      set    ah_estado = 'A'
      where  ah_cta_banco = @w_cuenta
    end

    delete from #registros
    where  ac_cuenta = @w_cuenta

    print @w_error

  end

  return 0

go

