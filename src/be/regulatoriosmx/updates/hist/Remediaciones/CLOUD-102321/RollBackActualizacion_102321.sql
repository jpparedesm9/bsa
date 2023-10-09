
/*
KARINA FLORES MARTINEZ (PROSPECTO).
ID: 4645

PERTENECE:
MIGUEL ANGEL REYES GONZALEZ
USUARIO: mareyesgo -> 73

ASIGNACION:
DANTE ALEJANDRO VAZQUEZ SAAVEDRA
USUARIO: davazquezsa -> 50

*/

use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_oficial= 73,
       @w_login_oficial = 'mareyesgo'
       
--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente     = 4645

go
