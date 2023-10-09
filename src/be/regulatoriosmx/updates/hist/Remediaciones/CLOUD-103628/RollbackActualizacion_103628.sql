
/*
980--Chicas Súper poderosas 
ASESOR ACTUAL: Prudencio Hernández Hernández -> phernandezhe -> 107
ASESOR PARA REASIGNAR:José Manuel Hernández Santillán-> jmhernandezsa -> 114
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
        
select @w_codigo_grupo  = 980,
       @w_codigo_oficial= 107,
       @w_login_oficial = 'phernandezhe',
       @w_oficina       = 2379


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
WHERE en_ente  in (20883, 20957, 21043, 22165,
                   22658, 23557, 24805, 24808)
                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_cliente in (20883, 20957, 21043, 22165,
                     22658, 23557, 24805, 24808)
--6--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente  = @w_codigo_grupo

--7--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente in (20883, 20957, 21043, 22165,
                     22658, 23557, 24805, 24808)

--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_cliente in (20883, 20957, 21043, 22165,
                      22658, 23557, 24805, 24808)

--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_cliente in (20883, 20957, 21043, 22165,
                     22658, 23557, 24805, 24808)

--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_cliente  in (20883, 20957, 21043, 22165,
                       22658, 23557, 24805, 24808) 
go

/*
649--Arbolito
ASESOR ACTUAL: Prudencio Hernández Hernández -> phernandezhe -> 107                      
ASESOR PARA REASIGNAR: José Manuel Hernández Santillán -> jmhernandezsa -> 114
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
        
select @w_codigo_grupo  = 649,
       @w_codigo_oficial= 107,
       @w_login_oficial = 'phernandezhe',
       @w_oficina       = 2379

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
WHERE en_ente in (14379, 14391, 14406, 14470,
                  15014, 15917, 17030, 17483)

                 
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial,
    op_oficina = @w_oficina 
WHERE op_cliente in (14379, 14391, 14406, 14470,
                     15014, 15917, 17030, 17483)

--6--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente  = @w_codigo_grupo

--7--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente in (14379, 14391, 14406, 14470,
                     15014, 15917, 17030, 17483)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_cliente in (14379, 14391, 14406, 14470,
                      15014, 15917, 17030, 17483)
--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_cliente in (14379, 14391, 14406, 14470,
                     15014, 15917, 17030, 17483)
--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_cliente in (14379, 14391, 14406, 14470,
                      15014, 15917, 17030, 17483)


go
/*
662--San Felipe II 
ASESOR ACTUAL: Prudencio Hernández Hernández -> Phernandezhe -> 107                      
ASESOR PARA REASIGNAR: María Guadalupe Hernández Barrios -> mghernandezba -> 143
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
        
select @w_codigo_grupo  = 662,
       @w_codigo_oficial= 107,
       @w_login_oficial = 'phernandezhe',
       @w_oficina       = 2379
       

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
WHERE en_ente  in (8871 , 12763, 13160, 13422, 13432,
                   13449, 13616, 13728)

                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial,
    op_oficina = @w_oficina  
WHERE op_cliente in (8871 , 12763, 13160, 13422, 13432,
                     13449, 13616, 13728)

--6--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina 
WHERE tr_cliente  = @w_codigo_grupo

--7--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina 
WHERE tr_cliente in (8871 , 12763, 13160, 13422, 13432,
                     13449, 13616, 13728)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina 
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina 
where oph_cliente in (8871 , 12763, 13160, 13422, 13432,
                      13449, 13616, 13728)
--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina 
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina 
where op_cliente in (8871 , 12763, 13160, 13422, 13432,
                     13449, 13616, 13728)
--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina 
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina    
where oph_cliente  in (8871 , 12763, 13160, 13422, 13432,
                       13449, 13616, 13728)


/*
415--Atizapán Moderno  
ASESOR ACTUAL: Prudencio Hernández Hernández -> phernandezhe -> 107                      
ASESOR PARA REASIGNAR: María Guadalupe Hernández Barrios -> mghernandezba -> 143
*/

use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
        
select @w_codigo_grupo  = 415,
       @w_codigo_oficial= 107,
       @w_login_oficial = 'phernandezhe',
       @w_oficina       = 2379
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
WHERE en_ente  in (10967, 10969, 10971, 10979,
                   10982, 10998, 11010, 11171)

                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_cliente in (10967, 10969, 10971, 10979,
                     10982, 10998, 11010, 11171)

--6--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente  = @w_codigo_grupo

--7--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente in (10967, 10969, 10971, 10979,
                     10982, 10998, 11010, 11171)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_cliente in (10967, 10969, 10971, 10979,
                      10982, 10998, 11010, 11171)
--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_cliente in (10967, 10969, 10971, 10979,
                     10982, 10998, 11010, 11171)
--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_cliente  in (10967, 10969, 10971, 10979,
                       10982, 10998, 11010, 11171)


    
       
/*
355--Amaranta   
ASESOR ACTUAL: Prudencio Hernández Hernández -> phernandezhe -> 107                      
ASESOR PARA REASIGNAR: María Guadalupe Hernández Barrios -> mghernandezba -> 143
*/

use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
        
select @w_codigo_grupo  = 355,
       @w_codigo_oficial= 107,
       @w_login_oficial = 'phernandezhe',
       @w_oficina       = 2379

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
WHERE en_ente  in (6143, 8843, 8845, 8853,
                   8858, 9050, 9350, 9449)

                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina    
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial,
    op_oficina = @w_oficina    
WHERE op_cliente in (6143, 8843, 8845, 8853,
                     8858, 9050, 9350, 9449)

--6--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina   
WHERE tr_cliente  = @w_codigo_grupo

--7--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina   
WHERE tr_cliente in (6143, 8843, 8845, 8853,
                     8858, 9050, 9350, 9449)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina 
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina 
where oph_cliente in (6143, 8843, 8845, 8853,
                      8858, 9050, 9350, 9449)
--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina 
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina 
where op_cliente in (6143, 8843, 8845, 8853,
                     8858, 9050, 9350, 9449)
--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina 
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina    
where oph_cliente  in (6143, 8843, 8845, 8853,
                       8858, 9050, 9350, 9449)

/*
303--Grupo Real de San Mateo   
ASESOR ACTUAL: Prudencio Hernández Hernández -> Phernandezhe -> 107                      
ASESOR PARA REASIGNAR: Luis Bernardo Rafael Jiménez Pale ->ljimenezp -> 119
*/

use cobis 
go

declare @w_codigo_grupo    int        ,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int        ,
        @w_oficina         int
        
select @w_codigo_grupo  = 303,
       @w_codigo_oficial= 107,
       @w_login_oficial = 'phernandezhe',
       @w_oficina       = 2379
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
WHERE en_ente  in (7260, 7398, 7413, 7434,
                   7440, 7911, 8051, 8207)

                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial,
    op_oficina = @w_oficina  
WHERE op_cliente in (7260, 7398, 7413, 7434,
                     7440, 7911, 8051, 8207)

--6--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina 
WHERE tr_cliente  = @w_codigo_grupo

--7--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina 
WHERE tr_cliente in (7260, 7398, 7413, 7434,
                     7440, 7911, 8051, 8207)
--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina 
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina 
where oph_cliente in (7260, 7398, 7413, 7434,
                      7440, 7911, 8051, 8207)
--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina 
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina   = @w_oficina 
where op_cliente in (7260, 7398, 7413, 7434,
                     7440, 7911, 8051, 8207)
--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina 
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina    
where oph_cliente  in (7260, 7398, 7413, 7434,
                       7440, 7911, 8051, 8207)

go
    