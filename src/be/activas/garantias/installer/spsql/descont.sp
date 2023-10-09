/************************************************************************/
/*	Archivo:		descont.sp				*/
/*	Stored procedure:	sp_descon 				*/
/*	Base de datos:		cob_custodia			        */
/*	Producto: 		Garantias        			*/
/*	Disenado por:  		Laura Alvarado  			*/
/*	Fecha de escritura:	Jun. 1998 				*/
/************************************************************************/
/*				IMPORTANTE			        */
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".					        */
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/  
/*				PROPOSITO			        */
/*	Tercera Parte: descontabilizacion transacciones con error       */
/*	dada.                                                           */
/************************************************************************/  
/*                             MODIFICACIONES                           */
/*************************************************************************/  

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_descon')
   drop proc sp_descon
go

create proc sp_descon
   @s_user		login    = null,
   @s_date              datetime = null,
   @i_filial            int      = null,
   @i_fecha             datetime = null,
   @i_tipo_trn    	catalogo = null,
   @i_codigo_externo 	cuenta   = null  
            
as declare 
   @w_error          	int,
   @w_return         	int,
   @w_sp_name        	descripcion,
   @w_mensaje		varchar(255),
   @w_tran_modulo          varchar(20)


/* VARIABLES DE TRABAJO */
select 
@w_sp_name         = 'descont.sp',
@w_mensaje         = ''


begin tran



update 	cu_transaccion 
set 	tr_estado = 'I'
from 	cob_ccontable..cco_error_conaut
where   tr_codigo_externo = substring(ec_tran_modulo,charindex('-',ec_tran_modulo)+1,datalength(ec_tran_modulo))
and   	tr_secuencial     = convert(int,substring(ec_tran_modulo,1,charindex('-',ec_tran_modulo)-1))
and  	ec_producto = 19


update 	cu_transaccion 
set 	tr_estado = 'I'
from 	cu_errorlog
where   tr_codigo_externo = er_garantia

commit tran

return 0

go