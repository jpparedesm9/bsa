/************************************************************************/
/*	Archivo: 		borrindmig.sp			        */
/*	Stored procedure: 	sp_borrindmig				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Pedro Coello Ramirez            	*/
/*	Fecha de escritura:     23-marzo-2001 				*/
/*************************************************************************/
/*				IMPORTANTE				 */
/*	Este programa es parte de los paquetes bancarios propiedad de	 */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	 */
/*	"NCR CORPORATION".						 */
/*	Su uso no autorizado queda expresamente prohibido asi como	 */
/*	cualquier alteracion o agregado hecho por alguno de sus		 */
/*	usuarios sin el debido consentimiento por escrito de la 	 */
/*	Presidencia Ejecutiva de MACOSA o su representante.		 */
/*				PROPOSITO				 */
/*	Este programa procesa las transacciones de:			 */
/*	Realiza validaciones efectuadas anteriormente en el 		 */
/*	cb_valmig.sqr        						 */
/*				MODIFICACIONES				 */
/*	FECHA		AUTOR		  RAZON				 */
/*      23-Marzo-2001   P. Coello         Emision Inicial	         */
/*************************************************************************/
use cob_conta_tercero
go

if exists (select * from sysobjects where name = 'sp_borrindmig')
	drop proc sp_borrindmig
go

create proc sp_borrindmig 
as 

drop index ct_migtran.i_migtran

return 0
go