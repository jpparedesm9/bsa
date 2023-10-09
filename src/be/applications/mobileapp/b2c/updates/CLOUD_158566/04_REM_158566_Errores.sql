use cobis
go

delete cl_errores where numero in (1890017, 1890018, 1890019, 1890020)

insert into cl_errores values (1890017, 0, 'ERROR: NO SE INGRESO UN NÚMERO DE CELULAR')
insert into cl_errores values (1890018, 0, 'ERROR: NO SE INGRESO UN CORREO ELECTRÓNICO')
insert into cl_errores values (1890019, 0, 'El número de celular ingresado no está registrado para un cliente de este servicio')
insert into cl_errores values (1890020, 0, 'El cliente no tiene operaciones activas')
go