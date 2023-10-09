/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-R117557 Modificaciones - Demo 1
--Fecha                      : 21/06/2017
--Descripción del Problema   : Agregando campo Destino credito
--Descripción de la Solución : Agregar el campo
--Autor                      : Paúl Ortiz Vera
--Instalador                 : cl_view.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/

-- Creacion de nuevo campo

use cobis
go

------------------------------------------------------------------
print ('CREACION VISTA - ts_negocio_cliente' )
------------------------------------------------------------------

IF OBJECT_ID ('dbo.ts_negocio_cliente') IS NOT NULL
	DROP TABLE dbo.ts_negocio_cliente
GO

create table ts_negocio_cliente (
        ts_secuencial       int         not null,
        ts_codigo           int         not null,
        ts_ente             int         not null,
        ts_nombre           varchar(60) null,
        ts_giro             varchar(10) null,
        ts_fecha_apertura   datetime    null,
        ts_calle            varchar(80) null,
        ts_nro              int         null,
        ts_colonia          varchar(10) null,
        ts_localidad        varchar(10) null,
        ts_municipio        varchar(10) null,
        ts_estado           varchar(10) null,
        ts_codpostal        varchar(30) null,
        ts_pais             varchar(10) null,
        ts_telefono         varchar(20) null,
        ts_actividad_ec     varchar(10) null,
        ts_tiempo_actividad int         null,
        ts_tiempo_dom_neg   int         null,
        ts_emprendedor      char(1)     null,
        ts_recurso          varchar(10) null,
        ts_ingreso_mensual  money       null,
        ts_tipo_local       varchar(10) null,
        ts_usuario          login,
        ts_oficina          int,
        ts_fecha_proceso    datetime,
        ts_operacion        varchar(1),
        ts_estado_reg       varchar(10) null,
		ts_destino_credito  varchar(10) null
)
go


print '=====> ix_ts_negocio_cliente'
go
create nonclustered index ix_ts_negocio_cliente on ts_negocio_cliente
(
    ts_codigo,
    ts_ente,
    ts_usuario
) on indexgroup
go

