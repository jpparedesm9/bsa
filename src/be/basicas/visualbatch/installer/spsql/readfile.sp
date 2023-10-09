/************************************************************************/
/* Archivo:                readfile.sp                                  */
/* Stored procedure:       sp_readfile                                  */
/* Base de datos:          cobis                                        */
/* Producto:               batch                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     30-Marzo-1994                                */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'MACOSA', representantes exclusivos para el Ecuador de la         */
/*    'NCR CORPORATION'.                                                */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/************************************************************************/
/*                          PROPOSITO                                   */
/*    Este programa procesa las transacciones de:                       */
/*    Permite leer archivos de Unix al front-end                        */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA               AUTOR           RAZON                         */
/*    30-Mar-1994         R. Garces       Emision Inicial               */
/*    31-Oct-2002         D. Ayala        Revision Visual Batch         */
/************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where type = 'P' and name = 'sp_readfile')
   DROP PROC sp_readfile
go

create proc sp_readfile (
   @i_fileName varchar(255),
   @i_offset   int,
   @i_numlines smallint,
   @i_dir      char(1),
   @o_numlines int = NULL output,
   @o_more     tinyint= NULL output,
   @o_of_ini   int = NULL output,
   @o_of_fin   int = NULL output

)
as

declare  @w_more     tinyint

   exec  ADMIN...rp_readfile
         @i_fileName = @i_fileName,
         @i_offset   = @i_offset,
         @i_numlines = @i_numlines,
         @i_dir      = @i_dir,
         @o_numlines = @o_numlines out,
         @o_more     = @w_more out,
         @o_of_ini   = @o_of_ini out,
         @o_of_fin   = @o_of_fin out
   
   select @o_more = @w_more
return 0
go
