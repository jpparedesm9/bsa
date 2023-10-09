
/*
#261 ZAFIRO TUIIO
ASESOR ACTUAL: Hugo Enrique Rojas Nolasco (herojas) -> 67
ASESOR PARA REASIGNACION: BENITO DE LA CRUZ POZOS (bdelacruz) -> 117
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
        
select @w_codigo_grupo  = 261,
       @w_codigo_oficial= 117,
       @w_login_oficial = 'bdelacruz',
       @w_oficina       = 3354

create table #cliente_grupo
(cod_cliente int)

insert into #cliente_grupo (cod_cliente) values(6869)
insert into #cliente_grupo (cod_cliente) values(6883)
insert into #cliente_grupo (cod_cliente) values(6893)
insert into #cliente_grupo (cod_cliente) values(6894)
insert into #cliente_grupo (cod_cliente) values(6899)
insert into #cliente_grupo (cod_cliente) values(7013)
insert into #cliente_grupo (cod_cliente) values(7227)
insert into #cliente_grupo (cod_cliente) values(26931)
insert into #cliente_grupo (cod_cliente) values(26940)

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
#257 LAS CHAPEADITAS
ASESOR ACTUAL: Hugo Enrique Rojas Nolasco (herojas) -> 67
ASESOR PARA REASIGNACION: BENITO DE LA CRUZ POZOS (bdelacruz) -> 117
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
        
select @w_codigo_grupo  = 257,
       @w_codigo_oficial= 117,
       @w_login_oficial = 'bdelacruz',
       @w_oficina       = 3354

create table #cliente_grupo
(cod_cliente int)

insert into #cliente_grupo (cod_cliente) values(6781)
insert into #cliente_grupo (cod_cliente) values(6783)
insert into #cliente_grupo (cod_cliente) values(6785)
insert into #cliente_grupo (cod_cliente) values(6789)
insert into #cliente_grupo (cod_cliente) values(6791)
insert into #cliente_grupo (cod_cliente) values(6796)
insert into #cliente_grupo (cod_cliente) values(6804)
insert into #cliente_grupo (cod_cliente) values(6845)

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
