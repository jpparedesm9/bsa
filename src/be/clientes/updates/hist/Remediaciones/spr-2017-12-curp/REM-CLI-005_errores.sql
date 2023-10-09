/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : N/A
--Fecha                      : 13/06/2017
--Descripción del Problema   : Agregar codigos de error
--Descripción de la Solución : Agregar codigos de error
--Autor                      : Maria Jose Taco
--Instalador                 : cl_errores.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/
use cobis
go

declare @w_codigo int

if not exists( select 1 from cl_errores where numero = 70011007)
   insert into cl_errores (numero, severidad, mensaje) values (70011007, 0, 'Ya existe una persona con esta Identificacion. CURP')


if not exists( select 1 from cl_errores where numero = 70011008)
   insert into cl_errores (numero, severidad, mensaje) values (70011008, 0, 'Ya existe una persona con esta Identificacion. RFC')

if not exists( select 1 from cl_errores where numero = 7300004)
   insert into cl_errores (numero, severidad, mensaje) values (7300004, 0, 'Error en la creación del cliente')
   
go