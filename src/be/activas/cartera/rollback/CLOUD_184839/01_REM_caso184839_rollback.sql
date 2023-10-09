use cob_cartera
go

if exists (SELECT 1 FROM sys.indexes WHERE Name = N'idx_ca_precancela_refer_det_cli' AND object_id = OBJECT_ID(N'ca_precancela_refer_det')) begin 
   print 'va a eliminar index ca_precancela_refer_det'
   DROP INDEX  idx_ca_precancela_refer_det_cli  on ca_precancela_refer_det
end 

PRINT 'Paso del detalle'

if exists (SELECT 1 FROM sys.indexes WHERE Name = N'idx_ca_precancela_refer_cli' AND object_id = OBJECT_ID(N'ca_precancela_refer')) begin 
  print 'va a eliminar index ca_precancela_refer'
  DROP INDEX  idx_ca_precancela_refer_cli on ca_precancela_refer
end

PRINT 'Paso del sin detalle'

go
