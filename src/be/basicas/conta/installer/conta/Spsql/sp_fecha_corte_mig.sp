/************************************************************************/
/*	Archivo: 		sp_fecha_corte_mig.sp			*/
/*	Stored procedure: 	sp_fecha_corte_mig			*/
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
/*	Extrae de la tabla cb_corte, el codigo de la empresa, 		*/
/*	la fecha inicial y la fecha_final para los cortes que esten 	*/
/*	activos o vigentes 						*/
/*	Generando asi la funcion "int fechatran(char c[], char e[]"  	*/
/*	del archivo cbcatalogo.h					*/
/*									*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR			RAZON			*/
/************************************************************************/

use cob_conta
go

if exists(select 1 from sysobjects where name = 'sp_fecha_corte_mig')
   drop proc sp_fecha_corte_mig
go

create proc sp_fecha_corte_mig
as
declare 
@w_co_fechaini		datetime,
@w_co_fechaven		datetime,
@w_co_corte		int,
@w_numero		int,
@w_linea		varchar(255),
@w_campo		varchar(255),
@w_num_campos		int,
@w_co_empresa		tinyint,
@w_co_periodo		int

select @w_num_campos = count(*)+1  
from   cob_conta..cb_corte
where  co_estado in ('V','A')

select @w_numero = 1
select @w_linea = ''

print 'int fechatran(char c[], char e[])'
print '{'
print '   int i,fecha;'
print '   char *n[%1!][3] = {'+cast(@w_num_campos as varchar)

declare cursor_fecha_corte cursor for
     select 
	co_empresa,
	co_fecha_ini,
	co_fecha_fin
	from   cob_conta..cb_corte
        where  co_estado in ('V','A') 
        
open cursor_fecha_corte

fetch cursor_fecha_corte into
@w_co_empresa,@w_co_fechaini,@w_co_fechaven 	 

while @@fetch_status = 0 begin

   select @w_campo	=	'{"'+right('000'+convert (varchar(3),@w_co_empresa),3)+'","'+convert(char(8),@w_co_fechaini,112) + '","' + convert(char(8),@w_co_fechaven,112) + '"},'

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
   
   fetch cursor_fecha_corte into
   @w_co_empresa,@w_co_fechaini,@w_co_fechaven 
end
close cursor_fecha_corte

deallocate cursor_fecha_corte
select @w_linea = @w_linea + '{"FIN","FIN"}'
print '%1!'+cast(@w_linea as varchar)
print '};'
print '   fecha=atoi(c);'
print '   for(i=0;i<%1!;i++)'+cast(@w_num_campos as varchar)
print '      if(strcmp(e,n[i][0])==0){'
print '         if ((atoi(n[i][1])<=fecha) && (atoi(n[i][2])>=fecha))'
print '            return 0;'
print '      } '
print '   return 1;'
print '}'

return 0
go
