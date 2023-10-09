
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S124039 Formatos de Documentos - Flujo Individual Parte II
--Fecha                      : 21/07/2017
--Descripción del Problema   :
--Descripción de la Solución : Creacion de Errores
--Autor                      : Walther Toledo
--Instalador                 : cr_errrores.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
/**********************************************************************************************************************/
use cobis
go
delete from cl_errores where numero in (2108036)
go
insert into cobis..cl_errores (numero, severidad, mensaje) values (2108036,  0, 'NO EXISTE TABLA DE AMORTIZACION PARA ESTE TRAMITE.')

go

