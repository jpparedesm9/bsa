use cob_conta_super 
go

if not exists(SELECT 1  FROM sys.indexes  WHERE name='idx7' and object_id = OBJECT_ID('sb_dato_operacion'))
   create index idx7 on sb_dato_operacion (do_operacion)
go
