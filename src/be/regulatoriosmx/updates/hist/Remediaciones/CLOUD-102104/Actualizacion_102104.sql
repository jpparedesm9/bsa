
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
        
select @w_codigo_oficial= 39,
       @w_login_oficial = 'mamorales'
       
--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente     = 13104

go

/*
Asesor actual: Sonia Lovera Pascual.-> hvalle -> 76
Reasignacion asesora correcta: Jaqueline Galindo Reyes, jgalindo.->172
Cliente: #8329  Ana Karen Orozco Mayorga
*/
use cobis 
go

declare @w_codigo_oficial  int,
        @w_login_oficial   varchar(14)
        
select @w_codigo_oficial= 172,
       @w_login_oficial = 'jgalindo'

--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente     = 8329

go
/*
Asesor actual: Sonia Lovera Pascual.
Reasignacion asesora correcta: Jaqueline Galindo Reyes, jgalindo. -> 172
Cliente: #8308 Rosa Gonz�lez Jos�.
*/
use cobis 
go

declare @w_codigo_oficial    int,
        @w_login_oficial     varchar(14)
        
select @w_codigo_oficial= 172,
       @w_login_oficial = 'jgalindo'
       
       
--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente     = 8308

go     