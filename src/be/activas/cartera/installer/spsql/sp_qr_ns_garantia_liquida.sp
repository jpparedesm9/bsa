/************************************************************************/
/*    Base de datos:            cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:                                                   */
/*      Fecha de escritura:                                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'.                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                         PROPOSITO                                    */
/* Proceso para consultar y actualizar registros para enviar garantías  */
/* liquidas                                                             */
/************************************************************************/  
/*                        MOFICACIONES                                  */
/* 00/000/0000            Version inicial                               */
/* 13/Jun/2022    ACH     REQ #185234-funcionalidad para individuales   */
/************************************************************************/  

use cob_cartera
go

IF OBJECT_ID ('dbo.sp_qr_ns_garantia_liquida') IS NOT NULL
	DROP PROCEDURE dbo.sp_qr_ns_garantia_liquida
GO

create proc sp_qr_ns_garantia_liquida (	
	@i_operacion		char(1),
	@i_tramite 			int 	= null,
	@i_estado			char(1) = null
)
as
declare @w_toperacion varchar(20)


if @i_operacion = 'Q' select @w_toperacion = 'GRUPAL' --Consulta para garantias liquidas grupales
else if @i_operacion = 'L'  select @w_toperacion = 'INDIVIDUAL' --Consulta para garantias liquidas individuales

	
if @i_operacion = 'Q' or @i_operacion = 'L' begin

   select ngl_tramite
   from ca_ns_garantia_liquida
   where ngl_estado  = 'P' --Pendiente
   and ngl_operacion = @w_toperacion
    
   update ca_ns_garantia_liquida set
   ngl_estado 	        = 'E' --En Proceso
   where ngl_estado 	= 'P'
   and ngl_operacion   = @w_toperacion
    
   if @@rowcount = 0
   begin 
   	return 1
   end
end 

--Actualiza estado
if @i_operacion = 'U'
begin
	update ca_ns_garantia_liquida
	   set ngl_estado 	= @i_estado
	 where ngl_tramite 	= @i_tramite
 
end
return 0

go
