/************************************************************************/
/*	Archivo: 	        venpolnc.sp                             */ 
/*	Stored procedure:       sp_vcto_poliza                          */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Laura Alvarado			      	*/
/*	Fecha de escritura:     Abril-1998  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Cambiar automticamente el estado de la poliza comparando        */
/*	la fecha de vencimiento con la fecha de proceso                 */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		    RAZON			*/
/*	Abr/1998        L.Castellanos    Emision Inicial		*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_vcto_poliza')
    drop proc sp_vcto_poliza
go
create proc sp_vcto_poliza (
   @s_date               datetime = null,
   @t_from               varchar(30) = null,
   @i_fecha_proceso      datetime = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32)  /* nombre stored proc*/
 

select @w_today = @s_date
select @w_sp_name = 'sp_vcto_poliza'
begin tran
   update cu_poliza
   set po_estado_poliza = 'VEN'
   where po_fvigencia_fin <= @i_fecha_proceso
   and   po_estado_poliza = 'VIG'
   if @@error <> 0
   begin
      select @w_return = 1905015
      goto ERROR
   end
commit tran
return 0
ERROR:
exec cobis..sp_cerror 
@t_from  = @w_sp_name,
@i_num   = @w_return
return 1
go