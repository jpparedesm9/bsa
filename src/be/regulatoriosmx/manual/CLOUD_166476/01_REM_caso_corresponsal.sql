-------
DECLARE @w_fecha DATETIME
SELECT @w_fecha = '08/01/2021'

SELECT * FROM cob_cartera..ca_corresponsal_trn 
WHERE co_tipo = 'GL' AND co_estado = 'I' AND co_fecha_proceso < @w_fecha --'03/23/2021' --- cambierles en Error

UPDATE cob_cartera..ca_corresponsal_trn 
SET co_estado = 'E'
WHERE co_tipo = 'GL' AND co_estado = 'I' AND co_fecha_proceso < @w_fecha --'03/23/2021' --- cambierles en Error
go

--- 5 dias laborales