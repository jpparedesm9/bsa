/************************************************************************/
/*	Archivo:		    valor_aplicar_seudo.sp                          */
/*	Stored procedure:	sp_valor_aplicar_seudo   	                    */
/*	Base de datos:		cob_cartera				                        */
/*	Producto: 		    Credito y Cartera                               */
/*	Disenado por:  		VBR                                             */
/*	Fecha de escritura:	14/12/2016				                        */
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
/*	Este stored procedure recupera el seudocatalogo de los valores      */
/*  de la tasa a aplicar                                                */
/************************************************************************/
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR		RAZON				                        */
/*  14/12/2016  VBR     	Emision Inicial			                    */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_valor_aplicar_seudo')
	drop proc sp_valor_aplicar_seudo
go


create proc sp_valor_aplicar_seudo 
as
declare 
@w_sp_name	descripcion,
@w_error	INT,
@w_fecha    DATETIME


/*  INICIALIZAR VARIABLES  */
select	@w_sp_name = 'sp_valor_aplicar_seudo'
 

/* Recupera valores del Seudocatalogo */
         
      SELECT @w_fecha = fp_fecha FROM cobis..ba_fecha_proceso

      select
      'Codigo'      =   va_tipo,
      'Descripcion' =   va_descripcion,
      'Clase'       =   va_clase
      from ca_valor 
      where  va_pit  = 'N'
        
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
         
         