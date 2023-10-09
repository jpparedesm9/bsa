/**********************************************************************************************************************/
--No Bug                                : NA
--Título de la Historia           : CGS-R117762 Cambio en Direcciones
--Fecha                                      : 13/06/2017
--Descripción del Problema   : nueva funcionalidad
--Descripción de la Solución : Agregar nueva tabla para registrar el codigo postal
--Autor                      : Maria Jose Taco
--Instalador                 : cl_table.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/
use cobis
go

IF OBJECT_ID ('dbo.cl_codigo_postal') IS NOT NULL
 DROP TABLE dbo.cl_codigo_postal
GO

create table cl_codigo_postal(
cp_codigo            varchar(10) not null,
cp_estado            int         null,
cp_municipio         int         null,
cp_colonia           int         null,
cp_pais              int         NULL,
cp_estado_h          VARCHAR(20) null,
cp_municipio_h       VARCHAR(20) null,
cp_colonia_h         VARCHAR(20) null
)
go

CREATE INDEX idx_1 ON cl_codigo_postal (cp_codigo)
GO