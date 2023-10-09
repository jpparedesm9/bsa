use cobis 
go 
------------->>>>>>>>>>>>
declare @w_codigo_tabla int 

select @w_codigo_tabla = codigo from cobis..cl_tabla where tabla = 'ca_param_notif' 

select * from cobis..cl_catalogo where tabla = @w_codigo_tabla and codigo in ('ETCIN_NJAS', 'ETCIN_NPDF', 'ETCIN_NXML')

delete cobis..cl_catalogo where tabla = @w_codigo_tabla and codigo in ('ETCIN_NJAS', 'ETCIN_NPDF', 'ETCIN_NXML')

select * from cl_catalogo where tabla = @w_codigo_tabla and codigo in ('ETCIN_NJAS', 'ETCIN_NPDF', 'ETCIN_NXML')
go
