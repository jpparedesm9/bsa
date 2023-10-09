
/*
GRUPO:
PROSPERIDAD
ID: 9001.18.000623
No. De grupo: 93

PERTENECE: 
JESSICA CORONA MARTINEZ
USUARIO: JCORONA

REASIGNAR A:
ERIKA MONTES BAZ
USUARIO: EMONTESBA
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 93,
       @w_codigo_oficial= 43,
       @w_login_oficial = 'jcorona'


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
WHERE en_ente  in (58  , 59  , 64  , 84  , 111, 2782,
                   2789, 2892, 2898, 2997)
                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (58  , 59  , 64  , 84  , 111, 2782,
                     2789, 2892, 2898, 2997)
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
WHERE tr_cliente in (58  , 59  , 64  , 84  , 111, 2782,
                     2789, 2892, 2898, 2997)

--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (58  , 59  , 64  , 84  , 111, 2782,
                     2789, 2892, 2898, 2997)

--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente in (58  , 59  , 64  , 84  , 111, 2782,
                     2789, 2892, 2898, 2997)

--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
where oph_cliente  in (58  , 59  , 64  , 84  , 111, 2782,
                       2789, 2892, 2898, 2997)  
go

/*
GRUPO
HONESTIDAD
ID:9001.18.000155
NO. DE GRUPO:172

PERTENECEN:
ZAIRA TURINCIO PASCUAL
USUARIO: ZTURINCIO ->51

REASIGNACION:
ERIKA MONTES BAZ
USUARIO: EMONTESBA
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 172,
       @w_codigo_oficial= 51,
       @w_login_oficial = 'zturincio'

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
WHERE en_ente in (1468, 1469, 1471, 4024, 4032, 
                  4307, 4679, 4759)

                 
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (1468, 1469, 1471, 4024, 4032, 
                     4307, 4679, 4759)

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
WHERE tr_cliente in (1468, 1469, 1471, 4024, 4032, 
                     4307, 4679, 4759)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (1468, 1469, 1471, 4024, 4032, 
                      4307, 4679, 4759)
--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente in (1468, 1469, 1471, 4024, 4032, 
                     4307, 4679, 4759)
--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
where oph_cliente in (1468, 1469, 1471, 4024, 4032, 
                      4307, 4679, 4759)
go
/*
GRUPO:
LA CONCHITA
ID:9001.18.000124
NO. DE GRUPO: 125

PERTENECEN:
ZAIRA TURINCIO PASCUAL
USUARIO: ZTURINCIO->51

REASIGNACION:
ERIKA MONTES BAZ
USUARIO: EMONTESBA
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 125,
       @w_codigo_oficial= 51,
       @w_login_oficial = 'zturincio'
       

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
WHERE en_ente  in (2636, 2662, 3121, 3130,
                   3131, 3287, 3293, 4098)

                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (2636, 2662, 3121, 3130,
                     3131, 3287, 3293, 4098)

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
WHERE tr_cliente in (2636, 2662, 3121, 3130,
                     3131, 3287, 3293, 4098)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (2636, 2662, 3121, 3130,
                      3131, 3287, 3293, 4098)
--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente in (2636, 2662, 3121, 3130,
                     3131, 3287, 3293, 4098)
--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
where oph_cliente  in (2636, 2662, 3121, 3130,
                       3131, 3287, 3293, 4098)


/*
GRUPO: LAS SUPER PECAS
ID:9001.18.000114 
NO. GRUPO: 128

PERTENECE:
JESSICA CORONA MARTINEZ
USUARIO: jcorona -> 43

RE ASIGNACION
ASESOR:
DANTE ALEJANDRO VAZQUEZ SAAVEDRA
USUARIO: davazquezsa ->  50

*/

use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 128,
       @w_codigo_oficial= 43,
       @w_login_oficial = 'jcorona'

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
WHERE en_ente  in (3487, 3491, 3494, 3562, 
                   3573, 3674, 3675, 3934)

                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (3487, 3491, 3494, 3562, 
                     3573, 3674, 3675, 3934)


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
WHERE tr_cliente in (3487, 3491, 3494, 3562, 
                     3573, 3674, 3675, 3934)

--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (3487, 3491, 3494, 3562, 
                      3573, 3674, 3675, 3934)

--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente in (3487, 3491, 3494, 3562, 
                     3573, 3674, 3675, 3934)

--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
where oph_cliente  in (3487, 3491, 3494, 3562, 
                       3573, 3674, 3675, 3934)



    
       