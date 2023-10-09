/************************************************************************/
/*	Archivo: 		sp_empresa_mig.sp			*/
/*	Stored procedure: 	sp_empresa_mig				*/
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
/*	Extrae de la tabla cb_empresa, todos los codigos de las  	*/
/*	empresas.							*/
/*	Generando asi la funcion "int codempresa (char c[] )" del 	*/
/*	archivo cbcatalogo.h						*/
/*									*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR			RAZON			*/
/************************************************************************/

use cob_conta
go

if exists(select 1 from cob_conta..sysobjects where name = 'sp_empresa_mig')
   drop proc sp_empresa_mig
go

create proc sp_empresa_mig
as
declare 
@w_numero		int,
@w_linea		varchar(255),
@w_campo		varchar(255),
@w_num_campos		int,
@w_em_empresa		tinyint

select @w_num_campos = count(*) +1
from   cob_conta..cb_empresa

select @w_numero = 1
select @w_linea = ''
print 'int codempresa (char c[] )'
print '{'
print '  int i;'
print '  char *n[%1!] = {'+cast(@w_num_campos as varchar)

declare cursor_empresa cursor for

select    
em_empresa
from   cob_conta..cb_empresa

open cursor_empresa

fetch cursor_empresa into
@w_em_empresa

while @@fetch_status = 0 begin

   select @w_campo	=	'"'+right('000'+convert (varchar(3),@w_em_empresa),3) + '",'

   if @w_numero <= 5 begin
      if @w_numero = 1
         select @w_linea = @w_campo
      else
         select @w_linea = @w_linea + @w_campo  

      if @w_numero = 5 begin
         print'%1!'+@w_linea
         select @w_numero = 0
         select @w_linea = ''
      end    
   end
   select @w_numero = @w_numero + 1
   
   fetch cursor_empresa into
   @w_em_empresa
end
close cursor_empresa

deallocate cursor_empresa

select @w_linea = @w_linea + '"FIN"'
print '%1!'+@w_linea
print '};'
print '    for(i=0;i<%1!;i++)' +cast(@w_num_campos as varchar)
print'       if(strcmp(c,n[i])==0) return(0);'
print'    return 1;'
print'}'

return  0
go
