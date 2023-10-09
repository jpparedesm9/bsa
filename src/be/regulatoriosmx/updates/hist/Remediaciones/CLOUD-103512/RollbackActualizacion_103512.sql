
/*
ASESOR ACTUAL: Sonia Lovera Pascual slovera -> 100
ASESOR PARA REASIGNAR: Roció Hernández rhernandezg-> 144

#7131 PATRICIA NIETO JERONIMO 
#7133 LILIANA ROJAS SALAZAR

*/

use cobis 
go

--1--
UPDATE cobis..cl_ente 
SET en_oficial    = 100,
    c_funcionario ='slovera'	
WHERE en_ente in (7131, 7133)
go       