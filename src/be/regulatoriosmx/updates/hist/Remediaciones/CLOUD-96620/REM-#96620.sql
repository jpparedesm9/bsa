USE cobis 
GO

select *
into cl_ente_96620
from cobis..cl_ente where en_ente in (2868,2876,2879,2880,2882,2883,2884,2887,3584,3589)


SELECT en_oficial, * FROM cobis..cl_ente WHERE en_ente IN (2868,2876,2879,2880,2882,2883,2884,2887,3584,3589)

UPDATE cobis..cl_ente SET en_oficial=97,
c_funcionario='gdnegrete' 
WHERE en_ente IN (2868,2876,2879,2880,2882,2883,2884,2887,3584,3589)

update cobis..cl_grupo
set gr_oficial = 97
where gr_grupo in (108, 114)


SELECT en_oficial, * FROM cobis..cl_ente WHERE en_ente IN (2868,2876,2879,2880,2882,2883,2884,2887,3584,3589)

select gr_oficial, * from cobis..cl_grupo where gr_grupo in (108, 114)



go

