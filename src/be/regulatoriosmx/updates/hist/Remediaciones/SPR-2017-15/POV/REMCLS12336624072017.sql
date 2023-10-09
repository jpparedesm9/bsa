
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S123366 Validaciones Estado de Clientes y Solicitud IND
--Fecha                      : 21/07/2017
--Descripción del Problema   : No existe control de errores
--Descripción de la Solución : Agregar el error
--Autor                      : Paúl Ortiz Vera
--Instalador                 : 8_sta_error.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- Agregar error
--------------------------------------------------------------------------------------------
use cobis
go

delete cobis..cl_errores
where numero in (103142, 103143, 103144, 103145, 103146)


insert into cobis..cl_errores (numero, severidad, mensaje)
values (103142, 0, ' No se puede convertir en cliente porque no tiene información Santander ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103143, 0, ' No se puede insertar porque el integrante no es un Cliente ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103144, 0, ' Error al iniciar el flujo, el solicitante no es un Cliente ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103145, 0, ' Error al iniciar el flujo, un integrante del grupo no es un Cliente ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103146, 0, ' Error al crear relación: Por favor regularice el estado civil del Conyuge ')
go



-----------------------------------------------
---    Agregar campo para negocio
-----------------------------------------------
--Instalador                 : cl_table.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
use cobis
go

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'di_negocio' AND TABLE_NAME = 'cl_direccion')
BEGIN
    ALTER TABLE cobis..cl_direccion ADD di_negocio INT NULL 
END
else
begin
	ALTER TABLE cobis..cl_direccion ALTER COLUMN di_negocio INT NULL 
end

-----------------------------------------------
---    Agregar nuevo campo a la vista
-----------------------------------------------
--Instalador                 : cl_view.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql

IF OBJECT_ID ('dbo.ts_direccion') IS NOT NULL
	DROP VIEW dbo.ts_direccion
GO

create view ts_direccion    (
  secuencial,          tipo_transaccion,          clase,                     fecha,	hora,
  usuario,             terminal,                  srv,                       lsrv,    
  ente,                direccion,                 descripcion,               vigencia,
  sector,              zona,                      parroquia,                 ciudad,    
  tipo,                oficina,                   verificado,                barrio,
  provincia,           codpostal,                 casa,                      calle,
  pais,                correspondencia,           alquilada,                 cobro,
  edificio,            departamento,              rural_urbano,              fact_serv_pu,
  tipo_prop,           nombre_agencia,            fuente_verif,              fecha_ver,
  reside,              negocio
)    as
select
  ts_secuencial,       ts_tipo_transaccion,       ts_clase,                  ts_fecha,	ts_hora,
  ts_usuario,          ts_terminal,               ts_srv,                    ts_lsrv,
  ts_ente,             ts_direccion,              ts_descripcion,            ts_posicion,
  ts_sector,           ts_zona,                   ts_parroquia,              ts_ciudad,    
  ts_tipo,             ts_oficina,                ts_tipo_dp,                ts_barrio,
  ts_provincia,        ts_emp_postal,             ts_pasaporte,              ts_sucursal_ref,
  ts_pais,             ts_estatus,                ts_garantia,               ts_mandat,
  ts_razon_social,     ts_ingre,                  ts_dinero,                 ts_toperacion,
  ts_fecha_ref,        ts_clase_bienes_e,         ts_valor,                  ts_fecha_valuo,
  ts_tiempo_reside,    ts_lugar_doc
from    cl_tran_servicio
where    ts_tipo_transaccion    =    109
or        ts_tipo_transaccion    =    110
or        ts_tipo_transaccion    =    1226
GO
