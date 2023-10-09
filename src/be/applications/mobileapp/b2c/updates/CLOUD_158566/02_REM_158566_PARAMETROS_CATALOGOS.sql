------------------------------------------------------------------
-- Archivo remediación para creación de parámetro medio de envio -
-- Req. 158566 - Mejoras enrolamiento B2C
------------------------------------------------------------------
use cobis
go

declare 
@w_producto_abrev      varchar(3)

select @w_producto_abrev  = pd_abreviatura from cl_producto where pd_descripcion = 'BANCA VIRTUAL'
delete cl_parametro where pa_nemonico in ('ENRTPL', 'OTPTPL', 'IMGTPL', 'B2CMEN') 

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TEMPLATE SMS ENROLAMIENTO', 'ENRTPL', 'I', null, null, null, 50470, null, null, null, @w_producto_abrev)
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TEMPLATE SMS OTP', 'OTPTPL', 'I', null, null, null, 50471, null, null, null, @w_producto_abrev)
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TEMPLATE IMAGEN BIENVENIDA', 'IMGTPL', 'I', null, null, null, 50472, null, null, null, @w_producto_abrev)
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('B2C - TIPO MEDIO DE ENVIO ','B2CMEN', 'T','SMS', null, null, null, null, null, null, 'BVI')

go

declare 
@w_codigo      int

select @w_codigo = codigo from cl_tabla where tabla = 'ns_plantilla_sms'
delete cl_catalogo where tabla = @w_codigo and codigo in ( '50470', '50471', '50472' )

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo, '50470', 'TUIIO_Descarga_la_APP_Tuiio_M+ovil_y_maneja_tu_crédito', 'V', null, null, null)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo, '50471', 'TUIIO_Clave_de_ingreso_Tuiio_Movil', 'V', null, null, null)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo, '50472', 'TUIIO_Se_Cambio_la_imagen_de_bienvenida', 'V', null, null, null)

go

declare 
@w_codigo      int

select @w_codigo = codigo from cl_tabla where tabla = 'ns_bloque_sms'
delete cl_catalogo where tabla = @w_codigo and codigo in ( '3', '4' )

insert into cobis.dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo, '3', 'ENROLAMIENTO', 'V', NULL, NULL, NULL)

insert into cobis.dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo, '4', 'OTP', 'V', NULL, NULL, NULL)

go