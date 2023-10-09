USE cobis 
GO

select *
into cl_ente_96777
from cobis..cl_ente where en_ente in (3433,3374, 3382,3377)


SELECT en_oficial, * FROM cobis..cl_ente WHERE en_ente IN(3433,3374, 3382,3377)

UPDATE cobis..cl_ente SET en_oficial=99,
c_funcionario='erlino' 
WHERE en_ente IN (3433,3374, 3382,3377)

SELECT en_oficial, * FROM cobis..cl_ente WHERE en_ente IN (3433,3374, 3382,3377)
go