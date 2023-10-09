/************************************************************************/
/*	Archivo:		    tipcus_seud.sp                                  */
/*	Stored procedure:	sp_tipo_cust_seudo    		                    */
/*	Base de datos:		cob_custodia			                        */
/*	Producto: 		    Garantía                                        */
/*	Disenado por:  		TBA                                             */
/*	Fecha de escritura:	17/01/2017				                        */
/************************************************************************/
/*				IMPORTANTE				                                */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	"MACOSA".							                                */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/************************************************************************/  
/*				PROPOSITO			                        	        */
/*	Este programa recupera el seudocatalogo de los tipos custodia.      */
/************************************************************************/
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR		RAZON				                        */
/*  17/01/2017  TBA     	Emision Inicial			                    */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_tipo_cust_seudo')
	drop proc sp_tipo_cust_seudo
go


create proc sp_tipo_cust_seudo 
as
declare 
@w_sp_name	descripcion,
@w_error	int


/*  INICIALIZAR VARIABLES  */
select	@w_sp_name = 'sp_tipo_cust_seudo'


select "TIPO" = tc_tipo,
"DESCRIPCION" = substring(tc_descripcion,1,25)
from cu_tipo_custodia  


if @@error!=0 begin
            select @w_error = 1901003
            goto ERROR
         end
              
return 0

ERROR:
exec cobis..sp_cerror
@t_debug='N',
@t_from =@w_sp_name,
@i_num = @w_error

return @w_error 

go
