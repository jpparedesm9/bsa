/************************************************************************/
/*      Archivo:                ahtotali.sp                             */
/*      Stored procedure:       sp_ahtotaliza                           */
/*      Base de datos:          cob_ahorros                             */
/*      Producto: Cuentas Ahorros                                       */
/*      Disenado por:          Marco Sanguino                          */
/*      Fecha de escritura: 12-Nov-1999                                 */
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
/*      Este programa calcula intereses ganados en cuentas de ahorros   */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA            AUTOR                 RAZON                    */
/*  01/Nov/1999    Marco Sanguino           Emision Inicial             */
/*  02/May/2016    J. Calderon              Migración a CEN             */
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
           where  name = 'sp_ahtotaliza')
  drop proc sp_ahtotaliza
go

create proc sp_ahtotaliza
(
  @t_show_version bit = 0,
  @i_fecha        datetime,
  @o_procesadas   int out
)
with recompile
as
  declare
    @w_return   int,
    @w_mensaje  varchar(254),
    @w_contador int,
    @w_ssn      int,
    @w_sp_name  varchar(30)

  select
    @w_sp_name = 'sp_ahtotaliza'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end
  /* Inicializacion de variables */

  select
    @w_contador = 0

  create table #rango
  (
    ra_rango tinyint not null,
    ra_desde money not null,
    ra_hasta money not null
  )
  if @@error <> 0
  begin
    /* ERROR EN LA CREACION DE LA TABLA TEMPORAL */
    exec cobis..sp_cerror
      @i_num = 909000
    select
      @o_procesadas = @w_contador
    return 909000
  end

  begin tran

  insert into cob_ahorros..ah_total_ciiu
    select
      @i_fecha,ec_secuencial,count(1),sum(
      ah_disponible + ah_12h + ah_24h + ah_remesas),ah_prod_banc,
      ah_moneda,ah_oficina,ah_estado,ah_categoria,round(
      sum(ah_tasa_hoy) / count(1),
            2)
    from   cob_ahorros..ah_cuenta,
           cob_remesas..re_escala_ciiu
    where  ah_filial                                      = 1
       and ah_categoria                                   <> 'B'
       and (ah_disponible + ah_12h + ah_24h + ah_remesas) > ec_saldo_desde
       and (ah_disponible + ah_12h + ah_24h + ah_remesas) <= ec_saldo_hasta
    group  by ec_secuencial,
              ah_prod_banc,
              ah_moneda,
              ah_oficina,
              ah_estado,
              ah_categoria

  if @@error <> 0
  begin
    print 'Procesando ...1'

    rollback tran

    select
      @w_mensaje = 'REGISTROS YA EXISTEN'
    insert into cob_ahorros..re_error_batch
    values      ('0',@w_mensaje)

    if @@error <> 0
    begin
      /* Error en grabacion de archivo de errores */
      exec cobis..sp_cerror
        @i_num = 203035

      /* Cerrar y liberar cursor */

      return 203035
    end

    return 1
  end

  insert into #rango
    select
      ra_rango,ra_desde,ra_hasta
    from   cob_remesas..pe_rango
    where  ra_tipo_rango  = 1
       and ra_grupo_rango = 1
  if @@error <> 0
  begin
    rollback tran
    print 'Error en la insercion en la tabla temporal #rango'
    return 1

  end

  insert into cob_ahorros..ah_total_escala
    select
      @i_fecha,ra_rango,count(1),sum(ah_disponible + ah_12h + ah_24h +
                                     ah_remesas)
      ,
      sum(ah_min_dispmes),
      ah_prod_banc,ah_moneda,(round(sum(ah_tasa_hoy) / count(1),
             2)),ah_categoria,ah_estado
    from   cob_ahorros..ah_cuenta,
           #rango
    where  ah_filial        = 1
       and ah_estado        <> 'C'
       and ah_prod_banc     = 1
       and ah_categoria     <> 'B'
       and (ah_min_dispmes) > ra_desde
       and (ah_min_dispmes) <= ra_hasta
    group  by ra_rango,
              ah_prod_banc,
              ah_moneda,
              ah_categoria,
              ah_estado

  if @@error <> 0
  begin
    print 'Procesando ...2'

    rollback tran

    select
      @w_mensaje = 'REGISTROS YA EXISTEN'
    insert into cob_ahorros..re_error_batch
    values      ('0',@w_mensaje)

    if @@error <> 0
    begin
      /* Error en grabacion de archivo de errores */
      exec cobis..sp_cerror
        @i_num = 203035

      /* Cerrar y liberar cursor */

      return 203035
    end

    return 1
  end

  /* Producto Bancario diferente de 1 */
  insert into cob_ahorros..ah_total_escala
    select
      @i_fecha,ra_rango,count(1),sum(ah_disponible + ah_12h + ah_24h +
                                     ah_remesas)
      ,
      sum(ah_min_dispmes),
      ah_prod_banc,ah_moneda,(round(sum(ah_tasa_hoy) / count(1),
             2)),ah_categoria,ah_estado
    from   cob_ahorros..ah_cuenta,
           #rango
    where  ah_filial                                      = 1
       and ah_estado                                      <> 'C'
       and ah_prod_banc                                   <> 1
       and ah_categoria                                   <> 'B'
       and (ah_disponible + ah_12h + ah_24h + ah_remesas) > ra_desde
       and (ah_disponible + ah_12h + ah_24h + ah_remesas) <= ra_hasta
    group  by ra_rango,
              ah_prod_banc,
              ah_moneda,
              ah_categoria,
              ah_estado

  if @@error <> 0
  begin
    print 'Procesando ...3'

    rollback tran

    select
      @w_mensaje = 'REGISTROS YA EXISTEN'
    insert into cob_ahorros..re_error_batch
    values      ('0',@w_mensaje)

    if @@error <> 0
    begin
      /* Error en grabacion de archivo de errores */
      exec cobis..sp_cerror
        @i_num = 203035

      /* Cerrar y liberar cursor */

      return 203035
    end

    return 1
  end

  commit tran

  return 0

go

