
---ROLLBACK DE CAMPOS DE CR OP RENOVAR
--ANDY GONZALEZ 
use cob_credito 
go 


if exists(select 1 from sys.indexes
	where name = 'cr_op_renovar_key3' and object_id = OBJECT_ID('cr_op_renovar'))
	drop index cr_op_renovar.cr_op_renovar_key3
go

if exists(select 1 from sys.indexes
	where name = 'cr_op_renovar_key4' and object_id = OBJECT_ID('cr_op_renovar'))
	drop index cr_op_renovar.cr_op_renovar_key4
go

if exists(select 1 from sys.indexes
	where name = 'cr_op_renovar_key5' and object_id = OBJECT_ID('cr_op_renovar'))
	drop index cr_op_renovar.cr_op_renovar_key5
go

if exists(select 1 from sys.indexes
	where name = 'cr_op_renovar_key6' and object_id = OBJECT_ID('cr_op_renovar'))
	drop index cr_op_renovar.cr_op_renovar_key6
go



if exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'or_referencia_grupal'
               AND Object_ID = Object_ID('cob_credito..cr_op_renovar')) begin
   ALTER TABLE cr_op_renovar
   drop column or_referencia_grupal  
end




if exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'or_ciclo_original'
               AND Object_ID = Object_ID('cob_credito..cr_op_renovar')) begin
   ALTER TABLE cr_op_renovar
   drop column or_ciclo_original  
end



if exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'or_grupo'
               AND Object_ID = Object_ID('cob_credito..cr_op_renovar')) begin
   ALTER TABLE cr_op_renovar
   drop column or_grupo  
end

if exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'or_tasa_ciclo_ant'
               AND Object_ID = Object_ID('cob_credito..cr_op_renovar')) begin
   ALTER TABLE cr_op_renovar
   drop column or_tasa_ciclo_ant  
end


if exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'or_tasa_ciclo_ant'
               AND Object_ID = Object_ID('cob_credito..cr_op_renovar')) begin
   ALTER TABLE cr_op_renovar
   drop column 'or_tasa_ciclo_ant')   
end


use cob_cartera 
go


delete ca_tipo_trn where tt_codigo = 'REN'


