
use cob_cartera
GO

--ELIMINA INDICES
DROP INDEX idx1_sms_cobranzas ON cob_cartera.dbo.ca_ns_sms_cobranzas;
DROP INDEX idx2_idx1_sms_cobranzas ON cob_cartera.dbo.ca_ns_sms_cobranzas;
DROP INDEX idx3_idx1_sms_cobranzas ON cob_cartera.dbo.ca_ns_sms_cobranzas;

--ACTUALIZAN CAMPOS
ALTER TABLE cob_cartera.dbo.ca_ns_sms_cobranzas ALTER COLUMN nsc_fecha_ing datetime NULL;
ALTER TABLE cob_cartera.dbo.ca_ns_sms_cobranzas ALTER COLUMN nsc_fecha_env datetime NULL;
ALTER TABLE cob_cartera.dbo.ca_ns_sms_cobranzas ALTER COLUMN nsc_rol_cliente varchar(10) COLLATE Latin1_General_BIN NULL;

--CREAN INDICES
CREATE INDEX idx1_sms_cobranzas ON cob_cartera.dbo.ca_ns_sms_cobranzas;
CREATE INDEX idx2_idx1_sms_cobranzas ON cob_cartera.dbo.ca_ns_sms_cobranzas;
CREATE INDEX idx3_idx1_sms_cobranzas ON cob_cartera.dbo.ca_ns_sms_cobranzas;


--ACTUALIZAN CAMPOS
DROP INDEX idx1_sms_recordatorio ON cob_cartera.dbo.ca_ns_sms_recordatorios;
ALTER TABLE cob_cartera.dbo.ca_ns_sms_recordatorios ALTER COLUMN nsc_fecha_ing datetime NULL;
ALTER TABLE cob_cartera.dbo.ca_ns_sms_recordatorios ALTER COLUMN nsr_fecha_env datetime NULL;
ALTER TABLE cob_cartera.dbo.ca_ns_sms_recordatorios ALTER COLUMN nsr_rol_cliente varchar(10) COLLATE Latin1_General_BIN NULL;
CREATE INDEX idx1_sms_recordatorio ON cob_cartera.dbo.ca_ns_sms_recordatorios;

--ACTUALIZAN CAMPOS
DROP INDEX idx1_sms_recordatorio_his ON cob_cartera_his.dbo.ca_ns_sms_recordatorios_his;
ALTER TABLE cob_cartera_his.dbo.ca_ns_sms_recordatorios_his ALTER COLUMN nsc_fecha_ing datetime NULL;
ALTER TABLE cob_cartera_his.dbo.ca_ns_sms_recordatorios_his ALTER COLUMN nsr_fecha_env datetime NULL;
ALTER TABLE cob_cartera_his.dbo.ca_ns_sms_recordatorios_his ALTER COLUMN nsr_rol_cliente varchar(10) COLLATE Latin1_General_BIN NULL;
CREATE INDEX idx1_sms_recordatorio_his ON cob_cartera_his.dbo.ca_ns_sms_recordatorios_his;


--ELIMINA INDICES
DROP INDEX idx1_sms_cobranzas_his ON cob_cartera_his.dbo.ca_ns_sms_cobranzas_his;
DROP INDEX idx2_idx1_sms_cobranzas_his ON cob_cartera_his.dbo.ca_ns_sms_cobranzas_his;
DROP INDEX idx3_idx1_sms_cobranzas_his ON cob_cartera_his.dbo.ca_ns_sms_cobranzas_his;

--ACTUALIZAN CAMPOS
ALTER TABLE cob_cartera_his.dbo.ca_ns_sms_cobranzas_his ALTER COLUMN nsc_fecha_ing datetime NULL;
ALTER TABLE cob_cartera_his.dbo.ca_ns_sms_cobranzas_his ALTER COLUMN nsc_fecha_env datetime NULL;
ALTER TABLE cob_cartera_his.dbo.ca_ns_sms_cobranzas_his ALTER COLUMN nsc_estado varchar(10) COLLATE Latin1_General_BIN NULL;

--CREAN INDICES
CREATE INDEX idx1_sms_cobranzas_his ON cob_cartera_his.dbo.ca_ns_sms_cobranzas_his;
CREATE INDEX idx2_idx1_sms_cobranzas_his ON cob_cartera_his.dbo.ca_ns_sms_cobranzas_his;
CREATE INDEX idx3_idx1_sms_cobranzas_his ON cob_cartera_his.dbo.ca_ns_sms_cobranzas_his;