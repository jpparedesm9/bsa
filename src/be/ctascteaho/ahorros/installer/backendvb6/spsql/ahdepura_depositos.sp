/************************************************************************/
/*  Archivo:            ahdepura_depositos.sp                           */
/*  Stored procedure:   sp_ahdepura_depositos                           */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas Ahorros.                                */
/*  Disenado por:       Johnny Mora U.                                  */
/*  Fecha de escritura: 27-Mar-2000                                     */
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
/*                                                                      */
/*  Este programa realiza la depuracion de las tablas de depositos.     */
/*                                                                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  27/Mar/2000 J. Mora     Emision inicial                             */
/*  02/May/2016 I. Yupa     Migración a CEN                             */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ahdepura_depositos')
  drop proc sp_ahdepura_depositos
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ahdepura_depositos
(  
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(30) = null,
  @t_show_version bit = 0,
  @i_fecha_inicio smalldatetime
)
as
  declare
    @w_sp_name    varchar(30),
    @w_contador   int,
    @w_cuantos    int,
    @w_residuo    int,
    @w_porcentaje int,
    @w_mensaje    varchar(80),
    @w_total      int,
    @w_total_reg  varchar(10)

  /*  Captura nombre del stored procedure   */
  select
    @w_sp_name = 'sp_ahdepura_depositos',
    @w_contador = 1,
    @w_cuantos = 0,
    @w_residuo = 5000

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_total = count(1)
  from   cob_ahorros..ah_ciudad_deposito
  where  cd_cuenta    > 0
     and cd_fecha_efe <= @i_fecha_inicio

  while @w_contador = 1
  begin
    set rowcount 1000

    delete cob_ahorros..ah_ciudad_deposito
    where  cd_cuenta    > 0
       and cd_fecha_efe <= @i_fecha_inicio

    if @@rowcount >= 1000
    begin
      select
        @w_cuantos = @w_cuantos + 1000
    --          dump tran cob_ahorros with no_log
    end
    else
    begin
      select
        @w_contador = 2
    end

    if (@w_cuantos % @w_residuo) = 0
    begin
      print 'SE HAN BORRADO DEL HISTORICO DE DEPOSITOS: ' + convert(varchar(10),
            @w_cuantos)
    --'SE HAN BORRADO DEL HISTORICO DE DEPOSITOS:%1!',@w_cuantos
    end

  end -- while

  select
    @w_total_reg = convert(varchar(10), @w_total)
  select
       @w_mensaje = 'EL TOTAL DE REGISTROS BORRADOS EN AH_CIUDAD_DEPOSITO SON: '
                    +
                    @w_total_reg
  insert into cob_remesas..re_error_batch
  values      ('0',@w_mensaje)
  print @w_mensaje

  return 0

go

