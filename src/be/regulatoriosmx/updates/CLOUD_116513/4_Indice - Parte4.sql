use cob_conta_super 
go

if not exists(SELECT 1  FROM sys.indexes  WHERE name='idx3' and object_id = OBJECT_ID('sb_dato_cuota_pry'))
   create index idx3 on sb_dato_cuota_pry (dc_fecha, dc_aplicativo)
go