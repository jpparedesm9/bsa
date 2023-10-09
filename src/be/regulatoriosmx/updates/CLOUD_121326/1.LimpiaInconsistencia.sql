/* Este script elimina una operacion inconsistente en el consolidador*/
/* que se encuentra en todos los ambiente incluso produccion*/
/* Se valida el tema con Fabian de la Torre indicando que la misma */
/* pertenece a una prueba inicial de LCR que se realizo en Produccion*/
use cob_conta_super
go

delete from 
cob_conta_super..sb_dato_operacion 
where do_banco='233510035170'

go
