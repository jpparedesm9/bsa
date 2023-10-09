------------------------------------------------------------------
-- Archivo remediación para rollback de parámetro medio de envio -
-- Req. 158566 - Mejoras enrolamiento B2C
------------------------------------------------------------------
use cobis
go

delete cl_parametro where pa_nemonico in ('ENRTPL', 'OTPTPL', 'IMGTPL', 'B2CMEN') 

declare 
@w_codigo      int

select @w_codigo = codigo from cl_tabla where tabla = 'ns_plantilla_sms'
delete cl_catalogo where tabla = @w_codigo and codigo in ( '50470', '50471', '50472' )

declare 
@w_codigo      int

select @w_codigo = codigo from cl_tabla where tabla = 'ns_bloque_sms'
delete cl_catalogo where tabla = @w_codigo and codigo in ( '3', '4' )


go