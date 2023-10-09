/************************************************************************/
/*	Archivo: 		sp_cuentamov_mig.sp			*/
/*	Stored procedure: 	sp_cu_mov_mig				*/
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
/*	Extrae de la tabla cb_cuenta,todas las cuentas que sean de 	*/
/*	movimiento y que esten vigentes para todas las empresas.	*/
/*	Generando asi la funcion:					*/
/*	"int codcta(char c[], char mo[], char e[])" del 		*/
/*	archivo cbcatalogo.h						*/
/*									*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR			RAZON			*/
/************************************************************************/

use cob_conta
go

if exists(select 1 from sysobjects where name = 'sp_cu_mov_mig')
   drop proc sp_cu_mov_mig
go

create proc sp_cu_mov_mig
as
declare 
@w_cu_empresa		tinyint,
@w_cu_cuenta		char(20),
@w_cu_moneda		tinyint,
@w_numero		int,
@w_linea		varchar(255),
@w_campo		varchar(255),
@w_num_campos		int,
@w_cuenta		money


select @w_num_campos = count(*) + 1
from   cob_conta..cb_cuenta
where  cu_estado = 'V' and cu_movimiento = 'S'

select @w_numero = 1
select @w_linea = ''

print 'int codcta(char c[], char mo[], char e[])'
print '{'
print '   int i,longitud;'
print '   char *n[%1!][3] = {'+cast(@w_num_campos as varchar)

declare cursor_cuenta cursor for
select 
cu_empresa,	cu_cuenta,	cu_moneda
from cob_conta..cb_cuenta
where  cu_estado = 'V' and cu_movimiento = 'S'

open cursor_cuenta

fetch cursor_cuenta into
@w_cu_empresa, @w_cu_cuenta, @w_cu_moneda

while @@fetch_status = 0 begin


   select @w_campo = '{"'+right('000'+convert (varchar(3),@w_cu_empresa),3)+'","'+ltrim(rtrim((convert (char(20),@w_cu_cuenta))))+'","'+right('00'+convert (varchar(2),@w_cu_moneda),2)+'"},'

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

   
   fetch cursor_cuenta into
   @w_cu_empresa, @w_cu_cuenta, @w_cu_moneda
end
close cursor_cuenta
deallocate cursor_cuenta

select @w_linea = @w_linea + '{"FIN","FIN"}'
print '%1!'+cast(@w_linea as varchar)
print '};'
print '   for(i=0;i<%1!;i++)'+cast(@w_num_campos as varchar)
print '      if(strcmp(e,n[i][0])==0){'
print '         longitud = strlen(n[i][1]);'
print '         if (strncmp(n[i][1],c,longitud)==0){'
print '            if (strcmp(mo,n[i][2])==0)'
print '               return 0;'
print '            else'
print '               return 1;'
print '         }'
print '      }'
print '   return 2;'
print '}'


return 0
go
