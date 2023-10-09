-- REQ 193221- B2B Grupal Digital
use cobis
go

--Antes
select * from cobis..cl_errores where numero in (103199, 103204)


delete from cobis..cl_errores where numero in (103199, 103204)

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103199, 0, 'NECESITA VERIFICAR SU CORREO')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103204, 0, 'NECESITA VERIFICAR SU TELEFONO CELULAR')


--Despues
select * from cobis..cl_errores where numero in (103199, 103204)

go
