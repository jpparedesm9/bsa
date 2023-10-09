/************************************************************************/
/*      Archivo:                gensec.sp                               */
/*      Stored procedure:       sp_gensec                               */
/*      Base de datos:          cob_custodia                            */
/*      Producto:               Custodia                                */
/*      Disenado por:                                                   */
/*      Fecha de escritura:     Jun. 1996                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Procedimiento que genera el secuencial                          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      Jun 1998        L. ALvarado     Emision inicial                 */
/************************************************************************/
use cob_custodia
go

set ansi_nulls off
go

if exists (select 1 from sysobjects where name = 'sp_gensec')
        drop proc sp_gensec
go

create proc sp_gensec
as

declare @secuencia int

exec @secuencia = ADMIN...rp_ssn --1, 2 se comenta para SQL2008

return @secuencia

go