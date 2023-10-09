/************************************************************************/
/*  Archivo:                c_plafin.sp                                 */
/*  Stored procedure:       sp_fecha_comercial                          */
/*  Base de datos:          cob_tesoreria                               */
/*  Producto:               TESORERIA                                   */
/*  Disenado por:           Nidia Silva                                 */
/*  Fecha de escritura:     09-Abr-1999                                 */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR  CORPORATION'.                                                 */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Este stored procedure ejecuta la rutina de suma de flujos de        */
/*  fondos.                                                             */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA                AUTOR              RAZON                       */
/*  09-Abr-1999          N. Silva           Emision inicial             */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_fecha_comercial') IS  NOT NULL
   drop proc sp_fecha_comercial
go

create procedure sp_fecha_comercial(
@i_fecha_inicial        datetime, 
@i_fecha_ultima         datetime,
@o_dias                 int out)
with encryption
as
declare 
@w_mesini               int,
@w_diaini               int,
@w_anioini              int,
@w_mesfin               int,
@w_diafin               int,
@w_aniofin              int,
@w_diferencia           int,
@w_total_dias           int,
@i_formato_fecha        tinyint 

BEGIN
   select @i_formato_fecha = 101
   select @w_mesini = convert(int, substring(convert (varchar, @i_fecha_inicial, @i_formato_fecha),1,2))
   select @w_diaini = convert(int, substring(convert (varchar, @i_fecha_inicial, @i_formato_fecha),4,2))
   select @w_anioini = convert(int, substring(convert (varchar, @i_fecha_inicial, @i_formato_fecha),7,4))

   -----------------------------
   -- Particionar fecha inicial
   -----------------------------
   select @w_mesfin = convert(int, substring(convert (varchar, @i_fecha_ultima, @i_formato_fecha),1,2))
   select @w_diafin = convert(int, substring(convert (varchar, @i_fecha_ultima, @i_formato_fecha),4,2))
   select @w_aniofin = convert(int, substring(convert (varchar, @i_fecha_ultima, @i_formato_fecha),7,4))

   /* Calculo de numero de dias */
   select @w_diferencia = (@w_diafin -  @w_diaini)
   IF @w_diferencia < 0 
   BEGIN
      select @w_diferencia = @w_diafin - @w_diaini + 30
      select @w_mesfin = @w_mesfin - 1
   END
   select @w_total_dias = @w_diferencia

   /* Calculo de numero de meses */
   select @w_diferencia = (@w_mesfin -  @w_mesini)
   IF @w_diferencia < 0 
   BEGIN
      select @w_diferencia = @w_mesfin - @w_mesini + 12
      select @w_aniofin = @w_aniofin - 1
   END
   select  @o_dias = ((@w_aniofin - @w_anioini) * 360) + (@w_diferencia * 30) + @w_total_dias

END
return 0

go

