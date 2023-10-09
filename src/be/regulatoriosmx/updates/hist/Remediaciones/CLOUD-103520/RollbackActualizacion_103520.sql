
/*
Se solicita la reasignación del Grupo 998 IMPOSIBLES

ASESOR ACTUAL: ARTURO ARCOS FLORES (aarcosfl) -> 157
ASESOR PARA REASIGNAR: JUAN CARLOS ROSALES ROLDAN ( jcrosalesro ) ->264

*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int
        
select @w_codigo_grupo  = 998,
       @w_codigo_oficial= 157 ,
       @w_login_oficial = 'aarcosfl'


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
WHERE en_ente  in (24859, 25059, 25294, 25379,
                   25604, 26023, 26066, 26189)
                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial = @w_codigo_oficial 
WHERE op_cliente in (24859, 25059, 25294, 25379,
                     25604, 26023, 26066, 26189)
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
WHERE tr_cliente in (24859, 25059, 25294, 25379,
                     25604, 26023, 26066, 26189)

--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente in (24859, 25059, 25294, 25379,
                      25604, 26023, 26066, 26189)

--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial
where op_cliente in (24859, 25059, 25294, 25379,
                     25604, 26023, 26066, 26189)

--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial   
where oph_cliente  in (24859, 25059, 25294, 25379,
                       25604, 26023, 26066, 26189)  
go
