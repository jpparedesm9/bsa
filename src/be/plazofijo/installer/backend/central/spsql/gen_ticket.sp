
/************************************************************************/
/*      Archivo:                gen_ticket.sp                           */
/*      Stored procedure:       sp_gen_ticket                           */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Gabriela Estupinan                      */
/*      Fecha de documentacion: 23/Nov/98                               */
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
/*      Este script crea la funcion que genera el secuencial utilizado  */
/*      en el ticket monetario                                          */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR                  RAZON                         */
/*      23-Nov-98  Gabriela Estupinan     Creacion                      */
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

if exists (select 1 from sysobjects where type = 'P' and name = 'sp_gen_ticket')
   drop proc sp_gen_ticket
go

create proc sp_gen_ticket (
@t_debug                char(1) = 'N',
@t_file	                varchar(14) = NULL,
@t_from	                varchar(32) = NULL,
@i_oficina              int,
@o_secuencial           int out)
with encryption
as
declare       	
@w_sp_name              varchar(30)

/* Captura del nombre del Stored Procedure */
select	@w_sp_name = 'sp_gen_ticket'

/* Modo de debug */

begin tran
   if exists (select * from pf_conversion_ticket where ct_oficina = @i_oficina)
   begin
     select @o_secuencial = ct_secuencial + 1
     from pf_conversion_ticket
     where ct_oficina = @i_oficina

     update pf_conversion_ticket 
     set ct_secuencial = @o_secuencial
     where ct_oficina = @i_oficina
     
     if @@error <> 0
     begin
        exec cobis..sp_cerror
        @t_debug        = @t_debug,
        @t_file         = @t_file,
        @i_num          = 145041
        return 1
     end              

   end
   else
   begin
     insert into pf_conversion_ticket
     values (@i_oficina,1)
     
     if @@error <> 0
     begin
        exec cobis..sp_cerror
        @t_debug        = @t_debug,
        @t_file         = @t_file,
        @i_num          = 143046
        return 1
     end              

     select @o_secuencial = 1

   end 

commit tran

return 0
go



