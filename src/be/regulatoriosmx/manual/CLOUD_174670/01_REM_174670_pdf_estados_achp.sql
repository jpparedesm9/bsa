use cobis 
go 
-------------->>>>>>>> 
declare @w_codigo_tabla int 

select @w_codigo_tabla = codigo from cobis..cl_tabla where tabla = 'ca_param_notif' 

select * from cobis..cl_catalogo where tabla = @w_codigo_tabla and codigo in ('ETCIN_NJAS', 'ETCIN_NPDF', 'ETCIN_NXML')

delete cobis..cl_catalogo where tabla = @w_codigo_tabla and codigo in ('ETCIN_NJAS', 'ETCIN_NPDF', 'ETCIN_NXML')

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo_tabla, 'ETCIN_NJAS', 'AccountStatusIndividual.jasper', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo_tabla, 'ETCIN_NPDF', 'EstadoCtaCREIND_', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo_tabla, 'ETCIN_NXML', 'AccountStatusIndividual.xml', 'V', NULL, NULL, NULL)

select * from cl_catalogo where tabla = @w_codigo_tabla and codigo in ('ETCIN_NJAS', 'ETCIN_NPDF', 'ETCIN_NXML')

go
