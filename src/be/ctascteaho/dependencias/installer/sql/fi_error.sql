
use cobis
go

delete from cl_errores 
 where numero in (301018,307005,301009)

insert into cl_errores values (301018, 0, 'No existe firmante de la cuenta')
go

insert into cl_errores values (307005, 1, 'Error en eliminacion de firmante')
go

insert into cl_errores values (301009, 0, 'Operacion invalida')
go

