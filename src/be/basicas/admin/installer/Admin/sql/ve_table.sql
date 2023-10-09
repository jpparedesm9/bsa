/************************************************************************/
/*                   MODIFICACIONES                                     */
/*      FECHA          AUTOR              RAZON                         */
/*      14/ABR/2016     BBO             Migracion SYBASE-SQLServer FAL  */
/************************************************************************/
use cobis
go

print 've_version'
if exists (select * from sysobjects where name = 've_version' )
	drop table ve_version
go
create table ve_version(
	ve_producto     tinyint not null,
	ve_archivo	descripcion not null,
	ve_oficina	smallint not null,
	ve_numero1      tinyint not null,
	ve_numero2	tinyint not null,
	ve_numero3	tinyint not null,
	ve_fecha_mod    datetime not null,
	ve_usuario	login	not null,
	ve_proposito	catalogo not null)
go

print 've_version_his'
if exists (select * from sysobjects where name = 've_version_his' )
	drop table ve_version_his
go
create table ve_version_his(
	ve_producto     tinyint not null,
	ve_archivo	descripcion not null,
	ve_oficina	smallint not null,
	ve_numero1      tinyint not null,
	ve_numero2	tinyint not null,
	ve_numero3	tinyint not null,
	ve_fecha_mod    datetime not null,
	ve_usuario	login	not null,
	ve_proposito	catalogo not null)
go

print 've_producto'
if exists (select * from sysobjects where name = 've_producto' )
	drop table ve_producto
go
create table ve_producto (
	pr_empresa      tinyint not null,
	pr_producto     tinyint not null,
	pr_version	char(1) not null,
	pr_fecha_mod    datetime not null)
go

print 'ad_producto_respaldo'
if exists (select * from sysobjects where name = 'ad_producto_respaldo' )
	drop table ad_producto_respaldo
go
create table ad_producto_respaldo (
	pr_producto              tinyint not null,
	pr_abreviatura        char(3) not null,
                     pr_base_datos        varchar(64) not null,
                     pr_catalogos            char(1) not null,
                     pr_parametros_g    char(1) not null,
                     pr_secuenciales     char (1) not null,
                     pr_perfiles                 char(1) not null,
                     pr_tablas_param    char(1) not null)	
go

print 'ad_parametrizacion_respaldo'
if exists (select * from sysobjects where name = 'ad_parametrizacion_respaldo' )
	drop table ad_parametrizacion_respaldo
go
create table ad_parametrizacion_respaldo (
	pr_producto              tinyint  not null,
	pr_tablas                   varchar(64) not null)
go

print 'ad_iniciales_catalogo'
if exists (select * from sysobjects where name = 'ad_iniciales_catalogo' )
	drop table ad_iniciales_catalogo
go
create table ad_iniciales_catalogo (
	ic_producto              tinyint  not null,
	ic_inicial                   varchar(64) not null)
go



