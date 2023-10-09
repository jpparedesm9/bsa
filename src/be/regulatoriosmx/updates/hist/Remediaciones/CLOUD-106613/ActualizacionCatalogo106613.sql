
use cobis
go



IF OBJECT_ID ('borrar_cl_parroquia_106577') IS NOT NULL
	DROP TABLE borrar_cl_parroquia_106577
GO

IF OBJECT_ID ('borrar_cl_ciudad_106577') IS NOT NULL
	DROP TABLE borrar_cl_ciudad_106577
GO



select *
into borrar_cl_parroquia_106577
from cl_parroquia

select * 
into borrar_cl_ciudad_106577
from cobis..cl_ciudad 


select * 
from cobis..cl_parroquia 
where pq_descripcion like '%  %'


update cobis..cl_parroquia 
set pq_descripcion =  replace(replace(replace(pq_descripcion,' ','<>'),'><',''),'<>',' ')
where pq_descripcion like '%  %'

update cobis..cl_parroquia 
set pq_descripcion =  ltrim(rtrim(pq_descripcion))

select * 
from cobis..cl_parroquia 
where pq_descripcion like '%  %'


select * 
from cobis..cl_ciudad 
where ci_descripcion like '%  %'

update cobis..cl_ciudad
set ci_descripcion =  replace(replace(replace(ci_descripcion,' ','<>'),'><',''),'<>',' ')
where ci_descripcion like '%  %'

select * 
from cobis..cl_ciudad 
where ci_descripcion like '%  %'



