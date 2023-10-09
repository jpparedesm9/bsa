PRINT 'REINTENTOS'
UPDATE cob_ien..ree_ien_agent_file_def
SET
	afd_allow_retry_ftp = 1, --Flag de activación 1:activado 0:desactivado
    afd_retry_number_ftp = 3,
    afd_milliseconds_interval_ftp = 1000
WHERE afd_transaction_type IN ('PGRFR', 'DSMBL', 'DSMBLCK')
GO

PRINT 'SFTP'
UPDATE cob_ien..ree_ien_integration_server
SET ins_password = 'exFerKNNILhWwP/GWZ8Dfg=='
WHERE ins_name = 'SANTANDER H2H'
GO


PRINT 'PROCESOS ANTES'
SELECT * 
FROM cob_ien..ree_ien_agent_file_def
ORDER BY afd_status

SELECT * 
FROM cob_ien..ree_ien_jobs
ORDER BY jo_status
GO

PRINT 'PAGOS REFERENCIADOS IN'
UPDATE cob_ien..ree_ien_jobs
SET jo_cron_expression = '0 15,45 6-19 ? * MON-SAT *'
WHERE jo_transaction_type = 'PGRFR'
AND jo_type = 'DOWNLOAD'
--AND jo_type = 'SERVICE'

UPDATE cob_ien..ree_ien_agent_file_def
SET afd_cron_expression = '0 20,50 6-19 ? * MON-SAT *'
WHERE afd_transaction_type = 'PGRFR'
AND afd_in_out = 'IN'
--AND afd_in_out = 'OUT'
GO

PRINT 'DESEMBOLSOS OUT'
UPDATE cob_ien..ree_ien_jobs
SET jo_cron_expression = '0 30 8-17 ? * MON-FRI *'
WHERE jo_transaction_type = 'DSMBL'
--AND jo_type = 'DOWNLOAD'
AND jo_type = 'SERVICE'

UPDATE cob_ien..ree_ien_agent_file_def
SET afd_cron_expression = '0 35 8-17 ? * MON-FRI *'
WHERE afd_transaction_type = 'DSMBL'
--AND afd_in_out = 'IN'
AND afd_in_out = 'OUT'
GO

PRINT 'DESEMBOLSOS CHEQUEO IN'
UPDATE cob_ien..ree_ien_jobs
SET jo_cron_expression = '0 0 9-18 ? * MON-FRI *'
WHERE jo_transaction_type = 'DSMBLCK'
AND jo_type = 'DOWNLOAD'
--AND jo_type = 'SERVICE'

UPDATE cob_ien..ree_ien_agent_file_def
SET afd_cron_expression = '0 5 9-18 ? * MON-FRI *'
WHERE afd_transaction_type = 'DSMBLCK'
AND afd_in_out = 'IN'
--AND afd_in_out = 'OUT'
GO

PRINT 'DESEMBOLSOS IN'
UPDATE cob_ien..ree_ien_jobs
SET jo_cron_expression = '0 10 9-18 ? * MON-FRI *'
WHERE jo_transaction_type = 'DSMBL'
AND jo_type = 'DOWNLOAD'
--AND jo_type = 'SERVICE'

UPDATE cob_ien..ree_ien_agent_file_def
SET afd_cron_expression = '0 15 9-18 ? * MON-FRI *'
WHERE afd_transaction_type = 'DSMBL'
AND afd_in_out = 'IN'
--AND afd_in_out = 'OUT'
GO


PRINT 'PROCESOS DESPUES'
SELECT * 
FROM cob_ien..ree_ien_agent_file_def
ORDER BY afd_status

SELECT * 
FROM cob_ien..ree_ien_jobs
ORDER BY jo_status
GO


PRINT 'NOTIFICACIONES'
USE cobis;
GO

SELECT *
FROM ns_template;

SELECT te_row = ROW_NUMBER() OVER (ORDER BY te_id ASC), * 
INTO #ns_template
FROM ns_template
WHERE te_id > 1001
AND te_nombre NOT IN ('report-connection-ftp.xslt', 'report-ftp-without-files.xslt')
ORDER BY te_id;

DELETE FROM ns_template
WHERE te_id > 1001;

DECLARE @w_max INT;

SELECT @w_max = MAX(te_id)
FROM ns_template
WHERE te_id < 1000;

INSERT INTO ns_template
	(te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
SELECT @w_max + te_row, te_tipo, te_cultura, te_nombre, te_estado, te_version
FROM #ns_template;

GO

insert into cobis..ns_template(te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version) 
values(1002, 'XSLT', '', 'report-connection-ftp.xslt', 'A', '1.0.0')

insert into cobis..ns_template(te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version) 
values(1003, 'XSLT', '', 'report-ftp-without-files.xslt', 'A', '1.0.0')

GO

SELECT *
FROM ns_template;

GO


PRINT 'CATALOGOS'
declare
	@w_id	int

--Asignacion de id segun la tabla ree_ien_transaction_type
select @w_id = codigo from cobis..cl_tabla where tabla = 'ree_ien_transaction_type'

IF @w_id IS NULL
	PRINT 'ERROR: No existe catálogo ree_ien_transaction_type. Revisar la instalación de Integration Engine'
ELSE
BEGIN
	DELETE FROM cobis..cl_catalogo
	WHERE tabla = @w_id 
	AND codigo IN ('DSMBL', 'COBRO', 'DSMBLCK', 'PGRFR')

	INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)
	VALUES (@w_id, 'DSMBL', 'DESEMBOLSO DE CREDITO', 'V')

	INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)
	VALUES (@w_id, 'COBRO', 'COBRO DE CUOTA DE CREDITO', 'V')

	INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)
	VALUES (@w_id, 'DSMBLCK', 'CHECK DESEMBOLSO DE CREDITO', 'V')

	INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)
	VALUES (@w_id, 'PGRFR', 'PAGO REFERENCIADO', 'V')

	PRINT 'Datos insertados correctamente'
END

go
