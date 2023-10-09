use cobis
go 

delete from cobis..cl_errores where numero in (103413,103414,103415)

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103413, 0, 'DATOS DEL CLIENTE INSUFICIENTES')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103414, 0, 'ERROR AL REALIZAR AUTO ONBOARDING')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103415, 0, 'ERROR AL GUARDAR EL ID DEL EXPEDIENTE')

go