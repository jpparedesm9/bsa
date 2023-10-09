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
go

------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>
------------>>>>>>>>>>>> Ingresa parametro
------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>
use cobis
go

delete cl_parametro where pa_producto = 'CRE' and pa_nemonico = 'FPDIND'
go

------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>
------------>>>>>>>>>>>> Ingresa error aval
------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>------------>>>>>>>>>>>>
use cobis
go

delete cl_errores where numero in (2108088)
