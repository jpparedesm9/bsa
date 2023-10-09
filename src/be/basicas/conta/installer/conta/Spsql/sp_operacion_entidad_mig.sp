/************************************************************************/
/*	Archivo: 		sp_operacion_entidad_mig.sp		*/
/*	Stored procedure: 	sp_operacion_ent_mig			*/
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
/*	Extrae los codigos de las operaciones con otras entidades 	*/
/*	Generando la funcion "int operbanco(char c[])" del archivo	*/
/*	cbcatalogo.h							*/												
/*									*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR			RAZON			*/
/************************************************************************/
use cob_conta
go

if exists(select 1 from sysobjects where name = 'sp_operacion_ent_mig')
   drop proc sp_operacion_ent_mig
go

create proc sp_operacion_ent_mig
as
declare 
@w_numero		int,
@w_linea		varchar(255),
@w_campo		varchar(255),
@w_num_campos		int,
@w_codigo_opera_ent	char(10)	

select @w_num_campos =  (select count (codigo) from cobis..cl_catalogo 
			where tabla =(select codigo from cobis..cl_tabla where tabla = 'cb_operacion_entidad'))+1
select @w_numero = 1
select @w_linea = ''

print 'int operbanco(char c[])'
print '{'
print '   int i;'
print '   char *n[%1!] = {'+cast(@w_num_campos as varchar)

declare cursor_operacion_entidad cursor for
select  codigo 
	from cobis..cl_catalogo 
	where tabla = (select codigo from cobis..cl_tabla where tabla = 'cb_operacion_entidad') 

open cursor_operacion_entidad

fetch cursor_operacion_entidad into
@w_codigo_opera_ent

while @@fetch_status = 0 begin
   select @w_campo	=	'"'+convert (char (4),@w_codigo_opera_ent)+'",'

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
   
   fetch cursor_operacion_entidad into
   @w_codigo_opera_ent
end
close cursor_operacion_entidad

deallocate cursor_operacion_entidad 
select @w_linea = @w_linea + '"FIN"'
print '%1!'+cast(@w_linea as varchar)
print '};'    
print '   for(i=0;i<%1!;i++)'+ cast(@w_num_campos as varchar)
print '      if (strcmp(c,n[i])==0) return 0;' 
print '   return 1;'
print '}'

return 0
go
