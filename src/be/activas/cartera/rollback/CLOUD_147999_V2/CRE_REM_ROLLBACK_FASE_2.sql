
---ROLLBACK DE CAMPOS DE CR OP RENOVAR
--ANDY GONZALEZ 
use cob_externos 
go 



if exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'do_renovacion_grupal'
               AND Object_ID = Object_ID('cob_externos..ex_dato_operacion')) begin
   ALTER TABLE ex_dato_operacion
   drop column do_renovacion_grupal  
end

if exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'do_renovacion_ind'
               AND Object_ID = Object_ID('cob_externos..ex_dato_operacion')) begin
   ALTER TABLE ex_dato_operacion
   drop column do_renovacion_ind  
end

use cob_conta_super 
go 



if exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'do_renovacion_grupal'
               AND Object_ID = Object_ID('cob_conta_super..sb_dato_operacion_tmp')) begin
   ALTER TABLE sb_dato_operacion_tmp
   drop column do_renovacion_grupal  
end

if exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'do_renovacion_ind'
               AND Object_ID = Object_ID('cob_conta_super..sb_dato_operacion_tmp')) begin
   ALTER TABLE sb_dato_operacion_tmp
   drop column do_renovacion_ind  
end


if exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'do_renovacion_grupal'
               AND Object_ID = Object_ID('cob_conta_super..sb_dato_operacion')) begin
   ALTER TABLE sb_dato_operacion
   drop column do_renovacion_grupal  
end

if exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'do_renovacion_ind'
               AND Object_ID = Object_ID('cob_conta_super..sb_dato_operacion')) begin
   ALTER TABLE sb_dato_operacion
   drop column do_renovacion_ind  
end

