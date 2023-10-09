/************************************************************************/
/*	Archivo: 		sp_concepto_ret_mig.sp			*/
/*	Stored procedure: 	sp_concepto_ret_mig			*/
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
/*	Extrae para todas las empresas los tipos de impuesto con sus 	*/
/*	respectivos codigos.  Generando asi la funcion:			*/
/*	"int conceptoret(char c[], char e[], char p[])"	del archivo	*/
/*	cbcatalogo.h							*/					
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR			RAZON			*/
/************************************************************************/
use cob_conta
go

if exists(select 1 from sysobjects where name = 'sp_concepto_ret_mig')
   drop proc sp_concepto_ret_mig
go
if exists(select 1 from sysobjects where name = 'conceptos')
   drop table conceptos
go

create proc sp_concepto_ret_mig
as
declare
@w_numero		int,
@w_linea		varchar(255),
@w_campo		varchar(255),
@w_num_campos		int,
@w_empresa		tinyint,
@w_concepto		varchar(10),
@w_tipo			char(1),
@w_afectacion		char(1)

if exists(select 1 from sysobjects where name = 'conceptos')
   drop table conceptos

/* CARGA TABLA TEMPORAL */
select empresa= iva_empresa, codigo = iva_codigo, tipo= 'I',afectacion = iva_debcred
into conceptos
from cob_conta..cb_iva
union
select ic_empresa, ic_codigo,'C',ic_debcred
from cob_conta..cb_ica
union
select ip_empresa, ip_codigo,'P',ip_debcred
from cob_conta..cb_iva_pagado
union
select cr_empresa, cr_codigo ,'T',cr_debcred
from cob_conta..cb_conc_retencion
where cr_tipo = 'T'
union
select cr_empresa, cr_codigo, 'R',cr_debcred
from cob_conta..cb_conc_retencion
where cr_tipo = 'R'
 
select @w_num_campos = count(*)+1
from   cob_conta..conceptos

select @w_numero = 1
select @w_linea = ''

print 'int conceptoret(char c[], char e[], char p[])'
print '{'
print '   int i;'
print '   char *n[%1!][4] = {'+cast(@w_num_campos as varchar)

declare cursor_concepto_ret cursor for
select empresa,
       codigo,
       tipo,
       afectacion 
       from cob_conta..conceptos
       order by empresa, tipo, codigo,afectacion

open cursor_concepto_ret

fetch cursor_concepto_ret into
@w_empresa,		
@w_concepto,		
@w_tipo,		
@w_afectacion		

while @@fetch_status = 0 begin
   select @w_campo	=	'{"'+right('000'+convert (varchar(3),@w_empresa),3)+'","'+ltrim(convert (varchar(4),@w_concepto))+'","'+ltrim(rtrim(convert (char(1),@w_tipo)))+'","'+ltrim(rtrim(convert(char(1),@w_afectacion)))+'"},'

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
  
   fetch cursor_concepto_ret into
   @w_empresa,@w_concepto,@w_tipo,@w_afectacion

end

close cursor_concepto_ret

deallocate cursor_concepto_ret
select @w_linea = @w_linea + '{"FIN","FIN"}'
print '%1!'+cast(@w_linea as varchar)
print '};'
print ' for(i=0;i<%1!;i++)'+cast(@w_num_campos as varchar)
print ' {'
print '     if (strcmp(e,n[i][0])==0){'
print '         if (strcmp(c,n[i][1])==0){'
print '            if (strcmp(p,n[i][2])==0){'
print '         	 if (strcmp("C",n[i][3])==0)'
print '         	 {'
print '                      return 2;'
print '                  }'
print '                	 if (strcmp("D",n[i][3])==0){'
print '               	     return 3;'
print '               	 }'	
print '            }'
print '         }'
print '     }'
print '  }'
print '     return 1;'
print '}'

return 0
go
