/************************************************************************/
/*	Archivo:		    rubroqry_seudo.sp                               */
/*	Stored procedure:	sp_rubro_qry_seudo    		                    */
/*	Base de datos:		cob_cartera				                        */
/*	Producto: 		    Credito y Cartera                               */
/*	Disenado por:  		TBA                                             */
/*	Fecha de escritura:	20/12/2016				                        */
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
/*	Este stored procedure recupera el seudocatalogo de los conceptos.   */
/************************************************************************/
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR		RAZON				                        */
/*  20/12/2016  TBA     	Emision Inicial			                    */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_rubro_qry_seudo')
	drop proc sp_rubro_qry_seudo
go


create proc sp_rubro_qry_seudo 
as
declare 
@w_sp_name	descripcion,
@w_error	int


/*  INICIALIZAR VARIABLES  */
select	@w_sp_name = 'sp_rubro_qry_seudo'

/* Recupera valores del Seudocatalogo */
         select 'Codigo'        = co_concepto,
                'Descripcion'   = co_descripcion
         from ca_concepto
		 where co_categoria in ('S','O','I','M', 'Q') 
         
         if @@error!=0 begin
            select @w_error = 6900089
            goto ERROR
         end
              
return 0

ERROR:
exec cobis..sp_cerror
@t_debug='N',         @t_file = null,
@t_from =@w_sp_name,   @i_num = @w_error

return @w_error 

go

