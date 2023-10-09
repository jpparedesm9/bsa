
/************************************************************************/
/*      Archivo:                round.sp                                */
/*      Stored procedure:       sp_round                                */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 24/Oct/94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Funcion que redondea los montos a dos decimales                 */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      25-Nov-94  Juan Lam           Creacion                          */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where type = 'P' and name = 'sp_round')
   drop proc sp_round
go

create proc sp_round(
@i_valor                float,
@o_resultado            money  = NULL out,
@o_resto                float  = NULL out)
with encryption
as
select @o_resultado = floor((@i_valor + 1/1000000000000.00) * 100)/100
select @o_resto     = @i_valor - convert(float,@o_resultado)
return 0
go
