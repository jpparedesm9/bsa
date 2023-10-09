--NOMBRE INCORRECTO: MA CARMEN CERVANTES MARTINES
--NOMBRE CORRECTO: MA. CARMEN CERVANTES MARTINEZ

use cob_cartera
go


update cob_cartera..ca_operacion
set op_nombre = 'CERVANTES MARTINEZ MA.'
where op_operacion in (251442,39851,121617)

update cob_cartera..ca_operacion_his
set oph_nombre = 'CERVANTES MARTINEZ MA.'
where oph_operacion in (251442,39851,121617)

update cob_cartera_his..ca_operacion_his
set oph_nombre = 'CERVANTES MARTINEZ MA.'
where oph_operacion in (251442,39851,121617)

update cob_cartera_his..ca_operacion
set op_nombre = 'CERVANTES MARTINEZ MA.'
where op_operacion in (251442,39851,121617)

go
