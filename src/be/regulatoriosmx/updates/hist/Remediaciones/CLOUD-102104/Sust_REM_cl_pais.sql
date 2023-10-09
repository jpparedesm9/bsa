use cobis
go

--cl_pais
--Á 
update cl_pais
set pa_descripcion = REPLACE(pa_descripcion,'Ã','A')
where pa_descripcion like '%Ã%'

--á 
update cl_pais
set pa_descripcion = REPLACE(pa_descripcion,'Ã¡','a')
where pa_descripcion like '%Ã¡%'

--É
update cl_pais
set pa_descripcion = REPLACE(pa_descripcion,'Ã‰','E')
where pa_descripcion like '%Ã‰%'

--é
update cl_pais
set pa_descripcion = REPLACE(pa_descripcion,'Ã©','e')
where pa_descripcion like '%Ã©%'

--Ó
update cl_pais
set pa_descripcion = REPLACE(pa_descripcion,'Ã“','O')
where pa_descripcion like '%Ã“%'

--ó
update cl_pais
set pa_descripcion = REPLACE(pa_descripcion,'Ã³','o')
where pa_descripcion like '%Ã³%'

--Ú
update cl_pais
set pa_descripcion = REPLACE(pa_descripcion,'Ãš','U')
where pa_descripcion like '%Ãš%'

--ú
update cl_pais
set pa_descripcion = REPLACE(pa_descripcion,'Ãº','u')
where pa_descripcion like '%Ãº%'

--Ñ
update cl_pais
set pa_descripcion = REPLACE(pa_descripcion,'Ã‘','Ñ')
where pa_descripcion like '%Ã‘%'

--ñ
update cl_pais
set pa_descripcion = REPLACE(pa_descripcion,'Ã±','ñ')
where pa_descripcion like '%Ã±%'

--Ü
update cl_pais
set pa_descripcion = REPLACE(pa_descripcion,'Ãœ','Ü')
where pa_descripcion like '%Ãœ%'

--ü
update cl_pais
set pa_descripcion = REPLACE(pa_descripcion,'Ã¼','ü')
where pa_descripcion like '%Ã¼%'

--Í
update cl_pais
set pa_descripcion = REPLACE(pa_descripcion,'Ã','I')
where pa_descripcion like '%Ã%'

--í
update cl_pais
set pa_descripcion = REPLACE(pa_descripcion,'Ã','i')
where pa_descripcion like '%Ã%'

go