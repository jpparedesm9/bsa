use cobis
go
-----------------------RESPALDO
------------------------------------------------------------
--cl_codigo_postal_tmp_resp_212473
------------------------------------------------------------
truncate table cl_codigo_postal_tmp

insert into cl_codigo_postal_tmp
select *
from cl_codigo_postal_tmp_resp_212473

select 'Termino codigo postal tmp'
go

------------------------------------------------------------
--cl_codigo_postal_resp_212473
------------------------------------------------------------
truncate table cl_codigo_postal

insert into cl_codigo_postal
select *
from cl_codigo_postal_resp_212473

select 'Termino codigo postal'
go

------------------------------------------------------------
--cl_direccion_resp_212473
------------------------------------------------------------
delete cl_direccion
where di_ente in (select di_ente from cl_direccion_resp_212473) 
	
insert into cl_direccion
select *
from cl_direccion_resp_212473

select 'Termino direccion'
go

------------------------------------------------------------
--cl_parroquia_resp_212473
------------------------------------------------------------
truncate table cl_parroquia

insert into cl_parroquia
select *
from cl_parroquia_resp_212473

select 'Termino parroquia'
go

------------------------------------------------------------
--cl_ciudad_resp_212473
------------------------------------------------------------
truncate table cl_ciudad

insert into cl_ciudad
select *
from cl_ciudad_resp_212473

select 'Termino ciudad'
go

------------------------------------------------------------
--cl_provincia_resp_212473
------------------------------------------------------------
truncate table cl_provincia

insert into cl_provincia
select *
from cl_provincia_resp_212473

select 'Termino provincia'
go

------------------------------------------------------------
--sb_equivalencias_resp_190405
------------------------------------------------------------
use cob_conta_super
go

delete from cob_conta_super..sb_equivalencias
where eq_catalogo in ('ENT_FED','ENT_MUN','ENT_PARROQ')

insert into sb_equivalencias
select *
from cob_conta_super..sb_equivalencias_resp_212473
where eq_catalogo in ('ENT_FED','ENT_MUN','ENT_PARROQ')

select 'Termino equivalencias'
go

print 'Fin script 00 respaldo: ' + convert(varchar(30), getdate(), 103) + '--' + convert(varchar(30), getdate(), 108)
--eq_catalogo = 'ENT_FED'--34 -- estado
--eq_catalogo = 'ENT_MUN'
--eq_catalogo = 'ENT_PARROQ'

go
