/* Agrega 2 insert a la tabla de prelacion_cuenta */ 
/* Agrega 2 insert a la tabla de prelacion_nivel */ 


use cob_credito
go


delete cob_credito..cr_prelacion_cuenta where pc_producto in ('10', '17')
and pc_nivel in ('N5', 'N6')

insert into cob_credito..cr_prelacion_cuenta values ('10', '0060', 'N5')
insert into cob_credito..cr_prelacion_cuenta values ('17', '0060', 'N6')

go


insert into cob_credito..cr_prelacion_nivel  values ('N5',5)
insert into cob_credito..cr_prelacion_nivel  values ('N6',7)

go
