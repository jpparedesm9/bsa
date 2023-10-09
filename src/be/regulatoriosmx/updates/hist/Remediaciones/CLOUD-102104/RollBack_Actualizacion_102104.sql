
/*
Asesor actual: Dante Alejandro Vazquez Saavedra.-> 50
Reasignacion asesora correcta: Monserrat Adaluz Morales Ortega -> 39 -> mamorales
Cliente: #13104 REYNA GARCIA VARGAS.
*/

use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_oficial= 50,
       @w_login_oficial = 'davazquezsa'
       
--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente     = 13104

go

/*
Asesor actual: Sonia Lovera Pascual.-> slovera -> 100
Reasignacion asesora correcta: Jaqueline Galindo Reyes, jgalindo.->172
Cliente: #8329  Ana Karen Orozco Mayorga
*/
use cobis 
go

declare @w_codigo_oficial  int,
        @w_login_oficial   varchar(14)
        
select @w_codigo_oficial= 100,
       @w_login_oficial = 'slovera'

--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente     = 8329

go
/*
Asesor actual: Sonia Lovera Pascual-> 100.
Reasignacion asesora correcta: Jaqueline Galindo Reyes, jgalindo. -> 172
Cliente: #8308 Rosa González José.
*/
use cobis 
go

declare @w_codigo_oficial    int,
        @w_login_oficial     varchar(14)
        
select @w_codigo_oficial= 100,
       @w_login_oficial = 'slovera'
       
       
--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente     = 8308

go     