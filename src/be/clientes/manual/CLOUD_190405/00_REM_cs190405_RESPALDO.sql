-----------------------RESPALDO
use cobis
go
print 'Inicio script 00 respaldos: ' + convert(varchar(30), getdate(), 103) + '--' + convert(varchar(30), getdate(), 108)
----------------
------------------------------------------------------------
--cl_codigo_postal_tmp_resp_190405
------------------------------------------------------------
IF OBJECT_ID ('dbo.cl_codigo_postal_tmp_resp_190405') IS NOT NULL
	DROP table dbo.cl_codigo_postal_tmp_resp_190405

select *
into cl_codigo_postal_tmp_resp_190405
from cl_codigo_postal_tmp

select 'Termino codigo postal tmp'
go

------------------------------------------------------------
--cl_codigo_postal_resp_190405
------------------------------------------------------------
IF OBJECT_ID ('dbo.cl_codigo_postal_resp_190405') IS NOT NULL
	DROP table dbo.cl_codigo_postal_resp_190405

select *
into cl_codigo_postal_resp_190405
from cl_codigo_postal

select 'Termino codigo postal'
go

------------------------------------------------------------
--cl_direccion_resp_190405
------------------------------------------------------------
IF OBJECT_ID ('dbo.cl_direccion_resp_190405') IS NOT NULL
	DROP table dbo.cl_direccion_resp_190405
	
select *
into cl_direccion_resp_190405
from cl_direccion

select 'Termino direccion'
go

------------------------------------------------------------
--cl_parroquia_resp_190405
------------------------------------------------------------
IF OBJECT_ID ('dbo.cl_parroquia_resp_190405') IS NOT NULL
	DROP table dbo.cl_parroquia_resp_190405

select *
into cl_parroquia_resp_190405
from cl_parroquia

select 'Termino parroquia'
go

------------------------------------------------------------
--cl_ciudad_resp_190405
------------------------------------------------------------
IF OBJECT_ID ('dbo.cl_ciudad_resp_190405') IS NOT NULL
	DROP table dbo.cl_ciudad_resp_190405

select *
into cl_ciudad_resp_190405
from cl_ciudad

select 'Termino ciudad'
go

------------------------------------------------------------
--cl_provincia_resp_190405
------------------------------------------------------------
IF OBJECT_ID ('dbo.cl_provincia_resp_190405') IS NOT NULL
	DROP table dbo.cl_provincia_resp_190405
	
select *
into cl_provincia_resp_190405
from cl_provincia

select 'Termino provincia'
go

------------------------------------------------------------
--sb_equivalencias_resp_190405
------------------------------------------------------------
use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_equivalencias_resp_190405') IS NOT NULL
	DROP table dbo.sb_equivalencias_resp_190405

select *
into cob_conta_super..sb_equivalencias_resp_190405
from cob_conta_super..sb_equivalencias
where eq_catalogo in ('ENT_FED','ENT_MUN','ENT_PARROQ')

select 'Termino equivalencias'
go

------------------------------------------------------------
--Eliminar registros con municipio y colonia en 0
------------------------------------------------------------
use cobis
go
delete from cl_codigo_postal where cp_colonia = 0
delete from cl_codigo_postal where cp_estado = 0
delete from cl_codigo_postal where cp_municipio = 0

select 'Termino borrar registros existentes en 0'

go

print 'Fin script 00 respaldo: ' + convert(varchar(30), getdate(), 103) + '--' + convert(varchar(30), getdate(), 108)
--eq_catalogo = 'ENT_FED' --34 -- estado
--eq_catalogo = 'ENT_MUN'
--eq_catalogo = 'ENT_PARROQ'

go
