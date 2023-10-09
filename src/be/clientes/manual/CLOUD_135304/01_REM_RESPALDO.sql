---------------------RESPALDO
use cobis
go

------------------------------------------------------------
--cl_codigo_postal_tmp_resp_135304
------------------------------------------------------------
IF OBJECT_ID ('dbo.cl_codigo_postal_tmp_resp_135304') IS NOT NULL
	DROP table dbo.cl_codigo_postal_tmp_resp_135304

select *
into cl_codigo_postal_tmp_resp_135304
from cl_codigo_postal_tmp

select 'Termino codigo postal tmp'
go

------------------------------------------------------------
--cl_codigo_postal_resp_135304
------------------------------------------------------------
IF OBJECT_ID ('dbo.cl_codigo_postal_resp_135304') IS NOT NULL
	DROP table dbo.cl_codigo_postal_resp_135304

select *
into cl_codigo_postal_resp_135304
from cl_codigo_postal

select 'Termino codigo postal'
go

------------------------------------------------------------
--cl_direccion_resp_135304
------------------------------------------------------------
IF OBJECT_ID ('dbo.cl_direccion_resp_135304') IS NOT NULL
	DROP table dbo.cl_direccion_resp_135304
	
select *
into cl_direccion_resp_135304
from cl_direccion

select 'Termino direccion'
go

------------------------------------------------------------
--cl_parroquia_resp_135304
------------------------------------------------------------
IF OBJECT_ID ('dbo.cl_parroquia_resp_135304') IS NOT NULL
	DROP table dbo.cl_parroquia_resp_135304

select *
into cl_parroquia_resp_135304
from cl_parroquia

select 'Termino parroquia'
go

------------------------------------------------------------
--ci_ciudad_resp_135304
------------------------------------------------------------
IF OBJECT_ID ('dbo.cl_ciudad_resp_135304') IS NOT NULL
	DROP table dbo.cl_ciudad_resp_135304

select *
into cl_ciudad_resp_135304
from cl_ciudad

select 'Termino ciudad'
go

------------------------------------------------------------
--cl_provincia_resp_135304
------------------------------------------------------------
IF OBJECT_ID ('dbo.cl_provincia_resp_135304') IS NOT NULL
	DROP table dbo.cl_provincia_resp_135304
	
select *
into cl_provincia_resp_135304
from cl_provincia

select 'Termino provincia'
go

------------------------------------------------------------
--sb_equivalencias_resp_135304
------------------------------------------------------------
use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_equivalencias_resp_135304') IS NOT NULL
	DROP table dbo.sb_equivalencias_resp_135304

select *
into cob_conta_super..sb_equivalencias_resp_135304
from cob_conta_super..sb_equivalencias
where eq_catalogo in ('ENT_FED','ENT_MUN','ENT_PARROQ')

select 'Termino equivalencias'
go

--eq_catalogo   ='ENT_FED' --34 -- estado
--eq_catalogo   = 'ENT_MUN'
--eq_catalogo   = 'ENT_PARROQ'

------------------------------------------------------------
--creacion de cl_codigo_postal_tmp, nuevas columnas
------------------------------------------------------------
use cobis
go

IF OBJECT_ID ('dbo.cl_codigo_postal_tmp') IS NOT NULL
	DROP TABLE dbo.cl_codigo_postal_tmp
GO

CREATE TABLE dbo.cl_codigo_postal_tmp
	(
	cp_codigo           VARCHAR (10) NOT NULL,
	cp_estado           VARCHAR (20),
	cp_nombre_estado    VARCHAR (255),
	cp_municipio        VARCHAR (20),
	cp_nombre_municipio VARCHAR (255),
	cp_colonia          VARCHAR (20),
	cp_nombre_col       VARCHAR (255)
	)
GO

CREATE INDEX idx_1
	ON dbo.cl_codigo_postal_tmp (cp_codigo)
GO

CREATE INDEX idx_2
	ON dbo.cl_codigo_postal_tmp (cp_colonia)
GO

select 'Termino crear tabla cl_codigo_postal_tmp'
go
