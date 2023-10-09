use cobis
go
---
print 'Inicio script 01 rollback:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)

------------------------------------------------------------
--cl_codigo_postal_tmp_resp_159331
------------------------------------------------------------
truncate table cl_codigo_postal_tmp

insert into cl_codigo_postal_tmp
select *
from cl_codigo_postal_tmp_resp_159331

select 'Termino codigo postal tmp'
go

------------------------------------------------------------
--cl_codigo_postal_resp_159331
------------------------------------------------------------
truncate table cl_codigo_postal

insert into cl_codigo_postal
select *
from cl_codigo_postal_resp_159331

select 'Termino codigo postal'
go

------------------------------------------------------------
--cl_direccion_resp_159331
------------------------------------------------------------
delete cl_direccion
where di_direccion in (select di_direccion from cl_direccion_resp_159331) 
	
insert into cl_direccion
select *
from cl_direccion_resp_159331

select 'Termino direccion'
go

------------------------------------------------------------
--cl_parroquia_resp_145099
------------------------------------------------------------
truncate table cl_parroquia

insert into cl_parroquia
select *
from cl_parroquia_resp_159331

select 'Termino parroquia'
go

------------------------------------------------------------
--ci_ciudad_resp_159331
------------------------------------------------------------
truncate table cl_ciudad

insert into cl_ciudad
select *
from cl_ciudad_resp_159331

select 'Termino ciudad'
go

------------------------------------------------------------
--cl_provincia_resp_159331
------------------------------------------------------------
truncate table cl_provincia

insert into cl_provincia
select *
from cl_provincia_resp_159331

select 'Termino provincia'
go

------------------------------------------------------------
--sb_equivalencias_resp_159331
------------------------------------------------------------
use cob_conta_super
go
delete sb_equivalencias
where  eq_catalogo in ('ENT_FED','ENT_MUN','ENT_PARROQ')

insert sb_equivalencias
select *
from sb_equivalencias_resp_159331
where eq_catalogo in ('ENT_FED','ENT_MUN','ENT_PARROQ')

print 'Fin script 01 rollback:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)

go
--fin

--eq_catalogo   = 'ENT_FED' --34 -- estado
--eq_catalogo   = 'ENT_MUN'
--eq_catalogo   = 'ENT_PARROQ'
