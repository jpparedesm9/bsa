/************************************************************************/
/*	Archivo: 		excel.sp	    		        */
/*	Stored procedure: 	sp_excel   				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               Contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     05-Junio-2004 				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Maneja las seguridades de las hojas excel para declaraciones y  */
/*	certificados, no requiere de codigo simplemente se controla el	*/
/*	acceso a las hojas excel ejecutando el sp con el numero de tran	*/
/*	que le corresponde a cada hoja					*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	05/Jun/2004			Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_excel')
   drop proc sp_excel
go

create proc sp_excel    (
        @t_trn		smallint = null,
	@i_rol		smallint = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32)	/* nombre del stored procedure*/

select @w_today = getdate()
select @w_sp_name = 'sp_excel'


return 0

go

