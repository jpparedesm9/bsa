/****************************************************************************/
/*     Archivo:          ahcamcat.sp                                        */
/*     Stored procedure: sp_cambio_categoria                                */
/*     Base de datos:    cob_ahorros                                        */
/*     Producto:         Ahorros                                            */
/*     Disenado por:     Andres Diab                                        */
/*     Fecha de escritura: 24-Jun-2011                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad           */
/*   de COBISCorp.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como             */
/*   cualquier alteracion o agregado  hecho por alguno de sus               */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.        */
/*   Este programa esta protegido por la ley de derechos de autor           */
/*   y por las convenciones  internacionales   de  propiedad inte-          */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para       */
/*   obtener ordenes  de secuestro o retencion y para  perseguir            */
/*   penalmente a los autores de cualquier infraccion.                      */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*  02/May/2016   J. Calderon      Migración a CEN                          */
/****************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_cambio_categoria')
  drop proc sp_cambio_categoria
go

create proc sp_cambio_categoria
(
  @t_show_version bit = 0,
  @i_cta_banco    cuenta
)
as
  declare
    @w_sp_name      varchar(32),
    @w_error        int,
    @w_msg          varchar(255),
    @w_trn_code     int,
    @w_fecha        datetime,
    @w_return       int,
    @w_camcat       char(1),
    @w_ssn          int,
    @w_cuenta       int,
    @w_cat_anterior char(1),
    @w_categoria    char(1),
    @w_prod_banc    tinyint,
    @w_oficina      smallint,
    @w_moneda       tinyint,
    @w_cliente      int

  select
    @w_sp_name = 'sp_cambio_categoria',
    @w_trn_code = 4130,
    @w_fecha = fp_fecha
  from   cobis..ba_fecha_proceso

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  /*** PARAMETRO CAMBIO DE CATEGORIA ***/
  select
    @w_camcat = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'CAMCAT'
  if @@rowcount = 0
  begin
    select
      @w_error = 0,
      @w_msg = 'NO EXISTE PARAMETRO CAMBIO DE CATEGORIA'
    goto ERROR
  end

  select
    @w_cuenta = ah_cuenta,
    @w_cat_anterior = ah_categoria,
    @w_prod_banc = ah_prod_banc,
    @w_oficina = ah_oficina,
    @w_moneda = ah_moneda,
    @w_cliente = ah_cliente
  from   cob_ahorros..ah_cuenta,
         cob_remesas..re_cuenta_contractual
  where  ah_cta_banco = cc_cta_banco
     and ah_cta_banco = @i_cta_banco
     and ah_estado    <> 'C'
  if @@rowcount = 0
  begin
    select
      @w_error = 0,
      @w_msg =
    'LA CUENTA DE AHORRO ESPECIFICADA NO EXISTE O ESTA CANCELADA. CUENTA: '
    + @i_cta_banco
    goto ERROR
  end

  update cob_ahorros..ah_cuenta with (rowlock)
  set    ah_categoria = @w_camcat
  where  ah_cta_banco = @i_cta_banco
     and ah_estado    <> 'C'
  if @@error <> 0
  begin
    select
      @w_error = 0,
      @w_msg = 'ERROR EN ACTUALIZACION DE CATEGORIA'
    goto ERROR
  end

  update cobis..ba_secuencial
  set    @w_ssn = se_numero,
         se_numero = @w_ssn + 1

  insert into ah_tran_servicio
              (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
               ts_usuario,
               ts_terminal,ts_ctacte,ts_filial,ts_oficina,ts_oficina_cta,
               ts_hora,ts_prod_banc,ts_categoria,ts_correccion,ts_cta_banco,
               ts_cliente,ts_moneda,ts_observacion)
  values      ( @w_ssn,@w_ssn,@w_trn_code,@w_fecha,'op_batch',
                'consola',@w_cuenta,1,@w_oficina,@w_oficina,
                getdate(),@w_prod_banc,@w_cat_anterior,@w_camcat,@i_cta_banco,
                @w_cliente,@w_moneda,'CAMBIO DE CATEGORIA CONTRACTUAL')
  if @@error <> 0
  begin
    select
      @w_error = 0,
      @w_msg = 'ERROR INSERTANDO TRANSACCION DE SERVICIO'
    goto ERROR
  end

  return 0

  ERROR:

  print @w_msg

  exec sp_errorlog
    @i_fecha       = @w_fecha,
    @i_error       = @w_error,
    @i_usuario     = 'batch',
    @i_tran        = @w_trn_code,
    @i_cuenta      = @i_cta_banco,
    @i_descripcion = @w_msg,
    @i_programa    = @w_sp_name

  return @w_error

go

