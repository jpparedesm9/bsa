
---------------------------------
--CASO 109378 FERIADOS IEN 2019
---------------------------------
USE cob_ien
GO

SET NOCOUNT ON
GO

DECLARE
	@w_secuencial INT,
	@w_ente INT,
	@w_fecha DATE


--FERIADOS
SELECT @w_ente = pd_producto
FROM cobis..cl_producto
WHERE pd_abreviatura = 'MIS'

SELECT @w_secuencial = ISNULL(MAX(agho_id), 0)
FROM ree_ien_agent_holiday

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190101'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190205'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190318'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190418'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190419'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190501'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190916'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191118'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191212'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191225'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

--FINES DE SEMANA
SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190105'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190106'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190112'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190113'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190119'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190120'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190126'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190127'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190202'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190203'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190209'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190210'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190216'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190217'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190223'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190224'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190302'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190303'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190309'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190310'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190316'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190317'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190323'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190324'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190330'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190331'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190406'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190407'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190413'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190414'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190420'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190421'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190427'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190428'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190504'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190505'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190511'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190512'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190518'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190519'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190525'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190526'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190601'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190602'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190608'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190609'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190615'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190616'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190622'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190623'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190629'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190630'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190706'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190707'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190713'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190714'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190720'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190721'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190727'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190728'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190803'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190804'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190810'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190811'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190817'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190818'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190824'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190825'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190831'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190901'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190907'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190908'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190914'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190915'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190921'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190922'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190928'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20190929'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191005'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191006'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191012'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191013'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191019'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191020'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191026'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191027'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191102'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191103'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191109'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191110'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191116'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191117'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191123'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191124'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191130'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191201'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191207'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191208'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191214'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191215'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191221'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191222'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191228'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20191229'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description, agho_is_date_process)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha, 0)

UPDATE cobis..cl_seqnos
SET siguiente = @w_secuencial
WHERE tabla = 'ree_ien_agent_holiday'

GO

SET NOCOUNT OFF
GO

