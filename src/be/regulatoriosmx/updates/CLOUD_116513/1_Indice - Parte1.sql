use cob_conta_super 
go

if not exists(SELECT 1  FROM sys.indexes  WHERE name='idx5' AND object_id = OBJECT_ID('sb_dato_operacion'))
  create index idx5 on sb_dato_operacion (do_fecha, do_aplicativo, do_tipo_operacion)
go
