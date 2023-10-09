/************************************************************************/
/*	Archivo:		        nscorresp.sp        			                     */
/*	Stored procedure:	  sp_ns_corresponsal_pago                          */
/*	Base de datos:		  cob_cartera                                      */
/*	Producto: 		     Cartera                                          */
/*	Disenado por:  		Santiago Mosquera                               */
/*	Fecha de escritura:	Junio 2019                                      */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*	Este programa es parte de los paquetes bancarios propiedad de	      */
/*	'MACOSA'.                                                            */
/*	Su uso no autorizado queda expresamente prohibido asi como           */
/*	cualquier alteracion o agregado hecho por alguno de sus              */
/*	usuarios sin el debido consentimiento por escrito de la              */
/*	Presidencia Ejecutiva de MACOSA o su representante.                  */
/*                              PROPOSITO	                              */
/*	                                                                     */ 
/*	Consulta y cambia el estado de las operaciones que se quiere generar */
/* una referencia de pago corresponsal para enviar por mail             */
/************************************************************************/
/*	                             MODIFICACIONES                          */
/*	    FECHA		   AUTOR		     RAZON                                */
/*	Junio   2019   S. Mosquera      Emision Inicial                      */
/************************************************************************/
use cob_cartera
go


if exists (select 1 from sysobjects where name = 'sp_ns_corresponsal_pago')
	drop proc sp_ns_corresponsal_pago
go

create proc sp_ns_corresponsal_pago (	
	@i_operacion		char(1),
	@i_banco			cuenta 	= null,
	@i_estado			char(1) = null
	)
 
AS


--Consulta
if @i_operacion = 'Q'
begin
	
	select ncp_banco,
		   ncp_estado
	  from ca_ns_corresponsal_pago
	 where ncp_estado = 'P' --Pendiente
	 
	 update ca_ns_corresponsal_pago
	   set ncp_estado 	= 'E' --En Proceso
	 where ncp_estado 	= 'P'
     
	if @@rowcount = 0
	begin 
		return 1
	end

end

--Actualiza estado
if @i_operacion = 'U'
begin
	update ca_ns_corresponsal_pago
	   set ncp_estado 		= @i_estado
	 where   ncp_banco	= @i_banco
 
end
return 0



go

