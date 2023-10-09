/******************************************************************/
/*                        COBIS CORPORATION                       */
/******************************************************************/
/*  SCRIPT DE PARAMETRIZACION PARA CREACION DE BASE DE DATOS      */
/*  DE LOS PRODUCTOS COBIS NECESARIOS PARA ARIAS2                 */
/******************************************************************/

use master
go

print 'Creando Estructuras para la Parametrizaci¢n'
go

if exists (select * from sysobjects where name = 'parambd_cobis')
	drop table parambd_cobis
go

create table parambd_cobis (
	secuencial	tinyint		not null,
	nombre		varchar(30)	not null,
	ruta_fisica	varchar(255)	not null,
	tamano_data	int		not null,
	tamano_log	int		not null,
	producto	char(3)		not null
)
go

if exists (select * from sysobjects where name = 'bd_cobis_actual')
	drop table bd_cobis_actual
go

create table bd_cobis_actual (
	prod_actual	char(3)		not null
)
go

create unique index parambd_cobis_Key ON parambd_cobis (secuencial)
go
create unique index parambd_cobis_Index ON parambd_cobis (nombre)
go

print 'Ingresando la Parametrizaci¢n de las Base de Datos'
go

insert into parambd_cobis (secuencial,nombre,ruta_fisica,tamano_data,tamano_log,producto) values (1,'cob_pac','f:\Datos',100,50, 'PAC')
go

--select * from parambd_cobis

print 'Generaci¢n Estructuras y Parametrizaci¢n Finalizada'
go
