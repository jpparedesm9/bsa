
/*
#66 ROSAS
ASESOR HUMBERTO VALE CERON (hvalle) -> 76
ASESOR PARA REASIGNACION: MARIA ELIZABETH GONZALEZ ORTEGA (megonzalezor) -> 254
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
        
select @w_codigo_grupo  = 66,
       @w_codigo_oficial= 76,
       @w_login_oficial = 'hvalle',
       @w_oficina       = 3354

create table #cliente_grupo
(cod_cliente int)

insert into #cliente_grupo (cod_cliente) values(1569)
insert into #cliente_grupo (cod_cliente) values(1947)
insert into #cliente_grupo (cod_cliente) values(1950)
insert into #cliente_grupo (cod_cliente) values(1951)
insert into #cliente_grupo (cod_cliente) values(1952)
insert into #cliente_grupo (cod_cliente) values(1953)
insert into #cliente_grupo (cod_cliente) values(2335)

--1--                  
update cobis..cl_grupo
set gr_oficial = @w_codigo_oficial
where gr_grupo = @w_codigo_grupo

--2--
update cobis..cl_cliente_grupo  
set cg_usuario = @w_login_oficial
where cg_grupo = @w_codigo_grupo
and   cg_estado= 'V'
        
--3.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (select cod_cliente from #cliente_grupo)
                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_cliente in (select cod_cliente from #cliente_grupo)
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
WHERE tr_cliente in (select cod_cliente from #cliente_grupo)

--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_cliente in (select cod_cliente from #cliente_grupo)

--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_cliente in (select cod_cliente from #cliente_grupo)

--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_cliente  in (select cod_cliente from #cliente_grupo)
go

/*
#58 EMPRENDEDORAS
ASESOR HUMBERTO VALE CERON (hvalle) -> 76
ASESOR PARA REASIGNACION: MARIA ELIZABETH GONZALEZ ORTEGA (megonzalezor) -> 254
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
        
select @w_codigo_grupo  = 58,
       @w_codigo_oficial= 76,
       @w_login_oficial = 'hvalle',
       @w_oficina       = 3354

truncate table #cliente_grupo

insert into #cliente_grupo (cod_cliente) values(1226)
insert into #cliente_grupo (cod_cliente) values(1228)
insert into #cliente_grupo (cod_cliente) values(1230)
insert into #cliente_grupo (cod_cliente) values(1232)
insert into #cliente_grupo (cod_cliente) values(1233)
insert into #cliente_grupo (cod_cliente) values(1843)
insert into #cliente_grupo (cod_cliente) values(1887)
insert into #cliente_grupo (cod_cliente) values(13010)
insert into #cliente_grupo (cod_cliente) values(13030)
insert into #cliente_grupo (cod_cliente) values(13679)

--1--                  
update cobis..cl_grupo
set gr_oficial = @w_codigo_oficial
where gr_grupo = @w_codigo_grupo

--2--
update cobis..cl_cliente_grupo  
set cg_usuario = @w_login_oficial
where cg_grupo = @w_codigo_grupo
and   cg_estado= 'V'
        
--3.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (select cod_cliente from #cliente_grupo)
                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_cliente in (select cod_cliente from #cliente_grupo)
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
WHERE tr_cliente in (select cod_cliente from #cliente_grupo)

--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_cliente in (select cod_cliente from #cliente_grupo)

--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_cliente in (select cod_cliente from #cliente_grupo)

--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_cliente  in (select cod_cliente from #cliente_grupo)
go

/*
#413 GRANDES GUERRERAS
ASESOR HUMBERTO VALE CERON (hvalle) -> 76
ASESOR PARA REASIGNACION: MARIA ELIZABETH GONZALEZ ORTEGA (megonzalezor) -> 254
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
        
select @w_codigo_grupo  = 413,
       @w_codigo_oficial= 76,
       @w_login_oficial = 'hvalle',
       @w_oficina       = 3354

truncate table #cliente_grupo

insert into #cliente_grupo (cod_cliente) values(7943)
insert into #cliente_grupo (cod_cliente) values(10440)
insert into #cliente_grupo (cod_cliente) values(10454)
insert into #cliente_grupo (cod_cliente) values(10461)
insert into #cliente_grupo (cod_cliente) values(10583)
insert into #cliente_grupo (cod_cliente) values(10624)
insert into #cliente_grupo (cod_cliente) values(11185)
insert into #cliente_grupo (cod_cliente) values(11864)

--1--                  
update cobis..cl_grupo
set gr_oficial = @w_codigo_oficial
where gr_grupo = @w_codigo_grupo

--2--
update cobis..cl_cliente_grupo  
set cg_usuario = @w_login_oficial
where cg_grupo = @w_codigo_grupo
and   cg_estado= 'V'
        
--3.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (select cod_cliente from #cliente_grupo)
                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_cliente in (select cod_cliente from #cliente_grupo)
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
WHERE tr_cliente in (select cod_cliente from #cliente_grupo)

--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_cliente in (select cod_cliente from #cliente_grupo)

--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_cliente in (select cod_cliente from #cliente_grupo)

--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_cliente  in (select cod_cliente from #cliente_grupo)
go

/*
#334 LIRAN ROCK
ASESOR HUMBERTO VALE CERON (hvalle) -> 76
ASESOR PARA REASIGNACION: MARIA ELIZABETH GONZALEZ ORTEGA (megonzalezor) -> 254
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
        
select @w_codigo_grupo  = 334,
       @w_codigo_oficial= 76,
       @w_login_oficial = 'hvalle',
       @w_oficina       = 3354

truncate table #cliente_grupo

insert into #cliente_grupo (cod_cliente) values(7129)
insert into #cliente_grupo (cod_cliente) values(7181)
insert into #cliente_grupo (cod_cliente) values(7535)
insert into #cliente_grupo (cod_cliente) values(7550)
insert into #cliente_grupo (cod_cliente) values(8005)
insert into #cliente_grupo (cod_cliente) values(8029)
insert into #cliente_grupo (cod_cliente) values(8054)
insert into #cliente_grupo (cod_cliente) values(8554)

--1--                  
update cobis..cl_grupo
set gr_oficial = @w_codigo_oficial
where gr_grupo = @w_codigo_grupo

--2--
update cobis..cl_cliente_grupo  
set cg_usuario = @w_login_oficial
where cg_grupo = @w_codigo_grupo
and   cg_estado= 'V'
        
--3.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (select cod_cliente from #cliente_grupo)
                  
--4--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_cliente in (select cod_cliente from #cliente_grupo)
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
WHERE tr_cliente in (select cod_cliente from #cliente_grupo)

--8--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_cliente in (select cod_cliente from #cliente_grupo)

--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_cliente in (select cod_cliente from #cliente_grupo)

--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_cliente  in (select cod_cliente from #cliente_grupo)
go