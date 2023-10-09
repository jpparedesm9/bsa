--*********Grupal
--OriginalHeader_PaymentFrequency_input
--OriginalHeader_Term
--*********Individual
--OriginalHeader_frequency_input
--OriginalHeader_termInd_input
--*********Colectivo
--OriginalHeader_frequencyRevolving_input
--*********individual Revolvente
--OriginalHeader_frequencyRevolving_input

--basado en SELECT * FROM cobis..cl_catalogo WHERE tabla IN (SELECT codigo FROM cobis..cl_tabla WHERE tabla = 'ca_periodicidad_lcr')

------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>
------------>>>>>>>>>>>> Ingreso a tabla
------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>

use cob_credito
go

if OBJECT_ID ('dbo.cr_plazo_ind') is not null
	drop table dbo.cr_plazo_ind
GO

create table dbo.cr_plazo_ind (
    pi_frecuencia char(10),
    pi_plazo int
)

insert into cr_plazo_ind values ('W', 16)
insert into cr_plazo_ind values ('W', 20)
insert into cr_plazo_ind values ('W', 24)

insert into cr_plazo_ind values ('BW', 8)
insert into cr_plazo_ind values ('BW', 10)
insert into cr_plazo_ind values ('BW', 12)

insert into cr_plazo_ind values ('M', 4)
insert into cr_plazo_ind values ('M', 5)
insert into cr_plazo_ind values ('M', 6)
go

------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>
------------>>>>>>>>>>>> Ingresa parametro
------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>
use cobis
go

delete cl_parametro where pa_producto = 'CRE' and pa_nemonico = 'FPDIND'

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('FRECUENCIA PLAZO DEFECTO INDIVIDUAL', 'FPDIND', 'C', 'W;16', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
go

------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>
------------>>>>>>>>>>>> Ingresa error aval
------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>
use cobis
go

delete cl_errores where numero in (2108088)

insert into cl_errores(numero, severidad, mensaje) values (2108088,0,'ERROR: El cliente no puede ser Aval')
go
