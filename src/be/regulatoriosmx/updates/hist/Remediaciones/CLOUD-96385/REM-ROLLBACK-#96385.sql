USE cobis 
GO


UPDATE cobis..cl_ente 
SET en_oficial=b.en_oficial,
    c_funcionario=b.c_funcionario
from cobis..cl_ente a, cobis..cl_ente_96385 b 
WHERE a.en_ente IN (2888,2949,2959,2972,2977,2990,2995,3306)
and a.en_ente =b.en_ente

SELECT en_oficial, * FROM cobis..cl_ente WHERE en_ente IN (2888,2949,2959,2972,2977,2990,2995,3306)

go