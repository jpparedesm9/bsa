/************************************************************************/
/*  Archivo:            sdate.sp                                        */
/*  Stored procedure:   sp_sdate                                        */
/*  Base de datos:      cob_pfijo                                       */
/*  Producto:           Cuentas Corrientes                              */
/*  Disenado por:       GCA                                             */
/*  Fecha de escritura: 20/Oct/1993                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este programa realiza la consulta de la fecha para trabajar         */
/*  e interno para operacion.                                           */ 
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_sdate')
 drop proc sp_sdate
go

create proc sp_sdate (
@t_debug                                   char(1)          = 'N',
@t_file                                    varchar(14)      = NULL,
@t_from                                    varchar(32)      = NULL,
@s_date                                    datetime)
with encryption
as
select convert(varchar(10),@s_date,101)
return 0
go
