--BUEN DIA FAVOR DE APOYARNOS CON LA SIGUIENTE REASIGNACION DE GRUPO:
--
--ASESOR ACTUAL: Fidel Antonio Hernandez Coria
--ASESOR PARA REASIGNAR: Uriel Calixto Velasco Ruiz
--
--GRUPO: VENADITOS
--ID: 268

use cobis
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
        
select @w_codigo_grupo  = 268,
       @w_codigo_oficial= 122, -- antes 179
       @w_login_oficial = 'ucvelasco'--, -- antes facoria
       --@w_oficina       = 2381 -- antes

create table #cliente_grupo
(cod_cliente int)

insert into #cliente_grupo (cod_cliente) values(6660)
insert into #cliente_grupo (cod_cliente) values(6663)
insert into #cliente_grupo (cod_cliente) values(6666)
insert into #cliente_grupo (cod_cliente) values(6704)
insert into #cliente_grupo (cod_cliente) values(6886)
insert into #cliente_grupo (cod_cliente) values(6945)
insert into #cliente_grupo (cod_cliente) values(7010)
insert into #cliente_grupo (cod_cliente) values(7016)
insert into #cliente_grupo (cod_cliente) values(7031)
insert into #cliente_grupo (cod_cliente) values(7247)
insert into #cliente_grupo (cod_cliente) values(27018)
insert into #cliente_grupo (cod_cliente) values(27032)

--1--                  
update cobis..cl_grupo
set gr_oficial = @w_codigo_oficial
where gr_grupo = @w_codigo_grupo

--2--
update cobis..cl_cliente_grupo  
set cg_usuario = @w_login_oficial,
    cg_oficial = @w_codigo_oficial-- oc_oficial
where cg_grupo = @w_codigo_grupo
and   cg_estado= 'V'
        
--3.--
UPDATE cobis..cl_ente
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (select cod_cliente from #cliente_grupo)
                  
--4--
UPDATE cob_cartera..ca_operacion
SET op_oficial   = @w_codigo_oficial--,
    --op_oficina   = @w_oficina 
WHERE op_cliente = @w_codigo_grupo
                                       
--5--
UPDATE cob_cartera..ca_operacion
SET op_oficial   = @w_codigo_oficial--,
    --op_oficina   = @w_oficina 
WHERE op_cliente in (select cod_cliente from #cliente_grupo)
--6--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial--,
    --tr_oficina    = @w_oficina
WHERE tr_cliente  = @w_codigo_grupo

--7--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial--,
    --tr_oficina    = @w_oficina
WHERE tr_cliente in (select cod_cliente from #cliente_grupo)

--8--
update cob_cartera..ca_operacion_his
set oph_oficial   = @w_codigo_oficial
where oph_cliente = @w_codigo_grupo

--9--
update cob_cartera..ca_operacion_his
set oph_oficial   = @w_codigo_oficial--,
    --oph_oficina   = @w_oficina
where oph_cliente in (select cod_cliente from #cliente_grupo)

--10--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial--,
      --op_oficina = @w_oficina
where op_cliente = @w_codigo_grupo                      
                      
--11--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial--,
      --op_oficina = @w_oficina
where op_cliente in (select cod_cliente from #cliente_grupo)

--12--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial--,
      --2oph_oficina = @w_oficina
where oph_cliente = @w_codigo_grupo

--13--
update cob_cartera_his..ca_operacion_hi
set   oph_oficial = @w_codigo_oficial--,
      --oph_oficina = @w_oficina   
where oph_cliente  in (select cod_cliente from #cliente_grupo)

print 'Finalizo'
go
