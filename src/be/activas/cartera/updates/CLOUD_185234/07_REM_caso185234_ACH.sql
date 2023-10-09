--no hay rollback para este archivo porque se borraria la nueva columna
SELECT io_campo_3, io_campo_4 
INTO #registros_actualizar
FROM cob_workflow..wf_inst_proceso WHERE io_fecha_crea >= '07/11/2022' 
AND io_campo_3 > 0

SELECT 'antes', * 
from cob_cartera..ca_ns_garantia_liquida, #registros_actualizar
WHERE  io_campo_3 = ngl_tramite

UPDATE cob_cartera..ca_ns_garantia_liquida
SET ngl_operacion = io_campo_4
FROM #registros_actualizar
WHERE  io_campo_3 = ngl_tramite

SELECT 'despues', * 
from cob_cartera..ca_ns_garantia_liquida, #registros_actualizar
WHERE  io_campo_3 = ngl_tramite
go
