PRINT 'Inicio crear tablas'
/**************************************************************/
--- INGRESAR LA DATA ref.caso150202 - 152243
/**************************************************************/
use cob_conta_super
go

if object_id ('sb_info_gen_xml_refacturacion') is not null
    drop table sb_info_gen_xml_refacturacion
go

create table sb_info_gen_xml_refacturacion (
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
   fecha_generacion_archivo datetime,
   timbrado char(1)
)
 create clustered index sb_info_gen_xml_refacturacion_key
	on sb_info_gen_xml_refacturacion (id, buc, banco, anio_facturacion, mes_facturacion)
go

/**************************************************************/
--- INGRESAR FECHA A PROCESAR ref.caso150202
/**************************************************************/
if object_id ('sb_fecha_gen_xml_refacturacion') is not null
    drop table sb_fecha_gen_xml_refacturacion
go

create table sb_fecha_gen_xml_refacturacion(
    orden int PRIMARY KEY NOT NULL,
    fecha datetime,
	ingreso char(1),
	generacion char(1)
)
/**************************************************************/
--- PARA GENERAR LOS ARCHIVOS ref.caso150202
/**************************************************************/
if object_id ('sb_gen_xml_refacturacion') is not null
    drop table sb_gen_xml_refacturacion
go

create table sb_gen_xml_refacturacion(
   trama nvarchar(max)
)
go

-----------------------------------------------------------------
--- INGRESAR LA DATA ref.caso 152243
-----------------------------------------------------------------

if object_id ('sb_info_reprt_factura_generada') is not null
    drop table sb_info_reprt_factura_generada
go

create table sb_info_reprt_factura_generada (
   g_id int identity (1, 1) not null,
   g_cliente int,
   g_banco varchar (30),
   g_cfdi_UUID varchar (255),
   g_rfc_ordenante varchar (255),
   g_rfc varchar (255),
   g_rfc_generico varchar (255),   
   g_monto money,
   g_fecha varchar(255),
   g_anio varchar(4),
   g_mes varchar(2),
   g_dia varchar(2)
)
 create clustered index sb_info_reprt_factura_generada_key
	on sb_info_reprt_factura_generada (g_id, g_banco, g_fecha)
go
PRINT 'Fin crear tablas'