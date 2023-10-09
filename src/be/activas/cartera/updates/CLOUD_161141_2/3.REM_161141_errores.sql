use cobis
go

--ERRORES LCR V2.0
delete cl_errores where numero in (2108089)
insert into cl_errores(numero, severidad, mensaje) 
values (2108089,0,'ERROR: LA SOLICITUD TIENE OTRO OFICIAL DIFERENTE AL DEL CLIENTE')

go