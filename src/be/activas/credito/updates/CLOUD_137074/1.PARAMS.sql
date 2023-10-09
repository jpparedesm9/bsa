use cobis
go
delete from cl_parametro where pa_nemonico='CA3DR'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('CLIENTE CON A3 DR','CA3DR','C','A3 DR','CLI')
go

declare @w_tabla int
select @w_tabla = codigo from cobis..cl_tabla where tabla = 'cre_des_riesgo'

delete from cl_catalogo where codigo in ('012','013','014') and tabla = @w_tabla

insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'012','No. Contrapartes','V')

insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'013','Canal de contratación','V')

insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'014','F. Nacimiento / Constitución','V')
go

