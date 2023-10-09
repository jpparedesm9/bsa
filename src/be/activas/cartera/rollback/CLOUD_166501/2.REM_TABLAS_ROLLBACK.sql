use cob_cartera
go

---REQ 166501 TRX SOCIO COMERCIAL - Log de Auditoria
IF OBJECT_ID ('dbo.ca_lcr_socio_comercial_log') IS NOT NULL
    DROP TABLE dbo.ca_lcr_socio_comercial_log
go

IF EXISTS (SELECT name FROM sysindexes WHERE name='idx_ca_lcr_socio_comercial_log_1')
    DROP INDEX ca_lcr_socio_comercial_log.idx_ca_lcr_socio_comercial_log_1
go


---REQ 166501 TRX SOCIO COMERCIAL - Log de Auditoria
IF OBJECT_ID ('dbo.ca_desembolsos_pendientes') IS NOT NULL
    DROP TABLE dbo.ca_desembolsos_pendientes
go

