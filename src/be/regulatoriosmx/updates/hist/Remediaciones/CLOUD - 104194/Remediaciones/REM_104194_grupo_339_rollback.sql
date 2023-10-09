--BUEN DIA FAVOR DE APOYARNOS CON LA SIGUIENTE REASIGNACION DEL GRUPO ESCANDALO ID 339
--
--ASESOR ACTUAL: María de los Ángeles Obregón Elizalde con usuario mobregon
--ASESOR PARA REASIGNAR : Socorro Perez Telles con usuario sperezte
--
--8616 MONICA RUIZ RODRIGUEZ
--8623 LETICIA ARENAS ALMARAZ
--8626 NELLY GUERRA GUERERO
--8629 MARIA MAGDALENA RODRIGUEZ BAROCIO
--8721 NALLELY GUADALUPE SALINAS ANAYA
--8723 IRENE CAZARES FUENTES
--8724 JAZMIN ARANDA MORALES
--8726 YURIDIA LOVERA FIDEL
--8735 ERIKA BERTHA SANDOVAL CRUZ

use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
        
select @w_codigo_grupo  = 339,
       @w_codigo_oficial= 86, -- antes 86
       @w_login_oficial = 'mobregon'--, -- antes mobregon
       --@w_oficina       = 2381 -- antes

create table #cliente_grupo
(cod_cliente int)

insert into #cliente_grupo (cod_cliente) values(8616)
insert into #cliente_grupo (cod_cliente) values(8623)
insert into #cliente_grupo (cod_cliente) values(8626)
insert into #cliente_grupo (cod_cliente) values(8629)
insert into #cliente_grupo (cod_cliente) values(8721)
insert into #cliente_grupo (cod_cliente) values(8723)
insert into #cliente_grupo (cod_cliente) values(8724)
insert into #cliente_grupo (cod_cliente) values(8726)
insert into #cliente_grupo (cod_cliente) values(8735)

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
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial--,
      --oph_oficina = @w_oficina   
where oph_cliente  in (select cod_cliente from #cliente_grupo)
go
