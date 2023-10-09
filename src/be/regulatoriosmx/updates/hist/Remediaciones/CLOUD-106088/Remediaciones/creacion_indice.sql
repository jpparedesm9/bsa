use cob_conta_super
go

if exists (SELECT 1 FROM sys.indexes WHERE Name = N'idx_1' AND object_id = OBJECT_ID(N'sb_severidad_perdida')) begin
   DROP INDEX sb_severidad_perdida.idx_1;
end

CREATE NONCLUSTERED INDEX idx_1
	ON sb_severidad_perdida (sp_toperacion)
	
if exists (SELECT 1 FROM sys.indexes WHERE Name = N'idx2' AND object_id = OBJECT_ID(N'sb_severidad_perdida')) begin
   DROP INDEX sb_severidad_perdida.idx2;
end

CREATE NONCLUSTERED INDEX idx2
	ON sb_severidad_perdida (sp_atr_minimo,sp_atr_maximo)

if exists (SELECT 1 FROM sys.indexes WHERE Name = N'idx1' AND object_id = OBJECT_ID(N'sb_dato_operacion_rubro')) begin
   DROP INDEX sb_dato_operacion_rubro.idx1;
end

CREATE NONCLUSTERED INDEX idx1
    on sb_dato_operacion_rubro (dr_banco, dr_fecha, dr_concepto, dr_estado)
	
if exists (SELECT 1 FROM sys.indexes WHERE Name = N'idx2' AND object_id = OBJECT_ID(N'sb_dato_operacion_rubro')) begin
   DROP INDEX sb_dato_operacion_rubro.idx2;
end

CREATE NONCLUSTERED INDEX idx2
    on sb_dato_operacion_rubro (dr_concepto, dr_estado)

if not exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'ds_atr'
               AND Object_ID = Object_ID('cob_conta_super..sb_dato_sumando_z')) begin
			   
   alter table sb_dato_sumando_z
   add ds_atr    float  null   
end

if not exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'ds_atr_max'
               AND Object_ID = Object_ID('cob_conta_super..sb_dato_sumando_z')) begin
			   
   alter table sb_dato_sumando_z
   add ds_atr_max    float  null   
end

if not exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'ds_cociente_pago'
               AND Object_ID = Object_ID('cob_conta_super..sb_dato_sumando_z')) begin
			   
   alter table sb_dato_sumando_z
   add ds_cociente_pago    float  null   
end

if not exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'ds_riesgo'
               AND Object_ID = Object_ID('cob_conta_super..sb_dato_sumando_z')) begin
			   
   alter table sb_dato_sumando_z
   add ds_riesgo    catalogo  null   
end

if not exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'dd_dividendo'
               AND Object_ID = Object_ID('cob_conta_super..sb_dato_transaccion_det')) begin
			   
   alter table cob_conta_super..sb_dato_transaccion_det
   add dd_dividendo    int default 0
end

if not exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'dd_dividendo'
               AND Object_ID = Object_ID('cob_externos..ex_dato_transaccion_det')) begin
			   
   alter table cob_externos..ex_dato_transaccion_det
   add dd_dividendo    int default 0
end

go