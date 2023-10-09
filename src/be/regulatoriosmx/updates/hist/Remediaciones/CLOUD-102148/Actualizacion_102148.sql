
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
       @w_codigo_oficial= 135,
       @w_login_oficial = 'fjacobo'


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
WHERE en_ente  in (8323, 8373, 8374, 8410, 8414, 8417,8482,
                   8527,9017)
                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (8323, 8373, 8374, 8410, 8414, 8417,8482,
                     8527,9017)
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
WHERE tr_cliente in (8323, 8373, 8374, 8410, 8414, 8417,8482,
                     8527,9017)

--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (8323, 8373, 8374, 8410, 8414, 8417,8482,
                      8527,9017)

--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente in (8323, 8373, 8374, 8410, 8414, 8417,8482,
                      8527,9017)

--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
where oph_cliente  in (8323, 8373, 8374, 8410, 8414, 8417,8482,
                       8527,9017)  
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
       @w_codigo_oficial= 210,
       @w_login_oficial = 'jgonzalezal'

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
WHERE en_ente in (14788, 14929, 14952, 15526,
                  15596, 15602, 15702, 15768)

                 
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (14788, 14929, 14952, 15526,
                     15596, 15602, 15702, 15768)

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
WHERE tr_cliente in (14788, 14929, 14952, 15526,
                     15596, 15602, 15702, 15768)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (14788, 14929, 14952, 15526,
                      15596, 15602, 15702, 15768)
--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente in (14788, 14929, 14952, 15526,
                     15596, 15602, 15702, 15768)
--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
where oph_cliente in (14788, 14929, 14952, 15526,
                      15596, 15602, 15702, 15768)


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
WHERE en_ente  in (11184, 11190, 11198, 11206,
                   11346, 11356, 11443, 11449)

                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (11184, 11190, 11198, 11206,
                     11346, 11356, 11443, 11449)

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
WHERE tr_cliente in (11184, 11190, 11198, 11206,
                     11346, 11356, 11443, 11449)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (11184, 11190, 11198, 11206,
                     11346, 11356, 11443, 11449)
--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente in (11184, 11190, 11198, 11206,
                     11346, 11356, 11443, 11449)
--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
where oph_cliente  in (11184, 11190, 11198, 11206,
                       11346, 11356, 11443, 11449)


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
WHERE en_ente  in (11800, 11815, 11816, 14863,
                   15475, 15484, 15813, 16488)

                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (11800, 11815, 11816, 14863,
                     15475, 15484, 15813, 16488)

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
WHERE tr_cliente in (11800, 11815, 11816, 14863,
                     15475, 15484, 15813, 16488)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (11800, 11815, 11816, 14863,
                      15475, 15484, 15813, 16488)
--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente in (11800, 11815, 11816, 14863,
                     15475, 15484, 15813, 16488)
--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
where oph_cliente  in (11800, 11815, 11816, 14863,
                       15475, 15484, 15813, 16488)


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
WHERE en_ente  in (10981, 10986, 11021, 11029, 
                   11095, 11774, 11810, 11964)
                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (10981, 10986, 11021, 11029, 
                     11095, 11774, 11810, 11964)

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
WHERE tr_cliente in (10981, 10986, 11021, 11029, 
                     11095, 11774, 11810, 11964)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (10981, 10986, 11021, 11029, 
                      11095, 11774, 11810, 11964)
--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente in (10981, 10986, 11021, 11029, 
                     11095, 11774, 11810, 11964)
--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
where oph_cliente  in (10981, 10986, 11021, 11029, 
                       11095, 11774, 11810, 11964)



       
       