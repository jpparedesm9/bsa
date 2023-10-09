
-----------------------------------------
--CASO 109378 FERIADOS IEN 2019 ROLLBACK
-----------------------------------------
USE cob_ien
GO

SET NOCOUNT ON
GO

DECLARE
	@w_secuencial INT

SELECT @w_secuencial = ISNULL(MAX(agho_id), 0)
FROM ree_ien_agent_holiday
WHERE agho_date < '01/01/2019'

delete ree_ien_agent_holiday
where agho_date >= '01/01/2019'

UPDATE cobis..cl_seqnos
SET siguiente = @w_secuencial
WHERE tabla = 'ree_ien_agent_holiday'

GO

SET NOCOUNT OFF
GO

/*
SELECT * FROM ree_ien_agent_holiday

SELECT * FROM cobis..cl_seqnos
WHERE tabla = 'ree_ien_agent_holiday'
*/