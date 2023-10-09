
/*
Grupo: 1504
220	REYES BENITEZ NOHEMI
Oficial Operacion = 387
Oficial Grupo     = 31-> jmijangos
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
                
select @w_codigo_oficial= 31,
       @w_login_oficial = 'jmijangos',
       @w_oficina       = 3351

create table #cliente_grupo (cod_cliente int)
create table #operacion_cliente 
             (cliente   int,
              operacion int,
              tramite   int)

insert into #cliente_grupo (cod_cliente) values (220)

insert into #operacion_cliente(cliente, operacion, tramite)
select op_cliente, op_operacion, op_tramite
from   cob_cartera..ca_operacion
where  op_cliente in (select cod_cliente from #cliente_grupo)
and    op_estado in  (select es_codigo from cob_cartera..ca_estado where es_procesa = 'S')

--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (select cod_cliente from #cliente_grupo)
                                                         
--2--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_operacion in ( select operacion from #operacion_cliente)

--3--
update cob_cartera..ca_transaccion 
set tr_ofi_oper = @w_oficina
where tr_operacion in ( select operacion from #operacion_cliente)

--4--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente in ( select tramite from #operacion_cliente)

--5--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_operacion in ( select operacion from #operacion_cliente)

--6--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_operacion in ( select operacion from #operacion_cliente)

--7--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_operacion in ( select operacion from #operacion_cliente)

go


/*
Grupo: 70
493	PEREZ SANCHEZ MARIA
Oficial Operacion = 308	
Oficial Grupo     = 49-> kejimenez
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
                
select @w_codigo_oficial= 49,
       @w_login_oficial = 'kejimenez',
       @w_oficina       = 3345

truncate table #cliente_grupo
truncate table #operacion_cliente 
             
insert into #cliente_grupo (cod_cliente) values (493)

insert into #operacion_cliente(cliente, operacion, tramite)
select op_cliente, op_operacion, op_tramite
from   cob_cartera..ca_operacion
where  op_cliente in (select cod_cliente from #cliente_grupo)
and    op_estado in  (select es_codigo from cob_cartera..ca_estado where es_procesa = 'S')

--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (select cod_cliente from #cliente_grupo)
                                                         
--2--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_operacion in ( select operacion from #operacion_cliente)

--3--
update cob_cartera..ca_transaccion 
set tr_ofi_oper = @w_oficina
where tr_operacion in ( select operacion from #operacion_cliente)

--4--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente in ( select tramite from #operacion_cliente)

--5--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_operacion in ( select operacion from #operacion_cliente)

--6--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_operacion in ( select operacion from #operacion_cliente)

--7--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_operacion in ( select operacion from #operacion_cliente)

go

/*
Grupo: 434
681	MARTINEZ TAPIA VIANEY
Oficial Operacion = 364	
Oficial Grupo     = 316-> jrespinosa
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
                
select @w_codigo_oficial= 316,
       @w_login_oficial = 'jrespinosa',
       @w_oficina       = 3345

truncate table #cliente_grupo
truncate table #operacion_cliente 

insert into #cliente_grupo (cod_cliente) values (681)

insert into #operacion_cliente(cliente, operacion, tramite)
select op_cliente, op_operacion, op_tramite
from   cob_cartera..ca_operacion
where  op_cliente in (select cod_cliente from #cliente_grupo)
and    op_estado in  (select es_codigo from cob_cartera..ca_estado where es_procesa = 'S')

--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (select cod_cliente from #cliente_grupo)
                                                         
--2--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_operacion in ( select operacion from #operacion_cliente)

--3--
update cob_cartera..ca_transaccion 
set tr_ofi_oper = @w_oficina
where tr_operacion in ( select operacion from #operacion_cliente)

--4--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente in ( select tramite from #operacion_cliente)

--5--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_operacion in ( select operacion from #operacion_cliente)

--6--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_operacion in ( select operacion from #operacion_cliente)

--7--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_operacion in ( select operacion from #operacion_cliente)

go


/*
Grupo: 1486
731	MUÑOZ RODRIGUEZ YAMILEPSI
Oficial Operacion = 214	
Oficial Grupo     = 40-> jgsoto
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
                
select @w_codigo_oficial= 40,
       @w_login_oficial = 'jgsoto',
       @w_oficina       = 3345

truncate table #cliente_grupo
truncate table #operacion_cliente 

insert into #cliente_grupo (cod_cliente) values (731)

insert into #operacion_cliente(cliente, operacion, tramite)
select op_cliente, op_operacion, op_tramite
from   cob_cartera..ca_operacion
where  op_cliente in (select cod_cliente from #cliente_grupo)
and    op_estado in  (select es_codigo from cob_cartera..ca_estado where es_procesa = 'S')

--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (select cod_cliente from #cliente_grupo)
                                                         
--2--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_operacion in ( select operacion from #operacion_cliente)

--3--
update cob_cartera..ca_transaccion 
set tr_ofi_oper = @w_oficina
where tr_operacion in ( select operacion from #operacion_cliente)

--4--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente in ( select tramite from #operacion_cliente)

--5--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_operacion in ( select operacion from #operacion_cliente)

--6--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_operacion in ( select operacion from #operacion_cliente)

--7--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_operacion in ( select operacion from #operacion_cliente)

go



/*
Grupo: 1834
736	TREJO CALDERON MARIA DE
Oficial Operacion = 322	
Oficial Grupo     = 38-> magijon
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
                
select @w_codigo_oficial= 38,
       @w_login_oficial = 'magijon',
       @w_oficina       = 3348

truncate table #cliente_grupo
truncate table #operacion_cliente 

insert into #cliente_grupo (cod_cliente) values (736)

insert into #operacion_cliente(cliente, operacion, tramite)
select op_cliente, op_operacion, op_tramite
from   cob_cartera..ca_operacion
where  op_cliente in (select cod_cliente from #cliente_grupo)
and    op_estado in  (select es_codigo from cob_cartera..ca_estado where es_procesa = 'S')

--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (select cod_cliente from #cliente_grupo)
                                                         
--2--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_operacion in ( select operacion from #operacion_cliente)

--3--
update cob_cartera..ca_transaccion 
set tr_ofi_oper = @w_oficina
where tr_operacion in ( select operacion from #operacion_cliente)

--4--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente in ( select tramite from #operacion_cliente)

--5--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_operacion in ( select operacion from #operacion_cliente)

--6--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_operacion in ( select operacion from #operacion_cliente)

--7--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_operacion in ( select operacion from #operacion_cliente)

go


/*
Grupo: 27
768	GONZALEZ MEDINA ISABEL
Oficial Operacion = 213	
Oficial Grupo     = 38-> magijon
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
                
select @w_codigo_oficial= 38,
       @w_login_oficial = 'magijon',
       @w_oficina       = 3348

truncate table #cliente_grupo
truncate table #operacion_cliente 

insert into #cliente_grupo (cod_cliente) values (768)

insert into #operacion_cliente(cliente, operacion, tramite)
select op_cliente, op_operacion, op_tramite
from   cob_cartera..ca_operacion
where  op_cliente in (select cod_cliente from #cliente_grupo)
and    op_estado in  (select es_codigo from cob_cartera..ca_estado where es_procesa = 'S')

--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (select cod_cliente from #cliente_grupo)
                                                         
--2--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_operacion in ( select operacion from #operacion_cliente)

--3--
update cob_cartera..ca_transaccion 
set tr_ofi_oper = @w_oficina
where tr_operacion in ( select operacion from #operacion_cliente)

--4--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente in ( select tramite from #operacion_cliente)

--5--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_operacion in ( select operacion from #operacion_cliente)

--6--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_operacion in ( select operacion from #operacion_cliente)

--7--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_operacion in ( select operacion from #operacion_cliente)

go

/*
Grupo: 22
858	VASQUEZ AMBROSIO DIANA
953	MUNOZ CARPIO DIANA
973	FLORES TOLEDO MARIA

Oficial Operacion = 364	
Oficial Grupo     = 50-> davazquezsa
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
                
select @w_codigo_oficial= 50,
       @w_login_oficial = 'davazquezsa',
       @w_oficina       = 3348

truncate table #cliente_grupo
truncate table #operacion_cliente 

insert into #cliente_grupo (cod_cliente) values (858)
insert into #cliente_grupo (cod_cliente) values (953)
insert into #cliente_grupo (cod_cliente) values (973)

insert into #operacion_cliente(cliente, operacion, tramite)
select op_cliente, op_operacion, op_tramite
from   cob_cartera..ca_operacion
where  op_cliente in (select cod_cliente from #cliente_grupo)
and    op_estado in  (select es_codigo from cob_cartera..ca_estado where es_procesa = 'S')

--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (select cod_cliente from #cliente_grupo)
                                                         
--2--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_operacion in ( select operacion from #operacion_cliente)

--3--
update cob_cartera..ca_transaccion 
set tr_ofi_oper = @w_oficina
where tr_operacion in ( select operacion from #operacion_cliente)

--4--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente in ( select tramite from #operacion_cliente)

--5--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_operacion in ( select operacion from #operacion_cliente)

--6--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_operacion in ( select operacion from #operacion_cliente)

--7--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_operacion in ( select operacion from #operacion_cliente)

go

/*
Grupo: 45
871	CARRERA ALVARADO FRANCISCA
Oficial Operacion = 146	
Oficial Grupo     = 58-> asandovalba
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
                
select @w_codigo_oficial= 58,
       @w_login_oficial = 'asandovalba',
       @w_oficina       = 3345

truncate table #cliente_grupo
truncate table #operacion_cliente 

insert into #cliente_grupo (cod_cliente) values (871)

insert into #operacion_cliente(cliente, operacion, tramite)
select op_cliente, op_operacion, op_tramite
from   cob_cartera..ca_operacion
where  op_cliente in (select cod_cliente from #cliente_grupo)
and    op_estado in  (select es_codigo from cob_cartera..ca_estado where es_procesa = 'S')

--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (select cod_cliente from #cliente_grupo)
                                                         
--2--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_operacion in ( select operacion from #operacion_cliente)

--3--
update cob_cartera..ca_transaccion 
set tr_ofi_oper = @w_oficina
where tr_operacion in ( select operacion from #operacion_cliente)

--4--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente in ( select tramite from #operacion_cliente)

--5--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_operacion in ( select operacion from #operacion_cliente)

--6--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_operacion in ( select operacion from #operacion_cliente)

--7--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_operacion in ( select operacion from #operacion_cliente)

go

/*
Grupo: 89
936	SANTOS RANGEL ELIZABETH
Oficial Operacion = 121	
Oficial Grupo     = 317-> rvargasch
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
                
select @w_codigo_oficial= 317,
       @w_login_oficial = 'rvargasch',
       @w_oficina       = 3345

truncate table #cliente_grupo
truncate table #operacion_cliente 

insert into #cliente_grupo (cod_cliente) values (936)

insert into #operacion_cliente(cliente, operacion, tramite)
select op_cliente, op_operacion, op_tramite
from   cob_cartera..ca_operacion
where  op_cliente in (select cod_cliente from #cliente_grupo)
and    op_estado in  (select es_codigo from cob_cartera..ca_estado where es_procesa = 'S')

--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (select cod_cliente from #cliente_grupo)
                                                         
--2--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_operacion in ( select operacion from #operacion_cliente)

--3--
update cob_cartera..ca_transaccion 
set tr_ofi_oper = @w_oficina
where tr_operacion in ( select operacion from #operacion_cliente)

--4--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente in ( select tramite from #operacion_cliente)

--5--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_operacion in ( select operacion from #operacion_cliente)

--6--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_operacion in ( select operacion from #operacion_cliente)

--7--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_operacion in ( select operacion from #operacion_cliente)

go

/*
Grupo: 320
968	ALAMILLA ROSAS IRMA
Oficial Operacion = 364	
Oficial Grupo     = 49-> kejimenez
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
                
select @w_codigo_oficial= 49,
       @w_login_oficial = 'kejimenez',
       @w_oficina       = 3345

truncate table #cliente_grupo
truncate table #operacion_cliente 

insert into #cliente_grupo (cod_cliente) values (968)

insert into #operacion_cliente(cliente, operacion, tramite)
select op_cliente, op_operacion, op_tramite
from   cob_cartera..ca_operacion
where  op_cliente in (select cod_cliente from #cliente_grupo)
and    op_estado in  (select es_codigo from cob_cartera..ca_estado where es_procesa = 'S')

--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (select cod_cliente from #cliente_grupo)
                                                         
--2--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_operacion in ( select operacion from #operacion_cliente)

--3--
update cob_cartera..ca_transaccion 
set tr_ofi_oper = @w_oficina
where tr_operacion in ( select operacion from #operacion_cliente)

--4--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente in ( select tramite from #operacion_cliente)

--5--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_operacion in ( select operacion from #operacion_cliente)

--6--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_operacion in ( select operacion from #operacion_cliente)

--7--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_operacion in ( select operacion from #operacion_cliente)

go

/*
Grupo: 668
1687	DURAN GARCIA ANA
Oficial Operacion = 279	
Oficial Grupo     = 68-> jherrerame
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
                
select @w_codigo_oficial= 68,
       @w_login_oficial = 'jherrerame',
       @w_oficina       = 3348

truncate table #cliente_grupo
truncate table #operacion_cliente 

insert into #cliente_grupo (cod_cliente) values (1687)

insert into #operacion_cliente(cliente, operacion, tramite)
select op_cliente, op_operacion, op_tramite
from   cob_cartera..ca_operacion
where  op_cliente in (select cod_cliente from #cliente_grupo)
and    op_estado in  (select es_codigo from cob_cartera..ca_estado where es_procesa = 'S')

--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (select cod_cliente from #cliente_grupo)
                                                         
--2--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_operacion in ( select operacion from #operacion_cliente)

--3--
update cob_cartera..ca_transaccion 
set tr_ofi_oper = @w_oficina
where tr_operacion in ( select operacion from #operacion_cliente)

--4--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente in ( select tramite from #operacion_cliente)

--5--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_operacion in ( select operacion from #operacion_cliente)

--6--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_operacion in ( select operacion from #operacion_cliente)

--7--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_operacion in ( select operacion from #operacion_cliente)

go
/*
Grupo: 1592
16671	VENCES VALERIO NOEMI
Oficial Operacion = 214	
Oficial Grupo     = 195-> javilla
*/
use cobis 
go

