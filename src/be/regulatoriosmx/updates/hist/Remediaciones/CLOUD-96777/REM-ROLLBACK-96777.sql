USE cobis 
GO


UPDATE cobis..cl_ente 
SET en_oficial=b.en_oficial,
    c_funcionario=b.c_funcionario
from cobis..cl_ente a, cobis.. cl_ente_96777 b 
WHERE a.en_ente IN (3433,3374, 3382,3377)
and a.en_ente =b.en_ente

SELECT en_oficial, * FROM cobis..cl_ente WHERE en_ente IN (3433,3374, 3382,3377)

go
