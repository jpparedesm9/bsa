USE cob_ien
GO

SET NOCOUNT ON
GO

DECLARE
	@w_secuencial INT,
	@w_ente INT,
	@w_fecha DATE

SELECT @w_ente = en_ente
FROM cobis..cl_ente 
WHERE en_nombre = 'SANTANDER'

DELETE FROM cob_ien..ree_ien_agent_holiday
WHERE ag_code = @w_ente

SELECT @w_secuencial = ISNULL(MAX(agho_id), 0)
FROM ree_ien_agent_holiday

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20171212'
INSERT INTO cob_ien..ree_ien_agent_holiday (agho_id, ag_code, agho_date, agho_description)
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20171225'
INSERT INTO cob_ien..ree_ien_agent_holiday
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20180101'
INSERT INTO cob_ien..ree_ien_agent_holiday
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20180205'
INSERT INTO cob_ien..ree_ien_agent_holiday
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20180319'
INSERT INTO cob_ien..ree_ien_agent_holiday
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20180329'
INSERT INTO cob_ien..ree_ien_agent_holiday
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20180330'
INSERT INTO cob_ien..ree_ien_agent_holiday
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20180501'
INSERT INTO cob_ien..ree_ien_agent_holiday
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20181102'
INSERT INTO cob_ien..ree_ien_agent_holiday
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20181119'
INSERT INTO cob_ien..ree_ien_agent_holiday
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20181212'
INSERT INTO cob_ien..ree_ien_agent_holiday
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha)

SELECT @w_secuencial = @w_secuencial + 1
SELECT @w_fecha = '20181225'
INSERT INTO cob_ien..ree_ien_agent_holiday
VALUES (@w_secuencial, @w_ente, @w_fecha, @w_fecha)

UPDATE cobis..cl_seqnos
SET siguiente = @w_secuencial
WHERE tabla = 'ree_ien_agent_holiday'

GO

SET NOCOUNT OFF
GO
