use cobis
go



select * from cobis..cl_errores where numero = 701195
delete cobis..cl_errores where numero = 701195
insert into cobis..cl_errores (numero, severidad, mensaje)
values (701195, 0, 'La fecha de pago no debe ser feriado o fines de semana')

select * from cobis..cl_errores where numero = 701195



select * from cobis..cl_errores where numero = 701196
delete cobis..cl_errores where numero = 701196
insert into cobis..cl_errores (numero, severidad, mensaje)
values (701196, 0, 'Verifica tu día de Pago')

select * from cobis..cl_errores where numero = 701196


select * from cobis..cl_errores where numero = 701197
delete cobis..cl_errores where numero = 701197
insert into cobis..cl_errores (numero, severidad, mensaje)
values (701197, 0, 'La fecha de pago es menor a la fecha de desembolso')

select * from cobis..cl_errores where numero = 701197



select * from cobis..cl_errores where numero = 701198
delete cobis..cl_errores where numero = 701198
insert into cobis..cl_errores (numero, severidad, mensaje)
values (701198, 0, 'Fecha generada inválida para día de pago')

select * from cobis..cl_errores where numero = 701198