/************************************************************************/
/*      Archivo:                ahpasdef2.sp                            */
/*      Stored procedure:       sp_ahpasdef2                            */
/*      Base de datos:          cob_ahorros                             */
/*      Producto: Cuentas Ahorros                                       */
/*      Disenado por:  Mauricio Bayas/Julio Navarrete/Xavier Bucheli    */
/*      Fecha de escritura: 12-Ene-1993                                 */
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
/*    Acumulacion de Intereses del mensual                              */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA            AUTOR                 RAZON                    */
/*    02/Dic/1999       J.C. Gordillo        Emision Inicial            */
/*    02/May/2016       J. Calderon          Migración a CEN            */
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
           where  name = 'sp_ahpasdef2')
  drop proc sp_ahpasdef2
go

create proc sp_ahpasdef2
(
  @t_show_version bit = 0,
  @s_rol          smallint = null,
  @i_fecha        datetime,
  @i_turno        smallint = null,
  @o_procesadas   int out
)
as
  declare
    @w_ssn                int,
    @w_ofi_cont           smallint,
    @w_mon_cont           tinyint,
    @w_proban_cont        smallint,
    @w_cat_cont           catalogo,
    @w_trn_cont           int,
    @w_ssn_cont           int,
    @w_valor_cont         money,
    @w_tipocta_super_cont char(1),
    @w_contador           int,
    @w_sp_name            descripcion,
    @w_mensaje            descripcion,
    @w_login_ope          varchar(10)

  select
    @w_sp_name = 'sp_ahpasdef2'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  /* Inicializacion de variables */

  select   @w_contador = 0

  /* Lectura para login operador batch*/
  select
    @w_login_ope = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'LOB'
     and pa_producto = 'ADM'

  if @i_turno is null
    select
      @i_turno = @s_rol

  begin tran
  /* Encuentra el SSN inicial */
  select
    @w_ssn = se_numero
  from   cobis..ba_secuencial

  if @@rowcount <> 1
  begin
    /* Error en lectura de SSN */
    exec cobis..sp_cerror
      @i_num = 201163
    return 201163
  end

  update cobis..ba_secuencial
  set    se_numero = @w_ssn + 4000000

  if @@rowcount <> 1
  begin
    /* Error en actualizacion de SSN */
    exec cobis..sp_cerror
      @i_num = 205031
    return 205031
  end

  commit tran

/* Grabar las transacciones de servicio para la contabilizacion */
  /* de Intereses Calculados                                      */

  begin tran
  declare intereses cursor for
    select
      ac_oficina,
      ac_moneda,
      ac_prod_banc,
      ac_categoria,
      ac_trn,
      ac_ssn,
      ac_intereses,
      ac_tipocta_super
    from   cob_ahorros..ah_acumulador
    where  ac_fecha = @i_fecha
       and ac_trn in (271, 323)
    for read only

  open intereses

  fetch intereses into @w_ofi_cont,
                       @w_mon_cont,
                       @w_proban_cont,
                       @w_cat_cont,
                       @w_trn_cont,
                       @w_ssn_cont,
                       @w_valor_cont,
                       @w_tipocta_super_cont

  if @@fetch_status = -1
  begin
    close intereses
    deallocate intereses
    exec cobis..sp_cerror
      @i_num = 201157
    select
      @o_procesadas = @w_contador
    return 201157
  end
  else if @@fetch_status = -2
  begin
    close intereses
    deallocate intereses
    select
      @o_procesadas = @w_contador
    return 0
  end

  while @@fetch_status = 0
  begin
    insert into cob_ahorros..ah_tran_servicio
                (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
                 ts_usuario,
                 ts_terminal,ts_oficina,ts_reentry,ts_origen,ts_cta_banco,
                 ts_valor,ts_moneda,ts_oficina_cta,ts_prod_banc,ts_categoria,
                 ts_tipocta_super,ts_turno)
    values      (@w_ssn_cont,@w_ssn_cont,@w_trn_cont,@i_fecha,@w_login_ope,
                 'consola',@w_ofi_cont,'N','U','0',
                 @w_valor_cont,@w_mon_cont,@w_ofi_cont,@w_proban_cont,
                 @w_cat_cont,
                 @w_tipocta_super_cont,@i_turno)
    if @@error <> 0
    begin
      rollback tran
      print 'Procesando ...'

      select
        @w_mensaje = 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO'

      insert into cob_ahorros..re_error_batch
      values      ('0',@w_mensaje)

      if @@error <> 0
      begin
        /* Error en grabacion de archivo de errores */
        exec cobis..sp_cerror
          @i_num = 203035

        /* Cerrar y liberar cursor */
        close intereses
        deallocate intereses

        select
          @o_procesadas = @w_contador
        return 203035
      end

      return 1

    end

    select
      @w_contador = @w_contador + 1

    fetch intereses into @w_ofi_cont,
                         @w_mon_cont,
                         @w_proban_cont,
                         @w_cat_cont,
                         @w_trn_cont,
                         @w_ssn_cont,
                         @w_valor_cont,
                         @w_tipocta_super_cont

    if @@fetch_status = -1
    begin
      rollback tran

      close intereses
      deallocate intereses

      exec cobis..sp_cerror
        @i_num = 201157

      select
        @o_procesadas = @w_contador
      return 201157
    end

  end

  -- Cerrar y liberar el cursor
  close intereses
  deallocate intereses

  select
    @o_procesadas = @w_contador

  commit tran

  return 0

go

