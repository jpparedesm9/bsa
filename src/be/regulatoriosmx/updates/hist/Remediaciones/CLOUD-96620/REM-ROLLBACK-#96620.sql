USE cobis 
GO


UPDATE cobis..cl_ente 
SET en_oficial=b.en_oficial,
    c_funcionario=b.c_funcionario
from cobis..cl_ente a, cobis..cl_ente_96620 b 
WHERE a.en_ente IN (2868,2876,2879,2880,2882,2883,2884,2887,3584,3589)
and a.en_ente =b.en_ente


update cobis..cl_grupo
set gr_oficial = 76
from cobis..cl_grupo 
where gr_grupo in (108, 114)



SELECT en_oficial, * FROM cobis..cl_ente WHERE en_ente IN (2868,2876,2879,2880,2882,2883,2884,2887,3584,3589)


select gr_oficial, * from cobis..cl_grupo where gr_grupo in (108, 114)


go