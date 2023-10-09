USE cobis 
GO

select *
into cl_ente_96385
from cobis..cl_ente where en_ente in (2888,2949,2959,2972,2977,2990,2995,3306)


SELECT en_oficial, * FROM cobis..cl_ente WHERE en_ente IN (2888,2949,2959,2972,2977,2990,2995,3306)

UPDATE cobis..cl_ente SET en_oficial=97,
c_funcionario='gdnegrete' 
WHERE en_ente IN (2888,2949,2959,2972,2977,2990,2995,3306)

SELECT en_oficial, * FROM cobis..cl_ente WHERE en_ente IN (2888,2949,2959,2972,2977,2990,2995,3306)
go