
/*
ASESOR ACTUAL: NOEMI GUERRERO ROJAS -> 136 -> nguerreror
ASESOR PARA REASIGNACION: FELIPE ALEJANDRO JACOBO TAPIA. -> 135 -> fjacobo
GRUPO: LAS COQUETAS # 329
*/

use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 329,
       @w_codigo_oficial= 136,
       @w_login_oficial = 'nguerreror'

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
FROM  cobis..cl_cliente_grupo      
WHERE en_ente  = cg_ente 
AND   cg_grupo = @w_codigo_grupo
                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
FROM cobis..cl_cliente_grupo
WHERE op_cliente = cg_ente 
AND   cg_grupo = @w_codigo_grupo

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
FROM  cobis..cl_cliente_grupo
WHERE tr_cliente = cg_ente 
AND   cg_grupo   = @w_codigo_grupo
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
from cobis..cl_cliente_grupo
where oph_cliente = cg_ente   
and   cg_grupo = @w_codigo_grupo
--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
from  cobis..cl_cliente_grupo
where op_cliente = cg_ente   
and   cg_grupo = @w_codigo_grupo
--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
from cobis..cl_cliente_grupo  
where oph_cliente  = cg_ente   
and   cg_grupo     = @w_codigo_grupo
go

/*
GRUPO:EMPRENDEDORAS TUIIO #582
ASESOR ACTUAL: JAQUELINE GALINDO REYES (JGALINDO)--> 172
ASESOR PARA REASIGNACION: JESUS GONZALEZ ALVAREZ (JGONZALEZAL)-> 210.
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 582,
       @w_codigo_oficial= 172,
       @w_login_oficial = 'jgalindo'

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
FROM  cobis..cl_cliente_grupo      
WHERE en_ente  = cg_ente 
AND   cg_grupo = @w_codigo_grupo
                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
FROM cobis..cl_cliente_grupo
WHERE op_cliente = cg_ente 
AND   cg_grupo = @w_codigo_grupo

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
FROM  cobis..cl_cliente_grupo
WHERE tr_cliente = cg_ente 
AND   cg_grupo   = @w_codigo_grupo
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
from cobis..cl_cliente_grupo
where oph_cliente = cg_ente   
and   cg_grupo = @w_codigo_grupo
--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
from  cobis..cl_cliente_grupo
where op_cliente = cg_ente   
and   cg_grupo = @w_codigo_grupo
--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
from cobis..cl_cliente_grupo  
where oph_cliente  = cg_ente   
and   cg_grupo     = @w_codigo_grupo


go
/*GRUPO: CHICS #427
ASESOR ACTUAL: ROCIO HERNANDEZ GALINDO (rhernandezg)-->144
ASESOR PARA REASIGNACION: JAQUELINE GALINDO REYES (jgalindo)-> 172
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 427,
       @w_codigo_oficial= 144,
       @w_login_oficial = 'rhernandezg'
       

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
FROM  cobis..cl_cliente_grupo      
WHERE en_ente  = cg_ente 
AND   cg_grupo = @w_codigo_grupo
                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
FROM cobis..cl_cliente_grupo
WHERE op_cliente = cg_ente 
AND   cg_grupo = @w_codigo_grupo

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
FROM  cobis..cl_cliente_grupo
WHERE tr_cliente = cg_ente 
AND   cg_grupo   = @w_codigo_grupo
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
from cobis..cl_cliente_grupo
where oph_cliente = cg_ente   
and   cg_grupo = @w_codigo_grupo
--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
from  cobis..cl_cliente_grupo
where op_cliente = cg_ente   
and   cg_grupo = @w_codigo_grupo
--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
from cobis..cl_cliente_grupo  
where oph_cliente  = cg_ente   
and   cg_grupo     = @w_codigo_grupo


/*
GRUPO: FOREVER # 648
ASESOR ACTUAL: MIRNA IVONNE ASCENSION VALDEZ (mivaldez) --> 106
ASESOR PARA REASIGNACION:JAQUELINE GALINDO REYES (JGALINDO) --> 172
*/

use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 648,
       @w_codigo_oficial= 106,
       @w_login_oficial = 'mivaldez'

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
FROM  cobis..cl_cliente_grupo      
WHERE en_ente  = cg_ente 
AND   cg_grupo = @w_codigo_grupo
                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
FROM cobis..cl_cliente_grupo
WHERE op_cliente = cg_ente 
AND   cg_grupo = @w_codigo_grupo

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
FROM  cobis..cl_cliente_grupo
WHERE tr_cliente = cg_ente 
AND   cg_grupo   = @w_codigo_grupo
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
from cobis..cl_cliente_grupo
where oph_cliente = cg_ente   
and   cg_grupo = @w_codigo_grupo
--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
from  cobis..cl_cliente_grupo
where op_cliente = cg_ente   
and   cg_grupo = @w_codigo_grupo
--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
from cobis..cl_cliente_grupo  
where oph_cliente  = cg_ente   
and   cg_grupo     = @w_codigo_grupo


/*
GRUPO: MERCADITO: #459
ASESOR ACTUAL: MIRNA IVONNE ASCENSION VALDEZ (mivaldez) --> 106.
ASESOR PARA REASIGNACION:JAQUELINE GALINDO REYES (JGALINDO)--> 172
*/


use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 459,
       @w_codigo_oficial= 106,
       @w_login_oficial = 'mivaldez'
              

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
FROM  cobis..cl_cliente_grupo      
WHERE en_ente  = cg_ente 
AND   cg_grupo = @w_codigo_grupo
                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
FROM cobis..cl_cliente_grupo
WHERE op_cliente = cg_ente 
AND   cg_grupo = @w_codigo_grupo

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
FROM  cobis..cl_cliente_grupo
WHERE tr_cliente = cg_ente 
AND   cg_grupo   = @w_codigo_grupo
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
from cobis..cl_cliente_grupo
where oph_cliente = cg_ente   
and   cg_grupo = @w_codigo_grupo
--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
from  cobis..cl_cliente_grupo
where op_cliente = cg_ente   
and   cg_grupo   = @w_codigo_grupo
--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
from cobis..cl_cliente_grupo  
where oph_cliente  = cg_ente   
and   cg_grupo     = @w_codigo_grupo


       
       