declare @w_codigo_grupo    int,
        @w_login_oficial   varchar(14),
        @w_codigo_oficial  int,
        @w_oficina         int
                
select @w_codigo_oficial= 195,
       @w_login_oficial = 'javilla',
       @w_oficina       = 1481

truncate table #cliente_grupo
truncate table #operacion_cliente 

insert into #cliente_grupo (cod_cliente) values (16671)

insert into #operacion_cliente(cliente, operacion, tramite)
select op_cliente, op_operacion, op_tramite
from   cob_cartera..ca_operacion
where  op_cliente in (select cod_cliente from #cliente_grupo)
and    op_estado in  (select es_codigo from cob_cartera..ca_estado where es_procesa = 'S')

--1.--
UPDATE cobis..cl_ente 
SET en_oficial    = @w_codigo_oficial,
    c_funcionario = @w_login_oficial
WHERE en_ente  in (select cod_cliente from #cliente_grupo)
                                                         
--2--
UPDATE cob_cartera..ca_operacion 
SET op_oficial   = @w_codigo_oficial,
    op_oficina   = @w_oficina 
WHERE op_operacion in ( select operacion from #operacion_cliente)

--3--
update cob_cartera..ca_transaccion 
set tr_ofi_oper = @w_oficina
where tr_operacion in ( select operacion from #operacion_cliente)

--4--
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = @w_login_oficial,
    tr_usuario_apr= @w_login_oficial,
    tr_oficial    = @w_codigo_oficial,
    tr_oficina    = @w_oficina
WHERE tr_cliente in ( select tramite from #operacion_cliente)

--5--
update cob_cartera..ca_operacion_his 
set oph_oficial   = @w_codigo_oficial,
    oph_oficina   = @w_oficina
where oph_operacion in ( select operacion from #operacion_cliente)

--6--
update cob_cartera_his..ca_operacion
set   op_oficial = @w_codigo_oficial,
      op_oficina = @w_oficina
where op_operacion in ( select operacion from #operacion_cliente)

--7--
update cob_cartera_his..ca_operacion_his
set   oph_oficial = @w_codigo_oficial,
      oph_oficina = @w_oficina   
where oph_operacion in ( select operacion from #operacion_cliente)

go