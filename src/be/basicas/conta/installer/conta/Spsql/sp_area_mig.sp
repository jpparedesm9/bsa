/************************************************************************/
/*	Archivo: 		sp_area_mig.sp				*/
/*	Stored procedure: 	sp_em_area_mig				*/
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
/*	Extrae de la tabla cb_area, todos los codigos de las areas que 	*/
/*	esten vigentes y sean de movimiento para todas las empresas.	*/
/*	Generando asi la funcion "int area(char c[], char e[])" del 	*/
/*	archivo cbcatalogo.h						*/
/*									*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR			RAZON			*/
/************************************************************************/

use cob_conta
go

if exists(select 1 from sysobjects where name = 'sp_em_area_mig')
   drop proc sp_em_area_mig
go

create proc sp_em_area_mig
as
declare 
@w_numero		int,
@w_linea		varchar(255),
@w_campo		varchar(255),
@w_num_campos		int,
@w_ararea		smallint, 
@w_arempresa		tinyint

select @w_num_campos = count(*) + 1
from   cob_conta..cb_area
where  ar_estado = 'V'
and    ar_movimiento = 'S'

select @w_numero = 1
select @w_linea = ''

print 'int area(char c[], char e[])'
print '{'
print '   int i;'
print '   char *n[%1!][2] = {'+cast(@w_num_campos as varchar)

declare cursor_area_empresa cursor for
select 
      ar_empresa,
      ar_area
      from   cob_conta..cb_area
      where ar_estado = 'V'  and    ar_movimiento = 'S'
      order by ar_empresa,ar_area 

open cursor_area_empresa

fetch cursor_area_empresa into
@w_arempresa,@w_ararea 

while @@fetch_status = 0 begin

   select @w_campo	=	'{"'+ right('000'+convert (varchar(3),@w_arempresa),3)+'","'+convert (char(4),@w_ararea)+'"},'
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
   
   fetch cursor_area_empresa into
   @w_arempresa,@w_ararea 
end
close cursor_area_empresa

deallocate cursor_area_empresa

select @w_linea = @w_linea + '{"FIN","FIN"}'
print '%1!'+cast(@w_linea as varchar)
print '};'
print '   for(i=0;i<%1!;i++)'+cast(@w_num_campos as varchar)
print '       if(strcmp(e,n[i][0])==0){'
print '          if (strcmp(c,n[i][1])==0)'
print '               return 0;'
print '       }'
print '       return 1;'
print '}'

return 0
go
