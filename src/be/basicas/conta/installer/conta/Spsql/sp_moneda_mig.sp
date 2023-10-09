/************************************************************************/
/*	Archivo: 		sp_moneda_mig.sp			*/
/*	Stored procedure: 	sp_moneda_mig				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Johanna Botero     	        	*/
/*	Fecha de escritura:    	Febrero 2002				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*									*/
/*				PROPOSITO				*/
/*	Extrae del catalogo cl_moneda, los codigos de las monedas 	*/
/*	Generando asi la funcion "int moneda(char c[])" del 		*/
/*	archivo cbcatalogo.h						*/														
/*									*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR			RAZON			*/
/************************************************************************/

use cob_conta
go

if exists(select 1 from sysobjects where name = 'sp_moneda_mig')
   drop proc sp_moneda_mig
go

create proc sp_moneda_mig
as
declare 
@w_numero		int,
@w_linea		varchar(255),
@w_campo		varchar(255),
@w_num_campos		int,
@w_mo_moneda		tinyint

select @w_num_campos =  (select count(mo_moneda) from cobis..cl_moneda )+1
select @w_numero = 1
select @w_linea = ''

print 'int moneda(char c[])'
print '{'
print '  int i;'
print '  char *n[%1!] = {'+cast(@w_num_campos as varchar)

declare cursor_moneda cursor for

select    
mo_moneda
from   cobis..cl_moneda

open cursor_moneda

fetch cursor_moneda into
@w_mo_moneda		

while @@fetch_status = 0 begin

   select @w_campo	=	'"'+right('00'+convert (varchar(2),@w_mo_moneda),2) + '",'
   if @w_numero <= 5 begin
      if @w_numero = 1
         select @w_linea = @w_campo
      else
         select @w_linea = @w_linea + @w_campo  
      if @w_numero = 5 begin
         print'%1!'+cast(@w_linea as varchar)
         select @w_numero = 0
         select @w_linea = ''
      end    
   end

   select @w_numero = @w_numero + 1
   
   fetch cursor_moneda into
   @w_mo_moneda		
end
close cursor_moneda

deallocate cursor_moneda

select @w_linea = @w_linea + '"FIN"'
print '%1!'+cast(@w_linea as varchar)
print '};'
print '    for(i=0;i<%1!;i++)' +cast(@w_num_campos as varchar)
print'       if(strcmp(c,n[i])==0) return(0);'
print'    return 1;'
print'}'

return 0
go
