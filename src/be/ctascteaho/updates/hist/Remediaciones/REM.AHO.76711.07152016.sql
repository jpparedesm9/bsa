/*************************************************/
-- Fecha Creación del Script:  15/Jul/2016
-- Historial  Dependencias:
-- TBA    15/Jul/2016   Se añade error 357537 para bug 76711
/*************************************************/ 

--NO APLICA A INSTALADOR
--Nota: Es un script para eliminar registros insertados con data no valida debido a un bug en la pantalla Topes de oficina

use cob_remesas
go

delete from pe_causales_restringidas
where cr_origen is null
   or cr_especie is null
go
