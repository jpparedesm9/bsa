use cob_conta_super 
go

if not exists(SELECT 1  FROM sys.indexes  WHERE name='idx6' AND object_id = OBJECT_ID('sb_dato_operacion'))
   create index idx6 on sb_dato_operacion (do_aplicativo, do_tipo_operacion)
go

