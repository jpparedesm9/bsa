use cobis
go

declare @w_codigo_tabla int

if not exists(select 1 from cobis..cl_tabla where tabla='causa_rechazo')
begin
	select @w_codigo_tabla = max(codigo)+1 from cobis..cl_tabla
	insert into cl_tabla (codigo, tabla, descripcion)
	values (@w_codigo_tabla, 'causa_rechazo', 'causas de rechazo de transacciones en Santander')
end

select @w_codigo_tabla =  codigo from cobis..cl_tabla where tabla='causa_rechazo'

if not exists (select 1 from cobis..cl_catalogo where tabla=@w_codigo_tabla and codigo='05')
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo_tabla, '05', 'CUENTA CERRADA', 'V', NULL, NULL, NULL)


if not exists (select 1 from cobis..cl_catalogo where tabla=@w_codigo_tabla and codigo='P6')
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo_tabla, 'P6', 'OP. EXCEDE MONTO PERMITIDO POR BANXICO PARA DEPOSITAR', 'V', NULL, NULL, NULL)


if not exists (select 1 from cobis..cl_catalogo where tabla=@w_codigo_tabla and codigo='X2')
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo_tabla, 'X2', 'CUENTA BLOQUEADA', 'V', NULL, NULL, NULL)





	
