use cobis
go
------------------------------------------------------------
--cl_codigo_postal_tmp_resp_135304
------------------------------------------------------------
IF OBJECT_ID ('dbo.cl_codigo_postal_tmp') IS NOT NULL
	DROP TABLE dbo.cl_codigo_postal_tmp
GO

CREATE TABLE dbo.cl_codigo_postal_tmp
	(
	cp_codigo     VARCHAR (10) NOT NULL,
	cp_estado     VARCHAR (20),
	cp_municipio  VARCHAR (20),
	cp_colonia    VARCHAR (20),
	cp_nombre_col VARCHAR (255)
	)
GO

CREATE INDEX idx_1
	ON dbo.cl_codigo_postal_tmp (cp_codigo)
GO

CREATE INDEX idx_2
	ON dbo.cl_codigo_postal_tmp (cp_colonia)
GO

insert into cl_codigo_postal_tmp
select *
from cl_codigo_postal_tmp_resp_135304

select 'Termino codigo postal tmp'
go

------------------------------------------------------------
--cl_codigo_postal_resp_135304
------------------------------------------------------------
truncate table cl_codigo_postal

insert into cl_codigo_postal
select *
from cl_codigo_postal_resp_135304

select 'Termino codigo postal'
go

------------------------------------------------------------
--cl_direccion_resp_135304
------------------------------------------------------------
delete cl_direccion
where di_direccion in (select di_direccion from cl_direccion_resp_135304) 
	
insert into cl_direccion
select *
from cl_direccion_resp_135304

select 'Termino direccion'
go

------------------------------------------------------------
--cl_parroquia_resp_135304
------------------------------------------------------------
truncate table cl_parroquia

insert into cl_parroquia
select *
from cl_parroquia_resp_135304

select 'Termino parroquia'
go

------------------------------------------------------------
--ci_ciudad_resp_135304
------------------------------------------------------------
truncate table cl_ciudad

insert into cl_ciudad
select *
from cl_ciudad_resp_135304

select 'Termino ciudad'
go

------------------------------------------------------------
--cl_provincia_resp_135304
------------------------------------------------------------
truncate table cl_provincia

insert into cl_provincia
select *
from cl_provincia_resp_135304

select 'Termino provincia'
go

------------------------------------------------------------
--sb_equivalencias_resp_135304
------------------------------------------------------------
use cob_conta_super
go
delete sb_equivalencias
where  eq_catalogo in ('ENT_FED','ENT_MUN','ENT_PARROQ')

insert sb_equivalencias
select *
from sb_equivalencias_resp_135304
where eq_catalogo in ('ENT_FED','ENT_MUN','ENT_PARROQ')

select 'Termino equivalencias'
go

--eq_catalogo   = 'ENT_FED' --34 -- estado
--eq_catalogo   = 'ENT_MUN'
--eq_catalogo   = 'ENT_PARROQ'
