
/*************************************************/
-- Fecha Creación del Script:  12/Jul/2016
-- Historial  Dependencias:
-- TBA    12/Jul/2016   Se añade error 357537 para bug 76711
/*************************************************/ 

--cc_error.sql

use cobis
go


if exists (select 1 from cl_errores where numero = 357516)
begin
    delete from cl_errores where numero =357516
end

insert into cl_errores values (357516, 0, 'YA EXISTE TOPE PARA PRODUCTO')

go

