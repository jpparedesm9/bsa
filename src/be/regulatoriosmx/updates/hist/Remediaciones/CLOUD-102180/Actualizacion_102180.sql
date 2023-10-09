
/*
707 MARIANITAS 
De: Antonio Bobadilla -> abobadilla ->  146
A:  Gerardo Emmanuel Montes de Oca Rojo -> germontes -> 223 
*/

use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 707,
       @w_codigo_oficial= 223,
       @w_login_oficial = 'germontes'


--1--                  
update cobis..cl_grupo
set gr_oficial = @w_codigo_oficial
where gr_grupo = @w_codigo_grupo

--2--
update cobis..cl_cliente_grupo  
set cg_usuario = @w_login_oficial
where cg_grupo = @w_codigo_grupo
        
--3.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (18170, 18180, 18200, 18203,
                   18263, 18787, 18793, 18802)
                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (18170, 18180, 18200, 18203,
                     18263, 18787, 18793, 18802)
--6--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente  = @w_codigo_grupo

--7--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente in (18170, 18180, 18200, 18203,
                     18263, 18787, 18793, 18802)

--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (18170, 18180, 18200, 18203,
                      18263, 18787, 18793, 18802)
go

/*
652 PANDITAS
De: Rafael García Sánchez -> rrgarciasa -> 152
A: Karla Rosas Gonzalez -> krosasgo -> 222
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 652,
       @w_codigo_oficial= 222,
       @w_login_oficial = 'krosasgo'

--1--                  
update cobis..cl_grupo
set gr_oficial = @w_codigo_oficial
where gr_grupo = @w_codigo_grupo

--2--
update cobis..cl_cliente_grupo  
set cg_usuario = @w_login_oficial
where cg_grupo = @w_codigo_grupo
        
--3.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente in (17485, 17501, 17510, 17520,
                  17523, 17758, 17761, 17778)

                 
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (17485, 17501, 17510, 17520,
                     17523, 17758, 17761, 17778)

--6--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente  = @w_codigo_grupo

--7--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente in (17485, 17501, 17510, 17520,
                     17523, 17758, 17761, 17778)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (17485, 17501, 17510, 17520,
                      17523, 17758, 17761, 17778)

go
/*
578 MARANATHA
De: Antonio Bobadilla -> abobadilla ->  146
A:  Jesus Adrian Flores Hernandez -> jafloreshe -> 205
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 578,
       @w_codigo_oficial= 205,
       @w_login_oficial = 'jafloreshe'
       

--1--                  
update cobis..cl_grupo
set gr_oficial = @w_codigo_oficial
where gr_grupo = @w_codigo_grupo

--2--
update cobis..cl_cliente_grupo  
set cg_usuario = @w_login_oficial
where cg_grupo = @w_codigo_grupo
        
--3.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (14586, 14590, 14596, 14722,
                   14954, 14964, 15090, 15470,
                   15792)

                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (14586, 14590, 14596, 14722,
                     14954, 14964, 15090, 15470,
                     15792)

--6--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente  = @w_codigo_grupo

--7--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente in (14586, 14590, 14596, 14722,
                     14954, 14964, 15090, 15470,
                     15792)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (14586, 14590, 14596, 14722,
                      14954, 14964, 15090, 15470,
                      15792)
--11--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
where oph_cliente  in (14586, 14590, 14596, 14722,
                       14954, 14964, 15090, 15470,
                       15792)


/*
516 KIARA
De: Jesus Juarez Peña -> jjuarezpe -> 164
A:   Karla Rosas Gonzalez -> krosasgo -> 222
*/

use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 516,
       @w_codigo_oficial= 222,
       @w_login_oficial = 'krosasgo'

--1--                  
update cobis..cl_grupo
set gr_oficial = @w_codigo_oficial
where gr_grupo = @w_codigo_grupo

--2--
update cobis..cl_cliente_grupo  
set cg_usuario = @w_login_oficial
where cg_grupo = @w_codigo_grupo
        
--3.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial   
WHERE en_ente  in (14134, 14139, 14150, 14164,
                   14173, 14182, 14310, 14334)

                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (14134, 14139, 14150, 14164,
                     14173, 14182, 14310, 14334)

--6--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente  = @w_codigo_grupo

--7--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente in (14134, 14139, 14150, 14164,
                     14173, 14182, 14310, 14334)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (14134, 14139, 14150, 14164,
                      14173, 14182, 14310, 14334)
--10--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--11--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
where oph_cliente  in (14134, 14139, 14150, 14164,
                       14173, 14182, 14310, 14334)


/*
493 EL PORTICO
De: Antonio Bobadilla Sosa -> abobadilla ->  146
A : Miguel Reyes Garay -> mreyesga -> 206
*/


use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 493,
       @w_codigo_oficial= 206,
       @w_login_oficial = 'mreyesga'
              

--1--                  
update cobis..cl_grupo
set gr_oficial = @w_codigo_oficial
where gr_grupo = @w_codigo_grupo

--2--
update cobis..cl_cliente_grupo  
set cg_usuario = @w_login_oficial
where cg_grupo = @w_codigo_grupo
        
