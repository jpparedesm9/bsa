/************************************************************************/
/*	Archivo:		    tipo_garantia_seudo.sp                          */
/*	Stored procedure:	sp_tipo_garantia_seudo                          */
/*	Base de datos:		cob_cartera				                        */
/*	Producto: 		    Credito y Cartera                               */
/*	Disenado por:  		VBR                                             */
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
/*	Este stored procedure recupera el seudocatalogo de las garantías.   */
/************************************************************************/
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR		RAZON				                        */
/*  20/12/2016  VBR     	Emision Inicial			                    */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_tipo_garantia_seudo')
	drop proc sp_tipo_garantia_seudo
go


create proc sp_tipo_garantia_seudo 
as
declare 
@w_sp_name	descripcion,
@w_error	int


/*  INICIALIZAR VARIABLES  */
select	@w_sp_name = 'sp_tipo_garantia_seudo'

/* Recupera valores del Seudocatalogo */
        
    select 'TIPO GARANTIA'=substring(tc_tipo,1,10),
       'DESCRIPCION'  = substring(tc_descripcion,1,30)
    from cob_custodia..cu_tipo_custodia
    order by tc_tipo
         
         if @@rowcount = 0 begin
            select @w_error = 701000
            goto ERROR
         end
              
return 0

ERROR:
exec cobis..sp_cerror
@t_debug='N',         @t_file = null,
@t_from =@w_sp_name,   @i_num = @w_error

return @w_error 

go
         
         