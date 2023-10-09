/************************************************************************/
/*	Archivo: 		sp_cuentapro_mig.sp			*/
/*	Stored procedure: 	sp_cu_proceso_mig			*/
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
/*	Extrae de la tabla cb_cuenta_proceso,las empresas que posean	*/
/*	cuentas asociadas al proceso 6003 y 6095			*/
/*	Generando asi la funcion "int ctaproceso (char c[], char e[])" 	*/
/*	del archivo cbcatalogo.h					*/
/*									*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR			RAZON			*/
/************************************************************************/
use cob_conta
go

if exists(select 1 from sysobjects where name = 'sp_cu_proceso_mig')
   drop proc sp_cu_proceso_mig
go

create proc sp_cu_proceso_mig
as
declare 
@w_cp_proceso     	smallint,
@w_cp_empresa 		tinyint,
@w_cp_cuenta		char (20),
@w_cp_condicion		char (4),
@w_numero		int,
@w_linea		varchar(255),
@w_campo		varchar(255),
@w_num_campos		int

select @w_num_campos = count(*) + 1
from   cob_conta..cb_cuenta_proceso
where  cp_proceso in (6003,6095)

select @w_numero = 1
select @w_linea = ''

print'int ctaproceso (char c[], char e[])'
print'{'
print'   int i,longitud;'
print'   char *n[%1!][4] = {'+cast(@w_num_campos as varchar)

declare cursor_cuenta cursor for
select 
cp_empresa, cp_proceso, cp_cuenta,
cp_condicion
from  cob_conta..cb_cuenta_proceso
where cp_proceso in (6003,6095)
order by cp_empresa, cp_proceso, cp_cuenta, cp_condicion

open cursor_cuenta

fetch cursor_cuenta into
@w_cp_empresa, @w_cp_proceso, @w_cp_cuenta, 
@w_cp_condicion

while @@fetch_status = 0 begin
   select @w_campo	=	'{"'+ right('000'+convert (varchar(3),@w_cp_empresa),3)+
				'","'+convert(char(4),@w_cp_proceso)+
				'","'+convert(varchar(20), @w_cp_cuenta)+
				'","'+right(convert(varchar(4),isnull(@w_cp_condicion,'X')),4)+'"},'
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
   @w_cp_empresa, @w_cp_proceso, @w_cp_cuenta, 
   @w_cp_condicion
end
close cursor_cuenta
deallocate cursor_cuenta

select @w_linea = @w_linea + '{"FIN","FIN"}'
print '%1!'+@w_linea
print '};'
print ' for(i=0; i<%1!;i++)'+cast(@w_num_campos as varchar)
print '      if(strcmp(e,n[i][0])==0){'
print '         longitud = strlen(n[i][2]);'
print '         if (strncmp(n[i][2],c,longitud)==0){'
print '            if (strcmp(n[i][1],"6003")==0 && strcmp(n[i][3],"X")==0)'
print '               return 2;'
print '	    if (strcmp(n[i][1],"6003")==0 && strcmp(n[i][3],"D")==0)'
print '	       return 3;'
print '	    if (strcmp(n[i][1],"6095")==0 && strcmp(n[i][3],"I")==0)'
print '	       return 4;'
print '	    if (strcmp(n[i][1],"6095")==0 && strcmp(n[i][3],"C")==0)'
print '               return 5;'
print '    	    if (strcmp(n[i][1],"6095")==0 && strcmp(n[i][3],"P")==0)'
print '               return 6;'
print '	    if (strcmp(n[i][1],"6095")==0 && strcmp(n[i][3],"T")==0)'
print '               return 7;'
print '	    if (strcmp(n[i][1],"6095")==0 && strcmp(n[i][3],"R")==0)'
print '               return 8;'
print '	    if (strcmp(n[i][1],"6095")==0 && strcmp(n[i][3],"V")==0)'
print '               return 20;'
print '	    if (strcmp(n[i][1],"6095")==0 && strcmp(n[i][3],"E")==0)'
print '               return 21;'
print '         }'
print '       }'
print '       return 1;'
print '}'
return 0
go
