use cob_cartera
go

if not exists (SELECT 1 FROM sys.indexes WHERE Name = N'idx_ca_precancela_refer_det_cli' AND object_id = OBJECT_ID(N'ca_precancela_refer_det')) begin 
   print 'va a crear index ca_precancela_refer_det'
   CREATE INDEX  idx_ca_precancela_refer_det_cli 
   on ca_precancela_refer_det (prd_cliente)
end 

PRINT 'Paso del detalle'

if not exists (SELECT 1 FROM sys.indexes WHERE Name = N'idx_ca_precancela_refer_cli' AND object_id = OBJECT_ID(N'ca_precancela_refer')) begin 
  print 'va a crear index ca_precancela_refer'
  CREATE INDEX  idx_ca_precancela_refer_cli 
   on ca_precancela_refer (pr_cliente)
end 

PRINT 'Paso del sin detalle'

GO
