--dev2
USE cob_credito
GO

--SELECT count(*) FROM cob_credito..cr_interface_buro---379109--- despues306789--------

SELECT cliente = ib_cliente, numero = count(*) 
INTO #clientes_1
FROM cob_credito..cr_interface_buro
WHERE ib_estado = 'V'
GROUP BY ib_cliente
HAVING count(*) > 1

--SELECT * FROM #clientes_1 -- 912
--SELECT * FROM #clientes_1, cob_credito..cr_interface_buro WHERE ib_cliente = cliente order by cliente

SELECT I.* 
INTO #cr_interface_buro_todo
FROM cob_credito..cr_interface_buro I, #clientes_1 T
WHERE cliente = ib_cliente

--SELECT * FROM #cr_interface_buro_todo--132

SELECT I.* 
INTO #cr_interface_buro_no_eli
FROM cob_credito..cr_interface_buro I, #clientes_1 T
WHERE cliente = ib_cliente
AND ib_fecha IN (SELECT max(ib_fecha) FROM cob_credito..cr_interface_buro, #clientes_1
                 WHERE cliente = ib_cliente AND cliente = I.ib_cliente)

--SELECT * FROM #cr_interface_buro_no_eli--65

SELECT T.* 
INTO #cr_interface_buro_eliminar
from #cr_interface_buro_todo T, #cr_interface_buro_no_eli N
WHERE T.ib_cliente = N.ib_cliente
AND T.ib_fecha <> N.ib_fecha
AND T.ib_folio <> N.ib_folio
AND T.ib_secuencial <> N.ib_secuencial

--SELECT * FROM #cr_interface_buro_eliminar--67

use cob_credito
go

if OBJECT_ID ('dbo.cr_interface_buro_tmp_162199_resp') is not null
	drop table dbo.cr_interface_buro_tmp_162199_resp
GO

------------>>>>>>Respaldo
SELECT 'LAS_Q_S_VA_ACT'='LAS_Q_S_VA_ACT', I.* 
INTO cob_credito..cr_interface_buro_tmp_162199_resp
FROM cob_credito..cr_interface_buro I, #cr_interface_buro_eliminar E
WHERE I.ib_cliente = E.ib_cliente
AND I.ib_fecha = E.ib_fecha
AND I.ib_folio = E.ib_folio
AND I.ib_secuencial = E.ib_secuencial

--select * from cob_credito..cr_interface_buro_tmp_162199_resp--67

UPDATE cob_credito..cr_interface_buro 
SET ib_estado = 'N'
FROM cob_credito..cr_interface_buro I, #cr_interface_buro_eliminar E
WHERE I.ib_cliente = E.ib_cliente
AND I.ib_fecha = E.ib_fecha
AND I.ib_folio = E.ib_folio
AND I.ib_secuencial = E.ib_secuencial

go