--3.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (13281, 13291, 13310, 13320,
                   13326, 13350, 13478, 13485)

--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (13281, 13291, 13310, 13320,
                     13326, 13350, 13478, 13485)

--6--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente  = @w_codigo_grupo

--7--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente in (13281, 13291, 13310, 13320,
                     13326, 13350, 13478, 13485)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (13281, 13291, 13310, 13320,
                      13326, 13350, 13478, 13485)
--11--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
where oph_cliente  in (13281, 13291, 13310, 13320,
                       13326, 13350, 13478, 13485)

/*
438: LA ISLA
De : Antonio Bobadilla Sosa -> abobadilla ->  146
A: Gerardo Emmanuel Montes de Oca Rojo -> germontes -> 223 
*/


use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 438,
       @w_codigo_oficial= 223,
       @w_login_oficial = 'germontes'
              

--1--                  
update cobis..cl_grupo
set gr_oficial = @w_codigo_oficial
where gr_grupo = @w_codigo_grupo

--2--
update cobis..cl_cliente_grupo  
set cg_usuario = @w_login_oficial
where cg_grupo = @w_codigo_grupo
        
--3.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (11241, 11244, 11248, 11251,
                   11261, 11433, 11664, 12137)

--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (11241, 11244, 11248, 11251,
                     11261, 11433, 11664, 12137)

--6--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente  = @w_codigo_grupo

--7--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente in (11241, 11244, 11248, 11251,
                     11261, 11433, 11664, 12137)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (11241, 11244, 11248, 11251,
                      11261, 11433, 11664, 12137)

--10--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--11--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
where oph_cliente  in (11241, 11244, 11248, 11251,
                       11261, 11433, 11664, 12137)


/*
433: SAMANTHA
De: David Varela Valdes -> dvarela -> 98
A: Rafael Garcia Sanchez -> rrgarciasa -> 152
*/


use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 433,
       @w_codigo_oficial= 152,
       @w_login_oficial = 'rrgarciasa'
              

--1--                  
update cobis..cl_grupo
set gr_oficial = @w_codigo_oficial
where gr_grupo = @w_codigo_grupo

--2--
update cobis..cl_cliente_grupo  
set cg_usuario = @w_login_oficial
where cg_grupo = @w_codigo_grupo
        
--3.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (10101, 10110, 10113, 10115, 
                   10118, 10903, 10910, 11459)

--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (10101, 10110, 10113, 10115, 
                     10118, 10903, 10910, 11459)

--6--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente  = @w_codigo_grupo

--7--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente in (10101, 10110, 10113, 10115, 
                     10118, 10903, 10910, 11459)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (10101, 10110, 10113, 10115, 
                      10118, 10903, 10910, 11459)

--10--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--11--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
where oph_cliente  in (10101, 10110, 10113, 10115, 
                       10118, 10903, 10910, 11459)

go       

/*
408: OCOTENCO 2018
De: Antonio Bobadilla Sosa  -> abobadilla ->  146
A: Miguiel Reyes Garay -> mreyesga -> 206
*/

use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 408,
       @w_codigo_oficial= 206,
       @w_login_oficial = 'mreyesga'
              

--1--                  
update cobis..cl_grupo
set gr_oficial = @w_codigo_oficial
where gr_grupo = @w_codigo_grupo

--2--
update cobis..cl_cliente_grupo  
set cg_usuario = @w_login_oficial
where cg_grupo = @w_codigo_grupo
        
--3.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (10181, 10190, 10543, 10545,
                   10546, 10698, 10699, 10700)

--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (10181, 10190, 10543, 10545,
                     10546, 10698, 10699, 10700)

--6--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente  = @w_codigo_grupo

--7--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente in (10181, 10190, 10543, 10545,
                     10546, 10698, 10699, 10700)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (10181, 10190, 10543, 10545,
                      10546, 10698, 10699, 10700)

--10--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--11--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
where oph_cliente  in (10181, 10190, 10543, 10545,
                       10546, 10698, 10699, 10700)

/*
314: Los Colibris
De: David Varela Valdes -> dvarela -> 98
A: Miguel Reyes Garay -> mreyesga -> 206

*/

use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 314,
       @w_codigo_oficial= 206,
       @w_login_oficial = 'mreyesga'
              

--1--                  
update cobis..cl_grupo
set gr_oficial = @w_codigo_oficial
where gr_grupo = @w_codigo_grupo

--2--
update cobis..cl_cliente_grupo  
set cg_usuario = @w_login_oficial
where cg_grupo = @w_codigo_grupo
        
--3.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (7888, 7889, 7891, 7892,
                   7893, 7896, 8049, 8390)

--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (7888, 7889, 7891, 7892,
                     7893, 7896, 8049, 8390)

--6--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente  = @w_codigo_grupo

--7--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial
WHERE tr_cliente in (7888, 7889, 7891, 7892,
                     7893, 7896, 8049, 8390)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (7888, 7889, 7891, 7892,
                      7893, 7896, 8049, 8390)

--10--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--11--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
where oph_cliente  in (7888, 7889, 7891, 7892,
                       7893, 7896, 8049, 8390)

go


       