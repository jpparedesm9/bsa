
/*
BUEN DIA FAVOR DE APOYARNOS CON LA SIGUIENTE REASIGNACION:

28529 MARIA MARTA GAMA VARGAS

ASESOR ACTUAL: fibarral FRANCISCO IBARRA LEINES -> 184
ASESOR PARA REASIGNAR: jjcerrillo JORGE JAVIER CERRILLO ALVAREZ -> 287



*/

use cobis 
go

--1--
update cobis..cl_ente 
set   en_oficial    = 287,
      c_funcionario ='jjcerrillo'	
where en_ente in (28529)
go       