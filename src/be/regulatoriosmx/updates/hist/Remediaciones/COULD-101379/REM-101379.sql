use cobis
go

--cl_provincia
--Á 
update cl_provincia
set pv_descripcion = REPLACE(pv_descripcion,'Ã','A')
where pv_descripcion like '%Ã%'

--á 
update cl_provincia
set pv_descripcion = REPLACE(pv_descripcion,'Ã¡','a')
where pv_descripcion like '%Ã¡%'

--É
update cl_provincia
set pv_descripcion = REPLACE(pv_descripcion,'Ã‰','E')
where pv_descripcion like '%Ã‰%'

--é
update cl_provincia
set pv_descripcion = REPLACE(pv_descripcion,'Ã©','e')
where pv_descripcion like '%Ã©%'

--Ó
update cl_provincia
set pv_descripcion = REPLACE(pv_descripcion,'Ã“','O')
where pv_descripcion like '%Ã“%'

--ó
update cl_provincia
set pv_descripcion = REPLACE(pv_descripcion,'Ã³','o')
where pv_descripcion like '%Ã³%'

--Ú
update cl_provincia
set pv_descripcion = REPLACE(pv_descripcion,'Ãš','U')
where pv_descripcion like '%Ãš%'

--ú
update cl_provincia
set pv_descripcion = REPLACE(pv_descripcion,'Ãº','u')
where pv_descripcion like '%Ãº%'

--Ñ
update cl_provincia
set pv_descripcion = REPLACE(pv_descripcion,'Ã‘','Ñ')
where pv_descripcion like '%Ã‘%'

--ñ
update cl_provincia
set pv_descripcion = REPLACE(pv_descripcion,'Ã±','ñ')
where pv_descripcion like '%Ã±%'

--Ü
update cl_provincia
set pv_descripcion = REPLACE(pv_descripcion,'Ãœ','Ü')
where pv_descripcion like '%Ãœ%'

--ü
update cl_provincia
set pv_descripcion = REPLACE(pv_descripcion,'Ã¼','ü')
where pv_descripcion like '%Ã¼%'

--Í
update cl_provincia
set pv_descripcion = REPLACE(pv_descripcion,'Ã','I')
where pv_descripcion like '%Ã%'

--í
update cl_provincia
set pv_descripcion = REPLACE(pv_descripcion,'Ã','i')
where pv_descripcion like '%Ã%'

go


--cl_ciudad
--Á 
update cl_ciudad
set ci_descripcion = REPLACE(ci_descripcion,'Ã','A')
where ci_descripcion like '%Ã%'

--á 
update cl_ciudad
set ci_descripcion = REPLACE(ci_descripcion,'Ã¡','a')
where ci_descripcion like '%Ã¡%'

--É
update cl_ciudad
set ci_descripcion = REPLACE(ci_descripcion,'Ã‰','E')
where ci_descripcion like '%Ã‰%'

--é
update cl_ciudad
set ci_descripcion = REPLACE(ci_descripcion,'Ã©','e')
where ci_descripcion like '%Ã©%'

--Ó
update cl_ciudad
set ci_descripcion = REPLACE(ci_descripcion,'Ã“','O')
where ci_descripcion like '%Ã“%'

--ó
update cl_ciudad
set ci_descripcion = REPLACE(ci_descripcion,'Ã³','o')
where ci_descripcion like '%Ã³%'

--Ú
update cl_ciudad
set ci_descripcion = REPLACE(ci_descripcion,'Ãš','U')
where ci_descripcion like '%Ãš%'

--ú
update cl_ciudad
set ci_descripcion = REPLACE(ci_descripcion,'Ãº','u')
where ci_descripcion like '%Ãº%'

--Ñ
update cl_ciudad
set ci_descripcion = REPLACE(ci_descripcion,'Ã‘','Ñ')
where ci_descripcion like '%Ã‘%'

--ñ
update cl_ciudad
set ci_descripcion = REPLACE(ci_descripcion,'Ã±','ñ')
where ci_descripcion like '%Ã±%'

--Ü
update cl_ciudad
set ci_descripcion = REPLACE(ci_descripcion,'Ãœ','Ü')
where ci_descripcion like '%Ãœ%'

--ü
update cl_ciudad
set ci_descripcion = REPLACE(ci_descripcion,'Ã¼','ü')
where ci_descripcion like '%Ã¼%'

--Í
update cl_ciudad
set ci_descripcion = REPLACE(ci_descripcion,'Ã','I')
where ci_descripcion like '%Ã%'

--í
update cl_ciudad
set ci_descripcion = REPLACE(ci_descripcion,'Ã','i')
where ci_descripcion like '%Ã%'

go


--cl_parroquia
--Á 
update cl_parroquia
set pq_descripcion = REPLACE(pq_descripcion,'Ã','A')
where pq_descripcion like '%Ã%'

--á
update cl_parroquia
set pq_descripcion = REPLACE(pq_descripcion,'Ã¡','a')
where pq_descripcion like '%Ã¡%'

--É
update cl_parroquia
set pq_descripcion = REPLACE(pq_descripcion,'Ã‰','E')
where pq_descripcion like '%Ã‰%'

--é
update cl_parroquia
set pq_descripcion = REPLACE(pq_descripcion,'Ã©','e')
where pq_descripcion like '%Ã©%'

--Ó
update cl_parroquia
set pq_descripcion = REPLACE(pq_descripcion,'Ã“','O')
where pq_descripcion like '%Ã“%'

--ó
update cl_parroquia
set pq_descripcion = REPLACE(pq_descripcion,'Ã³','o')
where pq_descripcion like '%Ã³%'

--Ú
update cl_parroquia
set pq_descripcion = REPLACE(pq_descripcion,'Ãš','U')
where pq_descripcion like '%Ãš%'

--ú
update cl_parroquia
set pq_descripcion = REPLACE(pq_descripcion,'Ãº','u')
where pq_descripcion like '%Ãº%'

--Ñ
update cl_parroquia
set pq_descripcion = REPLACE(pq_descripcion,'Ã‘','Ñ')
where pq_descripcion like '%Ã‘%'

--ñ
update cl_parroquia
set pq_descripcion = REPLACE(pq_descripcion,'Ã±','ñ')
where pq_descripcion like '%Ã±%'

--Ü
update cl_parroquia
set pq_descripcion = REPLACE(pq_descripcion,'Ãœ','Ü')
where pq_descripcion like '%Ãœ%'

--ü
update cl_parroquia
set pq_descripcion = REPLACE(pq_descripcion,'Ã¼','ü')
where pq_descripcion like '%Ã¼%'

--°
update cobis..cl_parroquia
set pq_descripcion = REPLACE(pq_descripcion,'Â°','°')
where pq_descripcion like '%Â°%'

--Í
update cl_parroquia
set pq_descripcion = REPLACE(pq_descripcion,'Ã','I')
where pq_descripcion like '%Ã%'

--í
update cl_parroquia
set pq_descripcion = REPLACE(pq_descripcion,'Ã','i')
where pq_descripcion like '%Ã%'

go
