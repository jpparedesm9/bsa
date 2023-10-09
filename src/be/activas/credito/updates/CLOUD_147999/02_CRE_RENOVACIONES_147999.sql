
use cob_credito 
go 



if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_op_renovar' and COLUMN_NAME = 'or_referencia_grupal') alter table cr_op_renovar add  or_referencia_grupal cuenta null 

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_op_renovar' and COLUMN_NAME = 'or_ciclo_original') alter table cr_op_renovar add  or_ciclo_original cuenta null 

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_op_renovar' and COLUMN_NAME = 'or_grupo') alter table cr_op_renovar add  or_grupo cuenta null 

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_op_renovar' and COLUMN_NAME = 'or_tasa_ciclo_ant') alter table cr_op_renovar add  or_tasa_ciclo_ant float null 


if not exists(select 1 from sys.indexes indexes  inner join sys.objects objects on indexes.object_id = objects.object_id  where indexes.name ='cr_op_renovar_key3'  and objects.name = 'cr_op_renovar') 
   create nonclustered index cr_op_renovar_key3  on dbo.cr_op_renovar (or_referencia_grupal)
go

if not exists(select 1 from sys.indexes indexes  inner join sys.objects objects on indexes.object_id = objects.object_id  where indexes.name ='cr_op_renovar_key4'  and objects.name = 'cr_op_renovar') 
   create nonclustered index cr_op_renovar_key4 on dbo.cr_op_renovar (or_ciclo_original)  
go

if not exists(select 1 from sys.indexes indexes  inner join sys.objects objects on indexes.object_id = objects.object_id  where indexes.name ='cr_op_renovar_key5'  and objects.name = 'cr_op_renovar') 
   create nonclustered index cr_op_renovar_key5 on dbo.cr_op_renovar (or_grupo) 
go

if not exists(select 1 from sys.indexes indexes  inner join sys.objects objects on indexes.object_id = objects.object_id  where indexes.name ='cr_op_renovar_key6'  and objects.name = 'cr_op_renovar') 
   create nonclustered index cr_op_renovar_key6  on dbo.cr_op_renovar (or_tasa_ciclo_ant)
go


use cob_cartera 
go


delete ca_tipo_trn where tt_codigo = 'REN'

insert into dbo.ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable)
values ('REN', 'OPERACION RENOVADA', 'N', 'N')
go


