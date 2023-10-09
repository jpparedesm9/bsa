
/*************************************************/
-- Fecha Creación del Script:  13/Jul/2016
-- Historial  Dependencias:
-- TBA    13/Jul/2016   Se añaden errores 301018 para bug 77278
/*************************************************/ 

--cc_error.sql

use cobis
go

--301018
if exists (select 1 from cl_errores where numero = 301018)
begin
    delete from cl_errores where numero =301018
end

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (301018, 0, 'No existe firmante de la cuenta')
GO

--307005
if exists (select 1 from cl_errores where numero = 307005)
begin
    delete from cl_errores where numero =307005
end


INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (307005, 1, 'Error en eliminacion de firmante')
GO

--301009
if exists (select 1 from cl_errores where numero = 301009)
begin
    delete from cl_errores where numero =301009
end

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (301009, 0, 'Operacion invalida')
GO
