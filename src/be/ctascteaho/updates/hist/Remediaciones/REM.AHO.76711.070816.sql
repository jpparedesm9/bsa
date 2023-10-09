
/*************************************************/
-- Fecha Creación del Script:  08/Jul/2016
-- Historial  Dependencias:
-- TBA    08/Jul/2016   Se añade error 357537 para bug 76711
/*************************************************/ 

use cobis
go

if not exists (select 1 from cl_errores where numero = 357537)
begin
    insert into cl_errores values (357537, 0, 'ERROR OBTENIENDO DATOS DE CLIENTE COMERCIO')
end

go
