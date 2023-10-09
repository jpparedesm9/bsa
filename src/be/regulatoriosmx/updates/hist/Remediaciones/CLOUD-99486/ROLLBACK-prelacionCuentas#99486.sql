/* Agrega 2 insert a la tabla de prelacion_cuenta */ 


use cob_credito
go

delete cob_credito..cr_prelacion_cuenta where pc_producto in ('10', '17')
and pc_nivel in ('N5', 'N6')
go

delete cob_credito..cr_prelacion_nivel  where pn_nivel in ('N5', 'N6')

go



