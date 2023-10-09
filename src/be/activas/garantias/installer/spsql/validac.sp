/************************************************************************************/
/*	Archivo:		validac.sp			*/
/*	Stored procedure:	sp_valid 				*/
/*	Base de datos:		cob_custodia		*/
/*	Producto: 		Garantias        		*/
/*	Disenado por:  		Laura Alvarado  		*/
/*	Fecha de escritura:	Jun. 1998 			*/
/************************************************************************************/
/*				IMPORTANTE		*/
/*Este programa es parte de los paquetes bancarios propiedad de	*/
/*"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*"NCR CORPORATION".					*/
/*Su uso no autorizado queda expresamente prohibido asi como	*/
/*cualquier alteracion o agregado hecho por alguno de sus		*/
/*usuarios sin el debido consentimiento por escrito de la 	                 */
/*Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************************/  
/*		PROPOSITO				*/
/*Genera los comprobantes contables de Garantias para una fecha    */
/*	dada.                                       		                */
/************************************************************************************/  
/*                             MODIFICACIONES                           		*/
/************************************************************************************/  
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_valid')
   drop proc sp_valid
go

create proc sp_valid
   @s_user		login    = null,
   @s_date              datetime = null,
   @i_filial            tinyint      = null
            
as declare 
   @w_error          	int,
   @w_return         	int,
   @w_sp_name        	descripcion,
   @w_mensaje           descripcion

/* VARIABLES DE TRABAJO */
select 
@w_sp_name         = 'validac.sp',
@w_mensaje         = ''

exec @w_return = cob_conta..sp_sasiento_val
	@i_operacion = 'V',
	@i_empresa = @i_filial,
	@i_producto = 19
if @w_return !=0 
     select @w_mensaje = 'ERR: EN VALIDACION' 


return 0

go