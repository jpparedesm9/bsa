/************************************************************************/
/*      Archivo:                fin_dia.sp                              */
/*      Stored procedure:       sp_fdia                                 */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           JJMD                                    */
/*      Fecha de documentacion: 23-Sep-2009                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa sustituye al SQR que ejecuta el sp_batch_fin_dia  */
/*                                                                      */
/************************************************************************/
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR              RAZON                           */
/*      23-Sep-2009  JJMD               Emision Inicial.                */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_fdia' and type = 'P')
   drop proc sp_fdia
go

create proc sp_fdia(
@i_param1               varchar(255))
with encryption
as
declare 
@w_return               int,
@i_fecha                datetime
   
select @i_fecha = convert(datetime, @i_param1)
      
exec @w_return   = sp_batch_fin_dia
@i_fecha_proceso = @i_fecha,
@s_date          = @i_fecha,
@i_en_linea      = 'N'

if @w_return <> 0
   return @w_return

return 0
go

