use cob_cartera 
go

if not exists(SELECT 1  FROM sys.indexes WHERE name = 'idx_1'  AND object_id = OBJECT_ID('ca_log_dispercion_gl') 
     ) 
begin 
     CREATE INDEX idx_1 ON ca_log_dispercion_gl (ld_fecha_proceso, ld_gl_id)
end 