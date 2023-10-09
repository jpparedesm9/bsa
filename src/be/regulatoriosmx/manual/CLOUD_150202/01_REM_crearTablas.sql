-----------------------------------------------------------------
--- INGRESAR LA DATA ref.caso150202----
-----------------------------------------------------------------
use cob_conta_super
go

if object_id ('info_gen_xml_refacturacion') is not null
    drop table info_gen_xml_refacturacion
go

create table info_gen_xml_refacturacion (
   id int identity (1, 1) not null,
   cliente_id int,
   buc varchar (30),
   banco varchar (30),
   interes_devengado_exigible money,
   monto_iva money,
   anio_facturacion char(4),
   mes_facturacion char(2),
   nombre_archivo varchar(255),
   procesado char(1),
   fecha_generacion_archivo datetime
)
 create clustered index info_gen_xml_refacturacion_key
	on info_gen_xml_refacturacion (id, buc, banco, anio_facturacion, mes_facturacion)
go

-----------------------------------------------------------------
--- INGRESAR FECHA A PROCESAR ref.caso150202
-----------------------------------------------------------------
if object_id ('fecha_gen_xml_refacturacion') is not null
    drop table fecha_gen_xml_refacturacion
go

create table fecha_gen_xml_refacturacion(
    orden int PRIMARY KEY NOT NULL,
    fecha datetime,
	ingreso char(1),
	generacion char(1)
)
-----------------------------------------------------------------
-----------------------------------------------------------------
--- PARA GENERAR LOS ARCHIVOS ref.caso150202
-----------------------------------------------------------------
if object_id ('gen_xml_refacturacion') is not null
    drop table gen_xml_refacturacion
go

create table gen_xml_refacturacion(
   trama nvarchar(max)
)
go

-----------------------------------------------------------------
--- CREACION DE PARAMETRO PARA RUTA  ref.caso150202
if exists (select 1 from cobis..cl_parametro where pa_nemonico = 'RREFX1' and pa_producto = 'REC')
    delete from cobis..cl_parametro where pa_nemonico = 'RREFX1'  and pa_producto = 'REC'

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('RUTA REFACTURACION GEN XML 1', 'RREFX1', 'C', 'D:\WorkFolder\ReFactGenXML\', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')

PRINT 'Fin creacion tablas tmp y parametros'