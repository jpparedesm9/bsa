/************************************************************************/
/*      Archivo:                actualiza_tasa.sp                       */
/*      Stored procedure:       sp_actasa                                */
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

if exists (select 1 from sysobjects where name = 'sp_actasa' and type = 'P')
   drop proc sp_actasa
go

create proc sp_actasa
with encryption
as
declare  
@w_return   int,
@w_fecha    datetime
   
   
Select 
@w_fecha = rc_fecha_final_dia 	  
from cob_pfijo..pf_reg_control
   
   
exec @w_return = sp_informa_cambio_tasa
   @i_fecha_proceso 	= @w_fecha,
   @s_date 		= @w_fecha,
   @i_en_linea 		= 'N'

if @w_return <> 0
  return @w_return
return 0

