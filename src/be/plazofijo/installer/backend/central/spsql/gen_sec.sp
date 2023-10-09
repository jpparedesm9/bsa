/************************************************************************/
/*      Archivo:                gen_secu.sp                             */
/*      Stored procedure:       sp_gen_sec                              */
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
/*      Este script crea la funcion que genera la el secuencial         */
/*      utilizado en los procesos batch                                 */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      24-Oct-94  Juan Lam           Creacion                          */
/*  25-Nov-2016     N. Martillo        Correcciones                     */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where type = 'P' and name = 'sp_gen_sec')
   drop proc sp_gen_sec
go

create proc sp_gen_sec (
@s_date 	            datetime = NULL,
@i_inicio_fin           char(1)  = 'F' )
with encryption
as

declare @secuencia int
        
-- Se asigna un secuencial dependiendo si es inicio o fin de dia
if @i_inicio_fin = 'F'
begin
   select @secuencia = isnull(max(se_numero),0) + 1
   from cobis..ba_secuencial
   
   update cobis..ba_secuencial
   set se_numero = @secuencia 
end
else
   if @i_inicio_fin = 'I'
   begin
      select @secuencia = isnull(max(sn_numero),1)  - 1
      from cobis..ba_secuencial_neg
    
      update cobis..ba_secuencial_neg
      set sn_numero = @secuencia 
   end
return @secuencia
go
