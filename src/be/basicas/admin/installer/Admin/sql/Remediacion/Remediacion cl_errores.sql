use cobis
go

if exists(select * from cl_errores where mensaje = 'Existe referencia de oficina horario')
	delete from cl_errores where mensaje = 'Existe referencia de oficina horario'
insert into cl_errores values (157229, 1, 'Existe referencia de oficina horario')

if exists(select * from cl_errores where mensaje = 'Error en autorizacion de componentes')
	delete from cl_errores where mensaje = 'Error en autorizacion de componentes'
insert into cl_errores values (157230, 1, 'Error en autorizacion de componentes')

if exists(select * from cl_errores where mensaje = 'Error en autorizacion de modulos')
	delete from cl_errores where mensaje = 'Error en autorizacion de modulos'
insert into cl_errores values (157231, 1, 'Error en autorizacion de modulos')

if exists(select * from cl_errores where mensaje = 'Error en autorizacion de paginas')
	delete from cl_errores where mensaje = 'Error en autorizacion de paginas'
insert into cl_errores values (157232, 1, 'Error en autorizacion de paginas')

if exists(select * from cl_errores where mensaje = 'Error en autorizacion de zonas de navegacion')
	delete from cl_errores where mensaje = 'Error en autorizacion de zonas de navegacion'
insert into cl_errores values (157233, 1, 'Error en autorizacion de zonas de navegacion')
go