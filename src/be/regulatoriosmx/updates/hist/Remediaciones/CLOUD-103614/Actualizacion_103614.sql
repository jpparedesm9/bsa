
/*
Se solicita la reasignacion de la integrante SANDRA YESICA VAZQUEZ MONTES #26328.

Asesor actual: Jeraldine Trujillo Avelar
Usuario: jtrujilloav -> 244

Reasignar al asesor: Aida Lissette Torres Reyna C046624
Usuario: altorres -> 178

*/

use cobis 
go

--1--
update cobis..cl_ente 
set   en_oficial    = 178,
      c_funcionario ='altorres'	
where en_ente = 26328
go       